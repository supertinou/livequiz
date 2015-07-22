//     UnderscoreUtilities.js
//     (c) Martin Lagrange

// find the array index of an object with a specific key value

_.findIndex = _.detect = function(obj, predicate, context) {
  var result;
  _.any(obj, function(value, index, list) {
    if (predicate.call(context, value, index, list)) {
      result = index;
      return true;
    }
  });
  return result;
};