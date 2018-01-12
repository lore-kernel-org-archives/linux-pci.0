Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964844AbeALSJO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 13:09:14 -0500
Date: Fri, 12 Jan 2018 18:10:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: cyndis@kapsi.fi, thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 0/7] Add loadable kernel module and power management
 support
Message-ID: <20180112181014.GE26438@red-moon>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 01, 2017 at 02:50:00PM +0530, Manikanta Maddireddy wrote:
> This series of patches add loadable kernel module and power management
> support to Tegra PCIe host controller driver.
> 
> These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
> are the verification details.
> 	- Multiple module insert & remove
> 	- PCIe device functionality after module insert
> 	- Free clock, resets, regulators, powergate, iomem and interrupt
> 	resources after module remove
> 	- PCIe device functionality after resume from RAM
> 
> Tegra PCIe host controller driver is using ioremap_page_range() which is
> not exported. This is switched with devm_ioremap() in the series
> 'https://patchwork.ozlabs.org/project/linux-tegra/list/?series=9907'.
> 
> V2: PM QoS fix is dropped in V2 from this series because the fix is
> incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
> latency framework")'. Update commit message of few patches in V2.
> 
> V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
> are dropped based on review comments. These symbols will be addressed in
> next series. Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe and took care
> of few other review comments.
> 
> Manikanta Maddireddy (7):
>   of: Export of_pci_range_to_resource()
>   PCI: Export pci_find_host_bridge()
>   PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
>   PCI: tegra: Free resources on probe failure
>   PCI: tegra: Add loadable kernel module support
>   PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
>   PCI: tegra: Add power management support
> 
>  drivers/of/address.c         |   1 +
>  drivers/pci/host-bridge.c    |   1 +
>  drivers/pci/host/Kconfig     |   2 +-
>  drivers/pci/host/pci-tegra.c | 331 +++++++++++++++++++++++++++++++++----------

Applied patches 1 and 2 to pci/tegra for v4.16.

Bjorn picked up patch 3, the rest of the series needs
Thierry's ACK.

Thanks !
Lorenzo
