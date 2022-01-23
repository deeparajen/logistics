class ShipmentDetail
  attr_accessor :id, :parcel_ref, :client, :weight, :shipment_ref

  def initialize(id: ,parcel:, client:, weight:)
    @id = id
    @parcel_ref = parcel
    @client = client
    @weight = weight.to_i
  end
end
