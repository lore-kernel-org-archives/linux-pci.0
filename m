Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:54048
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEVN05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:26:57 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [RESEND PATCH 0/4] PCI: cadence: Host and EP driver updates for PHY and power management
Date: Tue, 22 May 2018 14:26:09 +0100
Message-ID: <1526995569-5481-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 drivers/pci/cadence/pcie-cadence.c                 | 123 +++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.h                 |  13 ++-
 6 files changed, 189 insertions(+), 2 deletions(-)

-- 
2.2.2
