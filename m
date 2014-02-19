Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62928 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbaBSVeP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 16:34:15 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so684677ieb.30
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 13:34:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3905203.TvF8RmfLsz@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <3312083.odPX4th7oi@wuerfel> <CAErSpo5PCTyZ5jzumJxD=CCN+-t-Z31Cw+9ejT_oTQ4fFQePag@mail.gmail.com>
 <3905203.TvF8RmfLsz@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Feb 2014 14:33:54 -0700
Message-ID: <CAErSpo7g5G0vn_8tyRE52MK6YuTB8XhBbk9thhzLx4tg0hmDMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 1:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 19 February 2014 13:18:24 Bjorn Helgaas wrote:
>> >
>> > Right, this is an interesting case indeed, and I think we haven't
>> > considered it in the binding so far. We already encode a "bus-range"
>> > in DT, so we can easily partition the ECAM config space, but it
>> > still violates one of the two assumptions:
>> > a) that the register ranges for the two host bridge devices are
>> >    non-overlapping in DT
>> > b) that the ECAM register range as specified in DT starts at bus
>> >    0 and is a power-of-two size.
>> > Since the binding is not fixed that, we could change the definition to
>> > say that the ECAM register range in the "reg" property must match
>> > the buses listed in the "bus-range" property.
>>
>> Addresses in the ACPI MCFG table correspond to bus number 0, but the
>> MCFG also provides start & end bus numbers, so the valid range does
>> not necessarily start with bus 0 and need not be power-of-two in size.
>>  Something similar sounds like a good idea for DT.
>
> Hmm, we'll have to think about that. From a DT perspective, we try
> to keep things local to the node using it, so listing only the
> registers we are allowed to access is more natural.

The combination of MCFG base address for bus 00 and the bus number
range from _CRS, plus the obvious offset computation does effectively
describe the registers you're allowed to access; it's just up to the
OS to compute the offsets.  _CBA (an optional method that returns the
ECAM address for a hot-added host bridge) uses the same bus 00 base.
My guess is that _CBA uses a bus number 00 base so it can return a
constant, regardless of whether the OS changes the bus number range.
If _CBA returned the ECAM base for the current bus number aperture, it
would be dependent on _CRS (the current settings), and the OS would
have to re-evaluate _CBA if it ever changed the bus number aperture.

>> > * Each host would always have a fixed memory space aperture, right?
>>
>> The ACPI _CRS/_PRS/_SRS mechanism theoretically allows changes to the
>> bus number, I/O space, and memory space apertures of host bridges.
>> But we don't do any of those changes today, and I don't know if any
>> BIOSes actually allow it.
>
> I mean non-overlapping apertures in particular. We also have
> cases where the aperture that we list in DT is just programmed
> into hardware registers by the host driver and could be arbitrary,
> but you can't normally have the same MMIO address go to two
> devices on internal buses (or not in a sensible way).

I don't remember specific spec statements about that, but I can't
imagine how to make sense of an address that's claimed by two devices.

>> > * From what I understand from your description, the hardware does
>> >   not enforce specific bus numbers for each host. How does the
>> >   host bridge know its root bus number then?
>>
>> I don't know details of any specific hardware.  I'm just saying that
>> ACPI provides a mechanism for the OS to manipulate the bus number
>> range below a host bridge.  Of course, a BIOS is free to omit _PRS and
>> _SRS, and in that case, the bus/IO/memory apertures reported by _CRS
>> are fixed and can't be changed.  We learn the root bus number from the
>> host bridge _CRS (but I'm sure you knew that, so maybe I missed the
>> point of your question).
>
> I guess the answer then is that the host bridge can have a register
> for programming the root bus number, but it's not standardized and
> therefore the access is hidden in the _PRS/_SRS methods. If we have
> the same on DT and want to reprogram the bus numbers, we'd need to
> have a kernel driver for the nonstandard registers of the host bridge.

Exactly; that's my mental model of how it works: _CRS/_PRS/_SRS are
basically accessors for generalized BARs.

>> > * Should I expect one IOMMU per host bridge or one ECAM region,
>> >   or can either be possible?
>>
>> It's possible to have multiple IOMMUs per host bridge, and I think
>> they can even be buried down in the PCIe hierarchy.
>
> Oh, I didn't know that. So how do you actually find the IOMMU for
> a given domain/bus/device/function combination?

For VT-d on x86, there's a DMAR table that describes the remapping
units (IOMMUs), and each has a list of associated devices.  This is
one place where the FW/OS interface uses segment and bus numbers.
There's something different for AMD IOMMUs, but I think it also
involves looking up the device in a table from the firmware.

 Bjorn
