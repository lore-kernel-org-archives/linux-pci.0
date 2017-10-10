Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:32506 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJJKQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2017 06:16:17 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
Subject: [PATCH 0/4] PCI: dwc: pci-dra7: Support PCIe x2 lane mode
Date: Tue, 10 Oct 2017 15:46:02 +0530
Message-ID: <20171010101606.15951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch series adds support to enable x2 lane mode in dra74/dra76
based boards in pci-dra7xx driver. It introduces new compatible strings
in order to enable x2 lane mode support.

x2 lane mode support for dra72 based boards will be added in a later
series.

patch series is created on top of https://lkml.org/lkml/2017/10/9/133.

Kishon Vijay Abraham I (4):
  dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
  dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
  PCI: dwc: dra7xx: Add support for SoC specific compatible strings
  PCI: dwc: pci-dra7xx: Enable x2 mode support

 Documentation/devicetree/bindings/pci/ti-pci.txt | 12 +++-
 drivers/pci/dwc/pci-dra7xx.c                     | 80 ++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 2 deletions(-)

-- 
2.11.0
