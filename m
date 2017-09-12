Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdILS17 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Sep 2017 14:27:59 -0400
Date: Tue, 12 Sep 2017 12:27:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: valmiki <valmikibow@gmail.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        kevin.tian@intel.com, Auger Eric <eric.auger@redhat.com>
Subject: Re: VFIO on ARM64
Message-ID: <20170912122756.2eb29bb2@t450s.home>
In-Reply-To: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Cc +Eric Auger]

On Tue, 12 Sep 2017 23:31:00 +0530
valmiki <valmikibow@gmail.com> wrote:

> Hi, as per VFIO documentation i see that we need to see 
> "/sys/bus/pci/devices/0000:06:0d.0/iommu_group" in order to find group 
> in which PCI bus is attached.
> But as per drivers/pci/pci-sysfs.c in static struct attribute 
> *pci_dev_attrs[], i don't see any such attribute.
> I tried enabling SMMUv2 driver and SMMU for PCIe node on our SOC, but 
> this file doesn't show up and also in /sys/kernel/iommu_group i do not 
> see "/sys/kernel/iommu_groups/17/devices/0000:00:1f.00" file, i see only 
> PCIe root port device tree node in that group and not individual buses.
> So on ARM64 for showing these paths i.e show specific to each bus, does 
> SMMU need any particular confguration (we have SMMUv2) ?
> Do we need any specific kernel configuration ?
> 
> 
> Regards,
> Valmiki
