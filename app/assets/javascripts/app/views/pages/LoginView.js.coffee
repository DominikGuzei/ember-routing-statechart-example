
#= require app/templates/pages/login

App = @App

App.views.pages.LoginView = SC.View.extend {

  templateName: 'app_templates_pages_login'
  elementId: 'login-page'

  mediatorBinding: 'App.mediators.authenticationMediator'

  login: ->
    userName = $('#login-username').val()
    password = $('#login-password').val()

    App.statechart.send 'loginFormSubmitted', userName, password

}