# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_411_175_741) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'booking_tickets', force: :cascade do |t|
    t.bigint 'booking_id', null: false
    t.bigint 'ticket_id', null: false
    t.integer 'quantity'
    t.decimal 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['booking_id'], name: 'index_booking_tickets_on_booking_id'
    t.index ['ticket_id'], name: 'index_booking_tickets_on_ticket_id'
  end

  create_table 'bookings', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.bigint 'event_id', null: false
    t.decimal 'total_price'
    t.string 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_bookings_on_customer_id'
    t.index ['event_id'], name: 'index_bookings_on_event_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'phone_number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_customers_on_user_id'
  end

  create_table 'event_organizers', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'company_name'
    t.string 'phone_number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_event_organizers_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'event_date'
    t.string 'venue'
    t.bigint 'event_organizer_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_organizer_id'], name: 'index_events_on_event_organizer_id'
    t.index %w[title event_date], name: 'index_events_on_title_and_event_date', unique: true
  end

  create_table 'jwt_denylists', force: :cascade do |t|
    t.string 'jti'
    t.datetime 'exp'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['jti'], name: 'index_jwt_denylists_on_jti'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name resource_type resource_id], name: 'index_roles_on_name_and_resource_type_and_resource_id'
    t.index %w[resource_type resource_id], name: 'index_roles_on_resource'
  end

  create_table 'tickets', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.string 'ticket_type'
    t.decimal 'price'
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_tickets_on_event_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'users_roles', id: false, force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'role_id'
    t.index ['role_id'], name: 'index_users_roles_on_role_id'
    t.index %w[user_id role_id], name: 'index_users_roles_on_user_id_and_role_id'
    t.index ['user_id'], name: 'index_users_roles_on_user_id'
  end

  add_foreign_key 'booking_tickets', 'bookings'
  add_foreign_key 'booking_tickets', 'tickets'
  add_foreign_key 'bookings', 'customers'
  add_foreign_key 'bookings', 'events'
  add_foreign_key 'customers', 'users'
  add_foreign_key 'event_organizers', 'users'
  add_foreign_key 'events', 'event_organizers'
  add_foreign_key 'tickets', 'events'
end
