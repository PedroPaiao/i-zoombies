<h1 align="center">I ZoomBies</h1>
<p align="center">🧟
Rest API that stores survivors of a zombie apocalypse and allows
to find the survivor closest to your location.</p>

<div align='center' id="technologies">
  <img src="https://img.shields.io/static/v1?label=Framework&message=Ruby-on-rails&color=7159c1&style=for-the-badge&logo=Ruby.png"/>
  <img src="https://img.shields.io/static/v1?label=Database&message=Postgresql&color=7159c1&style=for-the-badge&logo=PostgreSQL.png"/>
</div>

<h3 id="table" align="center">Table of Contents</h3>
<p align="center">
 <a href="#table">Table of Contents</a> •
 <a href="#dependencies">Dependencies</a> • 
 <a href="#technologies">Technologies</a> • 
 <a href="#project-setup">Project Setup</a> •
 <a href="#run-tests">Run Tests</a> • 
 <a href="#run-server">Run Server</a> • 
 <a href="https://github.com/PedroPaiao">Author</a>
</p>

<h2 id="dependencies" align="left">Dependencies</h2>

 - Ruby v3.0.1
     - If you don't have Ruby installed on your machine, I recommend using [RVM](https://rvm.io/) to install it.
 - Rails, '~> 6.1.4', '>= 6.1.4.1'
 - Postgres >= 12
 - Git

**Download**

Access the location of your projects through the terminal and download the repository (ssh-version)
```bash
$ git clone git@github.com:PedroPaiao/i-zoombies.git
```

<h2 id="project-setup">Project Setup</h2>

**Gemset setup (If you are using rvm)**

Inside the project folder, create the files `.ruby-version` and `.ruby-gemset` then enter the folder again to load the new settings.
```bash
$ echo "ruby-3.0.1" > .ruby-version && echo "i-zoombies-api" > .ruby-gemset
$ cd .
```

**Install gem dependencies**

The tool `bundle` will install all the gems that were defined in the project's Gemset.
```bash
$ gem install bundler:2.2.15
$ bundle install
```

**Database configuration**

First copy the file from `database.sample.yml` to `database.yml`
```bash
$ cp config/database.sample.yml config/database.yml
```

Now, configure your database authentication.
```bash
Change variables `<'YOUR_USERNAME_HERE'>`,`<'YOUR_PASSWORD_HERE'>` for your own values.
```

Good! Now let's run the tasks you configure, and they will populate our database instance.
```bash
$  rails db:create db:migrate db:seed
```


<h5 id="run-tests">Tests</h5>

I used the Rspec framework for testing implementation.

```bash
$ rspec
```

<h5 id="run-server">Run Server</h5>

```bash
$ rails s
```
<h4 align="center"> 
	<a href="https://www.ruby-lang.org" emoji-code="Ruby"><img class="emojidex-emoji" src="https://cdn.emojidex.com/emoji/px16/Ruby.png" emoji-code="Ruby" alt="Ruby" /></a> Yay! You’re on Rails!  <a href="https://www.ruby-lang.org" emoji-code="Ruby"><img class="emojidex-emoji" src="https://cdn.emojidex.com/emoji/px16/Ruby.png" emoji-code="Ruby" alt="Ruby" /></a>
</h4>

### Features
<h4 align="left"> 
	🚧  Work in progress  🚧
</h4>
