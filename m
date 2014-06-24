Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:50402
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753523AbaFXAdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Jun 2014 20:33:15 -0400
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 1/2] arm/gic: Add binding probe for GIC400
Date: Mon, 23 Jun 2014 19:32:59 -0500
Message-ID: <1403569980-12913-2-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Add new Irqchip declaration for GIC400. This was mentioned in
gic binding documentation, but there is not code to support it.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7e11c9d..adc86de 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1071,6 +1071,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	gic_cnt++;
 	return 0;
 }
+
+IRQCHIP_DECLARE(arm_gic_400, "arm,gic-400", gic_of_init);
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
-- 
1.9.0

