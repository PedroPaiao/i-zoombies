# awesome_print
begin
  require 'awesome_print'
  AwesomePrint.defaults = {
    indent: -2, # left aligned
    sort_keys: true, # sort hash keys
    # more customization
  }
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => _e
  puts 'no awesome_print :('
end