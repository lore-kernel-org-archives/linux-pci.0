Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Date: Thu, 20 Oct 2016 09:57:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Pierre de Villemereuil <flyos@mailoo.org>,
    Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
In-Reply-To: <20161020100146.GA3319@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1610200956380.1462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 20 Oct 2016, Lukas Wunner wrote:

> On Tue, Oct 11, 2016 at 11:18:28AM -0400, Alan Stern wrote:
> > On Sat, 8 Oct 2016, Lukas Wunner wrote:
> > > The PCI core already calls pm_runtime_get_sync() before invoking the
> > > ->probe hook of a driver (see local_pci_probe()).  Drivers need to
> > > explicitly release a runtime ref to allow their device to suspend.
> > > For xhci-pci, this seems to happen in usb_hcd_pci_probe():
> > > 
> > > 	if (pci_dev_run_wake(dev))
> > > 		pm_runtime_put_noidle(&dev->dev);
> > > 
> > > So you could either modify the if-condition if you want to change the
> > > behaviour for XHCI devices only, or if you want to change it in general,
> > > add something like this to pci_dev_run_wake():
> > > 
> > > 	/* PME capable in principle, but not from the intended sleep state */
> > > 	if (dev->pme_support && !pci_pme_capable(dev, pci_target_state(dev)))
> > > 		return false;
> > > 
> > > I've briefly looked over the callers of pci_dev_run_wake() and the above
> > > seems safe but you should double-check them.
> > 
> > That seems like a good suggestion.  The patch is below; Pierre, can you 
> > test it?  This should remove the need to set the USB autosuspend module 
> > parameter to -1.
> 
> Alan, how do we proceed with this?  Are you going to submit a patch
> (with commit message, tags and all) to linux-pci@ or would you prefer
> me to do that?  I just went over the callers of pci_dev_run_wake()
> once more and the patch still looks safe to me.

Thanks for checking.  I intend to submit it soon; there just hasn't 
been enough free time this week.  :-(

Alan Stern
