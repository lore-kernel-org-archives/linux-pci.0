Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 25 Sep 2017 18:54:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/3] PCI: designware: only register MSI controller when
 MSI irq line is valid
Message-ID: <20170925235405.GJ15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
 <20170828142307.30061-2-l.stach@pengutronix.de>
 <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Binghui Wang <wangbinghui@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
 patchwork-lst@pengutronix.de, Jesper Nilsson <jesper.nilsson@axis.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 Kukjin Kim <kgene@kernel.org>, Niklas Cassel <niklas.cassel@axis.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, kernel@pengutronix.de,
 Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 11:58:17AM -0500, Bjorn Helgaas wrote:
> [+cc Kishon, Thomas, Niklas, Jesper, Zhou, Gabriele, Xiaowei, Binghui,
> Stanimir, Pratyush, Kukjin, Krzysztof, Richard, Murali, Minghuan, Mingkai,
> Roy]
> 
> Sorry about the unwieldy cc list.  It seems like this affects every
> DesignWare-based driver.
> 
> On Mon, Aug 28, 2017 at 04:23:05PM +0200, Lucas Stach wrote:
> > The MSI part of the controller isn't essential, so the host controller can
> > be registered without the MSI controller being present. This allows the
> > host to work in PCIe legancy interrupt only mode, if the IRQ line for the
> 
> s/legancy/legacy/
> 
> > MSI controller is missing.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index d29c020da082..8494089f088d 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -381,7 +381,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	if (ret)
> >  		pci->num_viewport = 2;
> >  
> > -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
> >  		if (!pp->ops->msi_host_init) {
> >  			pp->irq_domain = irq_domain_add_linear(dev->of_node,
> >  						MAX_MSI_IRQS, &msi_domain_ops,
> > @@ -412,7 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	bridge->ops = &dw_pcie_ops;
> >  	bridge->map_irq = of_irq_parse_and_map_pci;
> >  	bridge->swizzle_irq = pci_common_swizzle;
> > -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
> >  		bridge->msi = &dw_pcie_msi_chip;
> >  		dw_pcie_msi_chip.dev = dev;
> >  	}
> 
> Here are the callers of dw_pcie_host_init():
> 
>   armada8k_add_pcie_port
>   artpec6_add_pcie_port       # sets pp->msi_irq
>   dra7xx_add_pcie_port
>   dw_plat_add_pcie_port       # sets pp->msi_irq
>   exynos_add_pcie_port        # sets pp->msi_irq
>   hisi_add_pcie_port
>   imx6_add_pcie_port          # sets pp->msi_irq
>   kirin_add_pcie_port
>   ks_dw_pcie_host_init        # sets pp->ops->msi_host_init
>   ls_add_pcie_port            # sets pp->ops->msi_host_init
>   qcom_pcie_probe             # sets pp->msi_irq
>   spear13xx_add_pcie_port
> 
> For the drivers that set pp->msi_irq (artpec6, dw_plat, exynos, imx6,
> qcom), it seems like you'd want a similar follow-up change for all of
> them to make the MSI IRQ optional, but you only changed imx6.  What
> about the others?
> 
> For the drivers that don't set pp->msi_irq and don't set
> pp->ops->msi_host_init (armada8k, dra7xx, hisi, kirin, spear13xx),
> this patch means they no longer set up pp->irq_domain.  Do you intend
> that?

Ping, I'm looking for a v2 that addresses this.  No hurry, just
making sure you're not waiting on me.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
