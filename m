Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34963 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760160Ab2FUURg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 16:17:36 -0400
Message-ID: <4FE3815C.8030505@wwwdotorg.org>
Date: Thu, 21 Jun 2012 14:17:32 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> Device tree support for the TPS6586x PMU used on Harmony has recently
> been added. This commit adds the required device tree nodes to probe the
> PMU from the device tree.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts

> +		tps6586x@34 {
> +			compatible = "ti,tps6586x";
> +			reg = <0x34>;
> +			interrupts = <0 88 0x4>;

I believe that should be interrupt 86 not 88.
