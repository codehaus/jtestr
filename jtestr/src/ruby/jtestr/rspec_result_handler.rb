module JtestR
  class RSpecResultHandler < ::Spec::Runner::Formatter::BaseFormatter
    def initialize(result_handler)
      @result_handler = result_handler
    end

    def start(example_count)
      @result_handler.starting
    end
    
    def add_behaviour(behaviour)
      @behaviour = behaviour
    end
    
    def example_started(example)
      @result_handler.starting_single("#{example.description}(#{@behaviour.description})")
    end

    def example_passed(example)
      @result_handler.succeed_single(example.description)
    end

    def example_failed(example, counter, failure)
      @result_handler.add_fault(failure)
      if failure.exception.is_a?(::Spec::Expectations::ExpectationNotMetError)
        @result_handler.fail_single(example.description)
      else
        @result_handler.error_single(example.description)
      end
    end

    def example_pending(behaviour_name, example_name, message)
      @result_handler.add_pending("#{example_name}(#{behaviour_name}): #{message}")
      @result_handler.pending_single(example_name)
    end

    def start_dump
      @result_handler.ending
    end
  end
end
