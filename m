Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50272 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbbKXRDh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 12:03:37 -0500
Date: Tue, 24 Nov 2015 11:03:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladis Dronov <vdronov@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix invalid ROM content detection in
 pci_get_rom_size()
Message-ID: <20151124170331.GB24819@localhost>
References: <1446812196-3497-1-git-send-email-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446812196-3497-1-git-send-email-vdronov@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vladis,

On Fri, Nov 06, 2015 at 01:16:36PM +0100, Vladis Dronov wrote:
> Make pci_get_rom_size() to check all bytes in the PCI ROM signature
> and issue a warning if the values are not following the standard.

Can you include a reference to the spec, please?

Does this fix a bug?  If so, please include a reference to that as well.

>From reading the patch, I don't think it would change the return value; it
looks like the only change is that we'll emit a warning in some cases where
we previously didn't.  That does seem worthwhile, but it doesn't quite
match your changelog, which implies that we'll check more bytes.

While you're at it, maybe you could include the unexpected values in the
error messages.

Thanks,
  Bjorn

> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  drivers/pci/rom.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index eb0ad53..34f8b2c 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -77,22 +77,17 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
>  	do {
>  		void __iomem *pds;
>  		/* Standard PCI ROMs start out with these bytes 55 AA */
> -		if (readb(image) != 0x55) {
> -			dev_err(&pdev->dev, "Invalid ROM contents\n");
> +		if ((readb(image) != 0x55) || (readb(image + 1) != 0xAA)) {
> +			dev_err(&pdev->dev, "Invalid PCI ROM signature\n");
>  			break;
>  		}
> -		if (readb(image + 1) != 0xAA)
> -			break;
>  		/* get the PCI data structure and check its signature */
>  		pds = image + readw(image + 24);
> -		if (readb(pds) != 'P')
> -			break;
> -		if (readb(pds + 1) != 'C')
> -			break;
> -		if (readb(pds + 2) != 'I')
> -			break;
> -		if (readb(pds + 3) != 'R')
> +		if ((readb(pds) != 'P') || (readb(pds + 1) != 'C') ||
> +			(readb(pds + 2) != 'I') || (readb(pds + 3) != 'R')) {
> +			dev_err(&pdev->dev, "Invalid PCI ROM data signature\n");
>  			break;
> +		}
>  		last_image = readb(pds + 21) & 0x80;
>  		length = readw(pds + 16);
>  		image += length * 512;
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
