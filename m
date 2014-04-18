Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33014 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbaDRMUA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:20:00 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/7] irqchip: armada-370-xp: fix invalid cast of signed value into unsigned variable
Date: Fri, 18 Apr 2014 14:19:47 +0200
Message-Id: <1397823593-1932-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The armada_370_xp_alloc_msi() function returns a signed int, which is
negative on error. However, we store the return value into an
irq_hw_number_t, which is unsigned. Therefore, we actually never test
if armada_370_xp_alloc_msi() returns an error or not, which may lead
us to use hwirq numbers of as 0xffffffe4 (when
armada_370_xp_alloc_msi() returns -ENOSPC).

This commit fixes that by storing the return value of
armada_370_xp_alloc_msi() in a signed variable.

Fixes: 31f614edb726fcc4d5aa0f2895fbdec9b04a3ca4 ('irqchip: armada-370-xp: implement MSI support')
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/irqchip/irq-armada-370-xp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 41be897..3c8d89b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -132,8 +132,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 				       struct msi_desc *desc)
 {
 	struct msi_msg msg;
-	irq_hw_number_t hwirq;
-	int virq;
+	int virq, hwirq;
 
 	hwirq = armada_370_xp_alloc_msi();
 	if (hwirq < 0)
-- 
1.9.2

