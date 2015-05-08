Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 08 May 2015 15:21:31 +0800
From: Daniel J Blueman <daniel@numascale.com>
Subject: Re: [Patch v3] x86, irq: Allocate CPU vectors from device local
 CPUs if possible
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Message-Id: <1431069691.9785.7@cpanel21.proisp.no>
In-Reply-To: <1430967244-28905-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430967244-28905-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 7, 2015 at 10:53 AM, Jiang Liu <jiang.liu@linux.intel.com> 
wrote:
> On NUMA systems, an IO device may be associated with a NUMA node.
> It may improve IO performance to allocate resources, such as memory
> and interrupts, from device local node.
> 
> This patch introduces a mechanism to support CPU vector allocation
> policies. It tries to allocate CPU vectors from CPUs on device local
> node first, and then fallback to all online(global) CPUs.
> 
> This mechanism may be used to support NumaConnect systems to allocate
> CPU vectors from device local node.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Daniel J Blueman <daniel@numascale.com>
> ---
> Hi Thomas,
> 	I feel this should be simpliest version now:)
> Thanks!
> Gerry
> ---
>  arch/x86/kernel/apic/vector.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c 
> b/arch/x86/kernel/apic/vector.c
> index 1c7dd42b98c1..eb65c6b98de0 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -210,6 +210,18 @@ static int assign_irq_vector(int irq, struct 
> apic_chip_data *data,
>  	return err;
>  }
> 
> +static int assign_irq_vector_policy(int irq, int node,
> +				    struct apic_chip_data *data,
> +				    struct irq_alloc_info *info)
> +{
> +	if (info && info->mask)
> +		return assign_irq_vector(irq, data, info->mask);
> +	if (node != NUMA_NO_NODE &&
> +	    assign_irq_vector(irq, data, cpumask_of_node(node)) == 0)
> +		return 0;
> +	return assign_irq_vector(irq, data, apic->target_cpus());
> +}
> +
>  static void clear_irq_vector(int irq, struct apic_chip_data *data)
>  {
>  	int cpu, vector;
> @@ -258,12 +270,6 @@ void copy_irq_alloc_info(struct irq_alloc_info 
> *dst, struct irq_alloc_info *src)
>  		memset(dst, 0, sizeof(*dst));
>  }
> 
> -static inline const struct cpumask *
> -irq_alloc_info_get_mask(struct irq_alloc_info *info)
> -{
> -	return (!info || !info->mask) ? apic->target_cpus() : info->mask;
> -}
> -
>  static void x86_vector_free_irqs(struct irq_domain *domain,
>  				 unsigned int virq, unsigned int nr_irqs)
>  {
> @@ -289,7 +295,6 @@ static int x86_vector_alloc_irqs(struct 
> irq_domain *domain, unsigned int virq,
>  {
>  	struct irq_alloc_info *info = arg;
>  	struct apic_chip_data *data;
> -	const struct cpumask *mask;
>  	struct irq_data *irq_data;
>  	int i, err;
> 
> @@ -300,7 +305,6 @@ static int x86_vector_alloc_irqs(struct 
> irq_domain *domain, unsigned int virq,
>  	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
>  		return -ENOSYS;
> 
> -	mask = irq_alloc_info_get_mask(info);
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_data = irq_domain_get_irq_data(domain, virq + i);
>  		BUG_ON(!irq_data);
> @@ -318,7 +322,8 @@ static int x86_vector_alloc_irqs(struct 
> irq_domain *domain, unsigned int virq,
>  		irq_data->chip = &lapic_controller;
>  		irq_data->chip_data = data;
>  		irq_data->hwirq = virq + i;
> -		err = assign_irq_vector(virq, data, mask);
> +		err = assign_irq_vector_policy(virq, irq_data->node, data,
> +					       info);
>  		if (err)
>  			goto error;
>  	}

Testing x86/tip/apic with this patch on a 192 core/24 node NumaConnect 
system, all the PCIe bridge, GPU, SATA, NIC etc interrupts are 
allocated on the correct NUMA nodes, so it works great. Tested-by: 
Daniel J Blueman <daniel@numascale.com>

Many thanks!
  Daniel

