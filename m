Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 6 Sep 2016 12:14:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Punit Agrawal <punit.agrawal@arm.com>,
        Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2] drivers: acpi: fix GIC irq model default PCI IRQ
 polarity
Message-ID: <20160906171401.GA7554@localhost>
References: <1473180663-20590-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473180663-20590-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 05:51:03PM +0100, Lorenzo Pieralisi wrote:
> On ACPI ARM based systems the GIC interrupt controller
> and corresponding interrupt model permit only the high
> polarity for level interrupts.
> 
> ACPI firmware describes PCI legacy IRQs through entries
> in the _PRT objects. Entries in the _PRT can be of two types:
> 
> - Static: not configurable, trigger/polarity default to level-low,
>   _PRT entry defines the global GSI interrupt number
> - Configurable: _PRT interrupt entry contains a reference to the
>   corresponding PCI interrupt link device (that in turn provides the
>   interrupt descriptor through its _CRS/_PRS methods)
> 
> Configurable IRQ entries are not currently allowed by the ACPI
> specification on ARM since they can only be used for interrupt pins that
> are routable, as per ACPI specifications (version 6.1, 6.2.13):
> 
> "[...] There are two ways that _PRT can be used. Typically, the
> interrupt input that a given PCI interrupt is on is configurable. For
> example, a given PCI interrupt might be configured for either IRQ 10 or
> 11 on an 8259 interrupt controller. In this model, each interrupt is
> represented in the ACPI namespace as a PCI Interrupt Link Device. [...]"

Thanks for the reference!  I wouldn't read that as actually
*disallowing* Interrupt Links for non-configurable interrupts.

But regardless, I do understand that even if we assume Interrupt Links
are allowed, there is firmware in the field that doesn't use them, and
I think this patch is really targeted at *them*.

> ARM platforms GIC configurations do not allow dynamic IRQ routing,
> since routing is statically laid out at synthesis time; therefore PCI
> interrupt links cannot be used for PCI legacy IRQ descriptions in the
> _PRT on ARM systems.
> 
> On the other hand, current core ACPI code handling PCI legacy IRQs
> consider IRQ trigger/polarity for static _PRT entries as level-low.
> 
> On ARM systems with a GIC interrupt controller and corresponding
> ACPI interrupt model this does not work in that GIC interrupt
> controller is only capable of handling level interrupts whose
> polarity is high (for PCI legacy IRQs - that are level-low by
> specification - this means that the legacy IRQs are inverted before
> reaching the interrupt controller pin), resulting in IRQ allocation
> failures such as:
> 
> genirq: Setting trigger mode 8 for irq 18 failed (gic_set_type+0x0/0x48)
> 
> Change the default polarity for PCI legacy IRQs to high on systems
> booting wth ACPI on platforms with a GIC interrupt controller model,
> fixing the discrepancy between specification and HW behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Duc Dang <dhdang@apm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> v1 -> v2:
> 
> - Added ACPI specs PCI Interrupt Link device usage restrictions in
>   the patch commit log for explanation
> - Added review tags
> 
>  drivers/acpi/pci_irq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 2c45dd3..c576a6f 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -411,7 +411,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  	int gsi;
>  	u8 pin;
>  	int triggering = ACPI_LEVEL_SENSITIVE;
> -	int polarity = ACPI_ACTIVE_LOW;
> +	/*
> +	 * On ARM systems with the GIC interrupt model, level interrupts
> +	 * are always polarity high by specification; PCI legacy
> +	 * IRQs lines are inverted before reaching the interrupt
> +	 * controller and must therefore be considered active high
> +	 * as default.
> +	 */
> +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> +				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>  	char *link = NULL;
>  	char link_desc[16];
>  	int rc;
> -- 
> 2.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
