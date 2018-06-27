Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41742 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934434AbeF0Mnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2018 08:43:50 -0400
From: Vignesh R <vigneshr@ti.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/4] pci-dra7xx: Enable errata i870 workaround for RC mode
Date: Wed, 27 Jun 2018 17:59:15 +0530
Message-ID: <20180627122919.23926-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf

Tested on DRA72 EVM

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v1: https://lkml.org/lkml/2017/12/1/59

Vignesh R (4):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
  ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
  ARM: dts: dra7: Fix up unaligned access setting for PCIe EP

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.0
