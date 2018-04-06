Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:59547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755370AbeDFOzm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Apr 2018 10:55:42 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
Date: Fri,  6 Apr 2018 16:55:30 +0200
Message-Id: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, Lorenzo,

This patch series brings a number of improvements to the aardvark
PCIe.

Changes since v3:

 - Introduced advk_pcie_valid_device() late in the series, so that the
   patch fixing the logic in the PCIe configuration space read/write
   function does not depend on it. This is needed as we don't want the
   advk_pcie_valid_device() addition to go to stable.

Changes since v2:

 - Rebased on v4.16-rc7

 - Dropped the patches disabling L0S and aligning the MPS between RC
   and EP, since we are working on a different solution, implementing
   a proper root port. Therefore, this patch series only has the
   (hopefully) non-controversial changes.

 - Add a patch (PATCH 1) that factorizes the logic to decide if the
   target of a configuration space access is a valid device or not
   into a advk_pcie_valid_device() helper, and adjust PATCH 2
   accordingly.

 - Drop unused PCIE_BDF macro in PATCH 3.

Best regards,

Thomas Petazzoni



Evan Wang (2):
  PCI: aardvark: Fix PCIe Max Read Request Size setting
  PCI: aardvark: Remove PCIe outbound window configuration

Thomas Petazzoni (1):
  PCI: aardvark: Introduce an advk_pcie_valid_device() helper

Victor Gu (3):
  PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
  PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
  PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

 drivers/pci/host/pci-aardvark.c | 117 ++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 78 deletions(-)

-- 
2.14.3
