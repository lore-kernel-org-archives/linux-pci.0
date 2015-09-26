Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33964 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbIZAEk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2015 20:04:40 -0400
MIME-Version: 1.0
In-Reply-To: <1443197890.23936.631.camel@redhat.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
	<CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
	<CAL-B5D0f10Q6C5jmjzysowDjJ=Z8iA1tSSAQwUp9qcxW-WeMPw@mail.gmail.com>
	<CAE9FiQVXox9UbaQKZvatLwdqbEp6k9QpRcSCeFNROdK6=5qq2Q@mail.gmail.com>
	<CAE9FiQWd69=6-UvCWsPOHvnZ96grJyzEt_+WR0-Q3M9wHz69hw@mail.gmail.com>
	<20150925143546.GA1017@localhost>
	<1443197890.23936.631.camel@redhat.com>
Date: Fri, 25 Sep 2015 17:04:39 -0700
Message-ID: <CAE9FiQVopf59oEfGE2W9WixzDhhz4MvXxDuSdOaXXQDeqqf0qA@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Yinghai Lu <yinghai@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 25, 2015 at 9:18 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
>> > > Or do we want to keep a white list to say which device should have
>> > > ROM bar as mush have, and other is optional to have ?
>> >
>> > Subject: [RFC PATCH] PCI: Add pci_dev_need_rom_bar()
>> >
>> > Only set that for
>> > 1. if BIOS/firmware already set ROM bar.
>> > 2. via quirks for some devices.
>> >
>> > We assign those needed ROM bar as required
>> > and other ROM bars as optional resources.
>>
>> I'd rather not have a whitelist if we can avoid it.  We'd be
>> continually adding new devices to it, and it makes the system harder
>> to understand because there's no consistent rule about how ROMs are
>> handled.

I don't like that whitelist way, and hope we can find better way to
handle all the
cases elegantly.

>>
>> Alex mentioned the idea of ripping the ROM, and I'd like to explore
>> that idea a little more.  What if we could temporarily assign space
>> for the ROM during enumeration, read the contents, cache the contents
>> somewhere, then deallocate the actual BAR space?  We could hang onto
>> the cache and give it to anybody who later needs the ROM.
>
> That sounds pretty good, so long as we can consider the ROM to be
> perfectly static.  I don't know if anything relies on an in-place update
> or if there are ROMs that are less read-only than others.  Maybe it's
> safe to assume that or at least safe to assume that if the BIOS didn't
> leave room for them, then we can consider them static.  It might be
> interesting to strace some of the userspace firmware update programs for
> add-in cards to see if they re-read the ROM to determine if it has
> changed.

Should cover most cases. But there is some driver like
drivers/mtd/maps/pci.c::drivers/mtd/maps/pci.c do have write operation
to the mmio range.

>
> We already sort of do this for VGA ROMs.  When a driver tries to map the
> boot VGA ROM they actually map the shadow copy at 0xC0000 (iirc) rather
> than the one on the device.  This actually sort of sucks because this
> particular shadow copy certainly is not read-only and in all the glory
> that is VGA, the shadow sometimes gets modified by the execution of the
> VGA ROM itself and we no longer have access to the pristine device
> version of it (bad for device assignment of primary graphics).
>
> Now, if we want to make our own shadow copies for all ROMs, it seems
> pretty clear that we first need to get access to the ROM, which means we
> need to figure out if the BIOS mapped it.  If the ROM BAR is outside of
> the bridge aperture (catching both 0 and 0xFFF..000) or overlaps a
> standard ROM BAR, we can consider it unprogrammed.  In that case we need
> to try to do the trick above with unmapping standard BARs to get the
> shadow copy.  Otherwise we should be able to get the shadow copy in
> place (maybe a question of which we prefer to use in this case).  I
> would be willing to risk that if the BIOS didn't leave room for the ROM
> and we can't map it into the space used by other BARs or it doesn't fit
> the bridge aperture, we can spit out a printk warning and skip it.  I
> expect a very low failure rate.

Maybe we can combine two methods together:
1. have NEED_ROM_BAR, and it is set
    a) if BIOS allocate resource to yet (maybe not, so we leave space
for MMIO bars)
    b) via limited whitelist that will not support static copy.
2. kernel will try to allocate resource to ROM bar with
    NEED_ROM_BAR as required, and others
    as optional
3. for ROM bar that can not get assigned, kernel try to borrow mmio range
     from other MMIO bar on the device, and save a copy and  expose that
     via /sys/.../rom
     That should happen FINAL_FIXUP stage before driver get
      loaded.

    --- There is risk on it, some add-on card firmware would
         stop working if kernel ever try to change MMIO bar.
         then we will need blacklist to skip BAR on those devices.
