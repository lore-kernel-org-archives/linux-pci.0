Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:27900 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933410AbbBDJOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Feb 2015 04:14:44 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: rcar: Change macro name of PCIEPARL and PCIEPARH
Date: Wed, 4 Feb 2015 09:14:40 +0000
Message-ID: <SIXPR06MB06397E299C79226C6DD148CDF53A0@SIXPR06MB0639.apcprd06.prod.outlook.com>
References: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Iwamatsu-san,

On: 04 February 2015 09:03, Nobuhiro Iwamatsu wrote:
> 
> PCIEPARL and PCIEPARH are macro that calculates address of the register.
> However, register name is incorrect, PCIEPALR and PCIEPAUR is correct.
> This change macro name to PCIEPALR and PCIEPAUR.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks
Phil

> ---
>  drivers/pci/host/pcie-rcar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index eb12659..183c32d 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -64,8 +64,8 @@
>  #define  LAR_ENABLE		(1 << 1)
> 
>  /* PCIe address reg & mask */
> -#define PCIEPARL(x)		(0x03400 + ((x) * 0x20))
> -#define PCIEPARH(x)		(0x03404 + ((x) * 0x20))
> +#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
> +#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
>  #define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
>  #define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
>  #define  PAR_ENABLE		(1 << 31)
> @@ -341,9 +341,9 @@ static void rcar_pcie_setup_window(int win, struct
> rcar_pcie *pcie)
>  	else
>  		res_start = res->start;
> 
> -	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
> +	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
>  	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> -			   PCIEPARL(win));
> +			   PCIEPALR(win));
> 
>  	/* First resource is for IO */
>  	mask = PAR_ENABLE;
> --
> 2.1.3

