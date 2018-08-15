Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0072.outbound.protection.outlook.com ([104.47.37.72]:55603
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729363AbeHOQjX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Aug 2018 12:39:23 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2 0/5] Add MSI-X support for cadence EP driver
Date: Wed, 15 Aug 2018 14:46:21 +0100
Message-ID: <1534340781-19194-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch implements MSI-X support in the cadence endpoint driver.

This patch depends on on Gustavo Pimentel's patch series adding MSI-X
support for EP ("Add MSI-X support on pcitest tool") 

It also adds fixes for MSI issues discovered during testing of MSI-X
  - Use AXI region 0 for interrupt signalling
  - Write MSI and MSI-X with 32bit value rather than 16bit
  - Check for masking before sending MSI or MSI-X
  - Check link is up before sending IRQ

Changes since v1:
  - Rebased on 4.18-rc1
  - Update commit log to mark first 4 patches as fixes
  - Correct formatting issues pointed out by checkpatch --strict

Alan Douglas (5):
  PCI: cadence: Use AXI region 0 to signal interrupts from EP
  PCI: cadence: Write MSI data with 32bits
  PCI: cadence: Check whether MSI is masked before sending it
  PCI: cadence: Check link is up before sending IRQ from EP
  PCI: cadence: Add MSI-X capability to EP driver

 drivers/pci/controller/pcie-cadence-ep.c | 131 +++++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-cadence.h    |   1 +
 2 files changed, 125 insertions(+), 7 deletions(-)

-- 
1.9.0
