// Artoo is a smal library that handles the common things
// that I find myself doing often.
modulejs.define("artoo", function () {

  return {

    changeButtonText: function (button, text) {
      button.innerHTML = text;
      button.blur();
    },

    disableButton: function (button) {
      button.classList.add("disabled");
    },

    enableButton: function (button) {
      button.classList.remove("disabled")
    }

  };
});
