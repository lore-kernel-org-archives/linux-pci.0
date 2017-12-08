Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753256AbdLHLER (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 06:04:17 -0500
Date: Fri, 8 Dec 2017 11:04:52 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Gustavo.Pimentel@synopsys.com,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Re-activate task to add MSI-X to pcie-designware
Message-ID: <20171208110452.GD26816@red-moon>
References: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
 <1512661374.11506.19.camel@pengutronix.de>
 <9cde45e7-78cd-9185-5840-495b27340eab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9cde45e7-78cd-9185-5840-495b27340eab@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 07, 2017 at 03:53:39PM +0000, Marc Zyngier wrote:
> [+ Lorenzo]
> 
> On 07/12/17 15:42, Lucas Stach wrote:
> > Hi Joao,
> > 
> > Am Donnerstag, den 07.12.2017, 15:14 +0000 schrieb Joao Pinto:
> >> Hello to all,
> >>
> >> I am sending this e-mail to request your opinion about the tasks needed to add
> >> support for MSI-X for pcie-designware based solutions.
> >>
> >> A few months ago I submited a patch-set that added support for MSI-X:
> >>
> >> [v2,9/9] pci: remove limitation of the number of the available IRQs
> >> https://patchwork.ozlabs.org/patch/771320/
> >> [v2,8/9] pci: removing old irq api from pcie-designware
> >> https://patchwork.ozlabs.org/patch/771360/
> >> [v2,7/9] pci: keystone SoC driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771361/
> >> [v2,6/9] pci: qcom SoC driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771362/
> >> [v2,5/9] pci: generic PCIe DW driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771365/
> >> [v2,4/9] pci: artpec6 SoC driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771364/
> >> [v2,3/9] pci: imx6 SoC driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771363/
> >> [v2,2/9] pci: exynos SoC driver adapted to new irq API
> >> https://patchwork.ozlabs.org/patch/771359/
> >> [v2,1/9] pci: adding new irq api to pci-designware
> >> https://patchwork.ozlabs.org/patch/771366/
> >>
> >> The patch-set was globally accepted, but it broke the MSI mechanism for
> >> Keystone, due to its specificity.
> >>
> >> We are now going to resume this task and we would like to have your feedback
> >> about our plan:
> >>
> >> Task 1: Help TI to create a keystone_msi driver to isolate its custom msi mechanism
> >> Task 2: Port the existing patches to the new kernel version (except the keystone
> >> one)
> >>
> >> If TI can do the keystone_msi implementation it would be easier. If it's not
> >> possible, we volunteer to do it, but we will need testing & debug assistance.
> >>
> >> I appreciate very much your attention and feedback.
> >>
> >> Thanks and have a good day,
> >> Joao Pinto
> >>
> > 
> > The trivial implementation I have for MSI-X support is below. This has
> > been tested on i.MX6, but I guess it also works on Keystone as it
> > doesn't change the way the IRQs are set up.
> > 
> > -------------------------------->8-------------------------------------
> > 
> > From 0d722f67e3995cf26795f6a5d66cca8e4997ed64 Mon Sep 17 00:00:00 2001
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Date: Thu, 7 Dec 2017 12:54:04 +0100
> > Subject: [PATCH] PCI: dwc: implement MSI-X support
> > 
> > The DWC MSI controller does not support different MSI-X target addresses
> > and does not allow to route individual IRQs to different CPUs. Aside from
> > those shortcomings it is able to support MSI-X just fine.
> > 
> > Some devices like the Intel i210 network controller depend on MSI-X to
> > be available to enable all hardware features, so even a feature limited
> > implementation of MSI-X on the host side is useful.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 81e2157a7cfb..a85101dd15c9 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -206,9 +206,6 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> >  	int irq, pos;
> >  	struct pcie_port *pp = pdev->bus->sysdata;
> >  
> > -	if (desc->msi_attrib.is_msix)
> > -		return -EINVAL;
> > -
> >  	irq = assign_irq(1, desc, &pos);
> >  	if (irq < 0)
> >  		return irq;
> > @@ -226,9 +223,19 @@ static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> >  	struct msi_desc *desc;
> >  	struct pcie_port *pp = pdev->bus->sysdata;
> >  
> > -	/* MSI-X interrupts are not supported */
> > -	if (type == PCI_CAP_ID_MSIX)
> > -		return -EINVAL;
> > +	if (type == PCI_CAP_ID_MSIX) {
> > +		if ((MAX_MSI_IRQS - bitmap_weight(pp->msi_irq_in_use,
> > +						  MAX_MSI_IRQS)) < nvec)
> > +			return -ENOSPC;
> > +
> > +		for_each_pci_msi_entry(desc, pdev) {
> > +			int ret = dw_msi_setup_irq(chip, pdev, desc);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		return 0;
> > +	}
> >  
> >  	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> >  	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> > -- 
> > 2.11.0
> > 
> 
> Hi Lucas,
> 
> This is exactly what we're trying hard to get rid off. The whole
> msi_setup_irqs and msi_controller stuff gets in the way of proper
> abstraction, and litters the PCI subsystem with legacy stuff.
> 
> I'd rather see Joao's patches making it into mainline instead of keeping
> this DWC madness on life support.

+1

Thanks,
Lorenzo
