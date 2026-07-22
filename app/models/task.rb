class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  
  after_initialize :set_defaults, if: :new_record?

  validate :cannot_complete_if_overdue, on: :update
  validate :project_not_paused_when_completing, on: :update
  validate :project_not_completed_when_creating, on: :create

  # Tareas vencidas (due_date pasada y done: false)
  def overdue?
    !done && due_date.present? && due_date < Date.today
  end

  private

  def project_not_paused_when_completing
    if done_changed?(to: true) && project.status == 'paused'
      errors.add(:done, "por favor espere que el proyecto esté habilitado")
    end
  end

  def project_not_completed_when_creating
    if project.status == 'completed'
      errors.add(:base, "No se pueden agregar más tareas a un proyecto completado")
    end
  end

  def cannot_complete_if_overdue
    if done_changed?(to: true) && due_date.present? && due_date < Date.today
      errors.add(:done, "no se puede marcar como hecha porque está vencida")
    end
  end

  def set_defaults
    self.done = false if self.done.nil?
  end
end
