#= require app/mediators/authenticationMediator
#= require app/mediators/pagesMediator
#= require app/views/pages/ListNotesView
#= require app/views/pages/CreateNoteView

App = @App
pagesMediator = App.mediators.pagesMediator
pages = App.views.pages

ROUTES = {
  listNotes: 'notes'
  createNote: 'notes/create'
}

App.states.BrowsingState = SC.State.extend {

  initialSubstate: 'Public'

  # implement navigation as actions
  listNotes: (->
    SC.routes.set 'location', ROUTES.listNotes
  ).handleActions 'logout', 'listNotesClicked'

  createNote: (->
    SC.routes.set 'location', ROUTES.createNote
  ).handleActions 'createNoteClicked'

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

      representRoute: ROUTES.listNotes

      enterState: ->
        SC.routes.set 'location', ROUTES.listNotes
        pagesMediator.set 'currentPage', pages.ListNotesView
        pagesMediator.set 'listNotesIsCurrent', YES

      exitState: ->
        pagesMediator.set 'listNotesIsCurrent', NO

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
      representRoute: ROUTES.createNote

      enterState: ->
        SC.routes.set 'location', ROUTES.createNote
        pagesMediator.set 'currentPage', pages.CreateNoteView
        pagesMediator.set 'createNoteIsCurrent', YES

      exitState: ->
        pagesMediator.set 'createNoteIsCurrent', NO
    }
  }
}