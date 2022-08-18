import libs/webview/webview

var view = newWebview("#karasu", "http://localhost:5040", 365, 840, Fixed)
view.show()
#nim c viewer.nim && ./viewer   