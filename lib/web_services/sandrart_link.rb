class WebServices::SandrartLink < WebServices::Link

  def self.label
    "Sandrart"
  end
  
  def self.external_reference_label
    "Sandrart ID"
  end

  def self.link_for(entity)
    id = entity.external_references[name]
    unless id.blank?
      return "http://ta.sandrart.net/prs/" + id
    else
      return nil
    end
  end
  
  def self.needs_external_reference?
    true
  end
  
end
