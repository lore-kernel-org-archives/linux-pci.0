Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <53FCD816.6070108@infradead.org>
Date: Tue, 26 Aug 2014 11:55:18 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>, x86@kernel.org,
	Prarit Bhargava <prarit@redhat.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [Bugfix] x86, irq: Fix bug in setting IOAPIC pin attributes
References: <20140822124145.GF1660@lahna.fi.intel.com> <1409042706-11958-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1409042706-11958-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/26/14 01:45, Jiang Liu wrote:
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 29290f554e79..66c2700c9f83 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -3896,7 +3896,15 @@ int mp_irqdomain_map(struct irq_domain *domain, unsigned int virq,
> +		/*
> +		 * setup_IO_APIC_irqs() programs all legacy IRQs with default
> +		 * trigger and polarity attirbutes. Don't set the flag for that

		                        attributes.

> +		 * case so the first legacy IRQ user could reprogram the pin
> +		 * with real trigger and polarity attributes.
> +		 */

thanks,
-- 
~Randy
