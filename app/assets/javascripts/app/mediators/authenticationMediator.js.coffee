
App = @App

App.mediators.authenticationMediator = SC.Object.create {

  userName: null
  password: null

  loggedIn: NO
  notice: null
  error: null

}