
App = @App

App.views.PagesView = SC.View.extend {

  elementId: 'pages'

  currentPageView: null

  currentPageChanged: SC.observer (->
    @_removeCurrentPageView()

    currentPage = App.mediators.pagesMediator.get('currentPage').create()
    currentPage.appendTo @get('element')

    @set 'currentPageView', currentPage

  ), 'App.mediators.pagesMediator.currentPage'

  _removeCurrentPageView: ->
    currentPageView = @get 'currentPageView'
    if currentPageView
      currentPageView.remove()

}

# provides namespace for pages
App.views.pages = {}