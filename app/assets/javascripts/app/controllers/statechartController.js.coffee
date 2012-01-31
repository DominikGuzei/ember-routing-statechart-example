
App = this.App

App.controllers.statechartController = SC.Object.create(SC.StatechartDelegate, {

  lastRouteContext: null

  statechartShouldStateHandleTriggeredRoute: (statechart, state, context) ->
    @set 'lastRouteContext', context

    lastCheckedState = state
    shouldTrigger = true

    while shouldTrigger and lastCheckedState?

      if lastCheckedState.beforeFilter
        shouldTrigger = lastCheckedState.beforeFilter()
        if not shouldTrigger
          SC.routes.set 'location', null
          break

      lastCheckedState = lastCheckedState.get 'parentState'

    return shouldTrigger

})