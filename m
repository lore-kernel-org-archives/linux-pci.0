Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45513 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752914AbaEBQmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 12:42:09 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 0/3] Support for Generic PCI Host Controller
Date: Fri,  2 May 2014 17:41:13 +0100
Message-Id: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

This is a resend of the generic PCI host controller patch I last posted
in March:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237540.html

I've also included two additional patches to enable PCI for mach-virt
and add a MAINTAINERS entry for the new driver (Arnd -- I'm happy to add
you here as well if you like).

I've tested successfully on a 3.15-rc3-based kernel with kvmtool and would
really like to see this merged for 3.16.

All feedback welcome,

Will

Will Deacon (3):
  ARM: mach-virt: allow PCI support to be selected
  PCI: ARM: add support for generic PCI host controller
  MAINTAINERS: add entry for generic PCI host controller driver

 .../devicetree/bindings/pci/host-generic-pci.txt   | 100 ++++++
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 369 +++++++++++++++++++++
 6 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c

-- 
1.9.2

