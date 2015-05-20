Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 May 2015 17:23:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 13/25] genirq: Kill the parameter 'irq' of
 kstat_incr_irqs_this_cpu()
In-Reply-To: <1432116013-25902-14-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201721590.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-14-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Jiang Liu wrote:
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index d82a77d39aeb..ab675f282291 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -193,7 +193,7 @@ static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
>  	return __irqd_to_state(d) & mask;
>  }
>  
> -static inline void kstat_incr_irqs_this_cpu(unsigned int irq, struct irq_desc *desc)
> +static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
>  {
>  	__this_cpu_inc(*desc->kstat_irqs);
>  	__this_cpu_inc(kstat.irqs_sum);

That hunk does not apply. Neither on mainline nor on tip/x86/apic

Thanks,

	tglx
