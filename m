Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34877 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbbLPQwM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 11:52:12 -0500
MIME-Version: 1.0
In-Reply-To: <1450262992-77276-1-git-send-email-hare@suse.de>
References: <1450262992-77276-1-git-send-email-hare@suse.de>
Date: Wed, 16 Dec 2015 08:52:10 -0800
Message-ID: <CAKgT0Ucjv0GK02T5jeE79MnR1g57XOr0ZWhGe4ETA15Y3Cnh-g@mail.gmail.com>
Subject: Re: [PATCHv2] pci: Update VPD size with correct length
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 16, 2015 at 2:49 AM, Hannes Reinecke <hare@suse.de> wrote:
> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
> be smaller than that. To figure out the actual size one has to read
> the VPD area until the 'end marker' is reached.
> Trying to read VPD data beyond that marker results in 'interesting'
> effects, from simple read errors to crashing the card. And to make
> matters worse not every PCI card implements this properly, leaving
> us with no 'end' marker or even completely invalid data.
> This path modifies the size of the VPD attribute to the available
> size, and disables the VPD attribute altogether if no valid data
> could be read.
>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Michal Kubecek <mkubecek@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/pci/access.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 59ac36f..ab571a5 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -475,6 +475,48 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
>         .release = pci_vpd_pci22_release,
>  };
>
> +/**
> + * pci_vpd_size - determine actual size of Vital Product Data
> + * @dev:       pci device struct
> + * @old_size:  current assumed size, also maximum allowed size
> + *
> + */
> +static size_t
> +pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
> +{

Instead of passing old_size you could look at just using
PCI_VPD_PCI22_SIZE since currently your only caller will always be
passing that value anyway.

> +       size_t off = 0;
> +       unsigned char header[1+2];      /* 1 byte tag, 2 bytes length */
> +
> +       while (off < old_size && pci_read_vpd(dev, off, 1, header)) {
> +               unsigned char tag;
> +

I'm not sure the use of pci_read_vpd here is correct.  Doesn't it
return a non-zero value on error?  If so you should probably be
checking for this being greater than 0 instead of just non-zero
shouldn't you?

> +               if (header[0] == 0xff) {
> +                       /* Invalid data from VPD read */
> +                       tag = header[0];
> +               } else if (header[0] & 0x80) {
> +                       /* Large Resource Data Type Tag */
> +                       if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
> +                               return off + 1;
> +                       off += 3 + ((header[2] << 8) | header[1]);
> +                       tag = (header[0] & 0x7f);
> +               } else {
> +                       /* Short Resource Data Type Tag */
> +                       off += 1 + (header[0] & 0x07);
> +                       tag = (header[0] & 0x78) >> 3;
> +               }
> +               if (tag == 0x0f)        /* End tag descriptor */
> +                       break;

It might make sense to just use the "return off" here since this is
the only spot that should be returning the offset.

> +               if ((tag != 0x02) && (tag != 0x10) && (tag != 0x11)) {
> +                       dev_dbg(&dev->dev,
> +                               "invalid %s vpd tag %02x at offset %zu.",
> +                               header[0] & 0x80 ? "large" : "short",
> +                               tag, off);
> +                       break;
> +               }

It might be worth while to convert some of the values used in your
conditional checks into a human readable format by converting some of
the magic numbers into defines or placing them in an enum.  Then it
makes it a bit more obvious that if the tag is not a VPD identifier
string descriptor, VPD-R descriptor, or VPD-W descriptor you should be
reporting an error.

> +       }
> +       return off;
> +}
> +

You could probably convert this to "return 0" since there is only one
spot above where you would be returning the offset from.

>  int pci_vpd_pci22_init(struct pci_dev *dev)
>  {
>         struct pci_vpd_pci22 *vpd;
> @@ -497,6 +539,13 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
>         vpd->cap = cap;
>         vpd->busy = false;
>         dev->vpd = &vpd->base;
> +       vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
> +       if (vpd->base.len == 0) {
> +               dev_dbg(&dev->dev, "Disabling VPD access.");
> +               dev->vpd = NULL;
> +               kfree(vpd);
> +               return -ENXIO;
> +       }
>         return 0;
>  }
>

You might want to incorporate the PCI_DEV_FLAGS_VPD_REF_F0 bits that
were added a while ago in order to avoid having to reset the length
each time.  You should only need to call this on function 0 for such a
device so you may want to consider adding a check for that into your
length function.  If that flag is set and we are not testing function
zero you could just default to 0 for the base length.
