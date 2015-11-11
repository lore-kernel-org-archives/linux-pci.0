Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Nov 2015 16:38:02 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thierry Reding <treding@nvidia.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
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
Message-ID: <20151111163802.3a96080c@arm.com>
In-Reply-To: <20151110155232.GA25368@ulmo.nvidia.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
	<PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151109161115.GA13870@ulmo.nvidia.com>
	<PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151110155232.GA25368@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Nov 2015 16:52:33 +0100
Thierry Reding <treding@nvidia.com> wrote:

> On Mon, Nov 09, 2015 at 06:01:49PM +0000, Phil Edworthy wrote:
> > Hi Thierry,
> > 
> > On 09 November 2015 17:24, Phil wrote:
> > > On 09 November 2015 16:11, Thierry wrote:
> > > > On Mon, Nov 09, 2015 at 03:20:24PM +0000, Phil Edworthy wrote:
> > > > > cc'ing others (Tegra, Altera, Designware) who may have the same bug
> > > > >
> > > > > On 03 November 2015 09:28, Phil Edworthy wrote:
> > > > > > The OF node passed to irq_domain_add_linear() should be a
> > > > > > pointer to interrupt controller's device tree node, or NULL,
> > > > > > but not the PCI controller's node.
> > > > > >
> > > > > > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > > > > > to call msi_check().
> > > > > >
> > > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > > > ---
> > > > > >  drivers/pci/host/pcie-rcar.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > > > > > index 2377bf0..c6fa562 100644
> > > > > > --- a/drivers/pci/host/pcie-rcar.c
> > > > > > +++ b/drivers/pci/host/pcie-rcar.c
> > > > > > @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie
> > > *pcie)
> > > > > >  	msi->chip.setup_irq = rcar_msi_setup_irq;
> > > > > >  	msi->chip.teardown_irq = rcar_msi_teardown_irq;
> > > > > >
> > > > > > -	msi->domain = irq_domain_add_linear(pcie->dev->of_node,
> > > > > > INT_PCI_MSI_NR,
> > > > > > +	msi->domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> > > > > >  					    &msi_domain_ops, &msi->chip);
> > > > > >  	if (!msi->domain) {
> > > > > >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> > > >
> > > > On Tegra the PCI controller is in fact the interrupt controller for
> > > > MSIs. And looking at the code here it seems like the same would apply to
> > > > RCAR.
> > > Yes you are correct here.
> > > 
> > > > I'm also slightly confused as to why this would cause ->msi_check() to
> > > > fail. The default implementation (msi_domain_ops_check()) doesn't do
> > > > anything.
> > > >
> > > > Also, how is passing in NULL instead of a valid struct device_node *
> > > > going to prevent an oops? Perhaps this is one of those reference count
> > > > imbalance bugs that have recently been showing up?
> > > On arm64 (previously I didn't realise this just affects arm64, not arm),
> > > the changes in commit f075915ac0b11 ("PCI/MSI: Drop domain field from
> > > msi_controller") and d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use
> > > struct device::msi_domain") return an uninitialized msi domain that leads
> > > to the oops. It appears that these changes assume that msi interrupt
> > > controller is separate from the PCI controller.
> > More accurately, when CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled,
> > pci_msi_get_domain() calls dev_get_msi_domain() and at this point
> > dev->msi_domain is uninitialized.
> 
> Marc, any idea what's going on here?

Thanks for putting me in the loop.

No precise idea yet, but the proposed fix definitely looks like the
wrong one. Actually, not passing a node identifier to any domain
constructor is pretty much always a mistake when using DT.

Can someone post a stack trace for this issue so that I can have a
look? I'm currently traveling, so expect a slightly delayed reply...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
