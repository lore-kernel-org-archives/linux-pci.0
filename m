Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54585 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbaEBSLP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 14:11:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jgunthorpe@obsidianresearch.com
Subject: Re: [RESEND PATCH 1/3] ARM: mach-virt: allow PCI support to be selected
Date: Fri, 02 May 2014 20:11:04 +0200
Message-ID: <4646975.AnXvL4OPrE@wuerfel>
In-Reply-To: <1399048876-11862-2-git-send-email-will.deacon@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com> <1399048876-11862-2-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 02 May 2014 17:41:14 Will Deacon wrote:
> mach-virt can make use of virtio-pci devices, which requires the guest
> kernel to have PCI support selected.
> 
> This patch selects CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_VIRT=y.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db3c5414223e..f24356c4d630 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -941,6 +941,7 @@ config ARCH_VIRT
>         select ARM_GIC
>         select ARM_PSCI
>         select HAVE_ARM_ARCH_TIMER
> +       select MIGHT_HAVE_PCI

I would actually just put it under ARCH_MULTIPLATFORM. Anything can
have PCI really, and it doesn't cause any harm.

	Arnd
