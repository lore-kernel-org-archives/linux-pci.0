Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54095 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbG2Tqs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 15:46:48 -0400
Message-ID: <55B92DA5.4030409@roeck-us.net>
Date: Wed, 29 Jul 2015 12:46:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>	<20150729160903.GD31170@google.com> <CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
In-Reply-To: <CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/29/2015 12:30 PM, Yinghai Lu wrote:
> On Wed, Jul 29, 2015 at 9:09 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jul 07, 2015 at 11:11:20AM -0700, Guenter Roeck wrote:
>>> The PCI subsystem always assumes that I/O is supported on PCIe bridges
>>> and tries to assign an I/O window to each child bus even if that is not
>>> the case.
>>>
>>> This may result in messages such as
>>>
>>> pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff]
>>>                                        get_res_add_size add_size 1000
>>> pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
>>> pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
>>>
>>
>> Applied to pci/resource for v4.3, thanks!
>>> @@ -340,6 +369,23 @@ static void pci_read_bridge_io(struct pci_bus *child)
>>>        struct pci_bus_region region;
>>>        struct resource *res;
>>>
>>> +     if (child->bus_flags & PCI_BUS_FLAGS_NO_IO)
>>> +             return;
>>> +
>>> +     if (!pci_bus_supports_io(child)) {
>>> +             dev_printk(KERN_DEBUG, &dev->dev,
>>> +                        "  bus does not support IO\n");
>>> +             child->bus_flags |= PCI_BUS_FLAGS_NO_IO;
>>> +             return;
>>> +     }
>>> +
>>> +     if (!pci_root_has_io_resource(child)) {
>>> +             dev_printk(KERN_DEBUG, &dev->dev,
>>> +                        "  no IO window on root bus\n");
>>> +             child->bus_flags |= PCI_BUS_FLAGS_NO_IO;
>>> +             return;
>>> +     }
>>> +
>>>        io_mask = PCI_IO_RANGE_MASK;
>>>        io_granularity = 0x1000;
>>>        if (dev->io_window_1k) {
>
> Hi Bjorn,
>
> Looks like you flip the PCI_BUS_FLAGS_NO_IO to
> PCI_BUS_FLAGS_SUPPORT_IO, and now have
>
> @@ -340,6 +373,21 @@ static void pci_read_bridge_io(struct pci_bus *child)
>          struct pci_bus_region region;
>          struct resource *res;
>
> +       if (!(child->bus_flags & PCI_BUS_FLAGS_SUPPORTS_IO))
> +               return;
> +
> +       if (!pci_bridge_supports_io(dev)) {
> +               dev_printk(KERN_DEBUG, &dev->dev, "  no I/O window\n");
> +               return;
> +       }
> +
> +       if (!pci_root_has_io_resource(child)) {
> +               dev_printk(KERN_DEBUG, &dev->dev, "  no I/O resource
> on root bus\n");
> +               return;
> +       }
> +
> +       child->bus_flags |= PCI_BUS_FLAGS_SUPPORTS_IO;
> +
>
> so PCI_BUS_FLAGS_SUPPORTS_IO will never get set.
>

Hi Yinghai,

excellent catch. Unfortunately, I don't know how to make it
work with the reversed flag. The idea here was that the flag
propagates from parent to child. This makes sense for an
"it doesn't work" flag to be inherited from the child,
but not for an "it works" flag.

Guenter

