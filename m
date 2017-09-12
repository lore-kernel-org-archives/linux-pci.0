Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35795 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdILSAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2017 14:00:38 -0400
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kevin.tian@intel.com
From: valmiki <valmikibow@gmail.com>
Subject: VFIO on ARM64
Message-ID: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
Date: Tue, 12 Sep 2017 23:31:00 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, as per VFIO documentation i see that we need to see 
"/sys/bus/pci/devices/0000:06:0d.0/iommu_group" in order to find group 
in which PCI bus is attached.
But as per drivers/pci/pci-sysfs.c in static struct attribute 
*pci_dev_attrs[], i don't see any such attribute.
I tried enabling SMMUv2 driver and SMMU for PCIe node on our SOC, but 
this file doesn't show up and also in /sys/kernel/iommu_group i do not 
see "/sys/kernel/iommu_groups/17/devices/0000:00:1f.00" file, i see only 
PCIe root port device tree node in that group and not individual buses.
So on ARM64 for showing these paths i.e show specific to each bus, does 
SMMU need any particular confguration (we have SMMUv2) ?
Do we need any specific kernel configuration ?


Regards,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
