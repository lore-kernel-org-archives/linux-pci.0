Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556D4C73.7090202@huawei.com>
Date: Tue, 2 Jun 2015 14:25:55 +0800
From: Hanjun Guo <guohanjun@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v3 17/36] ARM64, irq: Use access helper irq_data_get_affinity_mask()
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com> <1433145945-789-18-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-18-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/1 16:05, Jiang Liu wrote:
> Use access helper irq_data_get_affinity_mask() to hide implementation
> details of struct irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm64/kernel/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 240b75c0e94f..463fa2e7e34c 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -61,7 +61,7 @@ void __init init_IRQ(void)
>  static bool migrate_one_irq(struct irq_desc *desc)
>  {
>  	struct irq_data *d = irq_desc_get_irq_data(desc);
> -	const struct cpumask *affinity = d->affinity;
> +	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
>  	struct irq_chip *c;
>  	bool ret = false;
>  
> @@ -81,7 +81,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	if (!c->irq_set_affinity)
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
>  	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
> -		cpumask_copy(d->affinity, affinity);
> +		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
>  
>  	return ret;
>  }

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun



