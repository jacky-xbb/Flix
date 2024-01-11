class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites
  has_many :liked_movies, through: :favorites, source: :movie

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
