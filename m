Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49221 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2EVVVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 17:21:14 -0400
Received: by dady13 with SMTP id y13so8779464dad.19
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 14:21:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
Date: Tue, 22 May 2012 14:21:13 -0700
Message-ID: <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jason Baron <jbaron@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 1:11 PM, Jason Baron <jbaron@redhat.com> wrote:
> I'm tyring to support bridge hotplug and devices below it in qemu via acpi
> hotplug. Currently only 1 level or 32 slots are supported. By allowing for a
> second level, we will be able to support 32^2 devices.
>
> If I first hotplug the bridge with no devices intially below it, the hotplug
> code sets the bridge memory window to 0 and does not increase it when
> subsequent devices are added below it.
>
> Fix this, by calling pci_rescan_bus_bridge_resize(), on the bridge directly
> below the root to re-size all the birdge windows that may have changed.
>
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 806c44f..8960c1e 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -792,6 +792,7 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>  {
>        struct pci_dev *dev;
>        struct pci_bus *bus = slot->bridge->pci_bus;
> +       struct pci_bus *rescan_bus;
>        struct acpiphp_func *func;
>        int retval = 0;
>        int num, max, pass;
> @@ -821,6 +822,13 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>                }
>        }
>
> +       /* Ensure we rescan/setup a bridge for new devs hanging off of it */
> +       rescan_bus = bus;
> +       while (rescan_bus->parent && rescan_bus->parent->self)
> +               rescan_bus = rescan_bus->parent;
> +       if (rescan_bus->self)
> +               pci_rescan_bus_bridge_resize(rescan_bus->self);
> +

No, you can not do that.  some parents bus could have other devices
and driver could be loaded for those devices.
so can not release resources that are used by those devices to resize
parent bridges.

>        list_for_each_entry(func, &slot->funcs, sibling)
>                acpiphp_bus_add(func);
>
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
