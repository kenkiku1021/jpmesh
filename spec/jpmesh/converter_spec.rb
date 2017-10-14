RSpec.describe Jpmesh do
  MESHCODE = "53394529"
  LONGITUDE = 139.7375
  LATITUDE = 35.68333333
  LONGITUDE2 = 139.7396
  LATITUDE2 = 35.6878
  
  it "get longitude from mesh code" do
    (longitude, latitude) = Jpmesh::Converter.mesh_to_location(MESHCODE)
    expect((longitude.abs - LONGITUDE) < 0.001).to eq(true)
  end

  it "get latitude from mesh code" do
   (longitude, latitude) = Jpmesh::Converter.mesh_to_location(MESHCODE)
    expect((latitude.abs - LATITUDE) < 0.001).to eq(true)    
  end

  it "get mesh code from location" do
    mesh = Jpmesh::Converter.location_to_mesh(LONGITUDE2, LATITUDE2, 3)
    expect(mesh).to eq MESHCODE
  end
  
  #it "does something useful" do
  #  expect(false).to eq(true)
  #end  
end
