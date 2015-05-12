Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49882 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964807AbbELVbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 May 2015 17:31:10 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: rjui@broadcom.com, bhelgaas@google.com, arnd@arndb.de
Cc: linux-pci@vger.kernel.org, sbranden@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, zajec5@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/2] PCI: iproc: add bcma PCIe 2.0 controller
Date: Tue, 12 May 2015 23:22:59 +0200
Message-Id: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After Ray submitted the PCIe controller for the iProc devices using 
pure device tree this adds support for the devices using bcma to scan 
the bus. This should replaces the driver I initially send for inclusion.

@Ray The driver found in the Broadcom SDK does some more stuff:
* setting up some DMA memory areas
* chaining MPS and MRRS to 512
* PHY changes:
 * "improving" the PCIe jitter 
 * some special initializations for the 3rd PCIe port

For me it works without these additions, but I haven't tested for 
performance or stability or 3rd port. Can you check if this is needed 
at all for the devices found on the market?

Hauke Mehrtens (2):
  PCI: iproc: make of_irq_parse_and_map_pci() configurable
  PCI: iproc: add bcma pcie driver

 drivers/pci/host/Kconfig               |  11 ++++
 drivers/pci/host/Makefile              |   1 +
 drivers/pci/host/pcie-iproc-bcma.c     | 112 +++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-iproc-platform.c |   2 +
 drivers/pci/host/pcie-iproc.c          |   2 +-
 drivers/pci/host/pcie-iproc.h          |   1 +
 6 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pcie-iproc-bcma.c

-- 
2.1.4

