Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35383 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbcFOIw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jun 2016 04:52:57 -0400
Date: Wed, 15 Jun 2016 09:52:12 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 4/7] irqchip/gicv3-its: Refator ITS DT init code to
 prepare for ACPI
Message-ID: <20160615095212.260d16c3@arm.com>
In-Reply-To: <1465828873-23498-5-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
	<1465828873-23498-5-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Jun 2016 16:41:10 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

s/refator/refactor/ in the subject line.

> In order to add ACPI support we need to isolate ACPI&DT common code and
> move DT logic to corresponding functions. To achieve this we are using
> firmware agnostic handle which can be unpacked to either DT or ACPI node.
> 
> No functional changes other than a very minor one:
> 1. Fix ITS base register address type (from 'unsigned long' to 'phys_addr_t'),
> as a bonus we get nice string formatting.
> 2. Since there is only one of ITS parent domain convert it to static global
> variable and drop the parameter from its_probe_one. Users can refer to it
> in more convenient way then.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

This doesn't apply anymore since I've merged Shanker's 2-level
translation patches. Please rebase it on top of my irq/irqchip-4.8
branch.

> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 79 +++++++++++++++++++++-----------------
>  drivers/irqchip/irq-gic-v3.c       |  6 +--
>  include/linux/irqchip/arm-gic-v3.h |  4 +-
>  3 files changed, 48 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 43d32fc..f033fd8 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -74,7 +74,7 @@ struct its_node {
>  	raw_spinlock_t		lock;
>  	struct list_head	entry;
>  	void __iomem		*base;
> -	unsigned long		phys_base;
> +	phys_addr_t		phys_base;
>  	struct its_cmd_block	*cmd_base;
>  	struct its_cmd_block	*cmd_write;
>  	struct its_baser	tables[GITS_BASER_NR_REGS];
> @@ -114,6 +114,7 @@ struct its_device {
>  static LIST_HEAD(its_nodes);
>  static DEFINE_SPINLOCK(its_lock);
>  static struct rdists *gic_rdists;
> +static struct irq_domain *its_parent;
>  
>  #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
> @@ -837,7 +838,7 @@ static void its_free_tables(struct its_node *its)
>  	}
>  }
>  
> -static int its_alloc_tables(const char *node_name, struct its_node *its)
> +static int its_alloc_tables(struct its_node *its)
>  {
>  	int err;
>  	int i;
> @@ -893,8 +894,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  				    order);
>  			if (order >= MAX_ORDER) {
>  				order = MAX_ORDER - 1;
> -				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
> -					node_name, order);
> +				pr_warn("ITS@%pa: Device Table too large, reduce its page order to %u\n",
> +					&its->phys_base, order);
>  			}
>  		}
>  
> @@ -903,8 +904,8 @@ retry_alloc_baser:
>  		if (alloc_pages > GITS_BASER_PAGES_MAX) {
>  			alloc_pages = GITS_BASER_PAGES_MAX;
>  			order = get_order(GITS_BASER_PAGES_MAX * psz);
> -			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
> -				node_name, order, alloc_pages);
> +			pr_warn("ITS@%pa: Device Table too large, reduce its page order to %u (%u pages)\n",
> +				&its->phys_base, order, alloc_pages);
>  		}
>  
>  		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> @@ -978,8 +979,8 @@ retry_baser:
>  		}
>  
>  		if (val != tmp) {
> -			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
> -			       node_name, i,
> +			pr_err("ITS@%pa: GITS_BASER%d doesn't stick: %lx %lx\n",
> +			       &its->phys_base, i,
>  			       (unsigned long) val, (unsigned long) tmp);
>  			err = -ENXIO;
>  			goto out_free;
> @@ -1507,8 +1508,7 @@ static void its_enable_quirks(struct its_node *its)
>  	gic_enable_quirks(iidr, its_quirks, its);
>  }
>  
> -static int its_init_domain(struct device_node *node, struct its_node *its,
> -			   struct irq_domain *parent)
> +static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  {
>  	struct irq_domain *inner_domain;
>  	struct msi_domain_info *info;
> @@ -1517,13 +1517,13 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
> +	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
>  	if (!inner_domain) {
>  		kfree(info);
>  		return -ENOMEM;
>  	}
>  
> -	inner_domain->parent = parent;
> +	inner_domain->parent = its_parent;
>  	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
>  	info->ops = &its_msi_domain_ops;
>  	info->data = its;
> @@ -1532,43 +1532,35 @@ static int its_init_domain(struct device_node *node, struct its_node *its,
>  	return 0;
>  }
>  
> -static int __init its_probe(struct device_node *node,
> -			    struct irq_domain *parent)
> +static int __init its_probe_one(struct resource *res,
> +				struct fwnode_handle *handle, int numa_node)
>  {
> -	struct resource res;
>  	struct its_node *its;
>  	void __iomem *its_base;
>  	u32 val;
>  	u64 baser, tmp;
>  	int err;
>  
> -	err = of_address_to_resource(node, 0, &res);
> -	if (err) {
> -		pr_warn("%s: no regs?\n", node->full_name);
> -		return -ENXIO;
> -	}
> -
> -	its_base = ioremap(res.start, resource_size(&res));
> +	its_base = ioremap(res->start, resource_size(res));
>  	if (!its_base) {
> -		pr_warn("%s: unable to map registers\n", node->full_name);
> +		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
>  		return -ENOMEM;
>  	}
>  
>  	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
>  	if (val != 0x30 && val != 0x40) {
> -		pr_warn("%s: no ITS detected, giving up\n", node->full_name);
> +		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
>  		err = -ENODEV;
>  		goto out_unmap;
>  	}
>  
>  	err = its_force_quiescent(its_base);
>  	if (err) {
> -		pr_warn("%s: failed to quiesce, giving up\n",
> -			node->full_name);
> +		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
>  		goto out_unmap;
>  	}
>  
> -	pr_info("ITS: %s\n", node->full_name);
> +	pr_info("ITS@%pa\n", &res->start);
>  
>  	its = kzalloc(sizeof(*its), GFP_KERNEL);
>  	if (!its) {
> @@ -1580,9 +1572,9 @@ static int __init its_probe(struct device_node *node,
>  	INIT_LIST_HEAD(&its->entry);
>  	INIT_LIST_HEAD(&its->its_device_list);
>  	its->base = its_base;
> -	its->phys_base = res.start;
> +	its->phys_base = res->start;
>  	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
> -	its->numa_node = of_node_to_nid(node);
> +	its->numa_node = numa_node;
>  
>  	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
>  	if (!its->cmd_base) {
> @@ -1593,7 +1585,7 @@ static int __init its_probe(struct device_node *node,
>  
>  	its_enable_quirks(its);
>  
> -	err = its_alloc_tables(node->full_name, its);
> +	err = its_alloc_tables(its);
>  	if (err)
>  		goto out_free_cmd;
>  
> @@ -1629,7 +1621,7 @@ static int __init its_probe(struct device_node *node,
>  	writeq_relaxed(0, its->base + GITS_CWRITER);
>  	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
>  
> -	err = its_init_domain(node, its, parent);
> +	err = its_init_domain(handle, its);
>  	if (err)
>  		goto out_free_tables;
>  
> @@ -1647,7 +1639,7 @@ out_free_its:
>  	kfree(its);
>  out_unmap:
>  	iounmap(its_base);
> -	pr_err("ITS: failed probing %s (%d)\n", node->full_name, err);
> +	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
>  	return err;
>  }
>  
> @@ -1675,10 +1667,10 @@ static struct of_device_id its_device_id[] = {
>  	{},
>  };
>  
> -int __init its_init(struct device_node *node, struct rdists *rdists,
> -	     struct irq_domain *parent_domain)
> +static int __init its_of_probe(struct device_node *node)
>  {
>  	struct device_node *np;
> +	struct resource res;
>  
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> @@ -1688,8 +1680,25 @@ int __init its_init(struct device_node *node, struct rdists *rdists,
>  			continue;
>  		}
>  
> -		its_probe(np, parent_domain);
> +		if (of_address_to_resource(np, 0, &res)) {
> +			pr_warn("%s: no regs?\n", np->full_name);
> +			continue;
> +		}
> +
> +		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
>  	}
> +	return 0;
> +}
> +
> +int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
> +		    struct irq_domain *parent_domain)
> +{
> +	struct device_node *of_node;
> +
> +	its_parent = parent_domain;
> +	of_node = to_of_node(handle);
> +	if (of_node)
> +		its_of_probe(of_node);

If you add an "else return -ENODEV;" here...

>  
>  	if (list_empty(&its_nodes)) {
>  		pr_warn("ITS: No ITS available, not enabling LPIs\n");
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 2c5ba0e..019b442 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -911,7 +911,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  				 u64 redist_stride,
>  				 struct fwnode_handle *handle)
>  {
> -	struct device_node *node;
>  	u32 typer;
>  	int gic_irqs;
>  	int err;
> @@ -952,10 +951,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	set_handle_irq(gic_handle_irq);
>  
> -	node = to_of_node(handle);
>  	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
> -	    node) /* Temp hack to prevent ITS init for ACPI */
> -		its_init(node, &gic_data.rdists, gic_data.domain);
> +	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
> +		its_init(handle, &gic_data.rdists, gic_data.domain);

... you nuke this hack in this patch. The sooner the better.

>  
>  	gic_smp_init();
>  	gic_dist_init();
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index dc493e0..2136639 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -334,9 +334,9 @@ struct rdists {
>  };
>  
>  struct irq_domain;
> -struct device_node;
> +struct fwnode_handle;
>  int its_cpu_init(void);
> -int its_init(struct device_node *node, struct rdists *rdists,
> +int its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  	     struct irq_domain *domain);
>  
>  static inline bool gic_enable_sre(void)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
