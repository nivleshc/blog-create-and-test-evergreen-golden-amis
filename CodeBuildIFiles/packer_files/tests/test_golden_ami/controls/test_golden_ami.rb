title "Check Golden AMI customisations and package installations"

control "Check customisations to motd"

control "Check Chef Inspec installed version is 5.18.14" do
    desc "Validate that Chef Inspec version 5.18.14 is installed for ec2-user"
    describe command('sudo -u ec2-user -i /opt/inspec/bin/inspec --version') do
        its('stdout') { should include('5.18.14') }
    end
end

control "Check Python version 3.8 is installed and its set as default for ec2-user" do
    impact 1.0

    desc "Validate that Python version 3.8 is installed and its set as default for ec2-user"
    describe command('sudo -u ec2-user -i /usr/bin/python3 --version') do
        its('stdout') { should include('Python 3.8') }
    end
end

control "Check Git version 2.37.1 is installed for ec2-user" do
    impact 1.0

    desc "Validate that Git version 2.37.1 is installed for ec2-user"
    describe command('sudo -u ec2-user -i git --version') do
        its('stdout') { should include('git version 2.37.1') }
    end
end

control "Check Ansible 2.9 is installed for ec2-user" do
    impact 1.0

    desc "Validate that Ansible 2.9 is installed for ec2-user"
    describe command('sudo -u ec2-user -i ansible --version') do
        its('stdout') { should include('ansible 2.9.23') }
    end
end

control "Check Java Openjdk 11 is installed for ec2-user" do
    impact 1.0

    desc "Validate that Java Openjdk 11 is installed for ec2-user"
    describe command('sudo -u ec2-user -i java --version') do
        its('stdout') { should include('openjdk 11.0') }
    end
end