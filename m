Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53795 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbaKJMvv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 07:51:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] drivers: of: move PCI domain assignment to generic OF code
Date: Mon, 10 Nov 2014 13:51:19 +0100
Message-ID: <1459907.RIyEjnM4cg@wuerfel>
In-Reply-To: <1415622368-14612-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1415622368-14612-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 10 November 2014 12:26:08 Lorenzo Pieralisi wrote:
> ---
>  arch/arm64/kernel/pci.c | 14 +++--------
>  drivers/of/of_pci.c     | 66 +++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/of_pci.h  |  7 +++---
>  3 files changed, 71 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index ce5836c..5e21c1c 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -49,20 +49,14 @@ int pcibios_add_device(struct pci_dev *dev)
>  
>  
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -static bool dt_domain_found = false;
>  
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  {
> -	int domain = of_get_pci_domain_nr(parent->of_node);
> +	int domain = of_assign_pci_domain_nr(parent->of_node);
>  
> -	if (domain >= 0) {
> -		dt_domain_found = true;
> -	} else if (dt_domain_found == true) {
> -		dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
> -			parent->of_node->full_name);
> -		return;
> -	} else {
> -		domain = pci_get_new_domain_nr();
> +	if (domain < 0) {
> +		dev_err(parent, "PCI domain assignment failed\n");
> +		domain = -1;
>  	}
>  
>  	bus->domain_nr = domain;

Is there a need to still keep this in architecture specific code? Why
not move it to drivers/pci and let other firmware infrastructure
hook in there directly.

>  {
> @@ -45,10 +45,9 @@ of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>  	return -EINVAL;
>  }
>  
> -static inline int
> -of_get_pci_domain_nr(struct device_node *node)
> +static inline int of_assign_pci_domain_nr(struct device_node *node)
>  {
> -	return -1;
> +	return pci_get_new_domain_nr();
>  }
>  #endif

This gets a bit tricky otherwise once we add ACPI in the mix, with all
combinations of OF and ACPI at compile time and at runtime.

	Arnd
