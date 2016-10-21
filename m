Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 20 Oct 2016 21:31:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        agross@codeaurora.org, Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>, linux-arm-msm@vger.kernel.org,
        wim@djo.tudelft.nl, devel@acpica.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 3/3] Revert "ACPI, PCI, IRQ: separate ISA penalty
 calculation"
Message-ID: <20161021023109.GD31044@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 19, 2016 at 06:21:04PM -0400, Sinan Kaya wrote:
> This reverts commit f7eca374f000 ("ACPI,PCI,IRQ: separate ISA penalty
> calculation") and commit 487cf917ed0d ("revert "ACPI, PCI, IRQ: remove
> redundant code in acpi_irq_penalty_init()"").
> 
> Now that we understand the real issue (SCI and ISA penalty getting
> calculated before ACPI start), there is no need for special handling
> for ISA interrupts.
> 
> Let's try to simplify the code one more time to share code.

I'm sort of OK with this, but it's not exactly a revert of the above
(the commits you mention don't check "link->irq.initialized == 1".

Previously acpi_irq_penalty_init() looked at _PRS info ("possible"
IRQs), but now we won't.  Maybe that's good; I dunno.  But it should
be mentioned.

And I don't think it fixes a user-visible problem, so it doesn't need
to be applied immediately.  I'm not sure this is worth doing by
itself; maybe it should wait until we can do more cleanup and think
about all these issues together?

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  arch/x86/pci/acpi.c         |  1 -
>  drivers/acpi/pci_link.c     | 44 +++++---------------------------------------
>  include/acpi/acpi_drivers.h |  1 -
>  3 files changed, 5 insertions(+), 41 deletions(-)
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
>  	pcibios_enable_irq = acpi_pci_irq_enable;
>  	pcibios_disable_irq = acpi_pci_irq_disable;
>  	x86_init.pci.init_irq = x86_init_noop;
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 294b190..dd14d78 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -478,7 +478,8 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>  		 * If a link is active, penalize its IRQ heavily
>  		 * so we try to choose a different IRQ.
>  		 */
> -		if (link->irq.active && link->irq.active == irq)
> +		if ((link->irq.active && link->irq.active == irq) &&
> +				(link->irq.initialized == 1))
>  			penalty += PIRQ_PENALTY_PCI_USING;
>  
>  		/*
> @@ -501,45 +502,10 @@ static int acpi_irq_get_penalty(int irq)
>  		penalty += sci_penalty;
>  
>  	if (irq < ACPI_MAX_ISA_IRQS)
> -		return penalty + acpi_isa_irq_penalty[irq];
> +		penalty += acpi_isa_irq_penalty[irq];
>  
> -	return penalty + acpi_irq_pci_sharing_penalty(irq);
> -}
> -
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
> +	penalty += acpi_irq_pci_sharing_penalty(irq);
> +	return penalty;
>  }
>  
>  static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
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
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
