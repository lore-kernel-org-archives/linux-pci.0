Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12800 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbeB1KAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 05:00:54 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V9 0/3] Add loadable kernel module and power management support
Date: Wed, 28 Feb 2018 15:30:31 +0530
Message-ID: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patches adds loadable kernel module and power management
support to Tegra PCIe host controller driver. irq_set_msi_desc() and
tegra_cpuidle_pcie_irqs_in_use() symbols will be taken care in next
set of patches.

These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
are the verification details.
	- Multiple module insert & remove
	- PCIe device functionality after module insert
	- Free clock, resets, regulators, powergate, iomem and interrupt
	resources after module remove
	- PCIe device functionality after resume from RAM

V2: PM QoS fix is dropped in V2 from this series because the fix is
incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
latency framework")'. Update commit message of few patches in V2.

V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
are dropped based on review comments. These symbols will be addressed in next
series. Took care of few other review comments.

V4: Dropped pci_find_host_bridge() export patch and added new patch to use
bus->sysdata for private data.

V5: Decouple from https://patchwork.ozlabs.org/patch/832053/ and rebase
on top of linux-next

V6: Rebased on lpieralisi/pci/tegra branch

V7: Addressed comments on patch: 6 and 7 in V6
Limiting this series to linux-tegra & linux-pci since patches for other 
subsystem are merged or dropped

V8: Since LKM is not completely implemented changing PCI_TEGRA config
back to bool

V9: Squash patch-3 (PME_Turn_Off patch) on top of patch-2 (LKM patch)
in V8 to have single working LKM patch.

Manikanta Maddireddy (3):
  PCI: tegra: Free resources on probe failure
  PCI: tegra: Add loadable kernel module support
  PCI: tegra: Add power management support

 drivers/pci/host/pci-tegra.c | 354 +++++++++++++++++++++++++++++++++----------
 1 file changed, 278 insertions(+), 76 deletions(-)

-- 
2.1.4
