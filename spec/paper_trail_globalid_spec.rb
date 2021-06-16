require 'spec_helper'
require_relative '../spec/support/order.rb'
require_relative '../spec/support/admin.rb'

describe PaperTrailGlobalid do
  before(:all) do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define do
      create_table :orders, force: true do |t|
        t.string :order_number
        t.integer :total
      end

      create_table :admins, force: true do |t|
        t.string :name
      end

      create_table :versions do |t|
        t.string   :item_type, :null => false
        t.integer  :item_id,   :null => false
        t.string   :event,     :null => false
        t.string   :whodunnit
        t.text     :object,    :limit => 1_073_741_823
        t.datetime :created_at
      end
    end
  end

  after(:all) do
    ActiveRecord::Schema.define do
      drop_table :orders
      drop_table :versions
    end
    ActiveRecord::Migration.verbose = true
  end

  describe 'paper_trail_globalid' do
    before do
      GlobalID.app = "App"
      @admin = Admin.create(name: 'admin')
      @order = Order.create!(order_number: 'ord_1', total: 100)
      @version = @order.versions.last
    end

    describe 'paper_trail' do
      describe 'class_methods' do
        describe 'PaperTrail.actor' do
          context 'when value for whodunnit is object of ActiveRecord' do
            it 'returns object' do
              PaperTrail.whodunnit=@admin
              expect(PaperTrail.actor).to eq(@admin)
            end
          end

          context 'when value for whodunnit is not an object of ActiveRecord' do
            it 'returns value itself' do
              PaperTrail.whodunnit="test"
              expect(PaperTrail.actor).to eq("test")
            end
          end
        end

        describe '.whodunnit' do
          context 'when value for whodunnit is object of ActiveRecord' do
            it 'returns global id' do
              PaperTrail.whodunnit=@admin
              expect(PaperTrail.whodunnit).to eq(@admin.to_gid)
            end
          end

          context 'when value for whodunnit is not an object of ActiveRecord' do
            it 'returns value itself' do
              PaperTrail.whodunnit="test"
              expect(PaperTrail.whodunnit).to eq("test")
            end
          end
        end
      end

      if PaperTrail.respond_to? :request
        describe 'request methods' do
          describe 'PaperTrail.request.actor' do
            context 'when value for whodunnit is object of ActiveRecord' do
              it 'returns object' do
                PaperTrail.request.whodunnit=@admin
                expect(PaperTrail.request.actor).to eq(@admin)
              end
            end

            context 'when value for whodunnit is not an object of ActiveRecord' do
              it 'returns value itself' do
                PaperTrail.request.whodunnit="test"
                expect(PaperTrail.request.actor).to eq("test")
              end
            end
          end

          describe '.whodunnit' do
            context 'when value for whodunnit is object of ActiveRecord' do
              it 'returns global id' do
                PaperTrail.request.whodunnit=@admin
                expect(PaperTrail.request.whodunnit).to eq(@admin.to_gid)
              end
            end

            context 'when value for whodunnit is not an object of ActiveRecord' do
              it 'returns value itself' do
                PaperTrail.request.whodunnit="test"
                expect(PaperTrail.request.whodunnit).to eq("test")
              end
            end
          end
        end
      end
    end

    describe 'version_concern' do
      describe 'instance_methods' do
        describe '#actor' do
          context 'when value for whodunnit is object of ActiveRecord' do
            it 'returns object' do
              @version.whodunnit = @admin
              @version.save
              expect(@version.actor).to eq(@admin)
            end
          end

          context 'when value for whodunnit is not an object of ActiveRecord' do
            it 'returns value itself' do
              @version.whodunnit = "test"
              @version.save
              expect(@version.actor).to eq("test")
            end
          end
        end

        describe '.whodunnit' do
          context 'when value for whodunnit is object of ActiveRecord' do
            it 'returns global id' do
              @version.whodunnit = @admin
              @version.save
              expect(@version.whodunnit).to eq(@admin.to_gid.to_s)
            end
          end

          context 'when value for whodunnit is not an object of ActiveRecord' do
            it 'returns value itself' do
              @version.whodunnit = "test"
              @version.save
              expect(@version.whodunnit).to eq("test")
            end
          end
        end
      end
    end
  end
end
