Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35845 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbbEVOw2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2015 10:52:28 -0400
Received: by igbpi8 with SMTP id pi8so37451368igb.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2015 07:52:28 -0700 (PDT)
Date: Fri, 22 May 2015 09:52:23 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH 1/1] PCI: Add function 1 DMA alias quirk for Marvell 9120
Message-ID: <20150522145223.GH32152@google.com>
References: <1432242218-28414-1-git-send-email-sakari.ailus@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432242218-28414-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 22, 2015 at 12:03:38AM +0300, Sakari Ailus wrote:
> Marvell 9120 SATA controller has the same issue as a number of others, use
> the same quirk for this one. The other quirks were added by patch
> "PCI: Add function 1 DMA alias quirk for Marvell devices"
> (commit id cc346a4714a59d08c118e8f33fd86692d3563133).
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v4.2, thanks!

> ---
> (Resending to linux-pci, was originally sent to linux-iommu list.)
> 
> Hi,
> 
> I recently booted the v4.0.1 kernel with intel-iommu enabled and had similar
> issues as in the original bug report with Marvell 88SE9120 (rev 12). The
> same quirk appears to work for that one as well.
> 
>  drivers/pci/quirks.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 85f247e..d4af5a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3572,6 +3572,8 @@ static void quirk_dma_func1_alias(struct pci_dev *dev)
>   * SKUs this function is not present, making this a ghost requester.
>   * https://bugzilla.kernel.org/show_bug.cgi?id=42679
>   */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
> +			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
>  			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
