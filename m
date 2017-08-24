Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753929AbdHXROr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 13:14:47 -0400
Date: Thu, 24 Aug 2017 12:14:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        svarbanov@mm-sol.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Subject: Re: [PATCHv4 7/9] PCI: layerscape: use accessors to enable/disable
 DBI RO registers' write permission
Message-ID: <20170824171445.GQ31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
 <20170823060856.9387-8-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823060856.9387-8-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 02:08:54PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Use the accessors instead accessing the DBI read-only write enable
> register directly.

This patch and the previous one (that added dw_pcie_dbi_ro_wr_en())
should be squashed together.  That way it's obvious that the new code
here is equivalent to the old code

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Acked-By: Joao Pinto <jpinto@synopsys.com>
> ---
> V4:
>  - no change
> 
>  drivers/pci/dwc/pci-layerscape.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 44a603db217a..0c1330fce01d 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -33,7 +33,6 @@
>  
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
>  
>  #define PCIE_IATU_NUM		6
>  
> @@ -145,10 +144,10 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	 */
>  	ls_pcie_disable_outbound_atus(pcie);
>  
> -	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	ls_pcie_fix_class(pcie);
>  	ls_pcie_clear_multifunction(pcie);
> -	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	ls_pcie_drop_msg_tlp(pcie);
>  
> -- 
> 2.14.1
> 
