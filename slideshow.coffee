slideCount = 0 # index of array for <section class="slide">
speakerNotesShown = helpMenuShown = controlsShown = false
slides = getElementsByClass('slide', null, 'section')
notes = getElementsByClass('note', null, 'aside')
help = getElementsByClass('help', null, 'aside')
controls = getElementsByClass('controls', null, 'aside')

load = ->
  console.log window.location.hash
  unless window.location.hash?
    for slide in slides
      slideCount = _i if window.location.hash.slice(1) is slide.id
  for slide in slides
    if i is slideCount
      slide.style.display = 'inline'
      slide.style.opacity = 1
    else
      slide.style.display = 'none'
      slide.style.opacity = 0

slideControl = (event) ->
  switch String.fromCharCode(event.which).toLowerCase() or event.which
    when 'n'
      speakerNotes()
    when 37
      # left arrow
      changeSlide('previous')
    when 39
      # right arrow
      changeSlide('next')
    when 'h'
      helpMenu()
    when 'c'
      controlsMenu()
    else
      # do nothing

changeSlide = (direction) ->
  slides[slideCount].style.display = 'none'
  slides[slideCount].style.opacity = 0
  # make sure it doesn't go out of bounds
  if direction is 'next'
    slideCount++ if slideCount < slides.length -1
  if direction is 'previous'
    slideCount-- if slideCount > 0
  window.history.pushState('string 1', 'title', '/slideshow/index.htm#' + slides[slideCount].id)
  # need to make this into a css style instead of hard-coded specifying here
  slides[slideCount].style.display = 'inline'
  slides[slideCount].style.opacity = 1
  slides[slideCount].style.position = 'relative'
  slides[slideCount].style.left = '0px'

speakerNotes = ->
  hide(notes) if speakerNotesShown
  display(notes, 'inline') unless speakerNotesShown
  speakerNotesShown = !speakerNotesShown

helpMenu = ->
  hide(help) if helpMenuShown
  display(help) unless helpMenuShown
  helpMenuShown = !helpMenuShown

controlsMenu = ->
  hide(controls) if controlsShown
  display(controls) unless controlsShown
  controlsShown = !controlsShown

hide = (group) ->
  for thing in group
    thing.style.display = 'none'

display = (group, displayType) ->
  unless displayType?
    displayType = 'block'
  for thing in group
    thing.style.display = display

getElementsByClass = (searchClass, node, tag) ->
  if node == null
    node = document
  if tag == null
    tag = '*'
  elems = node.getElementsByTagName(tag)
  pattern = new RegExp("(^|\\s)" + searchClass + "(\\s|$)")
  j = 0
  for elem in elems
    if pattern.test(elem.className)
      classElements[j] = elem
      j++
  return classElements

