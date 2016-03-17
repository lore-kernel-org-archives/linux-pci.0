Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Mar 2016 12:00:41 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm/arm64/irqchip/pci: select PCI_MSI instead of
 depending on it
Message-ID: <20160317120041.GG1184@io.lakedaemon.net>
References: <1458212069-896315-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458212069-896315-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 17, 2016 at 11:52:49AM +0100, Arnd Bergmann wrote:
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
> uses MSI but then leaving MSI disabled at compile time, so this
> patch changes the various Kconfig statement relating to PCI_MSI
> so they all use 'select'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thanks, Arnd!

Jason.
