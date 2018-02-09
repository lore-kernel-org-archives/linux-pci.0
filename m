Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] dra7xx: PCIe IRQ handling rework
Date: Fri, 9 Feb 2018 17:34:12 +0530
Message-ID: <20180209120415.17590-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series re-works dra7xx MSI IRQ handler to avoid issues of missing
of MSI IRQs and Legacy IRQs.

Tested on AM572 EVM with TUSB PCIe USB card and Intel PCIe WiFi cards.

Vignesh R (3):
  Revert "PCI: dwc: Clear MSI interrupt status after it is handled, not
    before"
  PCI: dwc: pci-dra7xx: Improve MSI IRQ handling
  PCI: dwc: pci-dra7xx: Handle legacy and MSI IRQs together

 drivers/pci/dwc/pci-dra7xx.c           | 32 +++++++++++++++++++++-----------
 drivers/pci/dwc/pcie-designware-host.c |  2 +-
 2 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.16.1
