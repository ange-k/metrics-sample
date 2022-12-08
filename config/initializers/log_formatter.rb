# frozen_string_literal: true

class LogFormatter
  class << self
    def basic(content, type='message')
      {
        type: type,
        content: content
      }
    end

    def athena(data_map, data_label)
      {
        label: data_label
      }.merge(data_map)
    end

    def exception(exception, code='RUNTIME_EXCEPTION')
      {
        exception: exception,
        code: code
      }
    end
  end

end
