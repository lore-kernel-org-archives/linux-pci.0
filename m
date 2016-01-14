Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
	"Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 1/2] PCI support added to ARC
Date: Thu, 14 Jan 2016 05:26:58 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E84C55@us01wembx1.internal.synopsys.com>
References: <cover.1452611234.git.jpinto@synopsys.com>
 <24c9b782dfade515bbed20ce75d85200a00a2e66.1452611234.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+CC Arnd

On Tuesday 12 January 2016 09:15 PM, Joao Pinto wrote:
> This patch adds PCI support to ARC and updates drivers/pci Makefile
> enabling the ARC arch to use the generic PCI setup functions.
>
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Much better now. I have one small question below and if that is not contended fine
by me.

> diff --git a/arch/arc/kernel/pcibios.c b/arch/arc/kernel/pcibios.c
> new file mode 100644
> index 0000000..12ea45a
> --- /dev/null
> +++ b/arch/arc/kernel/pcibios.c
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/pci.h>
> +
> +/*
> + * We don't have to worry about legacy ISA devices, so nothing to do here
> + */
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +				resource_size_t size, resource_size_t align)
> +{
> +	return res->start;
> +}

Doesn't this have to be EXPORT_SYMBOL_xxx as well given that the call
(setup-res.c) can build as module ?

> +
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +}
> +EXPORT_SYMBOL(pcibios_fixup_bus);

EXPORT_SYMBOL_GPL ?

As a seperate enhancement, it would be nicer if these 2 functions are defined weak
in common code. That would make basic PCI support almost arch independent !

> diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
> index d475f9d..426ac4b 100644
> --- a/arch/arc/plat-axs10x/Kconfig
> +++ b/arch/arc/plat-axs10x/Kconfig
> @@ -11,6 +11,7 @@ menuconfig ARC_PLAT_AXS10X
>  	select DW_APB_ICTL
>  	select GPIO_DWAPB
>  	select OF_GPIO
> +	select MIGHT_HAVE_PCI
>  	select GENERIC_IRQ_CHIP
>  	select ARCH_REQUIRE_GPIOLIB
>  	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index be3f631..2154092 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>  # Some architectures use the generic PCI setup functions
>  #
>  obj-$(CONFIG_ALPHA) += setup-irq.o
> +obj-$(CONFIG_ARC) += setup-irq.o
>  obj-$(CONFIG_ARM) += setup-irq.o
>  obj-$(CONFIG_ARM64) += setup-irq.o
>  obj-$(CONFIG_UNICORE32) += setup-irq.o
