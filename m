Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:34159
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbeEUW6m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 May 2018 18:58:42 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH v2 0/4] PCI: cadence: Host and EP driver updates for PHY and
 power management
Date: Mon, 21 May 2018 22:58:39 +0000
Message-ID: <SN6PR07MB451219710FAD2C0DD9FF05F9D8950@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series of patches for the cadence PCIe host and EP drivers, to:
 - Add optional list of generic PHYs to host and EP drivers
 - Add PHY bindings to devicetree
 - Add Power Management ops, which will enable/disable PHYs if present
- Update cdns_pcie_writel function signature

Changes in v2:
    Split commit into four patches
    Re-based on v4.17-rc1

Alan Douglas (4):
  PCI: cadence: Update cdns_pcie_writel function signature
  PCI: cadence: Add generic PHY support to host and EP drivers
  dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
  PCI: cadence: Add Power Management ops for host and EP

 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |   4 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |   2 +
 drivers/pci/cadence/pcie-cadence-ep.c              |  15 ++-
 drivers/pci/cadence/pcie-cadence-host.c            |  34 ++++++
 drivers/pci/cadence/pcie-cadence.c                 | 123 +++++++++++++++++=
++++
 drivers/pci/cadence/pcie-cadence.h                 |  13 ++-
 6 files changed, 189 insertions(+), 2 deletions(-)

--
