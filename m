Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:59853 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeC1NPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 09:15:37 -0400
Subject: Re: [PATCH v5 11/12] PCI: designware-ep: Make dw_pcie_ep_reset_bar()
 handle 64-bit BARs properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-12-niklas.cassel@axis.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <71fe27b4-60ca-898e-e41c-5e93f9b44af2@synopsys.com>
Date: Wed, 28 Mar 2018 14:14:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-12-niklas.cassel@axis.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On 28/03/2018 12:50, Niklas Cassel wrote:
> Since a 64-bit BAR consists of a BAR pair, we need to write to both
> BARs in the BAR pair to clear the BAR properly.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
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

Seems good to me. :)

Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
