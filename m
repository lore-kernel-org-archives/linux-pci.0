Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14982 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab3CKXLN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 19:11:13 -0400
Date: Mon, 11 Mar 2013 16:11:11 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
Message-ID: <20130311231111.GF5412@xanatos>
References: <513DD059.5030604@fold.natur.cuni.cz>
 <Pine.LNX.4.44L0.1303111111220.2246-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1303111111220.2246-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 11, 2013 at 11:26:26AM -0400, Alan Stern wrote:
> On Mon, 11 Mar 2013, Martin Mokrejs wrote:
> 
> > Hi,
> >   I use for my daily work acpiphp to manage express cards in Dell Vostro 3550.
> > I have never seen something like this before and believe this is some new regression
> > in 3.8 series. I had in teh a USB3 card and ejected it. Then I inserted a
> > SATA Sil3132 card but it is not detected and dmesg still ends with last lines
> > added when the USB card was being removed. The funny thing is that lspci reports
> > a mixture of USB-card properties with NEC chips along with Silicon Image eSATA card.
> 
> ...
> 
> When did you run this lspci command?  After inserting the SATA card?
> 
> Did you check to see if there were any hung processes?
> 
> >   I think as a guide you can take the kmemleak report showing that USB did not
> > release its resources completely? Did I screw something with having USB HID generic
> > driver?
> 
> Is this repeatable?  It would be more meaningful to see a kmemleak
> report for immediately after the USB-3 card is removed.  The leak may
> be related to these two lines in the log (they occurred only once):
> 
> [ 8768.825242] xhci_hcd 0000:11:00.0: Abort command ring failed
> [ 8768.825244] xhci_hcd 0000:11:00.0: HC died; cleaning up
> 
> Perhaps cleaning up after a dead controller doesn't deallocate all that
> it should.  Quite possibly this is connected with the fact that on this
> attempt, you removed the USB-3 card while the WD disk drive was plugged
> into it.

I have a note to myself that the xHCI driver leaks memory on an endpoint
stall, but I can't remember exactly where.  It's possible that the
device stalled, and the host died before we could clean it up.  It's
also possible that the memory leak is somewhere else entirely.

Sarah Sharp
