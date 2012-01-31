
#= require app/utils/stateToString
#= require app/utils/statechartAsActionTarget
#= require app/controllers/statechartController
#= require app/states/BrowsingState
#= require app/states/AuthenticationState
#= require app/views/AppView

App = @App

App.statechart = SC.Statechart.create {

  trace: YES

  delegate: App.controllers.statechartController

  rootState: SC.State.extend {

    substatesAreConcurrent: YES

    Browsing: App.states.BrowsingState
    Authentication: App.states.AuthenticationState

    enterState: ->
      App.views.appView = App.views.AppView.create()
      App.views.appView.append()
  }

}