Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58692 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2GCSQq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 14:16:46 -0400
Received: by vbbff1 with SMTP id ff1so4421606vbb.19
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2012 11:16:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120703173316.7bf169cf.izumi.taku@jp.fujitsu.com>
References: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
	<CAE9FiQUb1rtLYAWZ=iMok+FGsJh7NcRGxGoD8eLLEOrKQsWsHw@mail.gmail.com>
	<20120703173316.7bf169cf.izumi.taku@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 11:16:45 -0700
Message-ID: <CAE9FiQWOWaQyJHcOfWF5eRMD_cf523zUo8S_kSofWuQynpoQ+w@mail.gmail.com>
Subject: Re: [PATCH] pci: reserve extra bus number resource for hotplug bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 3, 2012 at 1:33 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Hi Yinghai,
> Thank you for your comment.
>
> On Mon, 2 Jul 2012 13:51:59 -0700
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> On Sun, Jul 1, 2012 at 9:49 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>> >
>> > Currently I/O ports and I/O memory resources are reserved for
>> > hotplug bridges and we can tune their size by using hpiosize
>> > and hpmemsize boot option.
>> >
>> > This patch extends feature so that we can reserve additional
>> > bus number resources for hotplug bridges and tune it by
>> > using "hpbussize" option.
>> >
>> > This patch also adds missing document for "hpiosize" and
>> > "hpmemsize" option.
>> >
>> > Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> > ---
>> >  Documentation/kernel-parameters.txt |   10 ++++++++++
>> >  drivers/pci/pci.c                   |    6 +++++-
>> >  drivers/pci/probe.c                 |    4 ++++
>> >  include/linux/pci.h                 |    1 +
>> >  4 files changed, 20 insertions(+), 1 deletion(-)
>> >
>> > Index: linux/drivers/pci/pci.c
>> > ===================================================================
>> > --- linux.orig/drivers/pci/pci.c
>> > +++ linux/drivers/pci/pci.c
>> > Index: linux/drivers/pci/probe.c
>> > ===================================================================
>> > --- linux.orig/drivers/pci/probe.c
>> > +++ linux/drivers/pci/probe.c
>> > @@ -865,6 +865,10 @@ int __devinit pci_scan_bridge(struct pci
>> >                 /*
>> >                  * Set the subordinate bus number to its real value.
>> >                  */
>> > +               if (dev->is_hotplug_bridge) {
>> > +                       if (max + pci_hotplug_bus_size < child->busn_res.end)
>> > +                               max += pci_hotplug_bus_size;
>> > +               }
>> >                 pci_bus_update_busn_res_end(child, max);
>> >                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
...
>   I don't think this feature conflicts with your feature.
>   Even if we can reallocate bus number automatically, I'd like to
>   avoid that situation preferably, so I'd like to keep bus number
>   resource for hotplug bridge in advance.
>
>   Can't you agree with me?
>

that add may not be safe, before busn_alloc patchset, that
busn_res.end should be 0xff.
so you add extra bus range that could overlap other bridge.

after busn_alloc patchset:

                /*
                 * Set the subordinate bus number to its real value.
                 */
                if (dev->is_hotplug_bridge && child->busn_res.end > max &&
                   (max - child->busn_res.start) < HOTPLUG_BRIDGE_RESERVE_BUSNR)
                        max = min_t(int, child->busn_res.start +
                                         HOTPLUG_BRIDGE_RESERVE_BUSNR,
                                    child->busn_res.end);
                shrink_size = (int)child->busn_res.end - max;
                pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
                pci_bus_update_busn_res_end(child, max);

and it will try to shrink less to preserve more space for later usage.
now

#define HOTPLUG_BRIDGE_RESERVE_BUSNR 8

so I assume that you want that value to be changeable via command line?

Thanks

Yinghai
