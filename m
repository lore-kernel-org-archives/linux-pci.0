Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0101.outbound.protection.outlook.com ([157.56.110.101]:44741
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753489AbbDOJrh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 05:47:37 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH] irqchip/gicv3-its: Decrease page size when needed
Date: Wed, 15 Apr 2015 17:49:22 +0800
Message-ID: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The default page size of ITS table has been changed to 64KB,
but for some platforms the real size of allocate memory which
calculated by DEVBITS of register GITS_TYPER may smaller than
default size. In this case, psz must be decreased, otherwise,
the wrong page number will cause kernel hang.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 596b0a9..d0374a6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -844,6 +844,9 @@ static int its_alloc_tables(struct its_node *its)
 
 		its->tables[i] = base;
 
+		while (alloc_size < psz)
+			psz = psz >> 1;
+
 retry_baser:
 		val = (virt_to_phys(base) 				 |
 		       (type << GITS_BASER_TYPE_SHIFT)			 |
-- 
1.9.1

