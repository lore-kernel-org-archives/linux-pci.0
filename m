Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42470 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdHHMpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 08:45:25 -0400
Subject: Re: [PATCHv2 1/6] PCI: designware: add accessors for write permission
 of DBI read-only registers
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-2-git-send-email-Zhiqiang.Hou@nxp.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ea408ca6-ef74-b4e1-1434-52e5ef09a260@synopsys.com>
Date: Tue, 8 Aug 2017 13:45:10 +0100
MIME-Version: 1.0
In-Reply-To: <1501748620-42866-2-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 9:23 AM de 8/3/2017, Zhiqiang Hou escreveu:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The read-only DBI registers can be written over the DBI when set
> the "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> MISC_CONTROL_1_OFF register.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - None
> 
>  drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index b4d2a89..bbdf35b 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -76,6 +76,9 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
> +#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
> +
>  /*
>   * iATU Unroll-specific register definitions
>   * From 4.80 core version the address translation will be made by unroll
> @@ -279,6 +282,28 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
>  	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
>  }
>  
> +static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +	u32 val;
> +
> +	reg = PCIE_MISC_CONTROL_1_OFF;
> +	val = dw_pcie_readl_dbi(pci, reg);
> +	val |= PCIE_DBI_RO_WR_EN;
> +	dw_pcie_writel_dbi(pci, reg, val);
> +}
> +
> +static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +	u32 val;
> +
> +	reg = PCIE_MISC_CONTROL_1_OFF;
> +	val = dw_pcie_readl_dbi(pci, reg);
> +	val &= ~PCIE_DBI_RO_WR_EN;
> +	dw_pcie_writel_dbi(pci, reg, val);
> +}
> +
>  #ifdef CONFIG_PCIE_DW_HOST
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> 

Acked-By: Joao Pinto <jpinto@synopsys.com>
