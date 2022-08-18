var morph = require("nanomorph");
import html from 'nanohtml';

const ROOT_NODE = document.body.querySelector("#app");

var socket = new WebSocket("ws://" + window.location.hostname + ":5000/ws");

function renderer(newUI) {
    morph(ROOT_NODE, newUI, {
      onBeforeElUpdated: (fromEl, toEl) => !fromEl.isEqualNode(toEl),
    });
  }

  function sendHello() {
    socket.send(JSON.stringify({
      type: "UI",
      data: {
          count: 0
      }
    }));
  }
window.sendHello = sendHello
socket.onmessage = function (event) {
console.log(`🍂 ${event.data}`, data);
const data = JSON.parse(event.data)
  switch (data.type) {
    case "UI":
        renderer(data.ui)
      break;
    default:
      
      break;
  }
};
