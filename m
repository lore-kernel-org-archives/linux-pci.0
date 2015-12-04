Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35665 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbbLDA2D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 19:28:03 -0500
Date: Thu, 3 Dec 2015 18:27:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: MSI: Only use the generic MSI layer when domain is
 hierarchical
Message-ID: <20151204002758.GA10479@localhost>
References: <1448288826-19058-1-git-send-email-marc.zyngier@arm.com>
 <PS1PR06MB11808365B312F6C3DAE2DB35F5000@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <PS1PR06MB11808365B312F6C3DAE2DB35F5000@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 30, 2015 at 10:25:34AM +0000, Phil Edworthy wrote:
> Cc'd linux-pci ml
> 
> On 23 November 2015 14:27, Marc Zyngier wrote:
> 
> Since d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct
> device::msi_domain"), we use the MSI domain associated to the PCI device.
> 
> But finding a MSI domain doesn't mean that the domain is implemented
> using the generic MSI domain API, and a number of MSI controllers
> are still using the arch_setup_msi_irq/arch_teardown_msi_irqs.
> 
> In order to avoid a firework on these systems, check that the domain
> we just obtained is hierarchical. If not, don't use the generic MSI
> stuff and stick with the old one. Not pretty, but reliable.
> 
> Another insentive to rework those drivers and phase out this API.
> 
> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> Tested-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, I applied this with Thomas' ack to pci/msi for v4.5.

It looks like d8a1cb757550 appeared in v4.3.  Is this a fix for that
commit?  Does this need to be backported via a stable tag?

> ---
>  drivers/pci/msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 53e4632..7eaa4c8 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -54,7 +54,7 @@ static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	struct irq_domain *domain;
>  
>  	domain = pci_msi_get_domain(dev);
> -	if (domain)
> +	if (domain && irq_domain_is_hierarchy(domain))
>  		return pci_msi_domain_alloc_irqs(domain, dev, nvec, type);
>  
>  	return arch_setup_msi_irqs(dev, nvec, type);
> @@ -65,7 +65,7 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
>  	struct irq_domain *domain;
>  
>  	domain = pci_msi_get_domain(dev);
> -	if (domain)
> +	if (domain && irq_domain_is_hierarchy(domain))
>  		pci_msi_domain_free_irqs(domain, dev);
>  	else
>  		arch_teardown_msi_irqs(dev);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
