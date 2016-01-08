Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35985 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756458AbcAHSXH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 13:23:07 -0500
Date: Fri, 8 Jan 2016 12:23:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: eocallaghan@alterapraxis.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers/pci: Avoid iterating through memory outside the
 resource window
Message-ID: <20160108182303.GF5354@localhost>
References: <ebd27b01905fd23bf9144800c1767e88@alterapraxis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ebd27b01905fd23bf9144800c1767e88@alterapraxis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 05, 2016 at 04:12:38AM +1100, eocallaghan@alterapraxis.com wrote:
> If the 'image' pointer has been advanced more than 'size',
> we've already iterated through memory outside the resource window.
> 
> We have zero control over whatever we find in the option ROM,
> if it's even an option ROM and not just an accident of random
> data just happening to look like an option ROM.
> 
> Signed-off-by: Edward O'Callaghan <eocallaghan@alterapraxis.com>

This patch was somehow malformed, but I applied it by hand to pci/resource
for v4.5, thanks, Edward!

> ---
>  drivers/pci/rom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index eb0ad53..45987ad 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -96,6 +96,9 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void
> __iomem *rom, size_t size)
>  		last_image = readb(pds + 21) & 0x80;
>  		length = readw(pds + 16);
>  		image += length * 512;
> +		/* Avoid iterating through memory outside the resource window */
> +		if (image > rom + size)
> +			break;
>  	} while (length && !last_image);
> 
>  	/* never return a size larger than the PCI resource window */
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
