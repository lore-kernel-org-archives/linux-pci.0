Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33106 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab2BCQTF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Feb 2012 11:19:05 -0500
From: Oliver Neukum <oneukum@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB:xhci: fix port switching on PantherPoint
Date: Fri, 3 Feb 2012 17:21:22 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>
References: <Pine.LNX.4.44L0.1202031015360.1598-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1202031015360.1598-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202031721.22474.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, 3. Februar 2012, 16:16:58 schrieb Alan Stern:
> On Fri, 3 Feb 2012, Oliver Neukum wrote:
> 
> > From be9bdcf88b2974cfe95c1afea327b46135b65391 Mon Sep 17 00:00:00 2001
> > From: Oliver Neukum <oliver@neukum.org>
> > Date: Fri, 3 Feb 2012 12:01:12 +0100
> > Subject: [PATCH] USB:xhci: fix port switching on PantherPoint
> > 
> > The quirks of XHCI were called to early so that the
> > PCI device hadn't been enabled and the quirk handler bailed out.
> > The fix is to call it later.
> 
> I don't understand.  How can PCI_FIXUP_FINAL be too late?  And if it 
> is, why do all the other BIOS-handover routines work okay?

I don't understand it either. I can only report experimental findings.

	Regards
		Oliver
