Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Nov 2017 10:43:06 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171113104306.GA27700@red-moon>
References: <20171112122850.30804-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171112122850.30804-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Johan,

On Sun, Nov 12, 2017 at 01:28:50PM +0100, Johan Hovold wrote:
> Fix child-node lookup during initialisation, which ended up searching
> the whole device tree depth-first starting at the parent rather than
> just matching on its children.
> 
> To make things worse, the parent pci node was prematurely freed, while
> the child interrupt-controller node was leaked.

Thanks for fixing this. I would kindly ask you please to split the
patch in two since there are two bugs you are fixing at once.

Murali: please test/ack accordingly.

Thanks !
Lorenzo

> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> Cc: stable <stable@vger.kernel.org>     # 3.18
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> ---
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
