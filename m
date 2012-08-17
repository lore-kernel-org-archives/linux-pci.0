Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36132 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933650Ab2HQDU0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 23:20:26 -0400
Received: by qcro28 with SMTP id o28so2751349qcr.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 20:20:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343180997-9483-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
	<1343180997-9483-4-git-send-email-shangw@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2012 11:20:26 +0800
Message-ID: <CADLM8XNy37rCki78Xueb7NgMoAU1_1suajSMEMrBrCLSF-tvfQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] fiddle with conversion of pci and CPU address
From: Wei Yang <weiyang.kernel@gmail.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	benh@kernel.crashing.org, linuxram@us.ibm.com,
	Yinghai Lu <yinghai@kernel.org>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am not sure why you want to rename those functions.

BTW, i think you change the parameter of find_pci_host_bridge() in patch 2/8.

So if I just apply 2/8, it will fail the compilation, i think.


2012/7/25 Gavin Shan <shangw@linux.vnet.ibm.com>:
> The patch fiddles with the those functions used to do conversion
> between PCI and CPU address. More specificly, 2 functions are
> involved: pcibios_bus_to_resource() and pcibios_resource_to_bus()
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/host-bridge.c |   24 +++++++++++++++++++-----
>  include/linux/pci.h       |    5 ++++-
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index fc16357..abcf053 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -37,10 +37,10 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
>         return res1->start <= res2->start && res1->end >= res2->end;
>  }
>
> -void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
> -                            struct resource *res)
> +void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> +                              struct resource *res)
>  {
> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>         struct pci_host_bridge_window *window;
>         resource_size_t offset = 0;
>
> @@ -57,6 +57,13 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>         region->start = res->start - offset;
>         region->end = res->end - offset;
>  }
> +
> +void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
> +                            struct resource *res)
> +{
> +       __pcibios_resource_to_bus(dev->bus, region, res);
> +}
> +
>  EXPORT_SYMBOL(pcibios_resource_to_bus);
>
>  static bool region_contains(struct pci_bus_region *region1,
> @@ -65,10 +72,10 @@ static bool region_contains(struct pci_bus_region *region1,
>         return region1->start <= region2->start && region1->end >= region2->end;
>  }
>
> -void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> +void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>                              struct pci_bus_region *region)
>  {
> -       struct pci_host_bridge *bridge = find_pci_host_bridge(dev->bus);
> +       struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
>         struct pci_host_bridge_window *window;
>         resource_size_t offset = 0;
>
> @@ -90,4 +97,11 @@ void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>         res->start = region->start + offset;
>         res->end = region->end + offset;
>  }
> +
> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
> +                            struct pci_bus_region *region)
> +{
> +       __pcibios_bus_to_resource(dev->bus, res, region);
> +}
> +
>  EXPORT_SYMBOL(pcibios_bus_to_resource);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d8c379d..9acea4b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -654,9 +654,12 @@ void pcibios_update_irq(struct pci_dev *, int irq);
>  void pci_fixup_cardbus(struct pci_bus *);
>
>  /* Generic PCI functions used internally */
> -
> +void __pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
> +                               struct resource *res);
>  void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
>                              struct resource *res);
> +void __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +                              struct pci_bus_region *region);
>  void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>                              struct pci_bus_region *region);
>  void pcibios_scan_specific_bus(int busn);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Richard Yang
Help You, Help Me
