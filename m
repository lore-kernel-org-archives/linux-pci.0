Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16387 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754464AbeEaK43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 06:56:29 -0400
Subject: Re: [PATCH v2 5/7] PCI: dwc: Add legacy interrupt callback handler
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <c94a66476c391f8bdc781384e6d096453c2c885b.1526576613.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <820a245a-77e9-b231-24df-7e7df7ea0c32@ti.com>
Date: Thu, 31 May 2018 16:26:15 +0530
MIME-Version: 1.0
In-Reply-To: <c94a66476c391f8bdc781384e6d096453c2c885b.1526576613.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
> Add a legacy interrupt callback handler. Currently DesignWare IP don't
> allow trigger legacy interrupts.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v1->v2:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-ep.c   | 10 ++++++++++
>  drivers/pci/dwc/pcie-designware-plat.c |  3 +--
>  drivers/pci/dwc/pcie-designware.h      |  6 ++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index a4baa0d..9822127 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -370,6 +370,16 @@ static const struct pci_epc_ops epc_ops = {
>  	.stop			= dw_pcie_ep_stop,
>  };
>  
> +int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct device *dev = pci->dev;
> +
> +	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +
> +	return -EINVAL;
> +}
> +
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
>  {
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index 654dcb5..90a8c95 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -84,8 +84,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	switch (type) {
>  	case PCI_EPC_IRQ_LEGACY:
> -		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
> -		return -EINVAL;
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>  	case PCI_EPC_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	case PCI_EPC_IRQ_MSIX:
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index a0ab12f..69e6e17 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -350,6 +350,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> +int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -369,6 +370,11 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
>  
> +static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	return 0;
> +}
> +
>  static inline int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  					   u8 interrupt_num)
>  {
> 
