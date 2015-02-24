Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41314 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbBXG0J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 01:26:09 -0500
Received: by pdno5 with SMTP id o5so31140995pdn.8
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2015 22:26:08 -0800 (PST)
Date: Tue, 24 Feb 2015 00:26:05 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au
Subject: Re: [PATCH] PCI: rcar: Change macro name of PCIEPARL and PCIEPARH
Message-ID: <20150224062605.GC6220@google.com>
References: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423040575-28080-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 04, 2015 at 06:02:55PM +0900, Nobuhiro Iwamatsu wrote:
> PCIEPARL and PCIEPARH are macro that calculates address of the register.
> However, register name is incorrect, PCIEPALR and PCIEPAUR is correct.
> This change macro name to PCIEPALR and PCIEPAUR.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied to pci/host-rcar for v4.1, thanks!

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
> @@ -341,9 +341,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
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
> 
