Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <20161123123004.GA3642@red-moon>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_xW+7KAC8fHquEwHynYzpy6OoO1ZjEm5mVKMo1S8j4Nw@mail.gmail.com>
 <20161123010600.GF4832@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu-TW__+eZFS2p=1ZLN7fBs7pqQ+SitbEX46Z4JiS64egA@mail.gmail.com> <20161123123004.GA3642@red-moon>
From: Duc Dang <dhdang@apm.com>
Date: Wed, 23 Nov 2016 12:52:07 -0800
Message-ID: <CADaLNDnj6=LRJrTTA_3cZXFZK1mWEWxRtD2JHEM48Ej0QQKZKQ@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH] PCI: Add information about describing PCI
 in ACPI
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 4:30 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Nov 23, 2016 at 07:28:12AM +0000, Ard Biesheuvel wrote:
>> On 23 November 2016 at 01:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Tue, Nov 22, 2016 at 10:09:50AM +0000, Ard Biesheuvel wrote:
>> >> On 17 November 2016 at 17:59, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >
>> >> > +PCI host bridges are PNP0A03 or PNP0A08 devices.  Their _CRS should
>> >> > +describe all the address space they consume.  In principle, this would
>> >> > +be all the windows they forward down to the PCI bus, as well as the
>> >> > +bridge registers themselves.  The bridge registers include things like
>> >> > +secondary/subordinate bus registers that determine the bus range below
>> >> > +the bridge, window registers that describe the apertures, etc.  These
>> >> > +are all device-specific, non-architected things, so the only way a
>> >> > +PNP0A03/PNP0A08 driver can manage them is via _PRS/_CRS/_SRS, which
>> >> > +contain the device-specific details.  These bridge registers also
>> >> > +include ECAM space, since it is consumed by the bridge.
>> >> > +
>> >> > +ACPI defined a Producer/Consumer bit that was intended to distinguish
>> >> > +the bridge apertures from the bridge registers [4, 5].  However,
>> >> > +BIOSes didn't use that bit correctly, and the result is that OSes have
>> >> > +to assume that everything in a PCI host bridge _CRS is a window.  That
>> >> > +leaves no way to describe the bridge registers in the PNP0A03/PNP0A08
>> >> > +device itself.
>> >>
>> >> Is that universally true? Or is it still possible to do the right
>> >> thing here on new ACPI architectures such as arm64?
>> >
>> > That's a very good question.  I had thought that the ACPI spec had
>> > given up on Consumer/Producer completely, but I was wrong.  In the 6.0
>> > spec, the Consumer/Producer bit is still documented in the Extended
>> > Address Space Descriptor (sec 6.4.3.5.4).  It is documented as
>> > "ignored" in the QWord, DWord, and Word descriptors (sec 6.4.3.5.1,2,3).
>> >
>> > Linux looks at the producer_consumer bit in acpi_decode_space(), which
>> > I think is used for all these descriptors (QWord, DWord, Word, and
>> > Extended).  This doesn't quite follow the spec -- we probably should
>> > ignore it except for Extended.  In any event, acpi_decode_space() sets
>> > IORESOURCE_WINDOW for Producer descriptors, but we don't test
>> > IORESOURCE_WINDOW in the PCI host bridge code.
>> >
>> > x86 and ia64 supply their own pci_acpi_root_prepare_resources()
>> > functions that call acpi_pci_probe_root_resources(), which parses _CRS
>> > and looks at producer_consumer.  Then they do a little arch-specific
>> > stuff on the result.
>> >
>> > On arm64 we use acpi_pci_probe_root_resources() directly, with no
>> > arch-specific stuff.
>> >
>> > On all three arches, we ignore the Consumer/Producer bit, so all the
>> > resources are treated as Producers, e.g., as bridge windows.
>> >
>> > I think we *could* implement an arm64 version of
>> > pci_acpi_root_prepare_resources() that would pay attention to the
>> > Consumer/Producer bit by checking IORESOURCE_WINDOW.  To be spec
>> > compliant, we would have to use Extended descriptors for all bridge
>> > windows, even if they would fit in a DWord or QWord.
>> >
>> > Should we do that?  I dunno.  I'd like to hear your opinion(s).
>> >
>>
>> Yes, I think we should. If the spec allows for a way for a PNP0A03
>> device to describe all of its resources unambiguously, we should not
>> be relying on workarounds that were designed for another architecture
>> in another decade (for, presumably, another OS)
>
> That was the idea I floated at LPC16. We can override the
> acpi_pci_root_ops prepare_resources() function pointer with a function
> that checks IORESOURCE_WINDOW and filters resources accordingly (and
> specific quirk "drivers" may know how to intepret resources that aren't
> IORESOURCE_WINDOW - ie they can use it to describe the PCI ECAM config
> space quirk region in their _CRS).
>
> In a way that's something that makes sense anyway because given
> that we are starting from a clean slate on ARM64 considering resources
> that are not IORESOURCE_WINDOW as host bridge windows is just something
> we are inheriting from x86, it is not really ACPI specs compliant (is
> it ?).
>
>> Just for my understanding, we will need to use extended descriptors
>> for all consumed *and* produced regions, even though dword/qword are
>> implicitly produced-only, due to the fact that the bit is ignored?
>
> That's something that has to be clarified within the ASWG ie why the
> consumer bit is ignored for *some* descriptors and not for others.
>
> As things stand unfortunately the answer seems yes (I do not know
> why).
>
>> > It *would* be nice to have bridge registers in the bridge _CRS.  That
>> > would eliminate the need for looking up the HISI0081/PNP0C02 devices
>> > to find the bridge registers.  Avoiding that lookup is only a
>> > temporary advantage -- the next round of bridges are supposed to fully
>> > implement ECAM, and then we won't need to know where the registers
>> > are.
>> >
>> > Apart from the lookup, there's still some advantage in describing the
>> > registers in the PNP0A03 device instead of an unrelated PNP0C02
>> > device, because it makes /proc/iomem more accurate and potentially
>> > makes host bridge hotplug cleaner.  We would have to enhance the host
>> > bridge driver to do the reservations currently done by pnp/system.c.
>> >
>> > There's some value in doing it the same way as on x86, even though
>> > that way is somewhat broken.
>> >
>> > Whatever we decide, I think it's very important to get it figured out
>> > ASAP because it affects the ECAM quirks that we're trying to merge in
>> > v4.10.
>> >
>>
>> I agree. What exactly is the impact for the quirks mechanism as proposed?
> The impact is that we could just use the PNP0A03 _CRS to report the PCI
> ECAM config space quirk region through a consumer resource keeping in
> mind what I say above (actually I think that's what was done on APM
> firmware initially, for the records).

Just to clarify: APM firmware initially has a _CSR region to declare
the controller register region. We don't know that we need to declare
the reserved space for ECAM until Bjorn pointed out recently (with the
usage of PNP0C02).

I really like this idea about declaring ECAM space and any additional
spaces required for ECAM quirk inside PNP0A03 _CRS. For the firmware
that already shipped, the quirk will need to add additional resources
(for ECAM and other needed regions) into the root-bus. If we decided
to go with this, do we still have time to make additional adjustment
for the current ECAM quirk and the foundation patches before
v4.10-rc1?

>
> Lorenzo
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-acpi
Regards,
Duc Dang.
