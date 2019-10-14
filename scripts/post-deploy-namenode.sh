#!/bin/bash
# centos 7.6

# parcels
sudo mkdir -p /opt/cloudera/parcel-repo/
cd /opt/cloudera/parcel-repo/
if [ ! -f CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel ]; then
	wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel
fi

if [ ! -f CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel.sha256 ]; then
	wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel.sha256
fi

if [ ! -f manifest.json ]; then
	wget -P /opt/cloudera/parcel-repo/ https://archive.cloudera.com/cdh6/6.1.1/parcels/manifest.json
fi

sha1sum CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel | awk '{ print $1 }' > CDH-6.1.1-1.cdh6.1.1.p0.875250-el7.parcel.sha

