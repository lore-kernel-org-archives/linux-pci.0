Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:30597
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJSPt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:49 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/4] Add support to register platform service IRQ
Date: Fri, 10 Aug 2018 21:09:36 +0530
Message-ID: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms have dedicated IRQ lines for PCIe services like
AER/PME etc. The root complex on these platform will use these seperate
IRQ lines to report AER/PME etc., interrupts and will not generate
MSI/MSI-X/INTx interrupts for these services.
These patches will add new method for these kind of platforms
to register the platform IRQ number with respective PCIe services.

Bharat Kumar Gogada (4):
  PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
  PCI: Add pci_check_platform_service_irqs
  PCI/portdrv: Check platform supported service IRQ's
  PCI: xilinx-nwl: Add method to setup_platform_service_irq hook

 drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
 drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
 include/linux/pci.h                      |   25 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)
