Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34386 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbcFOVCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jun 2016 17:02:16 -0400
Date: Wed, 15 Jun 2016 16:02:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>, Ley Foon Tan <lftan@altera.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies
Message-ID: <20160615210211.GA17504@localhost>
References: <8531046.3ceRqUA835@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8531046.3ceRqUA835@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 15, 2016 at 10:09:38PM +0200, Arnd Bergmann wrote:
> The PCI_MSI symbol is used inconsistently throughout the tree,
> with some drivers using 'select' and others using 'depends on',
> or using conditional selects. This keeps causing problems,
> and the latest one is a result of ARCH_ALPINE using a 'select'
> statement to enable its platform specific MSI driver but not
> enabling MSI support first:
> 
> warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI && PCI_MSI)
> drivers/irqchip/irq-alpine-msi.c:104:15: error: variable 'alpine_msix_domain_info' has initializer but incomplete type
>  static struct msi_domain_info alpine_msix_domain_info = {
>                ^~~~~~~~~~~~~~~
> drivers/irqchip/irq-alpine-msi.c:105:2: error: unknown field 'flags' specified in initializer
>   .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>   ^
> drivers/irqchip/irq-alpine-msi.c:105:11: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
>   .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>            ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> There is little reason to enable PCI support for a platform that
> uses MSI but then leaving MSI disabled at compile time.
> 
> I sent an earlier version that used 'select PCI_MSI' everywhere
> in March, but that caused build regressions on x86.
> 
> This version instead selects PCI_MSI from irqchips that implement MSI,
> and makes PCI host bridges that use MSI on ARM depend on PCI_MSI_IRQ_DOMAIN,
> which in turn is now enabled by default on all three architectures that
> support it, whenever MSI is enabled.
> 
> I think it makes most sense to merge this patch through the PCI tree,
> as new PCI host drivers get added occasionally, and they all need to
> be adapted for this change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I applied this to pci/msi, minus the crypto change that looks unrelated:

> @@ -1038,6 +1038,8 @@ source "arch/arm64/Kconfig.debug"
>  source "security/Kconfig"
>  
>  source "crypto/Kconfig"
> +if CRYPTO
>  source "arch/arm64/crypto/Kconfig"
> +endif
