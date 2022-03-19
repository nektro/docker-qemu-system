FROM alpine:3.15.0
RUN apk add qemu-img
ARG arch=x86_64
RUN apk add qemu-system-${arch}
VOLUME [ "/images" ]
EXPOSE 2222

ENV arch=${arch}
ENV os=alpine
ENV image=/images/${os}.${arch}.qcow2
ENV hdd=/data/hdd.qcow2
ENV cpu=max
ENV mem=2048
CMD set -e; mkdir /data; qemu-img create -f qcow2 -F qcow2 -b ${image} ${hdd}; qemu-system-${arch} -cpu ${cpu} -m ${mem} -hda ${hdd} -net nic -net user,hostfwd=tcp::2222-:22 -nographic
