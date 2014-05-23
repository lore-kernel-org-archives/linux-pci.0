Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50099 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752283AbaEWQwg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 12:52:36 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, sthokal@xilinx.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v7 0/4] Support for Generic PCI Host Controller
Date: Fri, 23 May 2014 17:51:51 +0100
Message-Id: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

This is version 7 of the generic PCI host controller series that has
previously been posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229679.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/232213.html
  v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233491.html
  v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/235468.html
  v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237540.html
      http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252915.html
  v6: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253993.html

Changes since v6 include:

  - Removed redundant MIGHT_HAVE_PCI selections from multiplatform-enabled
    SoCs

  - Included patch from Srikanth for generic Configuration Space access to
    be factored out and used by other drivers

  - Fixed minor issue in I/O port allocation (I had a >= instead of a >)

All comments welcome,

Will


Srikanth Thokala (1):
  PCI: Generic Configuration Access Mechanism support

Will Deacon (3):
  ARM: kconfig: allow PCI support to be selected with ARCH_MULTIPLATFORM
  PCI: ARM: add support for generic PCI host controller
  MAINTAINERS: add entry for generic PCI host controller driver

 .../devicetree/bindings/pci/host-generic-pci.txt   | 100 ++++++
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/mach-bcm/Kconfig                          |   1 -
 arch/arm/mach-cns3xxx/Kconfig                      |   1 -
 arch/arm/mach-imx/Kconfig                          |   1 -
 arch/arm/mach-mvebu/Kconfig                        |   1 -
 arch/arm/mach-shmobile/Kconfig                     |   1 -
 arch/arm/mach-tegra/Kconfig                        |   1 -
 drivers/pci/Makefile                               |   2 +-
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 388 +++++++++++++++++++++
 drivers/pci/pci-cfg.c                              | 162 +++++++++
 include/linux/pci.h                                |  34 ++
 15 files changed, 702 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c
 create mode 100644 drivers/pci/pci-cfg.c

-- 
1.9.2

