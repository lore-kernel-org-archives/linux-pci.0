Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50645 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeAWRyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 12:54:03 -0500
Date: Tue, 23 Jan 2018 18:53:58 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, jespern@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com
Subject: Re: [PATCH v5 1/9] PCI: dwc: Add IRQ chained API support
Message-ID: <20180123175358.GC7813@axis.com>
References: <cover.1516701516.git.gustavo.pimentel@synopsys.com>
 <d50ec3ee207fe51f82917f13adc7f2010e9345dc.1516701516.git.gustavo.pimentel@synopsys.com>
 <20180123145431.GB7813@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123145431.GB7813@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 03:54:31PM +0100, Niklas Cassel wrote:
> Hello Gustavo
> 
> On Tue, Jan 23, 2018 at 12:25:24PM +0000, Gustavo Pimentel wrote:
> > Adds a IRQ chained API to pcie-designware, that aims to replace the current
> > IRQ domain hierarchy API implemented.
> > 
> > Although the IRQ domain hierarchy API is still available, pcie-designware
> > will use now the IRQ chained API.
> > 
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> > Change v1->v2:
> > - num_vectors is now not configurable by the Device Tree. Now it is 32 by
> > default and can be overridden by any specific SoC driver.
> > Change v2->v3:
> > - Nothing changed, just to follow the patch set version.
> > Change v3->v4:
> > - Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
> > v3-0007 patch file to here.
> > - Undo the change of the function signature to be more coherent with the
> > host mode specific functions (Thanks Kishon).
> > - Refactor the added functions in order to used host_data so that getting
> > pp again back from pci could be avoided. (Thanks Kishon)
> > - Changed summary line to match the drivers/PCI convention and changelog to
> > maintain the consistency (thanks Bjorn).
> > Change v4->v5:
> > - Implemented Kishon MSI multiple messages fix (thanks Kishon).
> > 
> >  drivers/pci/dwc/pcie-designware-host.c | 296 +++++++++++++++++++++++++++++----
> >  drivers/pci/dwc/pcie-designware.h      |  18 ++
> >  2 files changed, 286 insertions(+), 28 deletions(-)
> > 
> 
> 
> > +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	u64 msi_target;
> > +
> > +	if (pp->ops->get_msi_addr)
> > +		msi_target = pp->ops->get_msi_addr(pp);
> > +	else
> > +		msi_target = virt_to_phys((void *)pp->msi_data);
> 
> The assignment in the else clause should be:
>     msi_target = (u64)pp->msi_data;
> 

Kishon's pci_epf_test works, and also an Intel e1000e PCIe card with MSI-X
(added some debug prints in the e1000e driver to verify that MSI-X is
actually used). The intel e1000e network card appears to function properly
with different ping sizes.

Nice!

With the one liner fix above:
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
