Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34753 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbcAaMeu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jan 2016 07:34:50 -0500
Received: by mail-pa0-f43.google.com with SMTP id uo6so67593898pac.1
        for <linux-pci@vger.kernel.org>; Sun, 31 Jan 2016 04:34:50 -0800 (PST)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
	<linux-pci@vger.kernel.org>
Cc: "'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Zhou Wang'" <wangzhou1@hisilicon.com>,
	"'Jingoo Han'" <jingoohan1@gmail.com>
References: <1454066972-3609-1-git-send-email-lorenzo.pieralisi@arm.com> <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1454066972-3609-2-git-send-email-lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] drivers: pci: host: designware: remove PCI_PROBE_ONLY handling
Date: Sun, 31 Jan 2016 21:34:40 +0900
Message-ID: <000701d15c23$c67963f0$536c2bd0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 29, 2016 8:30 PM, Lorenzo Pieralisi wrote:
> 
> The PCIe designware host driver is not used in system configurations
> requiring the PCI_PROBE_ONLY flag to be set to prevent resources
> assignment, therefore the driver code handling the flag can be
> removed from the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
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

