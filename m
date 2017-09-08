Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41977 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbdIHJyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2017 05:54:01 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Yehuda Yitschak <yehuday@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Evan Wang <xswang@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 6/7] PCI: aardvark: fix PCIe max read request size setting
Date: Fri,  8 Sep 2017 11:53:47 +0200
Message-Id: <20170908095348.16578-7-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
References: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Evan Wang <xswang@marvell.com>

There is an obvious typo issue in the definition of the PCIe maximum
read request size: a bit shift is directly used as a value, while it
should be used to shift the correct value.

This is part of fixing bug
https://bugzilla.kernel.org/show_bug.cgi?id=196339, this commit was
reported as the user to be important to get a Intel 7260 mini-PCIe
WiFi card working.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 461517a87eca..6d6a2ae35481 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -33,6 +33,7 @@
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ		0x2
 #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
+#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
 #define     PCIE_CORE_MPS_UNIT_BYTE				128
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
@@ -304,7 +305,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		(PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ <<
 		 PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
+		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
+		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
-- 
2.13.5
