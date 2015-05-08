Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <554C27C7.5050408@huawei.com>
Date: Fri, 8 May 2015 11:04:39 +0800
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
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	"Jason Cooper" <jason@lakedaemon.net>,
	Grant Likely <grant.likely@linaro.org>,
	"Kevin Cernekee" <cernekee@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-sh@vger.kernel.org>
Subject: Re: [RFC v1 02/11] genirq: Move field 'node' from struct irq_data
 into struct irq_common_data
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-3-git-send-email-jiang.liu@linux.intel.com> <554C1F9C.7020300@huawei.com>
In-Reply-To: <554C1F9C.7020300@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/8 10:29, Yun Wu (Abel) wrote:

> Hi Gerry,
> On 2015/5/4 11:15, Jiang Liu wrote:
> 
>> NUMA node information is per-irq instead of per-irqchip, so move it into
>> struct irq_common_data.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  arch/sh/kernel/irq.c          |    2 +-
>>  arch/x86/kernel/apic/vector.c |    8 ++++----
>>  arch/x86/platform/uv/uv_irq.c |    2 +-
>>  include/linux/irq.h           |   20 ++++++++++++++++++--
>>  kernel/irq/internals.h        |    5 +++++
>>  kernel/irq/irqdesc.c          |   10 ++--------
>>  kernel/irq/irqdomain.c        |    4 ++--
>>  kernel/irq/manage.c           |    2 +-
>>  kernel/irq/proc.c             |    2 +-
>>  9 files changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
>> index eb10ff84015c..8dc677cc136b 100644
>> --- a/arch/sh/kernel/irq.c
>> +++ b/arch/sh/kernel/irq.c
>> @@ -227,7 +227,7 @@ void migrate_irqs(void)
>>  	for_each_active_irq(irq) {
>>  		struct irq_data *data = irq_get_irq_data(irq);
>>  
>> -		if (data->node == cpu) {
>> +		if (irq_data_get_node(data) == cpu) {
>>  			unsigned int newcpu = cpumask_any_and(data->affinity,
>>  							      cpu_online_mask);
>>  			if (newcpu >= nr_cpu_ids) {
>> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
>> index 96ce5068a926..983bea2a09ce 100644
>> --- a/arch/x86/kernel/apic/vector.c
>> +++ b/arch/x86/kernel/apic/vector.c
>> @@ -345,7 +345,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>>  	struct irq_alloc_info *info = arg;
>>  	struct apic_chip_data *data;
>>  	struct irq_data *irq_data;
>> -	int i, err;
>> +	int i, err, node;
>>  
>>  	if (disable_apic)
>>  		return -ENXIO;
>> @@ -357,12 +357,13 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>>  	for (i = 0; i < nr_irqs; i++) {
>>  		irq_data = irq_domain_get_irq_data(domain, virq + i);
>>  		BUG_ON(!irq_data);
>> +		node = irq_data_get_node(irq_data);
>>  #ifdef	CONFIG_X86_IO_APIC
>>  		if (virq + i < nr_legacy_irqs() && legacy_irq_data[virq + i])
>>  			data = legacy_irq_data[virq + i];
>>  		else
>>  #endif
>> -			data = alloc_apic_chip_data(irq_data->node);
>> +			data = alloc_apic_chip_data(node);
>>  		if (!data) {
>>  			err = -ENOMEM;
>>  			goto error;
>> @@ -371,8 +372,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>>  		irq_data->chip = &lapic_controller;
>>  		irq_data->chip_data = data;
>>  		irq_data->hwirq = virq + i;
>> -		err = assign_irq_vector_policy(virq, irq_data->node, data,
>> -					       info);
>> +		err = assign_irq_vector_policy(virq, node, data, info);
>>  		if (err)
>>  			goto error;
>>  	}
>> diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
>> index cdf86cd3fd97..bc992b7b041f 100644
>> --- a/arch/x86/platform/uv/uv_irq.c
>> +++ b/arch/x86/platform/uv/uv_irq.c
>> @@ -89,7 +89,7 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>  		return -EINVAL;
>>  
>>  	chip_data = kmalloc_node(sizeof(*chip_data), GFP_KERNEL,
>> -				 irq_data->node);
>> +				 irq_data_get_node(irq_data));
>>  	if (!chip_data)
>>  		return -ENOMEM;
>>  
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index 3b6e0def7f5c..3f999a0af713 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -129,9 +129,13 @@ struct irq_domain;
>>   * struct irq_common_data - per irq data shared by all irqchips
>>   * @state_use_accessors: status information for irq chip functions.
>>   *			Use accessor functions to deal with it
>> + * @node:		node index useful for balancing
>>   */
>>  struct irq_common_data {
>>  	unsigned int		state_use_accessors;
>> +#ifdef CONFIG_SMP
> 
> Would CONFIG_NUMA be a little more appropriate?
> Or even let @node be always compiled?

Sorry for comment before reading your next patch in which you replaced
CONFIG_SMP with CONFIG_NUMA.
And letting @node be under CONFIG_NUMA makes sense, because it's useless
in non-NUMA scenario.

Thanks,
	Abel

> 
> 
>> +	unsigned int		node;
>> +#endif
>>  };
>>  
>>  /**
>> @@ -139,7 +143,6 @@ struct irq_common_data {
>>   * @mask:		precomputed bitmask for accessing the chip registers
>>   * @irq:		interrupt number
>>   * @hwirq:		hardware interrupt number, local to the interrupt domain
>> - * @node:		node index useful for balancing
>>   * @common:		point to data shared by all irqchips
>>   * @chip:		low level interrupt hardware access
>>   * @domain:		Interrupt translation domain; responsible for mapping
>> @@ -160,7 +163,6 @@ struct irq_data {
>>  	u32			mask;
>>  	unsigned int		irq;
>>  	unsigned long		hwirq;
>> -	unsigned int		node;
>>  	struct irq_common_data	*common;
>>  	struct irq_chip		*chip;
>>  	struct irq_domain	*domain;
>> @@ -634,6 +636,20 @@ static inline u32 irq_get_trigger_type(unsigned int irq)
>>  	return d ? irqd_get_trigger_type(d) : 0;
>>  }
>>  
>> +static inline int irq_common_data_get_node(struct irq_common_data *d)
>> +{
>> +#ifdef CONFIG_SMP
>> +	return d->node;
>> +#else
>> +	return 0;
>> +#endif
>> +}
>> +
>> +static inline int irq_data_get_node(struct irq_data *d)
>> +{
>> +	return irq_common_data_get_node(d->common);
>> +}
>> +
>>  unsigned int arch_dynirq_lower_bound(unsigned int from);
>>  
>>  int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
>> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
>> index ed84299788b3..d82a77d39aeb 100644
>> --- a/kernel/irq/internals.h
>> +++ b/kernel/irq/internals.h
>> @@ -199,6 +199,11 @@ static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *d
>>  	__this_cpu_inc(kstat.irqs_sum);
>>  }
>>  
>> +static inline int irq_desc_get_node(struct irq_desc *desc)
>> +{
>> +	return irq_common_data_get_node(&desc->irq_common_data);
>> +}
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  bool irq_pm_check_wakeup(struct irq_desc *desc);
>>  void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index eac1aac906ea..20773f073e24 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -52,23 +52,17 @@ static int alloc_masks(struct irq_desc *desc, gfp_t gfp, int node)
>>  
>>  static void desc_smp_init(struct irq_desc *desc, int node)
>>  {
>> -	desc->irq_data.node = node;
>> +	desc->irq_common_data.node = node;
>>  	cpumask_copy(desc->irq_data.affinity, irq_default_affinity);
>>  #ifdef CONFIG_GENERIC_PENDING_IRQ
>>  	cpumask_clear(desc->pending_mask);
>>  #endif
>>  }
>>  
>> -static inline int desc_node(struct irq_desc *desc)
>> -{
>> -	return desc->irq_data.node;
>> -}
>> -
>>  #else
>>  static inline int
>>  alloc_masks(struct irq_desc *desc, gfp_t gfp, int node) { return 0; }
>>  static inline void desc_smp_init(struct irq_desc *desc, int node) { }
>> -static inline int desc_node(struct irq_desc *desc) { return 0; }
>>  #endif
>>  
>>  static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>> @@ -300,7 +294,7 @@ static void free_desc(unsigned int irq)
>>  	unsigned long flags;
>>  
>>  	raw_spin_lock_irqsave(&desc->lock, flags);
>> -	desc_set_defaults(irq, desc, desc_node(desc), NULL);
>> +	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL);
>>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>>  }
>>  
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 3552b8750efd..93ef89059022 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -830,12 +830,12 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
>>  {
>>  	struct irq_data *irq_data;
>>  
>> -	irq_data = kzalloc_node(sizeof(*irq_data), GFP_KERNEL, child->node);
>> +	irq_data = kzalloc_node(sizeof(*irq_data), GFP_KERNEL,
>> +				irq_data_get_node(child));
>>  	if (irq_data) {
>>  		child->parent_data = irq_data;
>>  		irq_data->irq = child->irq;
>>  		irq_data->common = child->common;
>> -		irq_data->node = child->node;
>>  		irq_data->domain = domain;
>>  	}
>>  
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index e68932bb308e..d206aa2c3378 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -332,7 +332,7 @@ static int
>>  setup_affinity(unsigned int irq, struct irq_desc *desc, struct cpumask *mask)
>>  {
>>  	struct cpumask *set = irq_default_affinity;
>> -	int node = desc->irq_data.node;
>> +	int node = irq_desc_get_node(desc);
>>  
>>  	/* Excludes PER_CPU and NO_BALANCE interrupts */
>>  	if (!irq_can_set_affinity(irq))
>> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
>> index df2f4642d1e7..0e97c142ce40 100644
>> --- a/kernel/irq/proc.c
>> +++ b/kernel/irq/proc.c
>> @@ -241,7 +241,7 @@ static int irq_node_proc_show(struct seq_file *m, void *v)
>>  {
>>  	struct irq_desc *desc = irq_to_desc((long) m->private);
>>  
>> -	seq_printf(m, "%d\n", desc->irq_data.node);
>> +	seq_printf(m, "%d\n", irq_desc_get_node(desc));
>>  	return 0;
>>  }
>>  
> 
> 



