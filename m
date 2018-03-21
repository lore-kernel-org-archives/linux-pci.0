Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:25571 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCUFyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 01:54:36 -0400
Subject: Re: [PATCH v4 3/5] PCI: designware-ep: Make dw_pcie_ep_reset_bar()
 handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-4-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1ba89717-2eb7-c6af-632c-6ed8483002cb@ti.com>
Date: Wed, 21 Mar 2018 11:24:25 +0530
MIME-Version: 1.0
In-Reply-To: <20180308133331.19464-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Thursday 08 March 2018 07:03 PM, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, we need to write to both
> BARs in the BAR pair to clear the BAR properly.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 946bbdf53c4d..b20b2651caf9 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -22,11 +22,18 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  {
>  	u32 reg;
> +	u32 val;
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	val = dw_pcie_readl_dbi(pci, reg);
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writel_dbi2(pci, reg, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
> +	if (!(val & PCI_BASE_ADDRESS_SPACE_IO) &&
> +	    (val & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> +		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> +		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> +	}

same comment as previous patch apply here too.

Thanks
Kishon
