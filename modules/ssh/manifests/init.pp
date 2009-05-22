# take care of SSHing into the box as root
# assume package was installed via kick/jumpstart
class ssh {
  $permitrootlogin = 'without-password'

  file { "/etc/ssh/sshd_config" :
    notify  => Service['sshd'],
    content => template("ssh/sshd_config.erb"),
  }

  service { "sshd" :
    ensure => running,
    enable => true
  }
  package { "openssh-server" : ensure => present }


  ssh_authorized_key { "rasputnik@hellooperator.net" :
    user => 'root',
    type => 'ssh-dss',
    key => file('/etc/puppet/data/rasputnik.pubkey.data'),
    ensure => present
  }  
}
