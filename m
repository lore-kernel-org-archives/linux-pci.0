Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:58130 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeCUFuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 01:50:17 -0400
Subject: Re: [PATCH v4 2/5] PCI: designware-ep: Make dw_pcie_ep_set_bar()
 handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-3-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e779a6dc-3037-69da-1e92-64c5d8348019@ti.com>
Date: Wed, 21 Mar 2018 11:19:57 +0530
MIME-Version: 1.0
In-Reply-To: <20180308133331.19464-3-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Thursday 08 March 2018 07:03 PM, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, we need to write to both
> BARs in the BAR pair to setup the BAR properly.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 9236b998327f..946bbdf53c4d 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -136,8 +136,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  		return ret;
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writel_dbi2(pci, reg, size - 1);
> -	dw_pcie_writel_dbi(pci, reg, flags);
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +		dw_pcie_writel_dbi(pci, reg, flags);
> +		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi(pci, reg + 4, 0);

I think we should check in pci_epc_set_bar to make sure BAR_5 cannot have
PCI_BASE_ADDRESS_MEM_TYPE_64 flag set as this might lead undesired result.

Thanks
Kishon
