Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40596 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965563AbeEXOgc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2018 10:36:32 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 0/6] PCI: rcar: Failpath fixes
Date: Thu, 24 May 2018 16:36:18 +0200
Message-Id: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple minor failpath fixes for the R-Car PCIe driver.

V4: Sync up the version numbers
    Rebase on top of Lorenzo's tree
    Add new patch fixing bug in the PHY code

Marek Vasut (6):
  PCI: rcar: Pull bus clock enable/disable from
    rcar_pcie_get_resources()
  PCI: rcar: Add missing irq_dispose_mapping() into failpath
  PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
  PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
  PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
  PCI: rcar: Shut the PHY down in failpath

 drivers/pci/host/pcie-rcar.c | 82 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 16 deletions(-)

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org

-- 
2.16.2
