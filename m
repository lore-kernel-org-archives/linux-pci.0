Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62153 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbaKMTEy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 14:04:54 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so15863917pac.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 11:04:54 -0800 (PST)
Date: Thu, 13 Nov 2014 12:04:48 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra: Do not build on 64-bit ARM
Message-ID: <20141113190448.GA14500@google.com>
References: <1415800418-22957-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415800418-22957-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 02:53:37PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> 32-bit and 64-bit ARM use very different infrastructure to register a
> PCI host bridge. The Tegra PCIe host controller driver currently only
> supports the 32-bit ARM infrastructure, so prevent it from being built
> on 64-bit ARM where it will break.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

I applied both of these to pci/host-tegra for v3.19, thanks!

> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 3dc25fad490c..9c56137e5e5e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -32,7 +32,7 @@ config PCI_IMX6
>  
>  config PCI_TEGRA
>  	bool "NVIDIA Tegra PCIe controller"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA && !ARM64
>  
>  config PCI_RCAR_GEN2
>  	bool "Renesas R-Car Gen2 Internal PCI controller"
> -- 
> 2.1.3
> 
