Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:42863 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbaHYMjE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 08:39:04 -0400
Date: Mon, 25 Aug 2014 14:39:01 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140825143901.18357759@pluto>
In-Reply-To: <20140825121602.GB15520@phenom.ffwll.local>
References: <20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
	<20140821233435.19a9cffa@neptune.home>
	<CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
	<20140822082324.12cb6e93@pluto>
	<20140825121602.GB15520@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Daniel,

On Mon, 25 Aug 2014 14:16:02 +0200 Daniel Vetter wrote:
> Very often when something goes wrong with a kms driver we hang while doing
> the initial modeset. Which is all done while holding the console_lock
> (because fbdev+vt locking is just insane). You can try to get a closer
> look with I915_FBDEV=n which will avoid the console_lock, but which also
> won't register the legacy/compat i915 fbdev emulation any more, so greatly
> changes boot behaviour.
> 
> If that doesn't lead to clues the next approach is to "carefully"
> drop&reacquire console_lock at a few "interesting" places to get a few
> printks out over netconsole or similar. Or just hack up entire netconsole
> loggin infrastructure which bypasses printk and so all the console_lock
> insanity.

In this case it's not that bad as Andreas could send the logs for all
cases (captured via ssh).

So probably console lock is not held (unless he did have to do
terminal-free ssh which I doubt).
It looks much more as if it's just the output routing that gets weird
on his Mac (or possibly any other dual-GPU MacBook where discrete GPU is
primary). Black screen but alive system :)

See follow-up posts in this thread.

If you have some uncommon or otherwise weird (EFI) multi-GPU systems
around and want to give my patches sent yesterday evening a try, you're
welcome! Some with non-Apple GPU multiplexer would be nice to have
tested as well.


The following part mentioned earlier by Andreas might be of interest to
you though (and my latest patch series should bring the improvement):
> > vga_arbiter_add_pci_device chooses intel simply because it is the
> > first device. Next pci_fixup_video(intel) sees that it is the default
> > device, sets the IORESOURCE_ROM_SHADOW flag and calls
> > vga_set_default_device again. And finally (if the check is removed)
> > pci_fixup_video(nvidia) sees that it owns the framebuffer and sets
> > itself as the default device which allows the system to boot again.
> >
> > Does setting the ROM_SHADOW flag on (possibly) the wrong device have
> > any effect?  
> Yes it does. Removing the line changes a long standing
> i915 0000:00:02.0: Invalid ROM contents
> into a
> i915 0000:00:02.0: BAR 6: can't assign [??? 0x00000000 flags 0x20000000] (bogus alignment).
> 
> The first is logged at KERN_ERR and the second one only at KERN_INFO.
> We are making progress.

Bruno
