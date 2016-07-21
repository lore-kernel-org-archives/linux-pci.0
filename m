Return-Path: <adurbin@google.com>
Return-Path: <adurbin@google.com>
MIME-Version: 1.0
In-Reply-To: <9194227.5BmSSJ8mhr@vostro.rjw.lan>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <1787767.fkqrmkTfXg@vostro.rjw.lan> <CAE2855vSk3Pawuzj_Zs=ztia3EeEhd_NbFU=_1TxZyq7w83uVA@mail.gmail.com>
 <9194227.5BmSSJ8mhr@vostro.rjw.lan>
From: Aaron Durbin <adurbin@google.com>
Date: Wed, 20 Jul 2016 20:58:29 -0500
Message-ID: <CAE2855uTn3EqSuUW0-QD8ES4mm4ifWg-t=JfQ5+4z0YAyUDc_g@mail.gmail.com>
Subject: Re: ACPI device using sub-resource of PCI device
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 20, 2016 at 7:40 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 20, 2016 06:02:08 PM Aaron Durbin wrote:
>> On Wed, Jul 20, 2016 at 5:46 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, July 20, 2016 02:35:43 PM Bjorn Helgaas wrote:
>> >> On Tue, Jun 28, 2016 at 09:41:19PM -0700, Aaron Durbin wrote:
>> >> > On Fri, Jun 24, 2016 at 12:34 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >> > > On Tue, Jun 14, 2016 at 12:04 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >> > >> On Wed, May 18, 2016 at 3:32 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >> > >>> On Wed, May 18, 2016 at 4:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >> > >>>> On Wed, May 18, 2016 at 5:54 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >> > >>>>> Hi,
>> >> > >>>>>
>> >> > >>>>> We're currently running into a problem of resource conflicts with a
>> >> > >>>>> PCI device and ACPI devices.
>> >> > >>>>>
>> >> > >>>>> [    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
>> >> > >>>>> 0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
>> >> > >>>>> 0xd0c00000-0xd0c03fff]
>> >> > >>>>>
>> >> > >>>>> The PCI BAR covers a large amount mmio resources, however, there are
>> >> > >>>>> ACPI devices with their own HID (for probing) which uses resources
>> >> > >>>>> that are a subset of the PCI BAR.
>> >> > >>>>>
>> >> > >>>>> Short of re-structuring the linux driver is there anything that can be
>> >> > >>>>> done with ASL to properly have the ACPI device use a sub-resource of
>> >> > >>>>> the PCI device during the ACPI/PCI probing?
>> >> > >>>>
>> >> > >>>> Do you have an ACPI device object corresponding to the PCI device?
>> >> > >>>
>> >> > >>> I've been debugging this by proxy, and I did request that test. The
>> >> > >>> following is the overall structure:
>> >> > >>>
>> >> > >>> scope (\_SB.PCI0) {
>> >> > >>>
>> >> > >>> Device (P2S)
>> >> > >>> {
>> >> > >>>         Name (_ADR, 0x000D0000)
>> >> > >>>         Device (GPO0)
>> >> > >>>         {
>> >> > >>>                 Name (_ADR, 0)
>> >> > >>>                 Name (_HID, "INT3452")
>> >> > >>>                 Name (_CID, "INT3452")
>> >> > >>>         }
>> >> > >>> }
>> >> > >>> }
>> >> > >>>
>> >> > >>> There are _STA methods in both Devices. The GP0 device has a _CRS
>> >> > >>> method which just returns a ResourceTemplate which is filled in with
>> >> > >>> static values. The PCI bar is at a fixed address from the firmware
>> >> > >>> which allows the fixed calculations. However there is no specific
>> >> > >>> reference to the P2S device's resources proper -- only the parent
>> >> > >>> child relationship within the ASL. I'm not sure how to directly say "I
>> >> > >>> want this sub-region of this other device's resource for my resource."
>> >> > >>> That seems like the right thing, but it's not clear if that's implied
>> >> > >>> by hierarchy of the devices.
>> >> > >>>
>> >> > >>> Lastly, if it helps, the kernel being used is based on v4.4 (no core
>> >> > >>> patches on top).
>> >> > >>>
>> >> > >>
>> >> > >> Hi Rafael,
>> >> > >>
>> >> > >> I haven't tried a newer kernel yet, but are you of the opinion that
>> >> > >> having the Devices as parent-child within the ASL should work? I'm
>> >> > >> wondering if there's already a patch in newer kernels that doesn't
>> >> > >> report the conflict and works as expected once there are child Devices
>> >> > >> under the P2S device.
>> >> > >>
>> >> > >
>> >> > > I've been looking at this more closely. A child ACPI device under a
>> >> > > ACPI PCI device doesn't change the resource conflict even when a _CRS
>> >> > > method is added to the ACPI PCI device.  Below is my sleuthing which
>> >> > > is probably not a surprise to anyone here, but please correct me where
>> >> > > I am wrong.
>> >> > >
>> >> > > acpi_init() and pci_subsys_init() are both subsys_initcalls during
>> >> > > boot up. I'm not sure if the ordering is dumb luck or not, but
>> >> > > acpi_init() is called prior to pci_subsys_init(). The conflict error
>> >> > > is spit out from pcibios_resource_survey() by way of pci_subsys_init()
>> >> > >  subsys_initcall. However, the PCI device scanning is kicked off prior
>> >> > > to this through acpi_scan_init() by way of acpi_init()
>> >> > > subsys_initcall.  The conflict error occurs because there's already
>> >> > > the child ACPI device in the resource tree. I'm not sure when/where
>> >> > > those ACPI devices' resources are added, but clearly they are sitting
>> >> > > in there since the conflict was found.
>> >>
>> >> I think the acpi_init()/pci_subsys_init() ordering is correct.  The
>> >> ACPI namespace is primary.  A PCI hierarchy originates at a PCI host
>> >> bridge in the ACPI namespace, so we should enumerate the ACPI
>> >> namespace first, and when we find a PCI host bridge, we should
>> >> enumerate the PCI devices below it.
>> >>
>> >> That said, I think it is correct mostly by accident and it would be
>> >> nice if it were more explicit.
>> >
>> > No, it isn't by accident.
>> >
>> > The enumeration of PCI devices under a PCI host bridge discovered via ACPI
>> > starts in acpi_pci_root_add() which quite explicitly is only called after
>> > enumerating the ACPI namespace entirely.
>> >
>> > acpi_bus_scan() has two passes now, one is to call acpi_bus_check_add() for
>> > all namespace objects and the other is the acpi_bus_attach() pass where
>> > all things like acpi_pci_root_add() are called.
>> >
>> >> > > Somewhere along the way a PCI device from a scan is linked with the
>> >> > > ACPI device for that same PCI device in sysfs.  This is with me
>> >> > > putting a _HID and _CID in the PCI ACPI device.
>> >> > > # readlink -f /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00/physical_node
>> >> > > /sys/devices/pci0000:00/0000:00:0d.0
>> >> > > # readlink -f /sys/devices/pci0000\:00/0000\:00\:0d.0/firmware_node/
>> >> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00
>> >> > >
>> >> > > So the hierarchy is known eventually, but it's clearly not honored
>> >> > > when adding resources. The current ACPI support doesn't handle
>> >> > > PciBarTarget which initially sounds (from ACPI spec) like the way to
>> >> > > go for referencing a resource in a PCI device from an ACPI device.
>> >>
>> >> Yes, I think PCIBARTarget looks like the right way to do this.  It
>> >> doesn't *seem* like it'd be that hard to implement; have you looked
>> >> into that at all?
>> >>
>> >> Without PCIBARTarget, the AML contains fixed register addresses, so it
>> >> will break if Linux reassigns the BAR.
>> >
>> > Right.
>> >
>> >> > > So
>> >> > > that's out of the question currently, but maybe someone has a patch
>> >> > > for that? I don't think reordering the acpi_init() and
>> >> > > pci_subsys_init() would do anything different except change which
>> >> > > device discovers the conflict.
>> >> > >
>> >> > > Is there a way to honor the ACPI device hierarchy during resource
>> >> > > addition for the PCI devices? The conflict is found because of the
>> >> > > presence of a child device claiming resources through _CRS.
>> >> > > Alternatively, is there a good way to defer the probing of an ACPI
>> >> > > device until one knows PCI resources have been added?
>> >> > >
>> >> > > Any insights would be very helpful. Thank you.
>> >> >
>> >> > I stumbled upon the hierarchy connection. That's all handled with the
>> >> > platform_notify() end of things when device_add() is done on the pci
>> >> > device. I was thinking we could take advantage of this when adding
>> >> > resources, but a struct resource has no struct device. It's just a
>> >> > name description for the resource at hand. However, platform devices
>> >> > are added when the ACPI tree is parsed along with adding the resources
>> >> > associated with them (PciBarTarget would be helpful here) so those
>> >> > resources are sitting in the resource tree when PCI BARs are added.
>> >> >
>> >> > The following suggestion is sort of hacky, but it's the best I could
>> >> > come up with provided the currently supported infrastructure. In
>> >> > pci_claim_resource() do request_resource_conflict() as before. If it
>> >> > fails do the following: 1. check if the device has an ACPI companion.
>> >> > 2. For any children hanging off the ACPI companion device. check if
>> >> > that device's name matches the conflict resource's name. 3. If so,
>> >> > insert_resource_conflict() to place the BAR within the tree itself.
>> >>
>> >> I think the best solution would be to implement PCIBARTarget, but if
>> >> that's impossible, this seems like a plausible workaround.
>> >>
>> >> I don't know if the conflict would necessarily have to be with the
>> >> ACPI companion itself.  It seems like you could have some hierarchy of
>> >> ACPI devices where the leaf conflicts with a PCI BAR.  Maybe if a
>> >> resource of *any* ACPI device below a PCI host bridge conflicts with a
>> >> PCI BAR, we should insert the PCI BAR as a parent?
>> >>
>> >> And since moving that BAR would break the AML, we should probably mark
>> >> the BAR as IORESOURCE_PCI_FIXED.
>> >
>> > Isn't the problem a probe ordering issue, though?
>>
>> No. Not just ordering. There's no parent-child relationship taken into
>> account when PCI devices are added to the resource tree. Deferring
>> adding an ACPI device's resources would likely fail similarly because
>> one doesn't take into account the proper parent. One lives in PCI land
>> -- the other in ACPI land.
>
> What exactly do you mean by "PCI land" and "ACPI land"?
>
> All PCI resources are derived from the host bridge ones that come from
> ACPI anyway.

