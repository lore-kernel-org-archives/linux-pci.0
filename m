Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36162 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbcBEA1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 19:27:07 -0500
Date: Thu, 4 Feb 2016 18:27:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: pci: host: rcar: remove PCI_PROBE_ONLY
 handling
Message-ID: <20160205002703.GK7031@localhost>
References: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Simon, R-car maintainer, linux-renesas-soc]

I badly want to merge this, so speak up now if you object :)

On Fri, Jan 29, 2016 at 11:29:31AM +0000, Lorenzo Pieralisi wrote:
> The PCIe rcar host driver is not used in system configurations
> requiring the PCI_PROBE_ONLY flag to be set to prevent resources
> assignment, therefore the driver code handling the flag can be
> removed from the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-rcar.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 4edb518..3509218 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -390,9 +390,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  
>  	rcar_pcie_setup(&res, pcie);
>  
> -	/* Do not reassign resources if probe only */
> -	if (!pci_has_flag(PCI_PROBE_ONLY))
> -		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		bus = pci_scan_root_bus_msi(pcie->dev, pcie->root_bus_nr,
> @@ -408,13 +406,11 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  
> -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> -		pci_bus_size_bridges(bus);
> -		pci_bus_assign_resources(bus);
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
>  
> -		list_for_each_entry(child, &bus->children, node)
> -			pcie_bus_configure_settings(child);
> -	}
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
>  
>  	pci_bus_add_devices(bus);
>  
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
