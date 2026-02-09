function create(prefix) {
  return function (text) {
    return `<b>${prefix}:</b> ${text}`;
  };
}

function pre(prefix, text) {
  return `<b>${prefix}:</b> ${text}`;
}
