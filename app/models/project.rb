class Project < ApplicationRecord
  belongs_to :client
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: %w[active paused completed], message: "%{value} no es un estado válido" }

  # Un proyecto muestra su porcentaje de avance (tareas completadas / total)
  def progress_percentage
    return 0 if tasks.empty?
    completed = tasks.where(done: true).count
    (completed.to_f / tasks.count * 100).round
  end
end
