Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35976 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcB2XZ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 18:25:26 -0500
Date: Mon, 29 Feb 2016 17:25:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <Minghuan.Lian@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci/layerscape: fix MSG TLP drop setting
Message-ID: <20160229232522.GG3653@localhost>
References: <1456383870-23302-1-git-send-email-Minghuan.Lian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456383870-23302-1-git-send-email-Minghuan.Lian@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 03:04:30PM +0800, Minghuan Lian wrote:
> Some kinds of Layerscape PCIe controllers will forward the received
> message TLPs to system application address space, which could corrupt
> system memory or lead to a system hang. The patch enables the MSG_DROP
> to fix this issue.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>

Applied to for-linus for v4.5, thanks, Minghuan!

> ---
>  drivers/pci/host/pci-layerscape.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 3923bed..f39961b 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -77,6 +77,16 @@ static void ls_pcie_fix_class(struct ls_pcie *pcie)
>  	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->dbi + PCI_CLASS_DEVICE);
>  }
>  
> +/* Drop MSG TLP except for Vendor MSG */
> +static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = ioread32(pcie->dbi + PCIE_STRFMR1);
> +	val &= 0xDFFFFFFF;
> +	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
> +}
> +
>  static int ls1021_pcie_link_up(struct pcie_port *pp)
>  {
>  	u32 state;
> @@ -97,7 +107,7 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
>  static void ls1021_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
> -	u32 val, index[2];
> +	u32 index[2];
>  
>  	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
>  						     "fsl,pcie-scfg");
> @@ -116,13 +126,7 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_setup_rc(pp);
>  
> -	/*
> -	 * LS1021A Workaround for internal TKT228622
> -	 * to fix the INTx hang issue
> -	 */
> -	val = ioread32(pcie->dbi + PCIE_STRFMR1);
> -	val &= 0xffff;
> -	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
> +	ls_pcie_drop_msg_tlp(pcie);
>  }
>  
>  static int ls_pcie_link_up(struct pcie_port *pp)
> @@ -147,6 +151,7 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	iowrite32(1, pcie->dbi + PCIE_DBI_RO_WR_EN);
>  	ls_pcie_fix_class(pcie);
>  	ls_pcie_clear_multifunction(pcie);
> +	ls_pcie_drop_msg_tlp(pcie);
>  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
