Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41461 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab2CHPWI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:22:08 -0500
Message-ID: <4F58CE9D.3070605@gmail.com>
Date: Thu, 08 Mar 2012 09:22:05 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 00/11] ARM: tegra: Add PCIe device tree support
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 08:51 AM, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.
> 
> Patches 1 and 2 have already been posted by Grant and Mark respectively
> but I've included them here for reference. Both patches are dependencies
> for the subsequent patches.
> 
> Patches 3, 4 and 5 add support for obtaining the regulators required to
> power the PCIe controller from the device tree. Patches 6 and 7 are
> required to make some common PCI functions available after the init
> phase because the deferred probing will postpone the probing of the PCIe
> controller driver until that point.
> 
> Patches 8 and 9 make the PCIe controller code available as a driver and
> add the corresponding platform devices to the boards that enable PCIe
> (Harmony and TrimSlice). Patch 10 adds MSI support and patch 11 finally
> adds a device tree binding with documentation.
> 
> The code in patch 10 (MSI support) is based on the Vibrante kernel and I
> wasn't able to get a proper Signed-off-by or even copyright information.
> Perhaps somebody at NVIDIA can find out?
> 
> Thierry
> 
> Grant Likely (1):
>   drivercore: Add driver probe deferral mechanism
> 
> Mark Brown (1):
>   regulator: Support driver probe deferral
> 
> Thierry Reding (9):
>   regulator: fixed: Support driver probe deferral
>   regulator: tps6586x: fix typo in debug message
>   tps6586x: Add device-tree support
>   PCI: Keep pci_fixup_irqs() around after init
>   ARM: pci: Keep pci_common_init() around after init
>   ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
>   ARM: tegra: Rewrite PCIe support as a driver
>   ARM: tegra: pcie: Add MSI support
>   ARM: tegra: pcie: Add device tree support
> 
>  .../devicetree/bindings/pci/tegra-pcie.txt         |   23 +
>  .../devicetree/bindings/regulator/tps6586x.txt     |   98 +++
>  arch/arm/boot/dts/tegra20.dtsi                     |    8 +
>  arch/arm/kernel/bios32.c                           |    4 +-
>  arch/arm/mach-tegra/Kconfig                        |    1 +
>  arch/arm/mach-tegra/board-harmony-pcie.c           |   38 +-
>  arch/arm/mach-tegra/board-harmony.c                |    1 +
>  arch/arm/mach-tegra/board-harmony.h                |    1 +
>  arch/arm/mach-tegra/board-trimslice.c              |   16 +-
>  arch/arm/mach-tegra/board.h                        |   11 +-
>  arch/arm/mach-tegra/devices.c                      |   32 +
>  arch/arm/mach-tegra/devices.h                      |    1 +
>  arch/arm/mach-tegra/include/mach/iomap.h           |    6 +
>  arch/arm/mach-tegra/include/mach/irqs.h            |    5 +-
>  arch/arm/mach-tegra/pcie.c                         |  895 +++++++++++++++-----
>  arch/arm/mach-tegra/pmc.c                          |   16 +
>  arch/arm/mach-tegra/pmc.h                          |    1 +
>  drivers/base/base.h                                |    1 +
>  drivers/base/core.c                                |    2 +
>  drivers/base/dd.c                                  |  138 ++-
>  drivers/mfd/tps6586x.c                             |   66 ++
>  drivers/pci/setup-irq.c                            |    4 +-
>  drivers/regulator/core.c                           |    4 +-
>  drivers/regulator/fixed.c                          |   14 +-
>  drivers/regulator/tps6586x-regulator.c             |    4 +-
>  include/linux/device.h                             |    5 +
>  include/linux/errno.h                              |    1 +
>  include/linux/mfd/tps6586x.h                       |    1 +
>  28 files changed, 1136 insertions(+), 261 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/tegra-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt

There is a whole bunch of PCI DT code sitting in the powerpc tree that
probably needs to be moved to common location and used here.

This looks way too simple to be what's needed if I compare to PCI
bindings in powerpc dts files.

Rob
