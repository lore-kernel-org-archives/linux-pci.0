Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:38851 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbaF2VFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Jun 2014 17:05:06 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
	rmk+kernel@arm.linux.org.uk, Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH 00/13] Remove mach-kirkwood and mach-dove
Date: Sun, 29 Jun 2014 22:59:47 +0200
Message-Id: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset removes arch/arm/mach-kirkwood and arch/arm/mach-dove.
These SoCs are now supported in arch/arm/mach-mvebu using device tree.

Change the dependencies for a number of drivers, either to use
ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and
MACH_DOVE where the drivers are specific to a SoC.


Andrew Lunn (13):
  ARM: Kirkwood: Remove mach-kirkwood
  ARM: Dove: Remove mach-dove
  sound: ASoC: kirkwood: Remove unused drivers
  sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
  cpuidle: kirkwood: Replace ARCH_KIRKWOOD dependency
  ata: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
  thermal: Replace ARCH_KIRKWOOD and ARCH_DOVE dependency
  leds: Replace ARCH_KIRKWOOD dependency
  PCI: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
  phy: Replace ARCH_KIRKWOOD and ARCH_DOVE dependency
  rtc: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
  watchdog: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
  Remove ARCH_DOVE dependency

 arch/arm/Kconfig                                  |  32 -
 arch/arm/Kconfig.debug                            |  10 +-
 arch/arm/Makefile                                 |   2 -
 arch/arm/boot/dts/Makefile                        |   5 +-
 arch/arm/configs/dove_defconfig                   | 146 -----
 arch/arm/configs/kirkwood_defconfig               | 181 ------
 arch/arm/mach-dove/Kconfig                        |  25 -
 arch/arm/mach-dove/Makefile                       |   5 -
 arch/arm/mach-dove/Makefile.boot                  |   3 -
 arch/arm/mach-dove/cm-a510.c                      |  97 ---
 arch/arm/mach-dove/common.c                       | 411 ------------
 arch/arm/mach-dove/common.h                       |  49 --
 arch/arm/mach-dove/dove-db-setup.c                | 103 ---
 arch/arm/mach-dove/include/mach/bridge-regs.h     |  57 --
 arch/arm/mach-dove/include/mach/dove.h            | 190 ------
 arch/arm/mach-dove/include/mach/entry-macro.S     |  33 -
 arch/arm/mach-dove/include/mach/hardware.h        |  19 -
 arch/arm/mach-dove/include/mach/irqs.h            |  96 ---
 arch/arm/mach-dove/include/mach/pm.h              |  72 ---
 arch/arm/mach-dove/include/mach/uncompress.h      |  36 --
 arch/arm/mach-dove/irq.c                          | 178 ------
 arch/arm/mach-dove/mpp.c                          | 162 -----
 arch/arm/mach-dove/mpp.h                          | 196 ------
 arch/arm/mach-dove/pcie.c                         | 220 -------
 arch/arm/mach-kirkwood/Kconfig                    | 111 ----
 arch/arm/mach-kirkwood/Makefile                   |  14 -
 arch/arm/mach-kirkwood/Makefile.boot              |   3 -
 arch/arm/mach-kirkwood/board-dt.c                 | 223 -------
 arch/arm/mach-kirkwood/common.c                   | 746 ----------------------
 arch/arm/mach-kirkwood/common.h                   |  74 ---
 arch/arm/mach-kirkwood/d2net_v2-setup.c           | 231 -------
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  86 ---
 arch/arm/mach-kirkwood/include/mach/entry-macro.S |  34 -
 arch/arm/mach-kirkwood/include/mach/hardware.h    |  14 -
 arch/arm/mach-kirkwood/include/mach/irqs.h        |  65 --
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    | 142 ----
 arch/arm/mach-kirkwood/include/mach/uncompress.h  |  46 --
 arch/arm/mach-kirkwood/irq.c                      |  82 ---
 arch/arm/mach-kirkwood/lacie_v2-common.c          | 114 ----
 arch/arm/mach-kirkwood/lacie_v2-common.h          |  16 -
 arch/arm/mach-kirkwood/mpp.c                      |  43 --
 arch/arm/mach-kirkwood/mpp.h                      | 348 ----------
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         | 422 ------------
 arch/arm/mach-kirkwood/openrd-setup.c             | 255 --------
 arch/arm/mach-kirkwood/pcie.c                     | 296 ---------
 arch/arm/mach-kirkwood/pm.c                       |  76 ---
 arch/arm/mach-kirkwood/pm.h                       |  26 -
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |  89 ---
 arch/arm/mach-kirkwood/rd88f6281-setup.c          | 128 ----
 arch/arm/mach-kirkwood/t5325-setup.c              | 216 -------
 arch/arm/mach-kirkwood/ts219-setup.c              | 142 ----
 arch/arm/mach-kirkwood/ts41x-setup.c              | 186 ------
 arch/arm/mach-kirkwood/tsx1x-common.c             | 113 ----
 arch/arm/mach-kirkwood/tsx1x-common.h             |   7 -
 arch/arm/mm/Kconfig                               |   2 +-
 drivers/ata/Kconfig                               |   4 +-
 drivers/cpuidle/Kconfig.arm                       |   2 +-
 drivers/leds/Kconfig                              |   4 +-
 drivers/mmc/host/Kconfig                          |   2 +-
 drivers/pci/host/Kconfig                          |   2 +-
 drivers/phy/Kconfig                               |   2 +-
 drivers/rtc/Kconfig                               |   2 +-
 drivers/thermal/Kconfig                           |   4 +-
 drivers/watchdog/Kconfig                          |   2 +-
 sound/soc/kirkwood/Kconfig                        |  19 +-
 sound/soc/kirkwood/Makefile                       |   4 -
 sound/soc/kirkwood/kirkwood-openrd.c              | 109 ----
 sound/soc/kirkwood/kirkwood-t5325.c               | 116 ----
 68 files changed, 20 insertions(+), 6930 deletions(-)
 delete mode 100644 arch/arm/configs/dove_defconfig
 delete mode 100644 arch/arm/configs/kirkwood_defconfig
 delete mode 100644 arch/arm/mach-dove/Kconfig
 delete mode 100644 arch/arm/mach-dove/Makefile
 delete mode 100644 arch/arm/mach-dove/Makefile.boot
 delete mode 100644 arch/arm/mach-dove/cm-a510.c
 delete mode 100644 arch/arm/mach-dove/common.c
 delete mode 100644 arch/arm/mach-dove/common.h
 delete mode 100644 arch/arm/mach-dove/dove-db-setup.c
 delete mode 100644 arch/arm/mach-dove/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-dove/include/mach/dove.h
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-dove/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-dove/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-dove/include/mach/pm.h
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-dove/irq.c
 delete mode 100644 arch/arm/mach-dove/mpp.c
 delete mode 100644 arch/arm/mach-dove/mpp.h
 delete mode 100644 arch/arm/mach-dove/pcie.c
 delete mode 100644 arch/arm/mach-kirkwood/Kconfig
 delete mode 100644 arch/arm/mach-kirkwood/Makefile
 delete mode 100644 arch/arm/mach-kirkwood/Makefile.boot
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
 delete mode 100644 arch/arm/mach-kirkwood/common.c
 delete mode 100644 arch/arm/mach-kirkwood/common.h
 delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/bridge-regs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/kirkwood.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-kirkwood/irq.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
 delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
 delete mode 100644 arch/arm/mach-kirkwood/mpp.c
 delete mode 100644 arch/arm/mach-kirkwood/mpp.h
 delete mode 100644 arch/arm/mach-kirkwood/netxbig_v2-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/openrd-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/pcie.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.c
 delete mode 100644 arch/arm/mach-kirkwood/pm.h
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/rd88f6281-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/t5325-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts219-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/ts41x-setup.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.c
 delete mode 100644 arch/arm/mach-kirkwood/tsx1x-common.h
 delete mode 100644 sound/soc/kirkwood/kirkwood-openrd.c
 delete mode 100644 sound/soc/kirkwood/kirkwood-t5325.c


Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org

-- 
2.0.0

