module Embulk
  module Input

    class SampleConfigDiff < InputPlugin
      Plugin.register_input("sample_config_diff", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "option1" => config.param("option1", :integer, default: nil),                     # integer, required
          "option2" => config.param("option2", :string, default: "myvalue"),  # string, optional
          "option3" => config.param("option3", :string, default: nil),        # string, optional
          "last_num" => config.param("last_num", :integer, default: nil)
        }

        columns = [
          Column.new(0, "example", :string),
          Column.new(1, "column", :long),
          Column.new(2, "value", :double),
        ]

        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count, &control)
        task_reports = yield(task, columns, count)

#        next_config_diff = {}
#        return next_config_diff
        return task_reports[0]

      end

      # TODO
      # def self.guess(config)
      #   sample_records = [
      #     {"example"=>"a", "column"=>1, "value"=>0.1},
      #     {"example"=>"a", "column"=>2, "value"=>0.2},
      #   ]
      #   columns = Guess::SchemaGuess.from_hash_records(sample_records)
      #   return {"columns" => columns}
      # end

      def init
        # initialization code:
        @option1 = task["option1"]
        @option2 = task["option2"]
        @option3 = task["option3"]
        @last_num = task["last_num"] ||= 0
      end

      def run
        page_builder.add(["example-value", 1, 0.1])
        page_builder.add(["example-value", 2, 0.2])
        page_builder.finish

        task_report = { 'last_num' => @last_num + 1}
        return task_report
      end
    end

  end
end
