Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/2] pci-dra7xx: Fix legacy IRQ handling
Date: Fri, 29 Dec 2017 17:11:29 +0530
Message-ID: <20171229114131.22296-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes couple of issues wrt PCIe legacy IRQ handling on
dra7xx platforms.

Tested on DRA74 EVM.

Changes in v2:
 * Drop patches related to errata i870 handling. That will be posted
   separately later.
 * Split INTD IRQ handling into separate patch.

v1: https://lkml.org/lkml/2017/12/1/59

Vignesh R (2):
  PCI: dra7xx: Fix legacy INTD IRQ handling
  PCI: dra7xx: Iterate over INTx status bits

 drivers/pci/dwc/pci-dra7xx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.15.1
