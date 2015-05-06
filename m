Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 6 May 2015 12:22:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Daniel J Blueman <daniel@numascale.com>
Subject: Re: [Patch v2] x86, irq: Support CPU vector allocation policies
In-Reply-To: <1430901368-20686-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505061216390.4225@nanos>
References: <alpine.DEB.2.11.1505052116210.4225@nanos> <1430901368-20686-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 6 May 2015, Jiang Liu wrote:
> Hi Thomas,
> 	This is the simplified version, which removed the kernel parameter.
> Seems much simpler:)

But it can be made even simpler. :)
 
> +enum {
> +	/* Allocate CPU vectors from CPUs on device local node */
> +	X86_VECTOR_POL_NODE = 0x1,
> +	/* Allocate CPU vectors from all online CPUs */
> +	X86_VECTOR_POL_GLOBAL = 0x2,
> +	/* Allocate CPU vectors from caller specified CPUs */
> +	X86_VECTOR_POL_CALLER = 0x4,
> +	X86_VECTOR_POL_MIN = X86_VECTOR_POL_NODE,
> +	X86_VECTOR_POL_MAX = X86_VECTOR_POL_CALLER,
> +};

  
> +static int assign_irq_vector_policy(int irq, int node,
> +				    struct apic_chip_data *data,
> +				    struct irq_alloc_info *info)
> +{
> +	int err = -EBUSY;
> +	unsigned int policy;
> +	const struct cpumask *mask;
> +
> +	if (info && info->mask)
> +		policy = X86_VECTOR_POL_CALLER;
> +	else
> +		policy = X86_VECTOR_POL_MIN;
> +
> +	for (; policy <= X86_VECTOR_POL_MAX; policy <<= 1) {
> +		switch (policy) {
> +		case X86_VECTOR_POL_NODE:
> +			if (node >= 0)
> +				mask = cpumask_of_node(node);
> +			else
> +				mask = NULL;
> +			break;
> +		case X86_VECTOR_POL_GLOBAL:
> +			mask = apic->target_cpus();
> +			break;
> +		case X86_VECTOR_POL_CALLER:
> +			if (info && info->mask)
> +				mask = info->mask;
> +			else
> +				mask = NULL;
> +			break;
> +		default:
> +			mask = NULL;
> +			break;
> +		}
> +		if (mask) {
> +			err = assign_irq_vector(irq, data, mask);
> +			if (!err)
> +				return 0;
> +		}
> +	}

This looks pretty overengineered now that you don't have that parameter check.

	if (info && info->mask)
		return assign_irq_vector(irq, data, info->mask);

	if (node >= 0) {
		err = assign_irq_vector(irq, data, cpumask_of_node(node));
		if (!err)
			return 0;
	}

	return assign_irq_vector(irq, data, apic->target_cpus());

Should do the same, right?

Thanks,

	tglx
