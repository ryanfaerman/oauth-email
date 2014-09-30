require 'spec_helper'

shared_examples 'it is a token' do
  it 'is unique' do
    outcomes = []
    10.times do
      outcomes << described_class.call
    end

    expect(outcomes.uniq.length).to eq 10
  end
end

describe OAuthEmail::Token::ClientID do
  it_should_behave_like 'it is a token'

  it 'has length of about 19' do
    expect(described_class.call.length).to be_within(2).of(19)
  end
end

describe OAuthEmail::Token::ClientSecret do
  it_should_behave_like 'it is a token'

  it 'has length of about 19' do
    expect(described_class.call.length).to be_within(2).of(40)
  end
end

describe OAuthEmail::Token::User do
  it_should_behave_like 'it is a token'

  it 'has length of about 19' do
    expect(described_class.call.length).to be_within(2).of(19)
  end
end
