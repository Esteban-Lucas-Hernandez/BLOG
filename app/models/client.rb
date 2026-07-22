class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_destroy :check_active_projects, prepend: true

  private

  # Un cliente no se puede eliminar si tiene proyectos activos
  def check_active_projects
    if projects.where(status: 'active').exists?
      errors.add(:base, "No se puede eliminar el cliente porque tiene proyectos activos.")
      throw :abort
    end
  end
end
