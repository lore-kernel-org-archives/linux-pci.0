Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45443 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab2BCLSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Feb 2012 06:18:06 -0500
From: Oliver Neukum <oneukum@suse.de>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: failure of port switching to XHCI on PantherPoint on boot
Date: Fri, 3 Feb 2012 12:20:18 +0100
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
References: <201202021558.18427.oneukum@suse.de> <20120202172002.GB5711@xanatos> <20120202191914.GA16955@xanatos>
In-Reply-To: <20120202191914.GA16955@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202031220.18448.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 2. Februar 2012, 20:19:14 schrieb Sarah Sharp:
> On Thu, Feb 02, 2012 at 09:20:02AM -0800, Sarah Sharp wrote:
> > On Thu, Feb 02, 2012 at 03:58:18PM +0100, Oliver Neukum wrote:
> > > Hi,
> > > 
> > > I am observing a failure to switch ports to XHCI on boot, because the quirk
> > > handler bails out at quirk_usb_handoff_xhci():
> > > 
> > >         if (!mmio_resource_enabled(pdev, 0))
> > >                 return;
> > > 
> > > spefically mmio_enabled(pdev) fails. This seems to be generic because
> > > I see it on all my test systems. The switch itself works. My devices go to XHCI
> > > after an S4.
> > 
> > I have no idea why PCI MMIO wouldn't be enabled.  Maybe a PCI or BIOS
> > issue?  What does `sudo lspci -vvv` say about the xHCI host controller
> > revision, and what BIOS are you using?
> 
> In particular, what BIOS settings do you have that relate to USB?  Under
> my system's BIOS menu, I see USB options under Advanced -> USB and
> Advanced -> PCH-IO Configuration -> USB.

There is no such setting on this system.

> Under the PCH USB options, do you have an option called "xHCI Mode"?  If
> so, what is it set to?  If it's set to "Disabled", try setting it to
> "Smart Auto" and see if that helps.  Setting it to "Enabled" will cause
> the BIOS to put the ports under xHCI, but that's not usually on by
> default.  I'm wondering if the BIOS is attempting to disable the xHCI
> PCI device for some reason.

The reason is probably old versions of that OS.

> The xHCI driver really isn't designed to work with GPIO, it only does
> memory mapped I/O right now.

Well and this works but only later. Is it possible that the quirk is simply
called too early?. Shifting it later makes it work on my test systems.

	Regards
		Oliver
