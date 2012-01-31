
#= require app/mediators/authenticationMediator

App = @App

App.states.AuthenticationState = SC.State.extend {

  initialSubstate: 'Login',

  Login: SC.State.extend {

    initialSubstate: 'LoggedOut'

    LoggedOut: SC.State.extend {

      enterState: ->
        App.mediators.authenticationMediator.set 'loggedIn', NO
        App.mediators.authenticationMediator.set 'userName', null
        App.mediators.authenticationMediator.set 'password', null

      login: ->
        @gotoState 'Authentication.Login.Authenticate'
    }

    LoggedIn: SC.State.extend {
      enterState: ->
        App.mediators.authenticationMediator.set 'loggedIn', YES

        context = App.controllers.statechartController.get 'lastRouteContext'
        if context then context.retry()

      logout: ->
        @gotoState 'Authentication.Login.LoggedOut'
    }

    Authenticate: SC.State.extend {
      enterState: ->
        App.mediators.authenticationMediator.set 'userName', 'DominikGuzei'
        App.mediators.authenticationMediator.set 'password', 'xyz'

        @gotoState 'Authentication.Login.LoggedIn'
    }
  }

  Registration: SC.State.extend {

    initialSubstate: 'Intern'

    Intern: SC.State.extend {

    }

    Facebook: SC.State.extend {

    }
  }

}