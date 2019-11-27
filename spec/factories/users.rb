FactoryBot.define do
  factory :user do
    name { "hiro_hiro" }
    password { "hogefoobarfu" }
    password_confirmation { "hogefoobarfu" }
    atcoder_id { "" }
  end
end
