
#= require app/templates/pages

App = @App

App.views.PagesView = SC.View.extend {

  templateName: 'app_templates_pages'
  elementId: 'pages'

  currentPageBinding: 'App.mediators.pagesMediator.currentPage'

}

# provides namespace for pages
App.views.pages = {}