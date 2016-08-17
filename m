Return-Path: <guohanjun@huawei.com>
Return-Path: <guohanjun@huawei.com>
Subject: Re: [PATCH V8 5/8] irqchip/gicv3-its: Refactor ITS DT init code to
 prepare for ACPI
To: Tomasz Nowicki <tn@semihalf.com>, <marc.zyngier@arm.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-6-git-send-email-tn@semihalf.com>
CC: <will.deacon@arm.com>, <catalin.marinas@arm.com>, <hanjun.guo@linaro.org>,
        <shijie.huang@arm.com>, <robert.richter@caviumnetworks.com>,
        <mw@semihalf.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linaro-acpi@lists.linaro.org>,
        <andrea.gallo@linaro.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <al.stone@linaro.org>,
        <graeme.gregory@linaro.org>, <ddaney.cavm@gmail.com>,
        <okaya@codeaurora.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <57B4213E.3060201@huawei.com>
Date: Wed, 17 Aug 2016 16:33:02 +0800
MIME-Version: 1.0
In-Reply-To: <1470909998-16710-6-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 2016/8/11 18:06, Tomasz Nowicki wrote:
> In order to add ACPI support we need to isolate ACPI&DT common code and
> move DT logic to corresponding functions. To achieve this we are using
> firmware agnostic handle which can be unpacked to either DT or ACPI node.
>
> No functional changes other than a very minor one:
> 1. Terminate its_init call with -ENODEV for non-DT case which allows
> to remove hack from its-gic-v3.c.
> 2. Fix ITS base register address type (from 'unsigned long' to 'phys_addr_t'),
> as a bonus we get nice string formatting.
> 3. Since there is only one of ITS parent domain convert it to static global
> variable and drop the parameter from its_probe_one. Users can refer to it
> in more convenient way then.
[...]
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
                ^^

When I was testing this patch set I found message printed as below:

[    0.000000] ITS@0x00000000c6000000
[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices @27dc400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 2048 Virtual CPUs @27dc820000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt Collections @27dc80f000 (flat, esz 8, psz 4K, shr 1)

Seems this print is redundant, can we remove it?

Thanks
Hanjun
