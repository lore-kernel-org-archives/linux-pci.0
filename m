Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37288 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab2CHUJN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 15:09:13 -0500
Message-ID: <4F5911E0.6060802@wwwdotorg.org>
Date: Thu, 08 Mar 2012 13:09:04 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 09/11] ARM: tegra: Rewrite PCIe support as a driver
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 07:51 AM, Thierry Reding wrote:
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Patch description?

> diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
...
> -static int __init harmony_pcie_init(void)
> +static int tegra_pcie_init(struct platform_device *pdev)

That name should probably still be called harmony_something() since it's
still board-specific.

I wonder how having a per-board callback will integrate with device
tree. I guess I'll find out when I review patch 11:-)

> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c

> +static int __init trimslice_pci_init(void)
>  {
>  	if (!machine_is_trimslice())
>  		return 0;

You can remove that test now.

> diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h

> +#define TEGRA_PCIE_MAX_PORTS 2
> +
> +struct tegra_pcie_pdata {
> +	int (*init)(struct platform_device *pdev);
> +	int (*exit)(struct platform_device *pdev);
> +	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
> +};

That's a somewhat odd place to put the header; a dedicated
mach-tegra/include/mach/tegra_pcie_pdata.h or
include/linux/platform_data/tegra_pcie.h might make more sense.

Aside from those pretty minor issues, this all looks great. Thanks for
fixing our driver!
