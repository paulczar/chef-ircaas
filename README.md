Description
===========

This cookbook installs the IRC as a Service application

http://github.com/paulczar/ircaas

Requirements
==============

Chef 0.11.0 or higher required (for Chef environment use).

Cookbooks
----------------

The following cookbooks are dependencies:
* apt
* ruby
* git
* docker

Recipes
=======

ircaas::application
---------------------------

* creates user `ircaas`
* includes recipes `git::default`, `ruby::default`, `docker::default`, `application_ruby::default`
* Install supporting packages
* Install IRCaaS Application code from `https://github.com/paulczar/ircaas`

Attributes
==========
ircaas['user']  - user to run application as
ircaas['git']['repo']  - repo containing IRCaaS code
ircaas['git']['branch'] - Branch to download


Testing
=======

Strainer
--------

This cookbook uses [bundler](http://gembundler.com/), [berkshelf](http://berkshelf.com/), and [strainer](https://github.com/customink/strainer) to isolate dependencies and run tests.

Tests are defined in Strainerfile.

To run tests:

    $ bundle install # install gem dependencies
    $ bundle exec berks install # install cookbook dependencies
    $ bundle exec strainer test # run tests

License and Author
==================

|                      |                                                    |
|:---------------------|:---------------------------------------------------|
| **Author**           | Paul Czarkowski (<username.taken@gmail.com>)                           |
|                      |                                                    |
| **Copyright**        | Copyright (c) 2013, Paul Czarkowski                       |


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.