Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:36052 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeD0MAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 08:00:12 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 0/9] DesignWare EP support and code clean up
Date: Fri, 27 Apr 2018 12:59:55 +0100
Message-Id: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add DesignWare EP support.

Increase maximum number of interrupts allow for DesignWare IP controller.

Does a code cleanup on DesignWare driver, which involves:
 - Replacement of magic numbers by a self-explained define to ease human
comprehension.
 - Replacement a division by 2 operation for a right shift rotation of 1
bit.
 - Replacement of all initial lowercase character in comments and debug
messages to uppercase to maintain coherence.

Gustavo Pimentel (9):
  bindings: PCI: designware: Example update
  PCI: dwc: Add support for EP mode
  PCI: endpoint: functions/pci-epf-test: Add second entry
  bindings: PCI: designware: Add support for EP in DesignWare driver
  misc: pci_endpoint_test: Add DesignWare EP entry
  PCI: dwc: Define maximum number of vectors
  PCI: dwc: Replace lower into upper case characters
  PCI: dwc: Small computation improvement
  PCI: dwc: Replace magic number by defines

 .../PCI/endpoint/function/binding/pci-test.txt     |   2 +
 .../devicetree/bindings/pci/designware-pcie.txt    |  24 +++-
 drivers/misc/pci_endpoint_test.c                   |   1 +
 drivers/pci/dwc/Kconfig                            |  41 ++++--
 drivers/pci/dwc/pcie-designware-ep.c               |  16 +--
 drivers/pci/dwc/pcie-designware-host.c             |  77 +++++-----
 drivers/pci/dwc/pcie-designware-plat.c             | 155 +++++++++++++++++++--
 drivers/pci/dwc/pcie-designware.c                  |  22 +--
 drivers/pci/dwc/pcie-designware.h                  |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |   8 ++
 10 files changed, 267 insertions(+), 80 deletions(-)

-- 
2.7.4
