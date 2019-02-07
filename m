Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD48C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7803B21872
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfBGPoZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:44:25 -0500
Received: from foss.arm.com ([217.140.101.70]:39086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPoY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 10:44:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2EBA78;
        Thu,  7 Feb 2019 07:44:23 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 714323F719;
        Thu,  7 Feb 2019 07:44:22 -0800 (PST)
Date:   Thu, 7 Feb 2019 15:44:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] PCI: keystone: Add separate functions for
 configuring MSI and legacy interrupt
Message-ID: <20190207154419.GB21111@e107981-ln.cambridge.arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-4-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 04:39:18PM +0530, Kishon Vijay Abraham I wrote:
> ks_pcie_get_irq_controller_info() was used to configure both MSI and
> legacy interrupt. This will prevent MSI or legacy interrupt specific
> intializations. Add separate functions to configure MSI and legacy
> interrupts.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 188 +++++++++++-----------
>  1 file changed, 96 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 4cf9849d5a1d..b1d01751c1af 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -87,11 +87,8 @@ struct keystone_pcie {
>  	struct dw_pcie		*pci;
>  	/* PCI Device ID */
>  	u32			device_id;
> -	int			num_legacy_host_irqs;
> -	int			legacy_host_irqs[PCI_NUM_INTX];
>  	struct			device_node *legacy_intc_np;
>  
> -	int			num_msi_host_irqs;
>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
>  	int			num_lanes;
>  	u32			num_viewport;
> @@ -201,14 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
>  	return dw_pcie_allocate_domains(pp);
>  }
>  
> -static void ks_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
> -{
> -	int i;
> -
> -	for (i = 0; i < PCI_NUM_INTX; i++)
> -		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), 0x1);
> -}
> -
>  static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>  				      int offset)
>  {
> @@ -490,17 +479,6 @@ static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
>  
>  	ks_pcie->app = *res;
>  
> -	/* Create legacy IRQ domain */
> -	ks_pcie->legacy_irq_domain =
> -			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> -					      PCI_NUM_INTX,
> -					      &ks_pcie_legacy_irq_domain_ops,
> -					      NULL);
> -	if (!ks_pcie->legacy_irq_domain) {
> -		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> -		return -EINVAL;
> -	}
> -
>  	return dw_pcie_host_init(pp);
>  }
>  
> @@ -624,85 +602,117 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
> -					   char *controller, int *num_irqs)
> +static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
>  {
> -	int temp, max_host_irqs, legacy = 1, *host_irqs;
>  	struct device *dev = ks_pcie->pci->dev;
> -	struct device_node *np_pcie = dev->of_node, **np_temp;
> -
> -	if (!strcmp(controller, "msi-interrupt-controller"))
> -		legacy = 0;
> -
> -	if (legacy) {
> -		np_temp = &ks_pcie->legacy_intc_np;
> -		max_host_irqs = PCI_NUM_INTX;
> -		host_irqs = &ks_pcie->legacy_host_irqs[0];
> -	} else {
> -		np_temp = &ks_pcie->msi_intc_np;
> -		max_host_irqs = MAX_MSI_HOST_IRQS;
> -		host_irqs =  &ks_pcie->msi_host_irqs[0];
> -	}
> +	struct device_node *np = ks_pcie->np;
> +	struct device_node *intc_np;
> +	int irq_count;
> +	int irq;
> +	int ret;
> +	int i;

Nit: all int can be in one line.

> -	/* interrupt controller is in a child node */
> -	*np_temp = of_get_child_by_name(np_pcie, controller);
> -	if (!(*np_temp)) {
> -		dev_err(dev, "Node for %s is absent\n", controller);
> -		return -EINVAL;
> -	}
> +	if (!IS_ENABLED(CONFIG_PCI_MSI))
> +		return 0;
>  
> -	temp = of_irq_count(*np_temp);
> -	if (!temp) {
> -		dev_err(dev, "No IRQ entries in %s\n", controller);
> -		of_node_put(*np_temp);
> +	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
> +	if (!intc_np) {
> +		dev_WARN(dev, "msi-interrupt-controller node is absent\n");

I do not think you can justify a backtrace for this error path, so
convert it to a dev_warn() please.

>  		return -EINVAL;
>  	}
>  
> -	if (temp > max_host_irqs)
> -		dev_warn(dev, "Too many %s interrupts defined %u\n",
> -			(legacy ? "legacy" : "MSI"), temp);
> +	irq_count = of_irq_count(intc_np);
> +	if (!irq_count) {
> +		dev_err(dev, "No IRQ entries in msi-interrupt-controller\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
> -	/*
> -	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
> -	 * 7 (MSI)
> -	 */
> -	for (temp = 0; temp < max_host_irqs; temp++) {
> -		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
> -		if (!host_irqs[temp])
> -			break;
> +	if (irq_count > MAX_MSI_HOST_IRQS) {
> +		dev_warn(dev, "Too many MSI interrupt lines defined %u\n",
> +			 irq_count);
> +		irq_count = MAX_MSI_HOST_IRQS;
>  	}
>  
> -	of_node_put(*np_temp);
> +	for (i = 0; i < irq_count; i++) {
> +		irq = irq_of_parse_and_map(intc_np, i);
> +		if (!irq) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		ks_pcie->msi_host_irqs[i] = irq;
>  
> -	if (temp) {
> -		*num_irqs = temp;
> -		return 0;
> +		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
> +						 ks_pcie);
>  	}
>  
> -	return -EINVAL;
> +	of_node_put(intc_np);
> +	return 0;
> +
> +err:
> +	of_node_put(intc_np);
> +	return ret;
>  }
>  
> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  {
> +	struct device *dev = ks_pcie->pci->dev;
> +	struct irq_domain *legacy_irq_domain;
> +	struct device_node *np = ks_pcie->np;
> +	struct device_node *intc_np;
> +	int irq_count;
> +	int irq;
> +	int ret;
>  	int i;
>  
> -	/* Legacy IRQ */
> -	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
> -		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
> +	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
> +	if (!intc_np) {
> +		dev_WARN(dev, "legacy-interrupt-controller node is absent\n");

Likewise.

Lorenzo

> +		return -EINVAL;
> +	}
> +
> +	irq_count = of_irq_count(intc_np);
> +	if (!irq_count) {
> +		dev_err(dev, "No IRQ entries in legacy-interrupt-controller\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	for (i = 0; i < irq_count; i++) {
> +		irq = irq_of_parse_and_map(intc_np, i);
> +		if (!irq) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		irq_set_chained_handler_and_data(irq,
>  						 ks_pcie_legacy_irq_handler,
>  						 ks_pcie);
>  	}
> -	ks_pcie_enable_legacy_irqs(ks_pcie);
> -
> -	/* MSI IRQ */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
> -			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
> -							 ks_pcie_msi_irq_handler,
> -							 ks_pcie);
> -		}
> +
> +	legacy_irq_domain =
> +		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
> +				      &ks_pcie_legacy_irq_domain_ops, NULL);
> +	if (!legacy_irq_domain) {
> +		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> +		ret = -EINVAL;
> +		goto err;
>  	}
> +	ks_pcie->legacy_irq_domain = legacy_irq_domain;
> +
> +	for (i = 0; i < PCI_NUM_INTX; i++)
> +		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
> +
> +	of_node_put(intc_np);
> +
> +	return 0;
> +
> +err:
> +	of_node_put(intc_np);
> +	return ret;
> +}
>  
> +static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> +{
>  	if (ks_pcie->error_irq > 0)
>  		ks_pcie_enable_error_irq(ks_pcie);
>  }
> @@ -756,6 +766,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  	int ret;
>  
> +	ret = ks_pcie_config_legacy_irq(ks_pcie);
> +	if (ret)
> +		return ret;
> +
> +	ret = ks_pcie_config_msi_irq(ks_pcie);
> +	if (ret)
> +		return ret;
> +
>  	dw_pcie_setup_rc(pp);
>  
>  	ks_pcie_establish_link(ks_pcie);
> @@ -805,20 +823,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	ret = ks_pcie_get_irq_controller_info(ks_pcie,
> -					"legacy-interrupt-controller",
> -					&ks_pcie->num_legacy_host_irqs);
> -	if (ret)
> -		return ret;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		ret = ks_pcie_get_irq_controller_info(ks_pcie,
> -						"msi-interrupt-controller",
> -						&ks_pcie->num_msi_host_irqs);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/*
>  	 * Index 0 is the platform interrupt for error interrupt
>  	 * from RC.  This is optional.
> -- 
> 2.17.1
> 
