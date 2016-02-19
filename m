Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160219110950.606d48ec@endymion>
References: <20160217143306.6340c6cf@endymion> <CAErSpo5s9JnjaPfsQreWeXTeu7_j-hY0+jVJvyzFYhVeJyazsw@mail.gmail.com>
 <20160219110950.606d48ec@endymion>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Feb 2016 09:08:24 -0600
Message-ID: <CAErSpo7a8KnZA3fAmRzUAQRjdaZxdSw8o7CH=TusqpykZiXZ0Q@mail.gmail.com>
Subject: Re: aer_inject vs. apei/einj
To: Jean Delvare <jdelvare@suse.de>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Fri, Feb 19, 2016 at 4:09 AM, Jean Delvare <jdelvare@suse.de> wrote:
> On Wed, 17 Feb 2016 11:03:31 -0600, Bjorn Helgaas wrote:
>> [+cc Huang, author of both aer_inject and apei/einj]
>>
>> On Wed, Feb 17, 2016 at 7:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> > Hi all,
>> >
>> > I am looking for some guidance regarding AER testing. I see that we
>> > have two different drivers for error injection in the kernel:
>> > aer_inject and apei/einj. The user-space aer-inject tool seems to only
>> > care about the former.
>> >
>> > How does one know which driver should be used on a given system? I
>> > suppose that only one of them will work on a given system?
>> >
>> > My impression is that aer_inject is for "native" AER handling while
>> > apei/einj is for ACPI-driven AER. Is it correct? If not I would
>> > appreciate some pointers explaining when aer_inject should be used and
>> > when apei/einj should be used.
>>
>> My understanding is that:
>>
>>   - aer_inject does not actually write to any hardware registers
>> itself (though I do see it writes to some masks).  It works by
>> replacing the PCI config accessors with new ones that make it look
>> like the AER registers have errors logged.
>>
>>   - apei/einj runs ACPI methods that apparently seed errors.  These
>> might use hardware support for seeding errors, which would of course
>> be platform-dependent.
>>
>> So aer_inject should work on any system at all.  I think apei/einj
>
> My problem is precisely that aer_inject doesn't work on any system I
> tested. Either the device doesn't support AER, or its root port doesn't
> support AER, or (further I've been) the "error device" of the root port
> doesn't exist.

OK, I should have said "aer_inject" should work on any system with
devices that support AER :)  And there are also some conditions
related to _OSC and "firmware-first" error handling, based on the HEST
table.  I expect that dmesg would show whether we can use AER and why
it might be disabled (and if dmesg doesn't show that, it *should*).

> I am not too familiar with PCIe but apparently PCIe
> devices can have "sub-devices" which do not show in "lspci" but show up
> in /sys/bus/pci_express/devices. I have yet to see an aer sub-device
> there on any of my systems.

Yes, the different PCIe services (AER, native hotplug, VC, etc.) are
handled sort of like subdevices.  This seems a bit hacky to me but
it's what we have.

Anyway, if you have a system where the root port and a device below it
support AER, but there's no subdevice for it, we must have disabled it
somehow.  Can you collect a dmesg and "lspci -vv" for it?  We should
be logging a clue there.

>> will only work if the platform supplies an EINJ table, and even when
>> it does, I suspect different platforms probably have different
>> injection capabilities.
>>
>> Huang probably can give a much better response.
>
> Huang, pleeeease? :)
>
> --
> Jean Delvare
> SUSE L3 Support
