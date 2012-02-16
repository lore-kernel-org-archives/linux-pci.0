Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50634 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab2BPOd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Feb 2012 09:33:26 -0500
Date: Thu, 16 Feb 2012 06:33:21 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Message-ID: <20120216143321.GA9127@xanatos>
References: <20120209150823.GA5232@xanatos>
 <201202150948.07115.oneukum@suse.de>
 <20120215163807.GA5446@xanatos>
 <201202161115.48524.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202161115.48524.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2012 at 11:15:48AM +0100, Oliver Neukum wrote:
> Am Mittwoch, 15. Februar 2012, 17:38:07 schrieb Sarah Sharp:
> > On Wed, Feb 15, 2012 at 09:48:07AM +0100, Oliver Neukum wrote:
> > > Am Dienstag, 14. Februar 2012, 21:33:11 schrieb Sarah Sharp:
> > > > Hi Oliver,
> > > > 
> > > > Have you gotten a chance to test this patch on your test system?  I'd
> > > > like to get it out, but I want to make sure it fixes your problem.
> > > 
> > > Did I forget to answer? Anyway, yes it works. However it seems a bad idea
> > > to me to unconditionally disable the device, on second thought.
> > 
> > Why?  The USB core will re-enable the device during the PCI probe, so I
> 
> Provided the device is probed. Typically of course it wii be, but
> we cannot assume that the xhci driver will always be loaded.

Sure.  That's why I want to balance the enable/disable calls in the PCI
quirks handler.  If we don't disable the PCI device, and the driver
never gets loaded, then the PCI device will remain enabled.  I'm not
sure if that's a terrible thing, but it does mean the ref count never
goes to zero.

Jesse?

> > don't see the harm in it.  What else might be accessing the PCI device?
> > Obviously the PCI core didn't care if the device was enabled or not
> > pre-probe, or it would have enabled the PCI device itself.
> 
> The BIOS might touch it. Are you really willing to say that there won't
> be BIOSes that assume that what they enabled must stay enabled?

Once the xHCI PCI quirk handler runs, we've taken the host controller
away from the BIOS with the BIOS/OS semaphore handshake.  (If the BIOS
is smart enough to actually handle that.)  Any BIOS that touches the
xHCI host controller after that point is just broken.  There is only so
much we can do about the BIOS breakage. :)

Sarah Sharp
