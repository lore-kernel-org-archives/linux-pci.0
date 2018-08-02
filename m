Return-Path: <SRS0=22Bc=KR=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=22Bc=KR=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 2 Aug 2018 10:20:36 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
Message-ID: <20180802072036.GN2534@lahna.fi.intel.com>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com>
 <20180801171512.GA28440@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801171512.GA28440@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 07:15:12PM +0200, Lukas Wunner wrote:
> On Wed, Aug 01, 2018 at 07:43:58PM +0300, Mika Westerberg wrote:
> > On Tue, Jul 31, 2018 at 07:50:37AM +0200, Lukas Wunner wrote:
> > > -static void remove_board(struct slot *p_slot)
> > > +static void remove_board(struct slot *p_slot, bool safe_removal)
> > >  {
> > >  	struct controller *ctrl = p_slot->ctrl;
> > >  
> > > -	pciehp_unconfigure_device(p_slot);
> > > +	pciehp_unconfigure_device(p_slot, safe_removal);
> > 
> > Below we turn off power to the slot if it has power controller. Even if
> > we disable slot from sysfs, I think it ends up being inaccessible after
> > power is turned off. I wonder if we should mark the devices disconnected
> > in that case as well?
> > 
> > >  
> > >  	if (POWER_CTRL(ctrl)) {
> > >  		pciehp_power_off_slot(p_slot);
> 
> No, when pciehp_unconfigure_device() returns, the PCI devices below
> the hotplug bridge are unbound and removed from the system.  They're
> gone, so the bit set in their pci_dev struct would no longer be
> accessible anyway.  Unless of course something is holding a ref on
> the pci_dev, but that would seem to be a bug.  (Accessing a device
> that's already removed from the system, that is.)
> 
> Calling pci_dev_set_disconnected() only gives the PCI core and the
> driver bound to the device an indication that's it's inaccessible,
> so any code paths during unbound and PCI device teardown can skip
> accesses.  (Because pci_dev_is_disconnected() is currently scoped
> to the PCI core, the disconnected status can only be queried from
> drivers that live in the PCI core, such as portdrv and all the
> port services drivers.)  After the pci_dev is removed from the
> hierarchy, accessing it seems at least questionable.
> 
> Does this make things clearer?  Shout if it not. :-)

Yes it does. Thank you :)
