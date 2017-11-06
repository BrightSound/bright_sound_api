Sequel.migration do
  change do
    create_table(:sessions) do
      String :sid, unique: true, null: false, primary_key: true
      text :session, null: false
      DateTime :created_at, null: false
      DateTime :updated_at
    end
  end
end
