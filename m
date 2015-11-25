Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55711 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbbKYRSA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Nov 2015 12:18:00 -0500
Date: Wed, 25 Nov 2015 11:17:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Update VPD size with correct length
Message-ID: <20151125171756.GD1380@localhost>
References: <1445591396-95395-1-git-send-email-hare@suse.de>
 <562AD631.3040603@gmail.com>
 <562C4DCA.6070502@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562C4DCA.6070502@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hannes,

On Sun, Oct 25, 2015 at 04:34:34AM +0100, Hannes Reinecke wrote:
> On 10/24/2015 02:52 AM, Alexander Duyck wrote:
> > On 10/23/2015 02:09 AM, Hannes Reinecke wrote:
> >> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
> >> be smaller than that. To figure out the actual size one has to read
> >> the VPD area until the 'end marker' is reached.
> >> Trying to read VPD data beyond that marker results in 'interesting'
> >> effects, from simple read errors to crashing the card.
> >> This path modifies the attribute size to the avialable VPD size.
> >>
> >> Signed-off-by: Hannes Reinecke <hare@suse.de>
> >> ---
> >>   drivers/pci/access.c | 29 +++++++++++++++++++++++++++++
> >>   1 file changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> >> index 6bc9b12..4f8208e 100644
> >> --- a/drivers/pci/access.c
> >> +++ b/drivers/pci/access.c
> >> @@ -409,6 +409,34 @@ static int pci_vpd_f0_dev_check(struct pci_dev *dev)
> >>       return ret;
> >>   }
> >>
> >> +/**
> >> + * pci_vpd_size - determine actual size of Vital Product Data
> >> + * @dev:    pci device struct
> >> + * @old_size:    current assumed size, also maximum allowed size
> >> + *
> >> + */
> >> +size_t
> >> +pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
> >> +{
> >> +    loff_t off = 0;
> >> +    unsigned char header[1+2];    /* 1 byte tag, 2 bytes length */
> >> +
> >> +    while (off < old_size && pci_read_vpd(dev, off, 1, header)) {
> >> +        if (header[0] == 0x78)    /* End tag descriptor */
> >> +            return off + 1;
> >> +        if (header[0] & 0x80) {
> >> +            /* Large Resource Data Type Tag */
> >> +            if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
> >> +                return off + 1;
> >> +            off += 3 + ((header[2] << 8) | header[1]);
> >> +        } else {
> >> +            /* Short Resource Data Type Tag */
> >> +            off += 1 + (header[0] & 0x07);
> >> +        }
> >> +    }
> >> +    return old_size;
> >> +}
> >> +
> > 
> > My understanding is that the end tag can have some data associated with
> > it such as a checksum.  What you may want to look at doing is process
> > long tag and short tag bits first.  Then you could do a mask and compare
> > after and if ((header[0] & ~0x7) == 0x78) then you return off + 1.
> > 
> Ah. Oh. Hmm. Wasn't aware of that one.
> Bjorn?

I don't know.  I took a very quick glance at the PCI 3.0 spec and I
didn't see the description of data associated with an End Tag.  It'd
be nice to have a spec reference for whatever we implement here.

It sounds like this fixes some real problems, and it'd also be nice to
have more specifics about them, e.g., what devices, how to reproduce,
etc.

Bjorn
