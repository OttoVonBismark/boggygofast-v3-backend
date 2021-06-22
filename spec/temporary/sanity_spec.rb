# frozen_string_literal: true

require 'rails_helper'

# Temporary test to make sure RSpec is functional.
context 'Tests the sanity' do
  it 'is sane' do
    thing = true

    expect(thing).to be true
  end
end
