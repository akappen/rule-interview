class SameSideOfCenterline

  # "N points in a row on same side of centerline"

  def initialize(n, center)
    @n = n
    @center = center
  end

  def apply(values)
    return Array.new(values.length, false) if values.length < @n

    values.each_cons(@n).map do |vs|
      if vs.all? { |v| v && @center && v > @center }
        true
      elsif vs.all? { |v| v && @center && v < @center }
        true
      else
        false
      end
    end
  end
end
