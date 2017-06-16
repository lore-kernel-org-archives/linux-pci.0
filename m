Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdFPQvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 12:51:18 -0400
Date: Fri, 16 Jun 2017 11:51:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add an entry for MediaTek PCIe driver
Message-ID: <20170616165114.GB11129@bhelgaas-glaptop.roam.corp.google.com>
References: <1497588789-28607-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497588789-28607-1-git-send-email-ryder.lee@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 12:53:09PM +0800, Ryder Lee wrote:
> Add MediaTek PCIe driver maintainer entry.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Folded into pci/host-mediatek for v4.13, thanks!

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7d568b..736648e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9957,6 +9957,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/pci/pci-thunder-*
>  F:	drivers/pci/host/pci-thunder-*
>  
> +PCIE DRIVER FOR MEDIATEK
> +M:      Ryder Lee <ryder.lee@mediatek.com>
> +L:      linux-pci@vger.kernel.org
> +L:      linux-mediatek@lists.infradead.org
> +S:      Supported
> +F:      Documentation/devicetree/bindings/pci/mediatek*
> +F:      drivers/pci/host/*mediatek*
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia@lists.infradead.org
> -- 
> 1.9.1
> 
