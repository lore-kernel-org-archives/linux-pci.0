Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50223 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751702Ab3CKP01 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 11:26:27 -0400
Date: Mon, 11 Mar 2013 11:26:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
In-Reply-To: <513DD059.5030604@fold.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44L0.1303111111220.2246-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Mar 2013, Martin Mokrejs wrote:

> Hi,
>   I use for my daily work acpiphp to manage express cards in Dell Vostro 3550.
> I have never seen something like this before and believe this is some new regression
> in 3.8 series. I had in teh a USB3 card and ejected it. Then I inserted a
> SATA Sil3132 card but it is not detected and dmesg still ends with last lines
> added when the USB card was being removed. The funny thing is that lspci reports
> a mixture of USB-card properties with NEC chips along with Silicon Image eSATA card.

...

When did you run this lspci command?  After inserting the SATA card?

Did you check to see if there were any hung processes?

>   I think as a guide you can take the kmemleak report showing that USB did not
> release its resources completely? Did I screw something with having USB HID generic
> driver?

Is this repeatable?  It would be more meaningful to see a kmemleak
report for immediately after the USB-3 card is removed.  The leak may
be related to these two lines in the log (they occurred only once):

[ 8768.825242] xhci_hcd 0000:11:00.0: Abort command ring failed
[ 8768.825244] xhci_hcd 0000:11:00.0: HC died; cleaning up

Perhaps cleaning up after a dead controller doesn't deallocate all that
it should.  Quite possibly this is connected with the fact that on this
attempt, you removed the USB-3 card while the WD disk drive was plugged
into it.

Alan Stern

