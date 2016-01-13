Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40041 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbcAMLYS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 06:24:18 -0500
Date: Wed, 13 Jan 2016 11:25:51 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Matthew Minter <matt@masarand.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com
Subject: Re: [PATCH V4 28/29] of/pci: Fix comment for pci_fixup_irqs changing
 to pci_assign_irq
Message-ID: <20160113112551.GA13282@red-moon>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
 <1445576642-29624-29-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445576642-29624-29-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 23, 2015 at 06:04:01AM +0100, Matthew Minter wrote:
> Signed-off-by: Matthew Minter <matt@masarand.com>
> ---
>  drivers/of/of_pci_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 2306313..a742447 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_pci);
>   * @pin: PCI irq pin number; passed when used as map_irq callback. Unused
>   *
>   * @slot and @pin are unused, but included in the function so that this
> - * function can be used directly as the map_irq callback to pci_fixup_irqs().
> + * function can be used directly as the map_irq callback to pci_assign_irq().

No,

>   */
>  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
				^^^^^

it can't without getting compile warnings:

drivers/pci/host/pci-host-generic.c: In function 'gen_pci_probe':
drivers/pci/host/pci-host-generic.c:265:18: warning: assignment from
incompatible pointer type [-Wincompatible-pointer-types]
  bridge->map_irq = of_irq_parse_and_map_pci;

You did not add the const qualifier in the bridge *map_irq prototype
because the x86 implementation has to modify the dev passed to it,
question is if the x86 implementation may be made to return the irq
instead of modifying the dev directly, which is IMHO the expected
behaviour (I know there is x86 legacy code to deal with, I will have a
look to see if we can refactor that code).

of_irq_parse_and_map_pci() is not supposed to change the dev passed to
it so I think we should keep it as is.

Lorenzo
