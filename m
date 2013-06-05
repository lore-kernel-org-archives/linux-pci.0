Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45640 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab3FEQgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 12:36:06 -0400
Message-ID: <51AF68F1.8080307@wwwdotorg.org>
Date: Wed, 05 Jun 2013 10:36:01 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jay Agarwal <jagarwal@nvidia.com>
CC: linux@arm.linux.org.uk, thierry.reding@avionic-design.de,
	bhelgaas@google.com, ldewangan@nvidia.com, olof@lixom.net,
	hdoyu@nvidia.com, pgaikwad@nvidia.com, mturquette@linaro.org,
	pdeschrijver@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, jtukkinen@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V4 2/4] ARM: tegra: pcie: Add tegra3 support
References: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
In-Reply-To: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/05/2013 09:13 AM, Jay Agarwal wrote:
> - Make private data structure for each SoC
> - Add required Tegra30 clocks and regulators
> - Add Tegra30 specific code in enable controller
> - Added Tegra30 specific properties in pci binding document

It's a bit odd to send an updated version of just some of the patches;
reposting a whole series is much easier for the person applying the
patches. However, hopefully Thierry can handle it in this case.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

>  Required properties:
> -- compatible: "nvidia,tegra20-pcie"
> +- compatible: "nvidia,tegra20-pcie" "nvidia,tegra30-pcie"

perhaps add "or" between those two entries?

> +- avdd-supply: Power supply for controller (1.05V) (not required for tegra20)
...
> +  "cml": The Tegra clock of that name (not required for tegra20)

Tegra20 should be capitalized in both those two lines.

I assume that Thierry can fix up these nits when he applies the patches,
so you don't need to repost. Thierry can correct me if I'm wrong.
