Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17368 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdLHI6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 03:58:39 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <cyndis@kapsi.fi>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 0/7] Add loadable kernel module and power management support
Date: Fri, 8 Dec 2017 14:28:06 +0530
Message-ID: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patches adds loadable kernel module and power management
support to Tegra PCIe host controller driver.

These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
are the verification details.
	- Multiple module insert & remove
	- PCIe device functionality after module insert
	- Free clock, resets, regulators, powergate, iomem and interrupt
	resources after module remove
	- PCIe device functionality after resume from RAM

Tegra PCIe host controller driver is using ioremap_page_range() which is
not exported. This is switched with devm_ioremap() in the series
'https://patchwork.ozlabs.org/project/linux-tegra/list/?series=9907'.

V2: PM QoS fix is dropped in V2 from this series because the fix is
incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
latency framework")'. Update commit message of few patches in V2.

V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
are dropped based on review comments. These symbols will be addressed in next
series. Took care of few other review comments.

V4: Dropped pci_find_host_bridge() export patch and added new patch to use
bus->sysdata for private data.

Manikanta Maddireddy (7):
  of: Export of_pci_range_to_resource()
  PCI: tegra: Use bus->sysdata to store and get host private data
  PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
  PCI: tegra: Free resources on probe failure
  PCI: tegra: Add loadable kernel module support
  PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
  PCI: tegra: Add power management support

 drivers/of/address.c         |   1 +
 drivers/pci/host/Kconfig     |   2 +-
 drivers/pci/host/pci-tegra.c | 344 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 261 insertions(+), 86 deletions(-)

-- 
2.1.4
