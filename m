Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <564EECA9.9070400@arm.com>
Date: Fri, 20 Nov 2015 09:49:29 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>
CC: Thierry Reding <treding@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>	<PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>	<20151109161115.GA13870@ulmo.nvidia.com>	<PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>	<20151110155232.GA25368@ulmo.nvidia.com>	<20151111163802.3a96080c@arm.com>	<PS1PR06MB11806B2B906CABB553B94442F5120@PS1PR06MB1180.apcprd06.prod.outlook.com> <20151112203100.2e91da2a@arm.com> <PS1PR06MB11800B547C8957B226077B83F5110@PS1PR06MB1180.apcprd06.prod.outlook.com> <564A2101.90600@arm.com> <PS1PR06MB11804FF05BBF30F2CA2083FCF51C0@PS1PR06MB1180.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB11804FF05BBF30F2CA2083FCF51C0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18/11/15 18:01, Phil Edworthy wrote:
> Hi Marc,
> 
> On 16 November 2015 18:31, Marc Zyngier wrote:
>> On 13/11/15 09:36, Phil Edworthy wrote:
> <snip>
>>> Since the stack trace doesn't help that much I added some tracing:
>>> pci_msi_setup_msi_irqs()
>>>   calls pci_msi_get_domain()
>>>     calls dev_get_msi_domain(), gets a non-NULL domain.
>>> pci_msi_setup_msi_irqs()
>>>   calls pci_msi_domain_alloc_irqs()
>>>     calls msi_domain_alloc_irqs()
>>> msi_domain_alloc_irqs:273: ops=ffffffc03193a810
>>> msi_domain_alloc_irqs:274: ops->msi_check=ffffffc031161418
>>> systemd-udevd[1311]: undefined instruction: pc=ffffffc03116141c
>>> That looks to me as though msi_check is off pointing to the weeds.
>>
>> So the next step is to find out who initializes msi_check. Assuming
>> someone does...
> Nothing initializes msi_check... 
> 
>  
>>> By passing a NULL domain into irq_domain_add_linear() you get:
>>> pci_msi_setup_msi_irqs()
>>>   calls pci_msi_get_domain()
>>>     calls dev_get_msi_domain(), gets a NULL domain.
>>>     calls arch_setup_msi_irq()
>>> All ok then.
>>
>> Yes, because you're sidestepping the issue. Any chance you could dig a
>> bit deeper? I'd really like to nail this one down (before we convert
>> your PCI driver to the right API... ;-).
> The problem appears to be that when the pci host driver enables msi
> it calls the following:
> 	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
> 					    &msi_domain_ops, &msi->chip);
> The last arg is documented as:
> * @host_data: Controller private data pointer 
> In _irq_domain_add() this ptr is stored in struct irq_domain's host_data.
> 
> However, msi_domain_alloc_irqs() expects host_data to be a ptr to a
> struct msi_domain_info.
> 
> It seems that a number of other pci host drivers do the same, so I am
> surprised that no one else has seen this.

Can you please give this hack a go and let me know if that helps?

Thanks,

	M.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 53e4632..7eaa4c8 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -54,7 +54,7 @@ static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	struct irq_domain *domain;
 
 	domain = pci_msi_get_domain(dev);
-	if (domain)
+	if (domain && irq_domain_is_hierarchy(domain))
 		return pci_msi_domain_alloc_irqs(domain, dev, nvec, type);
 
 	return arch_setup_msi_irqs(dev, nvec, type);
@@ -65,7 +65,7 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 	struct irq_domain *domain;
 
 	domain = pci_msi_get_domain(dev);
-	if (domain)
+	if (domain && irq_domain_is_hierarchy(domain))
 		pci_msi_domain_free_irqs(domain, dev);
 	else
 		arch_teardown_msi_irqs(dev);

-- 
Jazz is not dead. It just smells funny...
