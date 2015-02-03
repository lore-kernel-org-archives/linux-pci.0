Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:51864 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965956AbbBCSx5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Feb 2015 13:53:57 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: rcar: Add mask of data to be written to PCIEPARL
Date: Tue, 3 Feb 2015 18:53:51 +0000
Message-ID: <SIXPR06MB0639AA0109B0332E757B7BF6F53D0@SIXPR06MB0639.apcprd06.prod.outlook.com>
References: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Iwamatsu-san,

On: 02 February 2015 05:10, Nobuhiro Iwamatsu wrote:
> 
> Lower 7bit of PCIEPARL is reserved bit. When we write to this register,
> these bits must be 0.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks
Phil

> ---
>  drivers/pci/host/pcie-rcar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 748786c..bb36e27 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -342,7 +342,8 @@ static void rcar_pcie_setup_window(int win, struct
> rcar_pcie *pcie)
>  		res_start = res->start;
> 
>  	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(win));
> -	rcar_pci_write_reg(pcie, lower_32_bits(res_start), PCIEPARL(win));
> +	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> +			   PCIEPARL(win));
> 
>  	/* First resource is for IO */
>  	mask = PAR_ENABLE;
> --
> 2.1.3

