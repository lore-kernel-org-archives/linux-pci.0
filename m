Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:57917 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeAWOyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 09:54:37 -0500
Date: Tue, 23 Jan 2018 15:54:31 +0100
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
Message-ID: <20180123145431.GB7813@axis.com>
References: <cover.1516701516.git.gustavo.pimentel@synopsys.com>
 <d50ec3ee207fe51f82917f13adc7f2010e9345dc.1516701516.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d50ec3ee207fe51f82917f13adc7f2010e9345dc.1516701516.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Gustavo

On Tue, Jan 23, 2018 at 12:25:24PM +0000, Gustavo Pimentel wrote:
> Adds a IRQ chained API to pcie-designware, that aims to replace the current
> IRQ domain hierarchy API implemented.
> 
> Although the IRQ domain hierarchy API is still available, pcie-designware
> will use now the IRQ chained API.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - num_vectors is now not configurable by the Device Tree. Now it is 32 by
> default and can be overridden by any specific SoC driver.
> Change v2->v3:
> - Nothing changed, just to follow the patch set version.
> Change v3->v4:
> - Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
> v3-0007 patch file to here.
> - Undo the change of the function signature to be more coherent with the
> host mode specific functions (Thanks Kishon).
> - Refactor the added functions in order to used host_data so that getting
> pp again back from pci could be avoided. (Thanks Kishon)
> - Changed summary line to match the drivers/PCI convention and changelog to
> maintain the consistency (thanks Bjorn).
> Change v4->v5:
> - Implemented Kishon MSI multiple messages fix (thanks Kishon).
> 
>  drivers/pci/dwc/pcie-designware-host.c | 296 +++++++++++++++++++++++++++++----
>  drivers/pci/dwc/pcie-designware.h      |  18 ++
>  2 files changed, 286 insertions(+), 28 deletions(-)
> 


> +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u64 msi_target;
> +
> +	if (pp->ops->get_msi_addr)
> +		msi_target = pp->ops->get_msi_addr(pp);
> +	else
> +		msi_target = virt_to_phys((void *)pp->msi_data);

The assignment in the else clause should be:
    msi_target = (u64)pp->msi_data;

See my commit 111111a72e67 ("PCI: dwc: Use the DMA-API to get the MSI address").

Since this patch set was originally posted in June last year,
you probably missed this when you recently rebased your patch set.

Since you introduce new functions and remove the old functions,
I can see why you didn't get a merge conflict.
It might be worthwile to look at the commits made in the old functions
since the original patch submission (June last year), to see if there
has been any other fixes that needs to be applied in your new functions
as well.

However, good news. With this small change Kishon's pci_epf_test
passes on ARTPEC-6 :)

Will do some testing with a E1000E PCIe card to see if MSI-X also
works, if it works, I will add a Tested-by tag.

Regards,
Niklas

> +
> +	msg->address_lo = lower_32_bits(msi_target);
> +	msg->address_hi = upper_32_bits(msi_target);
> +
> +	if (pp->ops->get_msi_data)
> +		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
> +	else
> +		msg->data = data->hwirq;
> +
> +	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
