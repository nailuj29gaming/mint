module Mint
  class Formatter
    def self.format(file) : String
      formatter = new(Parser.parse(file))
      formatter.format
    end

    def format : String
      body = (
        ast.records +
        ast.providers +
        ast.components +
        ast.modules +
        ast.routes +
        ast.stores +
        ast.suites +
        ast.enums +
        ast.styles +
        ast.comments
      )
        .sort_by!(&.from)
        .map { |node| format node }

      result =
        body
          .join("\n\n")
          .remove_trailing_whitespace + "\n"

      replace_skipped(result)
    end
  end
end
