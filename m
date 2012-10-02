Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61984 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab2JBVrr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 17:47:47 -0400
Received: by bkcjk13 with SMTP id jk13so5770080bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 14:47:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002204548.GC28663@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<1349159588-15029-2-git-send-email-yinghai@kernel.org>
	<20121002133303.GA502@kroah.com>
	<CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
	<20121002174712.GA11843@kroah.com>
	<CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
	<20121002204548.GC28663@kroah.com>
Date: Tue, 2 Oct 2012 14:47:45 -0700
Message-ID: <CAE9FiQV51R2RBAZBPobDifq6jQUhBCyx_Bo8EHxOX4yrUMSnLg@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
From: Yinghai Lu <yinghai@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 1:45 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 02, 2012 at 01:20:58PM -0700, Yinghai Lu wrote:
>> On Tue, Oct 2, 2012 at 10:47 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Tue, Oct 02, 2012 at 10:39:25AM -0700, Yinghai Lu wrote:
>> >> On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
>> >> Those patches address Bjorn's request:
>> >> 1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
>> >> 2. register pci device to device as soon as possible, so for_each_pci_device
>> >>    could be used early before pci_bus_add_devices.
>> >>
>> >> please check change log patch2-4.
>> >
>> > Sorry, I still don't see what is so special about PCI that they have to
>> > do something different here.  What am I missing?
>>
>> That is something that core related with hotplug:
>>
>> for booting and hotplug, we have different code path.
>> 1. for booting, all device are enumerated and registered, and later
>> driver get registered, driver is attached to the devices.
>> 2. for hotplug, one device on the bus is found, and then registered
>> and driver is attached, after that
>>                      another device on the bus is found, and then
>> registered and driver is attached...
>>
>> The reason for the difference, device driver is not registered later
>> during booting path.
>
> But on each case, the code path in the driver core is the same, and you
> don't know if for 1) a driver is not already registered in the system
> (think drivers built into the kernel).

different level initcall or link sequence make sure that in order. aka
bus_type come first before driver of that bus type.

>
>> We should make the two path have same sequence. the solution that I
>> suggest is adding per device drivers_autoprobe.
>
> No, now you have 2 code paths in the driver core, do not do that.

no, reduce 2 to 1.

>
>> and thanking for bus_type notifier that we could toggle that bit
>> during device_add, so could make all device on same
>> bus get probed and registered but driver get skipped. and after that
>> call device_attach for all device at one batch.
>>
>> That will remove those hotplug related hacks like acpi_pci_root_start
>> that try to delay registering of pci devices.
>> and make the code lesser and readable.
>
> I don't know what you are doing in the acpi code, but I do not think it
> requires a driver core change like this.
>
> Again, why is PCI different from any other bus type?  (hint, it
> shouldn't be...)

it is not pci susbsystem problem.

the problem come from device-driver core for hotplug handling, and
acpi system is
forcing pci system to split the scan and registering.
aka: to scan all pci device under one pci_root from acpi_pci_root_add.
then do pci_bus_add_devices for that bus in acpi_pci_root_start.

on hotplug path:
when acpi enumerating acpi devices, it will create acpi_device for pci_root,
then probe driver for that device : acpi_pci_root_driver.
<at that time no acpi_device under that pci_root acpi device is created>
device_add for root acpi_device will call bus_probe_device and ... and execute
acpi_pci_root_driver .add aka acpi_pci_root_add.
acpi_pci_root_add will call pci_acpi_scan_root. that will scan pci
root bus to find all
pci devices but does not add those pci device into devices.
If at the time device_add for pci device get called, platform_notify
will try to bind pci_dev
with acpi devices, but corresponding acpi device is not created yet.
that bind will fail.
So acpi_driver introduce .start in ops to add pci device later.

The patches will hold that acpi_driver for root to be probed for root
to early. aka
make sure all acpi devices come first, then probe driver for acpi device one by.
In that case we don' t need subsystem to introduce .start to hold add
device for next level.

Now HOTPLUG is enabled forcely, and bus_type add notifier help to
control that device
drivers_autoprobe during device hot add.

Thanks

Yinghai
