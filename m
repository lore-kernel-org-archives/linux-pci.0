Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:59360 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaIXNZz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 09:25:55 -0400
Received: by mail-ie0-f181.google.com with SMTP id tr6so11382094ieb.40
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2014 06:25:54 -0700 (PDT)
Date: Wed, 24 Sep 2014 07:25:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: designware: Fix configuration base address
Message-ID: <20140924132551.GA13850@google.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 10:28:56PM +0800, Minghuan Lian wrote:
> The code has calculated cfg0_base and cfg1_base when parsing 'reg'
> or 'ranges' property of PCI DTS node. so remove duplicate calculation.
> And when using 'reg', resource cfg is not used, the removed code
> will get incorrect configuration base.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

Applied to pci/host-designware with Mohit's ack for v3.18, thanks!

> ---
>  drivers/pci/host/pcie-designware.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index c28ca05..0f3cb2a 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -515,7 +515,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	pp->mem_base = pp->mem.start;
>  
>  	if (!pp->va_cfg0_base) {
> -		pp->cfg0_base = pp->cfg.start;
>  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
>  						pp->cfg0_size);
>  		if (!pp->va_cfg0_base) {
> @@ -525,7 +524,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	if (!pp->va_cfg1_base) {
> -		pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
>  		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
>  						pp->cfg1_size);
>  		if (!pp->va_cfg1_base) {
> -- 
> 1.9.1
> 
