import consumer from "./consumer"

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to PlayerChannel!")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data.content)
    console.log(data.sent_by)

   	//('#players').append('<div class="message"> ' + data.content + '</div>')
    

    //location.reload(true)
    location.href="/home/index.html"
// 	$.ajax({
//   	url: '/home/index',
//   	data: { authenticity_token: $('[name="csrf-token"]')[0].content}
//	}); 
  }

});
