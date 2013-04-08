Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51630BF4.6000605@wwwdotorg.org>
Date: Mon, 08 Apr 2013 12:27:00 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jay Agarwal <jagarwal@nvidia.com>
CC: linux@arm.linux.org.uk, thierry.reding@avionic-design.de,
	ldewangan@nvidia.com, bhelgaas@google.com, olof@lixom.net,
	hdoyu@nvidia.com, pgaikwad@nvidia.com, mturquette@linaro.org,
	pdeschrijver@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, jtukkinen@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH 2/3] ARM: dts: tegra: Correct PCIe entry
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com> <1365435688-4179-2-git-send-email-jagarwal@nvidia.com>
In-Reply-To: <1365435688-4179-2-git-send-email-jagarwal@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>

Your s-o-b line should be below the patch description, not above it.
Please see Documentation/SubmittingPatches.

I also don't see a --- line between the patch description and diffstat.
How are you generating these patch emails? Please see our internal wiki,
or other git documentation.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> -		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
> +		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml0";

Can you please explain more about this change?

I see the Tegra clock driver provides both a "cml0" and a "cml1" clock.
Are both of those used for PCIe?

If so, then why doesn't the driver and this DT change include both cml0
and cml1?

If not, then please note that the clock-names property doesn't have to
match the name of the clock at the clock provider. This property names
the clock inputs to the HW module. Hence, if the PCIe module only uses a
single CML clock, it can quite legitimately name its clock input just
"cml" rather than "cml0". In this case, you wouldn't need to make this
change to the DT.
