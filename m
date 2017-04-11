Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdDKB2w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Apr 2017 21:28:52 -0400
Date: Mon, 10 Apr 2017 20:28:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, Jon Masters <jcm@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Message-ID: <20170411012847.GA15291@bhelgaas-glaptop.roam.corp.google.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jayachandran,

On Mon, Apr 03, 2017 at 01:15:04PM +0000, Jayachandran C wrote:
> The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
> topology is slightly unusual. For a multi-node system, it looks like:
> 
> [node level PCI bridges - one per node]
>     [SoC PCI devices with MSI-X but no IOMMU]
>     [PCI-PCIe "glue" bridges - upto 14, one per real port below]
>         [PCIe real root ports associated with IOMMU and GICv3 ITS]
>             [External PCI devices connected to PCIe links]
> 
> The top two levels of bridges should have introduced aliases since they
> are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
> In the case of external PCIe devices, the "real" root ports are connected
> to the SMMU and the GIC ITS, so PCI-PCIe bridge does not introduce an
> alias. The SoC PCI devices are directly connected to the GIC ITS, so the
> node level bridges do not introduce an alias either.
> 
> To handle this quirk, we mark the real PCIe root ports and node level
> PCI bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
> pci_for_each_dma_alias() works correctly for external PCIe devices and
> SoC PCI devices.
> 
> For the current revision of Cavium ThunderX2, the VendorID and Device ID
> are from Broadcom Vulcan (14e4:90XX).

Can you supply some text here about why we want to apply this patch?
E.g., does it avoid making unnecessary IOMMU mappings, improve
performance, avoid a crash, etc?

> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6736836..564a84a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3958,6 +3958,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
>  
>  /*
> + * The IOMMU and interrupt controller on Broadcom Vulcan/Cavium ThunderX2 are
> + * associated not at the root bus, but at a bridge below. This quirk flag
> + * will ensure that the aliases are identified correctly.
> + */
> +static void quirk_bridge_cavm_thrx2_pcie_root(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
> +				quirk_bridge_cavm_thrx2_pcie_root);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
> +				quirk_bridge_cavm_thrx2_pcie_root);
> +
> +/*
>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>   * class code.  Fix it.
>   */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
