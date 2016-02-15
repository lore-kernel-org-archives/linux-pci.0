Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43374 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbcBOSU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Feb 2016 13:20:29 -0500
Date: Mon, 15 Feb 2016 12:20:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 1/2] PCI: Add PCI device flag
 PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
Message-ID: <20160215182023.GB12641@localhost>
References: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, iommu list]

On Mon, Feb 15, 2016 at 03:35:00AM +0530, Jayachandran C wrote:
> Add a new flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS to indicate bridges
> that should not be considered during DMA alias search. This is
> to support hardware (in this case Broadcom Vulcan PCIe subsystem)
> that has internal bridges which have either missing or wrong PCIe
> capabilities.

This needs more explanation, like what exactly is wrong with this
device?  A missing PCIe capability might cause other problems.

What problem does this fix?  Without these patches, do we merely add
aliases that are unnecessary?  Do we crash because something goes
wrong in the pci_pcie_type() switch because of the incorrect
capability?

> Update the function pci_for_each_dma_alias() to skip bridges with
> this flag set.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> 
> This patch is an RFC, if there is a better way to do this, please
> let me know.
> 
> Thanks,
> JC.
> 
>  drivers/pci/search.c | 2 ++
>  include/linux/pci.h  | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a20ce7d..e5296aa 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -55,6 +55,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			continue;
>  
>  		tmp = bus->self;
> +		if (tmp->dev_flags & PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS)
> +			continue;
>  
>  		/*
>  		 * PCIe-to-PCI/X bridges alias transactions from downstream
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 27df4a6..b4d8215 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -182,6 +182,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>  	/* Get VPD from function 0 VPD */
>  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> +	/* Bridge should be ignored for alias search  */
> +	PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS = (__force pci_dev_flags_t) (1 << 9),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
