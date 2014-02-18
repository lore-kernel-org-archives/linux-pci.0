Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55204 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208AbaBRMV3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 07:21:29 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 0/3] ARM: PCI: implement generic PCI host controller
Date: Tue, 18 Feb 2014 12:20:40 +0000
Message-Id: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This is version 3 of the patches previously posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229679.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/232213.html

Changes since v2 include:

  - Tightening up of the DT requirements:
    * Must have at least a non-prefetchable memory region
    * "reg" property now defines a base and size for config space
    * bus-range property supported and used in conjunction with "reg"
    * device_type must be "pci"

  - Fixed bus mapping so we don't sleep in atomic

  - Updated compatible strings and file names to get rid of "arm"

  - Added a really dumb I/O space allocator

  - Moved a bunch of ->probe() into ->setup(). Note that I've not included
    Arnd's patch to propagate ->setup() failures back to ->probe(), so despite
    the use of devm_* to manage resource allocations, I still have explicit
    cleanup code on the failure paths.

All feedback welcome.

Will


Will Deacon (3):
  ARM: mach-virt: allow PCI support to be selected
  ARM: bios32: use pci_enable_resource to enable PCI resources
  PCI: ARM: add support for generic PCI host controller

 .../devicetree/bindings/pci/host-generic-pci.txt   |  88 +++++
 arch/arm/kernel/bios32.c                           |  37 +-
 arch/arm/mach-virt/Kconfig                         |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 381 +++++++++++++++++++++
 6 files changed, 481 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c

-- 
1.8.2.2

