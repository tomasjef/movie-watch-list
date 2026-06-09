class List < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  validates :name, presence: true, uniqueness: { scope: :user_id }

  # 1. Runs before validation to catch blank fields
  before_validation :set_default_image, on: :create

  # 2. Validates that it looks like a proper web URL
  validates :image_url, format: {
    with: %r{\Ahttps?://.*\z}i,
    message: "must be a valid URL starting with http:// or https://"
  }

  private

  def set_default_image
    # Standard placeholder image from Unsplash if blank
    placeholder = "https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/background.png"
    self.image_url = placeholder if image_url.blank?
  end
end
