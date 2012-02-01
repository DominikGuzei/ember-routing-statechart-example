
#= require app/mediators/authenticationMediator

App = @App

authenticationMediator = App.mediators.authenticationMediator

App.states.AuthenticationState = SC.State.extend {

  initialSubstate: 'LoggedOut'

  LoggedOut: SC.State.extend {

    enterState: ->
      authenticationMediator.set 'loggedIn', NO
      authenticationMediator.set 'userName', null
      authenticationMediator.set 'password', null

    authenticate: (userName, password) ->
      if userName is 'user' and password is 'password'
        authenticationMediator.set 'userName', userName
        authenticationMediator.set 'password', password
        @gotoState 'Authentication.LoggedIn'
      else
        authenticationMediator.set 'error', 'username or password are wrong.'
  }

  LoggedIn: SC.State.extend {
    enterState: ->
      authenticationMediator.set 'loggedIn', YES

      context = App.controllers.statechartController.get 'lastRouteContext'
      if context then context.retry()

    logout: ->
      @gotoState 'Authentication.LoggedOut'
  }
}