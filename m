Return-Path: <SRS0=0ccY=BY=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=0ccY=BY=redhat.com=alex.williamson@kernel.org>
Date: Thu, 26 Oct 2017 00:34:07 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-arm-msm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rework error checking in the reset path
Message-ID: <20171026003407.29d3f400@t450s.home>
In-Reply-To: <20171025221046.GA25858@bhelgaas-glaptop.roam.corp.google.com>
References: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
	<20171025134511.GL21840@bhelgaas-glaptop.roam.corp.google.com>
	<20171025232805.163ccaad@t450s.home>
	<20171025221046.GA25858@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 25 Oct 2017 17:10:46 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Oct 25, 2017 at 11:28:05PM +0200, Alex Williamson wrote:
> > On Wed, 25 Oct 2017 08:45:11 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > [+cc Alex]
> > > 
> > > On Mon, Oct 23, 2017 at 05:36:48PM -0400, Sinan Kaya wrote:  
> > > > The return codes from various reset types are not consistent. The code is
> > > > assuming that all reset types will return -ENOTTY when things go wrong.
> > > > Instead of relying on negative error status, let's bail out if the
> > > > operation is successful instead.    
> > > 
> > > I like this (no surprise since I suggested something similar at
> > > http://lkml.kernel.org/r/20171011210057.GU25517@bhelgaas-glaptop.roam.corp.google.com),
> > > but I'd like Alex's opinion before merging it.
> > > 
> > > Previously, we only tried the next reset method if one method failed
> > > with -ENOTTY.  With this patch, we'll try the next reset method if one
> > > method fails for any reason, not just -ENOTTY.  
> > 
> > Hmm, I thought the return codes were pretty consistent.  -ENOTTY means
> > that the reset callback doesn't handle the device, move on.  Many
> > ioctls use the same return code to indicate an unknown ioctl.  This
> > allows us to differentiate success vs error vs unhandled.  In the code
> > below we lose the ability to, for instance, have a device specific
> > reset that returns -EINVAL to prevent the PCI core for triggering
> > further reset mechanisms which might be broken on the device.  So, I
> > don't see that this patch specifically fixes anything, but it does
> > remove what seems like useful functionality...  I'd veto it.  Thanks,  
> 
> I didn't understand the  intention of -EINVAL vs -ENOTTY, so
> that might be a reasonable argument.  The knowledge about mechanisms
> being broken on a specific device seems like it would belong in
> pci_dev_specific_reset() and not really applicable to other methods,
> though.
> 
> But I'm not sure the current usage makes a lot of sense.  The only
> places I found that return an error other than -ENOTTY are
> reset_ivb_igd() and pci_pm_reset().  In reset_ivb_igd(), we return
> -ENOMEM if an ioremap() fails.  That's not a case of "other reset
> mechanisms are broken and we shouldn't try them."

Well, by the fact that we have a device specific reset here, we can
probably deduce that the standard reset mechanisms do not work or are
undesirable for some reason.  Therefore if we cannot perform the
necessary ioremap in this case, it's probably better to stop and return
error.

> pci_pm_reset() returns -EINVAL if the device is not in D0.  Maybe it
> makes sense to not try any other reset methods in that case, but I
> really don't know.

Yeah, that one could probably be re-worked since it's a standard reset
mechanism.  I wonder if the logic here is to avoid a bus reset for a
device that reports NoSoftRst- but is simply in the wrong state for it.
 
> If we leave it as-is, maybe a comment like the following would be
> useful.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f0d68066c726..2c98f309bc8a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4170,6 +4170,13 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  
>  	might_sleep();
>  
> +	/*
> +	 * Reset method return values:
> +	 *   0:		    Device was successfully reset
> +	 *   -ENOTTY:	    Method doesn't support resetting this device;
> +	 *		    try the next method
> +	 *   anything else: Reset failed; don't try any other mechanisms
> +	 */
>  	rc = pci_dev_specific_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;

Yep, that's helpful.  The standard reset mechanisms also use the
-ENOTTY convention, but maybe don't have the same authority to indicate
whether to abort or move on to the next method as device specific
resets.  Thanks,

Alex
