Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46053 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab3JSBeI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 21:34:08 -0400
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] PCI: imx6: fix imprecise abort handler
Date: Sat, 19 Oct 2013 03:33:52 +0200
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
References: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310190333.52772.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Tim Harvey,

> An imprecise abort is triggered when a port behind a switch is accessed
> and no device is present.  At enumeration, imprecise aborts are not enabled
> thus this ends up getting deferred until the kernel has completed init.  At
> that point we must not adjust PC - the handler must do nothing, but a
> handler must exist.
> 
> This fixes random crashes that occur right after freeing init.
> This is against linux-pci/host-imx6.
> 
> Acked-by: Marek Vasut <marex@denx.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Expanding CC a bit, let's have more eyes on this.

> ---
>  drivers/pci/host/pci-imx6.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 966bac6..90fce05 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -200,12 +200,6 @@ static int pcie_phy_write(void __iomem *dbi_base, int
> addr, int data) static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
> -	/*
> -	 * If it was an imprecise abort, then we need to correct the
> -	 * return address to be _after_ the instruction.
> -	 */
> -	if (fsr & (1 << 10))
> -		regs->ARM_pc += 4;
>  	return 0;
>  }

Best regards,
Marek Vasut
