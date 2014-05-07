Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47575 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933933AbaEGQIm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 12:08:42 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, sthokal@xilinx.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 0/3] Support for Generic PCI Host Controller
Date: Wed,  7 May 2014 17:07:16 +0100
Message-Id: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello again,

This is version 6 of the generic PCI host controller series that has
previously been posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/229679.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/232213.html
  v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233491.html
  v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/235468.html
  v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237540.html
      http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252915.html

Changes since v5 include:

  - Moved most of ->setup() into ->probe() (via two new function calls)

  - Improved cleanup (we can now rely on devm_* doing its job for us)

  - Moved Kconfig option under ARCH_MULTIPLATFORM

All feedback welcome.

Cheers,

Will


Will Deacon (3):
  ARM: kconfig: allow PCI support to be selected with ARCH_MULTIPLATFORM
  PCI: ARM: add support for generic PCI host controller
  MAINTAINERS: add entry for generic PCI host controller driver

 .../devicetree/bindings/pci/host-generic-pci.txt   | 100 ++++++
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 388 +++++++++++++++++++++
 6 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c

-- 
1.9.2

