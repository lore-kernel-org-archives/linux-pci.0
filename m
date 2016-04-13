Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36016 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759160AbcDMFwy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 01:52:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id bx7so27287669pad.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 22:52:54 -0700 (PDT)
Subject: Re: [PATCH v8 02/45] powerpc/pci: Override pcibios_setup_bridge()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-3-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDEAE.1060909@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:52:46 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This overrides pcibios_setup_bridge() that is called to update PCI
> bridge windows when PCI resource assignment is completed, to assign
> PE and setup various (resource) mapping for the PE in subsequent
> patches.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/include/asm/pci-bridge.h | 2 ++
>   arch/powerpc/kernel/pci-common.c      | 8 ++++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 9f165e8..b688d04 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -33,6 +33,8 @@ struct pci_controller_ops {
>
>   	/* Called during PCI resource reassignment */
>   	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
> +	void		(*setup_bridge)(struct pci_bus *bus,
> +					unsigned long type);
>   	void		(*reset_secondary_bus)(struct pci_dev *dev);
>
>   #ifdef CONFIG_PCI_MSI
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 0f7a60f..40df3a5 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -124,6 +124,14 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>   	return 1;
>   }
>
> +void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(bus);
> +
> +	if (hose->controller_ops.setup_bridge)
> +		hose->controller_ops.setup_bridge(bus, type);
> +}
> +
>   void pcibios_reset_secondary_bus(struct pci_dev *dev)
>   {
>   	struct pci_controller *phb = pci_bus_to_host(dev->bus);
>


-- 
Alexey
