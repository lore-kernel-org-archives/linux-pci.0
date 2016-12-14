Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbcLNC7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Dec 2016 21:59:11 -0500
Date: Tue, 13 Dec 2016 20:50:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv4 next 1/3] pci: Add is_removed state
Message-ID: <20161214025007.GA13597@bhelgaas-glaptop.roam.corp.google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-2-git-send-email-keith.busch@intel.com>
 <20161213205614.GA30106@bhelgaas-glaptop.roam.corp.google.com>
 <20161213230731.GC12113@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213230731.GC12113@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alan, Greg]

On Tue, Dec 13, 2016 at 06:07:31PM -0500, Keith Busch wrote:
> On Tue, Dec 13, 2016 at 02:56:14PM -0600, Bjorn Helgaas wrote:
> > On Fri, Oct 28, 2016 at 06:58:15PM -0400, Keith Busch wrote:
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 0e49f70..2115d19 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -341,6 +341,7 @@ struct pci_dev {
> > >  	unsigned int	multifunction:1;/* Part of multi-function device */
> > >  	/* keep track of device state */
> > >  	unsigned int	is_added:1;
> > > +	unsigned int	is_removed:1;	/* device was surprise removed */
> > >  	unsigned int	is_busmaster:1; /* device is busmaster */
> > >  	unsigned int	no_msi:1;	/* device may not use msi */
> > >  	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
> > > @@ -417,6 +418,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> > >  	return (pdev->error_state != pci_channel_io_normal);
> > >  }
> > >  
> > > +static inline int pci_set_removed(struct pci_dev *pdev, void *unused)
> > > +{
> > > +	pdev->is_removed = 1;
> > 
> > This makes me slightly worried because this is a bitfield and there's
> > no locking.  A concurrent write to some nearby field can corrupt
> > things.  It doesn't look *likely*, but it's a lot of work to be
> > convinced that this is completely safe, especially since the writer is
> > running on behalf of the bridge, and the target is a child of the
> > bridge.
> > 
> > The USB HCD_FLAG_DEAD and HCD_FLAG_HW_ACCESSIBLE flags are somewhat
> > similar.  Maybe we can leverage some of that design?
> 
> A bit field with atomic accessors sounds good to me. Do you want to
> see all the struct pci_dev bit flags converted to that model? If so,
> I can send you a prep patch that does that first.

This is still blue-sky, "what if?" thinking on my part.  I was
starting to wonder if we could make something generic that could be
used for your is_removed work and also for the USB stuff.

The USB HCD_FLAG_DEAD is set by usb_hc_died(), which is frequently
used by drivers after an MMIO read returns ~0.  HCD_FLAG_HW_ACCESSIBLE
seems to encode part of the idea of "this device is powered up enough
to respond", which is sort of similar to what PCI does with
dev->current_state.

If there were generic PCI interfaces like pci_dev_died() and a
pci_dev_dead() predicate, I wonder if USB could use them instead of
rolling their own?

Bjorn
