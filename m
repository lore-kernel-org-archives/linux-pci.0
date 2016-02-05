Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40530 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbcBEU2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 15:28:13 -0500
Date: Fri, 5 Feb 2016 14:28:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] drivers: pci: host: designware: remove
 PCI_PROBE_ONLY handling
Message-ID: <20160205202808.GC9594@localhost>
References: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 29, 2016 at 11:29:32AM +0000, Lorenzo Pieralisi wrote:
> The PCIe designware host driver is not used in system configurations
> requiring the PCI_PROBE_ONLY flag to be set to prevent resources
> assignment, therefore the driver code handling the flag can be
> removed from the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>

Applied to pci/host-designware for v4.6 with acks from Pratyush and
Jingoo, thanks everybody!

> ---
>  drivers/pci/host/pcie-designware.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2171682..a445083 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -551,13 +551,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  #endif
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
>  	return 0;
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
