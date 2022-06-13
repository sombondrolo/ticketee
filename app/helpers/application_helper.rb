module ApplicationHelper

  def title(*namers)
    unless namers.empty?
      content_for :title do
        (namers << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end
