Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54938 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab2JBUpu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 16:45:50 -0400
Date: Tue, 2 Oct 2012 13:45:48 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
Message-ID: <20121002204548.GC28663@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org>
 <20121002133303.GA502@kroah.com>
 <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
 <20121002174712.GA11843@kroah.com>
 <CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 02, 2012 at 01:20:58PM -0700, Yinghai Lu wrote:
> On Tue, Oct 2, 2012 at 10:47 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Oct 02, 2012 at 10:39:25AM -0700, Yinghai Lu wrote:
> >> On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
> >> Those patches address Bjorn's request:
> >> 1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
> >> 2. register pci device to device as soon as possible, so for_each_pci_device
> >>    could be used early before pci_bus_add_devices.
> >>
> >> please check change log patch2-4.
> >
> > Sorry, I still don't see what is so special about PCI that they have to
> > do something different here.  What am I missing?
> 
> That is something that core related with hotplug:
> 
> for booting and hotplug, we have different code path.
> 1. for booting, all device are enumerated and registered, and later
> driver get registered, driver is attached to the devices.
> 2. for hotplug, one device on the bus is found, and then registered
> and driver is attached, after that
>                      another device on the bus is found, and then
> registered and driver is attached...
> 
> The reason for the difference, device driver is not registered later
> during booting path.

But on each case, the code path in the driver core is the same, and you
don't know if for 1) a driver is not already registered in the system
(think drivers built into the kernel).

> We should make the two path have same sequence. the solution that I
> suggest is adding per device drivers_autoprobe.

No, now you have 2 code paths in the driver core, do not do that.

> and thanking for bus_type notifier that we could toggle that bit
> during device_add, so could make all device on same
> bus get probed and registered but driver get skipped. and after that
> call device_attach for all device at one batch.
> 
> That will remove those hotplug related hacks like acpi_pci_root_start
> that try to delay registering of pci devices.
> and make the code lesser and readable.

I don't know what you are doing in the acpi code, but I do not think it
requires a driver core change like this.

Again, why is PCI different from any other bus type?  (hint, it
shouldn't be...)

greg k-h
