func template_decrypt*(): string = 
  return """
    <!DOCTYPE html>
      <head>
      <title>Hello</title>
      <link rel="stylesheet" href="/reasonable-colors.css">
      <link rel="stylesheet" href="/main.css">
      <script src="/htmx.js" ></script>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
      <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@100;200;500&amp;display=swap" rel="stylesheet"> 
      </head>
      <body>
        <div id="app">
          <div class="nav grid-container">
            <a href="/" >encrypt</a
            ><a href="/decrypt" class="active" >decrypt</a
            ><a href="/keys" >keys</a>
          </div>
          <div class="page">
            <div class="grid-container grid-1-2-2-v">
              <div
                class="recipients-selector box thin filled grid-container grid-1-2-h"
              >
                <span class="title">for key:</span>
                <select class="">
                  <option>alex</option>
                  <option>alex</option>
                  <option>alex</option>
                  <option>alex</option>
                  <option>alex</option>
                  <option>alex</option>
                  <option>alex</option>
                </select>
              </div>
              <div class="box"></div>
              <div class="box"></div>
            </div>
          </div>
          <div class="notification hide"></div>
        </div>
      </body>
    </html>
"""