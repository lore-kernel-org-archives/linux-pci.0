Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43403 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbbGXIvH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jul 2015 04:51:07 -0400
Date: Fri, 24 Jul 2015 09:51:03 +0100
From: Will Deacon <will.deacon@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	olof@lixom.net
Subject: Re: [PATCH v4 3/4] arm64: Add Broadcom iProc family support
Message-ID: <20150724085103.GA30410@arm.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-4-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437528583-855-4-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(adding Olof)

On Wed, Jul 22, 2015 at 02:29:42AM +0100, Ray Jui wrote:
> This patch adds support to Broadcom's iProc family of arm64 based SoCs
> in the arm64 Kconfig and defconfig files
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm64/Kconfig           |    5 +++++
>  arch/arm64/configs/defconfig |    2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f..969ef4a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -162,6 +162,11 @@ source "kernel/Kconfig.freezer"
>  
>  menu "Platform selection"
>  
> +config ARCH_BCM_IPROC
> +	bool "Broadcom iProc SoC Family"
> +	help
> +	  This enables support for Broadcom iProc based SoCs
> +

The arm-soc guys have a patch moving the platform-related config options
out into Kconfig.platforms, so I think you need to co-ordinate with them.

>  config ARCH_EXYNOS
>  	bool
>  	help
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4e17e7e..c83d51f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -31,6 +31,7 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
> +CONFIG_ARCH_BCM_IPROC=y
>  CONFIG_ARCH_EXYNOS7=y
>  CONFIG_ARCH_FSL_LS2085A=y
>  CONFIG_ARCH_HISI=y
> @@ -102,6 +103,7 @@ CONFIG_SERIO_AMBAKMI=y
>  CONFIG_LEGACY_PTY_COUNT=16
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y

I'm fine with this.

Will
