######################################################
# nim-webview
# New-style Zaitsev's webview wrapper
# for Nim
#
# (c) 2022 Yanis Zafirópulos
# 
# @license: see LICENSE file
# @file: nim-webview.nim
######################################################

#=======================================
# Libraries
#=======================================

import os

#=======================================
# Compilation & Linking
#=======================================

{.passC: "-I" & parentDir(currentSourcePath()) .}

when defined(linux):
    {.compile("webview.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_GTK=1 " &
             staticExec"pkg-config --cflags gtk+-3.0 webkit2gtk-4.0".}
    {.passL: "-lstdc++ " &
             staticExec"pkg-config --libs gtk+-3.0 webkit2gtk-4.0".}
elif defined(freebsd):
    {.compile("webview.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_GTK=1 " &
             staticExec"pkg-config --cflags gtk3 webkit2-gtk3".}
    {.passL: "-lstdc++ " &
             staticExec"pkg-config --libs gtk3 webkit2-gtk3".}
elif defined(macosx):
    {.compile("webview.cc","-std=c++11").}
    {.passC: "-DWEBVIEW_COCOA=1".}
    {.passL: "-lstdc++ -framework WebKit".}
elif defined(windows):
    when not defined(WEBVIEW_NOEDGE):
        {.compile("webview.cc","/std:c++17 /EHsc").}
        {.passC: "-DWEBVIEW_EDGE=1".}
        {.passL: """/EHsc /std:c++17 "deps\libs\x64\WebView2LoaderStatic.lib" version.lib shell32.lib""".}
    else:
        {.passC: "-DWEBVIEW_STATIC=1 -DWEBVIEW_IMPLEMENTATION=1 -DWEBVIEW_WINAPI=1".}
        {.passL: "-lole32 -lcomctl32 -loleaut32 -luuid -lgdi32".}

when defined(windows) and defined(WEBVIEW_NOEDGE):
    {.push header: "webview_win_old.h", cdecl.}
else:
    {.push header: "webview.h", cdecl.}

#=======================================
# Types
#=======================================

type
    Constraints* = enum
        Default = 0
        Minimum = 1
        Maximum = 2
        Fixed = 3

when not defined(WEBVIEW_NOEDGE):
    type
        Webview* {.importc: "webview_t".} = pointer
        WebviewDispatch* = proc (w: Webview, arg: pointer) {.cdecl.}
        WebviewCallback* = proc (seq: cstring, req: cstring, arg: pointer) {.cdecl.}
else:
    type
        WebviewPrivObj  {.importc: "struct webview_priv", bycopy.} = object
        WebviewObj*     {.importc: "struct webview", bycopy.} = object
            url*        {.importc: "url".}: cstring
            title*      {.importc: "title".}: cstring
            width*      {.importc: "width".}: cint
            height*     {.importc: "height".}: cint
            resizable*  {.importc: "resizable".}: cint
            debug*      {.importc: "debug".}: cint
            invokeCb    {.importc: "external_invoke_cb".}: pointer
            priv        {.importc: "priv".}: WebviewPrivObj
            userdata    {.importc: "userdata".}: pointer
        Webview* = ptr WebviewObj

#=======================================
# Function prototypes
#=======================================

when not defined(WEBVIEW_NOEDGE):
    proc webview_create*(debug: cint = 0, window: pointer = nil): Webview {.importc.}
        ## Creates a new webview instance. If debug is non-zero - developer tools will
        ## be enabled (if the platform supports them). Window parameter can be a
        ## pointer to the native window handle. If it's non-null - then child WebView
        ## is embedded into the given parent window. Otherwise a new window is created.
        ## Depending on the platform, a GtkWindow, NSWindow or HWND pointer can be
        ## passed here.
    
    proc webview_destroy*(w: Webview) {.importc.}
        ## Destroys a webview and closes the native window.
    
    proc webview_run*(w: Webview) {.importc.}
        ## Runs the main loop until it's terminated. After this function exits - you
        ## must destroy the webview.
    
    proc webview_terminate*(w: Webview) {.importc.}
        ## Stops the main loop. It is safe to call this function from another other
        ## background thread.

    proc webview_dispatch(w: Webview, fn: WebviewDispatch, arg: pointer) {.importc.}
        ## Posts a function to be executed on the main thread. You normally do not need
        ## to call this function, unless you want to tweak the native window.
    
    proc webview_get_window*(w: Webview): pointer {.importc.}
        ## Returns a native window handle pointer. When using GTK backend the pointer
        ## is GtkWindow pointer, when using Cocoa backend the pointer is NSWindow
        ## pointer, when using Win32 backend the pointer is HWND pointer.
    
    proc webview_set_title*(w: Webview, title: cstring) {.importc.}
        ## Updates the title of the native window. Must be called from the UI thread.
    
    proc webview_set_size*(w: Webview, width: cint, height: cint, constraints: Constraints) {.importc.}
        ## Updates native window size. See WEBVIEW_HINT constants.

    proc webview_navigate*(w: Webview, url: cstring) {.importc.}
        ## Navigates webview to the given URL. URL may be a data URI, i.e.
        ## "data:text/html,<html>...</html>". It is often ok not to url-encode it
        ## properly, webview will re-encode it for you.
    
    proc webview_init*(w: Webview, js: cstring) {.importc.}
        ## Injects JavaScript code at the initialization of the new page. Every time
        ## the webview will open a the new page - this initialization code will be
        ## executed. It is guaranteed that code is executed before window.onload.
    
    proc webview_eval*(w: Webview, js: cstring) {.importc.}
        ## Evaluates arbitrary JavaScript code. Evaluation happens asynchronously, also
        ## the result of the expression is ignored. Use RPC bindings if you want to
        ## receive notifications about the results of the evaluation.

    proc webview_bind*(w: Webview, name: cstring, cb: WebviewCallback, arg: pointer) {.importc.}
        ## Binds a native C callback so that it will appear under the given name as a
        ## global JavaScript function. Internally it uses webview_init(). Callback
        ## receives a request string and a user-provided argument pointer. Request
        ## string is a JSON array of all the arguments passed to the JavaScript
        ## function.
    
    proc webview_return*(w: Webview; seq: cstring; status: cint; result: cstring)
        ## Allows to return a value from the native binding. Original request pointer
        ## must be provided to help internal RPC engine match requests with responses.
        ## If status is zero - result is expected to be a valid JSON result value.
        ## If status is not zero - result is an error JSON object.
else:
    proc webview_init*(w: Webview): cint {.importc.}
    proc webview_loop*(w: Webview; blocking: cint): cint {.importc.}
    proc webview_eval*(w: Webview; js: cstring): cint {.importc.}
    proc webview_inject_css*(w: Webview; css: cstring): cint {.importc.}
    proc webview_set_title*(w: Webview; title: cstring) {.importc.}
    proc webview_set_color*(w: Webview; r,g,b,a: uint8) {.importc.}
    proc webview_set_fullscreen*(w: Webview; fullscreen: cint) {.importc.}
    #proc webview_dialog*(w: Webview; dlgtype: DialogType; flags: cint; title: cstring; arg: cstring; result: cstring; resultsz: csize_t) {.importc.}
    #proc dispatch(w: Webview; fn: pointer; arg: pointer) {.importc: "webview_dispatch", header: "webview.h".}
    proc webview_terminate*(w: Webview) {.importc.}
    proc webview_exit*(w: Webview) {.importc.}
    proc webview_debug*(format: cstring) {.importc.}
    proc webview_print_log*(s: cstring) {.importc.}
    proc webview*(title: cstring; url: cstring; w: cint; h: cint; resizable: cint): cint {.importc.}

{.pop.}

#=======================================
# Wrappers
#=======================================

when not defined(WEBVIEW_NOEDGE):
    proc setSize*(this: Webview, width: int, height: int, constraints: Constraints) =
        webview_set_size(this, width=width.cint, height=height.cint, constraints)

    proc navigateTo*(this: Webview, url: string) =
        webview_navigate(this, url.cstring)

    proc run*(this: Webview) =
        webview_run(this)

    proc inject*(this: Webview, js: string) =
        webview_init(this, js.cstring)

    proc eval*(this: Webview, js: string) =
        webview_eval(this, js.cstring)

    proc terminate*(this: Webview) =
        webview_terminate(this)

proc destroy*(this: Webview) =
    when not defined(WEBVIEW_NOEDGE):
        webview_destroy(this)
    else:
        webview_exit(this)

#=======================================
# Methods
#=======================================

proc newWebview*(title: string, url: string = "", width: int = 640, height: int = 480, constraints = Default, debug=false): Webview =
    when not defined(WEBVIEW_NOEDGE):
        result = webview_create(debug.cint)
        webview_set_title(result, title=title.cstring)
        webview_set_size(result, width.cint, height.cint, constraints)
        if url != @"":
            webview_navigate(result, url.cstring)
    else:
        result = cast[Webview](alloc0(sizeof(WebviewObj)))
        result.title = title.cstring
        result.url = url.cstring
        result.width = width.cint
        result.height = height.cint
        result.resizable = if constraints==Default: 1 else: 0
        result.invokeCb = nil
        result.debug = debug.cint

        if webview_init(result) != 0: 
            return nil

proc show*(this: Webview) =
    when not defined(WEBVIEW_NOEDGE):
        this.run()
        this.destroy()
    else:
        while webview_loop(this, 1) == 0:
            discard
        this.destroy()

proc changeTitle*(this: Webview, title: string) =
    webview_set_title(this, title=title.cstring)

proc execute*(this: Webview, js: string) =
    when not defined(WEBVIEW_NOEDGE):
        webview_eval(this, js.cstring)
    else:
        discard webview_eval(this, js.cstring)