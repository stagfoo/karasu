# "nim js --out:public/snake.js -d:local snake.nim"
import dom, jsconsole, sugar, std/asyncjs

# create type for global function (examples below)
#proc createElementNS*(d: Document, namespace: cstring, identifier: cstring): Element {.importcpp.}
#proc setAttributeNS*(n: Node, namespace: cstring, name, value: cstring) {.importcpp.}

# use javascript function
var svg = document.createElement("svg")
svg.style.setProperty("--rotationEnd", "{rotation}deg")
document.body.appendChild(svg)