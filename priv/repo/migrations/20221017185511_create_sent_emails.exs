defmodule AdminDashboard.Repo.Migrations.CreateSentEmails do
  use Ecto.Migration

  def up do
    create table(:sent_emails) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :to,      :string, null: false
      add :subject, :string, null: false
      add :body,    :text,   null: false
      add :tsv,     :tsvector

      timestamps()
    end

    create index(:sent_emails, [:user_id])

    flush()

    execute("CREATE EXTENSION IF NOT EXISTS unaccent;")

    execute(
      ~S"""
        CREATE OR REPLACE FUNCTION sent_emails_fts_upsert() RETURNS trigger AS $$
        begin
          new.tsv :=
            setweight(to_tsvector('pg_catalog.english', unaccent(coalesce(new.subject,''))), 'A')  || ' ' ||
            setweight(to_tsvector('pg_catalog.english', unaccent(coalesce(new.body,''))), 'B');
          return new;
        end
        $$ LANGUAGE plpgsql
      """
    )

    execute("CREATE TRIGGER sent_emails_fts_insert_trigger BEFORE INSERT OR UPDATE ON sent_emails FOR EACH ROW EXECUTE PROCEDURE sent_emails_fts_upsert();")
  end

  def down do
    execute("DROP TRIGGER IF EXISTS sent_emails_fts_insert_trigger ON sent_emails;")
    execute("DROP FUNCTION IF EXISTS sent_emails_fts_upsert();")

    execute("DROP TABLE IF EXIStS sent_emails CASCADE;")
  end
end
