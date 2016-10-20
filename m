Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org> <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Oct 2016 23:39:10 +0200
Message-ID: <CAJZ5v0jm-n8hbS_GFUY4EVKHiRaNPrkNcWDY+6c3SRxWhy4VAg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
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
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 12:21 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The penalty determination of ISA IRQ goes through 4 paths.
> 1. assign PCI_USING during power up via acpi_irq_penalty_init.
> 2. update the penalty with acpi_penalize_isa_irq function based on the
> active parameter.
> 3. kernel command line penalty update via acpi_irq_penalty_update function.
> 4. increment the penalty as USING right after the IRQ is assign to PCI.
>
> acpi_penalize_isa_irq and acpi_irq_penalty_update functions get called
> before the ACPI subsystem is started.
>
> These API need to bypass the acpi_irq_get_penalty function.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index c983bf7..4f37938 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -849,7 +849,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>                         continue;
>
>                 if (used)
> -                       new_penalty = acpi_irq_get_penalty(irq) +
> +                       new_penalty = acpi_isa_irq_penalty[irq] +
>                                         PIRQ_PENALTY_ISA_USED;
>                 else
>                         new_penalty = 0;
> @@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
>         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> -               acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +               acpi_isa_irq_penalty[irq] = acpi_isa_irq_penalty[irq] +

This looks slightly odd.  What about

+               acpi_isa_irq_penalty[irq] +=

>                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>

Thanks,
Rafael
