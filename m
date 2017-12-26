Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:9306 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZMvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 07:51:08 -0500
Subject: Re: [PATCH v6 06/18] PCI: designware-ep: Add generic function for
 raising MSI irq
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171219232940.659-7-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5fc44bf0-9d0e-e905-32fb-449d9ed1b01a@ti.com>
Date: Tue, 26 Dec 2017 18:20:54 +0530
MIME-Version: 1.0
In-Reply-To: <20171219232940.659-7-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Wednesday 20 December 2017 04:59 AM, Niklas Cassel wrote:
> Add a generic function for raising MSI irqs that can be used by all
> DWC based controllers.
> 
> Note that certain controllers, like DRA7xx, have a special convenience
> register for raising MSI irqs that doesn't require you to explicitly map
> the MSI address. Therefore, it is likely that certain drivers will
> not use this generic function, even if they can.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-designware.h    |  9 +++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 700ed2f4becf..c5aa1cac5041 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -282,6 +282,41 @@ static const struct pci_epc_ops epc_ops = {
>  	.stop			= dw_pcie_ep_stop,
>  };
>  
> +int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
> +			     u8 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct pci_epc *epc = ep->epc;
> +	u16 msg_ctrl, msg_data;
> +	u32 msg_addr_lower, msg_addr_upper;
> +	u64 msg_addr;
> +	bool has_upper;
> +	int ret;
> +
> +	/* Raise MSI per the PCI Local Bus Specification Revision 3.0, 6.8.1. */
> +	msg_ctrl = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> +	has_upper = !!(msg_ctrl & PCI_MSI_FLAGS_64BIT);
> +	msg_addr_lower = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> +	if (has_upper) {
> +		msg_addr_upper = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
> +		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_64);
> +	} else {
> +		msg_addr_upper = 0;
> +		msg_data = dw_pcie_readw_dbi(pci, MSI_MESSAGE_DATA_32);
> +	}
> +	msg_addr = ((u64) msg_addr_upper) << 32 | msg_addr_lower;
> +	ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr,
> +				  epc->mem->page_size);
> +	if (ret)
> +		return ret;
> +
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem);

Shouldn't this be msg_data + (interrupt_num - 1)?

Thanks
Kishon
