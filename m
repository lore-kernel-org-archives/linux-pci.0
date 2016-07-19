Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57014 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbcGSWPR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jul 2016 18:15:17 -0400
Date: Tue, 19 Jul 2016 17:15:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add DMA alias quirk for Adaptec 3805
Message-ID: <20160719221512.GA20759@localhost>
References: <20160718143209.7169.80117.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160718143209.7169.80117.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 18, 2016 at 08:32:45AM -0600, Alex Williamson wrote:
> Just like the 3405 quirk added in commit d3d2ab43ddae ("PCI: Add DMA
> alias quirk for Adaptec 3405").
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Link: https://www.redhat.com/archives/vfio-users/2016-July/msg00046.html

Applied to pci/virtualization for v4.8, thanks, Alex!

> ---
>  drivers/pci/quirks.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 98b0af0..b69321c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3752,6 +3752,9 @@ static const struct pci_device_id fixed_dma_alias_tbl[] = {
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
>  			 PCI_VENDOR_ID_ADAPTEC2, 0x02bb), /* Adaptec 3405 */
>  	  .driver_data = PCI_DEVFN(1, 0) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
> +			 PCI_VENDOR_ID_ADAPTEC2, 0x02bc), /* Adaptec 3805 */
> +	  .driver_data = PCI_DEVFN(1, 0) },
>  	{ 0 }
>  };
>  
> 
