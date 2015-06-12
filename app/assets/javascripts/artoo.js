// Artoo is a smal library that handles the common things
// that I find myself doing often.
modulejs.define("artoo", function () {

  return {

    buttonIsDisabled: function (button) {
      return button.classList.contains("disabled");
    },

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
      button.classList.remove("disabled");
    },

    http: {
      post: function (url, data, callback, error) {
        var xhr = new XMLHttpRequest();

        xhr.addEventListener("load", callback);
        if (error) {
          xhr.addEventListener("error", error);
        }
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.send(data);

      },
      get: function (url, callback, error) {
        var xhr = new XMLHttpRequest();

        xhr.addEventListener("load", callback);
        if (error) {
          xhr.addEventListener("error", error);
        }
        xhr.open("GET", url, true);
        xhr.send();
      }
    }


  };
});
