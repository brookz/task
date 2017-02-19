class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :entity_type, comment: 'related model'
      t.integer :entity_id, comment: 'related model.id'
      t.string :action, comment: 'action tag'
      t.string :attr_changes, comment: 'model.attr changes'
      t.integer :user_id, comment: 'user who did action'

      t.timestamps
    end

    create_table :teams do |t|
      t.string :title, comment: 'team name'

      t.timestamps
    end

    create_table :users do |t|
      t.integer :team_id, comment: 'belongs to team'
      t.string :name

      t.timestamps
    end

    create_table :projects do |t|
      t.integer :team_id, comment: 'team'
      t.string :title, comment: 'project name'
      t.timestamps
    end

    create_table :accesses do |t|
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end

    create_table :todos do |t|
      t.integer :project_id
      t.string :title
      t.integer :recipient_id, comment: 'who should finish it' 
      t.integer :status, default: 0, comment: 'status of todo: 0-init, 1-finished'
      t.datetime :etd, comment: 'estimate time'
      t.datetime :finished_at

      t.timestamps
    end

    create_table :comments do |t|
      t.integer :todo_id
      t.integer :user_id
      t.string :note
      t.timestamps
    end
  end
end
