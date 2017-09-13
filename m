Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbdIMBUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Sep 2017 21:20:02 -0400
Subject: Re: VFIO on ARM64
To: valmiki <valmikibow@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
Date: Wed, 13 Sep 2017 02:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Valmiki,

On 12/09/17 19:01, valmiki wrote:
> Hi, as per VFIO documentation i see that we need to see
> "/sys/bus/pci/devices/0000:06:0d.0/iommu_group" in order to find group
> in which PCI bus is attached.
> But as per drivers/pci/pci-sysfs.c in static struct attribute
> *pci_dev_attrs[], i don't see any such attribute.

This iommu_group attribute is created by
drivers/iommu/iommu.c:iommu_group_add_device. It is a symbolic link to
/sys/kernel/iommu_groups/<group>.

> I tried enabling SMMUv2 driver and SMMU for PCIe node on our SOC, but
> this file doesn't show up and also in /sys/kernel/iommu_group i do not
> see "/sys/kernel/iommu_groups/17/devices/0000:00:1f.00" file, i see only
> PCIe root port device tree node in that group and not individual buses.
> So on ARM64 for showing these paths i.e show specific to each bus, does
> SMMU need any particular confguration (we have SMMUv2) > Do we need any specific kernel configuration ?

I don't think so. If you're able to see the root complex in an IOMMU
group, then the configuration is probably fine. Could you provide a little
more information about your system, for example lspci along with "find
/sys/kernel/iommu_groups/*/devices/*"?

Ideally, each PCIe device will be in its own IOMMU group. So you shouldn't
have each bus in a group, but rather one device per group. Linux puts
multiple devices in a group if the IOMMU cannot properly isolate them. In
general it's not something you want in your system, because all devices in
a group will have the same address space and cannot be passed to a guest
separately.

Thanks,
Jean
