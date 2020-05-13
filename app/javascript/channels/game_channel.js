import consumer from "./consumer"

consumer.subscriptions.create("GameChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the game!")
    //debugger;
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    if (data.content==="reload"){
      location.href="/home/play.html"
    }
    // Called when there's incoming data on the websocket for this channel
    //console.log("Recieving:")
    //window.alert("Recieving:")
    //console.log(data.content)
    //$('#msg').append('<div class="message"> ' + data.content + '</div>')
    //debugger;
  }
});
