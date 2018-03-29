require 'spec_helper_acceptance'

describe 'vision_freeipa::master' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        class vision_docker () {}
        class vision_freeipa::images () {}
        class vision_freeipa::master::run () {}

        class { 'vision_freeipa':
         type => 'master',
        }
      FILE

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provision' do
    describe file('/data/ipa/etc/httpd/conf.d/ipa-rewrite.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'RewriteEngine' }
      it { is_expected.to contain 'RewriteRule' }
      it { is_expected.to contain 'RequestHeader' }
    end

    describe file('/data/ipa/ipa-server-install-options') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'unattended' }
      it { is_expected.to contain 'EXAMPLE.COM' }
      it { is_expected.to contain 'dspassword123' }
      it { is_expected.to contain 'adminpassword123' }
    end
  end
end
