Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38696 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdIMRiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2017 13:38:20 -0400
Subject: Re: VFIO on ARM64
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
 <8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>
From: valmiki <valmikibow@gmail.com>
Message-ID: <e8effeac-bdfb-34dd-63e5-eb3fb08fd540@gmail.com>
Date: Wed, 13 Sep 2017 23:08:42 +0530
MIME-Version: 1.0
In-Reply-To: <8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/13/2017 6:50 AM, Jean-Philippe Brucker wrote:
> Hi Valmiki,
>
> On 12/09/17 19:01, valmiki wrote:
>> Hi, as per VFIO documentation i see that we need to see
>> "/sys/bus/pci/devices/0000:06:0d.0/iommu_group" in order to find group
>> in which PCI bus is attached.
>> But as per drivers/pci/pci-sysfs.c in static struct attribute
>> *pci_dev_attrs[], i don't see any such attribute.
>
> This iommu_group attribute is created by
> drivers/iommu/iommu.c:iommu_group_add_device. It is a symbolic link to
> /sys/kernel/iommu_groups/<group>.
>
>> I tried enabling SMMUv2 driver and SMMU for PCIe node on our SOC, but
>> this file doesn't show up and also in /sys/kernel/iommu_group i do not
>> see "/sys/kernel/iommu_groups/17/devices/0000:00:1f.00" file, i see only
>> PCIe root port device tree node in that group and not individual buses.
>> So on ARM64 for showing these paths i.e show specific to each bus, does
>> SMMU need any particular confguration (we have SMMUv2) > Do we need any specific kernel configuration ?
>
> I don't think so. If you're able to see the root complex in an IOMMU
> group, then the configuration is probably fine. Could you provide a little
> more information about your system, for example lspci along with "find
> /sys/kernel/iommu_groups/*/devices/*"?
>
Here is the log:
root@:~# lspci
00:00.0 PCI bridge: Corporation Device a023
01:00.0 Memory controller: Corporation Device a024
root@:~# find /sys/kernel/iommu_groups/*/devices/*
/sys/kernel/iommu_groups/0/devices/ad0c0000.pcie
/sys/kernel/iommu_groups/1/devices/ad0f0000.spi
/sys/kernel/iommu_groups/2/devices/adc70000.sdhci
/sys/kernel/iommu_groups/3/devices/ad9d0000.usb0
root@:~#
> Ideally, each PCIe device will be in its own IOMMU group. So you shouldn't
> have each bus in a group, but rather one device per group. Linux puts
> multiple devices in a group if the IOMMU cannot properly isolate them. In
> general it's not something you want in your system, because all devices in
> a group will have the same address space and cannot be passed to a guest
> separately.
>
So i don't see separate group per pci device.When you say one pci device 
per group, when does smmu creates one group per pci device ?
As per boot log i see that smmu drvier gets probed first and then pcie 
root port driver, so how will smmu know number of pci devices present 
downstream and create a group for each device ?

Regards,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
