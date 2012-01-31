
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

# provides namespace for pages
App.views.pages = {}

# export App to global namespace
@App = App