Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51206 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab2F0SPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2012 14:15:40 -0400
Received: by lbbgm6 with SMTP id gm6so1950285lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 27 Jun 2012 11:15:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Jun 2012 12:15:17 -0600
Message-ID: <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] PCI: pcibus address to resource converting take
 bus directly
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	yinghai@kernel.org, benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2012 at 8:48 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> For allocating resource under bus path, we do have dev pass along,
> and we could just use bus instead. Also, we'd like to make function
> find_pci_host_bridge() global so that some platforms (e.g. PPC) can
> access the pci host bridge directly.

This patch appears to have multiple unrelated changes:

  - change "struct pci_bus *bus" to "struct pci_bus *root_bus"
  - change find_pci_host_bridge() argument from dev to bus
  - fiddle with pcibios_bus_to_resource() and pcibios_resource_to_bus()

These should be split out to make your patches easier to review.

What's the rationale for preferring the pci_bus over the pci_dev?

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/host-bridge.c |   34 +++++++++++++++++++++-------------
>  include/linux/pci.h       |    4 ++++
>  2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index a68dc61..4ccf477 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -9,22 +9,19 @@
>
>  #include "pci.h"
>
> -static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
> +static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  {
> -       struct pci_bus *bus;
> -
> -       bus = dev->bus;
>        while (bus->parent)
>                bus = bus->parent;
>
>        return bus;
>  }
>
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
>  {
> -       struct pci_bus *bus = find_pci_root_bus(dev);
> +       struct pci_bus *root_bus = find_pci_root_bus(bus);
>
> -       return to_pci_host_bridge(bus->bridge);
> +       return to_pci_host_bridge(root_bus->bridge);
>  }
>
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> @@ -40,10 +37,11 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
>        return res1->start <= res2->start && res1->end >= res2->end;
>  }
>
> -void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
> -                            struct resource *res)
> +void __pcibios_resource_to_bus(struct pci_bus *bus,
> +                                     struct pci_bus_region *region,
> +                                     struct resource *res)
>  {
> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>        struct pci_host_bridge_window *window;
>        resource_size_t offset = 0;
>
> @@ -60,6 +58,11 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>        region->start = res->start - offset;
>        region->end = res->end - offset;
>  }
> +void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
> +                            struct resource *res)
> +{
> +       __pcibios_resource_to_bus(dev->bus, region, res);
> +}
>  EXPORT_SYMBOL(pcibios_resource_to_bus);
>
>  static bool region_contains(struct pci_bus_region *region1,
> @@ -68,10 +71,10 @@ static bool region_contains(struct pci_bus_region *region1,
>        return region1->start <= region2->start && region1->end >= region2->end;
>  }
>
> -void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> -                            struct pci_bus_region *region)
> +static void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +                                     struct pci_bus_region *region)
>  {
> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev);
> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>        struct pci_host_bridge_window *window;
>        resource_size_t offset = 0;
>
> @@ -93,4 +96,9 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>        res->start = region->start + offset;
>        res->end = region->end + offset;
>  }
> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> +                            struct pci_bus_region *region)
> +{
> +       __pcibios_bus_to_resource(dev->bus, res, region);
> +}
>  EXPORT_SYMBOL(pcibios_bus_to_resource);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fefb4e1..2b559f1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -385,6 +385,7 @@ struct pci_host_bridge {
>  };
>
>  #define        to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>                     void (*release_fn)(struct pci_host_bridge *),
>                     void *release_data);
> @@ -657,6 +658,9 @@ void pci_fixup_cardbus(struct pci_bus *);
>
>  /* Generic PCI functions used internally */
>
> +void __pcibios_resource_to_bus(struct pci_bus *bus,
> +                              struct pci_bus_region *region,
> +                              struct resource *res);
>  void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>                             struct resource *res);
>  void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> --
> 1.7.9.5
>
