class CreateCompromisos < ActiveRecord::Migration
  def change
    create_table :compromisos do |t|
      t.string :nombre
      t.string :apellido
      t.string :email
      t.integer :ciudad_origen
      t.integer :edad
      t.string :compromiso

      t.timestamps null: false
    end
  end
end
