require 'spec_helper_acceptance'

describe 'vision_freeipa::master' do
  context 'with defaults' do
    it 'idempotentlies run' do
      pp = <<-FILE

        # mock classes
        class vision_gluster::node () {}

        file{ ['/vision', '/vision/data', '/vision/data/swarm']:
          ensure => directory,
        }

        class { 'vision_freeipa':
         type => 'master',
        }
      FILE

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provision' do
    describe file('/vision/data/ipa/etc/httpd/conf.d/ipa-rewrite.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'RewriteEngine' }
      it { is_expected.to contain 'RewriteRule' }
      it { is_expected.to contain 'RequestHeader' }
    end

    describe file('/vision/data/ipa/ipa-server-install-options') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'unattended' }
      it { is_expected.to contain 'EXAMPLE.COM' }
      it { is_expected.to contain 'dspassword123' }
      it { is_expected.to contain 'adminpassword123' }
    end

    describe file('/vision/data/swarm/freeipa-master.yaml') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'managed by Puppet' }
      it { is_expected.to contain 'image: freeipa/freeipa-server:latest' }
      it { is_expected.to contain '389:389' }
      it { is_expected.to contain '636:636' }
      it { is_expected.to contain 'tmpfs' }
      it { is_expected.to contain '/vision/data/ipa:/data' }
      it { is_expected.to contain 'foo=bar' }
      it { is_expected.to contain 'IPA_SERVER_IP=' }
      it { is_expected.to contain 'IPA_SERVER_HOSTNAME=' }
    end
  end
end
