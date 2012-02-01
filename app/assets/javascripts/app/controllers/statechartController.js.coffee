
App = @App

App.controllers.statechartController = SC.Object.create(SC.StatechartDelegate, {

  lastRouteContext: null

  statechartShouldStateHandleTriggeredRoute: (statechart, state, context) ->

    lastCheckedState = state
    shouldTrigger = true

    while shouldTrigger and lastCheckedState?

      if lastCheckedState.beforeFilter
        shouldTrigger = lastCheckedState.beforeFilter()
        if not shouldTrigger
          @set 'lastRouteContext', context
          break

      lastCheckedState = lastCheckedState.get 'parentState'

    return shouldTrigger

})