Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52096 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754709Ab3CLCZB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 22:25:01 -0400
Date: Mon, 11 Mar 2013 22:25:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
In-Reply-To: <20130311231111.GF5412@xanatos>
Message-ID: <Pine.LNX.4.44L0.1303112222390.10686-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Mar 2013, Sarah Sharp wrote:

> > Is this repeatable?  It would be more meaningful to see a kmemleak
> > report for immediately after the USB-3 card is removed.  The leak may
> > be related to these two lines in the log (they occurred only once):
> > 
> > [ 8768.825242] xhci_hcd 0000:11:00.0: Abort command ring failed
> > [ 8768.825244] xhci_hcd 0000:11:00.0: HC died; cleaning up
> > 
> > Perhaps cleaning up after a dead controller doesn't deallocate all that
> > it should.  Quite possibly this is connected with the fact that on this
> > attempt, you removed the USB-3 card while the WD disk drive was plugged
> > into it.
> 
> I have a note to myself that the xHCI driver leaks memory on an endpoint
> stall, but I can't remember exactly where.  It's possible that the
> device stalled, and the host died before we could clean it up.  It's
> also possible that the memory leak is somewhere else entirely.

I don't think this memory leak has anything to do with endpoints.  
Martin's kmemleak report indicated that the memory was originally
allocated near the start of usb_create_shared_hcd(), which means it was
a whole usb_hcd structure.

Alan Stern

