# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },{ name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Step.delete_all
User.delete_all
Deed.delete_all

lawyer = User.create!(
  email: 'abogado@a.b',
  password: '123321',
  password_confirmation: '123321',
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil,
  sign_in_count: 1,
  current_sign_in_at: '2015-02-06 14:02:10',
  last_sign_in_at: '2015-02-06 14:02:10',
  current_sign_in_ip: '127.0.0.1',
  last_sign_in_ip: '127.0.0.1',
  job: 1, # 'Abogado',
  first_name: 'Ignacio',
  last_name: 'González'
)

real_estate = User.create!(
  email: 'inmobiliaria@a.b',
  password: '123321',
  password_confirmation: '123321',
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil,
  sign_in_count: 1,
  current_sign_in_at: '2015-02-06 14:03:01',
  last_sign_in_at: '2015-02-06 14:03:01',
  current_sign_in_ip: '127.0.0.1',
  last_sign_in_ip: '127.0.0.1',
  job: 0, #'Inmobiliaria',
  first_name: 'Pedro',
  last_name: 'Pérez'
)

User.create!(
  [
    {
      email: 'abogado2@a.b',
      password: '123321',
      password_confirmation: '123321',
      reset_password_token: nil,
      reset_password_sent_at: nil,
      remember_created_at: nil,
      sign_in_count: 1,
      current_sign_in_at: '2015-02-06 14:03:01',
      last_sign_in_at: '2015-02-06 14:03:01',
      current_sign_in_ip: '127.0.0.1',
      last_sign_in_ip: '127.0.0.1',
      job: 1 #'Abogado'
    },

    {
      email: 'inmobiliaria2@a.b',
      password: '123321',
      password_confirmation: '123321',
      reset_password_token: nil,
      reset_password_sent_at: nil,
      remember_created_at: nil,
      sign_in_count: 1,
      current_sign_in_at: '2015-02-06 14:03:44',
      last_sign_in_at: '2015-02-06 14:03:44',
      current_sign_in_ip: '127.0.0.1',
      last_sign_in_ip: '127.0.0.1',
      job: 0 # 'Inmobiliaria'
    }
  ]
)

deed1 = Deed.create!(
  identifier: 'cliente n134',
  state: 0,
  start_date: '',
  duration: 60,
  real_estate: real_estate,
  lawyers: [lawyer],
  created_at: '2015-02-06 14:03:44',
  updated_at: '2015-02-06 14:03:44'
)

deed2 = Deed.create!(
  identifier: 'cliente n133',
  state: 1,
  start_date: '',
  duration: 60,
  real_estate: real_estate,
  lawyers: [lawyer],
  created_at: '2015-02-06 14:03:44',
  updated_at: '2015-02-06 14:03:44'
)


Step.create!(
  user: real_estate,
  deed: deed1,
  state: 3,
  executed_on: '2015-02-06 14:03:44'
)

Step.create!(
  user: real_estate,
  deed: deed2,
  state: 4,
  executed_on: '2015-02-06 14:03:44'
)
