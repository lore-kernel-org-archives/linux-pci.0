Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52236 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeIDJJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 05:09:17 -0400
Subject: Re: [PATCH v2 5/5] PCI: cadence: Add MSI-X capability to EP driver
To: Alan Douglas <adouglas@cadence.com>, <bhelgaas@google.com>
CC: <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <gustavo.pimentel@synopsys.com>, <cyrille.pitchen@bootlin.com>,
        <stelford@cadence.com>
References: <1534340948-24093-1-git-send-email-adouglas@cadence.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <daa340ff-1860-dec4-a814-a0ba63227748@ti.com>
Date: Tue, 4 Sep 2018 10:15:38 +0530
MIME-Version: 1.0
In-Reply-To: <1534340948-24093-1-git-send-email-adouglas@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wednesday 15 August 2018 07:19 PM, Alan Douglas wrote:
> Add set_msix and get_msix functions to driver, and handle
> PCI_EPC_IRQ_MSIX request in raise_irq.  BAR5 is used for
> the MSI-X vectors.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>   drivers/pci/controller/pcie-cadence-ep.c | 107 ++++++++++++++++++++++++++++++-
>   drivers/pci/controller/pcie-cadence.h    |   1 +
>   2 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index 1248d75..259b9a6 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -16,6 +16,7 @@
>   #define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
>   #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
>   #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> +#define CDNS_PCIE_EP_MSIX_BAR			0x5
>   
>   /**
>    * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
> @@ -255,6 +256,43 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>   	return mme;
>   }
>   
> +static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +	u32 val, reg;
> +
> +	reg = cap + PCI_MSIX_FLAGS;
> +	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
> +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	val &= PCI_MSIX_FLAGS_QSIZE;
> +
> +	return val;
> +}
> +
> +static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u16 interrupts)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +	u32 val, reg;
> +
> +	reg = cap + PCI_MSIX_FLAGS;
> +	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
> +	val &= ~PCI_MSIX_FLAGS_QSIZE;
> +	val |= interrupts;
> +	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
> +	/* Set MSIX BAR and offset */
> +	cdns_pcie_ep_fn_writel(pcie, fn, 0xb4, CDNS_PCIE_EP_MSIX_BAR);

Please add a macro for MSIX table offset.
I think it relies on endpoint function driver to invoke set_bar for 
BAR5? It's possible a function driver can invoke set_msix without set_bar.

> +	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
> +	cdns_pcie_ep_fn_writel(pcie, fn, 0xb8, 0x10000 | CDNS_PCIE_EP_MSIX_BAR);

Here too add a macro for PBA.
How did you get the 0x10000?

Thanks
Kishon
