Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44988 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729249AbeIRV1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 17:27:14 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <lorenzo.pieralisi@arm.com>
CC: <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 0/5] Add MSI-X support for cadence EP driver
Date: Tue, 18 Sep 2018 16:14:58 +0100
Message-ID: <1537283698-11169-1-git-send-email-adouglas@cadence.com>
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

Changes since v2:
  - Changes are only in 5/5 Add MSI-X capability to EP driver is changed
  - Use BAR4 instead of BAR5 for MSI-X vectors
  - Check that BAR4 has been initialized and is large enough, return
    -EINVAL if not
  - Use macros for MSIX & PBA table register offsets

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

 drivers/pci/controller/pcie-cadence-ep.c | 153 +++++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-cadence.h    |   7 ++
 2 files changed, 153 insertions(+), 7 deletions(-)

-- 
1.9.0
