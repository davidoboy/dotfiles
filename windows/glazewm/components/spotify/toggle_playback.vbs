Set objShell = CreateObject("WScript.Shell")
objShell.Run "cmd /c node %UserProfile%\.glaze-wm\components\spotify\js\playback.js", 0, True
