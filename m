Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50201 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750851Ab2BCPQ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2012 10:16:59 -0500
Date: Fri, 3 Feb 2012 10:16:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.de>
cc: linux-usb@vger.kernel.org, <gregkh@linuxfoundation.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, <trenn@suse.de>,
	<linux-pci@vger.kernel.org>, Michal Marek <MMarek@suse.com>
Subject: Re: [PATCH] USB:xhci: fix port switching on PantherPoint
In-Reply-To: <201202031222.43649.oneukum@suse.de>
Message-ID: <Pine.LNX.4.44L0.1202031015360.1598-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Feb 2012, Oliver Neukum wrote:

> From be9bdcf88b2974cfe95c1afea327b46135b65391 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 3 Feb 2012 12:01:12 +0100
> Subject: [PATCH] USB:xhci: fix port switching on PantherPoint
> 
> The quirks of XHCI were called to early so that the
> PCI device hadn't been enabled and the quirk handler bailed out.
> The fix is to call it later.

I don't understand.  How can PCI_FIXUP_FINAL be too late?  And if it 
is, why do all the other BIOS-handover routines work okay?

Alan Stern