Except that the BARs are queried in the pci devices themselves and
those resources are added w/o any communication to/from ACPI. That's
all done in the pci subsystem internally. Only if

>
>> Currently, the issue is manifesting that the ACPI device's resources
>> are added into the resource tree. PCI devices the follow trying to add
>> their own resources. Conflicts ensue without taking into account the
>> proper hierarchy. To make matters worse, struct resource doesn't have
>> a struct device -- only a name. That means there's no way of knowing
>> who owns what resource. All that information is unavailable. That's
>> why the semi-hacky proposal was to see if there is an ACPI companion
>> device and see if it has children. If it's children's names match the
>> conflicting resource it's a good bet that the PCI device's resources
>> should be placed as the parent in the resource tree.
>
> That really looks like a broken hierarchy of devices somewhere.

Why do you think it's a broken hierarchy? This CL has the heirarchy:
https://chromium-review.googlesource.com/#/c/359432/

There is a device, P2S, which would result in an ACPI companion device
when the pci_dev is added to the device infrastructure by way of
acpi_platform_notify() which does the ACPI companion binding.
device_add() is the caller of platform_notify() which is set to
acpi_platform_notify() in init_acpi_device_notify() by way of
acpi_init().

There are 4 children of the P2S device: GPO0, GPO1, GPO2, GPO3.

