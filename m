Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965932AbeAJRP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 12:15:29 -0500
Date: Wed, 10 Jan 2018 17:15:21 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 0/7] Add loadable kernel module and power management
 support
Message-ID: <20180110171521.GA26960@e107981-ln.cambridge.arm.com>
References: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515489577-2197-1-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 02:49:30PM +0530, Manikanta Maddireddy wrote:
> This series of patches adds loadable kernel module and power management
> support to Tegra PCIe host controller driver. irq_set_msi_desc() and
> tegra_cpuidle_pcie_irqs_in_use() symbols will be taken care in next
> set of patches.
> 
> These patches are tested on Jetson TK1, TX1 and TX2 platforms, following
> are the verification details.
> 	- Multiple module insert & remove
> 	- PCIe device functionality after module insert
> 	- Free clock, resets, regulators, powergate, iomem and interrupt
> 	resources after module remove
> 	- PCIe device functionality after resume from RAM
> 
> V2: PM QoS fix is dropped in V2 from this series because the fix is
> incorporated in latest 'commit 0759e80b84e3 ("PM / QoS: Fix device resume
> latency framework")'. Update commit message of few patches in V2.
> 
> V3: Patches to export irq_set_msi_desc() and tegra_cpuidle_pcie_irqs_in_use()
> are dropped based on review comments. These symbols will be addressed in next
> series. Took care of few other review comments.
> 
> V4: Dropped pci_find_host_bridge() export patch and added new patch to use
> bus->sysdata for private data.
> 
> V5: Decouple from https://patchwork.ozlabs.org/patch/832053/ and rebase
> on top of linux-next
> 
> Manikanta Maddireddy (7):
>   of: Export of_pci_range_to_resource()
>   PCI: tegra: Use bus->sysdata to store and get host private data
>   PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for Tegra PCIe
>   PCI: tegra: Free resources on probe failure
>   PCI: tegra: Add loadable kernel module support
>   PCI: tegra: Broadcast PME_Turn_Off message before link goes to L2
>   PCI: tegra: Add power management support
> 
>  drivers/of/address.c         |   1 +
>  drivers/pci/host/Kconfig     |   2 +-
>  drivers/pci/host/pci-tegra.c | 333 ++++++++++++++++++++++++++++++++-----------
>  3 files changed, 253 insertions(+), 83 deletions(-)

Can I ask you please to rebase this series against my pci/tegra branch ?

Thanks,
Lorenzo
