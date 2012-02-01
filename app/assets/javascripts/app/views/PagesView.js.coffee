
App = @App

App.views.PagesView = SC.View.extend {

  elementId: 'pages'

  currentPageBinding: 'App.mediators.pagesMediator.currentPage'
  currentPageView: null

  didInsertElement: ->
    @_makeCurrentPageView @get('currentPage')

  currentPageChanged: SC.observer (->
    @_makeCurrentPageView @get('currentPage')
  ), 'currentPage'

  _makeCurrentPageView: (pageView) ->
    if pageView?
      @_removeCurrentPageView()
      @_addCurrentPageView pageView.create()

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