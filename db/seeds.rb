# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.where(email: "rootuser@mail.com").first_or_initialize

# Set the password attributes
user.password = "password"
user.password_confirmation = "password"
# Save the user and check for errors
if user.save
  puts "User created successfully!"
else
  puts "Failed to create user. Errors: #{user.errors.full_messages}"
end
