Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 6/8] of/irq: Use the msi-map property to provide device-specific MSI domain
Date: Tue,  6 Oct 2015 18:04:01 +0100
Message-Id: <1444151043-31084-7-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While msi-parent is used to point to the MSI controller that
works for all the devices behind a root complex, it doesn't
allow configurations where each individual device can be routed
to a separate MSI controller.

The msi-map property provides this flexibility (and much more),
so let's add a utility function that parses it, and return the
corresponding MSI domain.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/irq.c       | 18 ++++++++++++++++++
 include/linux/of_irq.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index ed64d98..0baf626d 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -689,6 +689,24 @@ static struct irq_domain *__of_get_msi_domain(struct device_node *np,
 }
 
 /**
+ * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
+ * @dev: device for which the mapping is to be done.
+ * @rid: Requester ID for the device.
+ *
+ * Walk up the device hierarchy looking for devices with a "msi-map"
+ * property.
+ *
+ * Returns: the MSI domain for this device (or NULL on failure)
+ */
+struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
+{
+	struct device_node *np = NULL;
+
+	__of_msi_map_rid(dev, &np, rid);
+	return __of_get_msi_domain(np, DOMAIN_BUS_PCI_MSI);
+}
+
+/**
  * of_msi_get_domain - Use msi-parent to find the relevant MSI domain
  * @dev: device for which the domain is requested
  * @np: device node for @dev
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 62ae6ed..65d9692 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -49,6 +49,8 @@ extern int of_irq_to_resource_table(struct device_node *dev,
 extern struct irq_domain *of_msi_get_domain(struct device *dev,
 					    struct device_node *np,
 					    enum irq_domain_bus_token token);
+extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
+						       u32 rid);
 #else
 static inline int of_irq_count(struct device_node *dev)
 {
@@ -73,6 +75,11 @@ static inline struct irq_domain *of_msi_get_domain(struct device *dev,
 {
 	return NULL;
 }
+static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
+							      u32 rid)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_OF)
-- 
2.1.4

