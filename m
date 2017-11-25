Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11114 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdKYTc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:32:58 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 0/9] Add loadable kernel module and power management support
Date: Sun, 26 Nov 2017 01:02:04 +0530
Message-ID: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patches add loadable kernel module and power management
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
Both these series will complete the loadable module support for Tegra
PCIe host driver.

PM QoS fix is dropped in V2 from this series because the fix is
incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
latency framework")'. Update commit message of few patches in V2.

Manikanta Maddireddy (9):
  genirq: Export irq_set_msi_desc()
  of: Export of_pci_range_to_resource()
  ARM: tegra: Export tegra_cpuidle_pcie_irqs_in_use()
  PCI: Export pci_find_host_bridge()
  PCI: Export pci_flags
  PCI: tegra: free resources on probe failure
  PCI: tegra: Add loadable kernel module support
  PCI: tegra: Broadcast PME_turn_Off message before link goes to L2
  PCI: tegra: Add power management support

 arch/arm/mach-tegra/cpuidle.c |   1 +
 drivers/of/address.c          |   1 +
 drivers/pci/host-bridge.c     |   1 +
 drivers/pci/host/Kconfig      |   2 +-
 drivers/pci/host/pci-tegra.c  | 359 +++++++++++++++++++++++++++++++++---------
 drivers/pci/setup-bus.c       |   1 +
 kernel/irq/chip.c             |   1 +
 7 files changed, 292 insertions(+), 74 deletions(-)

-- 
2.1.4
