module MediaProfilesHelper
  def display_address(address)
    unless address.nil?
      full_address = ""
      full_address += address.line1 + ",<br/>" unless address.line1.blank?
      full_address += address.line2 + ",<br/>" unless address.line2.blank?
      full_address += address.postcode + "," unless address.postcode.blank?
      full_address += address.city.name + ",<br/>" unless address.city.blank?
      full_address += address.city.state_name unless address.city.blank?

      full_address.html_safe
    end
  end
end
