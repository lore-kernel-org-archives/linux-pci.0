Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11769 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab2BIPIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Feb 2012 10:08:25 -0500
Date: Thu, 9 Feb 2012 07:08:23 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] xhci: Fix BIOS handoff failure on some Intel systems.
Message-ID: <20120209150823.GA5232@xanatos>
References: <20120207233118.GA6947@xanatos>
 <201202081611.37097.oneukum@suse.de>
 <20120208214851.GA2669@xanatos>
 <201202090956.22456.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202090956.22456.oliver@neukum.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 09, 2012 at 09:56:22AM +0100, Oliver Neukum wrote:
> Am Mittwoch, 8. Februar 2012, 22:48:51 schrieb Sarah Sharp:
> > > > Can you test and make sure this fixes the issue on your test systems?
> > > 
> > > I've tested it and it works. Are you sure it is safe to enable a PCI device
> > > at that point? If so, your patch is better than mine.
> > 
> > Jesse Barnes told me it's fine over IRC, so I'm just going to send this
> > off, with your Tested-by line.
> 
> Very well, but then consequently you should do it for all HCIs.

Ok, sure. :)  I'll send the patch out later today.

Sarah Sharp
