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

ActiveRecord::Schema.define(version: 2022_04_16_154521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absence_request_notifications", force: :cascade do |t|
    t.bigint "absence_request_id", null: false
    t.bigint "notification_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["absence_request_id"], name: "index_absence_request_notifications_on_absence_request_id"
    t.index ["notification_id"], name: "index_absence_request_notifications_on_notification_id"
  end

  create_table "absence_requests", force: :cascade do |t|
    t.integer "state", default: 0, null: false
    t.string "reason", limit: 64, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "schedule_id", null: false
    t.index ["schedule_id"], name: "index_absence_requests_on_schedule_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name", limit: 16
    t.string "first_name", limit: 16
    t.string "zipcode", limit: 16
    t.string "address", limit: 128
    t.string "phone_number", limit: 16
    t.boolean "delete_flg"
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "attendance_request_notifications", force: :cascade do |t|
    t.bigint "attendance_request_id", null: false
    t.bigint "notification_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendance_request_id"], name: "index_attendance_request_notifications_on_attendance_request_id"
    t.index ["notification_id"], name: "index_attendance_request_notifications_on_notification_id"
  end

  create_table "attendance_requests", force: :cascade do |t|
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "schedule_id", null: false
    t.index ["schedule_id"], name: "index_attendance_requests_on_schedule_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name", limit: 16
    t.string "first_name", limit: 16
    t.string "zipcode", limit: 16
    t.string "address", limit: 128
    t.string "phone_number", limit: 16
    t.boolean "delete_flag"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "action", default: 0, null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "starting_time", null: false
    t.datetime "closing_time", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_schedules_on_employee_id"
  end

  add_foreign_key "absence_request_notifications", "absence_requests"
  add_foreign_key "absence_request_notifications", "notifications"
  add_foreign_key "absence_requests", "schedules"
  add_foreign_key "attendance_request_notifications", "attendance_requests"
  add_foreign_key "attendance_request_notifications", "notifications"
  add_foreign_key "attendance_requests", "schedules"
  add_foreign_key "schedules", "employees"
end
