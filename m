Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752903AbcKWBGL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Nov 2016 20:06:11 -0500
Date: Tue, 22 Nov 2016 19:06:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
Message-ID: <20161123010600.GF4832@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_xW+7KAC8fHquEwHynYzpy6OoO1ZjEm5mVKMo1S8j4Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAKv+Gu_xW+7KAC8fHquEwHynYzpy6OoO1ZjEm5mVKMo1S8j4Nw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 22, 2016 at 10:09:50AM +0000, Ard Biesheuvel wrote:
> On 17 November 2016 at 17:59, Bjorn Helgaas <bhelgaas@google.com> wrote:

> > +PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
> > +describe all the address space they consume.  In principle, this would
> > +be all the windows they forward down to the PCI bus, as well as the
> > +bridge registers themselves.  The bridge registers include things like
> > +secondary/subordinate bus registers that determine the bus range below
> > +the bridge, window registers that describe the apertures, etc.  These
> > +are all device-specific, non-architected things, so the only way a
> > +PNP0A03/PNP0A08 driver can manage them is via _PRS/_CRS/_SRS, which
> > +contain the device-specific details.  These bridge registers also
> > +include ECAM space, since it is consumed by the bridge.
> > +
> > +ACPI defined a Producer/Consumer bit that was intended to distinguish
> > +the bridge apertures from the bridge registers [4, 5].  However,
> > +BIOSes didn't use that bit correctly, and the result is that OSes have
> > +to assume that everything in a PCI host bridge _CRS is a window.  That
> > +leaves no way to describe the bridge registers in the PNP0A03/PNP0A08
> > +device itself.
> 
> Is that universally true? Or is it still possible to do the right
> thing here on new ACPI architectures such as arm64?

That's a very good question.  I had thought that the ACPI spec had
given up on Consumer/Producer completely, but I was wrong.  In the 6.0
spec, the Consumer/Producer bit is still documented in the Extended
Address Space Descriptor (sec 6.4.3.5.4).  It is documented as
"ignored" in the QWord, DWord, and Word descriptors (sec 6.4.3.5.1,2,3).

Linux looks at the producer_consumer bit in acpi_decode_space(), which
I think is used for all these descriptors (QWord, DWord, Word, and
Extended).  This doesn't quite follow the spec -- we probably should
ignore it except for Extended.  In any event, acpi_decode_space() sets
IORESOURCE_WINDOW for Producer descriptors, but we don't test
IORESOURCE_WINDOW in the PCI host bridge code.

x86 and ia64 supply their own pci_acpi_root_prepare_resources()
functions that call acpi_pci_probe_root_resources(), which parses _CRS
and looks at producer_consumer.  Then they do a little arch-specific
stuff on the result.

On arm64 we use acpi_pci_probe_root_resources() directly, with no
arch-specific stuff.

On all three arches, we ignore the Consumer/Producer bit, so all the
resources are treated as Producers, e.g., as bridge windows.

I think we *could* implement an arm64 version of
pci_acpi_root_prepare_resources() that would pay attention to the
Consumer/Producer bit by checking IORESOURCE_WINDOW.  To be spec
compliant, we would have to use Extended descriptors for all bridge
windows, even if they would fit in a DWord or QWord.

Should we do that?  I dunno.  I'd like to hear your opinion(s).

It *would* be nice to have bridge registers in the bridge _CRS.  That
would eliminate the need for looking up the HISI0081/PNP0C02 devices
to find the bridge registers.  Avoiding that lookup is only a
temporary advantage -- the next round of bridges are supposed to fully
implement ECAM, and then we won't need to know where the registers
are.

Apart from the lookup, there's still some advantage in describing the
registers in the PNP0A03 device instead of an unrelated PNP0C02
device, because it makes /proc/iomem more accurate and potentially
makes host bridge hotplug cleaner.  We would have to enhance the host
bridge driver to do the reservations currently done by pnp/system.c.

There's some value in doing it the same way as on x86, even though
that way is somewhat broken.

Whatever we decide, I think it's very important to get it figured out
ASAP because it affects the ECAM quirks that we're trying to merge in
v4.10.

