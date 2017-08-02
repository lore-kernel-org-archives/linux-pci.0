Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdHBVpk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:45:40 -0400
Date: Wed, 2 Aug 2017 16:45:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] xen/pci: Use acpi_noirq_set() helper
Message-ID: <20170802214537.GM20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170717103907.77308-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170717103907.77308-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 17, 2017 at 01:39:07PM +0300, Andy Shevchenko wrote:
> No need to keep an #ifdef since we have a helper (in x86 world).
> Use it instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks reasonable to me, and I assume some non-PCI tree will take it.

> ---
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
> 2.11.0
> 
