<h1 align="center">I ZoomBies</h1>
<p align="center">🧟
Rest API that stores survivors of a zombie apocalypse and allows
to find the survivor closest to your location.🧟</p>

<div align='center' id="technologies">
  <img src="https://img.shields.io/static/v1?label=Framework&message=Ruby-on-rails&color=7159c1&style=for-the-badge&logo=Ruby"/>
  <img src="https://img.shields.io/static/v1?label=Database&message=Postgresql&color=7159c1&style=for-the-badge&logo=PostgreSQL"/>
  <img src="https://img.shields.io/static/v1?label=Development&message=Docker&color=7159c1&style=for-the-badge&logo=Docker"/>
</div>

Table of Contents
=================
<!--ts-->
   * [Postman Documentation](https://documenter.getpostman.com/view/17627865/UUxwCUMk)
   * [Dependencies](#dependencies)
      * [Local Dependencies](#local-dependencies)
      * [Docker Dependencies](#docker-dependencies)
   * [Technologies](#technologies)
   * [Project Setup](#como-usar)
      * [Local version (Safely)](#local-version)
      * [Docker version (Fastly)](#docker-version)
   * [Starting server](#starting-server)
   * [Starting sidekiq (Only the local version needs)](#starting-sidekiq)
   * [Tests](#run-tests)
   * [List of tasks you find in this repository](#features)
   * [About the simple worker](#simple-worker)
<!--te-->

<h2 align="left">Postman Documentation</h2>

 - Documentantion of endpoints available on Postman, <a href="https://documenter.getpostman.com/view/17627865/UUxwCUMk">CLICK HERE</a> to access them.


<h2 id="dependencies" align="left">dependencies</h2>

<h3 id="local-dependencies" align="left">Local dependencies</h3>

 - Ruby v3.0.1
     - If you don't have Ruby installed on your machine, I recommend using [RVM](https://rvm.io/) to install it.
 - Rails, '~> 6.1.4', '>= 6.1.4.1'
 - Postgres >= 12
 - Git

<h3 id="docker-dependencies" align="left">Docker dependencies</h3>

 - Docker >= 20.10.7
     - If you don't have Docker installed on your machine, I recommend to install [Docker Compose](https://phoenixnap.com/kb/install-docker-compose-on-ubuntu-20-04), to install both at the same time.
 - Docker Compose >= 1.29.2

**Download**

Access the location of your projects through the terminal and download the repository (ssh-version)
```bash
$ git clone git@github.com:PedroPaiao/i-zoombies.git
```

<h1 id="project-setup">Project Setup</h1>

<h3 id="local-version">Local version</h3>

**Gemset setup (If you are using rvm)**

Inside the project folder, create the files `.ruby-version` and `.ruby-gemset` then enter the folder again to load the new settings.
```bash
$ echo "ruby-3.0.1" > .ruby-version && echo "i-zoombies-api" > .ruby-gemset
$ cd .
```

**Install gem dependencies**

The tool `bundle` will install all the gems that were defined in the project's Gemset.
```bash
$ gem install bundler:2.2.22
$ bundle install
```

**Database configuration**

First copy the file from `database.sample.yml` to `database.yml`
```bash
$ cp config/database.sample.yml config/database.yml
```

Now, configure your database authentication.
```
Change variables `<'YOUR_USERNAME_HERE'>`,`<'YOUR_PASSWORD_HERE'>` for your own values.
And `<'YOUR_HOST_HERE'>` to localhost.
```


Good! Now let's run the tasks you configured, and they will create and populate our database instance.
```bash
$  rails db:create db:migrate db:seed
```

<h3 id="docker-version">Docker version</h3>

[Docker Installation Manual](https://docs.docker.com/compose/install/)

**Build image**

Inside the project folder, run the build command for docker-compose.
```bash
$ docker-compose build
```

**Database configuration**

First copy the file from `database.sample.yml` to `database.yml`
```bash
$ cp config/database.sample.yml config/database.yml
```

Now, configure your database authentication.
```
Change variables `<'DOCKER_PG_USERNAME'>`,`<'DOCKER_PG_USERNAME'>` for your own values.
And `<'YOUR_HOST_HERE'>` to pg.
```

##### obsn: If you not changed anything on docker-compose.yml, the values are `username: postgres`, `password: postgres`

Good! Now let's run the tasks you configured, and they will create and populate our database instance.
```bash
$  docker-compose run izoombies rails db:create db:migrate db:seed
```

<h3 id="starting-server">Starting server</h3>

```bash
$ rails s
```
Or if you are using docker
```bash
$ docker-compose up
```

<h4 align="center">
	<a href="https://www.ruby-lang.org" emoji-code="Ruby"><img class="emojidex-emoji" src="https://cdn.emojidex.com/emoji/px16/Ruby.png" emoji-code="Ruby" alt="Ruby" /></a> Yay! You’re on Rails!  <a href="https://www.ruby-lang.org" emoji-code="Ruby"><img class="emojidex-emoji" src="https://cdn.emojidex.com/emoji/px16/Ruby.png" emoji-code="Ruby" alt="Ruby" /></a>
</h4>

<h3 id="starting-sidekiq"> Starting sidekiq </h3>

```bash
$ sidekiq -q default
```

###### Note: If you are using docker, is already started

<h3 id="run-tests">Automated Tests</h3>

I used the Rspec framework for testing implementation.

```bash
$ rspec
```
Or if you are using docker
```bash
$ docker-compose run izoombies rspec
```

<h3 id="features">List of tasks you find in this repository</h3>

- [x] Adding CI tests with rspec
- [x] Adding internacionalization(i18n) (incomplete, only in english for now)
- [x] CRUD of survivors
- [x] Update of location(longitude, latitude) 
- [x] Create report to an survivor
- [x] Consultation of my complaints (reports)
- [x] Consultation of complaints to me (reports)
- [x] Mark survivor infected after three reports
- [x] Find closest survivor by longitude
- [x] Find closest survivor by longitude
- [x] Find closest survivor by inline ([Method used to calculate](https://en.wikipedia.org/wiki/Great-circle_distance))
- [x] Simple route to move all survivors
- [x] Simple worker to move all survivors

<h3 id="simple-worker">About the simple worker (Move all survivors)</h3>

* How do works?
  - Basically, a simple calculation is made to move the survivors up to the maximum value of logitude and latitude after reaching "the edge of the world" the direction changes and they start "walking" in the opposite direction.
* How many times does it update?
  - The worker is scheduled to run every 1 min, similar to a very slow radar
