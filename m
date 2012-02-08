Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59972 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2BHVsx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Feb 2012 16:48:53 -0500
Date: Wed, 8 Feb 2012 13:48:51 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] xhci: Fix BIOS handoff failure on some Intel systems.
Message-ID: <20120208214851.GA2669@xanatos>
References: <20120207233118.GA6947@xanatos>
 <201202081611.37097.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202081611.37097.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2012 at 04:11:37PM +0100, Oliver Neukum wrote:
> Am Mittwoch, 8. Februar 2012, 00:31:18 schrieb Sarah Sharp:
> > The downside is that the xHCI BIOS handoff mechanism will fail because
> > memory mapped I/O is not enabled for the disabled PCI device.  Make the
> > xHCI quirk handler call pci_enable_device() to re-enable MMIO, and call
> > pci_disable_device() once it's done with the BIOS handoff.  This will
> > balance the ref counts in the PCI core.  When the xHCI PCI probe is
> > called, usb_hcd_pci_probe() will call pci_enable_device() again.
> > 
> > Also add some debugging to the xHCI quirk failure paths, so we can pin
> > point the problem when a user says their xHCI PCI quirk function fails.
> > 
> > Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> > ---
> > 
> > Hi Oliver,
> > 
> > What about this approach instead?  This means the PCI quirk sequence
> > doesn't change, and the xHCI ports are still switched over before the
> > EHCI PCI probe starts.  With your original patch, the ports could be
> > switched over after the EHCI driver has already started to enumerate
> > devices.
> > 
> > Can you test and make sure this fixes the issue on your test systems?
> 
> I've tested it and it works. Are you sure it is safe to enable a PCI device
> at that point? If so, your patch is better than mine.

Jesse Barnes told me it's fine over IRC, so I'm just going to send this
off, with your Tested-by line.

Thanks,
Sarah Sharp
