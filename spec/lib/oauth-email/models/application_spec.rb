describe OAuthEmail::Application do
  it 'generates the client keypair after create' do
    d = described_class.create(name: 'awesome app', redirect_uri: 'http://foobar')
    puts d.inspect
    expect(d.client_id).not_to be_nil
    expect(d.client_secret).not_to be_nil
  end
end
