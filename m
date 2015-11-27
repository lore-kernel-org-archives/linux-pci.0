Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:58678 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbbK0RFS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 12:05:18 -0500
Date: Fri, 27 Nov 2015 12:05:15 -0500 (EST)
From: Vladis Dronov <vdronov@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Message-ID: <910906892.25452827.1448643915256.JavaMail.zimbra@redhat.com>
In-Reply-To: <20151124170331.GB24819@localhost>
References: <1446812196-3497-1-git-send-email-vdronov@redhat.com> <20151124170331.GB24819@localhost>
Subject: Re: [PATCH] PCI: fix invalid ROM content detection in
 pci_get_rom_size()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, Bjorn.

> > Make pci_get_rom_size() to check all bytes in the PCI ROM signature
> > and issue a warning if the values are not following the standard.
>
> Can you include a reference to the spec, please?

I was not able to find publicly available "PCI Firmware Specification
Revision 3.x" doc (only my company's internal one for 3.0), but the related
part is matching one found in "PCI Local Bus Specification v2.2", at
http://www.ics.uci.edu/~harris/ics216/pci/PCI_22.pdf ,page 207, "6.3.1.1.
PCI Expansion ROM Header Format", "6.3.1.2. PCI Data Structure Format":

Offset        Length      Value    Description
0h                1       55h      ROM Signature, byte 1
1h                1       AAh      ROM Signature, byte 2

Offset     Length              Description
0              4               Signature, the string "PCIR"

> Does this fix a bug?  If so, please include a reference to that as well.
>
> From reading the patch, I don't think it would change the return value; it
> looks like the only change is that we'll emit a warning in some cases where
> we previously didn't.  That does seem worthwhile, but it doesn't quite
> match your changelog, which implies that we'll check more bytes.

You're right, there is no bug, my wording is incorrect. The code indeed checks
all signature bytes, it does not just print a warning in some cases. And my
suggested code indeed does not change the return value, it only emits a warning
in cases where it previously didn't.

I believe, this change deserves a patch, and I will alter a changelog wording.

> While you're at it, maybe you could include the unexpected values in the
> error messages.

Yes, I will reply with a patch-v2-which-prints-the-values to this message shortly.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
From: "Bjorn Helgaas" <helgaas@kernel.org>
To: "Vladis Dronov" <vdronov@redhat.com>
Cc: linux-pci@vger.kernel.org
Sent: Tuesday, November 24, 2015 6:03:31 PM
Subject: Re: [PATCH] PCI: fix invalid ROM content detection in pci_get_rom_size()

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
