Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbcAORDi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 12:03:38 -0500
Message-ID: <1452877417.14628.144.camel@redhat.com>
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Lite-On/Plextor
 M6e/Marvell 88SS9183
From: Alex Williamson <alex.williamson@redhat.com>
To: Tim Sander <tim@krieglstein.org>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Date: Fri, 15 Jan 2016 10:03:37 -0700
In-Reply-To: <2496384.AM4JqWABTr@dabox>
References: <11003431.x6xHs1WP1I@dabox> <20160108204924.GK5354@localhost>
	 <1452287726.29599.230.camel@redhat.com> <2496384.AM4JqWABTr@dabox>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-01-15 at 13:30 +0100, Tim Sander wrote:
> Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell
> 88SS9183
> 
> Signed-off-by: Tim Sander <tim@krieglstein.org>
> ---

Acked-by: Alex Williamson <alex.williamson@redhat.com>

>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7e32730..40b1dfe 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3620,6 +3620,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI,
> 0x0642,
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
>                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
>                          quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c117 */
> +DECLARE_PCI_FIXUP_HEADER(0x1c28, /* Lite-On */
> +                        0x0122, /* Plextor M6E (Marvell 88SS9183)*/
> +                        quirk_dma_func1_alias);
>  
>  /*
>   * Some devices DMA with the wrong devfn, not just the wrong
> function.

