Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43949 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbHaGXI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 02:23:08 -0400
Date: Mon, 31 Aug 2015 15:23:04 +0900
From: Simon Horman <horms@verge.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>,
	TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>
Subject: Re: [PATCH][resent] PCI: rcar: Add PCIE_CONF_REGNO macro for PCIECAR
 register
Message-ID: <20150831062200.GB27319@verge.net.au>
References: <HKNPR06MB049BFAE520321568794CA8FC5600@HKNPR06MB049.apcprd06.prod.outlook.com>
 <874mjlefty.wl%kuninori.morimoto.gx@renesas.com>
 <8737z5efjt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737z5efjt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 27, 2015 at 12:37:00AM +0000, Kuninori Morimoto wrote:
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> The reg variable used when setting PCIECAR register need to be masked by 0xFC
> by restriction of the corresponding register.
> This adds PCIE_CONF_REGNO are macros for masking changes that PCIE_CONF_REGNO
> is used when setting PCIECAR register.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
> This patch was posted to ML, but still no response.
> I re-sent it because original author has gone now.
> 
>  drivers/pci/host/pcie-rcar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index c086210..9fd39cd8b 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -104,6 +104,7 @@
>  #define  PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
>  #define  PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
>  #define  PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
> +#define  PCIE_CONF_REGNO(r)	(r & 0xfc)
>  
>  #define RCAR_PCI_MAX_RESOURCES 4
>  #define MAX_NR_INBOUND_MAPS 6
> @@ -227,7 +228,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>  
>  	/* Set the PIO address */
>  	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
> -		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
> +		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) |
> +		PCIE_CONF_REGNO(reg), PCIECAR);
>  
>  	/* Enable the configuration access */
>  	if (bus->parent->number == pcie->root_bus_nr)

This seems to partially duplicate the following line earlier on
in rcar_pcie_config_access().

	reg = where & ~3;

I wonder if that line could be updated to use the new PCIE_CONF_REGNO()
macro. If so it seems that the second hunk of the patch could be dropped.
