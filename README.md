# Lerni
Lerni is my personal hobby project to learn Ruby on Rails and to explore how to use Github efficiently for scrum. I started lerni with the intention to create a web based card learning app. While there may be no need for another app or service for this it serves me perfectly for my needs and actually there are a few potential users who might want to use it in my family :-) 

* To learn about the features that should be implemented, then follow the Link to the current development milestone. 
* If you like to learn about my expiriences with Ruby on Rails and Github, then read on in this document.

# Issues

* Current Development Milestone: https://github.com/patrickhaemmerle/lerni/milestone/1
* Upcoming Development Milestone: https://github.com/patrickhaemmerle/lerni/milestone/3
* Backlog: https://github.com/patrickhaemmerle/lerni/milestone/2

# My experience with Ruby on Rails 

## Convention over configuration
That's something I am already used to from Spring development. It makes it very fast and easy to set up the whole evironment for a new application. With just one command the whole environment is here including everything you need to start. While it's not recommended to run in production it's very convenient to have a SQLite Database from the first second one can start with.

## Generators
Generators are a really nice thing they do the repetitive tasks for you and let you start with the fun part very quickly. After the generating the app the very first thing which is showed in most of the tutorials is the scaffold generator. Wow! One command generates you a database table and a user interface to do all CRUD operations on it. But when it comes down to develop real world scenarios just having a scaffold generator for CRUD operations is probably in most cases not what you want. If you try to build a user interface from the users perspective chances are that scaffolding CRUD operations do not match the workflow you want the user to be guided through. Currently I have the opinion that the I get the best result by generating the active record model and an empty controller separately. From there I am stepping forward manually.

## My first generator
I just created my first generator and guess what: there is a generator to generate a generator. Nice, isn't it? I created a generator to create an empty use case (read on below for the use cases) and a test class. When developping new functionality the workflow often looks like this:

* Create a new file and copy paste the structure from some other file
* Rename and remove some stuff to get an empty stub to start with
* Do the same with the test class

With my brand-new use case generator all this stuff can be condensed to `rails g usecase user/signup_action`. To my surprise it was very straight forward to implement that generator, so it will pay off very quickly.

## Where should the business logic be?
One thing that concerned me was, that rails seemed to be opinionated to have the business logic in the controller. Coupling the business logic so close to UI related code makes me feel very uncomfortable. Imagine there is some User Interface to place an order. In the next step the pending orders are presented to an employee who has to act upon each of them and then approve it. So far everything is fine. Now you see the posibility to process a certain kind of order without human interaction in a backgroud job. The code to approve the order would probably be the same, no matter whether the employee is calling it via the user interface or the background job is calling it. Making the background job call the controller is obviously no option. No problem one may think, let's move the code to the model, probably there is a model called "Order" which seems to be the right place.

Having that logic in the model seems to be better because it enables us to develop our application DRY. But moving it to the model classes distributes the business logic across the model and I can imagine that model classes become large and it could become difficult to find a piece of code, especially if it affects two or three model classes (on which model would you expect such a method to be implemented?).

Coming from Java I am used to have a database layer which only contains model classes that map to the database structure. There is some xml file or annotations on the model classes defining the queries (e.g. SQL or something similar that maps to SQL). On top of it there is some kind of service layer or business layer (name it whathever you like) which defines the business logic. In terms of MVC we could say that the "M" is splitted in two parts and the "V" and "C" build on top of it.

While searching the internet for solutions others found, I came across this really nice blog post: http://webuild.envato.com/blog/a-case-for-use-cases/

First of all it made me clear that rails is not really opinionated about where the business logic should reside, it just does not say anything about this. Secondly it presents an idea that goes beyond of just building a "service layer" or "business layer". It actually provides the very interesting idea to map every use case directly to an artefact in this layer and you end up with something one could call a "use case layer". Speaking in the example above there could be a use case called "ApproveOrder" and if all use cases are held together in a use case folder of the project structure, this folder is the way to go if you are looking for code that actually "does".

As also mentioned in the blog post I think this radically improves documentation. When I imagine to work with such use cases in a scrum environment it comes to the following scenario: I start a user story by breaking it down to one or more use cases and evaluate which of use cases already exist and can be reused. Since each use case stands in a one to one relationship with a ruby class, it's very straight forward to keep documentation and implementation linked. I could also imagine to have the prosa description of a use case in the ruby class itself and extract it from there to generate documentation.

After reading this and trying it out, I decided to use this concept for this app. To keep command and query separation I will postfix my class names with Action and Query. An action does something and returns maximally an id or an object that it created or changed. A query is meant to find data and return it, if you ever encounter a class whose name ends with Query you can be confident that it only fetches data and has no side effects. There is nothing that technically enforces Query Objects not to have side effects, but as a convention it should be fine for now.

Find here [my use cases](app/usecases) for this app.

# Scrum with Github

...
