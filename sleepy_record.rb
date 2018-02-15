SleepyRecord = Struct.new(:name, :items_count) do
  class << self
    def find_in_batches
      1.upto(4).map { |i| new("Batch #{i}", 10) }.each do |group|
        yield group
      end
    end
  end

  def each
    return to_enum(__callee__) unless block_given?
    items_count.times do |line_no|
      sleep 0.3
      yield "#{name};CSV;line #{line_no + 1}\n"
    end
  end
end
