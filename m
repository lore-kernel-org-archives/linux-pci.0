Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:37810 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754366AbeCGK6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 05:58:11 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: Joao.Pinto@synopsys.com, bhelgaas@google.com, jg1.han@samsung.com,
        lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 0/4] Code cleanup and small improvements
Date: Wed,  7 Mar 2018 10:57:56 +0000
Message-Id: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sets a callback that defines the maximum number of MSI applied to
designware driver for future easiness and also as an example, since
the callback currently defines the default value.

Does a code cleanup by replacing magic numbers without a easy meaning
by a well known define that helps the human compreension.

Fix of the first characters on comments and debug messages to maintain
coherency.

Replaces a division by 2 by a simple right shift rotation of 1 bit.

The patch set was made against Lorenzo's dwc-msi branch.

Gustavo Pimentel (4):
  PCI: dwc: designware: Define maximum number of vectors
  PCI: dwc: Replace lower into upper case characters in comments and
    debug printks
  PCI: dwc: Replace magic number by defines
  PCI: dwc: Replace division by 2 to right shift

 drivers/pci/dwc/pcie-designware-ep.c   | 16 +++----
 drivers/pci/dwc/pcie-designware-host.c | 77 +++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware-plat.c |  8 +++-
 drivers/pci/dwc/pcie-designware.c      | 22 +++++-----
 drivers/pci/dwc/pcie-designware.h      |  1 +
 5 files changed, 70 insertions(+), 54 deletions(-)

-- 
2.7.4