> > +The workaround is to describe the bridge registers (including ECAM
> > +space) in PNP0C02 catch-all devices [6].  With the exception of ECAM,
> > +the bridge register space is device-specific anyway, so the generic
> > +PNP0A03/PNP0A08 driver (pci_root.c) has no need to know about it.  For
> > +ECAM, pci_root.c learns about the space from either MCFG or the _CBA
> > +method.
> > +
> > +Note that the PCIe spec actually does require ECAM unless there's a
> > +standard firmware interface for config access, e.g., the ia64 SAL
> > +interface [7].  One reason is that we want a generic host bridge
> > +driver (pci_root.c), and a generic driver requires a generic way to
> > +access config space.
> > +
> > +
> > +[1] ACPI 6.0, sec 6.1:
> > +    For any device that is on a non-enumerable type of bus (for
> > +    example, an ISA bus), OSPM enumerates the devices' identifier(s)
> > +    and the ACPI system firmware must supply an _HID object ... for
> > +    each device to enable OSPM to do that.
> > +
> > +[2] ACPI 6.0, sec 3.7:
> > +    The OS enumerates motherboard devices simply by reading through
> > +    the ACPI Namespace looking for devices with hardware IDs.
> > +
> > +    Each device enumerated by ACPI includes ACPI-defined objects in
> > +    the ACPI Namespace that report the hardware resources the device
> > +    could occupy [_PRS], an object that reports the resources that are
> > +    currently used by the device [_CRS], and objects for configuring
> > +    those resources [_SRS].  The information is used by the Plug and
> > +    Play OS (OSPM) to configure the devices.
> > +
> > +[3] ACPI 6.0, sec 6.2:
> > +    OSPM uses device configuration objects to configure hardware
> > +    resources for devices enumerated via ACPI.  Device configuration
> > +    objects provide information about current and possible resource
> > +    requirements, the relationship between shared resources, and
> > +    methods for configuring hardware resources.
> > +
> > +    When OSPM enumerates a device, it calls _PRS to determine the
> > +    resource requirements of the device.  It may also call _CRS to
> > +    find the current resource settings for the device.  Using this
> > +    information, the Plug and Play system determines what resources
> > +    the device should consume and sets those resources by calling the
> > +    device’s _SRS control method.
> > +
> > +    In ACPI, devices can consume resources (for example, legacy
> > +    keyboards), provide resources (for example, a proprietary PCI
> > +    bridge), or do both.  Unless otherwise specified, resources for a
> > +    device are assumed to be taken from the nearest matching resource
> > +    above the device in the device hierarchy.
> > +
> > +[4] ACPI 6.0, sec 6.4.3.5.4:
> > +    Extended Address Space Descriptor
> > +    General Flags: Bit [0] Consumer/Producer:
> > +       1–This device consumes this resource
> > +       0–This device produces and consumes this resource
> > +
> > +[5] ACPI 6.0, sec 19.6.43:
> > +    ResourceUsage specifies whether the Memory range is consumed by
> > +    this device (ResourceConsumer) or passed on to child devices
> > +    (ResourceProducer).  If nothing is specified, then
> > +    ResourceConsumer is assumed.
> > +
> > +[6] PCI Firmware 3.0, sec 4.1.2:
> > +    If the operating system does not natively comprehend reserving the
> > +    MMCFG region, the MMCFG region must be reserved by firmware.  The
> > +    address range reported in the MCFG table or by _CBA method (see
> > +    Section 4.1.3) must be reserved by declaring a motherboard
> > +    resource.  For most systems, the motherboard resource would appear
> > +    at the root of the ACPI namespace (under \_SB) in a node with a
> > +    _HID of EISAID (PNP0C02), and the resources in this case should
> > +    not be claimed in the root PCI bus’s _CRS.  The resources can
> > +    optionally be returned in Int15 E820 or EFIGetMemoryMap as
> > +    reserved memory but must always be reported through ACPI as a
> > +    motherboard resource.
> > +
> > +[7] PCI Express 3.0, sec 7.2.2:
> > +    For systems that are PC-compatible, or that do not implement a
> > +    processor-architecture-specific firmware interface standard that
> > +    allows access to the Configuration Space, the ECAM is required as
> > +    defined in this section.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
