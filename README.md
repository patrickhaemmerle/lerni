# Lerni
Lerni is my personal fun project to learn Ruby on Rails and to learn about how to use Github effectively for project management. I started lerni with the intention to create a web based card learning app. While ther may be no need for another app or service for this it serves me perfectly for my needs. To learn about the features that should be implemented, then follow the Link to the current development milestone. To learn about my expiriences with Ruby on Rails and Github, then read on in this document.

Current Development Milestone: https://github.com/patrickhaemmerle/lerni/milestone/1

Backlog: https://github.com/patrickhaemmerle/lerni/milestone/2

# My experience with Ruby on Rails 

## Convention over configuration
That's something I am already used to from Spring development. It makes it very fast and easy to set up the whole evironment for a new application.

## Generators
Generators are a really nice thing they do the repetitive tasks for you and let you start with the fun part of programming faster. The very first thing you will get in touch, when you are new to Ruby on Rails is the scaffold generator. Wow! One command and you have a database table and a user interface to do all CRUD operations on it. But when it comes down to develop real world scenarios just having a scaffold generator for CRUD operations is probably in most cases not what you want. If you try to build a user interface from the users perspective chances are that scaffolding CRUD operations do not match the workflow you want the user to guide through. Currently I have the opinion that generating the active record model and an empty controller separately and then continue manually is probably the best way to do it. Maybe this changes with more expirience :-)

## Where should the business logic be?
One thing that concerned me was, that rails seems to be opinionated to have the business logic in the controller. Coupling the business logic so close to UI related code makes me feel very uncomfortable. Imagine there is some User Interface to place an order, it don't matter what kind of order. In the next step the pending orders are presented to an employe who has to act upon them and then approve it. So far everything is fine. Now you see the posibility to process a certain kind of order without human interaction in a backgroud job. The code to approve the order would probably be the same, no matter whether the employee is calling it via the user interface or the background job is calling it. Making the background job call the controller is obviously no option. No problem, let's move the job to the model, maybe there is a model called "Order" which seems to be the right place.

Having that logic in the model seems to be better becaus it enables us to develop our application DRY. But moving it to the model classes distributes the business logic across the model and I can imagine that it model classes become large and it could become difficult to find a piece of code, especially if it affects two or three model classes (on which model would you expect such a method to be implemented?).

Coming from Java I am used to have a database layer which only contains model classes which map to the database structure and query definitions, which either are SQL Queries or map to SQL Queries (for example JPQL). On top of it there is some kind of service layer or business layer (name it whathever you like) which defines the business logic. In terms of MVC we could say that the "M" is splitted in two parts and the "V" and "C" build on top of it.

While searching the internet for solutions others found I came across this really nice blog post: http://webuild.envato.com/blog/a-case-for-use-cases/

First of all it makes clear that rails is not really opinionated about where the business logic should reside, it just does not say anything about this. And secondly it presents an idea that goes beyond of just building a "service layer" or "business layer". It actually provides the very interesting idea to map every use case directly to an artefact in this layer and you end up with something one could call a "use case layer". Speaking in the example above there could be a use case called "ApproveOrder" and if all use cases are held together in a use case folder of the project structure, this folder is the way to go if you are looking for code that actually "does".

As also mentioned in the blog post I think this radically improves documentation. I have not tried it but hiere is how I imagine to work with such use cases in a scrum environment. I start a user story by breaking it down to one or more use cases and evaluate which use cases can be reused. Since each use case stands in a one to one relationship with a ruby class, it's very straight forward to keep documentation and implementation linked. I could also imagine to have the prosa description of a use case in the ruby class itself and extract it from there to generate documentation.

In order to keep command and query separation I will postfix my classes with Action and Query. An action does something and returns maximally an id or an object that it created or changed. A query is meant to find data and return it, if you ever encounter a class whose name ends with Query it's guaranteed that it has no side effects.

# Project management with Github

...
