Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59718 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbaHYMPk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 08:15:40 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so12893951wgh.18
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 05:15:39 -0700 (PDT)
Date: Mon, 25 Aug 2014 14:16:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140825121602.GB15520@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140822082324.12cb6e93@pluto>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 08:23:24AM +0200, Bruno Prémont wrote:
> On Thu, 21 Aug 2014 23:39:31 -0500 Bjorn Helgaas wrote:
> > On Thu, Aug 21, 2014 at 4:34 PM, Bruno Prémont wrote:
> > 
> > > A second step would then be to tune vgaarb's initial selection.
> > > Bjorn, is it possible to verify which I/O ports are decoded by a PCI
> > > device at the time of adding it to vgaarb? If so, how? I would like to
> > > check for legacy VGA I/O range (0x03B0-0x03DF) and only let vgaarb set
> > > a device as default if that I/O range is decoded by the device.
> > 
> > I don't know of a way.  I'm pretty sure VGA devices are allowed to
> > respond to those legacy addresses even if there's no BAR for them, but
> > I haven't found a spec reference for this.  There is the VGA Enable
> > bit in bridges, of course (PCI Bridge spec, sec 12.1.1.  If the VGA
> > device is behind a bridge that doesn't have the VGA Enable bit set, it
> > probably isn't the default device.
> 
> Those VGA devices behind bridges are the easy ones that vgaarb selects
> properly.
> It's the ones not behind a bridge (integrated graphics) like the intel
> one that cause problems.
> 
> For Andreas's system the discrete nvidia GPU has no I/O enabled
> according to PCI_COMMAND flags while the integrated intel one does have
> them (that's why the Intel GPU is chosen).
> 
> Unfortunately I don't know what makes his system choke at boot time as
> he did not provide logs for the failing case.

Very often when something goes wrong with a kms driver we hang while doing
the initial modeset. Which is all done while holding the console_lock
(because fbdev+vt locking is just insane). You can try to get a closer
look with I915_FBDEV=n which will avoid the console_lock, but which also
won't register the legacy/compat i915 fbdev emulation any more, so greatly
changes boot behaviour.

If that doesn't lead to clues the next approach is to "carefully"
drop&reacquire console_lock at a few "interesting" places to get a few
printks out over netconsole or similar. Or just hack up entire netconsole
loggin infrastructure which bypasses printk and so all the console_lock
insanity.

It's not pretty, I know :(

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
