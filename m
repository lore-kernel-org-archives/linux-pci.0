Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:46028 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbAVTnS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jan 2015 14:43:18 -0500
Received: by mail-ob0-f169.google.com with SMTP id va8so1324247obc.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2015 11:43:18 -0800 (PST)
Date: Thu, 22 Jan 2015 13:43:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix Richard Zhu's mail address
Message-ID: <20150122194309.GC13072@google.com>
References: <1421662651-22962-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421662651-22962-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 19, 2015 at 11:17:31AM +0100, Lucas Stach wrote:
> The old cryptic address bounces, fix it by using a properly
> working one.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied with Richard's ack to for-linus for v3.19, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fa385321245..b0a01320c755 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7239,7 +7239,7 @@ S:	Maintained
>  F:	drivers/pci/host/*layerscape*
>  
>  PCI DRIVER FOR IMX6
> -M:	Richard Zhu <r65037@freescale.com>
> +M:	Richard Zhu <Richard.Zhu@freescale.com>
>  M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.1.4
> 
