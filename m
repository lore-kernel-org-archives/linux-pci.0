Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47906 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbcFKRZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 11 Jun 2016 13:25:04 -0400
Date: Sat, 11 Jun 2016 12:24:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Handle Broadcom Vulcan DMA alias calculation
 quirk
Message-ID: <20160611172457.GK16462@localhost>
References: <linux-pci@vger.kernel.org>
 <1462700001-30086-2-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462700001-30086-2-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 08, 2016 at 03:03:21PM +0530, Jayachandran C wrote:
> The Broadcom Vulcan PCI topology is slightly unusual, for a multi-node
> system, it looks like:
> 
>  [bus 0]
>      |
>      +--[node 0 PCI bridge 0.0.0]
>      |           |
>      |        [bus 1]
>      |           +---[SoC PCI devices 1.4.x, 1.5.x] ........
>      |           +---[Glue bridges    1.a.x, 1.b.x]         \
>      |                    |                        .....{node 0 GIC ITS}
>      |                    |                       /
>      |                    +----[SoC PCIe controller root ports]
>      |                                |         \...... {SMMUv3 0..3}
>      |                                |
>      |                                +---- [external PCI devices]
>      +- [node 1 PCI bridge 0.0.1]
>      |           |
>      |        [bus n - similar to bus 1 above]
>      ...
> 
> The for_each_dma_alias call for external PCI devices should not go
> beyond the PCIe controllers where the SMMU and ITS is associated, going
> further above to the glue bridges or the node bridges will find aliases
> which are not valid. For internal devices, the association is at the
> node level bridge and the alias search should not go further.

I like the line of reasoning that we should not iterate higher in the
hierarchy than where the translation hardware is attached.  That seems
like a reasonable thing in general, not just for this hardware.

Is there some generic way to learn where the translation hardware is
attached?  If there is, we could make pci_for_each_dma_alias() use
that information, and maybe we could solve the problem for other
systems as well as for Vulcan.

> To handle this quirk, we mark the SoC PCIe bridges and node PCI bridge
> with flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT so that the alias and RID
> calculations are correct.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8e67802..62664b5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3734,6 +3734,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>  
>  /*
> + * The IOMMU and interrupt controller of Broadcom vulcan are associated
> + * not at the root bus, but at a bridge below. The DMA alias search should
> + * not go above the bridge at which the association exists.
> + */
> +static void quirk_bridge_brcm_vulcan_pcie_root(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_ROOT;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
> +				quirk_bridge_brcm_vulcan_pcie_root);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
> +				quirk_bridge_brcm_vulcan_pcie_root);
> +
> +/*
>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>   * class code.  Fix it.
>   */
> -- 
> 1.9.1
> 
