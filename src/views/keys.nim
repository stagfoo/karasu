func template_keys*(): string = 
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
            <a href="/" >encrypt</a>
            <a href="/decrypt" class="">decrypt</a>
            <a href="/keys" class="active">keys</a>
          </div>
      <div class="page">
      <div class="grid-container">
        <div class="box recipients-list"><button class="bottom-list-button">+ add new key</button>
        <button class="box item key selected"><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        <button class="box item key "><span>alex</span><i class="pair">PP</i></button>
        </div>
      </div>
      <p>key info:</p>
      <div class="box borderless padding-0">
        <div class="input grid-container grid-1-3-h"><label>crypto</label><input type="text" name="name" value="alex" class="input-name"></div>
        <div class="input grid-container grid-1-3-h"><label>email</label><input type="text" name="email" value="example@stagfoo.com" class="input-email"></div>
        <div class="input grid-container grid-1-3-h"><label>added</label><input type="text" name="email" value="example@stagfoo.com" class="input-email"></div>
        <div class="input grid-container grid-1-3-h"><label>type</label><input type="text" name="email" value="example@stagfoo.com" class="input-email"></div>
        <div class="input grid-container grid-1-3-h"><label>name</label><input type="text" name="email" value="example@stagfoo.com" class="input-email"></div>
      </div>
            <div class="box ghost">
        <div class="grid-1-1-h">
          <button class="secondary">Delete x</button>
          <button class="primary">Copy []</button>
        </div>
      </div>
    </div>
      </body>
    </html>
"""

func template_key_create*(): string = 
  return """
    <!DOCTYPE html>
      <head>
      <title>Hello</title>
      <link rel="stylesheet" href="/reasonable-colors.css">
      <link rel="stylesheet" href="/main.css">
      <script src="/htmx.js" ></script>
      </head>
      <body>
        <div id="app">
          <div class="nav grid-container">
            <a href="/" >encrypt</a>
            <a href="/decrypt" class="">decrypt</a>
            <a href="/keys" class="active">keys</a>
          </div>
         </div>
      </body>
    </html>
"""