// Artoo is a smal library that handles the common things
// that I find myself doing often.
modulejs.define("artoo", function () {

  return {

    changeButtonClass: function (button, activeClass) {
      button.classList.remove("success");
      button.classList.remove("secondary");
      button.classList.remove("alert");
      button.classList.remove("info");

      button.classList.add(activeClass);
    },

    changeButtonText: function (button, text) {
      button.innerHTML = text;
      button.blur();
    },

    disableButton: function (button) {
      button.classList.add("disabled");
    },

    enableButton: function (button) {
      button.classList.remove("disabled")
    },


  };
});
