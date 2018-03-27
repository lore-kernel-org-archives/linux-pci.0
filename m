Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:52104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeC0OJX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 10:09:23 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/6] PCI: aardvark: misc fixes and improvements
Date: Tue, 27 Mar 2018 16:08:13 +0200
Message-Id: <20180327140819.23501-8-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

This patch series brings a number of improvements to the aardvark
PCIe. Sorry for being so slow at sending the v3 after the v2 sent in
January. Hopefully this time around the series will be fine.

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
  PCI: aardvark: fix PCIe max read request size setting
  PCI: aardvark: remove PCIe outbound window configuration

Thomas Petazzoni (1):
  PCI: aardvark: introduce an advk_pcie_valid_device() helper

Victor Gu (3):
  PCI: aardvark: fix logic in advk_pcie_valid_device()
  PCI: aardvark: set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
  PCI: aardvark: use isr1 instead of isr0 interrupt in legacy irq mode

 drivers/pci/host/pci-aardvark.c | 117 ++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 78 deletions(-)

-- 
2.14.3
