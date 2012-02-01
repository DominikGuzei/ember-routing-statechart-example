
#= require app/templates/login_overlay

App = @App

App.views.LoginOverlayView = SC.View.extend {

  templateName: 'app_templates_login_overlay'
  elementId: 'login-overlay'

  mediatorBinding: 'App.mediators.authenticationMediator'

  didInsertElement: ->
    @_showAsOverlay()

  login: ->
    userName = $('#login-username').val()
    password = $('#login-password').val()

    App.statechart.send 'loginFormSubmitted', userName, password

  show: (@showCallback) ->
    @append()

  hide: (@hideCallback) ->
    # when the dialog has been cancelled it
    # doesn't need to be closed again
    if @$().overlay().close
      @$().overlay().close()
    else
      @hideCallback()

  # show the login dialog as jQuery Tools Overlay
  # to focus the user on the task
  _showAsOverlay: ->
    @$().overlay {
        top: 260

        mask: {
          color: '#ccc'
          opacity: 0.6
        }

        load: true

        onLoad: =>
          @showCallback()

        onClose: => @_overlayClosed()
    }

  _overlayClosed: ->
    @remove()

    # When the user closes the dialog without
    # logging in tell the statechart
    if @hideCallback
      @hideCallback()
    else
      App.statechart.send 'loginFormCancelled'

    @hideCallback = null


}