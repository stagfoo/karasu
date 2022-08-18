import jester

var settings = newSettings()
settings.staticDir = "./public"



const AFTER_CLICK = """
  <p>Foobar</p>
"""

const APP_PAGE = """
  <html>
    <head>
    <title>Hello</title>
    <script src="https://unpkg.com/htmx.org@1.6.0" ></script>
    </head>
    <body>
      <div id="app">
        <div id="parent-div">
          <p>Foo</p>
        </div>
        <button 
            hx-post="/clicked"
            hx-trigger="click"
            hx-target="#parent-div"
            hx-swap="innerHTML"
        >
            Click Me!
        </button>
      </div>
    </body>
  </html>
"""

routes:
  get "/":
    resp APP_PAGE
  post "/clicked":
    resp AFTER_CLICK