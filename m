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
Subject: [PATCH v2 1/8] of/irq: Add support code for multi-parent version of "msi-parent"
Date: Tue,  6 Oct 2015 18:03:56 +0100
Message-Id: <1444151043-31084-2-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since 126b16e2ad98 ("Docs: dt: add generic MSI bindings"),
the definition of "msi-parent" has evolved, while maintaining
some degree of compatibility. It can now express multiple MSI
controllers as parents, as well as some sideband data being
communicated to the controller.

This patch adds the parsing of the property, iterating over
the multiple parents until a suitable irqdomain is found.
It can also fallback to the original parsing if the old
binding is detected.

This support code gets used in the subsequent patches.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/irq.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_irq.h |  9 ++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c90bd4e..62cfdc2 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -682,3 +682,62 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
 
 	return rid_out;
 }
+
+static struct irq_domain *__of_get_msi_domain(struct device_node *np,
+					      enum irq_domain_bus_token token)
+{
+	struct irq_domain *d;
+
+	d = irq_find_matching_host(np, token);
+	if (!d)
+		d = irq_find_host(np);
+
+	return d;
+}
+
+/**
+ * of_msi_get_domain - Use msi-parent to find the relevant MSI domain
+ * @dev: device for which the domain is requested
+ * @np: device node for @dev
+ * @token: bus type for this domain
+ *
+ * Parse the msi-parent property (both the simple and the complex
+ * versions), and returns the corresponding MSI domain.
+ *
+ * Returns: the MSI domain for this device (or NULL on failure).
+ */
+struct irq_domain *of_msi_get_domain(struct device *dev,
+				     struct device_node *np,
+				     enum irq_domain_bus_token token)
+{
+	struct device_node *msi_np;
+	struct irq_domain *d;
+
+	/* Check for a single msi-parent property */
+	msi_np = of_parse_phandle(np, "msi-parent", 0);
+	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells")) {
+		d = __of_get_msi_domain(msi_np, token);
+		if (!d)
+			of_node_put(msi_np);
+		return d;
+	}
+
+	if (token == DOMAIN_BUS_PLATFORM_MSI) {
+		/* Check for the complex msi-parent version */
+		struct of_phandle_args args;
+		int index = 0;
+
+		while (!of_parse_phandle_with_args(np, "msi-parent",
+						   "#msi-cells",
+						   index, &args)) {
+			d = __of_get_msi_domain(args.np, token);
+			if (d)
+				return d;
+
+			of_node_put(args.np);
+			index++;
+		}
+	}
+
+	return NULL;
+}
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 8cd9334..62ae6ed 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -46,6 +46,9 @@ extern int of_irq_get(struct device_node *dev, int index);
 extern int of_irq_get_byname(struct device_node *dev, const char *name);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
+extern struct irq_domain *of_msi_get_domain(struct device *dev,
+					    struct device_node *np,
+					    enum irq_domain_bus_token token);
 #else
 static inline int of_irq_count(struct device_node *dev)
 {
@@ -64,6 +67,12 @@ static inline int of_irq_to_resource_table(struct device_node *dev,
 {
 	return 0;
 }
+static inline struct irq_domain *of_msi_get_domain(struct device *dev,
+						   struct device_node *np,
+						   enum irq_domain_bus_token token)
+{
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_OF)
-- 
2.1.4

