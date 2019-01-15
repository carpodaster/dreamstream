SleepyRecord = Struct.new(:name, :items_count) do
  class << self
    def find_in_batches
      1.upto(5).map { |i| new("Batch #{i}", 20) }.each do |group|
        yield group
      end
    end

    def all
      new("All records", 100)
    end
  end

  def each
    return to_enum(__callee__) unless block_given?
    items_count.times do |line_no|
      sleep 0.1
      yield "#{name};CSV;line #{line_no + 1}\n"
    end
  end
end
