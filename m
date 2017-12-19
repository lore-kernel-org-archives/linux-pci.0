Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:33687 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933786AbdLSI6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 03:58:38 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v2 0/3] PCI: dra7xx: Support PCIe x2 lane mode
Date: Tue, 19 Dec 2017 14:28:20 +0530
Message-ID: <20171219085823.8695-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previous version of this series can be found here @ [1]

Patch series adds support to enable x2 lane mode in dra74/dra76 and
dra72 based boards in pci-dra7xx driver. It introduces new compatible
strings in order to enable x2 lane mode support.

Changes from v1:
*) Added ti prefix to syscon-lane-conf and syscon-lane-sel as
   suggested to Rob
*) Merged "PCI: dwc: dra7xx: Add support for SoC specific compatible
   strings" and "PCI: dwc: pci-dra7xx: Enable x2 mode support" into
   a single patch.
*) Fixed $subject as suggested by Bjorn
*) Added x2 lane mode support for DRA72x

The dts changes and phy changes will be sent as a separate series.

[1] -> https://lkml.org/lkml/2017/10/10/276

Kishon Vijay Abraham I (3):
  dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
  dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
  PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x

 Documentation/devicetree/bindings/pci/ti-pci.txt | 14 +++-
 drivers/pci/dwc/pci-dra7xx.c                     | 90 ++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.11.0
