Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 20 Oct 2016 20:39:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
Message-ID: <20161021013930.GB31044@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 19, 2016 at 06:21:02PM -0400, Sinan Kaya wrote:
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

I don't mind this patch, but the changelog doesn't tell me what's
broken and why we need this fix.  Apparently acpi_irq_get_penalty()
doesn't work before ACPI is initialized, but I don't see *why* it
wouldn't work.

However, I see one bug it *does* fix: we do not store the SCI penalty
in the acpi_isa_irq_penalty[] table because acpi_isa_irq_penalty[]
only holds ISA IRQ penalties, and there's no guarantee that the SCI is
an ISA IRQ.  But prior to this patch, we added in the SCI penalty to
the acpi_isa_irq_penalty[] entry when the SCI was an ISA IRQ, which
makes acpi_irq_get_penalty() return the wrong thing.  Consider:

  Initially     acpi_isa_irq_penalty[9] = 0.
  Assume        sci_interrupt = 9.
  Then          acpi_irq_get_penalty(9) returns X.
  If we call    acpi_penalize_isa_irq(9, 1),
  it sets       acpi_isa_irq_penalty[9] = X,
  and now       acpi_irq_get_penalty(9) returns X + X.

I'd propose a changelog like this:

  We do not want to store the SCI penalty in the acpi_isa_irq_penalty[]
  table because acpi_isa_irq_penalty[] only holds ISA IRQ penalties and
  there's no guarantee that the SCI is an ISA IRQ.  We add in the SCI
  penalty as a special case in acpi_irq_get_penalty().

  But if we called acpi_penalize_isa_irq() or acpi_irq_penalty_update()
  for an SCI that happened to be an ISA IRQ, they stored the SCI
  penalty (part of the acpi_irq_get_penalty() return value) in
  acpi_isa_irq_penalty[].  Subsequent calls to acpi_irq_get_penalty()
  returned a penalty that included *two* SCI penalties.

If this actually fixes a worse problem related to ACPI initialization,
of course you should detail that.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
>  			continue;
>  
>  		if (used)
> -			new_penalty = acpi_irq_get_penalty(irq) +
> +			new_penalty = acpi_isa_irq_penalty[irq] +
>  					PIRQ_PENALTY_ISA_USED;
>  		else
>  			new_penalty = 0;
> @@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
>  	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> -		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +		acpi_isa_irq_penalty[irq] = acpi_isa_irq_penalty[irq] +
>  		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
