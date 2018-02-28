Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:35457 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbeB1OrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 09:47:14 -0500
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Omri Itach <omrii@marvell.com>,
        Hanna Hawa <hannah@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/2] PCI: armada8k: Fix clock resource for Armada 7K/8K
Date: Wed, 28 Feb 2018 15:47:02 +0100
Message-Id: <20180228144704.12947-1-gregory.clement@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This short series fixes the way the clocks are used for the PCIe host
controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
second one is needed in order to clock the registers. It was not
noticed until now because we relied on the bootloader and also because
the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

Gregory CLEMENT (2):
  PCI: armada8k: Remove useless test before clk_disable_unprepare
  PCI: armada8k: Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/pci/pci-armada8k.txt |  6 +++++-
 drivers/pci/dwc/pcie-armada8k.c                        | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.16.1
