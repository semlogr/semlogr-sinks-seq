require 'semlogr/sinks/seq'

describe Semlogr::Sinks::Seq do
  it 'has a version number' do
    expect(Semlogr::Sinks::Seq::VERSION).not_to be nil
  end
end
