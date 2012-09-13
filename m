Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53386 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758221Ab2IMQnf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 12:43:35 -0400
Received: by lagy9 with SMTP id y9so2075098lag.19
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2012 09:43:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <503DD9A7.70007@huawei.com>
References: <503DD9A7.70007@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Sep 2012 10:43:13 -0600
Message-ID: <CAErSpo7JknWsMGpYnxyLqmLQO5Xr5jMGYnpgdCmEjYWN-=5vjA@mail.gmail.com>
Subject: Re: a small problem about pci_stop_and_remove_bus_device() function
To: Yijing Wang <wangyijing@huawei.com>
Cc: PCI <linux-pci@vger.kernel.org>, Jiang Liu <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2012 at 2:58 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Hi Bjorn,
>    The drivers/pci/remove.c now is so clean after applied series "[PATCH v2 00/16] Clean up drivers/pci/remove.c"(very good ^_^).
> I have a small problem about pci_stop_and_remove_bus_device() function. Traditionally, pci_bus is removed after its pci bridge stop.
> But now pci_bus is remove before its pci brdige.

Let me restate this to make sure I understand the problem.  Prior to
my cleanups, the flow when removing a bridge device was like this:

    pci_stop_and_remove_bus_device(bridge)
        pci_stop_bus_device(bridge)
            pci_stop_bus_devices(bridge->subordinate)
            pci_stop_dev(bridge)
                device_unregister(bridge->dev)
                    device_del(bridge->dev)
                        blocking_notifier_call_chain(pci_bus_type, ...)
                            <notifier>
                                if (dev->bus == &pci_bus_type)
                                    pdev = to_pci_dev(dev)
                                    if (pdev->subordinate)
                                        ...
        __pci_remove_bus_device(bridge)
            if (bridge->subordinate)
                pci_remove_bus(bridge->subordinate)
                bridge->subordinate = NULL

After my changes, the flow is like this:

    pci_stop_and_remove_bus_device(bridge)
        pci_remove_bus(bridge->subordinate)
        bridge->subordinate = NULL
        pci_stop_dev(bridge)
            device_unregister(bridge->dev)
                device_del(bridge->dev)
                    blocking_notifier_call_chain(pci_bus_type, ...)
                        <notifier>
                            if (dev->bus == &pci_bus_type)
                                pdev = to_pci_dev(dev)
                                if (pdev->subordinate)
                                    ** broken because
pdev->subordinate is always NULL **

The problem is that before, a notifier could check "dev->subordinate"
to identify a bridge device, but now, "dev->subordinate" has already
been cleared by the time the notifier runs, so that test no longer
identifies bridges.

I didn't intend this change in behavior, so in that sense, this is a
regression.  We could restore the previous behavior by changing
pci_stop_and_remove_bus_device() so the "pci_remove_bus();
dev->subordinate = NULL;" code is after the pci_stop_dev() call, as
you suggest.

But I'm not 100% sure that's the correct fix.  I think it's possible
to have a bridge device that has no secondary bus.  For example, I
don't think a bridge configured with "secondary > subordinate", e.g.,
"[bus ff-00]", will forward any config transactions downstream.  In
that case, we'll have a struct pci_dev for the bridge device, but
there won't be a struct pci_bus for the secondary bus, so
dev->subordinate will be NULL.  There are actually quite a few
existing tests for this situation in pnv_ioda_setup_bus_PE(),
eeh_add_device_tree_late(), yenta_probe(), etc.

When we enumerate bridges, we build the bridge pci_dev before building
the downstream pci_bus, so symmetry suggests that we should tear down
the pci_bus before tearing down the pci_dev.

So I wonder if a better fix is remove the assumption that
"dev->subordinate != NULL means this is a bridge device."  There are
many places where we test "dev->subordinate" to iterate through
downstream devices or something similar; those should be fine.  We'd
only have to change the places that care about actual type of the
device, e.g., the config space differences between header types.

Where did you trip over this?  If you just found this by inspection,
my congratulations, it's a pretty subtle issue :)

> So If I use pci_bus_type notifier, I can't identify pci_dev whether is bridge(by pci_dev->subordinate)
> when notifier arrives.
>    What about move pci_remove_bus after stop pci bridge?
>
>  82     if (bus) {
>  83         list_for_each_entry_safe_reverse(child, tmp,
>  84                          &bus->devices, bus_list)
>  85             pci_stop_and_remove_bus_device(child);
>  86
>  87     }
>  88
>  89     pci_stop_dev(dev);
>  90     if (bus) {
>  91         pci_remove_bus(bus);
>  92         dev->subordinate = NULL;
>  93     }
>  94     pci_destroy_dev(dev);
>
>
> --
> Thanks!
> Yijing
>
