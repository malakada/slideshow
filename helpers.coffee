getElementsByClassName = (searchClass, node, tag) ->
  unless node? then node = 'document'
  unless tag? then tag = '*'
  elems = document.getElementsByTagName(tag) # hardcoding in document for now
  pattern = new RegExp("(^|\\s)" + searchClass + "(\\s|$)")
  j = 0
  classElements = [] # for some reason coffeescript didn't do this for me?
  for elem in elems
    if pattern.test(elem.className)
      classElements[j] = elem
      j++
  return classElements
