class AddAgendaDetailsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :agenda_details, :string
  end
end
