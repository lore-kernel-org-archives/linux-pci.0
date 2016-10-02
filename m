Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
References: <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 2 Oct 2016 22:40:44 +1100
Message-ID: <CANwerB1jnx7x28F0p4zOXJq6Cchs3+SNU3EHN0mV3jJ_90xjVQ@mail.gmail.com>
Subject: Re: [3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2 October 2016 at 04:46, Sinan Kaya <okaya@codeaurora.org> wrote:
> This reverts commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize
> function"). SCI penalty API was replaced by the runtime penalty calculation
> based on the value of acpi_gbl_FADT.sci_interrupt.
>
> acpi_gbl_FADT.sci_interrupt type does not get updated at the right time
> for some platforms and results in incorrect penalty assignment for PCI
> IRQs as irq_get_trigger_type returns the wrong type.
>
> Link: http://www.spinics.net/lists/linux-pci/msg54599.html
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
>                 polarity = acpi_sci_flags & ACPI_MADT_POLARITY_MASK;
>
>         mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
> +       acpi_penalize_sci_irq(bus_irq, trigger, polarity);
>
>         /*
>          * stash over-ride to indicate we've been here
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 06c2a11..6a2af19 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -495,27 +495,10 @@ static int acpi_irq_pci_sharing_penalty(int irq)
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
> -       if (irq < ACPI_MAX_ISA_IRQS)
> -               return penalty + acpi_irq_penalty[irq];
> +       if (irq < ACPI_MAX_IRQS)
> +               return acpi_irq_penalty[irq];
>
> -       penalty += acpi_irq_pci_sharing_penalty(irq);
> -       return penalty;
> +       return acpi_irq_pci_sharing_penalty(irq);
>  }
>
>  int __init acpi_irq_penalty_init(void)
> @@ -886,6 +869,17 @@ bool acpi_isa_irq_available(int irq)
>                     acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>
> +void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> +{
> +       if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> +               if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> +                   polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> +                       acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> +               else
> +                       acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> +       }
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

This series fixes one or more network adapters in VirtualBox not
working with Linux 32-bit x86 guest if I have 4 network adapters
enabled. The following message no longer appears in the kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
