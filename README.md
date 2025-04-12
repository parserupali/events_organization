# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

    Software Used:
    •	Ruby: ruby 3.1.2p20
    •	Rails: Rails 7.1.5.1
    •	Redis: Installed via brew install redis
    •	PostgreSQL

Application Startup Steps and Commands:
1.	Start Redis:
      brew services start redis
2.	Install dependencies:
      bundle install
3.	Set up the database:
      rails db:create
      rails db:migrate
      rails db:seed
4.	Start Sidekiq:
      bundle exec sidekiq
5.	Start the Rails server:
      rails s
6.	Open Rails console
      rails c

API document is attached here -
https://links.getpostman.com/ls/click?upn=u001.F5oWY2bDM9VsP1yDsg8sV-2FFzG75a0TDhOImmQ4dmU-2BZsGDgzZn8gPli-2FvotPQiQ2aSxF0-2F-2Fd24M9xKGywxAlJFL4gyo-2FqyEAO6sKWoIQjH2yHayyWUPB3SOyKprNC-2BE2KxKE0TISRG-2BHmYpE8llJTYLFLzzeS-2FvPh8MuycDvlyaUP5YipVhVbOnxAsCqHktOaunjRsF9iFTkCfHnYlXEuQ5FZp9FFLNYI0Yiktdq3xM-3D7YoY_LDgqRvkPIWHZOhyqI7ajlGg4u4rTzY7wGQVqCB-2BT8Ap9Fc6mhW-2FxtXp-2BHqcEzUjqhCvnIxikNp6Rtm5UCdDW2293MN99-2Bdy6AoirRscjpPqsdeSq4-2Fqsti0y077w9LuYCfh6TWzgdFTPIbNlA4TVJTKkaHrHu9912NM1seNYPKd8uYPkDm2fA9sak3N87JQVBMk4h9jg5qcols7WtY9cfdx4DYNWaPJ8n487CYgo644kG8oPnB0KeHR-2Bjr92ebmJ-2Bnd19dK0iYsc7-2BAhfd1WMLGv28SJumC4cw3xmVAQ-2BPJV9Ne9YxPQt2zujIIaLKMTVvnshVVPAfe4Fmww3SvQjngr2ExnE1uX1MWXIpqqQcxkP7aup6vNppdWK08gRoT-2FjbweGEX2qazMWkV-2BfiFqSxT6nNtQbR8bi-2B1WD0-2Bksa6-2F54YYuHe6QO197K0gwCnS

Click on - View complete documentation
There we can see sample requests, by running on send we can check response but also adding here.
sample_request_response.txt
