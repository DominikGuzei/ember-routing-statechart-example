#= require app/mediators/authenticationMediator
#= require app/mediators/pagesMediator
#= require app/views/pages/ListNotesView
#= require app/views/pages/CreateNoteView

App = @App
pagesMediator = App.mediators.pagesMediator
pages = App.views.pages

App.states.BrowsingState = SC.State.extend {

  initialSubstate: 'Public'

  logout: ->
    @gotoState 'Browsing.Public.ListNotes'

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
  }

  Restricted: SC.State.extend {

    initialSubstate: 'CreateNote'

    beforeFilter: ->
      unless App.mediators.authenticationMediator.get('loggedIn')
        App.mediators.authenticationMediator.set('notice', 'You have no access to this page. Please login!')
        @get('statechart').sendAction('login')

        # don't trigger transition to substate
        return false

      # trigger transition to substate
      return true

    CreateNote: SC.State.extend {
      representRoute: 'notes/create'

      enterState: ->
        SC.routes.set('location', 'notes/create')
        pagesMediator.set 'currentPage', pages.CreateNoteView
    }
  }
}