Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:10257 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbbELWO4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 18:14:56 -0400
Message-ID: <55527B5A.8070702@broadcom.com>
Date: Tue, 12 May 2015 15:14:50 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <bhelgaas@google.com>,
	<arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <sbranden@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <zajec5@gmail.com>
Subject: Re: [PATCH 1/2] PCI: iproc: make of_irq_parse_and_map_pci() configurable
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de> <1431465781-10753-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1431465781-10753-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hauke,

On 5/12/2015 2:23 PM, Hauke Mehrtens wrote:
> This patch makes the generic code not use the function
> of_irq_parse_and_map_pci() always to get the irqs, but to take a
> function the actual driver has provided.  This is needed to make this
> function work with drivers not using device tree.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/pci/host/pcie-iproc-platform.c | 2 ++
>  drivers/pci/host/pcie-iproc.c          | 2 +-
>  drivers/pci/host/pcie-iproc.h          | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index afad6c2..c8aa06f 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -71,6 +71,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  
>  	pcie->resources = &res;
>  
> +	pcie->map_irq = of_irq_parse_and_map_pci;
> +
>  	ret = iproc_pcie_setup(pcie);
>  	if (ret) {
>  		dev_err(pcie->dev, "PCIe controller setup failed\n");
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 329e1b5..cef31f6 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -229,7 +229,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
>  	pci_bus_add_devices(bus);
>  
>  	return 0;
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index e28075e..a333d4b 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -34,6 +34,7 @@ struct iproc_pcie {
>  	struct pci_bus *root_bus;
>  	struct phy *phy;
>  	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
> +	int (*map_irq)(const struct pci_dev *, u8, u8);
>  };
>  
>  int iproc_pcie_setup(struct iproc_pcie *pcie);
> 

This change looks fine to me.

Reviewed-by: Ray Jui <rjui@broadcom.com.com>

Thanks,

Ray


