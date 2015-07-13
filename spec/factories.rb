FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Name #{n}" }
    prename 'Prename'
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'welcome'
    password_confirmation 'welcome'
  end

  factory :admin, class: 'Admin', parent: :user do
    sequence(:email) { |n| "admin_#{n}@example.com" }
  end

  factory :mentor, class: 'Mentor', parent: :user do
    sequence(:email) { |n| "mentor_#{n}@example.com" }
  end

  factory :teacher, class: 'Teacher', parent: :user do
    sequence(:email) { |n| "teacher_#{n}@example.com" }
  end

  factory :principal, class: 'Principal', parent: :user do
    sequence(:email) { |n| "principal_#{n}@example.com" }
    schools {[FactoryGirl.create(:school)]}
  end

  factory :kid do
    sequence(:name) { |n| "Kid #{n}" }
    prename 'Prename'
  end

  factory :journal do
    association :kid
    association :mentor
    held_at Date.parse('2011-05-30')
    start_at Time.parse('13:00')
    end_at Time.parse('14:00')
  end

  factory :cancelled_journal, parent: :journal do
    held_at Date.parse('2011-05-30')
    cancelled true
    start_at nil
    end_at nil
  end

  factory :review do
    association :kid
    held_at Date.parse('2011-05-30')
  end

  factory :reminder do
    association :kid
    association :mentor
    recipient { |r| r.mentor.email }
    held_at Date.parse('2011-05-30')
    week { |r| r.held_at.strftime('%U') }
    year { |r| r.held_at.year }
  end

  factory :schedule do
    person { |p| p.association(:mentor) }
    day 1
    hour 14
    minute 0
  end

  factory :school do
    name 'The school'
  end

  factory :comment do
    association :journal
    body 'A comment'
    by 'Commentator'
  end

  factory :document

  factory :relation_log do
    association :kid
    user { |p| p.association(:mentor) }
  end

  factory :principal_school_relation do
    association :school
    association :principal
  end

end
