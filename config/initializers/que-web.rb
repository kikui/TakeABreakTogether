Que::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "admin"]
end