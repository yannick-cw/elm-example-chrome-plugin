import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";

const app = Elm.Main.init({
  node: document.getElementById("root")
});

const updateCookie = cookieName => {
  if (chrome && chrome.cookies) {
    chrome.cookies.get(
      { url: "https://www.test.de/", name: cookieName },
      function(cookie) {
        if (cookie) {
          app.ports.updateCookie.send(cookie.value);
        } else {
          app.ports.updateCookie.send(null);
        }
      }
    );
  } else {
    app.ports.updateCookie.send("dev_cookie");
  }
};

app.ports.askCookie.subscribe(updateCookie);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
