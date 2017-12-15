Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756191AbdLONWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 08:22:12 -0500
Date: Fri, 15 Dec 2017 13:22:52 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171215132252.GA30737@red-moon>
References: <20171117133831.1300-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117133831.1300-1-johan@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 17, 2017 at 02:38:31PM +0100, Johan Hovold wrote:
> Fix child-node lookup during initialisation which was using the wrong
> OF-helper and ended up searching the whole device tree depth-first
> starting at the parent rather than just matching on its children.
> 
> To make things worse, the parent pci node could end up being prematurely
> freed as of_find_node_by_name() drops a reference to its first argument.
> Any matching child interrupt-controller node was also leaked.
> 
> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> Cc: stable <stable@vger.kernel.org>     # 3.18
> Acked-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Applied to pci/keystone for v4.16.

Thanks,
Lorenzo

> v2
>  - amend commit message and mention explicitly that of_find_node_by_name()
>    drops a reference to the start node
>  - add Murali's and Lorenzo's acks
> 
> 
>  drivers/pci/dwc/pci-keystone.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
> index 5bee3af47588..39405598b22d 100644
> --- a/drivers/pci/dwc/pci-keystone.c
> +++ b/drivers/pci/dwc/pci-keystone.c
> @@ -178,7 +178,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  	}
>  
>  	/* interrupt controller is in a child node */
> -	*np_temp = of_find_node_by_name(np_pcie, controller);
> +	*np_temp = of_get_child_by_name(np_pcie, controller);
>  	if (!(*np_temp)) {
>  		dev_err(dev, "Node for %s is absent\n", controller);
>  		return -EINVAL;
> @@ -187,6 +187,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  	temp = of_irq_count(*np_temp);
>  	if (!temp) {
>  		dev_err(dev, "No IRQ entries in %s\n", controller);
> +		of_node_put(*np_temp);
>  		return -EINVAL;
>  	}
>  
> @@ -204,6 +205,8 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  			break;
>  	}
>  
> +	of_node_put(*np_temp);
> +
>  	if (temp) {
>  		*num_irqs = temp;
>  		return 0;
> -- 
> 2.15.0
> 
