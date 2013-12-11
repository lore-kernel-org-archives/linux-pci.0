Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:58376 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3LKSn3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 13:43:29 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so5346009yho.38
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2013 10:43:29 -0800 (PST)
Date: Wed, 11 Dec 2013 11:43:21 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Wei Yongjun <weiyj.lk@gmail.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI
 host maintainers
Message-ID: <20131211184321.GJ4699@google.com>
References: <20131211183237.GI4699@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131211183237.GI4699@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mohit]

On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> If this looks reasonable, I'll merge it via the PCI tree for v3.13.

And I see Mohit's patch [1] to update the DesignWare entry:

+PCIE DRIVER FOR SYNOPSIS DESIGNWARE CONTROLLER
+M:	Mohit Kumar <mohit.kumar@st.com>
+M:	Jingoo Han <jg1.han@samsung.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/host/pcie-designware.c

I can fold in that update too if Jingoo acks it.

[1] http://patchwork.ozlabs.org/patch/299905/

> MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
> 
> Add entries for PCI host controller drivers in drivers/pci/host/.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8285ed4676b6..826c722d92ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6449,16 +6449,47 @@ F:	drivers/pci/
>  F:	include/linux/pci*
>  F:	arch/x86/pci/
>  
> +PCI DRIVER FOR DESIGNWARE
> +M:	Jingoo Han <jg1.han@samsung.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/*designware*
> +
> +PCI DRIVER FOR IMX6
> +M:	Shawn Guo <shawn.guo@linaro.org>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*imx6*
> +
> +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> +M:	Jason Cooper <jason@lakedaemon.net>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*mvebu*
> +
>  PCI DRIVER FOR NVIDIA TEGRA
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  L:	linux-tegra@vger.kernel.org
> +L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  F:	drivers/pci/host/pci-tegra.c
>  
> +PCI DRIVER FOR RENESAS R-CAR
> +M:	Simon Horman <horms@verge.net.au>
> +M:	Magnus Damm <magnus.damm@gmail.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-sh@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/*rcar*
> +
>  PCI DRIVER FOR SAMSUNG EXYNOS
>  M:	Jingoo Han <jg1.han@samsung.com>
>  L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/pci/host/pci-exynos.c
>  
