Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:43982 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755931AbdLTTTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 14:19:01 -0500
Subject: Re: [PATCH v6 03/18] PCI: designware-ep: Read-only registers need
 DBI_RO_WR_EN to be writable
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171219232940.659-4-niklas.cassel@axis.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <dd13b24a-fb66-6c76-a61a-cacab6fbbd50@synopsys.com>
Date: Wed, 20 Dec 2017 19:18:56 +0000
MIME-Version: 1.0
In-Reply-To: <20171219232940.659-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi,

Às 11:29 PM de 12/19/2017, Niklas Cassel escreveu:
> Certain registers that pcie-designware-ep tries to write to are read-only
> registers. However, these registers can become read/write if we first
> enable the DBI_RO_WR_EN bit. Set/unset the DBI_RO_WR_EN bit before/after
> writing these registers.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index c92ab87fd660..3fb34be99715 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -35,8 +35,10 @@ static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  	u32 reg;
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writel_dbi2(pci, reg, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
>  static int dw_pcie_ep_write_header(struct pci_epc *epc,
> @@ -45,6 +47,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
>  	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, hdr->deviceid);
>  	dw_pcie_writeb_dbi(pci, PCI_REVISION_ID, hdr->revid);
> @@ -58,6 +61,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc,
>  	dw_pcie_writew_dbi(pci, PCI_SUBSYSTEM_ID, hdr->subsys_id);
>  	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
>  			   hdr->interrupt_pin);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
>  }
> @@ -142,8 +146,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
>  	if (ret)
>  		return ret;
>  
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writel_dbi2(pci, reg, size - 1);
>  	dw_pcie_writel_dbi(pci, reg, flags);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
>  }
> @@ -223,7 +229,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
>  	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
>  	val &= ~MSI_CAP_MMC_MASK;
>  	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
>  }
> 

Acked-by: Joao Pinto <jpinto@synopsys.com>
