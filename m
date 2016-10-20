Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Thu, 20 Oct 2016 12:01:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Pierre de Villemereuil <flyos@mailoo.org>,
	Oliver Neukum <oneukum@suse.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Message-ID: <20161020100146.GA3319@wunner.de>
References: <20161008103140.GA7725@wunner.de>
 <Pine.LNX.4.44L0.1610111117040.1827-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1610111117040.1827-100000@iolanthe.rowland.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 11, 2016 at 11:18:28AM -0400, Alan Stern wrote:
> On Sat, 8 Oct 2016, Lukas Wunner wrote:
> > The PCI core already calls pm_runtime_get_sync() before invoking the
> > ->probe hook of a driver (see local_pci_probe()).  Drivers need to
> > explicitly release a runtime ref to allow their device to suspend.
> > For xhci-pci, this seems to happen in usb_hcd_pci_probe():
> > 
> > 	if (pci_dev_run_wake(dev))
> > 		pm_runtime_put_noidle(&dev->dev);
> > 
> > So you could either modify the if-condition if you want to change the
> > behaviour for XHCI devices only, or if you want to change it in general,
> > add something like this to pci_dev_run_wake():
> > 
> > 	/* PME capable in principle, but not from the intended sleep state */
> > 	if (dev->pme_support && !pci_pme_capable(dev, pci_target_state(dev)))
> > 		return false;
> > 
> > I've briefly looked over the callers of pci_dev_run_wake() and the above
> > seems safe but you should double-check them.
> 
> That seems like a good suggestion.  The patch is below; Pierre, can you 
> test it?  This should remove the need to set the USB autosuspend module 
> parameter to -1.

Alan, how do we proceed with this?  Are you going to submit a patch
(with commit message, tags and all) to linux-pci@ or would you prefer
me to do that?  I just went over the callers of pci_dev_run_wake()
once more and the patch still looks safe to me.

Thanks,

Lukas

> 
> Index: usb-4.x/drivers/pci/pci.c
> ===================================================================
> --- usb-4.x.orig/drivers/pci/pci.c
> +++ usb-4.x/drivers/pci/pci.c
> @@ -2064,6 +2064,10 @@ bool pci_dev_run_wake(struct pci_dev *de
>  	if (!dev->pme_support)
>  		return false;
>  
> +	/* PME-capable in principle, but not from the intended sleep state */
> +	if (!pci_pme_capable(dev, pci_target_state(dev)))
> +		return false;
> +
>  	while (bus->parent) {
>  		struct pci_dev *bridge = bus->self;
>  
