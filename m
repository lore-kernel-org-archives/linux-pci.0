Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32980 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab2FYRa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2012 13:30:59 -0400
Received: by dady13 with SMTP id y13so5612906dad.19
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2012 10:30:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2012 10:30:59 -0700
Message-ID: <CAE9FiQUE0_niTRmvZ=ROSFKB4HKDFFLjfJC+QeQkTKLMyvxv4g@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	bhelgaas@google.com, benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 24, 2012 at 8:10 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> With current implementation, there is one function to retrieve
> the corresponding host bridge (struct pci_host_bridge) according
> to the given PCI device (struct pci_dev) and that function has
> been declared as "static". Further, we don't have the public
> function to retrieve host bridge from PCI bus yet. The function
> is useful somewhere.
>
> The additional information like minimal resource alignment for I/O
> and MMIO bars of p2p bridges will be put into the PCI host bridge.
> The patch introduces the public function pci_bus_host_bridge() to
> retrieve the corresponding PCI host bridge according to the specified
> PCI bus, then accessing the information regarding the minimal resource
> alignment for I/O and MMIO bars of p2p bridges.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/pci/host-bridge.c |   13 +++++++++++++
>  include/linux/pci.h       |    2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index a68dc61..b95f0ce 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -27,6 +27,19 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
>        return to_pci_host_bridge(bus->bridge);
>  }
>
> +struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus)
> +{
> +       struct pci_bus *b = bus;
> +
> +       /* Find the PCI root bus */
> +       while (b->parent)
> +               b = b->parent;
> +
> +       return to_pci_host_bridge(b->bridge);
> +}
> +
> +EXPORT_SYMBOL(pci_bus_host_bridge);

why do you need to export it?

> +
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>                                 void (*release_fn)(struct pci_host_bridge *),
>                                 void *release_data)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fefb4e1..6d5bb1c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -656,7 +656,7 @@ void pcibios_update_irq(struct pci_dev *, int irq);
>  void pci_fixup_cardbus(struct pci_bus *);
>
>  /* Generic PCI functions used internally */
> -
> +struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus);
>  void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>                             struct resource *res);
>  void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,

have one patch will change parameter all to bus instead of bridge.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=3dc90c8f31e5e6153e1ac9a903189d3013690e80

in that case, we can just make find_pci_host_bridge() global.

Thanks

Yinghai
