const express = require("express");
const axios = require("axios");
const querystring = require("querystring");
const fs = require("fs");
const { GwmClient } = require("glazewm");

const app = express();
const PORT = 3000;

const client = new GwmClient();
client.onConnect(() => console.log('Connected!'));

let accessToken = "";
let refreshToken = "";
var client_id = ""; // Your Spotify client ID
var client_secret = ""; // Your Spotify Client Secret
var redirect_uri = `http://localhost:${PORT}/callback`;

app.get("/", (req, res) => {
  res.send("Use /login to authenticate with Spotify.");
});

app.get("/login", function (req, res) {
  var state = "asd";
  var scope = "user-read-currently-playing";

  res.redirect(
    "https://accounts.spotify.com/authorize?" +
    querystring.stringify({
      response_type: "code",
      client_id: client_id,
      scope: scope,
      redirect_uri: redirect_uri,
      state: state,
    })
  );
});

app.get("/callback", function (req, res) {
  var code = req.query.code || null;
  var state = req.query.state || null;

  if (state === null) {
    res.redirect(
      "/#" +
      querystring.stringify({
        error: "state_mismatch",
      })
    );
  } else {
    var authOptions = {
      url: "https://accounts.spotify.com/api/token",
      form: {
        code: code,
        redirect_uri: redirect_uri,
        grant_type: "authorization_code",
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization:
          "Basic " +
          Buffer.from(client_id + ":" + client_secret).toString(
            "base64"
          ),
      },
      json: true,
    };
    axios
      .post(authOptions.url, querystring.stringify(authOptions.form), {
        headers: authOptions.headers,
      })
      .then((response) => {
        accessToken = response.data.access_token;
        refreshToken = response.data.refresh_token;
        res.send(
          "Authentication successful! You can now use the access token: " +
          accessToken
        );
      })
      .catch((error) => {
        console.error("Error getting access token:", error.message);
        res.status(500).send("Error getting access token");
      });
  }
});


function refreshAccessToken() {
  const authOptions = {
    url: "https://accounts.spotify.com/api/token",
    method: "post",
    params: {
      grant_type: "refresh_token",
      refresh_token: refreshToken,
    },
    headers: {
      Authorization:
        "Basic " +
        Buffer.from(client_id + ":" + client_secret).toString("base64"),
    },
  };

  axios(authOptions)
    .then((response) => {
      accessToken = response.data.access_token;
    })
    .catch((error) => {
      console.error("Error refreshing access token:", error.message);
    });
}

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}\n`);
  console.log(`Login in at: http://localhost:${PORT}/login\n`);
});

let lastTrackTitle = '';
let isPlaying = false;

setInterval(() => {
  // Spotify API request to get the currently playing track
  axios
    .get("https://api.spotify.com/v1/me/player/currently-playing", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    })
    .then((response) => {
      if (response.data.is_playing) {
        const albumImageURL = response.data.item.album.images[0].url;
        const currentTrackTitle = response.data.item.name;

        // Check if the current track title is different from the previous one
        if (currentTrackTitle !== lastTrackTitle || !isPlaying) {
          const artistName = response.data.item.artists[0].name;
          const trackInfo = `${truncateString(currentTrackTitle, 20)} - ${truncateString(artistName, 20)}`;

          const imagePath = `spotify/assets/${currentTrackTitle}.png`;

          // Check if the album image already exists
          if (!fs.existsSync(imagePath)) {
            axios({
              method: "get",
              url: albumImageURL,
              responseType: "stream",
            })
              .then((response) => {
                response.data.pipe(fs.createWriteStream(imagePath));
              })
              .catch((error) => {
                console.error("Error downloading album image:", error.message);
              });
          }

          // Write artist and title to file for glazewm to read
          fs.writeFile(
            "spotify/output.txt",
            trackInfo,
            { flag: "w" },
            (err) => {
              if (err) {
                console.error("Error writing to file:", err.message);
              } else {
                return;
              }
            }
          );

          lastTrackTitle = currentTrackTitle;
          isPlaying = true;

          // glazewm config file
          const configPath = "../config.yaml";

          try {
            const existingConfig = fs.readFileSync(configPath, "utf8");

            // modifying the source line in the config file to display the album image (modify both paths to match yours)
            const newConfigLine = `source: 'C:/Users/davidoboy/.glaze-wm/components/spotify/assets/${currentTrackTitle}.png'`;
            const updatedConfig = existingConfig.replace(
              /source: 'C:\/Users\/davidoboy\/.glaze-wm\/components\/spotify\/assets\/.*\.png'/,
              newConfigLine
            );

            // Reloading glazewm config to update the album image
            fs.writeFileSync(configPath, updatedConfig, "utf8");
            client.runCommand('reload config');
          } catch (error) {
            console.error("Error reading or updating the configuration file:", error.message);
          }
        }
      }else {
        // Track is not playing
        refreshAccessToken();
      }
    })
    .catch((error) => {
      // console.error("Error fetching currently playing track:", error.message);
    });
}, 1000);

function truncateString(title, maxLength) {
	return title.length <= maxLength
		? title
		: `${title.slice(0, maxLength - 3)}...`;
}