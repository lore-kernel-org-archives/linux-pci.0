Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60050 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2EWFEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 01:04:12 -0400
Received: by dady13 with SMTP id y13so9206691dad.19
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 22:04:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120523043511.13449.22006.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
	<20120523043511.13449.22006.stgit@bhelgaas.mtv.corp.google.com>
Date: Tue, 22 May 2012 22:04:12 -0700
Message-ID: <CAE9FiQVs0U62NRxkDYdOC67EUiEBu1f5ojGxGXkdbt0O6XO4uQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] PCI: acpiphp: remove all functions in slot, even
 without ACPI _EJx
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Amos Kong <kongjianjun@gmail.com>, linux-pci@vger.kernel.org,
	liuj97@gmail.com, qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 9:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Amos Kong <kongjianjun@gmail.com>
>
> When we add a device with acpiphp, we enumerate all functions in the
> slot with pci_scan_slot(), regardless of whether they have associated
> ACPI methods such as _EJ0.
>
> When removing the device, we previously removed only the functions
> with those ACPI methods.  This patch makes the remove symmetric with the
> add: we remove all functions in the slot, whether they have associated
> ACPI methods or not.
>
> With qemu-kvm and SeaBIOS, we can build a multi-function device where
> only function 0 has _EJ0 and _ADR (see bugzilla below).  Removing and
> re-adding that device works correctly with Windows guests.  This patch
> makes it also work in Linux guests.
>
> [bhelgaas: restructure loop iteration, pull out of slot->funcs loop]
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=43219
> Signed-off-by: Amos Kong <kongjianjun@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |   39 +++++++++++++++++++++++++++---------
>  1 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index c8f9991..9aff4f0 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -878,6 +878,21 @@ static void disable_bridges(struct pci_bus *bus)
>        }
>  }
>
> +/* return first device in slot, acquiring a reference on it */
> +static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
> +{
> +       struct pci_bus *bus = slot->bridge->pci_bus;
> +       struct pci_dev *dev;
> +
> +       down_read(&pci_bus_sem);
> +       list_for_each_entry(dev, &bus->devices, bus_list)
> +               if (PCI_SLOT(dev->devfn) == slot->device)
> +                       return pci_dev_get(dev);
> +       up_read(&pci_bus_sem);

Do you need to keep that pci_bus_sem operation pair on return path?

> +
> +       return NULL;
> +}
> +
>  /**
>  * disable_device - disable a slot
>  * @slot: ACPI PHP slot
> @@ -902,18 +917,22 @@ static int disable_device(struct acpiphp_slot *slot)
>                                                (u32)1, NULL, NULL);
>                        func->bridge = NULL;
>                }
> +       }
>
> -               pdev = pci_get_slot(slot->bridge->pci_bus,
> -                                   PCI_DEVFN(slot->device, func->function));
> -               if (pdev) {
> -                       pci_stop_bus_device(pdev);
> -                       if (pdev->subordinate) {
> -                               disable_bridges(pdev->subordinate);
> -                               pci_disable_device(pdev);
> -                       }
> -                       __pci_remove_bus_device(pdev);
> -                       pci_dev_put(pdev);
> +       /*
> +        * enable_device() enumerates all functions in this device via
> +        * pci_scan_slot(), whether they have associated ACPI hotplug
> +        * methods (_EJ0, etc.) or not.  Therefore, we remove all functions
> +        * here.
> +        */
> +       while ((pdev = dev_in_slot(slot))) {
> +               pci_stop_bus_device(pdev);
> +               if (pdev->subordinate) {
> +                       disable_bridges(pdev->subordinate);
> +                       pci_disable_device(pdev);
>                }
> +               __pci_remove_bus_device(pdev);
> +               pci_dev_put(pdev);
>        }
>
>        list_for_each_entry(func, &slot->funcs, sibling) {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
