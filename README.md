Ruby Typechecker
===

A batch of tools and methods your can optionally use to type check your ruby methods.



---

### Goals

* Contain the entire type checking interface into one file (minitest FTW)
* Add an additional runtime check for CI/CD
* 0 impact to performace in production systems
* Seamless integration with rails
* Easily manage via rake tasks


---

### Constraints

* Cannot be called at all in production
* Must work with custom classes


---

### Tools

* Rakefile
* Tests
* Mixin
* Rubocop support

