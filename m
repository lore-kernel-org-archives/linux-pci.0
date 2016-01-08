Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1452287726.29599.230.camel@redhat.com>
Subject: Re: [PATCH] PCI: Add quirk for Lite-On IT Corp. / Plextor M6e PCI
 Express
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Tim Sander <tim@krieglstein.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Date: Fri, 08 Jan 2016 14:15:26 -0700
In-Reply-To: <20160108204924.GK5354@localhost>
References: <11003431.x6xHs1WP1I@dabox> <20160108204924.GK5354@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-01-08 at 14:49 -0600, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Mon, Jan 04, 2016 at 05:47:14PM +0100, Tim Sander wrote:
> > Hi
> > 
> > Please consider this patch for the next release. It won't recognize
> > my Plextor
> > M6e PCIE disk without it. Please cc as i am not on the list.
> > 
> > Signed-off-by: Tim Sander <tim@krieglstein.org>
> > 
> > PCI: Add quirk for Lite-On IT Corp. / Plextor M6e PCI Express SSD
> > [Marvell 88SS9183] (rev 14)
> 
> Alex?

Aside from the style issues you've already commented on, I'll give a
thumbs up to quirking this device.  Thanks,

Alex

> Please use a subject line that matches the other similar commits:
> 
>   247de694349c PCI: Add function 1 DMA alias quirk for Marvell 9120
>   c2e0fb966ad8 PCI: Add function 1 DMA alias quirk for HighPoint
> RocketRaid 642L
>   cc346a4714a5 PCI: Add function 1 DMA alias quirk for Marvell
> devices
> 
> > ---
> >  drivers/pci/quirks.c    | 4 ++++
> >  include/linux/pci_ids.h | 3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 7e32730..93ec5a02 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3620,6 +3620,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI,
> > 0x0642,
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
> >                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
> >                          quirk_dma_func1_alias);
> > +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
> 
> Thanks for the link.  There are 126 comments on that bugzilla so far,
> so it'd be nice to have a more specific pointer.  I'm guessing 117
> might be the relevant one, so:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=42679#c117
> 
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
> > +                        PCI_DEVICE_ID_PLEXTOR_M6E,
> > +                        quirk_dma_func1_alias);
> >  
> >  /*
> >   * Some devices DMA with the wrong devfn, not just the wrong
> > function.
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index d9ba49c..01d8041 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2501,6 +2501,9 @@
> >  
> >  #define PCI_VENDOR_ID_ASMEDIA          0x1b21
> >  
> > +#define PCI_VENDOR_ID_LITE_ON          0x1c28
> > +#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
> 
> Since these constants are only used in one place, don't add them to
> pci_ids.h (see comment at the top of this file).  Just use the hex
> constants directly in the quirk and include the vendor/device names
> in
> the comment.
> 
> >  #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
> >  
