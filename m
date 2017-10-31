Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:42483 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbdJaFKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 01:10:35 -0400
Subject: Re: [PATCH v2 05/17] PCI: designware-ep: Remove static keyword from
 dw_pcie_ep_reset_bar()
To: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-6-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7ad6dbed-f799-11b3-8d7d-b7d0cad35f4d@ti.com>
Date: Tue, 31 Oct 2017 10:39:30 +0530
MIME-Version: 1.0
In-Reply-To: <20171030124221.20690-6-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 30 October 2017 06:12 PM, Niklas Cassel wrote:
> This way pci-dra7xx.c does not need its own copy of dw_pcie_ep_reset_bar().
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> V2:
> * New patch in this series.
> 
>  drivers/pci/dwc/pci-dra7xx.c         | 9 ---------
>  drivers/pci/dwc/pcie-designware-ep.c | 2 +-
>  drivers/pci/dwc/pcie-designware.h    | 5 +++++
>  3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index d0848006945a..a743545da4d4 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -336,15 +336,6 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> -{
> -	u32 reg;
> -
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> -	dw_pcie_writel_dbi(pci, reg, 0x0);
> -}
> -
>  static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index c291da2a10ba..47134a85a342 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -30,7 +30,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  	pci_epc_linkup(epc);
>  }
>  
> -static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> +void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  {
>  	u32 reg;
>  
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index 5a1da459eda5..37dfad8d003f 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -338,6 +338,7 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> +void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
>  #else
>  static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  {
> @@ -351,5 +352,9 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
> +
> +static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> +{
> +}
>  #endif
>  #endif /* _PCIE_DESIGNWARE_H */
> 
