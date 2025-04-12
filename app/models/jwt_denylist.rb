# frozen_string_literal: true

class JwtDenylist < ApplicationRecord
  validates :jti, presence: true, uniqueness: true
end
