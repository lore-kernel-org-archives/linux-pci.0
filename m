Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbeCFR6p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Mar 2018 12:58:45 -0500
Date: Tue, 6 Mar 2018 17:58:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V9 0/3] Add loadable kernel module and power management
 support
Message-ID: <20180306175838.GA2926@e107981-ln.cambridge.arm.com>
References: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 03:30:31PM +0530, Manikanta Maddireddy wrote:
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
> V6: Rebased on lpieralisi/pci/tegra branch
> 
> V7: Addressed comments on patch: 6 and 7 in V6
> Limiting this series to linux-tegra & linux-pci since patches for other 
> subsystem are merged or dropped
> 
> V8: Since LKM is not completely implemented changing PCI_TEGRA config
> back to bool
> 
> V9: Squash patch-3 (PME_Turn_Off patch) on top of patch-2 (LKM patch)
> in V8 to have single working LKM patch.
> 
> Manikanta Maddireddy (3):
>   PCI: tegra: Free resources on probe failure
>   PCI: tegra: Add loadable kernel module support
>   PCI: tegra: Add power management support
> 
>  drivers/pci/host/pci-tegra.c | 354 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 278 insertions(+), 76 deletions(-)

Applied to pci/tegra for v4.17, thanks !

Lorenzo
