# AdminDashboard

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Details

The dashboard displays a "sent_emails" table that can be sorted and filtered, containing:
  * User - email's creator & sender
  * To - email recipient's email address
  * Sent At - time the email was sent at ("created")
  * Subject - email's subject line
  * Body - email's body

New emails and users can be created with the New Email & New User Modals.
  * Creating new users or emails does not affect table sort and filter selections.
  * New emails will automatically be inserted into the table in the appropriate position.
