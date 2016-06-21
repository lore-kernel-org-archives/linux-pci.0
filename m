Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jun 2016 14:47:15 +0200
From: Wim Osterholt <wim@djo.tudelft.nl>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	perex@perex.cz, linux-pci@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Message-ID: <20160621124715.GB3528@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan>
 <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57686D67.8010201@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Can you try the following and see if it makes any difference?
> 
> 
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -500,7 +500,7 @@ static int acpi_irq_get_penalty(int irq)
>         int penalty = 0;
> 
>         if (irq < ACPI_MAX_ISA_IRQS)
> -               penalty += acpi_isa_irq_penalty[irq];
> +               return acpi_isa_irq_penalty[irq];
> 
>         /*
>         * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
> @@ -586,6 +586,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>                             acpi_device_bid(link->device));
>                 return -ENODEV;
>         } else {
> +               if (irq < ACPI_MAX_ISA_IRQS)
> +                       acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +                                                       PIRQ_PENALTY_PCI_USING;
> +
> 
> 
> 
> > Bjorn


I tried this on kernel 4.7.0-rc4, but that didn't help. It still tried to
grab irq7.


Regards, Wim.


----- wim@djo.tudelft.nl -----
