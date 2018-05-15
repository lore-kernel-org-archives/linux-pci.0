Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:42925 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeEOOlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 10:41:50 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 0/4] Add DesignWare EP support
Date: Tue, 15 May 2018 15:41:40 +0100
Message-Id: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch set was made against the Lorenzo's pci/dwc branch.

The PCIe controller dual mode is capable of operating in RC mode as well
as EP mode by configuration option. Till now only RC mode was supported,
with this patch is add EP support to the DesignWare driver.

Gustavo Pimentel (4):
  bindings: PCI: designware: Example update
  PCI: dwc: Add support for EP mode
  bindings: PCI: designware: Add support for EP in DesignWare driver
  misc: pci_endpoint_test: Add DesignWare EP entry

 .../devicetree/bindings/pci/designware-pcie.txt    |  24 +++-
 drivers/misc/pci_endpoint_test.c                   |   1 +
 drivers/pci/dwc/Kconfig                            |  37 +++--
 drivers/pci/dwc/pcie-designware-ep.c               |   3 +
 drivers/pci/dwc/pcie-designware-plat.c             | 149 +++++++++++++++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c      |   7 +
 include/linux/pci-epc.h                            |   8 ++
 7 files changed, 205 insertions(+), 24 deletions(-)

-- 
2.7.4
