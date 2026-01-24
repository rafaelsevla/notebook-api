# frozen_string_literal: true

class User < ApplicationRecord # ou < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User
end
