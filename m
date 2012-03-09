Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34452 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758129Ab2CIQmj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 11:42:39 -0500
Message-ID: <4F5A32F8.80001@wwwdotorg.org>
Date: Fri, 09 Mar 2012 09:42:32 -0700
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
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-10-git-send-email-thierry.reding@avionic-design.de> <4F5911E0.6060802@wwwdotorg.org> <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120309063739.GC25208@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 11:37 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
...
>>> diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
>>
>>> +#define TEGRA_PCIE_MAX_PORTS 2
>>> +
>>> +struct tegra_pcie_pdata {
>>> +	int (*init)(struct platform_device *pdev);
>>> +	int (*exit)(struct platform_device *pdev);
>>> +	bool enable_ports[TEGRA_PCIE_MAX_PORTS];
>>> +};
>>
>> That's a somewhat odd place to put the header; a dedicated
>> mach-tegra/include/mach/tegra_pcie_pdata.h or
>> include/linux/platform_data/tegra_pcie.h might make more sense.
> 
> mach-tegra/include/mach/pcie.h perhaps? That would be less redundant.

New files in that directory should have tegra in the name somewhere, so
that when multi-SoC kernels are built, and multiple mach-*/include/mach
directories are in the include path (or files get moved from those paths
into a single common place), you know which include file you're getting.
