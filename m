Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
References: <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 23 Oct 2016 14:49:15 +1100
Message-ID: <CANwerB36ZK=b5mxiJdY5GKQ0THcEUVMSA-XFKaNq=ezFzwRUww@mail.gmail.com>
Subject: Re: [V4,2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        linux@rainbow-software.org, timur@codeaurora.org,
        cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20 October 2016 at 09:21, Sinan Kaya <okaya@codeaurora.org> wrote:
> The SCI penalize function was removed in two steps (first refactor
> and then remove) and these changes are reverted here in one go.
>
> The commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> refactored the original code so that SCI penalty is calculated dynamically
> by the time get_penalty function is called. That change is partially
> reverted here, specifically for the SCI IRQ alone.
>
> The SCI penalize function was finally dropped by commit 9e5ed6d1fb87
> ("ACPI,PCI,IRQ: remove SCI penalize function") that replaced the old SCI
> penalty API with penalty calculation carried out dynamically and based
> on the acpi_gbl_FADT.sci_interrupt value.
>
> However, that new algorithm relies on the accurate setting of IRQ
> types and that doesn't happen early enough on some platforms which
> leads to incorrect penalty assignments for PCI IRQs.  In those cases,
> irq_get_trigger_type() returns incorrect values for the IRQs in
> question, because they have not been registered yet by the time the
> penalties are calculated.
>
> To fix this problem, we only need to fix the penalty for the SCI interrupt.
> It seems better to add a single "sci_penalty" variable, set it to
> PIRQ_PENALTY_PCI_USING if it's level/low or PIRQ_PENALTY_ISA_ALWAYS
> otherwise, and add "sci_penalty" in when appropriate.  That should fix it
> for *any* SCI IRQ, not just those less than 256, and we don't have to add
> these extra penalty table entries that are all unused (except possibly for
> one entry if we have an SCI in the 16-255 range).
>
> For this reason, revert commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI
> penalize function") completely to restore the correct behavior.
>
> Link: https://lkml.org/lkml/2016/10/4/283
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Fixes: commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> Fixes: commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize function")
> ---
>  arch/x86/kernel/acpi/boot.c |  1 +
>  drivers/acpi/pci_link.c     | 30 +++++++++++++++---------------
>  include/linux/acpi.h        |  1 +
>  3 files changed, 17 insertions(+), 15 deletions(-)
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
> index 4f37938..294b190 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -87,6 +87,7 @@ struct acpi_pci_link {
>
>  static LIST_HEAD(acpi_link_list);
>  static DEFINE_MUTEX(acpi_link_lock);
> +static int sci_irq = -1, sci_penalty;
>
>  /* --------------------------------------------------------------------------
>                              PCI Link Device Management
> @@ -496,25 +497,13 @@ static int acpi_irq_get_penalty(int irq)
>  {
>         int penalty = 0;
>
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
> +       if (irq == sci_irq)
> +               penalty += sci_penalty;
>
>         if (irq < ACPI_MAX_ISA_IRQS)
>                 return penalty + acpi_isa_irq_penalty[irq];
>
> -       penalty += acpi_irq_pci_sharing_penalty(irq);
> -       return penalty;
> +       return penalty + acpi_irq_pci_sharing_penalty(irq);
>  }
>
>  int __init acpi_irq_penalty_init(void)
> @@ -881,6 +870,17 @@ bool acpi_isa_irq_available(int irq)
>                     acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>
> +void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> +{
> +       sci_irq = irq;
> +
> +       if (trigger == ACPI_MADT_TRIGGER_LEVEL &&
> +           polarity == ACPI_MADT_POLARITY_ACTIVE_LOW)
> +               sci_penalty = PIRQ_PENALTY_PCI_USING;
> +       else
> +               sci_penalty = PIRQ_PENALTY_ISA_ALWAYS;
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

This series fixes one or more network adapters not working in Linux
32-bit x86 guest running inside VirtualBox if I have 4 network
adapters enabled. The following message no longer appears in the
kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
