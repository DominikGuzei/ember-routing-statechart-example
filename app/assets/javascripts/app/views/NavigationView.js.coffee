
#= require app/templates/navigation

App = @App

App.views.NavigationView = SC.View.extend {

  templateName: 'app_templates_navigation'
  elementId: 'nav-main'
  tagName: 'nav'

  loggedInBinding: 'App.mediators.authenticationMediator.loggedIn'

  listNotesIsCurrentBinding: 'App.mediators.pagesMediator.listNotesIsCurrent'
  createNoteIsCurrentBinding: 'App.mediators.pagesMediator.createNoteIsCurrent'

  listNotesClicked: ->
    App.statechart.send 'listNotesClicked'

  createNoteClicked: ->
    App.statechart.send 'createNoteClicked'

  logoutClicked: ->
    App.statechart.send 'logout'

  loginClicked: ->
    App.statechart.send 'login'

}