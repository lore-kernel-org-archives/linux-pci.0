Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:43671 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeC2KDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 06:03:31 -0400
Subject: Re: [PATCH v5 11/12] PCI: designware-ep: Make dw_pcie_ep_reset_bar()
 handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-12-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <db3f2460-706e-0d93-2038-5abeef23aa85@ti.com>
Date: Thu, 29 Mar 2018 15:33:16 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-12-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, we need to write to both
> BARs in the BAR pair to clear the BAR properly.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index cc4d8381c1dc..4d304e3ccf24 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -28,6 +28,10 @@ static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writel_dbi2(pci, reg, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> +		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> +	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> 
