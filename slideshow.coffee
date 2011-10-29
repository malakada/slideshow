slideCount = 0 # index of array for <section class="slide">
speakerNotesShown = helpMenuShown = controlsShown = false
console.log 'about to look for slides'
slides = getElementsByClassName('slide', null, 'section')
notes = getElementsByClassName('note', null, 'aside')
help = getElementsByClassName('help', null, 'aside')
controls = getElementsByClassName('controls', null, 'aside')

load = ->
  console.log "window.location.hash: #{window.location.hash}"
  elems = getElementsByClassName("slide", null, "section")
  unless window.location.hash is ""
    i = 0
    while i < elems.length
      slideCount = i  if elems[i].id is window.location.hash.slice(1)
      i++
  i = 0
  while i < elems.length
    if i is slideCount
      elems[i].style.display = "inline"
      elems[i].style.opacity = 1
    else
      elems[i].style.display = "none"
      elems[i].style.opacity = 0.0
    i++

slideControl = (event) ->
  switch event.which
    when 110, 78
      speakerNotes()
    when 37
      previousSlide()
    when 39
      nextSlide()
    when 72
      helpMenu()
    when 67
      controlsMenu()
    else

nextSlide = ->
  elems = getElementsByClassName("slide", null, "section")
  elems[slideCount].style.display = "none"
  elems[slideCount].style.opacity = 0
  slideCount++  if slideCount < (elems.length - 1)
  window.history.pushState "string 1", "title", "/slideshow/index.htm#" + elems[slideCount].id
  elems[slideCount].style.display = "inline"
  elems[slideCount].style.opacity = 1
  elems[slideCount].style.position = "relative"
  elems[slideCount].style.left = "0px"

previousSlide = ->
  elems = getElementsByClassName("slide", null, "section")
  elems[slideCount].style.display = "none"
  elems[slideCount].style.opacity = 0
  slideCount--  if slideCount > 0
  window.history.pushState "string 1", "title", "/slideshow/index.htm#" + elems[slideCount].id
  elems[slideCount].style.display = "inline"
  elems[slideCount].style.opacity = 1
  elems[slideCount].style.position = "relative"
  elems[slideCount].style.left = "0px"



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

