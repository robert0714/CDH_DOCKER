#!/bin/bash
# centos 7.6

# parcels
sudo mkdir -p /opt/cloudera/parcel-repo/
wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel
wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel.sha256
wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/manifest.json
Sha1sum CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel | awk '{ print $1 }' > CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel.sha