Those children devices utilize a sub-resource of the P2S device which
has a pci_dev companion. It's BAR0 is the resource.

>
> And one more thing: a struct acpi_device object is not a device in general
> (althogh some pieces of code in the kernel, arguably incorrectly, treat it
> this way).  It is an abstract representation of a firmware entity (a node
> in the ACPI namespace).
>
> There really should be a "physical device" thing corresponding to it and
> that should be a child of the PCI device object in question.

I thought I established that by the sysfs readlink I output I
previously provided?

# ls /sys/devices/platform/| grep INT3452
INT3452:00
INT3452:01
INT3452:02
INT3452:03

# ls /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:11 | grep INT3452
INT3452:00
INT3452:01
INT3452:02
INT3452:03

# readlink -f /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:11/INT3452:00/physical_node
/sys/devices/platform/INT3452:00


>
>> > Do we assign BARs for endpoints during enumeration or only when we find a
>> > matching driver?
>>
>> BARs look to be assigned during enumeration. There's where conflicts
>> are found and resources reassigned in the current failing case.
>
> OK
>
> You seem to be saying that we insert some resources for ACPI device objects
> that correspond to the children of ACPI companions of PCI devices before we
> assign the BARs for their parent devices.

The pci_dev is the one owning the parent resource. Even if there is a
companion ACPI device with a resource it doesn't matter because there
will still be a conflict because there is no checking against the
companion. There are 2 parallel entities without any communication
between the PCI subsystem and the ACPI subsystem when resources are
being added.

>
> To me, that sounds very suspicious.
>
> Where in the code are the ACPI resources inserted, exactly?

I believe it's through this mechanism:
acpi_bus_attach() -> acpi_default_enumeration() ->
acpi_create_platform_device() -> platform_device_register_full()


>
> Thanks,
> Rafael
>
