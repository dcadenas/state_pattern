  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  require 'state_pattern'

    def wait(seconds)
      seconds.downto(1) do |i|
        print " #{i}"
        $stdout.flush
        sleep 1
      end
    end

    class Stop < StatePattern::State
      def next
        wait 3
        transition_to(Go)
      end

      def color
        "Red"
      end
    end

    class Go < StatePattern::State
      def next
        wait 2
        transition_to(Caution)
      end

      def color
        "Green"
      end
    end

    class Caution < StatePattern::State
      def next
        wait 1
        transition_to(Stop)
      end

      def color
        "Amber"
      end
    end

  class TrafficSemaphore
    include StatePattern
    set_initial_state Stop
  end

  semaphore = TrafficSemaphore.new

  loop do
    print semaphore.color
    semaphore.next
    puts
  end


