Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:33466 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdJaGBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 02:01:45 -0400
Subject: Re: [PATCH v2 04/17] PCI: designware-ep: Pre-allocate memory for MSI
 in dw_pcie_ep_init
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-5-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9d4c17b7-94ec-fd79-4bd8-8165019f04ce@ti.com>
Date: Tue, 31 Oct 2017 11:31:34 +0530
MIME-Version: 1.0
In-Reply-To: <20171030124221.20690-5-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Monday 30 October 2017 06:12 PM, Niklas Cassel wrote:
> Certain SoCs need to map the MSI address in raise_irq.
> To map an address, you first need to call pci_epc_mem_alloc_addr,
> however, pci_epc_mem_alloc_addr calls ioremap (which can sleep).
> 
> Since raise_irq is only called from atomic context, we can't call
> pci_epc_mem_alloc_addr from raise_irq, instead we pre-allocate
> a page in dw_pcie_ep_init, so this page can later be used to map/unmap
> the MSI address in raise_irq.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> V2:
> * No change.
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
>  drivers/pci/dwc/pcie-designware.h    | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 3fb34be99715..c291da2a10ba 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -286,6 +286,8 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc = ep->epc;
>  
> +	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem, PAGE_SIZE);
> +
>  	pci_epc_mem_exit(epc);
>  }
>  
> @@ -341,6 +343,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return ret;
>  	}
>  
> +	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, PAGE_SIZE);

ep->page_size instead of PAGE_SIZE?

Thanks
Kishon
