Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34805 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932734AbcASUho (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Jan 2016 15:37:44 -0500
Date: Tue, 19 Jan 2016 14:37:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Sander <tim@krieglstein.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Lite-On/Plextor
 M6e/Marvell 88SS9183
Message-ID: <20160119203741.GF14080@localhost>
References: <11003431.x6xHs1WP1I@dabox>
 <20160108204924.GK5354@localhost>
 <1452287726.29599.230.camel@redhat.com>
 <2496384.AM4JqWABTr@dabox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2496384.AM4JqWABTr@dabox>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 01:30:58PM +0100, Tim Sander wrote:
> Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell 88SS9183
> 
> Signed-off-by: Tim Sander <tim@krieglstein.org>

Applied with Alex's ack to pci/iommu for v4.5, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7e32730..40b1dfe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3620,6 +3620,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
>                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
>                          quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c117 */
> +DECLARE_PCI_FIXUP_HEADER(0x1c28, /* Lite-On */
> +                        0x0122, /* Plextor M6E (Marvell 88SS9183)*/
> +                        quirk_dma_func1_alias);
>  
>  /*
>   * Some devices DMA with the wrong devfn, not just the wrong function.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
