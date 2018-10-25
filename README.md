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

## Updates for Task Tracker Part 2

#### Managers

  * When registering a user now, they can select the is_manager field check box
  to give them manager access. They also choose a manager which will assign them
  tasks. The managers drop down contains all of the users who are managers in the
  app. You also have the option to not assign them a manager.
  * On the list of tasks page, you can see the tasks that you (the current user)
  needs to complete, the tasks that all your underlings (people you manage) need
  to complete and their progress, and all of the tasks that have not been assigned
  by any manager in the app.
  * When creating a new task, you can only assign the task to yourself or one of
  your underlings. You can also choose not to assign the task to anyone.
  * There is also a new profile page which can be accessed by click the "Profile"
  button on the nav bar. This shows you all the information about yourself
  (i.e. your name, email, and manager). And you can also see the names of all
  the users you manage. You have the ability to edit this profile with your information.

  * This functionality was implemented by adding two new fields to the User table: is_manager
  and manager_id.
  * The manager_id references the User table and represents the User's manager. This is a one to
  many relationship where a manager can have many underlings but each underling only has one manager.
  * To get all of the underlings for the current_user, I created a database query
  in users.ex where when given a user_id, search through all the users where their
  manager_id is the same as the current_user's id.

#### Time Blocks to represent Duration of tasks

  * Durations are no longer represented in 15 minute increments. They are
  represented in Time Blocks with a start and end DateTime. Each time block also belongs_to
  a Task and a Task can have many time blocks to represent time periods the user worked on it.
  * Time blocks can be created when clicking on the show button for the task. Only the user which
  is assigned to the task can add time blocks. Additionally, time blocks can only be added when
  the task isn't complete. If the task is complete, then no more time blocks can be added.
  * When going to the show page for the task, a time block is created after the start button and end
  button are pressed. The start button is pressed the user wants to indicate starting a time block
  for working on the task. The end button is pressed when the user wants to indicate ending a chunk
  of time working on the project.
  * When the end button is pressed, a new time block is added to the table of time blocks. The user
  can delete the time block if it is incorrect and add more by just pressing start and end again.
  * Once start is pressed, the start button is disabled while the end button is enabled. This is to
  make sure the start button and / or end button isn't pressed twice.

  * This functionality was implemented by creating a new table called TimeBlock. The Timeblock has a
  start_time, end_time field that represent the datetimes that the user started and finished a chunk of
  time working on the task. It also has a task_id to represent the task that the block is associated
  with. This is a one to many relationship where a timeblock belongs to a task and a task has many
  timeblocks.
