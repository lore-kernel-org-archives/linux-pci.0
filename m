Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:26258 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbeC2KAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 06:00:47 -0400
Subject: Re: [PATCH v5 09/12] PCI: endpoint: Make
 epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklass@axis.com>,
        John Keeping <john@metanate.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-10-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ac3131cb-468d-5143-62a4-68d6e6b47e82@ti.com>
Date: Thu, 29 Mar 2018 15:30:23 +0530
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Make epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar.
> 
> This is needed so that epc->ops->clear_bar() can clear the BAR pair,
> if the BAR is 64-bits wide.
> 
> This also makes it possible for pci_epc_clear_bar() to sanity check
> the flags.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c         |  3 ++-
>  drivers/pci/dwc/pcie-designware-ep.c          | 13 ++++++++++---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  5 ++++-
>  drivers/pci/endpoint/pci-epc-core.c           |  7 ++++---
>  include/linux/pci-epc.h                       |  5 +++--
>  5 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 2905e098678c..3d8283e450a9 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -145,10 +145,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>  }
>  
>  static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> -				   enum pci_barno bar)
> +				   struct pci_epf_bar *epf_bar)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
> +	enum pci_barno bar = epf_bar->barno;
>  	u32 reg, cfg, b, ctrl;
>  
>  	if (bar < BAR_4) {
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 571b90f88d84..cc4d8381c1dc 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -19,7 +19,8 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  	pci_epc_linkup(epc);
>  }
>  
> -void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> +static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
> +				   int flags)

Looks like the 'flags' are not used anywhere here?

Thanks
Kishon
