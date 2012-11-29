Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25883 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233Ab2K2AJS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Nov 2012 19:09:18 -0500
Message-ID: <50B6A7AB.5010908@redhat.com>
Date: Wed, 28 Nov 2012 19:09:15 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI,sriov: add documentation on sysfs-based VF control
References: <1354073497-6702-1-git-send-email-ddutile@redhat.com> <CAErSpo4mso26k5pwpBs9ujrX7dZtvd-fxYnU+m712xycwngCvg@mail.gmail.com>
In-Reply-To: <CAErSpo4mso26k5pwpBs9ujrX7dZtvd-fxYnU+m712xycwngCvg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/28/2012 03:18 PM, Bjorn Helgaas wrote:
> On Tue, Nov 27, 2012 at 8:31 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>>   Signed-off: Donald Dutile<ddutile@redhat.com>
>>
>
> Thanks, Don.  I added this to my -next branch, for merging in the v3.8
> merge window.
>
> I removed the trailing underscore from sriov_numvfs_.
>
>
Thanks for pulling it into your 3.8-next branch and the correction!
My apologies for the delay in getting it out to the list
after posting the related code.
- Don

>>   Documentation/ABI/testing/sysfs-bus-pci | 34 +++++++++++++++++++++++
>>   Documentation/PCI/pci-iov-howto.txt     | 48 ++++++++++++++++++++++++++++++---
>>   2 files changed, 78 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index dff1f48..1cb389d 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -222,3 +222,37 @@ Description:
>>                  satisfied too.  Reading this attribute will show the current
>>                  value of d3cold_allowed bit.  Writing this attribute will set
>>                  the value of d3cold_allowed bit.
>> +
>> +What:          /sys/bus/pci/devices/.../sriov_totalvfs
>> +Date:          November 2012
>> +Contact:       Donald Dutile<ddutile@redhat.com>
>> +Description:
>> +               This file appears when a physical PCIe device supports SR-IOV.
>> +               Userspace applications can read this file to determine the
>> +               maximum number of Virtual Functions (VFs) a PCIe physical
>> +               function (PF) can support. Typically, this is the value reported
>> +               in the PF's SR-IOV extended capability structure's TotalVFs
>> +               element.  Drivers have the ability at probe time to reduce the
>> +               value read from this file via the pci_sriov_set_totalvfs()
>> +               function.
>> +
>> +What:          /sys/bus/pci/devices/.../sriov_numvfs_
>> +Date:          November 2012
>> +Contact:       Donald Dutile<ddutile@redhat.com>
>> +Description:
>> +               This file appears when a physical PCIe device supports SR-IOV.
>> +               Userspace applications can read and write to this file to
>> +               determine and control the enablement or disablement of Virtual
>> +               Functions (VFs) on the physical function (PF). A read of this
>> +               file will return the number of VFs that are enabled on this PF.
>> +               A number written to this file will enable the specified
>> +               number of VFs. A userspace application would typically read the
>> +               file and check that the value is zero, and then write the number
>> +               of VFs that should be enabled on the PF; the value written
>> +               should be less than or equal to the value in the sriov_totalvfs
>> +               file. A userspace application wanting to disable the VFs would
>> +               write a zero to this file. The core ensures that valid values
>> +               are written to this file, and returns errors when values are not
>> +               valid.  For example, writing a 2 to this file when sriov_numvfs
>> +               is not 0 and not 2 already will return an error. Writing a 10
>> +               when the value of sriov_totalvfs is 8 will return an error.
>> diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
>> index fc73ef5..c41cf95 100644
>> --- a/Documentation/PCI/pci-iov-howto.txt
>> +++ b/Documentation/PCI/pci-iov-howto.txt
>> @@ -2,6 +2,9 @@
>>                  Copyright (C) 2009 Intel Corporation
>>                      Yu Zhao<yu.zhao@intel.com>
>>
>> +               Update: November 2012
>> +                       -- sysfs-based SRIOV enable-/disable-ment
>> +               Donald Dutile<ddutile@redhat.com>
>>
>>   1. Overview
>>
>> @@ -24,10 +27,21 @@ real existing PCI device.
>>
>>   2.1 How can I enable SR-IOV capability
>>
>> -The device driver (PF driver) will control the enabling and disabling
>> -of the capability via API provided by SR-IOV core. If the hardware
>> -has SR-IOV capability, loading its PF driver would enable it and all
>> -VFs associated with the PF.
>> +Multiple methods are available for SR-IOV enablement.
>> +In the first method, the device driver (PF driver) will control the
>> +enabling and disabling of the capability via API provided by SR-IOV core.
>> +If the hardware has SR-IOV capability, loading its PF driver would
>> +enable it and all VFs associated with the PF.  Some PF drivers require
>> +a module parameter to be set to determine the number of VFs to enable.
>> +In the second method, a write to the sysfs file sriov_numvfs will
>> +enable and disable the VFs associated with a PCIe PF.  This method
>> +enables per-PF, VF enable/disable values versus the first method,
>> +which applies to all PFs of the same device.  Additionally, the
>> +PCI SRIOV core support ensures that enable/disable operations are
>> +valid to reduce duplication in multiple drivers for the same
>> +checks, e.g., check numvfs == 0 if enabling VFs, ensure
>> +numvfs<= totalvfs.
>> +The second method is the recommended method for new/future VF devices.
>>
>>   2.2 How can I use the Virtual Functions
>>
>> @@ -40,13 +54,22 @@ requires device driver that is same as a normal PCI device's.
>>   3.1 SR-IOV API
>>
>>   To enable SR-IOV capability:
>> +(a) For the first method, in the driver:
>>          int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>>          'nr_virtfn' is number of VFs to be enabled.
>> +(b) For the second method, from sysfs:
>> +       echo 'nr_virtfn'>  \
>> +        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
>>
>>   To disable SR-IOV capability:
>> +(a) For the first method, in the driver:
>>          void pci_disable_sriov(struct pci_dev *dev);
>> +(b) For the second method, from sysfs:
>> +       echo  0>  \
>> +        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
>>
>>   To notify SR-IOV core of Virtual Function Migration:
>> +(a) In the driver:
>>          irqreturn_t pci_sriov_migration(struct pci_dev *dev);
>>
>>   3.2 Usage example
>> @@ -88,6 +111,22 @@ static void dev_shutdown(struct pci_dev *dev)
>>          ...
>>   }
>>
>> +static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
>> +{
>> +       if (numvfs>  0) {
>> +               ...
>> +               pci_enable_sriov(dev, numvfs);
>> +               ...
>> +               return numvfs;
>> +       }
>> +       if (numvfs == 0) {
>> +               ....
>> +               pci_disable_sriov(dev);
>> +               ...
>> +               return 0;
>> +       }
>> +}
>> +
>>   static struct pci_driver dev_driver = {
>>          .name =         "SR-IOV Physical Function driver",
>>          .id_table =     dev_id_table,
>> @@ -96,4 +135,5 @@ static struct pci_driver dev_driver = {
>>          .suspend =      dev_suspend,
>>          .resume =       dev_resume,
>>          .shutdown =     dev_shutdown,
>> +       .sriov_configure = dev_sriov_configure,
>>   };
>> --
>> 1.7.10.2.552.gaa3bb87
>>

