Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33509 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcDSFbX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 01:31:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id 184so3027043pff.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2016 22:31:23 -0700 (PDT)
Subject: Re: [PATCH v8 25/45] powerpc/pci: Rename pcibios_find_pci_bus()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-26-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715C2A3.7080704@ozlabs.ru>
Date: Tue, 19 Apr 2016 15:31:15 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-26-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> This renames pcibios_find_pci_bus() to pci_find_bus_by_node() to
> avoid conflicts with those PCI subsystem weak function names, which
> have prefix "pcibios". No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/include/asm/pci-bridge.h      | 2 +-
>   arch/powerpc/platforms/pseries/pci_dlpar.c | 5 ++---
>   drivers/pci/hotplug/rpadlpar_core.c        | 6 +++---
>   drivers/pci/hotplug/rpaphp_pci.c           | 2 +-
>   4 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index c817f38..03f4ee7 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -260,7 +260,7 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
>   #endif
>
>   /** Find the bus corresponding to the indicated device node */
> -extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
> +extern struct pci_bus *pci_find_bus_by_node(struct device_node *dn);
>
>   /** Remove all of the PCI devices under this bus */
>   extern void pci_remove_pci_devices(struct pci_bus *bus);
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index 5d4a3df..aee22b4 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -54,8 +54,7 @@ find_bus_among_children(struct pci_bus *bus,
>   	return child;
>   }
>
> -struct pci_bus *
> -pcibios_find_pci_bus(struct device_node *dn)
> +struct pci_bus *pci_find_bus_by_node(struct device_node *dn)
>   {
>   	struct pci_dn *pdn = dn->data;
>
> @@ -64,7 +63,7 @@ pcibios_find_pci_bus(struct device_node *dn)
>
>   	return find_bus_among_children(pdn->phb->bus, dn);
>   }
> -EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
> +EXPORT_SYMBOL_GPL(pci_find_bus_by_node);
>
>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   {
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index 730982b..acbf041 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -175,7 +175,7 @@ static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
>   	struct pci_dev *dev;
>   	struct pci_controller *phb;
>
> -	if (pcibios_find_pci_bus(dn))
> +	if (pci_find_bus_by_node(dn))
>   		return -EINVAL;
>
>   	/* Add pci bus */
> @@ -212,7 +212,7 @@ static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
>   	struct pci_dn *pdn;
>   	int rc = 0;
>
> -	if (!pcibios_find_pci_bus(dn))
> +	if (!pci_find_bus_by_node(dn))
>   		return -EINVAL;
>
>   	/* If pci slot is hotpluggable, use hotplug to remove it */
> @@ -356,7 +356,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
>
>   	pci_lock_rescan_remove();
>
> -	bus = pcibios_find_pci_bus(dn);
> +	bus = pci_find_bus_by_node(dn);
>   	if (!bus) {
>   		ret = -EINVAL;
>   		goto out;
> diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
> index 1099b38..a9180bb 100644
> --- a/drivers/pci/hotplug/rpaphp_pci.c
> +++ b/drivers/pci/hotplug/rpaphp_pci.c
> @@ -93,7 +93,7 @@ int rpaphp_enable_slot(struct slot *slot)
>   	if (rc)
>   		return rc;
>
> -	bus = pcibios_find_pci_bus(slot->dn);
> +	bus = pci_find_bus_by_node(slot->dn);
>   	if (!bus) {
>   		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
>   		return -EINVAL;
>


-- 
Alexey
