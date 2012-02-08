Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38146 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756216Ab2BHPJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Feb 2012 10:09:17 -0500
From: Oliver Neukum <oneukum@suse.de>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC] xhci: Fix BIOS handoff failure on some Intel systems.
Date: Wed, 8 Feb 2012 16:11:37 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
References: <20120207233118.GA6947@xanatos>
In-Reply-To: <20120207233118.GA6947@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202081611.37097.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, 8. Februar 2012, 00:31:18 schrieb Sarah Sharp:
> The downside is that the xHCI BIOS handoff mechanism will fail because
> memory mapped I/O is not enabled for the disabled PCI device.  Make the
> xHCI quirk handler call pci_enable_device() to re-enable MMIO, and call
> pci_disable_device() once it's done with the BIOS handoff.  This will
> balance the ref counts in the PCI core.  When the xHCI PCI probe is
> called, usb_hcd_pci_probe() will call pci_enable_device() again.
> 
> Also add some debugging to the xHCI quirk failure paths, so we can pin
> point the problem when a user says their xHCI PCI quirk function fails.
> 
> Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> ---
> 
> Hi Oliver,
> 
> What about this approach instead?  This means the PCI quirk sequence
> doesn't change, and the xHCI ports are still switched over before the
> EHCI PCI probe starts.  With your original patch, the ports could be
> switched over after the EHCI driver has already started to enumerate
> devices.
> 
> Can you test and make sure this fixes the issue on your test systems?

I've tested it and it works. Are you sure it is safe to enable a PCI device
at that point? If so, your patch is better than mine.

	Regards
		Oliver
