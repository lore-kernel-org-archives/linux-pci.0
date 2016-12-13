Return-Path: <SRS0=vrCD=X4=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=vrCD=X4=intel.com=keith.busch@kernel.org>
Date: Tue, 13 Dec 2016 18:01:19 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 3/3] pci/msix: Skip disabling removed devices
Message-ID: <20161213230119.GB12113@localhost.localdomain>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-4-git-send-email-keith.busch@intel.com>
 <20161213211810.GB30106@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213211810.GB30106@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 13, 2016 at 03:18:10PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 28, 2016 at 06:58:17PM -0400, Keith Busch wrote:
> > @@ -1017,6 +1017,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
> >  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
> >  		return;
> >  
> > +	if (dev->is_removed) {
> > +		dev->msix_enabled = 0;
> > +		return;
> > +	}
> > +
> >  	/* Return the device with MSI-X masked as initial states */
> >  	for_each_pci_msi_entry(entry, dev) {
> >  		/* Keep cached states to be restored */
> 
> Do we need the same thing in pci_msi_shutdown()?

We get MSI automatically from the previous two patches since MSI masking
is config access. MSIx is MMIO so it needs to explicitly check the
removed flag to fence off those unnecessary read-modify-writes.
 
> It's too bad we have the data structure maintenance stuff all
> intermingled with the hardware-touching code.  I don't know how they
> could really be disentangled, but it feels a little ad hoc to sprinkle
> is_removed checks in random places where we observe problems.

Yeah, I unfortunately don't see a better way to do it either. It may
look a bit arbitrary considering there's plenty of other places we
could possibly check for removed, but this is the one we observe to
be the highest contributor. I'm mainly interested in NVM-Express where
controllers have dozens to hundreds of vectors, so this is potentially
shaving off another ~100 non-posted commands.

I have heard interest in leveraging this flag for other device drivers,
though, and suspect new usage may come later.
