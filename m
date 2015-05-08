Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:49728 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbEHCfS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 22:35:18 -0400
Message-ID: <554C1E3F.7050306@huawei.com>
Date: Fri, 8 May 2015 10:23:59 +0800
From: "Yun Wu (Abel)" <wuyun.wu@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Grant Likely <grant.likely@linaro.org>,
	"Kevin Cernekee" <cernekee@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [RFC v1 01/11] genirq: Introduce struct irq_common_data to host
 shared irq data
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430709339-29083-2-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/4 11:15, Jiang Liu wrote:

[...]
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index dd1109fb241e..3010e99abf3e 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -47,6 +47,7 @@ struct pt_regs;
>   * @name:		flow handler name for /proc/interrupts output
>   */
>  struct irq_desc {
> +	struct irq_common_data	irq_common_data;

Hi Gerry,

Please update description as well. :)

Thanks,
	Abel

>  	struct irq_data		irq_data;
>  	unsigned int __percpu	*kstat_irqs;
>  	irq_flow_handler_t	handle_irq;
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index df553b0af936..ed84299788b3 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -170,27 +170,27 @@ irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
>   */
>  static inline void irqd_set_move_pending(struct irq_data *d)
>  {
> -	d->state_use_accessors |= IRQD_SETAFFINITY_PENDING;
> +	__irqd_to_state(d) |= IRQD_SETAFFINITY_PENDING;
>  }
>  
>  static inline void irqd_clr_move_pending(struct irq_data *d)
>  {
> -	d->state_use_accessors &= ~IRQD_SETAFFINITY_PENDING;
> +	__irqd_to_state(d) &= ~IRQD_SETAFFINITY_PENDING;
>  }
>  
>  static inline void irqd_clear(struct irq_data *d, unsigned int mask)
>  {
> -	d->state_use_accessors &= ~mask;
> +	__irqd_to_state(d) &= ~mask;
>  }
>  
>  static inline void irqd_set(struct irq_data *d, unsigned int mask)
>  {
> -	d->state_use_accessors |= mask;
> +	__irqd_to_state(d) |= mask;
>  }
>  
>  static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
>  {
> -	return d->state_use_accessors & mask;
> +	return __irqd_to_state(d) & mask;
>  }
>  
>  static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *desc)
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 99793b9b6d23..eac1aac906ea 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -76,6 +76,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>  {
>  	int cpu;
>  
> +	desc->irq_data.common = &desc->irq_common_data;
>  	desc->irq_data.irq = irq;
>  	desc->irq_data.chip = &no_irq_chip;
>  	desc->irq_data.chip_data = NULL;
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 7fac311057b8..3552b8750efd 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -834,6 +834,7 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
>  	if (irq_data) {
>  		child->parent_data = irq_data;
>  		irq_data->irq = child->irq;
> +		irq_data->common = child->common;
>  		irq_data->node = child->node;
>  		irq_data->domain = domain;
>  	}



