Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:42382 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdGFJoO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 05:44:14 -0400
Subject: Re: [PATCH 1/3] PCI: designware: add accessors for write permission
 of DBI read-only registers
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <Joao.Pinto@synopsys.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
CC: <bhelgaas@google.com>, <jingoohan1@gmail.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <a4510ddb-3037-0787-c00e-b2703d66d54b@synopsys.com>
Date: Thu, 6 Jul 2017 10:44:04 +0100
MIME-Version: 1.0
In-Reply-To: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Zhiqiang,

Às 7:33 AM de 7/6/2017, Zhiqiang Hou escreveu:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The read-only DBI registers can be written over the DBI when set
> the "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
> MISC_CONTROL_1_OFF register.

I would suggest you to add a cover-letter next time to explain the global
picture of the patch-set.

I understand your need for this patch, but I don't agree on the approach.
Sometimes the people in charge of the hardware design / configuration, forget to
specify the device class and that can be problematic for some drivers, and so
the typical workaround is to set it in the driver using a quirk for example.

You can see some examples here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c

Thanks,
Joao


> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
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
