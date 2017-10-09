Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Roger Quadros <rogerq@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
Subject: [PATCH 0/2] phy: ti-pipe3: Update PCIe PHY settings
Date: Mon, 9 Oct 2017 14:33:36 +0530
Message-ID: <20171009090338.26033-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This was supposed to only update ti-pipe3 PHY registers. However because
of the way the ti-pipe3 PHY, OCP2SCP and PCIe controller are connected
in dra7xx where

PCIe controller --------------> ti-pipe3 PHY --------------> OCP2SCP
		  depends on		       depends on

updating ti-pipe3 PHY registers results in an abort.

Though the dependency between ti-pipe3 PHY and OCP2SCP is created
(OCP2SCP is parent of ti-pipe3 PHY), and enabling ti-pipe3 PHY clocks
should in turn enable OCP2SCP (with the help of pm_runtime framework),
this doesn't work in no_irq stage since pm_runtime is disabled during
no_irq stage. Since pci-dra7xx enables/initializes ti-pipe3 phy in
no_irq stage, OCP2SCP is not enabled resulting in an abort with ti-pipe3
PHY registers are accessed.

In order to solve this a functional dependency is created between
PCIe and ti-pipe3 PHY so that PCIe is suspended before PHY/OCP2SCP
and resumed after PCIe PHY/OCP2SCP

Kishon Vijay Abraham I (2):
  PCI: dwc: dra7xx: Create functional dependency between PCIe and PHY
  phy: ti-pipe3: Update pcie phy settings

 drivers/pci/dwc/pci-dra7xx.c  |  16 +++++++
 drivers/phy/ti/phy-ti-pipe3.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

-- 
2.11.0
