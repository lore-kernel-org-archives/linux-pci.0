Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39384 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab2FKVJt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 17:09:49 -0400
Message-ID: <4FD65E98.4070200@wwwdotorg.org>
Date: Mon, 11 Jun 2012 15:09:44 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> This commit adds a platform device driver for the PCIe controller on
> Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> converted and now initialize and register a corresponding platform
> device.

> diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c

> +static struct resource tegra_pcie_resources[] = {
> +	[0] = {
> +		.start = TEGRA_PCIE_BASE,
> +		.end = TEGRA_PCIE_BASE + TEGRA_PCIE_SIZE - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = TEGRA_PCIE_MMIO_BASE,
> +		.end = TEGRA_PCIE_MMIO_BASE + TEGRA_PCIE_MMIO_SIZE - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[2] = {
> +		.start = INT_PCIE_INTR,
> +		.end = INT_PCIE_INTR,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};

I'm not sure those resources either cover all the necessary regions, nor
are as fine-grained as they should be ...

In particular, in pcie.c, I see separate afi_writel() and pads_writel()
implying those are separate regions.

Also, I see the following hard-code specific addresses, and are still
used by the driver after conversion:

> #define MEM_BASE_0              (TEGRA_PCIE_BASE + SZ_256M)
> #define MEM_SIZE_0              SZ_128M
> #define MEM_BASE_1              (MEM_BASE_0 + MEM_SIZE_0)
> #define MEM_SIZE_1              SZ_128M
> #define PREFETCH_MEM_BASE_0     (MEM_BASE_1 + MEM_SIZE_1)
> #define PREFETCH_MEM_SIZE_0     SZ_128M
> #define PREFETCH_MEM_BASE_1     (PREFETCH_MEM_BASE_0 + PREFETCH_MEM_SIZE_0)
> #define PREFETCH_MEM_SIZE_1     SZ_128M

Also, there's a comment describing the register layout in terms of a
number of separate regions:

> /*
>  * Tegra2 defines 1GB in the AXI address map for PCIe.
>  *
>  * That address space is split into different regions, with sizes and
>  * offsets as follows:
>  *
>  * 0x80000000 - 0x80003fff - PCI controller registers
>  * 0x80004000 - 0x80103fff - PCI configuration space
>  * 0x80104000 - 0x80203fff - PCI extended configuration space
>  * 0x80203fff - 0x803fffff - unused
>  * 0x80400000 - 0x8040ffff - downstream IO
>  * 0x80410000 - 0x8fffffff - unused
>  * 0x90000000 - 0x9fffffff - non-prefetchable memory
>  * 0xa0000000 - 0xbfffffff - prefetchable memory
>  */

(the latter 2 regions at least being also split in half for each of the
2 host ports)

Shouldn't each of these regions be a separate entry in the platform
device resources.

This perhaps isn't that relevant for Tegra20 alone, but Tegra30 supports
3 host ports instead of 2 (hence I presume alters the internal layout of
the 1G chunk of physical memory space allocated to PCIe), and moves the
PCIe area from 2G..3G to 0G..1G (so invalidates the hard-coded
*_MEM_BASE_* above).

That said, I'm not sure whether Tegra20's and Tegra30's PCIe controllers
are similar enough to make a shared driver worthwhile/possible.
(Although our downstream Android driver appears to handle both with a
very small number of ifdefs). If they are similar, then I think my
comments above should be addressed. If they are not similar, then I
think you can just have a single 1G memory region in the resources, and
split it up internally, rather than needing separate resources for
different parts of the address space.

While we can easily fix this kind of driver internals so this doesn't
seem like a big deal, this kind of change would impact the device tree
binding, so it seems that we need to sort it out before DT conversion.
