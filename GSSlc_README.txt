======================================
SLC Resources
======================================

** SLC Developer site (docs, details on camp, forums, etc...)
http://dev.slcedu.org/

** Main SLC Portal (administer or use apps)
https://portal.sandbox.slcedu.org/portal

======================================
Project Setup
======================================

** One time setup
1) git clone git@githost.greatschools.org:GSSlc
2) cd GSSlc
3) bundle install
4) rake db:create
5) rake db:migrate

** If you have 64 bit MySQL on Windows you need to:
1) Go here http://dev.mysql.com/downloads/connector/c/
2) Download the file named (mysql-connector-c-noinstall-6.0.2-win32.zip).  Or latest version of
  the noinstall zip file.
3) Extract anywhere
4) Copy lib/libmysql.dll into your ruby bin folder (e.g. C:\Ruby193\bin)

** To run rails server and app
1) rails server -b 127.0.0.1 -p 3000 -e development
1.1) Or just "rails server" since those are the defaults
1.2) Or use IDEA to run the project in development environment
2) To access app, either visit http://localhost:3000 or log in to https://portal.sandbox.slcedu.org/portal
  as a sandbox user and click on the app there.

** To import rails project into IDEA
1) Ensure that you have the "Ruby" plugin for IDEA.  This is not bundled so you have to use
  the browse repositories button to find it.  While you're at it install the "HAML", "CoffeeScript"
  and maybe "Railways" plugins.
2) Create new project
3) Select "Ruby module" as type on the left (If you don't see that, cancel and return to step 1)
4) Select path of the rails checkout
5) Configure (or select) a Ruby SDK.
6) Check both Ruby on Rails and SQL Support.  For Rails I set it to "Use Existing Rails application" where it
  defaulted to Rails 3.2.9 with jQuery and preconfigured for mysql.  Nothing else was checked or filled in.
  For SQL Support I left it at "Project Default (keywords only)"
7) Click "Finish"
