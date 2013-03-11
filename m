Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50248 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750923Ab3CKQFS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 12:05:18 -0400
Date: Mon, 11 Mar 2013 12:05:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: 3.8.2: stale pci device info for a previously inserted express
 card
In-Reply-To: <513DFCD4.2070309@fold.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44L0.1303111155380.2246-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Mar 2013, Martin Mokrejs wrote:

> > Did you check to see if there were any hung processes?
> 
> I did not reboot yet. What commands?

Alt-SysRq-W from a VT console.

> > Is this repeatable?  It would be more meaningful to see a kmemleak
> 
> No idea, saw it for the first time. Nobody ever told me whether kmemleak is
> able to report the leak immediately or whether that is some background process
> which is always lagging, by definition. If the latter is true, it could be
> I have meanwhile done something else (popped in or out another card). Until
> I know what to expect I am just lost with what I see logged.

kmemleak is described in the Documentation directory.  As I understand
it, there is a background process which wakes up from time to time and
looks for leaks, and there is a way to ask it to wake up and look
whenever you want.

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
> I am not that skilled but I believe somebody could help me to provide you
> with the current time value in the epoch way to translate two lines
>   comm "kworker/0:1", pid 675, jiffies 4295795189 (age 58365.960s)
>   comm "kworker/0:1", pid 675, jiffies 4295809367 (age 58224.180s)
> into human date. Same for the timestamps in dmesg output.

Those values probably wouldn't mean much.  In fact, I don't see how the 
process's age (58365 seconds) could be larger than the time since 
boot-up (either 9893 or 11735 seconds).

> Well, from the

...
> [ 9893.877224] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> [11735.840095] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
...
> 
> I bet both kmemleaks happened before I ejected the USB card (at about [16849.168366]).

I suspect they happened during the eject at about 8763 -- that's when 
the "HC died" message occurred.

> But why the two kmemleak lines are so much lagging after any previous log lines
> I don't know but I am repeating here myself. The system is 99% idle. What process
> shoudl I be looking for? Or you mean some SysRq magic?

Read Documentation/kmemleak.txt.

Alan Stern

