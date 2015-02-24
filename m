Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42885 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbBXGZu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 01:25:50 -0500
Received: by padhz1 with SMTP id hz1so33621475pad.9
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2015 22:25:50 -0800 (PST)
Date: Tue, 24 Feb 2015 00:25:42 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au
Subject: Re: [PATCH] PCI: rcar: Add mask of data to be written to PCIEPARL
Message-ID: <20150224062542.GB6220@google.com>
References: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422853798-14467-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 02, 2015 at 02:09:58PM +0900, Nobuhiro Iwamatsu wrote:
> Lower 7bit of PCIEPARL is reserved bit. When we write to this register,
> these bits must be 0.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied to pci/host-rcar for v4.1, thanks!

> ---
>  drivers/pci/host/pcie-rcar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 748786c..bb36e27 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -342,7 +342,8 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
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
> 
