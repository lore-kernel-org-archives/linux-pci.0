Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:47256 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaEONQR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 May 2014 09:16:17 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so1252801veb.15
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2014 06:16:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140515123948.GD27594@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
	<1399478839-3564-2-git-send-email-will.deacon@arm.com>
	<CAL_JsqLUMQTd65xBRMx3XNa-7RcY93CcLdL=Z6wXsLXRpNcHGg@mail.gmail.com>
	<20140515123948.GD27594@arm.com>
Date: Thu, 15 May 2014 08:16:16 -0500
Message-ID: <CAL_JsqLbWL136=dGZZfzPbPdF5HjhktYwLaVfbkOoo7Tr+g9Pg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected
 with ARCH_MULTIPLATFORM
From: Rob Herring <robherring2@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	srikanth t <sthokal@xilinx.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 15, 2014 at 7:39 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, May 14, 2014 at 03:01:35PM +0100, Rob Herring wrote:
>> On Wed, May 7, 2014 at 11:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
>> > PCI-capable devices (e.g. mach-virt with virtio-pci).
>> >
>> > This patch allows PCI support to be selected for these SoCs by selecting
>> > CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.
>>
>> I generally think we should select all options for multi-platform that
>> only serve to hide other options like this.
>>
>> You should remove the MIGHT_HAVE_PCI selections from all the
>> multi-platform enabled platforms as well.
>
> Something like the diff below?

Yes, but that raises another question as to what do we do with
PCI_DOMAINS? Probably should be a PCI host driver select, or given how
little code it controls it could just be removed. Anyway, that's a
problem for another day (or patch).

So with the below part added:

Acked-by: Rob Herring <robh@kernel.org>

>
> Will
>
> --->8
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 49c914cd9c7a..764c129b5eee 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -55,7 +55,6 @@ config ARCH_BCM_5301X
>         select GENERIC_CLOCKEVENTS
>         select ARM_GLOBAL_TIMER
>         select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> -       select MIGHT_HAVE_PCI
>         help
>           Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
>
> diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
> index dce8decd5d46..66838f42037f 100644
> --- a/arch/arm/mach-cns3xxx/Kconfig
> +++ b/arch/arm/mach-cns3xxx/Kconfig
> @@ -1,7 +1,6 @@
>  config ARCH_CNS3XXX
>         bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
>         select ARM_GIC
> -       select MIGHT_HAVE_PCI
>         select PCI_DOMAINS if PCI
>         help
>           Support for Cavium Networks CNS3XXX platform.
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5740296dc429..50bb546b893a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -796,7 +796,6 @@ config SOC_IMX6Q
>         select ARM_ERRATA_764369 if SMP
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
> -       select MIGHT_HAVE_PCI
>         select PCI_DOMAINS if PCI
>         select PINCTRL_IMX6Q
>         select SOC_IMX6
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 3f73eecbcfb0..120301ebd324 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -9,7 +9,6 @@ config ARCH_MVEBU
>         select MVEBU_MBUS
>         select ZONE_DMA if ARM_LPAE
>         select ARCH_REQUIRE_GPIOLIB
> -       select MIGHT_HAVE_PCI
>         select PCI_QUIRKS if PCI
>         select OF_ADDRESS_PCI
>
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 0f92ba8e7884..905003898913 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -8,7 +8,6 @@ config ARCH_SHMOBILE_MULTI
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
>         select ARM_GIC
> -       select MIGHT_HAVE_PCI
>         select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>         select NO_IOPORT_MAP
>         select PINCTRL
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 55b305d51669..e16999e5b735 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -7,7 +7,6 @@ config ARCH_TEGRA
>         select CLKSRC_MMIO
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
> -       select MIGHT_HAVE_PCI
>         select PINCTRL
>         select ARCH_HAS_RESET_CONTROLLER
>         select RESET_CONTROLLER
