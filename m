Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:56405 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUGHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 02:07:13 -0400
Subject: Re: [PATCH v4 4/5] PCI: endpoint: Make pci_epc_set_bar() return the
 BAR width that was set-up
To: Niklas Cassel <niklas.cassel@axis.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Niklas Cassel <niklass@axis.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-5-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <001f10ee-d2cd-a1ae-5524-75a1e0b8c92e@ti.com>
Date: Wed, 21 Mar 2018 11:36:56 +0530
MIME-Version: 1.0
In-Reply-To: <20180308133331.19464-5-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Thursday 08 March 2018 07:03 PM, Niklas Cassel wrote:
> In order to properly handle 64-bit BARs, we need to know what BAR width
> that was actually set-up by specific pci_epc_set_bar() implementations.
> 
> This is done so that we can know if we need to skip a BAR,
> since a 64-bit BAR consists of a BAR pair.
> 
> It is important to know the BAR width that was actually set-up,
> since some drivers, like the Cadence EP controller, does not
> simply look at PCI_BASE_ADDRESS_MEM_TYPE_64, as it configures
> all BARs larger than 2G as 64-bit.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c         | 2 +-
>  drivers/pci/dwc/pcie-designware-ep.c          | 4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c | 7 ++++++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3c3a97743453..0e4cc4cca56d 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -135,7 +135,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, enum pci_barno bar,
>  		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
>  	cdns_pcie_writel(pcie, reg, cfg);
>  
> -	return 0;
> +	return is_64bits ? 1 : 0;
>  }
>  
>  static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index b20b2651caf9..f3c19f8ff8e5 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -139,7 +139,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  		as_type = DW_PCIE_AS_IO;
>  
>  	ret = dw_pcie_ep_inbound_atu(ep, bar, bar_phys, as_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
> @@ -154,7 +154,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
>  	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> -	return 0;
> +	return (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 1 : 0;
>  }
>  
>  static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c70433b11a7..09878e011284 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -379,12 +379,17 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  		ret = pci_epc_set_bar(epc, epf->func_no, bar,
>  				      epf_bar->phys_addr,
>  				      epf_bar->size, bar_flags[bar]);
> -		if (ret) {
> +		if (ret < 0) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
>  			dev_err(dev, "failed to set BAR%d\n", bar);
>  			if (bar == test_reg_bar)
>  				return ret;
>  		}
> +		/*
> +		 * pci_epc_set_bar() returns 1 if a 64-bit BAR was set-up,
> +		 * or 0 if a 32-bit BAR was set-up.
> +		 */
> +		bar += ret;

I'd prefer having a new argument bool *is_64bit in set_bar rather than having
to work with return value of set_bar.

Even otherwise, can't we set PCI_BASE_ADDRESS_MEM_TYPE_64 based on size in
pci-epf-test itself?

Thanks
Kishon
