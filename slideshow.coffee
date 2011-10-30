slideCount = 0 # index of array for <section class="slide">
speakerNotesShown = helpMenuShown = controlsShown = false
slides = document.getElementsByClassName('slide')
notes = document.getElementsByClassName('note')
help = document.getElementsByClassName('help')
controls = document.getElementsByClassName('controls')

load = ->
  unless window.location.hash.slice(1).length < 1 # for some reason using unless window.location.hash.slice(1)? ... didn't work
    for slide in slides # go through and see if the hash tag in the URL matches any of the ID's for the slides.  if not, keep the slideCount at 0
      if slide.id = window.location.hash.slice(1)
        slideCount = _i
  for slide in slides
    slide.style.display = 'none'
  slides[slideCount].style.display = 'inline'

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
  slides[slideCount].style.display = "none"
  slideCount++ if slideCount < (slides.length - 1)
  # window.history.pushState "string 1", "title", "/slideshow/index.htm#" + slides[slideCount].id
  slides[slideCount].style.display = "inline"

previousSlide = ->
  slides[slideCount].style.display = "none"
  slideCount--  if slideCount > 0
  # window.history.pushState "string 1", "title", "/slideshow/index.htm#" + elems[slideCount].id
  slides[slideCount].style.display = "inline"

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

