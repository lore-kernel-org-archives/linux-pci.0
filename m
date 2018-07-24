Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43976 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXSih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2018 14:38:37 -0400
From: Vignesh R <vigneshr@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC mode
Date: Tue, 24 Jul 2018 23:01:46 +0530
Message-ID: <20180724173150.2701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf

Tested on DRA72 EVM

Tony,

If you are okay with the series, could you pick this via omap tree?
All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
rest of DTS changes.

Regards
Vignesh


Changes since v2:
Reorder patch 2 to appear at the last.
Collect all the ACKs

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v2: https://patchwork.ozlabs.org/cover/935454/
v1: https://lkml.org/lkml/2017/12/1/59


Vignesh R (4):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
  ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.0
