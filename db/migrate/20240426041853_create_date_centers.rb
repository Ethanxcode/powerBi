# frozen_string_literal: true

class CreateDateCenters < ActiveRecord::Migration[7.1]
  def change
    create_table :date_centers do |t|

      t.timestamps
    end
  end
end
