Return-Path: <SRS0=vrCD=X4=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=vrCD=X4=intel.com=keith.busch@kernel.org>
Date: Tue, 13 Dec 2016 18:07:31 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 1/3] pci: Add is_removed state
Message-ID: <20161213230731.GC12113@localhost.localdomain>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-2-git-send-email-keith.busch@intel.com>
 <20161213205614.GA30106@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213205614.GA30106@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 13, 2016 at 02:56:14PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 28, 2016 at 06:58:15PM -0400, Keith Busch wrote:
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 0e49f70..2115d19 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -341,6 +341,7 @@ struct pci_dev {
> >  	unsigned int	multifunction:1;/* Part of multi-function device */
> >  	/* keep track of device state */
> >  	unsigned int	is_added:1;
> > +	unsigned int	is_removed:1;	/* device was surprise removed */
> >  	unsigned int	is_busmaster:1; /* device is busmaster */
> >  	unsigned int	no_msi:1;	/* device may not use msi */
> >  	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
> > @@ -417,6 +418,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
> >  	return (pdev->error_state != pci_channel_io_normal);
> >  }
> >  
> > +static inline int pci_set_removed(struct pci_dev *pdev, void *unused)
> > +{
> > +	pdev->is_removed = 1;
> 
> This makes me slightly worried because this is a bitfield and there's
> no locking.  A concurrent write to some nearby field can corrupt
> things.  It doesn't look *likely*, but it's a lot of work to be
> convinced that this is completely safe, especially since the writer is
> running on behalf of the bridge, and the target is a child of the
> bridge.
> 
> The USB HCD_FLAG_DEAD and HCD_FLAG_HW_ACCESSIBLE flags are somewhat
> similar.  Maybe we can leverage some of that design?

A bit field with atomic accessors sounds good to me. Do you want to
see all the struct pci_dev bit flags converted to that model? If so,
I can send you a prep patch that does that first.
