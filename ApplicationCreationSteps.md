# How to create this application

## 1. Project initialisation to first commit

```bash
git init elite_ams
echo "# elite_ams" > elite_ams/README.md
rails new elite_ams
cd elite_ams
git add .
git commit -m "Create a new RoR project using MySQL"
```

## 2. Dependencies

They are managed in the file `Gemfile` of the project. To install the gems, simply run `bundle install` in the command-line.

### JavaScript runtime error

To solve this error:

> /usr/lib/ruby/gems/2.2.0/gems/execjs-2.5.2/lib/execjs/runtimes.rb:48:in `autodetect': Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)

We need to install a JavaScript runtime. Simply uncomment this line in the `Gemfile`:

```ruby
gem 'therubyracer', platforms: :ruby
```

### Twitter Bootstrap

See https://github.com/seyhunak/twitter-bootstrap-rails

To add Bootstrap using LESS, add the following in the `Gemfile`:

```ruby
gem 'less-rails'
gem 'twitter-bootstrap-rails'
```

After installation, run:

```bash
rails generate bootstrap:install less
```

### Schema to scaffold

See https://github.com/frenesim/schema_to_scaffold

This gem allows to generate the scaffold commands depending on schema.rb (the actual database state). This is great, because we can modify a table and easily regenerate the controllers and views.

This is not a dependency of the project, thus we install it system-wide. Run in the command-line:

```bash
gem install schema_to_scaffold
```

## 3. Database

### Create the databases

Run the command:

```bash
rake db:create
```

### Create the migrations

See http://api.rubyonrails.org/classes/ActiveRecord/Migration.html
See http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column
See http://guides.rubyonrails.org/active_record_migrations.html

Migrations are files which allow to modify the database incrementally. We will first create the database, and then generate the models, controllers and views later when the DB schema is completely done. Migrations are stored in the folder `db/migrate`.

We need first to create the tables *rooms*, *asset_categories*, *assets* and *reports*. [By convention] (http://guides.rubyonrails.org/active_record_basics.html#convention-over-configuration-in-active-record), table names should be pluralized, while object names of the model should be singularized. Default type for the columns is *string* (varchar(255)).

```bash
rails g migration CreateRooms name:string{32}:uniq
rails g migration CreateAssetCategories name:string{32}:uniq
rails g migration CreateAssets description:string{32}
rails g migration CreateReports created_at:datetime:index description:text
rails g migration AddRoomToAssets room:references
rails g migration AddAssetCategoryToAssets asset_category:references
rails g migration AddRoomToReports room:references
rails g migration AddAssetCategoryToReports asset_category:references
rails g migration AddAssetToReports asset:references
rake db:migrate
```

### Load schema.rb

The command `rake db:migrate` created the file `db/schema.rb`, which contains the actual state of the database. If the file is up-to-date, we can create and setup the entire database by simply running the follong command:

```bash
rake db:setup
```

If we need to delete the database first (`rake db:drop`), use `rake db:reset` instead.

## 4. Application configuration

See http://guides.rubyonrails.org/configuring.html

Open `config/application.rb`.

### Timezone

Date are recorded in UTC in the database. We can set the default timezone for the views here by adding the following line in the class:

```ruby
config.time_zone = 'Tokyo'
```

### Generators

We can configure the default behaviour of the generators (`rails generate ...`) here. In particular, the *scaffold* generator creates too many files we do no need. We can deactivate the empty stylesheets, javascripts and helpers generations by adding the following block inside the class:

```ruby
config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
end
```

## 5. Generate CRUD for the resources

We will use the `scaffold` command in order to display the commands we need to execute in order to generate the CRUD for our application. Run `scaffold`, type `0` to select the schema.rb, then type `*` to generate the commands for all the objects.

The scripts should appear as follows:

```bash
rails generate scaffold AssetCategory name:string --no-migration
rails generate scaffold Asset description:string room:references asset_category:references --no-migration
rails generate scaffold Report description:text room:references asset_category:references asset:references --no-migration
rails generate scaffold Room name:string --no-migration
```

If you start the server using `rails server`, the pages should be visible at:

* http://localhost:3000/rooms
* http://localhost:3000/asset_categories
* http://localhost:3000/assets
* http://localhost:3000/reports

Finally, we can use the twitter-bootstrap-rails in order to have a nice theme:

```bash
rails g bootstrap:themed Rooms -f
rails g bootstrap:themed AssetCategories -f
rails g bootstrap:themed Assets -f
rails g bootstrap:themed Reports -f

