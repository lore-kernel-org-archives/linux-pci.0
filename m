Return-Path: <adurbin@google.com>
Return-Path: <adurbin@google.com>
MIME-Version: 1.0
In-Reply-To: <2300001.Cg2EHxyMN1@vostro.rjw.lan>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <9194227.5BmSSJ8mhr@vostro.rjw.lan> <CAE2855uTn3EqSuUW0-QD8ES4mm4ifWg-t=JfQ5+4z0YAyUDc_g@mail.gmail.com>
 <2300001.Cg2EHxyMN1@vostro.rjw.lan>
From: Aaron Durbin <adurbin@google.com>
Date: Fri, 22 Jul 2016 12:26:03 -0500
Message-ID: <CAE2855sjXKkx+0RNYMhfqVQCs+cj8NWp6V2RZMoBjRBgcWi-ew@mail.gmail.com>
Subject: Re: ACPI device using sub-resource of PCI device
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 21, 2016 at 7:55 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 20, 2016 08:58:29 PM Aaron Durbin wrote:
>> On Wed, Jul 20, 2016 at 7:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, July 20, 2016 06:02:08 PM Aaron Durbin wrote:
>
> [...]
>
>> >> > Isn't the problem a probe ordering issue, though?
>> >>
>> >> No. Not just ordering. There's no parent-child relationship taken into
>> >> account when PCI devices are added to the resource tree. Deferring
>> >> adding an ACPI device's resources would likely fail similarly because
>> >> one doesn't take into account the proper parent. One lives in PCI land
>> >> -- the other in ACPI land.
>> >
>> > What exactly do you mean by "PCI land" and "ACPI land"?
>> >
>> > All PCI resources are derived from the host bridge ones that come from
>> > ACPI anyway.
>>
>> Except that the BARs are queried in the pci devices themselves and
>> those resources are added w/o any communication to/from ACPI. That's
>> all done in the pci subsystem internally. Only if
>
> Well, not quite.
>
> It gets to host bridge resources via pcibios_bus_to_resource() AFAICS and
> those come from ACPI on ACPI-based systems.

>From what I can tell that's just updating resource values that have a
translation across a bridge. For a 1:1 mapping nothing is different
from the BAR encoded in the PCI device itself. Those windows are just
encoded in the bridge device. The only thing adjusted on the resources
is an offset. The BAR values are read from the device. That path is
just adjusting resources -- it's not adding those individual resources
into the resource tree for pci devices. See below.

>
>> >
>> >> Currently, the issue is manifesting that the ACPI device's resources
>> >> are added into the resource tree. PCI devices the follow trying to add
>> >> their own resources. Conflicts ensue without taking into account the
>> >> proper hierarchy. To make matters worse, struct resource doesn't have
>> >> a struct device -- only a name. That means there's no way of knowing
>> >> who owns what resource. All that information is unavailable. That's
>> >> why the semi-hacky proposal was to see if there is an ACPI companion
>> >> device and see if it has children. If it's children's names match the
>> >> conflicting resource it's a good bet that the PCI device's resources
>> >> should be placed as the parent in the resource tree.
>> >
>> > That really looks like a broken hierarchy of devices somewhere.
>>
>> Why do you think it's a broken hierarchy? This CL has the heirarchy:
>> https://chromium-review.googlesource.com/#/c/359432/
>>
>> There is a device, P2S, which would result in an ACPI companion device
>> when the pci_dev is added to the device infrastructure by way of
>> acpi_platform_notify() which does the ACPI companion binding.
>> device_add() is the caller of platform_notify() which is set to
>> acpi_platform_notify() in init_acpi_device_notify() by way of
>> acpi_init().
>>
>> There are 4 children of the P2S device: GPO0, GPO1, GPO2, GPO3.
>>
>> Those children devices utilize a sub-resource of the P2S device which
>> has a pci_dev companion. It's BAR0 is the resource.
>
> OK
>
>> >
>> > And one more thing: a struct acpi_device object is not a device in general
>> > (althogh some pieces of code in the kernel, arguably incorrectly, treat it
>> > this way).  It is an abstract representation of a firmware entity (a node
>> > in the ACPI namespace).
>> >
>> > There really should be a "physical device" thing corresponding to it and
>> > that should be a child of the PCI device object in question.
>>
>> I thought I established that by the sysfs readlink I output I
>> previously provided?
>>
>> # ls /sys/devices/platform/| grep INT3452
>> INT3452:00
>> INT3452:01
>> INT3452:02
>> INT3452:03
>>
>> # ls /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:11 | grep INT3452
>> INT3452:00
>> INT3452:01
>> INT3452:02
>> INT3452:03
>>
>> # readlink -f /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:11/INT3452:00/physical_node
>> /sys/devices/platform/INT3452:00
>
> OK
>
> I must have missed that part.
>
>> >
>> >> > Do we assign BARs for endpoints during enumeration or only when we find a
>> >> > matching driver?
>> >>
>> >> BARs look to be assigned during enumeration. There's where conflicts
>> >> are found and resources reassigned in the current failing case.
>> >
>> > OK
>> >
>> > You seem to be saying that we insert some resources for ACPI device objects
>> > that correspond to the children of ACPI companions of PCI devices before we
>> > assign the BARs for their parent devices.
>>
>> The pci_dev is the one owning the parent resource. Even if there is a
>> companion ACPI device with a resource it doesn't matter because there
>> will still be a conflict because there is no checking against the
>> companion. There are 2 parallel entities without any communication
>> between the PCI subsystem and the ACPI subsystem when resources are
>> being added.
>>
>> >
>> > To me, that sounds very suspicious.
>> >
>> > Where in the code are the ACPI resources inserted, exactly?
>>
>> I believe it's through this mechanism:
>> acpi_bus_attach() -> acpi_default_enumeration() ->
>> acpi_create_platform_device() -> platform_device_register_full()
>
> I still would like to understand how and why that is called for child devices
> before the (physical) parent is enumerated.
>
> The theory is that when the PCI host bridge is found in the ACPI namespace,
> it will be enumerated along with the entire PCI bus below it before enumerating
> any _HID devices in the ACPI namespace below the host bridge object.
>
> Therefore all PCI devices should be enumerated before any children of any of
> them that aren't PCI devices themselves.  If BARs are assigned during
> enumeration, they all should be assigned before inserting any resources
> for any non-PCI children of any PCI devices.
>
> If that doesn't happen, the practice doesn't match the theory and that very
> well may be the source of the problem you're seeing.
>

I'll sprinkle some WARN_ON()s in the resource code to track down when
things are being added to provide a definitive answer to when these
resources are being inserted. The current issue is still stands:
there is nothing properly tying the 2 sources of resource information
together. And ACPI resources are added prior to PCI resources.

PCI devices might be enumerated, but that doesn't mean their
*resources* are added.  Back to the subsys_initcall topic:

pci_subsys_init() is called *after* acpi_init().

pci_subsys_init() -> pcibios_init() -> pcibios_resource_survey() ->
pcibios_allocate_resources() -> pcibios_allocate_dev_resources() ->
pci_claim_resource()


> Thanks,
> Rafael
>
