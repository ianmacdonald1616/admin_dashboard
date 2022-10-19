defmodule AdminDashboard.SentEmails do
  import Ecto.Query, warn: false
  alias AdminDashboard.Repo
  alias AdminDashboard.SentEmails.SentEmail

  def change_new_sent_email(%SentEmail{} = new_email, attrs \\ %{}) do
    SentEmail.changeset(new_email, attrs)
  end

  def create_sent_email(attrs \\ %{}) do
    %SentEmail{}
    |> SentEmail.changeset(attrs)
    |> Repo.insert()
  end

  def sent_emails_query() do
    from(e in SentEmail,
      left_join: u in assoc(e, :user),
      preload: [user: u]
    )
  end

  def get_sent_emails(user_id \\ "", search_text \\ "", sort_by \\ "inserted_at", sort_order \\ "desc") do
    sent_emails_query()
    |> sort_sent_emails(sort_by, String.to_existing_atom(sort_order))
    |> where_user(user_id)
    |> where_text(search_text)
    |> Repo.all
  end

  defp sort_sent_emails(query, "inserted_at", sort_order) do
    from [e, u] in query, order_by: [{^sort_order, e.inserted_at}]
  end
  defp sort_sent_emails(query, "user_name", sort_order) do
    from [e, u] in query, order_by: [{^sort_order, u.name}]
  end
  defp sort_sent_emails(query, "to", sort_order) do
    from [e, u] in query, order_by: [{^sort_order, e.to}]
  end
  defp sort_sent_emails(query, "subject", sort_order) do
    from [e, u] in query, order_by: [{^sort_order, e.subject}]
  end
  defp sort_sent_emails(query, "body", sort_order) do
    from [e, u] in query, order_by: [{^sort_order, e.body}]
  end

  defp where_user(query, ""), do: query
  defp where_user(query, user_id) do
    from [e] in query, where: e.user_id == ^String.to_integer(user_id)
  end

  defp where_text(query, ""), do: query
  defp where_text(query, text) do
    from [e] in query,
      where: fragment(
        """
        ?::tsvector @@ websearch_to_tsquery('english', ?)
        """, e.tsv, ^text),

      order_by: fragment(
        """
        ts_rank(?::tsvector, websearch_to_tsquery('english', ?)) desc
        """,
        e.tsv, ^text)
  end
end
