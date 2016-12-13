Return-Path: <SRS0=GzuL=X4=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=GzuL=X4=wunner.de=lukas@kernel.org>
Date: Wed, 14 Dec 2016 00:54:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 1/3] pci: Add is_removed state
Message-ID: <20161213235433.GA11088@wunner.de>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-2-git-send-email-keith.busch@intel.com>
 <20161213205614.GA30106@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213205614.GA30106@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 13, 2016 at 02:56:14PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 28, 2016 at 06:58:15PM -0400, Keith Busch wrote:
[snip]
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

Back in October I suggested leveraging the error_state field in struct
pci_dev.  That's an enum defined at the top of include/linux/pci.h
with values pci_channel_io_normal, pci_channel_io_frozen and
pci_channel_io_perm_failure.  I suggested adding a removed state.
The benefit is that lots of drivers already check pci_channel_offline()
before accessing a device, so without any further changes they would
treat surprise-removed devices properly.

However Keith responded:
"I'd be happy if we can reuse that, but concerned about overloading
error_state's intended purpose for AER. The conditions under which an
'is_removed' may be set can also create AER events, and the aer driver
overrides the error_state."
(http://www.spinics.net/lists/linux-pci/msg55417.html)

So it would seem to require at least a modification of the AER driver
to not overwrite a pci_channel_io_removed state.

Best regards,

Lukas
