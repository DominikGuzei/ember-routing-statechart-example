#= require app/mediators/authenticationMediator
#= require app/mediators/pagesMediator
#= require app/views/PagesView
#= require app/views/pages/ListNotesView
#= require app/views/pages/CreateNoteView

App = @App
pagesMediator = App.mediators.pagesMediator
pages = App.views.pages

App.states.BrowsingState = SC.State.extend {

  initialSubstate: 'Public'

  Public: SC.State.extend {

    initialSubstate: 'ListNotes'

    ListNotes: SC.State.extend {

      representRoute: 'notes'

      enterState: ->
        pagesMediator.set 'currentPage', pages.ListNotesView

      createNote: ->
        @gotoState 'Browsing.Restricted.CreateNote'
    }
  }

  Restricted: SC.State.extend {

    initialSubstate: 'CreateNote'

    beforeFilter: (context) ->
      unless App.mediators.authenticationMediator.get('loggedIn')
        @get('statechart').send('login')
        return false

      return true

    CreateNote: SC.State.extend {
      representRoute: 'notes/create'

      enterState: ->
        pagesMediator.set 'currentPage', pages.CreateNoteView
    }

    logout: ->
      @gotoState 'Browsing.Public.ListNotes'
  }

}