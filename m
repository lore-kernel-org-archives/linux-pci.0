Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52634 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbbEUOMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 May 2015 10:12:12 -0400
Message-ID: <1432217531.11375.319.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: Add function 1 DMA alias quirk for Marvell 9120
From: Alex Williamson <alex.williamson@redhat.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: iommu@lists.linux-foundation.org,
	linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 21 May 2015 08:12:11 -0600
In-Reply-To: <555DAB52.5030401@linux.intel.com>
References: <1430409392-32479-1-git-send-email-sakari.ailus@iki.fi>
	 <555DAB52.5030401@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-05-21 at 12:54 +0300, Sakari Ailus wrote:
> Ping.
> 
> (Cc Alex.)

You can add my ack, but the linux-pci list is the proper list to get
this upstream.  I suggest resending it there.  Thanks,

Ale

> Sakari Ailus wrote:
> > Marvell 9120 SATA controller has the same issue as a number of others, use
> > the same quirk for this one. The other quirks were added by patch
> > "PCI: Add function 1 DMA alias quirk for Marvell devices"
> > (commit id cc346a4714a59d08c118e8f33fd86692d3563133).
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> > ---
> > Hi,
> > 
> > I just booted the v4.0.1 kernel with intel-iommu enabled and had similar
> > issues as in the original bug report with Marvell 88SE9120 (rev 12). The
> > same quirk appears to work for that one as well.
> > 
> >  drivers/pci/quirks.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 85f247e..d4af5a8 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3572,6 +3572,8 @@ static void quirk_dma_func1_alias(struct pci_dev *dev)
> >   * SKUs this function is not present, making this a ghost requester.
> >   * https://bugzilla.kernel.org/show_bug.cgi?id=42679
> >   */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
> > +			 quirk_dma_func1_alias);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
> >  			 quirk_dma_func1_alias);
> >  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
> > 
> 
> 



