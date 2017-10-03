Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 14:31:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Sironi, Filippo" <sironi@amazon.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: Expose offset, stride, and VF device ID via
 sysfs
Message-ID: <20171003193114.GE25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
 <1503927530-26076-2-git-send-email-sironi@amazon.de>
 <20170925185523.GF15970@bhelgaas-glaptop.roam.corp.google.com>
 <922D0B9C-4900-4226-9FB3-1BF3EA103708@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <922D0B9C-4900-4226-9FB3-1BF3EA103708@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 07:53:31AM +0000, Sironi, Filippo wrote:
> 
> Hi Bjorn,
> 
> > On 25. Sep 2017, at 20:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > Hi Filippo,
> > 
> > On Mon, Aug 28, 2017 at 03:38:50PM +0200, Filippo Sironi wrote:
> >> +static ssize_t sriov_vf_did_show(struct device *dev,
> >> +				 struct device_attribute *attr,
> >> +				 char *buf)
> >> +{
> >> +	struct pci_dev *pdev = to_pci_dev(dev);
> >> +
> >> +	return sprintf(buf, "%x\n", pdev->sriov->vf_did);
> >> +}
> > 
> > What does the vf_did part look like in sysfs?  Do we have a directory with
> > both "device" and "vf_did" in it?  If so, why do we have both and do we
> > need both?  Could we put the vf_did in the "device" file?
> 
> On my machine:
> 
> /sys/bus/pci/devices/0000:03:00.0# ls -l  # this is the PF
> total 0
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 broken_parity_status
> -r--r--r-- 1 root root    4096 Sep 28 19:41 class
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 config
> -r--r--r-- 1 root root    4096 Sep 28 19:41 consistent_dma_mask_bits
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 d3cold_allowed
> -r--r--r-- 1 root root    4096 Sep 28 19:41 device
> -r--r--r-- 1 root root    4096 Sep 28 19:41 dma_mask_bits
> lrwxrwxrwx 1 root root       0 Sep 28 19:41 driver -> ../../../../bus/pci/drivers/igb
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 driver_override
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 enable
> lrwxrwxrwx 1 root root       0 Sep 28 19:41 firmware_node -> ../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:4b/device:4c
> -r--r--r-- 1 root root    4096 Sep 28 19:41 irq
> -r--r--r-- 1 root root    4096 Sep 28 19:41 local_cpulist
> -r--r--r-- 1 root root    4096 Sep 28 19:41 local_cpus
> -r--r--r-- 1 root root    4096 Sep 28 19:41 modalias
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 msi_bus
> drwxr-xr-x 2 root root       0 Sep 29 09:44 msi_irqs
> drwxr-xr-x 3 root root       0 Sep 28 19:41 net
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 numa_node
> -r--r--r-- 1 root root    4096 Sep 28 19:41 offset  # this is new
> drwxr-xr-x 2 root root       0 Sep 28 19:41 power
> drwxr-xr-x 3 root root       0 Sep 28 19:41 ptp
> --w--w---- 1 root root    4096 Sep 28 19:41 remove
> --w--w---- 1 root root    4096 Sep 28 19:41 rescan
> --w------- 1 root root    4096 Sep 28 19:41 reset
> -r--r--r-- 1 root root    4096 Sep 28 19:41 resource
> -rw------- 1 root root  131072 Sep 28 19:41 resource0
> -rw------- 1 root root 4194304 Sep 28 19:41 resource1
> -rw------- 1 root root      32 Sep 28 19:41 resource2
> -rw------- 1 root root   16384 Sep 28 19:41 resource3
> -r--r--r-- 1 root root    4096 Sep 28 19:41 revision
> -rw-rw-r-- 1 root root    4096 Sep 29 09:44 sriov_numvfs
> -r--r--r-- 1 root root    4096 Sep 28 19:41 sriov_totalvfs
> -r--r--r-- 1 root root    4096 Sep 28 19:41 stride  # this is new
> lrwxrwxrwx 1 root root       0 Sep 28 19:41 subsystem -> ../../../../bus/pci
> -r--r--r-- 1 root root    4096 Sep 28 19:41 subsystem_device
> -r--r--r-- 1 root root    4096 Sep 28 19:41 subsystem_vendor
> -rw-r--r-- 1 root root    4096 Sep 28 19:41 uevent
> -r--r--r-- 1 root root    4096 Sep 28 19:41 vendor
> -r--r--r-- 1 root root    4096 Sep 28 19:41 vf_did  # this is new
> lrwxrwxrwx 1 root root       0 Sep 29 09:44 virtfn0 -> ../0000:03:10.0
> 
> nothing changes on for VFs.
> Then:
> 
> /sys/bus/pci/devices/0000:03:00.0# cat device 
> 0x10c9
> 
> /sys/bus/pci/devices/0000:03:00.0# cat vf_did
> 0x10ca
> 
> Putting the VF device ID in the PF device file would be a change of
> that we expose to userspace.  Something might break.

Oh, sorry, I misunderstood!  I was thinking that you were adding
"vf_did" to the VF directory, not the PF directory.

Then I guess my only issue is that "vf_did" doesn't match the pattern
of other names.  I think "virtfn_device" would give more of a hint and
would match "device" and "subsystem_device".

Bjorn

> vf_did provides a easy way to retrieve the VF device ID without reading
> the PF config (looking up the SR-IOV capability and reading it) or without
> enabling SR-IOV to read for example virtfn0/device.
> 
> Similar considerations (ease of access) apply to offset and stride.
> 
> 
> >> static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
> >> 					    struct device_attribute *attr,
> >> 					    char *buf)
> >> @@ -676,6 +703,9 @@ static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> >> static struct device_attribute sriov_numvfs_attr =
> >> 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
> >> 		       sriov_numvfs_show, sriov_numvfs_store);
> >> +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> >> +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> >> +static struct device_attribute sriov_vf_did_attr = __ATTR_RO(sriov_vf_did);
> >> static struct device_attribute sriov_drivers_autoprobe_attr =
> >> 		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
> >> 		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> >> @@ -1744,6 +1774,9 @@ static struct attribute_group pci_dev_hp_attr_group = {
> >> static struct attribute *sriov_dev_attrs[] = {
> >> 	&sriov_totalvfs_attr.attr,
> >> 	&sriov_numvfs_attr.attr,
> >> +	&sriov_offset_attr.attr,
> >> +	&sriov_stride_attr.attr,
> >> +	&sriov_vf_did_attr.attr,
> >> 	&sriov_drivers_autoprobe_attr.attr,
> >> 	NULL,
> >> };
> >> -- 
> >> 2.7.4
> >> 
> > 
> 
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
> 
