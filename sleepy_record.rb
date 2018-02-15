SleepyRecord = Struct.new(:items_count) do
  class << self
    def find_in_batches
      1.upto(4).map { new(10) }.each do |group|
        yield group
      end
    end
  end

  def each
    return to_enum(__callee__) unless block_given?
    items_count.times do
      sleep 0.3
      yield "My;CSV;line\n"
    end
  end
end
