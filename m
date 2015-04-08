Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:48467 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbDHSSk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 14:18:40 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v8 0/3] pci: iproc: Add Broadcom iProc PCIe support
Date: Wed, 8 Apr 2015 11:21:32 -0700
Message-ID: <1428517295-12825-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds the support for Broadcom iProc PCIe controller

pcie-iproc.c servers as the common core driver, and front-end bus
interface needs to be added to support different bus interfaces

pcie-iproc-pltfm.c contains the support for the platform bus interface

Changes from v7:
 - Consolidate iProc PCIe patches and rebase to v4.0-rc1 per request
   from Bjorn
 - Restrict CONFIG_PCIE_IPROC to ARM based platforms
 - Spell out 'pltfm' as 'platform'

Changes from v6:
 - Fix print formatting
 - Fix section mismatch warning by removing __init from the probe function
 - Fix Kconfig to force it only compiling for ARM based platforms

Changes from v5:
 - Sync code base to v4.0-rc2
 - Change export symbols of common PCI functions to GPL only
 - Add comment to describe how configuration register access are protected
   at the higher layer through 'pci_lock'
 - Use generic PCI functions for configuration register access and implement
   'map_bus' callback to support it
 - Move 'pci_fixup_irqs' to before devices are added to the bus
 - Remove 'extern' from function prototype declared in the header

Changes from v4:
 - iProc PCIe driver module support was not included in patch series v4.
   This patch series (v5) fixes it

Changes from v3:
 - Export symbols of several PCI functions so they can be used by drivers
   compiled as kernel module
 - Add additional support to the Broadcom iProc PCIe driver so it can be
   installed/uninstalled as kernel loadable module

Changes from v2:
 - Major rework of the PCIe driver to factor out common generic code from
   front-end bus interface. Support for generic platform bus interface is
   also added
 - Adapt to several new PCI APIs that have been introduced lately

Changes from v1:
 - Add standard PCI interrupt DT properties "#interrupt-cells",
   "interrupt-map-mask" and "interrupt-map" so legacy INTx interrupts can be
   supported by using standard PCI OF IRQ parsing function
 - Get rid of custom IRQ mapping function in the driver. Use
   of_irq_parse_and_map_pci instead

Ray Jui (3):
  PCI: Export symbols of PCI functions
  PCI: iproc: Add DT docs for Broadcom iProc PCIe driver
  pci: iproc: Add Broadcom iProc PCIe support

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   63 +++++
 drivers/pci/host/Kconfig                           |   19 ++
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pcie-iproc-platform.c             |  108 ++++++++
 drivers/pci/host/pcie-iproc.c                      |  268 ++++++++++++++++++++
 drivers/pci/host/pcie-iproc.h                      |   42 +++
 drivers/pci/pci.c                                  |    1 +
 drivers/pci/probe.c                                |    1 +
 drivers/pci/remove.c                               |    2 +
 drivers/pci/setup-bus.c                            |    1 +
 drivers/pci/setup-irq.c                            |    1 +
 11 files changed, 508 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 drivers/pci/host/pcie-iproc-platform.c
 create mode 100644 drivers/pci/host/pcie-iproc.c
 create mode 100644 drivers/pci/host/pcie-iproc.h

-- 
1.7.9.5

