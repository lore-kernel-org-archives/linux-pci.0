Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42489 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdHHMqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 08:46:18 -0400
Subject: Re: [PATCHv2 3/6] PCI: layerscape: use accessors to enable/disable
 DBI RO registers' write permission
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-4-git-send-email-Zhiqiang.Hou@nxp.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <a7c1e517-4488-c979-fc13-e45fc78809be@synopsys.com>
Date: Tue, 8 Aug 2017 13:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <1501748620-42866-4-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 9:23 AM de 8/3/2017, Zhiqiang Hou escreveu:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Use the accessors instead accessing the DBI read-only write enable
> register directly. And the STRFMR1 is not read-only register, so move it
> out from the write-enable bracket.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch split from patch v1 3/3.
> 
>  drivers/pci/dwc/pci-layerscape.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index fd86128..09056a6 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -33,7 +33,6 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
>  
>  struct ls_pcie_drvdata {
>  	u32 lut_offset;
> @@ -155,11 +154,12 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct ls_pcie *pcie = to_ls_pcie(pci);
>  
> -	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	ls_pcie_fix_class(pcie);
>  	ls_pcie_clear_multifunction(pcie);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
>  	ls_pcie_drop_msg_tlp(pcie);
> -	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
>  }
>  
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> 

Acked-By: Joao Pinto <jpinto@synopsys.com>
