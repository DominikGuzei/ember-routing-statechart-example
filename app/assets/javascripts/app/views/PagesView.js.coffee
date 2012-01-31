
App = @App

App.views.PagesView = SC.View.extend {

  elementId: 'pages'

  currentPageBinding: 'App.mediators.pagesMediator.currentPage'
  currentPageView: null

  didInsertElement: ->
    @_makeCurrentPageView @get('currentPage').create()

  currentPageChanged: SC.observer (->
    @_makeCurrentPageView @get('currentPage').create()
  ), 'currentPage'

  _makeCurrentPageView: (pageView) ->
    @_removeCurrentPageView()
    @_addCurrentPageView pageView

  _removeCurrentPageView: ->
    currentPageView = @get 'currentPageView'
    if currentPageView?
      currentPageView.remove()

  _addCurrentPageView: (pageView) ->
    container = @get('element')
    if container
      pageView.appendTo container
      @set 'currentPageView', pageView

}