Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:31808
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753470AbaI1Uya (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 28 Sep 2014 16:54:30 -0400
From: <suravee.suthikulpanit@amd.com>
To: <will.deacon@arm.com>, <liviu.dudau@arm.com>,
	<marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<catalin.marinas@arm.com>, <jason@lakedaemon.net>,
	<tglx@linutronix.de>, <robh+dt@kernel.org>, <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC 0/4] Add PCI/MSI(x) support for AMD Seattle Platform
Date: Sun, 28 Sep 2014 15:53:26 -0500
Message-ID: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This is an RFC to introduce support for AMD Seattle ARM64 platform.

It is also intended to provide support for validating Liviu's PCI patch series:
    [PATCH v12 00/12] Support for creating generic PCI host bridges from DT
    https://lkml.org/lkml/2014/9/23/852

It is also intended to provide support for validating GICv2m patch series
(w/o multi-MSI).

Overview:

 * Patch 1 adds AMD Seattle device tree (w/ PCI and MSI support)

 * Patch 2-3) adds ARM64 and MSI support to the existing Generic PCI
   host controller.

 * Patch 4 comes from the GICv2m patch series: 
      [V8 2/2] irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)
      (https://lkml.org/lkml/2014/9/20/113)

   It has been slightly modified to remove the multi-MSI supports for now
   (awaiting discussion with other maintainers), and will be submitted
   separately.

Suravee Suthikulpanit (4):
  arm64: amd-seattle: Adding device tree for AMD Seattle platform
  PCI: generic: Add support for ARM64 and MSI(x)
  arm64: Do not call enable PCI resources when specify PCI_PROBE_ONLY
  irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt      |  53 ++++
 .../devicetree/bindings/pci/host-generic-pci.txt   |   3 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/amd-seattle-periph.dtsi        | 175 ++++++++++++
 arch/arm64/boot/dts/amd-seattle.dts                | 245 +++++++++++++++++
 arch/arm64/kernel/pci.c                            |   8 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-v2m.c                      | 301 +++++++++++++++++++++
 drivers/irqchip/irq-gic.c                          |  82 ++++--
 drivers/irqchip/irq-gic.h                          |  54 ++++
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pci-host-generic.c                |  95 ++++++-
 14 files changed, 986 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amd-seattle-periph.dtsi
 create mode 100644 arch/arm64/boot/dts/amd-seattle.dts
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.3

