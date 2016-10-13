Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Oct 2016 13:25:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
Message-ID: <20161013182528.GC21529@localhost>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1475615720-31047-4-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, ravikanth.nalla@hpe.com,
 timur@codeaurora.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux@rainbow-software.org,
 linux-pm@vger.kernel.org, jcm@redhat.com, alex.williamson@redhat.com,
 cov@codeaurora.org, bhelgaas@google.com, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, agross@codeaurora.org, wim@djo.tudelft.nl
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 04, 2016 at 05:15:19PM -0400, Sinan Kaya wrote:
> The SCI function was removed in two steps (first refactor and then remove).
> This patch does the revert in one step.
> 
> The commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> refactored the original code so that SCI penalty is calculated dynamically
> by the time get_penalty function is called. This patch does a partial
> revert for the SCI functionality only.
> 
> The commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize function") is
> for the removal of the function. SCI penalty API was replaced by the
> runtime penalty calculation based on the value of
> acpi_gbl_FADT.sci_interrupt.
> 
> The IRQ type does not get updated at the right time for some platforms and
> results in incorrect penalty assignment for PCI IRQs as
> irq_get_trigger_type returns the wrong type.
> 
> The register_gsi function delivers the IRQ found in the ACPI table to
> the interrupt controller driver.  Penalties are calculated before a
> link object is enabled to find out which interrupt has the least number
> of users. By the time penalties are calculated, the IRQ is not registered
> yet and the API returns the wrong type.
> 
> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Link: https://lkml.org/lkml/2016/10/4/283
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  arch/x86/kernel/acpi/boot.c |  1 +
>  drivers/acpi/pci_link.c     | 34 ++++++++++++++--------------------
>  include/linux/acpi.h        |  1 +
>  3 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 90d84c3..0ffd26e 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -453,6 +453,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
>  		polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
>  
>  	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
> +	acpi_penalize_sci_irq(bus_irq, trigger, polarity);
>  
>  	/*
>  	 * stash over-ride to indicate we've been here
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 06c2a11..6a2af19 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -495,27 +495,10 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>  
>  static int acpi_irq_get_penalty(int irq)
>  {
> -	int penalty = 0;
> -
> -	/*
> -	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
> -	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
> -	* use for PCI IRQs.
> -	*/
> -	if (irq == acpi_gbl_FADT.sci_interrupt) {
> -		u32 type = irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;
> -
> -		if (type != IRQ_TYPE_LEVEL_LOW)
> -			penalty += PIRQ_PENALTY_ISA_ALWAYS;
> -		else
> -			penalty += PIRQ_PENALTY_PCI_USING;
> -	}
> -
> -	if (irq < ACPI_MAX_ISA_IRQS)
> -		return penalty + acpi_irq_penalty[irq];
> +	if (irq < ACPI_MAX_IRQS)
> +		return acpi_irq_penalty[irq];
>  
> -	penalty += acpi_irq_pci_sharing_penalty(irq);
> -	return penalty;
> +	return acpi_irq_pci_sharing_penalty(irq);
>  }
>  
>  int __init acpi_irq_penalty_init(void)
> @@ -886,6 +869,17 @@ bool acpi_isa_irq_available(int irq)
>  		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>  
> +void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> +{
> +	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> +		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> +		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> +			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> +		else
> +			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;

This would be a lot easier to read if the trigger/polarity tests were
positive, e.g.,

  if (trigger == ACPI_MADT_TRIGGER_LEVEL &&
      polarity == ACPI_MADT_POLARITY_ACTIVE_LOW)
    acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
  else
    acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
      
> +	}
> +}
> +
>  /*
>   * Over-ride default table to reserve additional IRQs for use by ISA
>   * e.g. acpi_irq_isa=5
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4d8452c..85ac7d5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -318,6 +318,7 @@ struct pci_dev;
>  int acpi_pci_irq_enable (struct pci_dev *dev);
>  void acpi_penalize_isa_irq(int irq, int active);
>  bool acpi_isa_irq_available(int irq);
> +void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
>  void acpi_pci_irq_disable (struct pci_dev *dev);
>  
>  extern int ec_read(u8 addr, u8 *val);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
