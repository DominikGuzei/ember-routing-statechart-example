
SC.Statechart.reopen {
  send: ->
    @sendAction.apply(this, arguments)
}