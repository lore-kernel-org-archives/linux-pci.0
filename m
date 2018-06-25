Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:56289
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753087AbeFYIbR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 04:31:17 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 0/5] PCI: cadence: Host and EP driver updates for PHY and power management
Date: Mon, 25 Jun 2018 09:30:48 +0100
Message-ID: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series of patches for the cadence PCIe host and EP drivers, to:
 - Add optional list of generic PHYs to host and EP drivers
 - Add PHY bindings to devicetree
 - Add Power Management ops, which will enable/disable PHYs if present
 - Add shutdown handler to host driver
 - Update cdns_pcie_writel function signature

Changes in v3:
	Use devm_phy_optional_get() to get optional PHY
	Updated decription in DT bindings to cover use of single/multiple PHYs
	Split patch to add shutdown callback in separate patch
	Re-based on v4.18-rc1

Changes in v2:
	Split commit into four patches
	Re-based on v4.17-rc1

Alan Douglas (5):
  PCI: cadence: Update cdns_pcie_writel function signature
  PCI: cadence: Add generic PHY support to host and EP drivers
  dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
  PCI: cadence: Add Power Management ops for host and EP
  PCI: cadence: Add shutdown callback to host driver

 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    5 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |    6 +
 drivers/pci/controller/pcie-cadence-ep.c           |   15 +++-
 drivers/pci/controller/pcie-cadence-host.c         |   33 +++++
 drivers/pci/controller/pcie-cadence.c              |  123 ++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h              |   13 ++-
 6 files changed, 193 insertions(+), 2 deletions(-)
