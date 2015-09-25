Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbbIYQSL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Sep 2015 12:18:11 -0400
Message-ID: <1443197890.23936.631.camel@redhat.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 Sep 2015 10:18:10 -0600
In-Reply-To: <20150925143546.GA1017@localhost>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
	 <CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
	 <CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
	 <CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
	 <CAE9FiQWd69=6-UvCWsPOHvnZ96grJyzEt_+WR0-Q3M9wHz69hw@mail.gmail.com>
	 <20150925143546.GA1017@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-09-25 at 09:35 -0500, Bjorn Helgaas wrote:
> On Thu, Sep 24, 2015 at 09:35:20PM -0700, Yinghai Lu wrote:
> > On Thu, Sep 24, 2015 at 12:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > 
> > > Or do we want to keep a white list to say which device should have
> > > ROM bar as mush have, and other is optional to have ?
> > 
> > Subject: [RFC PATCH] PCI: Add pci_dev_need_rom_bar()
> > 
> > Only set that for
> > 1. if BIOS/firmware already set ROM bar.
> > 2. via quirks for some devices.
> > 
> > We assign those needed ROM bar as required
> > and other ROM bars as optional resources.
> 
> I'd rather not have a whitelist if we can avoid it.  We'd be
> continually adding new devices to it, and it makes the system harder
> to understand because there's no consistent rule about how ROMs are
> handled.
> 
> Alex mentioned the idea of ripping the ROM, and I'd like to explore
> that idea a little more.  What if we could temporarily assign space
> for the ROM during enumeration, read the contents, cache the contents
> somewhere, then deallocate the actual BAR space?  We could hang onto
> the cache and give it to anybody who later needs the ROM.
> 
> I know there are probably issues here, but I don't know what they are,
> so I'd like to at least have a conversation about it.

Ok, so for background in the case I mentioned, we can often use the
pci-sysfs rom interface to get a copy of the device ROM, which we then
pass to QEMU and we avoid any access to the physical ROM from the VM.
We can obviously get the ROM from other sources too, but that's not
really relevant here.

If we want to extend this idea into the kernel, creating a buffer that
holds the ROM contents that we access rather than mapping and enabling
the ROM to provide access, we first need to get access to the ROM at
least once.  The simplification here is that we can do this on boot and
we can re-use the space allocated to the standard BARs since we don't
need space for both the ROM and the standard BARs at the same time.  I
think that in the vast majority of cases, we're going to find that the
ROM BAR is smaller than the largest standard MMIO BAR of the device or
at least smaller than the minimum bridge aperture.  This suggests that
we could simply record the BAR values, reprogram them to zero, then
overlap the ROM BAR to the orignal addresses, enable, rip the ROM, then
restore the configuration without needing to adjust any bridge
apertures.

That sounds pretty good, so long as we can consider the ROM to be
perfectly static.  I don't know if anything relies on an in-place update
or if there are ROMs that are less read-only than others.  Maybe it's
safe to assume that or at least safe to assume that if the BIOS didn't
leave room for them, then we can consider them static.  It might be
interesting to strace some of the userspace firmware update programs for
add-in cards to see if they re-read the ROM to determine if it has
changed.

We already sort of do this for VGA ROMs.  When a driver tries to map the
boot VGA ROM they actually map the shadow copy at 0xC0000 (iirc) rather
than the one on the device.  This actually sort of sucks because this
particular shadow copy certainly is not read-only and in all the glory
that is VGA, the shadow sometimes gets modified by the execution of the
VGA ROM itself and we no longer have access to the pristine device
version of it (bad for device assignment of primary graphics).

Now, if we want to make our own shadow copies for all ROMs, it seems
pretty clear that we first need to get access to the ROM, which means we
need to figure out if the BIOS mapped it.  If the ROM BAR is outside of
the bridge aperture (catching both 0 and 0xFFF..000) or overlaps a
standard ROM BAR, we can consider it unprogrammed.  In that case we need
to try to do the trick above with unmapping standard BARs to get the
shadow copy.  Otherwise we should be able to get the shadow copy in
place (maybe a question of which we prefer to use in this case).  I
would be willing to risk that if the BIOS didn't leave room for the ROM
and we can't map it into the space used by other BARs or it doesn't fit
the bridge aperture, we can spit out a printk warning and skip it.  I
expect a very low failure rate.

What dependencies would we have on the BIOS programming of the ROM BAR
if we took such an approach?  It seems like we should always be able to
detect invalid contents in the ROM BAR and it doesn't matter if they
think we should have access or not, we own the device and can give
ourselves access.  Thanks,

Alex

