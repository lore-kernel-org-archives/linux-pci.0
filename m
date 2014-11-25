Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47781 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaKYXsL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 25 Nov 2014 18:48:11 -0500
Message-ID: <1416956310.5089.5.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/8] powerpc/pci: Move pcibios_find_pci_bus() around
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Date: Wed, 26 Nov 2014 09:58:30 +1100
In-Reply-To: <1416869365-7671-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <1416869365-7671-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
> The patch moves pcibios_find_pci_bus() to PPC kerenl directory so
> that it can be reused by hotplug code for pSeries and PowerNV
> platform at the same time.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/pci-hotplug.c          | 36 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci_dlpar.c | 32 --------------------------
>  2 files changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 5b78917..6e2b4e3 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -21,6 +21,42 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
>  
> +static struct pci_bus *find_pci_bus(struct pci_bus *bus,
> +				    struct device_node *dn)
> +{
> +	struct pci_bus *tmp, *child = NULL;
> +	struct device_node *busdn;
> +
> +	busdn = pci_bus_to_OF_node(bus);
> +	if (busdn == dn)
> +		return bus;
> +
> +	list_for_each_entry(tmp, &bus->children, node) {
> +		child = find_pci_bus(tmp, dn);
> +		if (child)
> +			break;
> +	}
> +
> +	return child;
> +}
> +
> +/**
> + * pcibios_find_pci_bus - find PCI bus according to the given device node
> + * @dn: Device node
> + *
> + * Find the corresponding PCI bus according to the given device node.
> + */
> +struct pci_bus *pcibios_find_pci_bus(struct device_node *dn)
> +{
> +	struct pci_dn *pdn = PCI_DN(dn);
> +
> +	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> +		return NULL;
> +
> +	return find_pci_bus(pdn->phb->bus, dn);
> +}
> +EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
> +
>  /**
>   * pcibios_release_device - release PCI device
>   * @dev: PCI device
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 89e2381..98c50bc 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -32,38 +32,6 @@
>  #include <asm/firmware.h>
>  #include <asm/eeh.h>
>  
> -static struct pci_bus *
> -find_bus_among_children(struct pci_bus *bus,
> -                        struct device_node *dn)
> -{
> -	struct pci_bus *child = NULL;
> -	struct pci_bus *tmp;
> -	struct device_node *busdn;
> -
> -	busdn = pci_bus_to_OF_node(bus);
> -	if (busdn == dn)
> -		return bus;
> -
> -	list_for_each_entry(tmp, &bus->children, node) {
> -		child = find_bus_among_children(tmp, dn);
> -		if (child)
> -			break;
> -	};
> -	return child;
> -}
> -
> -struct pci_bus *
> -pcibios_find_pci_bus(struct device_node *dn)
> -{
> -	struct pci_dn *pdn = dn->data;
> -
> -	if (!pdn  || !pdn->phb || !pdn->phb->bus)
> -		return NULL;
> -
> -	return find_bus_among_children(pdn->phb->bus, dn);
> -}
> -EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
> -
>  struct pci_controller *init_phb_dynamic(struct device_node *dn)
>  {
>  	struct pci_controller *phb;


