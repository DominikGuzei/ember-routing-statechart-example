
#= require app/templates/navigation

App = @App

App.views.NavigationView = SC.View.extend {

  templateName: 'app_templates_navigation'
  elementId: 'navigation'

  loggedInBinding: 'App.mediators.authenticationMediator.loggedIn'

  logout: ->
    App.statechart.send 'logout'

}