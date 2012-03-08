Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45781 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289Ab2CHTu0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 14:50:26 -0500
Message-ID: <4F590D7D.70308@wwwdotorg.org>
Date: Thu, 08 Mar 2012 12:50:21 -0700
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
Subject: Re: [PATCH 08/11] ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-9-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-9-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 07:51 AM, Thierry Reding wrote:
> The PMC code already accesses the PMC registers so it makes sense to
> move this function there as well. While at it, rename the function to
> tegra_pmc_pcie_xclk_clamp() for consistency.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
