Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52592 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbaEHPI3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 11:08:29 -0400
Message-ID: <536B9DE9.80100@wwwdotorg.org>
Date: Thu, 08 May 2014 09:08:25 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org
CC: arnd@arndb.de, linux-pci@vger.kernel.org, sthokal@xilinx.com,
	jgunthorpe@obsidianresearch.com, bhelgaas@google.com
Subject: Re: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected
 with ARCH_MULTIPLATFORM
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com> <1399478839-3564-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1399478839-3564-2-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/07/2014 10:07 AM, Will Deacon wrote:
> When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> PCI-capable devices (e.g. mach-virt with virtio-pci).
> 
> This patch allows PCI support to be selected for these SoCs by selecting
> CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

> @@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
>  	select CLKSRC_OF
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
> +	select MIGHT_HAVE_PCI

Doesn't ARCH_MULTIPLATFORM allow ARCH_$soc to be selected, and ARCH_$soc
selects MIGHT_HAVE_PCI?

That way, you can only enable PCI support if you have actually enabled
an SoC that has PCI, and equally ARCH_$soc selects MIGHT_HAVE_PCI just
like it always used to work before ARCH_MULTIPLATFORM.
