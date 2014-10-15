# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  ip_detected_location   :string(255)
#  city                   :string(255)
#  browser                :string(255)
#  referrals              :integer
#  created_at             :datetime
#  updated_at             :datetime
#  referral_token         :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :generate_referral_token

  def generate_referral_token
    self.referral_token = Devise.friendly_token
    self.confirmation_token = Devise.friendly_token
    save!
  end

  def confirmed?
    self.confirmed_at != nil
  end

  def confirm(token)
    unless confirmed? && token == confirmation_token
      self.confirmed_at = DateTime.now
      save
    end
  end
end
