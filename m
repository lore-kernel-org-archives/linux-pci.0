Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1476505867-24599-3-git-send-email-okaya@codeaurora.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org> <1476505867-24599-3-git-send-email-okaya@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 15 Oct 2016 15:06:58 +0200
Message-ID: <CAJZ5v0iqCF7oOq_xH2ikaD8g_0K+oqitKOteUcv23iYkp5wWJw@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        Ondrej Zary <linux@rainbow-software.org>,
        Timur Tabi <timur@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Jon Masters <jcm@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 15, 2016 at 6:31 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The SCI function was removed in two steps (first refactor and then remove).
> This patch does the revert in one step.

"The SCI penalize function was removed in two steps (first refactor
and then remove) and these changes are reverted here in one go."

>
> The commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> refactored the original code so that SCI penalty is calculated dynamically
> by the time get_penalty function is called. This patch does a partial
> revert for the SCI functionality only.

I'd write the last sentence this way:

"That change is partially reverted here, specifically for the SCI IRQ alone."

> The commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize function") is
> for the removal of the function. SCI penalty API was replaced by the
> runtime penalty calculation based on the value of
> acpi_gbl_FADT.sci_interrupt.

"The SCI penalize function was finally dropped by commit 9e5ed6d1fb87
(ACPI,PCI,IRQ: remove SCI penalize function) that replaced the old SCI
penalty API with penalty calculation carried out dynamically and based
on the acpi_gbl_FADT.sci_interrupt value."

> The IRQ type does not get updated at the right time for some platforms and
> results in incorrect penalty assignment for PCI IRQs as
> irq_get_trigger_type returns the wrong type.

"However, that new algorithm relies on the accurate setting of IRQ
types and that doesn't happen early enough on some platforms which
leads to incorrect penalty assignments for PCI IRQs.  In those cases,
irq_get_trigger_type() returns incorrect values for the IRQs in
question, because they have not been registered yet by the time the
penalties are calculated."

And then you don't need the paragraph below then.

> The register_gsi function delivers the IRQ found in the ACPI table to
> the interrupt controller driver.  Penalties are calculated before a
> link object is enabled to find out which interrupt has the least number
> of users. By the time penalties are calculated, the IRQ is not registered
> yet and the API returns the wrong type.

And I would add:

"For this reason, revert commit 9e5ed6d1fb87 (ACPI,PCI,IRQ: remove SCI
penalize function) completely to restore the correct behavior."

Also, please add Fixes: tags pointing to the commits you're fixing here.

> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Link: https://lkml.org/lkml/2016/10/4/283
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/acpi/boot.c |  1 +
>  drivers/acpi/pci_link.c     | 32 +++++++++++++-------------------
>  include/linux/acpi.h        |  1 +
>  3 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 90d84c3..0ffd26e 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -453,6 +453,7 @@ static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger,
>                 polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
>
>         mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
> +       acpi_penalize_sci_irq(bus_irq, trigger, polarity);
>
>         /*
>          * stash over-ride to indicate we've been here
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index a212709..1934e2a 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -494,27 +494,10 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>
>  static int acpi_irq_get_penalty(int irq)
>  {
> -       int penalty = 0;
> -
> -       /*
> -       * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
> -       * with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
> -       * use for PCI IRQs.
> -       */
> -       if (irq == acpi_gbl_FADT.sci_interrupt) {
> -               u32 type = irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;
> -
> -               if (type != IRQ_TYPE_LEVEL_LOW)
> -                       penalty += PIRQ_PENALTY_ISA_ALWAYS;
> -               else
> -                       penalty += PIRQ_PENALTY_PCI_USING;
> -       }
> -
>         if (irq < ACPI_MAX_ISA_IRQS)
> -               return penalty + acpi_isa_irq_penalty[irq];
> +               return acpi_isa_irq_penalty[irq];
>
> -       penalty += acpi_irq_pci_sharing_penalty(irq);
> -       return penalty;
> +       return acpi_irq_pci_sharing_penalty(irq);
>  }
>
>  int __init acpi_irq_penalty_init(void)
> @@ -885,6 +868,17 @@ bool acpi_isa_irq_available(int irq)
>                     acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>
> +void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> +{
> +       if (irq >= 0 && irq < ARRAY_SIZE(acpi_isa_irq_penalty)) {
> +               if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> +                   polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> +                       acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> +               else
> +                       acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> +       }
> +}
> +
>  /*
>   * Over-ride default table to reserve additional IRQs for use by ISA
>   * e.g. acpi_irq_isa=5
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c5eaf2f..67d1d3e 100644
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
