module Infrastructure
  module Jobs
    class JobQueue
      @queue = []

      class << self
        def enqueue(&block)
          Thread.new do
            block.call
          end
        end
      end
    end
  end
end
