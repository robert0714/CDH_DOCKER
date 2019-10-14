# CDH docker

I started this project to be able to set up a simple, working Hadoop environment in minutes and be able recreate the environment without any hassle when I messed up. So I ended up with [Vagrant](http://www.vagrantup.com "Vagrant"):

>Vagrant provides easy to configure, reproducible, and portable work environments built on top of industry-standard technology and controlled by a single consistent workflow to help maximize the productivity and flexibility of you and your team. - [Why Vagrant?](http://docs.vagrantup.com/v2/why-vagrant/index.html "Vagrant Docs: Why Vagrant?")

You can find the code and README at the GitHub repo [hadoop-single-node-vagrant](https://github.com/baswenneker/hadoop-single-node-vagrant).

## For learning Hadoop, below are the hardware requirements:

1. Minimum RAM Per a Node required: 4GB (Suggested: 8GB)
1. Minimum Free Disk Space Per a Node: 25GB
1. Minimum Processor i3 or above
1. Operating System of 64bit (Suggested)



## Clone a new VM from Master box file

```bash
[hadoop-single-node-vagrant]$ vagrant halt gfcdh1
[hadoop-single-node-vagrant]$ vagrant package gfcdh1  --output gfcdh1.box
[hadoop-single-node-vagrant]$ vagrant box add robert-cdh-box gfcdh1.box
```

Now you can create virtual machines from this box by simply giving the name of the box in the Vagrantfile, like

```yaml
config.vm.box = "robert-cdh-box"
```
reference: https://www.sitepoint.com/create-share-vagrant-base-box/
