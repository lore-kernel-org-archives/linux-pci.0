Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Feb 2017 14:54:53 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
In-Reply-To: <20170214192743.GA3869@amd>
Message-ID: <Pine.LNX.4.44L0.1702141452590.1949-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Feb 2017, Pavel Machek wrote:

> On Tue 2017-02-14 18:59:56, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > > > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > > > > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > > > > > but I'll have to double check.
> > > > > 
> > > > > But all the kernel versions worked when the keyboard was plugged into
> > > > > its original USB port?
> > > > 
> > > > Aha. So it looks difference is probably in "where is keyboard plugged
> > > > in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> > > > a while :-(.
> > > > 
> > > > Booting to grub, then hitting ctrl-alt-del is enough to make it work. Ouch.
> > > > 
> > > > It happens with current Linus' tree.
> > > 
> > > v4.10-rc6-feb3 : broken
> > > v4.9 : ok
> > > (v4.6 : ok)
> > 
> > Hmm. It hangs during PCI fixups, and it hangs in v4.10-rc8, too.   
> > 
> > With debug patch below, I get
> > 
> > ...1d.7: PCI fixup... pass 2
> > ...1d.7: PCI fixup... pass 3
> > ...1d.7: PCI fixup... pass 3 done
> > 
> > ...followed by hang. So yes, it looks USB related.
> > 
> > (Sometimes it hangs with some kind backtrace involving secondary CPU
> > startup, unfortunately useful info is off screen at that point).
> 
> Forgot to say, 1d.7 is EHCI controller.
> 
> 00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI
> Controller (rev 01)

So this looks like a problem in the PCI subsystem affecting a USB
controller.

Linus is right; bisection is the best approach now that you know a
reliable trigger.

Alan Stern
