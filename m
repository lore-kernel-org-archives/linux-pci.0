Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v5 10/19] genirq: Add DOMAIN_BUS_NEXUS irqdomain property
Date: Thu, 23 Jul 2015 10:26:29 +0100
Message-Id: <1437643598-19795-11-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some IRQ domains are not designed to directly provide interrupts
to devices, but strictly to be used by other domains. An example
of this is the GICv3 ITS, which is completely bus agnostic, and
on which it is possible to device a PCI/MSI domain.

Just introduce the irq_domain_bus_token property for now.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b4a74f7..d3ca792 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -56,6 +56,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_ANY		= 0,
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_NEXUS,
 };
 
 /**
-- 
2.1.4

