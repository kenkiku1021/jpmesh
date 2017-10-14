module Jpmesh
  class Converter
    def Converter.mesh_to_location(mesh)
      unless mesh.to_s =~ /^(\d{4})(\d{2})?(\d{2})?$/
        raise "Invalid mesh code format"
      end
      primary_mesh = $1
      secondary_mesh = $2
      tertiary_mesh = $3

      (longitude, latitude) = Converter.primary_mesh_to_location(primary_mesh)
      if secondary_mesh
        (longitude2, latitude2) = Converter.secondary_mesh_to_location(secondary_mesh)
        longitude += longitude2
        latitude += latitude2

        if tertiary_mesh
          (longitude3, latitude3) = Converter.tertiary_mesh_to_location(tertiary_mesh)
          longitude += longitude3
          latitude += latitude3
        end
      end

      [longitude, latitude]
    end

    def Converter.location_to_mesh(longitude, latitude, level=3)
      if level != 1 && level != 2 && level != 3
        raise "Invalid mesh code level"
      end
      p = (latitude * 60).to_i / 40
      a = (latitude * 60).to_i % 40
      u = (longitude - 100).floor
      f = longitude - 100 - u
      q = a / 5
      b = a % 5
      v = (f * 60 / 7.5).floor
      g = (f * 60) - (7.5 * v)
      r = (b * 60).to_i / 30
      w = (g * 60).to_i / 45
      if level == 1
        sprintf("%d%d", p, u)
      elsif level == 2
        sprintf("%d%d%d%d", p, u, q, v)
      elsif level == 3
        sprintf("%d%d%d%d%d%d", p, u, q, v, r, w)
      end
    end

    private
    def Converter.primary_mesh_to_location(mesh)
      if mesh =~ /^(\d{2})(\d{2})$/
        latitude = $1.to_f/1.5
        longitude = $2.to_f + 100
        [longitude, latitude]
      end
    end

    def Converter.secondary_mesh_to_location(mesh)
      if mesh =~ /^(\d)(\d)$/
        latitude = $1.to_f*5/60
        longitude = $2.to_f/8/60
        [longitude, latitude]
      end
    end

    def Converter.tertiary_mesh_to_location(mesh)
      if mesh =~ /^(\d)(\d)$/
        latitude = $1.to_f/2/60
        longitude = $2.to_f*3/4/60
        [longitude, latitude]
      end
    end
  end
end
