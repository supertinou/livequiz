$(document).on 'ready cocoon:after-insert', ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('[data-toggle="tooltip"]').tooltip()

