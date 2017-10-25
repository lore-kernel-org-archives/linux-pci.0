Return-Path: <SRS0=0ccY=BY=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=0ccY=BY=redhat.com=alex.williamson@kernel.org>
Date: Wed, 25 Oct 2017 23:28:05 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-arm-msm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rework error checking in the reset path
Message-ID: <20171025232805.163ccaad@t450s.home>
In-Reply-To: <20171025134511.GL21840@bhelgaas-glaptop.roam.corp.google.com>
References: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
	<20171025134511.GL21840@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 25 Oct 2017 08:45:11 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Mon, Oct 23, 2017 at 05:36:48PM -0400, Sinan Kaya wrote:
> > The return codes from various reset types are not consistent. The code is
> > assuming that all reset types will return -ENOTTY when things go wrong.
> > Instead of relying on negative error status, let's bail out if the
> > operation is successful instead.  
> 
> I like this (no surprise since I suggested something similar at
> http://lkml.kernel.org/r/20171011210057.GU25517@bhelgaas-glaptop.roam.corp.google.com),
> but I'd like Alex's opinion before merging it.
> 
> Previously, we only tried the next reset method if one method failed
> with -ENOTTY.  With this patch, we'll try the next reset method if one
> method fails for any reason, not just -ENOTTY.

Hmm, I thought the return codes were pretty consistent.  -ENOTTY means
that the reset callback doesn't handle the device, move on.  Many
ioctls use the same return code to indicate an unknown ioctl.  This
allows us to differentiate success vs error vs unhandled.  In the code
below we lose the ability to, for instance, have a device specific
reset that returns -EINVAL to prevent the PCI core for triggering
further reset mechanisms which might be broken on the device.  So, I
don't see that this patch specifically fixes anything, but it does
remove what seems like useful functionality...  I'd veto it.  Thanks,

Alex
 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > ---
> >  drivers/pci/pci.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 6078dfc..a753e07 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4200,20 +4200,20 @@ int __pci_reset_function_locked(struct pci_dev *dev)
> >  	might_sleep();
> >  
> >  	rc = pci_dev_specific_reset(dev, 0);
> > -	if (rc != -ENOTTY)
> > +	if (!rc)
> >  		return rc;
> >  	if (pcie_has_flr(dev)) {
> >  		pcie_flr(dev);
> >  		return 0;
> >  	}
> >  	rc = pci_af_flr(dev, 0);
> > -	if (rc != -ENOTTY)
> > +	if (!rc)
> >  		return rc;
> >  	rc = pci_pm_reset(dev, 0);
> > -	if (rc != -ENOTTY)
> > +	if (!rc)
> >  		return rc;
> >  	rc = pci_dev_reset_slot_function(dev, 0);
> > -	if (rc != -ENOTTY)
> > +	if (!rc)
> >  		return rc;
> >  	return pci_parent_bus_reset(dev, 0);
> >  }
> > -- 
> > 1.9.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
