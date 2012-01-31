
App = SC.Application.create {

    ready: ->
      App.statechart.initStatechart();
      @_super()

}

# create namespaces
App.models = {}
App.views = {}
App.controllers = {}
App.mediators = {}
App.states = {}
App.templates = {}

# export App to global namespace
@App = App