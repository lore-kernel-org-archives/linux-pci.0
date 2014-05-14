Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:52644 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbaENOBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 May 2014 10:01:37 -0400
Received: by mail-vc0-f172.google.com with SMTP id hr9so2508820vcb.3
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2014 07:01:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399478839-3564-2-git-send-email-will.deacon@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
	<1399478839-3564-2-git-send-email-will.deacon@arm.com>
Date: Wed, 14 May 2014 09:01:35 -0500
Message-ID: <CAL_JsqLUMQTd65xBRMx3XNa-7RcY93CcLdL=Z6wXsLXRpNcHGg@mail.gmail.com>
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

On Wed, May 7, 2014 at 11:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> PCI-capable devices (e.g. mach-virt with virtio-pci).
>
> This patch allows PCI support to be selected for these SoCs by selecting
> CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.

I generally think we should select all options for multi-platform that
only serve to hide other options like this.

You should remove the MIGHT_HAVE_PCI selections from all the
multi-platform enabled platforms as well.

Rob

>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db3c5414223e..860bea828ac4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
>         select CLKSRC_OF
>         select COMMON_CLK
>         select GENERIC_CLOCKEVENTS
> +       select MIGHT_HAVE_PCI
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>         select USE_OF
> --
> 1.9.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
