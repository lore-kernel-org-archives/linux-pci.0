Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34336 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbcF2NQX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 09:16:23 -0400
MIME-Version: 1.0
In-Reply-To: <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org> <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jun 2016 15:16:11 +0200
Message-ID: <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Jon Masters <jcm@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The omitted parenthesis prevents the addition operation when
> acpi_penalize_isa_irq function is called.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Well, this is a rather obvious one, so I'm wondering why it is the
last one in the series?

> ---
>  drivers/acpi/pci_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 8c08971..c983bf7 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -872,7 +872,7 @@ void acpi_penalize_isa_irq(int irq, int active)
>  {
>         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
>                 acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> -                       active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
> +                 (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>
>  bool acpi_isa_irq_available(int irq)
> --

Thanks,
Rafael
