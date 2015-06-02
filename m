Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 2 Jun 2015 21:19:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Feng Wu <feng.wu@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Brian Gerst <brgerst@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Juergen Gross <jgross@suse.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, xen-devel@lists.xenproject.org
Subject: Re: [Patch v3 27/36] x86, irq: Use access helper
 irq_data_get_affinity_mask()
In-Reply-To: <1433145945-789-28-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1506021714170.20347@nanos>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com> <1433145945-789-28-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 1 Jun 2015, Jiang Liu wrote:

> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 9b62f690b0ff..dfa3a5f5b3d3 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -494,9 +494,8 @@ static int apic_set_affinity(struct irq_data *irq_data,
>  
>  	err = assign_irq_vector(irq, data, dest);
>  	if (err) {
> -		struct irq_data *top = irq_get_irq_data(irq);
> -
> -		if (assign_irq_vector(irq, data, top->affinity))
> +		if (assign_irq_vector(irq, data,
> +				      irq_data_get_affinity_mask(irq_data)))

Does this patch work w/o moving the affinity mask to common data? I
doubt so, as you remove the retrieval of 'top'.

Thanks,

	tglx
