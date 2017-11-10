Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    User.create \
      email: "user@example.com",
      password: 'asdf123!'
  end
end
