Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:19728
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403758AbeHATAi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:38 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/3] Use xilinx controller irq for AER handler
Date: Wed, 1 Aug 2018 22:14:46 +0530
Message-ID: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
Error Interrupt Message Number. The controller has dedicated interrupt line
for reporting PCIe errors along with AER.

Since pcie-xilinx-nwl.c is platform driver and AER uses irq from
pci_dev, using struct device_node private data to save xilinx controller
error irq line. Using PCI quirks this data is passed to sysdata of
root port pci_dev which is retrieved and used for AER handler registration.


Bharat Kumar Gogada (3):
  PCI: xilinx-nwl: Save error IRQ number in device_node private data
  PCI: Use dedicated Xilinx controller irq number for AER
  PCI/portdrv: Add support for sharing xilinx controller irq with AER

 drivers/pci/controller/pcie-xilinx-nwl.c |    6 ++++++
 drivers/pci/pcie/portdrv_core.c          |    4 ++++
 drivers/pci/quirks.c                     |   29 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)
