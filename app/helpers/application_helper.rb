module ApplicationHelper

  def title(*namers)
    unless namers.empty?
      content_for :title do
        (namers << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&show_this_section)
    show_this_section.call if current_user.try(:admin?)
  end
end
