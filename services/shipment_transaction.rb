require 'csv'
require './shipment_detail.rb'

class ShipmentTransaction
  attr_accessor :records, :count, :data

  # shipment maximum weight
  MAX_WEIGHT = 2311

  def initialize
    @count = 5
    read_parcel
    process
    update_shipment_ref
  end

  def read_parcel
    filepath = File.expand_path('../data/input.csv', File.dirname(__FILE__))
    csv = CSV.read(filepath, headers: true)
    @records = csv.each_with_object([]).with_index do |(row, data), index|
      data << ShipmentDetail.new(
        id: index + 1,
        parcel: row['parcel_ref'],
        client: row['client_name'],
        weight: row['weight']
      )
    end
  end

  def process
    total_weight = 0
    #  group parcels into as few shipments
    @data = @records.group_by(&:client).each_with_object([]) do |(_client, parcel), data|
      total_weight += parcel.map(&:weight).inject(0, &:+)
      if total_weight > MAX_WEIGHT
        @count -= 1
        total_weight = 0
      end
      # update the shipment reference
      data << parcel.each { |tr| tr.shipment_ref = "shipment #{@count}" }
    end.flatten!
  end

  def update_shipment_ref
    filepath = File.expand_path('../data/output.csv', File.dirname(__FILE__))
    # generate the csv
    CSV.open(filepath, 'w') do |csv|
      csv << %w[parcel_ref,client_name,weight,shipment_ref]
      data.sort_by(&:id).each { |obj|
        csv << [obj.parcel_ref, obj.client, obj.weight, obj.shipment_ref]
      }
    end
  end
end

ShipmentTransaction.new
