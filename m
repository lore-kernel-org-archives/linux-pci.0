Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62313 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752204AbaGMV76 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Jul 2014 17:59:58 -0400
Date: Sun, 13 Jul 2014 17:59:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Bryan Wu <cooloney@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Remove mach-kirkwood
Message-ID: <20140713215924.GG13108@titan.lakedaemon.net>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All driver/sub-system maintainers:

On Thu, Jul 10, 2014 at 11:36:20PM +0200, Andrew Lunn wrote:
> This patchset removes arch/arm/mach-kirkwood.  This SoCs is now
> supported in arch/arm/mach-mvebu using device tree.
> 
> V1 of this patchset also removed mach-dove. However it has been
> decided to leave it alone for a while to aid some developers get out
> of tree patches merged.
>                                                                          
> Change the dependencies for a number of drivers, either to use
> ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and where
> the drivers are specific to the SoC.
> 
> Once Jason Cooper has Acked these patches, we would prefer that
> individual subsystem maintainers take these patches through their own
> trees.
> 
> Thanks
> 	Andrew
> 
> Andrew Lunn (12):
>   ARM: Kirkwood: Remove mach-kirkwood
>   ARM: Kirkwood: Remove kirkwood_defconfig
>   ASoC: kirkwood: Remove unused drivers
>   ASoC: kirkwood: Remove ARCH_KIRKWOOD dependency
>   cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
>   ata: Remove ARCH_KIRKWOOD dependency
>   thermal: Remove ARCH_KIRKWOOD dependency
>   leds: Remove ARCH_KIRKWOOD dependency
>   PCI: Remove ARCH_KIRKWOOD dependency
>   phy: Remove ARCH_KIRKWOOD dependency
>   rtc: Remove ARCH_KIRKWOOD dependency
>   watchdog: Remove ARCH_KIRKWOOD dependency
> 
>  arch/arm/Kconfig                                  |  18 -
>  arch/arm/Kconfig.debug                            |   6 +-
>  arch/arm/Makefile                                 |   1 -
>  arch/arm/boot/dts/Makefile                        |   5 +-
>  arch/arm/configs/kirkwood_defconfig               | 181 ------
>  arch/arm/mach-kirkwood/Kconfig                    | 111 ----
>  arch/arm/mach-kirkwood/Makefile                   |  14 -
>  arch/arm/mach-kirkwood/Makefile.boot              |   3 -
>  arch/arm/mach-kirkwood/board-dt.c                 | 223 -------
>  arch/arm/mach-kirkwood/common.c                   | 746 ----------------------
>  arch/arm/mach-kirkwood/common.h                   |  74 ---
>  arch/arm/mach-kirkwood/d2net_v2-setup.c           | 231 -------
>  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  86 ---
>  arch/arm/mach-kirkwood/include/mach/entry-macro.S |  34 -
>  arch/arm/mach-kirkwood/include/mach/hardware.h    |  14 -
>  arch/arm/mach-kirkwood/include/mach/irqs.h        |  65 --
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h    | 142 ----
>  arch/arm/mach-kirkwood/include/mach/uncompress.h  |  46 --
>  arch/arm/mach-kirkwood/irq.c                      |  82 ---
>  arch/arm/mach-kirkwood/lacie_v2-common.c          | 114 ----
>  arch/arm/mach-kirkwood/lacie_v2-common.h          |  16 -
>  arch/arm/mach-kirkwood/mpp.c                      |  43 --
>  arch/arm/mach-kirkwood/mpp.h                      | 348 ----------
>  arch/arm/mach-kirkwood/netxbig_v2-setup.c         | 422 ------------
>  arch/arm/mach-kirkwood/openrd-setup.c             | 255 --------
>  arch/arm/mach-kirkwood/pcie.c                     | 296 ---------
>  arch/arm/mach-kirkwood/pm.c                       |  76 ---
>  arch/arm/mach-kirkwood/pm.h                       |  26 -
>  arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |  89 ---
>  arch/arm/mach-kirkwood/rd88f6281-setup.c          | 128 ----
>  arch/arm/mach-kirkwood/t5325-setup.c              | 216 -------
>  arch/arm/mach-kirkwood/ts219-setup.c              | 142 ----
>  arch/arm/mach-kirkwood/ts41x-setup.c              | 186 ------
>  arch/arm/mach-kirkwood/tsx1x-common.c             | 113 ----
>  arch/arm/mach-kirkwood/tsx1x-common.h             |   7 -
>  arch/arm/mm/Kconfig                               |   2 +-
>  drivers/ata/Kconfig                               |   2 +-
>  drivers/cpuidle/Kconfig.arm                       |   2 +-
>  drivers/leds/Kconfig                              |   4 +-
>  drivers/pci/host/Kconfig                          |   2 +-
>  drivers/phy/Kconfig                               |   2 +-
>  drivers/rtc/Kconfig                               |   2 +-
>  drivers/thermal/Kconfig                           |   2 +-
>  drivers/watchdog/Kconfig                          |   2 +-
>  sound/soc/kirkwood/Kconfig                        |  19 +-
>  sound/soc/kirkwood/Makefile                       |   4 -
>  sound/soc/kirkwood/kirkwood-openrd.c              | 109 ----
>  sound/soc/kirkwood/kirkwood-t5325.c               | 116 ----
>  48 files changed, 14 insertions(+), 4813 deletions(-)
>  delete mode 100644 arch/arm/configs/kirkwood_defconfig
>  delete mode 100644 arch/arm/mach-kirkwood/Kconfig
>  delete mode 100644 arch/arm/mach-kirkwood/Makefile
>  delete mode 100644 arch/arm/mach-kirkwood/Makefile.boot
>  delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
>  delete mode 100644 arch/arm/mach-kirkwood/common.c
>  delete mode 100644 arch/arm/mach-kirkwood/common.h
>  delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/bridge-regs.h
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/kirkwood.h
>  delete mode 100644 arch/arm/mach-kirkwood/include/mach/uncompress.h
>  delete mode 100644 arch/arm/mach-kirkwood/irq.c
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
>  delete mode 100644 arch/arm/mach-kirkwood/mpp.c
>  delete mode 100644 arch/arm/mach-kirkwood/mpp.h
>  delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/openrd-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/pcie.c
>  delete mode 100644 arch/arm/mach-kirkwood/pm.c
>  delete mode 100644 arch/arm/mach-kirkwood/pm.h
>  delete mode 100644 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/rd88f6281-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/t5325-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/ts219-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/ts41x-setup.c
>  delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.c
>  delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.h
>  delete mode 100644 sound/soc/kirkwood/kirkwood-openrd.c
>  delete mode 100644 sound/soc/kirkwood/kirkwood-t5325.c

For all the driver changes:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
