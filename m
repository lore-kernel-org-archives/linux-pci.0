Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32882 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbbGNJOL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jul 2015 05:14:11 -0400
Date: Tue, 14 Jul 2015 10:14:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, linux-pci@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: Add Broadcom's North Star 2 support
Message-ID: <20150714091406.GC13555@e104818-lin.cambridge.arm.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
 <1436837955-26279-4-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436837955-26279-4-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 13, 2015 at 06:39:14PM -0700, Ray Jui wrote:
> This patch adds support to Broadcom's North Star 2 SoC in the arm64
> Kconfig and defconfig files
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm64/Kconfig           |   12 ++++++++++++
>  arch/arm64/configs/defconfig |    2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f..6c5c279 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -162,6 +162,18 @@ source "kernel/Kconfig.freezer"
>  
>  menu "Platform selection"
>  
> +config ARCH_BCM_IPROC
> +	bool
> +	help
> +	  This enables support for Broadcom iProc based SoCs
> +
> +config ARCH_BCM_NS2
> +	bool "Broadcom North Start 2 (BCM5871X)"
> +	select ARCH_BCM_IPROC
> +	help
> +	  This enables support for Broadcom NS2 (BCM5871X). NS2 is in
> +	  the iProc family of SoCs based on the ARMv8 architecture

Do you really need the second config option? Just leave the one covering
the family as we do for most of the other family SoCs on arm64 (apart
from ARCH_TEGRA_123_SOC which I plan to remove and use ARCH_TEGRA
instead).

-- 
Catalin
