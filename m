Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:58155 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeDJM6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 08:58:50 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v3 00/10] Designware EP support and code clean up
Date: Tue, 10 Apr 2018 13:58:32 +0100
Message-Id: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch set was made against the Bjorn's next branch.

Adds support Designware EP support.

Increases the maximum number of interrupts allowed for Designware IP
controller.

Does a code cleanup on Designware driver:
 - Replaces magic numbers without a easy meaning by a well known define
   that helps the human compreension.
 - Replaces a division by 2 by a simple right shift rotation of 1 bit.
 - Fixes all first letter characters on comments and debug messages to
   upper case to maintain coherency.

Gustavo Pimentel (10):
  bindings: PCI: designware: Example update
  PCI: dwc: Add support for endpoint mode
  PCI: endpoint: functions/pci-epf-test: Add second entry
  bindings: PCI: designware: Add support for the EP in Designware driver
  PCI: Adds device ID for Synopsys Sample Endpoint.
  misc: pci_endpoint_test: Add designware EP entry
  PCI: dwc: Define maximum number of vectors
  PCI: dwc: Replace lower into upper case characters
  PCI: dwc: Small computation improvement
  PCI: dwc: Replace magic number by defines

 .../devicetree/bindings/pci/designware-pcie.txt    |  27 +++-
 drivers/misc/pci_endpoint_test.c                   |   1 +
 drivers/pci/dwc/Kconfig                            |  45 ++++--
 drivers/pci/dwc/pcie-designware-ep.c               |  16 +--
 drivers/pci/dwc/pcie-designware-host.c             |  77 +++++-----
 drivers/pci/dwc/pcie-designware-plat.c             | 159 +++++++++++++++++++--
 drivers/pci/dwc/pcie-designware.c                  |  22 +--
 drivers/pci/dwc/pcie-designware.h                  |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |   8 ++
 include/linux/pci_ids.h                            |   1 +
 10 files changed, 277 insertions(+), 80 deletions(-)

-- 
2.7.4
