Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36199 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965199AbcJWDt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2016 23:49:29 -0400
MIME-Version: 1.0
In-Reply-To: <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
References: <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 23 Oct 2016 14:49:27 +1100
Message-ID: <CANwerB1LDgFFKDVBVf1eAo5713niEDchqQDHHxet-SuAPNPq7Q@mail.gmail.com>
Subject: Re: [V4,3/3] Revert "ACPI,PCI,IRQ: separate ISA penalty calculation"
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        linux@rainbow-software.org, timur@codeaurora.org,
        cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20 October 2016 at 09:21, Sinan Kaya <okaya@codeaurora.org> wrote:
> This reverts commit f7eca374f000 ("ACPI,PCI,IRQ: separate ISA penalty
> calculation") and commit 487cf917ed0d ("revert "ACPI, PCI, IRQ: remove
> redundant code in acpi_irq_penalty_init()"").
>
> Now that we understand the real issue (SCI and ISA penalty getting
> calculated before ACPI start), there is no need for special handling
> for ISA interrupts.
>
> Let's try to simplify the code one more time to share code.
>
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
>                 return -ENODEV;
>
>         printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
> -       acpi_irq_penalty_init();
>         pcibios_enable_irq = acpi_pci_irq_enable;
>         pcibios_disable_irq = acpi_pci_irq_disable;
>         x86_init.pci.init_irq = x86_init_noop;
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 294b190..dd14d78 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -478,7 +478,8 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>                  * If a link is active, penalize its IRQ heavily
>                  * so we try to choose a different IRQ.
>                  */
> -               if (link->irq.active && link->irq.active == irq)
> +               if ((link->irq.active && link->irq.active == irq) &&
> +                               (link->irq.initialized == 1))
>                         penalty += PIRQ_PENALTY_PCI_USING;
>
>                 /*
> @@ -501,45 +502,10 @@ static int acpi_irq_get_penalty(int irq)
>                 penalty += sci_penalty;
>
>         if (irq < ACPI_MAX_ISA_IRQS)
> -               return penalty + acpi_isa_irq_penalty[irq];
> +               penalty += acpi_isa_irq_penalty[irq];
>
> -       return penalty + acpi_irq_pci_sharing_penalty(irq);
> -}
> -
> -int __init acpi_irq_penalty_init(void)
> -{
> -       struct acpi_pci_link *link;
> -       int i;
> -
> -       /*
> -        * Update penalties to facilitate IRQ balancing.
> -        */
> -       list_for_each_entry(link, &acpi_link_list, list) {
> -
> -               /*
> -                * reflect the possible and active irqs in the penalty table --
> -                * useful for breaking ties.
> -                */
> -               if (link->irq.possible_count) {
> -                       int penalty =
> -                           PIRQ_PENALTY_PCI_POSSIBLE /
> -                           link->irq.possible_count;
> -
> -                       for (i = 0; i < link->irq.possible_count; i++) {
> -                               if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
> -                                       acpi_isa_irq_penalty[link->irq.
> -                                                        possible[i]] +=
> -                                           penalty;
> -                       }
> -
> -               } else if (link->irq.active &&
> -                               (link->irq.active < ACPI_MAX_ISA_IRQS)) {
> -                       acpi_isa_irq_penalty[link->irq.active] +=
> -                           PIRQ_PENALTY_PCI_POSSIBLE;
> -               }
> -       }
> -
> -       return 0;
> +       penalty += acpi_irq_pci_sharing_penalty(irq);
> +       return penalty;
>  }
>
>  static int acpi_irq_balance = -1;      /* 0: static, 1: balance */
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
>                                int *polarity, char **name);
>  int acpi_pci_link_free_irq(acpi_handle handle);

This series fixes one or more network adapters not working in Linux
32-bit x86 guest running inside VirtualBox if I have 4 network
adapters enabled. The following message no longer appears in the
kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
