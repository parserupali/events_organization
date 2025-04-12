# frozen_string_literal: true

%w[admin event_organizer customer].each do |role|
  Role.find_or_create_by(name: role)
end

# This is default admin user
admin_user = User.find_or_create_by(email: 'admin@example.com') do |user|
  user.first_name = 'Super'
  user.last_name = 'Admin'
  user.password = 'admin@123'
  user.password_confirmation = 'admin@123'
end

admin_user.add_role(:admin) unless admin_user.has_role?(:admin)

puts "Super Admin: #{admin_user.email}"
