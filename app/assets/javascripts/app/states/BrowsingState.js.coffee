#= require app/mediators/authenticationMediator
#= require app/mediators/pagesMediator
#= require app/views/pages/ListNotesView
#= require app/views/pages/CreateNoteView
#= require app/views/pages/LoginView

App = @App
pagesMediator = App.mediators.pagesMediator
pages = App.views.pages

App.states.BrowsingState = SC.State.extend {

  initialSubstate: 'Public'

  Public: SC.State.extend {

    initialSubstate: 'Index'

    Index: SC.State.extend {
      enterState: ->
        # wait until SC.routes has initialized before
        # deciding to redirect to default page
        SC.run.next =>
          if SC.routes.get('location') is ''
            @gotoState 'Browsing.Public.ListNotes'
    }

    ListNotes: SC.State.extend {

      representRoute: 'notes'

      enterState: ->
        SC.routes.set('location', 'notes')
        pagesMediator.set 'currentPage', pages.ListNotesView

    }

    Login: SC.State.extend {

      representRoute: 'user/login'

      enterState: ->
        # let SC.routes run first
        SC.run.next =>
          SC.routes.set('location', 'user/login')

        pagesMediator.set 'currentPage', pages.LoginView

      loginFormSubmitted: (userName, password) ->
        App.mediators.authenticationMediator.set('notice', '')
        App.mediators.authenticationMediator.set('error', '')
        @get('statechart').send('authenticate', userName, password)

    }
  }

  Restricted: SC.State.extend {

    initialSubstate: 'CreateNote'

    beforeFilter: ->
      unless App.mediators.authenticationMediator.get('loggedIn')
        App.mediators.authenticationMediator.set('notice', 'You have no access to this page. Please login!')
        @gotoState 'Browsing.Public.Login'

        # don't trigger transition to substate
        return false

      # trigger transition to substate
      return true

    logout: ->
      @gotoState 'Browsing.Public.ListNotes'

    CreateNote: SC.State.extend {
      representRoute: 'notes/create'

      enterState: ->
        SC.routes.set('location', 'notes/create')
        pagesMediator.set 'currentPage', pages.CreateNoteView
    }
  }
}