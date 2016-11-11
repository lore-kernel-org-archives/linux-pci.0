Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965001AbcKKWyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 17:54:18 -0500
Date: Fri, 11 Nov 2016 16:54:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, l.stach@pengutronix.de, hongxing.zhu@nxp.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] MAINTAINERS: PCI: imx6: Use Richard Zhu's NXP email
Message-ID: <20161111225414.GW9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1477499244-10640-1-git-send-email-fabio.estevam@nxp.com>
 <1477499244-10640-2-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477499244-10640-2-git-send-email-fabio.estevam@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 26, 2016 at 02:27:23PM -0200, Fabio Estevam wrote:
> FSL emails may become invalid soon, so switch to the NXP one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

I applied patches 2 & 3 (MAINTAINERS updates) with acks from Richard and
Lucas.  I put these on for-linus, so they should go in v4.9 if I have any
more stuff to send to Linus before then.  I probably won't ask him to pull
*just* these, so if by some chance I don't have any more v4.9 material,
they will appear in v4.10.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8544cd6..cf828f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9257,7 +9257,7 @@ S:	Maintained
>  F:	drivers/pci/host/*layerscape*
>  
>  PCI DRIVER FOR IMX6
> -M:	Richard Zhu <Richard.Zhu@freescale.com>
> +M:	Richard Zhu <hongxing.zhu@nxp.com>
>  M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
