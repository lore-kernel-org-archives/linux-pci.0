Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966230AbcAZQ2Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 11:28:24 -0500
Message-ID: <1453825703.26652.47.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: Add DMA alias quirk for mic_x200_dma
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>,
	linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, dwmw2@infradead.org, jroedel@suse.de
Date: Tue, 26 Jan 2016 09:28:23 -0700
In-Reply-To: <1453804310-12946-2-git-send-email-jacek.lawrynowicz@intel.com>
References: <1453804310-12946-1-git-send-email-jacek.lawrynowicz@intel.com>
	 <1453804310-12946-2-git-send-email-jacek.lawrynowicz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-26 at 11:31 +0100, Jacek Lawrynowicz wrote:
> MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
> be added as aliases to the DMA device in order to allow buffer access
> when IOMMU is enabled.
> 
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> ---
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b094061..bc23bc8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3703,6 +3703,21 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>  
>  /*
> + * MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
> + * be added as aliases to the DMA device in order to allow buffer access
> + * when IOMMU is enabled.
> + */
> +static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
> +{
> +	if (iommu_present(pdev->dev.bus)) {

Why do we need this test?  The alias simply goes unused without an
IOMMU, right?

> +		pci_enable_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
> +		pci_enable_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
> +		pci_enable_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
> +
> +/*
>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>   * class code.  Fix it.
>   */

