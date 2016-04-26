Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40499 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbcDZSig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 14:38:36 -0400
Date: Tue, 26 Apr 2016 13:38:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/4] acpi,pci,irq: reduce static IRQ array size to 16
Message-ID: <20160426183831.GD27803@localhost>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <1460914617-8259-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460914617-8259-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 17, 2016 at 01:36:54PM -0400, Sinan Kaya wrote:
> Now that the supported number of PCI IRQs are no longer capped
> with 256, renaming the static array to support ISA IRQs only
> and removing the MAX_IRQS constant.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index cc0ba16..12ea784 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -438,8 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>   * enabled system.
>   */
>  
> -#define ACPI_MAX_IRQS		256
> -#define ACPI_MAX_ISA_IRQ	16
> +#define ACPI_MAX_ISA_IRQS	16
>  
>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>  #define PIRQ_PENALTY_PCI_USING		(16*16*16)
> @@ -447,7 +446,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
>  #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
>  
> -static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
> +static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] = {
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
> @@ -500,8 +499,8 @@ static int acpi_irq_get_penalty(int irq)
>  {
>  	int penalty = 0;
>  
> -	if (irq < ACPI_MAX_ISA_IRQ)
> -		penalty += acpi_irq_penalty[irq];
> +	if (irq < ACPI_MAX_ISA_IRQS)

Nit: sometimes you use "irq < ACPI_MAX_ISA_IRQS", other times you use
"irq < ARRAY_SIZE(acpi_isa_irq_penalty)".  Seems like they could be
consistent.

> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
> -		acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> +		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
>  			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
>  }
>  
>  bool acpi_isa_irq_available(int irq)
>  {
> -	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
> +	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_isa_irq_penalty) ||
>  		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>  
> -- 
> 1.8.2.1
> 
