Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49327 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcJKM6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 08:58:47 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 0/4] PCI: designware/dra7xx: misc fixes and cleanups
Date: Tue, 11 Oct 2016 18:28:31 +0530
Message-ID: <1476190715-16884-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series was created on 4.8 Kernel after merging "pci/host-designware"
and "pci/host-dra7xx" of Bjorn's PCI tree.

The first patch fixes a compilation warning in designware code.

It is now possible to force the DRA7xx controller to work in GEN1 mode
using a dt property.

It includes a fix in dra7xx driver so that even if CONFIG_PCI_MSI is enabled,
dra7xx driver can service legacy interrupts (provided the device
support only legacy interrupts).

Kishon Vijay Abraham I (4):
  PCI: designware: Fix compiler warning
  PCI: dra7xx: simplify the probe code
  PCI: dra7xx: Add support to force RC to work in GEN1 mode
  PCI: dra7xx: Enable MSI and legacy interrupts simultaneously

 Documentation/devicetree/bindings/pci/ti-pci.txt |    1 +
 drivers/pci/host/pci-dra7xx.c                    |   80 +++++++++++++---------
 drivers/pci/host/pcie-designware.c               |   10 +--
 3 files changed, 49 insertions(+), 42 deletions(-)

-- 
1.7.9.5

