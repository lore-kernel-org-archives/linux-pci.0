Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751520AbdLSLiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 06:38:14 -0500
Date: Tue, 19 Dec 2017 11:38:56 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH v2] PCI: designware-ep: Fix ->get_msi() to check MSI_EN
 bit
Message-ID: <20171219113856.GA19911@red-moon>
References: <20171219095541.18838-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219095541.18838-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 03:25:41PM +0530, Kishon Vijay Abraham I wrote:
> ->get_msi() now checks MSI_EN bit in the MSI CAPABILITY register to
> find whether the host supports MSI instead of using the
> MSI ADDRESS in the MSI CAPABILITY register.
> 
> This fixes the issue with the following sequence
>   'modprobe pci_endpoint_test' enables MSI
>   'rmmod pci_endpoint_test' disables MSI but MSI address (in EP's
> 	capability register) has a valid value
>   'modprobe pci_endpoint_test no_msi=1' - Since MSI address (in EP's
> 	capability register) has a valid value (set during the previous
> 	insertion of the module), EP thinks host supports MSI.
> 
> Fixes: f8aed6ec624fb436 ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> changes from v1:
> Added a Fixes tag and mentioned MSI address to be set in EP's capability
> register in the commit log.
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 12 +++---------
>  drivers/pci/dwc/pcie-designware.h    |  1 +
>  2 files changed, 4 insertions(+), 9 deletions(-)

Applied to pci/endpoint for v4.16.

Thanks,
Lorenzo

> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index d53d5f168363..7c621877a939 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -197,20 +197,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
>  static int dw_pcie_ep_get_msi(struct pci_epc *epc)
>  {
>  	int val;
> -	u32 lower_addr;
> -	u32 upper_addr;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	val = dw_pcie_readb_dbi(pci, MSI_MESSAGE_CONTROL);
> -	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
> -
> -	lower_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
> -	upper_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
> -
> -	if (!(lower_addr || upper_addr))
> +	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> +	if (!(val & MSI_CAP_MSI_EN_MASK))
>  		return -EINVAL;
>  
> +	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
>  	return val;
>  }
>  
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e5d9d77b778e..cb493bcae8b4 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -101,6 +101,7 @@
>  #define MSI_MESSAGE_CONTROL		0x52
>  #define MSI_CAP_MMC_SHIFT		1
>  #define MSI_CAP_MME_SHIFT		4
> +#define MSI_CAP_MSI_EN_MASK		0x1
>  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
>  #define MSI_MESSAGE_ADDR_L32		0x54
>  #define MSI_MESSAGE_ADDR_U32		0x58
> -- 
> 2.11.0
> 
