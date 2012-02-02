Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12143 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933030Ab2BBTTV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Feb 2012 14:19:21 -0500
Date: Thu, 2 Feb 2012 11:19:14 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: failure of port switching to XHCI on PantherPoint on boot
Message-ID: <20120202191914.GA16955@xanatos>
References: <201202021558.18427.oneukum@suse.de>
 <20120202172002.GB5711@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120202172002.GB5711@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2012 at 09:20:02AM -0800, Sarah Sharp wrote:
> On Thu, Feb 02, 2012 at 03:58:18PM +0100, Oliver Neukum wrote:
> > Hi,
> > 
> > I am observing a failure to switch ports to XHCI on boot, because the quirk
> > handler bails out at quirk_usb_handoff_xhci():
> > 
> >         if (!mmio_resource_enabled(pdev, 0))
> >                 return;
> > 
> > spefically mmio_enabled(pdev) fails. This seems to be generic because
> > I see it on all my test systems. The switch itself works. My devices go to XHCI
> > after an S4.
> 
> I have no idea why PCI MMIO wouldn't be enabled.  Maybe a PCI or BIOS
> issue?  What does `sudo lspci -vvv` say about the xHCI host controller
> revision, and what BIOS are you using?

In particular, what BIOS settings do you have that relate to USB?  Under
my system's BIOS menu, I see USB options under Advanced -> USB and
Advanced -> PCH-IO Configuration -> USB.

Under the PCH USB options, do you have an option called "xHCI Mode"?  If
so, what is it set to?  If it's set to "Disabled", try setting it to
"Smart Auto" and see if that helps.  Setting it to "Enabled" will cause
the BIOS to put the ports under xHCI, but that's not usually on by
default.  I'm wondering if the BIOS is attempting to disable the xHCI
PCI device for some reason.

The xHCI driver really isn't designed to work with GPIO, it only does
memory mapped I/O right now.

Sarah Sharp
