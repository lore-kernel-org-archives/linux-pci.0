Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33607 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab2FKVlt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 17:41:49 -0400
Message-ID: <4FD6661A.1060407@wwwdotorg.org>
Date: Mon, 11 Jun 2012 15:41:46 -0600
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
Subject: Re: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> With the device tree support in place, probe the PCIe controller from
> the device tree and remove the corresponding workaround in the board
> file.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts

> +	pci_vdd_reg: fixedregulator@0 {

I think that'd usually just be "regulator@0".

If you need the "@0" part to differentiate between multiple regulators,
the node needs a reg property too:

	reg = <0 0>;

although then I wonder about putting the regulator under the root node,
since the address wouldn't really make sense...
