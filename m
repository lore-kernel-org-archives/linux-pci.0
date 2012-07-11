Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58870 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab2GKPul (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 11:50:41 -0400
Received: by lbbgm6 with SMTP id gm6so2579026lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 08:50:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340437325-29282-5-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org> <1340437325-29282-5-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jul 2012 09:50:19 -0600
Message-ID: <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Jason Baron <jbaron@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> When system support hotplug bridge with children hotplug slots, we need to make sure
> that parent bridge get preallocated resource so later when device is plugged into
> children slot, those children devices will get resource allocated.
>
> We do not meet this problem, because for pcie hotplug card, when acpiphp is used,
> pci_scan_bridge will set that for us when detect hotplug bit in slot cap.
>
> Reported-and-tested-by: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Acked-by: Jason Baron <jbaron@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ad6fd66..0f2b72d 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -783,6 +783,29 @@ static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
>         }
>  }
>
> +static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
> +{
> +       struct acpiphp_func *func;
> +
> +       if (!dev->subordinate)
> +               return;
> +
> +       /* quirk, or pcie could set it already */
> +       if (dev->is_hotplug_bridge)
> +               return;
> +
> +       if (PCI_SLOT(dev->devfn) != slot->device)
> +               return;
> +
> +       list_for_each_entry(func, &slot->funcs, sibling) {
> +               if (PCI_FUNC(dev->devfn) == func->function) {
> +                       /* check if this bridge has ejectable slots */
> +                       if ((detect_ejectable_slots(func->handle) > 0))
> +                               dev->is_hotplug_bridge = 1;
> +                       break;
> +               }
> +       }
> +}
>  /**
>   * enable_device - enable, configure a slot
>   * @slot: slot to be enabled
> @@ -817,8 +840,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>                             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
>                                 max = pci_scan_bridge(bus, dev, max, pass);
> -                               if (pass && dev->subordinate)
> +                               if (pass && dev->subordinate) {
> +                                       check_hotplug_bridge(slot, dev);

I don't like this patch because it increases the differences between
the hotplug drivers, rather than decreasing them.

For PCI Express devices, we set dev->is_hotplug_bridge in the
pci_setup_device() path (in set_pcie_hotplug_bridge()).  I think it
would make sense to try to expand that path to also handle SHPC and
ACPI hotplug as well.  ACPI is harder because it's not PCI-specified,
so we'd need some sort of pcibios or other optional hook.

I don't have a clear picture of how this works -- if I understand
correctly, the situation is that we have a bridge managed by acpiphp.
That part makes sense because the bridge is on the motherboard and can
have a DSDT device.  Now we plug something into the slot below the
bridge.  I *think* this patch handles the case where this new
hot-added thing is also a bridge managed by acpiphp.  But where does
the ACPI device for this hot-added bridge come from?  It's an
arbitrary device the BIOS knows nothing about, so it can't be in the
DSDT.

>                                         pci_bus_size_bridges(dev->subordinate);
> +                               }
>                         }
>                 }
>         }
> --
> 1.7.7
>
