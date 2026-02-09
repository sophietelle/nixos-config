function sliceAndDot(str, to) {
  return str.slice(0, to).trim() + (str.length > to ? "..." : "");
}