```

Unfortunately, the theme assumes that we have *created_at* and *updated_at* columns in every table, which is not the case in our application. This cause to throw an error when we try to open the pages. We need to delete the references in the generated files, except for *created_at* in *reports*. For instance, in the case of *rooms*, for the files in the folder `app/views/rooms`:

* File `index.html.erb`:
  * Delete the line 10
  * Delete the line 19
* File `show.json.builder`:
  * Delete the *created_at* and *updated_at* arguments

We will focus later on improving this part of the application.

## 6. Welcome page and default layout

### Creation of the welcome page

Let us create the welcome/index controller, view and test files. We can skip the creation of the route, because we want the page as the root page of the website only.

```bash
rails g controller welcome index --skip-routes
```

Open `config/routes.rb` and uncomment the following line:

```ruby
root 'welcome#index'
```

If you start the server using `rails server`, the welcome page should be visible at http://localhost:3000.

### Default layout

Now, we can focus on the default layout of the website. The file containing the default layout is `app/views/layouts/application.html.erb`. It contains:

```erb
<!DOCTYPE html>
<html>
<head>
  <title>EliteAms</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
```

The `<%= yield %>` block is important, as this is where the content of every views of the site, like `app/views/welcome/index.html.erb`, is automatically included during the generation of the page.

We won't use it here, but the twitter-bootstrap-rails gem contains a generator for the layout:

```bash
rails g bootstrap:layout
```

### Default blank layout

The first step is to create the base html structure of the website. Replace the code of the layout by the following one:

```erb
<!doctype html>
<html class="no-js" lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>EliteAMS<%= content_for?(:title) ?  " - " + yield(:title) : "" %></title>
    <%= csrf_meta_tags %>

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
      <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.js" type="text/javascript"></script>
    <![endif]-->

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  </head>
  <body>
    <div class="container">
      <%= yield %>
    </div>
  </body>
</html>
```

Notice the title of the page. The default value is "EliteAMS". But if you add the following code in `app/views/welcome/index.html.erb`, it will become "EliteAMS - Welcome".

```erb
<% content_for :title, "Welcome" %>
```

### Add a navigation bar

Add this code at the beginning of the `<body>` part of the layout:

```erb
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <%= link_to "EliteAMS", root_path, class: "navbar-brand" %>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li><%= link_to "Rooms", rooms_path %></li>
        <li><%= link_to "Asset categories", asset_categories_path %></li>
        <li><%= link_to "Assets", assets_path %></li>
        <li><%= link_to "Reports", reports_path %></li>
      </ul>
    </div>
  </div>
</nav>
```

Since the navbar is fixed at the top, the content is hidden by the bar. In order to solve this issue, let us add some padding to the body. In `app/assets/stylesheets/application.css`, add:

```css
body
{
    padding-top: 50px;
    padding-bottom: 20px;
}
```

Finally, we can improve the apparence of the Bootstrap theme by adding the following line in the line 2 of `app/assets/stylesheets/bootstrap_and_overrides.css.less`:

```less
@import "twitter/bootstrap/theme";
```

### Final version of the welcome page

See the actual version of the file to know its content.


## 7. Issue reporting

### Creation of the pages

We need several pages for reporting an issue.

* Pages to choose the room, asset category and asset
* A page to describe the issue
* A page to thank for the report
* A how-to page

```bash
rails g controller report_issue choose_room choose_asset_category choose_asset describe thank_you how_to
```

### Dummy data

In order to test our pages, we need some dummy data in our database. These data are named fixtures. The scaffold command created some fixtures for us in the folder `test/fixtures`. Nevertheless, they do not take into account the constraints of our data (uniqueness and foreign keys). Let us fix that by creating our own fixtures:

* File `rooms.yml`

```yml
room_1:
  name: Room 1

room_2:
  name: Room 2
```

* File `asset_categories.yml`

```yml
room_1:
  name: Room 1

room_2:
  name: Room 2
```

* File `assets.yml`

```yml
chair_1:
  description: Blue chair
  room: room_1
  asset_category: chair

chair_2:
  description: Red chair
  room: room_1
  asset_category: chair

chair_3:
  description: Blue chair
  room: room_2
  asset_category: chair

chair_4:
  description: Blue chair
  room: room_2
  asset_category: chair

table_1:
  description: Long table
  room: room_2
  asset_category: table

laptop_1:
  description: PC1
  room: room_1
  asset_category: laptop

laptop_2:
  description: Rakuten PC model AEE123
  room: room_2
  asset_category: laptop

laptop_3:
  description: Rakuten PC model AEE123
  room: room_2
  asset_category: laptop
```

* File `reports.yml`

```yml
report_1:
  description: The screen is broken.
  room: room_1
  asset_category: laptop
  asset: laptop_2

report_2:
  description: There are no chairs in this room!!!
  room: room_2
  asset_category: chair
```

Then we can load them into the database by running:

`rake db:fixtures:load`

### Controllers and views

See the actual version of the files to know how they are done.
