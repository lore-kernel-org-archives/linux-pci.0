Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.163.185] ([207.46.163.185]:10591 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757679AbaHHXUU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Aug 2014 19:20:20 -0400
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>
CC: <pawel.moll@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <tglx@linutronix.de>,
	<Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"Marc Zyngier" <Marc.Zyngier@arm.com>
Subject: [PATCH 2/4] irqchip: gic-v2m: Remove the matching name gic-400-v2m
Date: Fri, 8 Aug 2014 18:17:14 -0500
Message-ID: <1407539836-9768-3-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch remove the matching name gic-400-v2m.
It will use the "gic-400" instead

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-gic-v2m.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 94ed8d6..57b5a51 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -245,7 +245,4 @@ gicv2m_of_init(struct device_node *node, struct device_node *parent)
 
 	return gicv2m_msi_init(node, &gic->v2m_data);
 }
-
-IRQCHIP_DECLARE(arm_gic_400_v2m, "arm,gic-400-v2m", gicv2m_of_init);
-
 #endif /* CONFIG_OF */
-- 
1.9.0

