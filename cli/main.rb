require "colorize"

module CLI
  class Server < Thor
    desc "start", "boot up app"
    def start
      system "echo 'SPRING_PROFILES=cool gradle bootRun'; sleep 2"
      puts "-- App started!".green
    end

    desc "kill", "kill app"
    def kill
      system "echo 'Stopping app'"
      puts "-- App stopped!".green
    end
  end

  class Main < Thor
    desc "ship", "run all tests and push code"
    def ship
      invoke :test
      invoke Server, :start
      invoke :journeys
      invoke Server, :kill
      invoke :push
    end

    desc "test", "run tests"
    def test
      puts "Running all tests..."
      system "./tests.sh"
      puts "-- Done!".green
    end

    desc "journeys", "run journeys"
    def journeys
      system "./journeys.sh"
    end

    desc "push", "push to git"
    def push
      system "./git.sh"
      puts "-- Shipped!".green
    end

    desc "server", "server subcommands"
    subcommand 'server', ::CLI::Server
  end
end
