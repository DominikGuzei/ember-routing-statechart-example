
#= require app/utils/stateToString
#= require app/utils/statechartAsActionTarget
#= require app/controllers/statechartController
#= require app/states/BrowsingState
#= require app/states/AuthenticationState

App = this.App

App.statechart = SC.Statechart.create {

  statesAreConcurrent: YES
  trace: YES

  delegate: App.controllers.statechartController

  Browsing: App.states.BrowsingState
  Authentication: App.states.AuthenticationState
}