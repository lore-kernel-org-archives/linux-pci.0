Return-Path: <ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20161123010600.GF4832@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_xW+7KAC8fHquEwHynYzpy6OoO1ZjEm5mVKMo1S8j4Nw@mail.gmail.com> <20161123010600.GF4832@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Nov 2016 07:28:12 +0000
Message-ID: <CAKv+Gu-TW__+eZFS2p=1ZLN7fBs7pqQ+SitbEX46Z4JiS64egA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 23 November 2016 at 01:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 22, 2016 at 10:09:50AM +0000, Ard Biesheuvel wrote:
>> On 17 November 2016 at 17:59, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> > +PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
>> > +describe all the address space they consume.  In principle, this would
>> > +be all the windows they forward down to the PCI bus, as well as the
>> > +bridge registers themselves.  The bridge registers include things like
>> > +secondary/subordinate bus registers that determine the bus range below
>> > +the bridge, window registers that describe the apertures, etc.  These
>> > +are all device-specific, non-architected things, so the only way a
>> > +PNP0A03/PNP0A08 driver can manage them is via _PRS/_CRS/_SRS, which
>> > +contain the device-specific details.  These bridge registers also
>> > +include ECAM space, since it is consumed by the bridge.
>> > +
>> > +ACPI defined a Producer/Consumer bit that was intended to distinguish
>> > +the bridge apertures from the bridge registers [4, 5].  However,
>> > +BIOSes didn't use that bit correctly, and the result is that OSes have
>> > +to assume that everything in a PCI host bridge _CRS is a window.  That
>> > +leaves no way to describe the bridge registers in the PNP0A03/PNP0A08
>> > +device itself.
>>
>> Is that universally true? Or is it still possible to do the right
>> thing here on new ACPI architectures such as arm64?
>
> That's a very good question.  I had thought that the ACPI spec had
> given up on Consumer/Producer completely, but I was wrong.  In the 6.0
> spec, the Consumer/Producer bit is still documented in the Extended
> Address Space Descriptor (sec 6.4.3.5.4).  It is documented as
> "ignored" in the QWord, DWord, and Word descriptors (sec 6.4.3.5.1,2,3).
>
> Linux looks at the producer_consumer bit in acpi_decode_space(), which
> I think is used for all these descriptors (QWord, DWord, Word, and
> Extended).  This doesn't quite follow the spec -- we probably should
> ignore it except for Extended.  In any event, acpi_decode_space() sets
> IORESOURCE_WINDOW for Producer descriptors, but we don't test
> IORESOURCE_WINDOW in the PCI host bridge code.
>
> x86 and ia64 supply their own pci_acpi_root_prepare_resources()
> functions that call acpi_pci_probe_root_resources(), which parses _CRS
> and looks at producer_consumer.  Then they do a little arch-specific
> stuff on the result.
>
> On arm64 we use acpi_pci_probe_root_resources() directly, with no
> arch-specific stuff.
>
> On all three arches, we ignore the Consumer/Producer bit, so all the
> resources are treated as Producers, e.g., as bridge windows.
>
> I think we *could* implement an arm64 version of
> pci_acpi_root_prepare_resources() that would pay attention to the
> Consumer/Producer bit by checking IORESOURCE_WINDOW.  To be spec
> compliant, we would have to use Extended descriptors for all bridge
> windows, even if they would fit in a DWord or QWord.
>
> Should we do that?  I dunno.  I'd like to hear your opinion(s).
>

Yes, I think we should. If the spec allows for a way for a PNP0A03
device to describe all of its resources unambiguously, we should not
be relying on workarounds that were designed for another architecture
in another decade (for, presumably, another OS)

Just for my understanding, we will need to use extended descriptors
for all consumed *and* produced regions, even though dword/qword are
implicitly produced-only, due to the fact that the bit is ignored?

> It *would* be nice to have bridge registers in the bridge _CRS.  That
> would eliminate the need for looking up the HISI0081/PNP0C02 devices
> to find the bridge registers.  Avoiding that lookup is only a
> temporary advantage -- the next round of bridges are supposed to fully
> implement ECAM, and then we won't need to know where the registers
> are.
>
> Apart from the lookup, there's still some advantage in describing the
> registers in the PNP0A03 device instead of an unrelated PNP0C02
> device, because it makes /proc/iomem more accurate and potentially
> makes host bridge hotplug cleaner.  We would have to enhance the host
> bridge driver to do the reservations currently done by pnp/system.c.
>
> There's some value in doing it the same way as on x86, even though
> that way is somewhat broken.
>
> Whatever we decide, I think it's very important to get it figured out
> ASAP because it affects the ECAM quirks that we're trying to merge in
> v4.10.
>

I agree. What exactly is the impact for the quirks mechanism as proposed?
