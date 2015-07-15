Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:53789 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbbGOVx5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 17:53:57 -0400
Message-ID: <55A6D673.1040908@hauke-m.de>
Date: Wed, 15 Jul 2015 23:53:55 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: Add Broadcom iProc family support
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com> <1436935343-4437-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1436935343-4437-4-git-send-email-rjui@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/15/2015 06:42 AM, Ray Jui wrote:
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

Is this working correctly if we have ARCH_BCM_IPROC under ARM and ARM64?
They are guarding the same SoC line, which now uses ARM64 CPUS.

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
> 

