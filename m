Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32835 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751184AbdH1PZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 11:25:34 -0400
From: Jan Luebbe <jlu@pengutronix.de>
To: Gregory Clement <gregory.clement@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH 0/2] fix 4GB DRAM window support on mvebu
Date: Mon, 28 Aug 2017 17:25:15 +0200
Message-Id: <20170828152517.24506-1-jlu@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current MBUS DRAM window calculation fails for 4GB windows because it
overflows. This is fixed in the first patch by using u64 instead of u32 to
store the size. The second excplicitly checks that we don't try to configure a
too large memory window in the pci driver.

As they don't depend on each other, they could also go in separatly.

Jan Luebbe (2):
  bus: mbus: fix window size calculation for 4GB windows
  PCI: mvebu: Check DRAM window size

 drivers/bus/mvebu-mbus.c     |  2 +-
 drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
 include/linux/mbus.h         |  4 ++--
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.11.0
