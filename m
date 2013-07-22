Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56487 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316Ab3GVVXu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:23:50 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so16704450ief.12
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2013 14:23:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374261258-23036-2-git-send-email-yinghai@kernel.org>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org> <1374261258-23036-2-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Jul 2013 15:23:30 -0600
Message-ID: <CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Evidently this is really part of a series, but you didn't label it
that way.  It looks like this applies on top of your "PCI: Fix hotplug
remove with sriov again" patch?

On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> (PCI: Simplify IOV implementation and fix reference count races)
> VF need to be removed via virtfn_remove to make sure ref to PF
> is put back.

I'm sure this makes sense, but it needs background.  I haven't figured
out exactly what the problem is.  You're describing the lowest-level
details, but not the overall picture that would make it understandable
to the rest of us.

> So we can not call stop_and_remove for VF before PF, that will
> make VF get removed directly before PF's driver try to use
> virtfn_remove to do it.
>
> Solution is separating stop and remove in two iterations.
>
> In first iteration, we stop VF driver at first with iterating devices
> reversely, and later during stop PF driver, disable_sriov will use
> virtfn_remove to remove VFs.
>
> Also some driver (like mlx4_core) need VF's driver get stopped before PF.

If this is relevant, please give a pointer to the mlx4_core code that
requires VFs to be stopped before the PF.

> To make it simple, separate VGA checking out and do that at first,
> if there is VGA in the chain, do even try to stop or remove any device
> under that bus.

This part seems like it could be a separate patch.

> Need this one for v3.11.

OK, but why?  We need a better explanation of what problem this fixes.
 It sounds like it fixes a reference counting problem in v3.11-rc1,
but I don't know what the effect of that problem is.  Maybe it means a
device isn't freed when it should be?  Maybe it means we can't add a
new device after hot-removing an SR-IOV device?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Yijing Wang <wangyijing@huawei.com>
> Cc: Jiang Liu <liuj97@gmail.com>
>
> ---
>  drivers/pci/hotplug/pciehp_pci.c |   46 ++++++++++++++++++++++++++-------------
>  drivers/pci/remove.c             |    6 +++--
>  include/linux/pci.h              |    2 +
>  3 files changed, 37 insertions(+), 17 deletions(-)
>
> Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
> @@ -92,26 +92,37 @@ int pciehp_unconfigure_device(struct slo
>         if (ret)
>                 presence = 0;
>
> +       /* check if VGA is around */
> +       if (presence) {
> +               list_for_each_entry(dev, &parent->devices, bus_list) {
> +                       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +                               pci_read_config_byte(dev, PCI_BRIDGE_CONTROL,
> +                                                       &bctl);
> +                               if (bctl & PCI_BRIDGE_CTL_VGA) {
> +                                       ctrl_err(ctrl,
> +                                                "Cannot remove display device %s\n",
> +                                                pci_name(dev));
> +                                       return -EINVAL;
> +                               }
> +                       }
> +               }
> +       }
> +
>         /*
> -        * Need to iterate device reversely, as during
> +        * Now VF need to be removed via virtfn_remove to make
> +        * sure ref to PF is put back. Some driver (mlx4_core) need
> +        * VF's driver get stopped before PF.
> +        * So we need to stop VF driver at first, that means
> +        * loop reversely, and later during stop PF driver,
> +        * disable_sriov will use virtfn_remove to remove VFs.
> +        * Also we can not loop without reverse, as during
>          * stop PF driver, VF will be removed, the list_for_each
>          * could point to removed VF with temp.
>          */
>         list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> -                                        bus_list) {
> -               pci_dev_get(dev);
> -               if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
> -                       pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
> -                       if (bctl & PCI_BRIDGE_CTL_VGA) {
> -                               ctrl_err(ctrl,
> -                                        "Cannot remove display device %s\n",
> -                                        pci_name(dev));
> -                               pci_dev_put(dev);
> -                               rc = -EINVAL;
> -                               break;
> -                       }
> -               }
> -               pci_stop_and_remove_bus_device(dev);
> +                                                bus_list) {
> +               pci_stop_bus_device(dev);
> +
>                 /*
>                  * Ensure that no new Requests will be generated from
>                  * the device.
> @@ -122,6 +133,11 @@ int pciehp_unconfigure_device(struct slo
>                         command |= PCI_COMMAND_INTX_DISABLE;
>                         pci_write_config_word(dev, PCI_COMMAND, command);
>                 }
> +       }
> +
> +       list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
> +               pci_dev_get(dev);
> +               pci_remove_bus_device(dev);
>                 pci_dev_put(dev);
>         }
>
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_remove_bus);
>
> -static void pci_stop_bus_device(struct pci_dev *dev)
> +void pci_stop_bus_device(struct pci_dev *dev)
>  {
>         struct pci_bus *bus = dev->subordinate;
>         struct pci_dev *child, *tmp;
> @@ -75,8 +75,9 @@ static void pci_stop_bus_device(struct p
>
>         pci_stop_dev(dev);
>  }
> +EXPORT_SYMBOL(pci_stop_bus_device);
>
> -static void pci_remove_bus_device(struct pci_dev *dev)
> +void pci_remove_bus_device(struct pci_dev *dev)
>  {
>         struct pci_bus *bus = dev->subordinate;
>         struct pci_dev *child, *tmp;
> @@ -92,6 +93,7 @@ static void pci_remove_bus_device(struct
>
>         pci_destroy_dev(dev);
>  }
> +EXPORT_SYMBOL(pci_remove_bus_device);

I really don't want to export these two symbols unless we have to.
Obviously this is the heart of your patch, so we probably *will* have
to.

But maybe they can at least be confined to drivers/pci code, and not
exported to modules?  I don't think there's any reason pciehp needs to
be a module.  I was planning to merge a patch restricting it to be
built-in this cycle anyway.

>  /**
>   * pci_stop_and_remove_bus_device - remove a PCI device and any children
> Index: linux-2.6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pci.h
> +++ linux-2.6/include/linux/pci.h
> @@ -754,6 +754,8 @@ u8 pci_common_swizzle(struct pci_dev *de
>  struct pci_dev *pci_dev_get(struct pci_dev *dev);
>  void pci_dev_put(struct pci_dev *dev);
>  void pci_remove_bus(struct pci_bus *b);
> +void pci_stop_bus_device(struct pci_dev *dev);
> +void pci_remove_bus_device(struct pci_dev *dev);
>  void pci_stop_and_remove_bus_device(struct pci_dev *dev);
>  void pci_stop_root_bus(struct pci_bus *bus);
>  void pci_remove_root_bus(struct pci_bus *bus);
