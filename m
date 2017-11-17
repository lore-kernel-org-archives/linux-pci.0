Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdKQLSu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Nov 2017 06:18:50 -0500
Date: Fri, 17 Nov 2017 11:19:10 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171117111910.GA21148@red-moon>
References: <20171112122850.30804-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171112122850.30804-1-johan@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Johan,

On Sun, Nov 12, 2017 at 01:28:50PM +0100, Johan Hovold wrote:
> Fix child-node lookup during initialisation, which ended up searching
> the whole device tree depth-first starting at the parent rather than
> just matching on its children.
> 
> To make things worse, the parent pci node was prematurely freed, while
> the child interrupt-controller node was leaked.

I think you should explain that of_find_node_by_name() drops a reference
to the from pointer, it is not clear from the log.

More importantly: are you saying that all of_find_node_by_name() usages
with a (from* != NULL) are broken unless they bump up the from node (if
!= NULL) ref count ?

Is there a reason why of_find_node_by_name() behaviour can't be changed ?

> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> Cc: stable <stable@vger.kernel.org>     # 3.18

Do we really want to send this to stable kernels straight away ?

There is not any specific bug report - it should be safe but I
wanted to ask.

> Cc: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/dwc/pci-keystone.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

With an update log:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
