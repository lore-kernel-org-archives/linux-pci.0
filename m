Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754879AbcJLQ0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:26:39 -0400
Date: Wed, 12 Oct 2016 11:16:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add DT binding doc to the Aardvark PCIE
 driver maintainer
Message-ID: <20161012161618.GV4308@localhost>
References: <1475872231-3199-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1475872231-3199-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475872231-3199-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 07, 2016 at 10:30:31PM +0200, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to pci/host-aardvark for v4.9, thanks, Thomas!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f6fb8c..c0ac3dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9019,6 +9019,7 @@ M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
>  F:	drivers/pci/host/pci-aardvark.c
>  
>  PCI DRIVER FOR NVIDIA TEGRA
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
