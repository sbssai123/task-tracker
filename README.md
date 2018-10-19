# TaskTracker

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Information about the Task Tracker application

  * deploy.sh script is for running the application in the foreground
  * start.sh script is for deploying the application in production
  * Users can register with their first name, last name, and email. The email
  has to not already exist in the database for it to be valid.
  * Once logged in, a user can create a new task and assign it to themselves
  or another user.
  * There are two lists: one that shows the logged in users tasks and one that
  shows all of the tasks created by all the users.
  * A user is only able to mark the completion and duration of a task that is
  assigned to them.
  * One a task is marked as complete, a user is not able to reassign it to
  another user. The user who was assigned to the task can mark it as incomplete
  and then reassign it if needed.
  * The time is kept in 15 minute increments and by the hour as well.
