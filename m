Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:37923 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2JBWiX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 18:38:23 -0400
Received: by lagh6 with SMTP id h6so2656803lag.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 15:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV51R2RBAZBPobDifq6jQUhBCyx_Bo8EHxOX4yrUMSnLg@mail.gmail.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org> <20121002133303.GA502@kroah.com>
 <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
 <20121002174712.GA11843@kroah.com> <CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
 <20121002204548.GC28663@kroah.com> <CAE9FiQV51R2RBAZBPobDifq6jQUhBCyx_Bo8EHxOX4yrUMSnLg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Oct 2012 16:38:01 -0600
Message-ID: <CAErSpo5EuGVhu_ObioV-4n7930MkJzD9jrtkn6-JdBLikDBmMg@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 3:47 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Oct 2, 2012 at 1:45 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:

>> I don't know what you are doing in the acpi code, but I do not think it
>> requires a driver core change like this.
>>
>> Again, why is PCI different from any other bus type?  (hint, it
>> shouldn't be...)
>
> it is not pci susbsystem problem.
>
> the problem come from device-driver core for hotplug handling, and
> acpi system is
> forcing pci system to split the scan and registering.
> aka: to scan all pci device under one pci_root from acpi_pci_root_add.
> then do pci_bus_add_devices for that bus in acpi_pci_root_start.

I don't believe there's anything in ACPI that forces this split
between scanning and registering.

Certainly we have Linux *implementation* issues that currently lead us
to split them, but I don't think those are forced by the hardware or
the spec.  I'd rather address those implementation issues than add
band-aids.

> on hotplug path:
> when acpi enumerating acpi devices, it will create acpi_device for pci_root,
> then probe driver for that device : acpi_pci_root_driver.
> <at that time no acpi_device under that pci_root acpi device is created>
> device_add for root acpi_device will call bus_probe_device and ... and execute
> acpi_pci_root_driver .add aka acpi_pci_root_add.
> acpi_pci_root_add will call pci_acpi_scan_root. that will scan pci
> root bus to find all
> pci devices but does not add those pci device into devices.
> If at the time device_add for pci device get called, platform_notify
> will try to bind pci_dev
> with acpi devices, but corresponding acpi device is not created yet.
> that bind will fail.
> So acpi_driver introduce .start in ops to add pci device later.

We enumerate ACPI devices by doing a depth-first traversal of the
namespace.  We should be able to bind a driver to a device as soon as
we discover it.  For PNP0A03/08 host bridges, that will be the
pci_root.c driver.  That driver's .add() method enumerates all the PCI
devices behind the host bridge, which is another depth-first
traversal, this time of the PCI hierarchy.  Similarly, we ought to be
able to bind drivers to the PCI devices as we discover them.

But the PCI/ACPI binding is an issue here, because the ACPI
enumeration hasn't descended below the host bridge yet, so we have the
pci_dev structs but the acpi_device structs don't exist yet.  I think
this is part of the reason for the .add()/.start() split.  But I don't
think the split is the correct solution.  I think we need to think
about the binding in a different way.  Maybe we don't bind at all and
instead search the namespace every time we need the association.  Or
maybe we do the binding but base it on the acpi_handle (which exists
before the ACPI subtree has been enumerated) rather than the
acpi_device (which doesn't exist until we enumerate the subtree).
It's not even clear to me that we should build acpi_device structs for
things that already have pci_dev structs.

I don't know what the right answer is, but I do think it's better to
resolve it inside PCI and ACPI rather than playing games with driver
binding times in the driver core.

Bjorn
