# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AdminDashboard.Repo.insert!(%AdminDashboard.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias AdminDashboard.Repo
alias AdminDashboard.Users.User
alias AdminDashboard.SentEmails.SentEmail

Repo.delete_all(SentEmail)
Repo.delete_all(User)

defmodule SeedHelpers do
  def add_user(name, email) do
    Repo.insert!(User.accept_invitation_changeset(%User{}, %{name: name, email: email, password: "supersekrit00", password_confirmation: "supersekrit00", accepted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)}))
  end

  def add_sent_email(email) do
    Repo.insert!(SentEmail.seed_changeset(%SentEmail{}, email))
  end

  def set_inserted_time(second_offset) do
    DateTime.utc_now()
    |> DateTime.add(second_offset)
    |> DateTime.truncate(:second)
    |> DateTime.to_naive()
  end
end

dummy_users = [
  %{name: "Jane Doe", email: "jane@example.com"},
  %{name: "Paul McCartney", email: "paul@example.com"},
  %{name: "John Lennon", email: "john@example.com"},
  %{name: "Richard Starkley", email: "ringo@example.com"}
]

Enum.each(dummy_users, &SeedHelpers.add_user(&1.name, &1.email))

email_seeds = [
  %{
    user_id: 1,
    to: "miranda_customer@example.com",
    subject: "Your free gift from The Local Diner & Taproom.",
    body: "We hope you enjoy this gift from The Local Diner & Taproom and hope to see you and your family soon!",
    inserted_at: SeedHelpers.set_inserted_time(-1800)
  },
  %{
    user_id: 1,
    to: "beth_customer@example.com",
    subject: "A special thank you from The Local Diner & Taproom.",
    body: "Enjoy an dessert from The Local Diner & Taproom. Call ahead and place or order online for convenient pickups.",
    inserted_at: SeedHelpers.set_inserted_time(-3600)
  },
  %{
    user_id: 1,
    to: "jay_customer@example.com",
    subject: "Your free gift from The Local Diner & Taproom is waiting.",
    body: "Come on over to The Local Diner & Taproom for this sweat treet!",
    inserted_at: SeedHelpers.set_inserted_time(-10800)
  },
  %{
    user_id: 2,
    to: "will_customer@example.com",
    subject: "Redeem your gift from The Local Diner & Taproom.",
    body: "Come on over to The Local Diner & Taproom to redeem this free gift and enjoy our live music.",
    inserted_at: SeedHelpers.set_inserted_time(-7800)
  },
  %{
    user_id: 2,
    to: "dave_customer@example.com",
    subject: "A special thank you from The Local Diner & Taproom",
    body: "Enjoy outdoor dining, grabbing all the great deals and indulging in a delicious meal.",
    inserted_at: SeedHelpers.set_inserted_time(-1000)
  },
  %{
    user_id: 3,
    to: "terry_customer@example.com",
    subject: "Trivia night and your free gift from The Local Diner & Taproom is waiting.",
    body: "Come out Thursday nights for fun trivia, prizes and your favorite Local appetizer free.",
    inserted_at: SeedHelpers.set_inserted_time(-28800)
  },
  %{
    user_id: 3,
    to: "chris_customer@example.com",
    subject: "A special gift from The Local Diner & Taproom",
    body: "Don’t miss out on this fun tasty event with good food, wine, live music and so much more! Redeem this coupon for $10 off.",
    inserted_at: SeedHelpers.set_inserted_time(-3800)
  },
  %{
    user_id: 3,
    to: "brett_customer@example.com",
    subject: "Enjoy this local gift from us.",
    body: "Fall leaves are falling and so are our prices at The Local Diner & Taproom.",
    inserted_at: SeedHelpers.set_inserted_time(-5700)
  },
  %{
    user_id: 3,
    to: "deb_customer@example.com",
    subject: "The Local Diner & Taproom's happy hour just got happier",
    body: "Your night out with friends at The Local Diner & Taproom just got a lot better with this free round on us.",
    inserted_at: SeedHelpers.set_inserted_time(-4200)
  },
  %{
    user_id: 3,
    to: "linda_customer@example.com",
    subject: "Your special offer from The Local Diner & Taproom",
    body: "How could a dinner at The Local Diner & Taproom get any better? A free specialty flatbread that's how!",
    inserted_at: SeedHelpers.set_inserted_time(-7100)
  },
  %{
    user_id: 4,
    to: "aaron_customer@example.com",
    subject: "Have more fun at The Local Diner & Taproom on us.",
    body: "We want your family's next trip to The Local Diner & Taproom to be unforgettable with this special offer.",
    inserted_at: SeedHelpers.set_inserted_time(-21500)
  }
]

Enum.each(email_seeds, &SeedHelpers.add_sent_email(&1))
