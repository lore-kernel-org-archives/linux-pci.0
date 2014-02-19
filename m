Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64564 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaBSUSo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 15:18:44 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so620628ieb.38
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 12:18:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3312083.odPX4th7oi@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <2200534.anptP81x7X@wuerfel> <CAErSpo7JNyqK3NZgP++OWkQYQzZ1_BdR3GrK3vOd8c=_YAX7nA@mail.gmail.com>
 <3312083.odPX4th7oi@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Feb 2014 13:18:24 -0700
Message-ID: <CAErSpo5PCTyZ5jzumJxD=CCN+-t-Z31Cw+9ejT_oTQ4fFQePag@mail.gmail.com>
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

On Wed, Feb 19, 2014 at 12:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 19 February 2014 11:20:19 Bjorn Helgaas wrote:
>> On Wed, Feb 19, 2014 at 2:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 18 February 2014 17:28:14 Bjorn Helgaas wrote:
>
>> > The second one seems a little easier to implement, and I don't
>> > see what _SEG is used for other than to avoid having domains
>> > when you don't need them. Is there more to it that I'm missing?
>>
>> Not really, but I do have a question related to OS management of host
>> bridge bus number apertures.  Currently, Linux never changes a host
>> bridge's bus number range, but it's conceivable that we could in some
>> hotplug scenario.  ACPI does provide a mechanism to do so (_PRS,
>> _SRS), and other host bridge drivers could also do this by programming
>> CSRs to change the bus number range.  The PCI domain is the logical
>> place to manage allocation of the 00-ff range of bus numbers.
>>
>> 1) x86 platforms may have constraints because PCIBIOS and the 0xcf8
>> config access mechanism are unaware of segments.  If a platform has to
>> support legacy OSes that use those, it can't reuse bus numbers even in
>> different segment groups.  The platform might have to use multiple
>> segments to allow multiple ECAM regions, but use _PRS/_SRS to prevent
>> bus number overlaps to keep legacy config access working.  Obviously
>> this is only an issue if there are non-segment aware config access
>> methods.
>
> Right, I don't think this will be an issue outside of x86/ia64/alpha,
> since on all other architectures I'm aware of you have no PCIBIOS
> and each host controller would also have its own config space.
> Even host controllers using 0xfc8 would be fine because each host
> bridge normally has its own I/O space.
>
>> 2) If two host bridges share an ECAM region, I think we're forced to
>> put them in the same domain: if we put them in different domains,
>> Linux might assign [bus 00-ff] to both bridges, and ECAM config
>> accesses would only work for one of the bridges.  This is quite common
>> on x86 and is a potential issue for any architecture.
>
> Right, this is an interesting case indeed, and I think we haven't
> considered it in the binding so far. We already encode a "bus-range"
> in DT, so we can easily partition the ECAM config space, but it
> still violates one of the two assumptions:
> a) that the register ranges for the two host bridge devices are
>    non-overlapping in DT
> b) that the ECAM register range as specified in DT starts at bus
>    0 and is a power-of-two size.
> Since the binding is not fixed that, we could change the definition to
> say that the ECAM register range in the "reg" property must match
> the buses listed in the "bus-range" property.

Addresses in the ACPI MCFG table correspond to bus number 0, but the
MCFG also provides start & end bus numbers, so the valid range does
not necessarily start with bus 0 and need not be power-of-two in size.
 Something similar sounds like a good idea for DT.

> I still want to make sure I understand exactly what this case is about
> though, i.e. what is shared and what is separate if you have two host
> bridges with a common ECAM region:
>
> * I assume I/O space is always shared on x86, but probably separate
>   elsewhere.

I think x86 *could* support multiple I/O spaces, but user-mode
inb/outb could only reach the 0-64K space.  I think ia64 has the same
limitation on user code, but it supports many spaces in the kernel.

> * Each host would always have a fixed memory space aperture, right?

The ACPI _CRS/_PRS/_SRS mechanism theoretically allows changes to the
bus number, I/O space, and memory space apertures of host bridges.
But we don't do any of those changes today, and I don't know if any
BIOSes actually allow it.

> * From what I understand from your description, the hardware does
>   not enforce specific bus numbers for each host. How does the
>   host bridge know its root bus number then?

I don't know details of any specific hardware.  I'm just saying that
ACPI provides a mechanism for the OS to manipulate the bus number
range below a host bridge.  Of course, a BIOS is free to omit _PRS and
_SRS, and in that case, the bus/IO/memory apertures reported by _CRS
are fixed and can't be changed.  We learn the root bus number from the
host bridge _CRS (but I'm sure you knew that, so maybe I missed the
point of your question).

> * Should I expect one IOMMU per host bridge or one ECAM region,
>   or can either be possible?

It's possible to have multiple IOMMUs per host bridge, and I think
they can even be buried down in the PCIe hierarchy.

> * The IntA-IntB IRQ numbers are always per host bridge I assume.

For conventional PCI, INTx are just wires that could go anywhere, so
there's no connection between them and a host bridge.  You have to
have a _PRT or similar to make sense out of them.  For PCIe, a Root
Complex maps INTx emulation messages to system interrupts in an
implementation-specific way, so we need a _PRT there, too.  I don't
think there's a requirement that these IRQ numbers be per-host bridge.

> * Memory space on one host bridge is visible to bus master DMA
>   from a device on another host bridge on x86, right? I assume
>   this won't normally be the case on other architectures.

I think this is also implementation dependent, and I'm not aware of an
ACPI or other generic way to learn what a particular platform does.
It seems like this was an issue for MPS configuration, where
peer-to-peer DMA is a problem because we don't really know how Root
Complexes handle peer-to-peer transactions.

Bjorn
