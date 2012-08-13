require 'spec_helper'

describe Saddlebag::AssetHost do
  let(:source) { 'image.jpg' }
  let(:request) { mock('Request') }

  after do
    Saddlebag::AssetHost.enabled = nil
    Saddlebag::AssetHost.asset_host = nil
    Saddlebag::AssetHost.secure_asset_host = nil
  end

  context "disabled" do
    before do
      Saddlebag::AssetHost.stub!(:enabled => false)
    end

    it { subject.call.should be_nil }
  end

  context "enabled" do
    before do
      Saddlebag::AssetHost.stub!(
        enabled: true,
        secure_asset_host: "https://secureassets.example.com",
        asset_host: "http://assets%d.example.com"
      )
    end

    it "returns nil when called with no request" do
      subject.call(source).should be_nil
      subject.call(source, nil).should be_nil
    end

    it "returns https host when request is ssl" do
      request.stub!(:ssl? => true)
      subject.call(source, request).should eq("https://secureassets.example.com")
    end

    it "returns computed asset host computed by source hash mod 4" do
      request.stub!(:ssl? => false)
      subject.call(source, request).should =~ %r{http://assets\d.example.com}
    end
  end

  describe "direct settings" do
    before do
      Saddlebag::AssetHost.enabled = true
      Saddlebag::AssetHost.asset_host = "http://assets.example.com"
      Saddlebag::AssetHost.secure_asset_host = "https://secureassets.example.com"
    end

    it { Saddlebag::AssetHost.enabled.should be_true }
    it { Saddlebag::AssetHost.asset_host.should eq('http://assets.example.com') }
    it { Saddlebag::AssetHost.secure_asset_host.should eq('https://secureassets.example.com') }
  end

  describe "settings from block" do
    before do
      Saddlebag::AssetHost.configure do |a|
        a.enabled = true
        a.asset_host = "http://assets.example.com"
        a.secure_asset_host = "https://secureassets.example.com"
      end
    end

    it { Saddlebag::AssetHost.enabled.should be_true }
    it { Saddlebag::AssetHost.asset_host.should eq('http://assets.example.com') }
    it { Saddlebag::AssetHost.secure_asset_host.should eq('https://secureassets.example.com') }
  end

  describe "settings from hash" do
    before do
      Saddlebag::AssetHost.configure({
              enabled: true,
              asset_host: "http://assets.example.com",
              secure_asset_host: "https://secureassets.example.com"
            })
    end

    it { Saddlebag::AssetHost.enabled.should be_true }
    it { Saddlebag::AssetHost.asset_host.should eq('http://assets.example.com') }
    it { Saddlebag::AssetHost.secure_asset_host.should eq('https://secureassets.example.com') }
  end

end