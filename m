Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33043 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaDRMUC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:20:02 -0400
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
Subject: [PATCH 3/7] irqchip: armada-370-xp: Fix releasing of MSIs
Date: Fri, 18 Apr 2014 14:19:49 +0200
Message-Id: <1397823593-1932-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Neil Greatorex <neil@fatboyfat.co.uk>

Store the value of d->hwirq in a local variable as the real value is wiped out
by calling irq_dispose_mapping. Without this patch, the armada_370_xp_free_msi
function would always free MSI#0, no matter what was passed to it.

Fixes: 31f614edb726fcc4d5aa0f2895fbdec9b04a3ca4 ('irqchip: armada-370-xp: implement MSI support')
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 78b0ac9..868d11b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -158,8 +158,10 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 					   unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
+
 	irq_dispose_mapping(irq);
-	armada_370_xp_free_msi(d->hwirq);
+	armada_370_xp_free_msi(hwirq);
 }
 
 static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
-- 
1.9.2

