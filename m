Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:52971 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdHPLdf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 07:33:35 -0400
Subject: Re: [PATCHv3 6/9] PCI: designware: add accessors for write permission
 of DBI read-only registers
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com, Joao.Pinto@synopsys.com
Cc: minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        niklas.cassel@axis.com, jesper.nilsson@axis.com
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1502859419-33696-7-git-send-email-Zhiqiang.Hou@nxp.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <83b0ad83-bb8f-a899-86b3-7be910eb4b51@mm-sol.com>
Date: Wed, 16 Aug 2017 14:33:31 +0300
MIME-Version: 1.0
In-Reply-To: <1502859419-33696-7-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 08/16/2017 07:56 AM, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The read-only DBI registers can be written over the DBI when set
> the "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> MISC_CONTROL_1_OFF register.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - No change
> 
>  drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index 7366c81..0c5f874 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -76,6 +76,9 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> +#define PCIE_MISC_CONTROL_1_OFF		0x8BC
> +#define PCIE_DBI_RO_WR_EN		(0x1 << 0)

Does those registers exist for dwc version 4.01a?

I managed to test 6/9, 8/9 and 9/9 on qcom platform (apq8064) which has
4.01a version and it doesn't work, i.e. the PCI_CLASS_BRIDGE_PCI is not
returned when read PCI_CLASS_DEVICE offset.

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

regards,
Stan
