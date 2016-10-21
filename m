Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934311AbcJUPhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 11:37:07 -0400
Date: Fri, 21 Oct 2016 10:37:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Yang <leoyang.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stuart Yoder <stuart.yoder@nxp.com>
Subject: Re: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL
 pointer
Message-ID: <20161021153701.GC9007@localhost>
References: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 04:44:06PM -0500, Li Yang wrote:
> Commit fefe6733e added reference to the pcie->drvdata before it is
> initialized which causes a kernel panic.  Fix the problem by
> initializing the pcie->drvdata earlier before it is used.
> 
> Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

I applied Marc Zyngier's identical patch to for-linus for v4.9.  I don't
know which was posted first, but I saw Marc's first.  Sorry I didn't at
least credit you when I applied it.

> ---
>  drivers/pci/host/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 2cb7315..958187f 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -245,6 +245,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	if (!pcie)
>  		return -ENOMEM;
>  
> +	pcie->drvdata = match->data;
>  	pp = &pcie->pp;
>  	pp->dev = dev;
>  	pp->ops = pcie->drvdata->ops;
> @@ -256,7 +257,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->pp.dbi_base);
>  	}
>  
> -	pcie->drvdata = match->data;
>  	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
>  
>  	if (!ls_pcie_is_bridge(pcie))
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
