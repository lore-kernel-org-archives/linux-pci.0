Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34085 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3CRT6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Mar 2013 15:58:54 -0400
Date: Mon, 18 Mar 2013 12:58:53 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled
Message-ID: <20130318195853.GA9063@xanatos>
References: <5142094D.2070305@fold.natur.cuni.cz>
 <20130318170159.GF17414@xanatos>
 <51474CCC.3090802@fold.natur.cuni.cz>
 <20130318182604.GI17414@xanatos>
 <5147625A.7010306@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5147625A.7010306@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 18, 2013 at 07:52:10PM +0100, Martin Mokrejs wrote:
> Sarah Sharp wrote:
> > On Mon, Mar 18, 2013 at 06:20:12PM +0100, Martin Mokrejs wrote:
> >> Hi Sarah,
> >>   in this particular thread, the USB3 socket of the laptop works once
> >> I plugin a device. When I unplug it and insert same or another device it appears
> >> to be dead until I use 'lsusb -vvv'. After that, I see in dmesg the two lines:
> > 
> > Which kernel are you running on?  We had a regression that involved dead
> 
> As the subject says, 3.8.2. I really started last week several different email
> threads, each independent.
> 
> > ports after a USB disconnect in 3.8.  This was was fixed in 3.8.3.  Can
> > you please retest with that kernel version?
> 
> Hmm, will do. What change do you mean exactly?

Commit d79303047f25957a3e00d25cc1eddb82b3ee0f89 "USB: Fix connected
device switch to Inactive state." along with three others.

> BTW, how about this bugfix which just appeared at linux-pci?
> [PATCH] PCI: Remove not needed check in disable aspm link

I understand that you want to try and figure out on your own what bug
you're hitting.  I'm really happy you're enthusiastic about reporting
and testing bug fixes.  However, looking at random bug fix patches when
we don't know the root cause is not very productive.  I would suggest
you read http://www.chiark.greenend.org.uk/~sgtatham/bugs.html,
especially the "I think the tachyon modulation must be wrongly
polarised" section.

We have no hard proof that this is even a PCI bug.  lsusb does cause the
PCI host to wakeup out of D3, which triggers the PME disable messages
you mentioned.  However, lsusb also triggers the USB core to look at the
roothub status registers.  Without further debugging, we can't be sure
if we lost a PCI wakeup from the port status change, or if the xHCI
driver mishandled the USB device disconnect and running lsusb causes the
USB core to notice the connect change.  Let's rule out the most common
case, the xHCI driver, first.

Please, try 3.8.3 first, and if that doesn't help, turn on
CONFIG_USB_DEBUG and CONFIG_USB_XHCI_HCD_DEBUGGING, and send me the
dmesg from the time you first unplug the USB 3.0 device to when you
replug it in and have to run `sudo lsusb -v` to get the device to
appear.

Sarah Sharp
