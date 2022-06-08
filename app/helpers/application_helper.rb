module ApplicationHelper

  def title(*namers)
    unless namers.empty?
      content_for :title do
        (namers << "Ticketee_from_helper").join(" - ")
      end
    end
  end

end
