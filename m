Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44930 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbbABXNl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jan 2015 18:13:41 -0500
MIME-Version: 1.0
In-Reply-To: <5205206.j8Q9x4GQsU@wuerfel>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <2308474.mrIrUSfiTv@wuerfel> <CAL_JsqJbUHkr0zXYKTvS0WPGs7mNqkppsn4i0LuWz5Wv12Unmw@mail.gmail.com>
 <5205206.j8Q9x4GQsU@wuerfel>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 2 Jan 2015 17:13:19 -0600
Message-ID: <CAL_JsqKj3KCwgtb8SViiAFSqhOS0gSq2gLQU1G3kFmV6o=q5iQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] pci: add DT based ARM Versatile PCI host driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"arm@kernel.org" <arm@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 2, 2015 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 02 January 2015 12:14:43 Rob Herring wrote:
>> On Tue, Dec 30, 2014 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 30 December 2014 13:28:33 Rob Herring wrote:
>> >> From: Rob Herring <robh@kernel.org>
>> >>
>> >> This converts the Versatile PCI host code to a platform driver using
>> >> the commom DT parsing and setup. The driver uses only an empty ARM
>> >> pci_sys_data struct and does not use pci_common_init_dev init function.
>> >> The old host code will be removed in a subsequent commit when Versatile
>> >> is completely converted to DT.
>> >>
>> >> I've tested this on QEMU with the sym53c8xx driver in both i/o and
>> >> memory mapped modes.
>> >
>> > Ah, this is quite clever, I think you tried to explain to me what you
>> > did with the pci_sys_data before, but I didn't get it then.
>> >
>> >> +
>> >> +static void __iomem *__pci_addr(struct pci_bus *bus,
>> >> +                             unsigned int devfn, int offset)
>> >> +{
>> >> +     unsigned int busnr = bus->number;
>> >> +
>> >> +     /*
>> >> +      * Trap out illegal values
>> >> +      */
>> >> +     BUG_ON(offset > 255);
>> >> +     BUG_ON(busnr > 255);
>> >> +     BUG_ON(devfn > 255);
>> >
>> > Isn't an offset>255 something that can be triggered by a non-broken
>> > driver or even user space?
>>
>> I don't know. I just copied what the old driver did. Are these checks
>> even host controller specific?
>
> A busnr or devfn larger than 255 would be a serious bug on any host
> controller, those just don't exist. A BUG_ON check here is not a problem,
> but if we want to have it, I'd prefer to put it into the core code.

Agreed.

> offset values between 256 and 4095 can be valid on some devices, but
> apparently this host controller does not support them.

I'm going to drop the checks. The only checks I see in other drivers
are for the bus number to match the root bus which I'm not convinced
are needed either.

>> > Maybe just return PCIBIOS_BAD_REGISTER_NUMBER in this case?
>>
>> Perhaps. We could probably simplify the config space read/write
>> functions and just provide the PCI core a bus/devfn/offset to config
>> address translation function. That would not work in all cases, but
>> propably most that have memory mapped config space.
>
> Actually, thinking about this some more, the implementation seems to
> be "CAM" compliant, and we could share the confic space accessors with
> the ones from drivers/pci/host/pci-host-generic.c.

Almost. It uses readl for all size accesses. Yet writes support
different access sizes. I would guess that the h/w can support byte
and word reads if writes are supported, but I can't really verify.
Dword-only sized reads or reads and writes seem to be the main
variations for config space accesses. There's a few hosts with more
complex config space access setup, but quite a few only vary in
address decode.

>> >> +static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
>> >> +                                                  struct list_head *res)
>> >> +{
>> >> +     int err, mem = 1, res_valid = 0;
>> >> +     struct device_node *np = dev->of_node;
>> >> +     resource_size_t iobase;
>> >> +     struct pci_host_bridge_window *win;
>> >> +
>> >> +     err = of_pci_get_host_bridge_resources(np, 0, 0xff, res, &iobase);
>> >> +     if (err)
>> >> +             return err;
>> >> +
>> >> +     list_for_each_entry(win, res, list) {
>> >> +             struct resource *parent, *res = win->res;
>> >> +
>> >> +             switch (resource_type(res)) {
>> >> +             case IORESOURCE_IO:
>> >> +                     parent = &ioport_resource;
>> >> +                     err = pci_remap_iospace(res, iobase);
>> >> +                     if (err) {
>> >> +                             dev_warn(dev, "error %d: failed to map resource %pR\n",
>> >> +                                      err, res);
>> >> +                             continue;
>> >> +                     }
>> >> +                     break;
>> >> +             case IORESOURCE_MEM:
>> >> +                     parent = &iomem_resource;
>> >> +                     res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>> >> +
>> >> +                     writel(res->start >> 28, PCI_IMAP(mem));
>> >> +                     writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
>> >> +                     mem++;
>> >> +
>> >> +                     break;
>> >> +             case IORESOURCE_BUS:
>> >> +             default:
>> >> +                     continue;
>> >> +             }
>> >> +
>> >> +             err = devm_request_resource(dev, parent, res);
>> >> +             if (err)
>> >> +                     goto out_release_res;
>> >> +     }
>> >
>> > I wonder if we should also request the physical resource for the I/O space
>> > window to have it show up in /proc/iomem. We are rather inconsistent in this
>> > regard between drivers.
>>
>> It's a little complicated now because we don't have that as a struct
>> resource any more. We could reconstruct it from iobase and the i/o
>> resource size.
>
>
>
>> >> +     pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
>> >> +     pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
>> >> +
>> >> +     bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, &sys, &pci_res);
>> >> +     if (!bus)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> >> +     pci_assign_unassigned_bus_resources(bus);
>> >> +
>> >> +     return 0;
>> >
>> > One general question, mainly for Bjorn: pci_scan_root_bus adds all the devices
>> > at the Linux driver level by calling pci_bus_add_devices(), but then we call
>> > pci_fixup_irqs and pci_assign_unassigned_bus_resources after that, which will
>> > change the devices again. Is this how it's meant to work? How do we ensure
>> > that we have the correct irq number and resources by the time we enter the
>> > probe() function of the PCI device driver that gets bound to a device here?
>>
>> I'm a bit puzzled myself. I think that the devices are not probed
>> until after pci_assign_unassigned_bus_resources. It certainly doesn't
>> work without that call. Really, I think of_irq_parse_and_map_pci
>> should be the default if no one else has set the device's irq (and the
>> host has a device node of course).
>>
>> It also seems to be a bit of random set of pci functions that are
>> called here. It would be nice to simplify this chunk of code.
>
> Yes, and we recently had some attempts at creating a better interface posted
> on the mailing list, not sure what the latest status on it is. I think we
> want to end up with a two-stage interface along the lines of:
>
>         /* allocate a pci_host_bridge, scan DT, set default operations, map
>            I/O space if necessary, request all resources ... */
>         phb = pci_host_bridge_create(parent, ..., sizeof(struct my_pci_private));

Humm, I wondered what happened to pci_host_bridge_create and thought
we had abandoned it. It wasn't too clear reading thru the threads. The
host drivers generally still have to walk thru the resources anyway to
setup inbound and outbound windows, so we don't gain too much moving
that out. And the error clean-up gets complicated too.

Rob
