Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdKUXyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Nov 2017 18:54:17 -0500
Date: Tue, 21 Nov 2017 17:54:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] xen/pci: Use acpi_noirq_set() helper
Message-ID: <20171121235409.GA2282@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110180819.83868-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110180819.83868-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 08:08:19PM +0200, Andy Shevchenko wrote:
> No need to keep an #ifdef since we have a helper (in x86 world).
> Use it instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - resend as v2 with slightly longer Cc list, i.e. +Rafael and ACPI ML
> - in v1 Bjorn told he is okay with patch, but assumed it goes not via PCI tree

Sorry, I didn't understand your pings on the previous patch correctly,
and I still assumed a Xen or x86 person would take this.  Since they
haven't, I put it on pci/virtualization for v4.16.

If anybody else wants it and does pick it up, let me know and I'll
drop it.

Bjorn

>  arch/x86/pci/xen.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index c4b3646bd04c..9542a746dc50 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -409,10 +409,8 @@ int __init pci_xen_init(void)
>  	pcibios_enable_irq = xen_pcifront_enable_irq;
>  	pcibios_disable_irq = NULL;
>  
> -#ifdef CONFIG_ACPI
>  	/* Keep ACPI out of the picture */
> -	acpi_noirq = 1;
> -#endif
> +	acpi_noirq_set();
>  
>  #ifdef CONFIG_PCI_MSI
>  	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
