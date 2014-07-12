(function(ctx) {

  function getEnumerablePropertyNames(target) {
    var result = [];
    for (var key in target) {
      result.push(key);
    }
    return result;
  }

  ctx.EventHandler = {
    create: function () {
      var subject = function() {
        subject.onNext.apply(subject, arguments);
      };

      getEnumerablePropertyNames(Rx.Subject.prototype).forEach(function (property) {
        subject[property] = Rx.Subject.prototype[property];
      });
      Rx.Subject.call(subject);

      return subject;
    }
  };

})(window);