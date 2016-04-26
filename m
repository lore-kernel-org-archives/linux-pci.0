Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40760 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbcDZSj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 14:39:57 -0400
Date: Tue, 26 Apr 2016 13:39:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Robert Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org,
	devel@acpica.org
Subject: Re: [PATCH V3 3/4] acpi,pci,irq: remove redundant code in
 acpi_irq_penalty_init
Message-ID: <20160426183952.GE27803@localhost>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <1460914617-8259-3-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460914617-8259-3-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 17, 2016 at 01:36:55PM -0400, Sinan Kaya wrote:
> acpi_irq_get_penalty is now calculating the penalty on the fly now.
> No need to maintain global list of penalties or calculate them
> at the init time. Removing duplicate code in acpi_irq_penalty_init.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  arch/x86/pci/acpi.c         |  1 -
>  drivers/acpi/pci_link.c     | 36 ------------------------------------
>  include/acpi/acpi_drivers.h |  1 -
>  3 files changed, 38 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 3cd6983..b2a4e2a 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -396,7 +396,6 @@ int __init pci_acpi_init(void)
>  		return -ENODEV;
>  
>  	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
> -	acpi_irq_penalty_init();

Yay!  Another x86-ism and init ordering issue gone!  Thanks for doing
this!

>  	pcibios_enable_irq = acpi_pci_irq_enable;
>  	pcibios_disable_irq = acpi_pci_irq_disable;
>  	x86_init.pci.init_irq = x86_init_noop;
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 12ea784..ab39208 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -520,42 +520,6 @@ static int acpi_irq_get_penalty(int irq)
>  	return penalty;
>  }
>  
> -int __init acpi_irq_penalty_init(void)
> -{
> -	struct acpi_pci_link *link;
> -	int i;
> -
> -	/*
> -	 * Update penalties to facilitate IRQ balancing.
> -	 */
> -	list_for_each_entry(link, &acpi_link_list, list) {
> -
> -		/*
> -		 * reflect the possible and active irqs in the penalty table --
> -		 * useful for breaking ties.
> -		 */
> -		if (link->irq.possible_count) {
> -			int penalty =
> -			    PIRQ_PENALTY_PCI_POSSIBLE /
> -			    link->irq.possible_count;
> -
> -			for (i = 0; i < link->irq.possible_count; i++) {
> -				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
> -					acpi_isa_irq_penalty[link->irq.
> -							 possible[i]] +=
> -					    penalty;
> -			}
> -
> -		} else if (link->irq.active &&
> -				(link->irq.active < ACPI_MAX_ISA_IRQS)) {
> -			acpi_isa_irq_penalty[link->irq.active] +=
> -			    PIRQ_PENALTY_PCI_POSSIBLE;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
>  
>  static int acpi_pci_link_allocate(struct acpi_pci_link *link)
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 29c6912..797ae2e 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -78,7 +78,6 @@
>  
>  /* ACPI PCI Interrupt Link (pci_link.c) */
>  
> -int acpi_irq_penalty_init(void);
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
>  			       int *polarity, char **name);
>  int acpi_pci_link_free_irq(acpi_handle handle);
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
