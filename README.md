# Quick Notes - Ember.js Example Application

Quick Notes is a small example to showcase some of the capabilities of 
[sproutcore-statechart](https://github.com/emberjs-addons/sproutcore-statechart) and 
[sproutcore-routing](https://github.com/emberjs-addons/sproutcore-routing) in 
[Ember.js](https://github.com/emberjs/ember.js)

View online: [Quick Notes Application](http://ember-quicknotes.herokuapp.com/)

## Concepts Covered

* Ember.js application structure and clean separation of layers (MVC)
* Statechart with hierarchical and concurrent states
* Paging with public and restricted areas
* Authentication with async login overlay

## Statechart Specification

This image shows the rough specification of the application as UML state-diagram:

![Statechart Specification of Quick Notes](https://github.com/DominikGuzei/ember-routing-statechart-example/blob/master/spec/architecture/ember-app-statechart.png?raw=true)

## For Non-Rails Developers

You find the JavaScript application written in CoffeeScript in the app/assets/javascripts folder. 
If you wonder about the '#= require x/y/z' statements -> these are precompile 'include' statements
for Sprockets in Rails and are not included in the resulting JavaScript code base.

If you don't use rails, you should.

## Credits

* Thanks to Michael Cohen (aka. FrozenCanuck) for creating the super awesome sproutcore-statechart framework!
* Quick Notes was designed and built by [Dominik Guzei](http://wizzart.at/)
* Logo designed by [Double-J Design](http://www.doublejdesign.co.uk/)
