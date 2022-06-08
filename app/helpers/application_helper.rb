module ApplicationHelper

  def title(*namers)
    unless namers.empty?
      content_for :title do
        (namers << "Ticketee").join(" - ")
      end
    end
  end
  
end
