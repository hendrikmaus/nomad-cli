# Example

- Create a virtual machine with a Nomad server:

  ```shell
  curl -O https://raw.githubusercontent.com/hashicorp/nomad/master/demo/vagrant/Vagrantfile
  vagrant up
  ```
  
  *Source: https://learn.hashicorp.com/tutorials/nomad/get-started-install?in=nomad/get-started*

- SSH into the virtual machine

  ```shell
  vagrant ssh
  ```

- Launch an agent

  ```shell
  sudo nomad agent -dev -bind 0.0.0.0 -log-level INFO
  ```
  
  > Please mind: this is not a production grade setup!
  
  *Source: https://learn.hashicorp.com/tutorials/nomad/get-started-run?in=nomad/get-started*

- Wait until the server has acquired leadership

- Now test the container image by listing servers:

  ```shell
  docker run --rm --network=host hendrikmaus/nomad-cli:dev-snapshot nomad node status -address=http://127.0.0.1:4646
  ```
