module ApplicationHelper
  def can_delete?(item)
    current_user.admin? || current_user.id == item.author_id
  end
end
