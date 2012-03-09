Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37684 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753009Ab2CIBI1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Mar 2012 20:08:27 -0500
Received: by lahj13 with SMTP id j13so1153719lah.19
        for <linux-pci@vger.kernel.org>; Thu, 08 Mar 2012 17:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331018040-30725-12-git-send-email-yinghai@kernel.org>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org> <1331018040-30725-12-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Mar 2012 18:08:05 -0700
Message-ID: <CAErSpo4-KBHA9fqzO0XELtAkvMvmE1WdavJ_dxsjTN46wjSjhA@mail.gmail.com>
Subject: Re: [PATCH 11/23] PCI: separate out pci_assign_unassigned_bus_resources()
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> it is main portion of pci_rescan_bus().
>
> Separate it out and will use it later for pci root bus rescan.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c |   34 ++++++++++++++++++++--------------
>  include/linux/pci.h     |    1 +
>  2 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 8fa2d4b..6a66139 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1488,25 +1488,12 @@ enable_all:
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>
> -#ifdef CONFIG_HOTPLUG
> -/**
> - * pci_rescan_bus - scan a PCI bus for devices.
> - * @bus: PCI bus to scan
> - *
> - * Scan a PCI bus and child buses for new devices, adds them,
> - * and enables them.
> - *
> - * Returns the max number of subordinate bus discovered.
> - */
> -unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
> +void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>  {
> -       unsigned int max;
>        struct pci_dev *dev;
>        LIST_HEAD(add_list); /* list of resources that
>                                        want additional resources */
>
> -       max = pci_scan_child_bus(bus);
> -
>        down_read(&pci_bus_sem);
>        list_for_each_entry(dev, &bus->devices, bus_list)
>                if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> @@ -1519,6 +1506,25 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
>        BUG_ON(!list_empty(&add_list));
>
>        pci_enable_bridges(bus);
> +}
> +#ifdef CONFIG_HOTPLUG
> +/**
> + * pci_rescan_bus - scan a PCI bus for devices.
> + * @bus: PCI bus to scan
> + *
> + * Scan a PCI bus and child buses for new devices, adds them,
> + * and enables them.
> + *
> + * Returns the max number of subordinate bus discovered.
> + */
> +unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
> +{
> +       unsigned int max;
> +
> +       max = pci_scan_child_bus(bus);
> +
> +       pci_assign_unassigned_bus_resources(bus);
> +
>        pci_bus_add_devices(bus);
>
>        return max;

We don't need all the blank lines here.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 28556cb..4f30cd1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -910,6 +910,7 @@ void pci_bus_size_bridges(struct pci_bus *bus);
>  int pci_claim_resource(struct pci_dev *, int);
>  void pci_assign_unassigned_resources(void);
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
> +void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
>  void pdev_enable_device(struct pci_dev *);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
