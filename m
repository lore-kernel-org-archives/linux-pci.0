Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <tglx@linutronix.de>,
	<jason@lakedaemon.net>, <rjw@rjwysocki.net>, <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	<hanjun.guo@linaro.org>, <tomasz.nowicki@linaro.org>,
	<graeme.gregory@linaro.org>, <dhdang@apm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>,
	"Suravee Suthikulpanit" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v7 2/4] irqdomain: introduce is_fwnode_irqchip helper
Date: Thu, 10 Dec 2015 08:55:28 -0800
Message-ID: <1449766530-16935-3-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since there will be several places checking if fwnode.type
is equal FWNODE_IRQCHIP, this patch adds a convenient function
for this purpose.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c | 2 +-
 include/linux/irqdomain.h | 5 +++++
 kernel/irq/irqdomain.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index abf2ffa..fcd327f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -972,7 +972,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		return 0;
 	}
 
-	if (fwspec->fwnode->type == FWNODE_IRQCHIP) {
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a06feda..d72fabc 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -211,6 +211,11 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 	return node ? &node->fwnode : NULL;
 }
 
+static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_IRQCHIP;
+}
+
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..7f34d98 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -70,7 +70,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(fwnode->type != FWNODE_IRQCHIP))
+	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
-- 
2.1.0

