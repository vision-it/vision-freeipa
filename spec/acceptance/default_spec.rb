require 'spec_helper_acceptance'

describe 'vision_freeipa' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-EOS

        class vision_docker () {}
        class vision_freeipa::images () {}
        class vision_freeipa::run () {}

        class { 'vision_freeipa': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provision' do
    describe file('/data/ipa/ipa-server-install-options') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'unattended' }
      it { is_expected.to contain 'EXAMPLE.COM' }
      it { is_expected.to contain 'dspassword123' }
      it { is_expected.to contain 'adminpassword123' }
    end
  end
end
