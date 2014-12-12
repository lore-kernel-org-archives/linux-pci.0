Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57433 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966268AbaLLMQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Dec 2014 07:16:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	Christian Daudt <bcm@fixthebug.org>,
	Matt Porter <mporter@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: mach-bcm: Enable PCIe support for iProc
Date: Fri, 12 Dec 2014 13:15:52 +0100
Message-ID: <3173848.p74DGitYxH@wuerfel>
In-Reply-To: <1418351817-14898-4-git-send-email-rjui@broadcom.com>
References: <1418351817-14898-4-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 11 December 2014 18:36:56 Ray Jui wrote:
> Enable PCIe driver support for Broadcom iProc family of SoCs by
> selecting PCIE_IPROC
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm/mach-bcm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index aaeec78..a13a0b2 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_AMBA
>  	select PINCTRL
> +	select PCIE_IPROC
>  	help
>  	  This enables support for systems based on Broadcom IPROC architected SoCs.
>  	  The IPROC complex contains one or more ARM CPUs along with common
> 

No, just enable it in multi_v7_defconfig and bcm_defconfig.

	Arnd
