Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44728 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2JBUVA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 16:21:00 -0400
Received: by bkcjk13 with SMTP id jk13so5735296bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 13:20:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002174712.GA11843@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<1349159588-15029-2-git-send-email-yinghai@kernel.org>
	<20121002133303.GA502@kroah.com>
	<CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
	<20121002174712.GA11843@kroah.com>
Date: Tue, 2 Oct 2012 13:20:58 -0700
Message-ID: <CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
From: Yinghai Lu <yinghai@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 10:47 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 02, 2012 at 10:39:25AM -0700, Yinghai Lu wrote:
>> On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
>> Those patches address Bjorn's request:
>> 1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
>> 2. register pci device to device as soon as possible, so for_each_pci_device
>>    could be used early before pci_bus_add_devices.
>>
>> please check change log patch2-4.
>
> Sorry, I still don't see what is so special about PCI that they have to
> do something different here.  What am I missing?

That is something that core related with hotplug:

for booting and hotplug, we have different code path.
1. for booting, all device are enumerated and registered, and later
driver get registered, driver is attached to the devices.
2. for hotplug, one device on the bus is found, and then registered
and driver is attached, after that
                     another device on the bus is found, and then
registered and driver is attached...

The reason for the difference, device driver is not registered later
during booting path.

We should make the two path have same sequence. the solution that I
suggest is adding per device drivers_autoprobe.

and thanking for bus_type notifier that we could toggle that bit
during device_add, so could make all device on same
bus get probed and registered but driver get skipped. and after that
call device_attach for all device at one batch.

That will remove those hotplug related hacks like acpi_pci_root_start
that try to delay registering of pci devices.
and make the code lesser and readable.

Thanks

Yinghai
