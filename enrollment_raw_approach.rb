module Verifiable
  # classes in this module will have to be created at runtime later based on DB config
  class Enrollment
    attr_accessor :input, :verification_configs, :tasks

    def initialize(enrollment)
      @input = enrollment
      @verification_configs = [
        VYP::VerificationConfig.new({
          label:'national provider identifier',
          type:'rest',
          options: {url:'www.npi.com',method:'GET',input_params:{npi:"{{input.npi}}"},output_processor:{fields_to_extract:[{}]}}}),
        VYP::VerificationConfig.new({
          label:'SSA',
          type:'screen scrapper',
          options:{robot_id:'111',input_params:{npi:"{{input.npi}}",name:"{{input.fname}} {{input.lname}}"},output_processor:{fields_to_extract:[{}]}}})
      ]
      @tasks = []
    end

    def verify
      verification_configs.each{|config|
        puts "Config picked with id #{config.object_id}"
        task = VYP::Task.new(input, config)
        task.save!
        self.tasks << task
      }
    end

    def verification_status
      puts 'No tasks yet' if tasks.length.eql?(0)
      tasks.each{|task|
        puts "--- Task #{task.object_id} status is #{task.status} for input #{self.object_id}"
      }
    end

    def report
      puts 'Print report in XML format'
    end

    def proof
      puts 'Print proof in PDF format'
    end
  end

  class CoC
  end

  class Aadhaar
  end
end

module VYP
  # all code specific to VYP domain
  class Task
    attr_accessor :input, :config, :status
    
    def initialize(input, config)
      @input = input
      @config = config
    end

    def save!
      puts "Persist task in DB with task id = #{self.object_id} & input id = #{input.object_id}"
      @status = 'created'
      process
    end

    private

    def process
      puts 'Start task processing'
      verifier = VerifierFactory.create_verifier(config.type)
      @status = 'in process' if verifier.process(input, config)
    end
  end

  class VerifierFactory
    def self.create_verifier(verification_type)
      puts "Received #{verification_type}"
      case verification_type
      when 'rest'
        Verifier::REST.new
      when 'screen scrapper'
        Verifier::ScreenScrapper.new
      when 'internal db'
        Verifier::InternalDB.new
      end
    end
  end

  # primitive type
  # nested object
  # array of primitive
  # array of object
  class VerificationConfig
    attr_accessor :label, :type, :options

    VALID_TYPES = ['rest', 'screen scrapper', 'internal db']

    def initialize(params)
      unless VALID_TYPES.include?(params[:type])
        raise Errors::InvalidVerificationTypeFound.new params[:type]
      end
      @label = params[:label]
      @type = params[:type]
      @options = params[:options]
    end
  end

  module Errors
    class InvalidVerificationTypeFound < StandardError
      def initialize(type)
        puts "`#{type}` type is not supported. Allowed values are #{VerificationConfig::VALID_TYPES.join(',')}"
      end
    end
  end

  module Verifier
    class REST
      def initialize
        puts 'REST initialized'
      end

      def process(input, config)
      	puts "Processing with config #{config.object_id}"
        true
      end
    end

    class ScreenScrapper
      def initialize
        puts 'SS initialized'
      end

      def process(input, config)
      	puts "Processing with config #{config.object_id}"
        true
      end
    end

    class InternalDB
      def initialize
        puts 'InternalDB initialized'
      end

      def process(input, config)
      	puts "Processing with config #{config.object_id}"
        true
      end
    end
  end
end

e = Verifiable::Enrollment.new({npi:'123', fname:'bhavesh'})
e.verify # starts verification tasks
e.verification_status
e.report # generates configured report in dynamic format which can be also passed at runtime
e.proof # generates configured proof document in dynamic format which can be also passed at runtime

c = Verifiable::CoC.new