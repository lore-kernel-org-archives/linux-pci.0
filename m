Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36637 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbBXBWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Feb 2015 20:22:40 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so23182936igb.5
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2015 17:22:39 -0800 (PST)
Date: Mon, 23 Feb 2015 19:22:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-pci@vger.kernel.org, phil.edworthy@renesas.com,
	horms+renesas@verge.net.au
Subject: Re: [PATCH] PCI: rcar: Fix postion of MSI enable bit
Message-ID: <20150224012236.GA6220@google.com>
References: <1422853779-14413-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422853779-14413-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 02, 2015 at 02:09:39PM +0900, Nobuhiro Iwamatsu wrote:
> Position of MSI enable bit is 31bit, not 28bit.
> This fixes position of MSI bit necessary to initialize MSI.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied to pci/host-rcar for v4.1, thanks!

> ---
>  drivers/pci/host/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index bb36e27..eb12659 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -505,7 +505,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
>  
>  	/* Enable MSI */
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		rcar_pci_write_reg(pcie, 0x101f0000, PCIEMSITXR);
> +		rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
>  
>  	/* Finish initialization - establish a PCI Express link */
>  	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> -- 
> 2.1.3
> 
