import consumer from "./consumer"

consumer.subscriptions.create("ApperanceChannel", {
  initialized(){
    this.update.bind(this)
  },

  connected() {
    // Called when the subscription is ready for use on the server
    this.install()
    this.update()
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    this.unistall()
  },

  rejected(){
    this.unistall()
  },

  update(){
    this.documentIsActive ? this.appear() : this.away()
  },

  appear(){
    this.perform("appear", {appearing_on: this.appearingOn})
  },

  away(){
    this.perform("away")
  },

  install(){
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("turbolinks:load", this.update)
    document.addEventListener("visibilitychange", this.update)
  },

  unistall(){
    window.removeEventListener("focus", this.update)
    window.removeEventListener("blur", this.update)
    window.removeEventListener("turbolinks:load", this.update)
    window.removeEventListener("visibilitychange", this.update)
  },

  get documentIsActive(){
    return document.visibilityState == visible && document.hasFocus()
  },

  get appearingOn(){
    const element = document.querySelector("[data-appering-on]")
    return element ? element.getAttribute("data-appering-on") : null
  },



  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  appear: function() {
    return this.perform('appear');
  },

  away: function() {
    return this.perform('away');
  }
});
