Return-Path: <SRS0=oEwl=BH=amazon.com=prvs=44771f684=sironi@kernel.org>
Return-Path: <SRS0=oEwl=BH=amazon.com=prvs=44771f684=sironi@kernel.org>
From: Filippo Sironi <sironi@amazon.de>
To: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH v2] pci: Expose offset, stride, and VF device ID via sysfs
Date: Mon,  9 Oct 2017 01:09:10 +0200
Message-Id: <1507504151-16179-1-git-send-email-sironi@amazon.de>
In-Reply-To: <1503927530-26076-1-git-send-email-sironi@amazon.de>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
List-ID: <linux-pci.vger.kernel.org>

Testing done:

$ ls -l /sys/bus/pci/devices/0000\:03\:00.0/
total 0
-rw-r--r-- 1 root root    4096 Oct  9 00:48 broken_parity_status
-r--r--r-- 1 root root    4096 Oct  9 00:48 class
-rw-r--r-- 1 root root    4096 Oct  9 00:46 config
-r--r--r-- 1 root root    4096 Oct  9 00:48 consistent_dma_mask_bits
-r--r--r-- 1 root root    4096 Oct  9 00:48 current_link_speed
-r--r--r-- 1 root root    4096 Oct  9 00:48 current_link_width
-rw-r--r-- 1 root root    4096 Oct  9 00:48 d3cold_allowed
-r--r--r-- 1 root root    4096 Oct  9 00:46 device
-r--r--r-- 1 root root    4096 Oct  9 00:48 dma_mask_bits
lrwxrwxrwx 1 root root       0 Oct  9 00:46 driver -> ../../../../bus/pci/drivers/igb
-rw-r--r-- 1 root root    4096 Oct  9 00:48 driver_override
-rw-r--r-- 1 root root    4096 Oct  9 00:48 enable
lrwxrwxrwx 1 root root       0 Oct  9 00:48 firmware_node -> ../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:4b/device:4c
-r--r--r-- 1 root root    4096 Oct  9 00:46 irq
-r--r--r-- 1 root root    4096 Oct  9 00:48 local_cpulist
-r--r--r-- 1 root root    4096 Oct  9 00:48 local_cpus
-r--r--r-- 1 root root    4096 Oct  9 00:48 max_link_speed
-r--r--r-- 1 root root    4096 Oct  9 00:48 max_link_width
-r--r--r-- 1 root root    4096 Oct  9 00:48 modalias
-rw-r--r-- 1 root root    4096 Oct  9 00:48 msi_bus
drwxr-xr-x 2 root root       0 Oct  9 00:48 msi_irqs
drwxr-xr-x 3 root root       0 Oct  9 00:46 net
-rw-r--r-- 1 root root    4096 Oct  9 00:48 numa_node
drwxr-xr-x 2 root root       0 Oct  9 00:48 power
drwxr-xr-x 3 root root       0 Oct  9 00:46 ptp
--w--w---- 1 root root    4096 Oct  9 00:48 remove
--w--w---- 1 root root    4096 Oct  9 00:48 rescan
--w------- 1 root root    4096 Oct  9 00:48 reset
-r--r--r-- 1 root root    4096 Oct  9 00:46 resource
-rw------- 1 root root  131072 Oct  9 00:48 resource0
-rw------- 1 root root 4194304 Oct  9 00:48 resource1
-rw------- 1 root root      32 Oct  9 00:48 resource2
-rw------- 1 root root   16384 Oct  9 00:48 resource3
-r--r--r-- 1 root root    4096 Oct  9 00:48 revision
-rw-rw-r-- 1 root root    4096 Oct  9 00:48 sriov_drivers_autoprobe
-rw-rw-r-- 1 root root    4096 Oct  9 00:48 sriov_numvfs
-r--r--r-- 1 root root    4096 Oct  9 00:48 sriov_offset
-r--r--r-- 1 root root    4096 Oct  9 00:48 sriov_stride
-r--r--r-- 1 root root    4096 Oct  9 00:48 sriov_totalvfs
-r--r--r-- 1 root root    4096 Oct  9 00:48 sriov_vf_device
lrwxrwxrwx 1 root root       0 Oct  9 00:46 subsystem -> ../../../../bus/pci
-r--r--r-- 1 root root    4096 Oct  9 00:48 subsystem_device
-r--r--r-- 1 root root    4096 Oct  9 00:48 subsystem_vendor
-rw-r--r-- 1 root root    4096 Oct  9 00:46 uevent
-r--r--r-- 1 root root    4096 Oct  9 00:46 vendor
$ cat /sys/bus/pci/devices/0000\:03\:00.0/sriov_offset
128
$ cat /sys/bus/pci/devices/0000\:03\:00.0/sriov_stride
2
$ cat /sys/bus/pci/devices/0000\:03\:00.0/sriov_vf_device 
10ca

Filippo Sironi (1):
  pci: Expose offset, stride, and VF device ID via sysfs

 drivers/pci/pci-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.7.4
