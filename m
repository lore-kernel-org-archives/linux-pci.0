Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:44850 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdJaGXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 02:23:17 -0400
Subject: Re: [PATCH v2 06/17] PCI: designware-ep: Add generic function for
 raising MSI irq
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-7-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c0ec56ba-1896-c3be-33a9-4650921a433a@ti.com>
Date: Tue, 31 Oct 2017 11:52:13 +0530
MIME-Version: 1.0
In-Reply-To: <20171030124221.20690-7-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 30 October 2017 06:12 PM, Niklas Cassel wrote:
> This function can be used by all DWC based controllers to raise a MSI
> irq. However, certain controllers, like DRA7xx, has a special
> convenience register for raising MSI irqs that doesn't require you to
> explicitly map the MSI address.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> V2:
> * New patch in this series. The other changes in the changelog are against
>   the version that was included in pcie-artpec6.c in V1.
> * raise_msi_irq now uses readw/writew instead of masking.
> * raise_msi_irq now uses fixed offset for MSI cap in raise_msi, since it is
>   always at the same offset for this IP.
> * raise_msi_irq now uses PCI_MSI_FLAGS_64BIT rather than BIT(7).
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-designware.h    |  9 +++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 47134a85a342..92b7ca36bae4 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -282,6 +282,40 @@ static const struct pci_epc_ops epc_ops = {
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
> +	ret = dw_pcie_ep_map_addr(epc, ep->msi_mem_phys, msg_addr, PAGE_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem);
> +
> +	dw_pcie_ep_unmap_addr(epc, ep->msi_mem_phys);
> +
> +	return 0;
> +}
> +
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc = ep->epc;
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index 37dfad8d003f..24edac035160 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -106,6 +106,8 @@
>  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
>  #define MSI_MESSAGE_ADDR_L32		0x54
>  #define MSI_MESSAGE_ADDR_U32		0x58
> +#define MSI_MESSAGE_DATA_32		0x58

Does ADDR_U32 and DATA_32 share the same offset? (in dra7xx MSI_64_EN is
hardwired to 1 so I can't know this for sure.)

Thanks
Kishon
