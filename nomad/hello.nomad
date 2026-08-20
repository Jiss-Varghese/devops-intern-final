job "hello-devops" {

  datacenters = ["dc1"]

  type = "service"

  group "hello" {

    count = 1

    task "hello-devops" {

      driver = "docker"

      config {
        image   = "localhost:5001/hello-devops:latest"
        command = "python"
        args    = ["-u", "-c", "import time; print('Hello,DevOps!', flush=True); time.sleep(3600)"]
 }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
