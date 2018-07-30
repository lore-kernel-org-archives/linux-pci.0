Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:42108
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeG3S5l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 14:57:41 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 0/5] Add MSI-X support for cadence EP driver
Date: Mon, 30 Jul 2018 18:21:00 +0100
Message-ID: <1532971260-5269-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch series made against Bjorn Helgaas's pci next branch.
It relies on Gustavo Pimentel's patch series adding MSI-X
support in the PCIe EP driver framework, and implements
MSI-X support for the cadence endpoint driver.
 - Use AXI region 0 for interrupt signalling
 - Write MSI and MSI-X with 32bit value rather than 16bit
 - Check for masking before sending MSI or MSI-X
 - Check link is up before sending IRQ
 - Use BAR5 for MSI-X vectors

Alan Douglas (5):
  PCI: cadence: Use AXI region 0 to signal interrupts from EP
  PCI: cadence: Write MSI data with 32bits
  PCI: cadence: Check whether MSI is masked before sending it
  PCI: cadence: Check link is up before sending IRQ from EP
  PCI: cadence: Add MSI-X capability to EP driver

 drivers/pci/controller/pcie-cadence-ep.c |  129 ++++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-cadence.h    |    1 +
 2 files changed, 124 insertions(+), 6 deletions(-)
