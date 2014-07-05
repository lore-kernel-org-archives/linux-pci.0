Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50795 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbaGEV0c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 17:26:32 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so1522440iec.10
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 14:26:32 -0700 (PDT)
Date: Sat, 5 Jul 2014 15:26:29 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: Add bridge DMA alias quirk for Intel 82801
Message-ID: <20140705212629.GF28871@google.com>
References: <20140623223530.13445.94886.stgit@gimli.home>
 <20140705163143.GB6247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140705163143.GB6247@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg]

On Sat, Jul 05, 2014 at 10:31:43AM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 23, 2014 at 04:36:25PM -0600, Alex Williamson wrote:
> > This bridge sometimes shows up as a root complex device and sometimes
> > as a discrete PCIe-to-PCI bridge.  Testing indicates that in the
> > latter case, we need to enable the PCIe bridge DMA alias quirk.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Reported-by: Milos Kaurin <milos.kaurin@gmail.com>
> > Tested-by: Milos Kaurin <milos.kaurin@gmail.com>
> 
> Applied to for-linus for v3.16, thanks!

Actually, this quirk doesn't make any difference until the iommu changes
are in, so there's no reason to have this in v3.16, is there?  

I saw that Joerg applied those iommu changes to his core branch, which I
assume will be merged for v3.17.  So I'll move this to a pci/iommu branch,
to be merged during the v3.17 merge window.

> > ---
> > 
> >  drivers/pci/quirks.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 78a7df6..460c354 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3405,6 +3405,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080,
> >  DECLARE_PCI_FIXUP_HEADER(0x10e3, 0x8113, quirk_use_pcie_bridge_dma_alias);
> >  /* ITE 8892, https://bugzilla.kernel.org/show_bug.cgi?id=73551 */
> >  DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
> > +/* Intel 82801, https://bugzilla.kernel.org/show_bug.cgi?id=44881#c49 */
> > +DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
> >  
> >  /*
> >   * AMD has indicated that the devices below do not support peer-to-peer
> > 
