Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42078 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab2BPKNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Feb 2012 05:13:19 -0500
From: Oliver Neukum <oneukum@suse.de>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Date: Thu, 16 Feb 2012 11:15:48 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
References: <20120209150823.GA5232@xanatos> <201202150948.07115.oneukum@suse.de> <20120215163807.GA5446@xanatos>
In-Reply-To: <20120215163807.GA5446@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202161115.48524.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, 15. Februar 2012, 17:38:07 schrieb Sarah Sharp:
> On Wed, Feb 15, 2012 at 09:48:07AM +0100, Oliver Neukum wrote:
> > Am Dienstag, 14. Februar 2012, 21:33:11 schrieb Sarah Sharp:
> > > Hi Oliver,
> > > 
> > > Have you gotten a chance to test this patch on your test system?  I'd
> > > like to get it out, but I want to make sure it fixes your problem.
> > 
> > Did I forget to answer? Anyway, yes it works. However it seems a bad idea
> > to me to unconditionally disable the device, on second thought.
> 
> Why?  The USB core will re-enable the device during the PCI probe, so I

Provided the device is probed. Typically of course it wii be, but
we cannot assume that the xhci driver will always be loaded.

> don't see the harm in it.  What else might be accessing the PCI device?
> Obviously the PCI core didn't care if the device was enabled or not
> pre-probe, or it would have enabled the PCI device itself.

The BIOS might touch it. Are you really willing to say that there won't
be BIOSes that assume that what they enabled must stay enabled?

	Regards
		Oliver
