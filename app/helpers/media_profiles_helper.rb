module MediaProfilesHelper
  def display_address(address)
    full_address = ""
    full_address += address.line1 + ",<br/>" unless address.line1.nil?
    full_address += address.line2 + ",<br/>" unless address.line2.nil?
    full_address += address.postcode + "," unless address.postcode.nil?
    full_address += address.city.name + ",<br/>" unless address.city.nil?
    full_address += address.city.state_name unless address.city.nil?

    full_address.html_safe
  end
end
