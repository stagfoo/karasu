import libs/webview/webview

var view = newWebview("test", "http://localhost:5000")
view.show()
#nim c viewer.nim && ./viewer   