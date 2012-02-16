Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34067 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab2BPQy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Feb 2012 11:54:28 -0500
Date: Thu, 16 Feb 2012 08:54:24 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Message-ID: <20120216165424.GA4703@xanatos>
References: <20120209150823.GA5232@xanatos>
 <201202161115.48524.oneukum@suse.de>
 <20120216143321.GA9127@xanatos>
 <201202161548.53556.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202161548.53556.oliver@neukum.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2012 at 03:48:53PM +0100, Oliver Neukum wrote:
> Am Donnerstag, 16. Februar 2012, 15:33:21 schrieb Sarah Sharp:
> > > The BIOS might touch it. Are you really willing to say that there won't
> > > be BIOSes that assume that what they enabled must stay enabled?
> > 
> > Once the xHCI PCI quirk handler runs, we've taken the host controller
> > away from the BIOS with the BIOS/OS semaphore handshake.  (If the BIOS
> > is smart enough to actually handle that.)  Any BIOS that touches the
> > xHCI host controller after that point is just broken.  There is only so
> > much we can do about the BIOS breakage. :)
> 
> What about S3 when the BIOS takes control?

If that was a problem, we would see BIOS issues during S3 with the
current code when a host controller driver wasn't loaded before
suspend.  In fact, I think several distros used to unload the USB
drivers when the user selected suspend from the menu.

When the driver is unloaded, usb_hcd_pci_remove() is called, which will
call pci_disable_device().  If the ref counts were balanced (and I
believe they are), then the PCI device would have been disabled before
S3 for distros that unloaded the USB drivers on suspend.  So the BIOS
would have seen a disabled PCI device for these distros, just like it
would with my patch if the driver never got loaded.

I don't think this is an issue.

Sarah Sharp
