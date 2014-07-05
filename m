Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42901 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbaGERfb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 13:35:31 -0400
Received: by mail-ie0-f173.google.com with SMTP id at20so2368017iec.4
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 10:35:31 -0700 (PDT)
Date: Sat, 5 Jul 2014 11:35:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@freescale.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] MAINTAINERS: Update mx6 pci driver maintainer's email
Message-ID: <20140705173528.GB26618@google.com>
References: <1403729566-12690-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403729566-12690-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 05:52:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use Shawn's email address from Freescale.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to for-linus for v3.16, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 134483f..f35d07d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6774,7 +6774,7 @@ F:	arch/x86/kernel/quirks.c
>  
>  PCI DRIVER FOR IMX6
>  M:	Richard Zhu <r65037@freescale.com>
> -M:	Shawn Guo <shawn.guo@linaro.org>
> +M:	Shawn Guo <shawn.guo@freescale.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 1.8.3.2
> 
