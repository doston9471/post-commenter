import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";
import debounce from "lodash.debounce";

export default class extends Controller {
  static targets = ["display"];

  initialize() {
    this.typingStopped = debounce(this.typingStopped, 1000);
  }

  connect() {
    this.subscription = consumer.subscriptions.create("TypingChannel", {
      received: (data) => {
        if (data.uid != this.userId) {
          this.displayTarget.innerHTML =
            data.action == "typing" ? `${data.user_email} is typing...` : "";
        }
      },
    });
  }

  typing(_event) {
    this.subscription.perform("typing");
  }

  typingStopped(_event) {
    this.subscription.perform("typing_stopped");
  }

  get userId() {
    return document.head.querySelector("meta[name=current-user-id]")?.content;
  }
}