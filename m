Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:56458 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdLAGNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 01:13:24 -0500
From: Vignesh R <vigneshr@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chris Welch <Chris.Welch@viavisolutions.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/4] pci-dra7xx: Fix legacy IRQ handling and errata handling
Date: Fri, 1 Dec 2017 11:43:07 +0530
Message-ID: <20171201061311.16691-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series contains two fixes:
1. Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
2. Fix problem with handling of legacy INTD interrupts.

Tested on 66AK2G EVM and ICE boards


Vignesh R (4):
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  ARM: dts: dra7: Add DT property to allow unaligned mem access to PCIe
    RC
  PCI: dwc: pci-dra7xx: Fix legacy IRQ handling

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  2 ++
 drivers/pci/dwc/pci-dra7xx.c                     | 23 ++++++++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.15.0
