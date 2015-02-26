Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:56102 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbbBZBEm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 20:04:42 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so40781963igb.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 17:04:41 -0800 (PST)
Date: Wed, 25 Feb 2015 19:04:38 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] PCI: xgene: Fix xgene_pcie_map_bus() return type
Message-ID: <20150226010438.GT6220@google.com>
References: <1423512731-9625-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423512731-9625-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tanmay]

On Mon, Feb 09, 2015 at 06:12:11PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit 350f8be5bb402a1 ("PCI: xgene: Convert to use generic config accessors")
> introduced the following build warnings:
> 
> drivers/pci/host/pci-xgene.c:137:3: warning: return makes integer from pointer without a cast
> drivers/pci/host/pci-xgene.c:140:2: warning: return makes integer from pointer without a cast
> drivers/pci/host/pci-xgene.c:144:2: warning: initialization from incompatible pointer type
> drivers/pci/host/pci-xgene.c:144:2: warning: (near initialization for 'xgene_pcie_ops.map_bus')
> 
> The .map_bus function should return 'void __iomem *' instead of 'int'.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to for-linus for v4.0, thanks!

Rob, Tanmay, speak up if you object.

> ---
>  drivers/pci/host/pci-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index aab5547..22addb6 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>  	return false;
>  }
>  
> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			      int offset)
>  {
>  	struct xgene_pcie_port *port = bus->sysdata;
> -- 
> 1.9.1
> 
