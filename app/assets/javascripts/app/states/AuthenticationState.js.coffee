
#= require app/mediators/authenticationMediator
#= require app/views/LoginOverlayView

App = @App

authenticationMediator = App.mediators.authenticationMediator

App.states.AuthenticationState = SC.State.extend {

  initialSubstate: 'LoggedOut'

  logout: ->
    @gotoState 'Authentication.LoggedOut'

  LoggedOut: SC.State.extend {

    enterState: ->
      authenticationMediator.set 'loggedIn', NO
      authenticationMediator.set 'userName', null
      authenticationMediator.set 'password', null

    login: ->
      @gotoState 'Authentication.Authenticate'
  }

  Authenticate: SC.State.extend {

    enterState: ->
      unless App.views.loginOverlayView
        App.views.loginOverlayView = App.views.LoginOverlayView.create()

      @performAsync =>
        App.views.loginOverlayView.show =>
        @resumeGotoState()

    exitState: ->
      # reset notifications
      App.mediators.authenticationMediator.set('notice', '')
      App.mediators.authenticationMediator.set('error', '')

      @performAsync =>
        App.views.loginOverlayView.hide =>
        @resumeGotoState()

    authenticate: ((action, userName, password) ->
      if userName is 'user' and password is 'password'
        authenticationMediator.set 'userName', userName
        authenticationMediator.set 'password', password
        @gotoState 'Authentication.LoggedIn'
      else
        authenticationMediator.set 'error', 'Username or password are wrong.'
    ).handleActions('authenticate', 'loginFormSubmitted')

    loginFormCancelled: ->
      @get('statechart').sendAction 'logout'

  }

  LoggedIn: SC.State.extend {
    enterState: ->
      authenticationMediator.set 'loggedIn', YES

      context = App.controllers.statechartController.get 'lastRouteContext'
      if context then context.retry()
  }
}