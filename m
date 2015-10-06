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
Subject: [PATCH v2 5/8] of/irq: Split of_msi_map_rid to reuse msi-map lookup
Date: Tue,  6 Oct 2015 18:04:00 +0100
Message-Id: <1444151043-31084-6-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The msi-map property is also used to identify the MSI controller
as a form of grown-up msi-parent property.

Looking it up is complicated enough, and since of_msi_map_rid
already implements this, let's turn it into an internal utility
function. We'll put that to good use later on.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/irq.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 89ebc61..ed64d98 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -579,21 +579,12 @@ err:
 	}
 }
 
-/**
- * of_msi_map_rid - Map a MSI requester ID for a device.
- * @dev: device for which the mapping is to be done.
- * @msi_np: device node of the expected msi controller.
- * @rid_in: unmapped MSI requester ID for the device.
- *
- * Walk up the device hierarchy looking for devices with a "msi-map"
- * property.  If found, apply the mapping to @rid_in.
- *
- * Returns the mapped MSI requester ID.
- */
-u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
+static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
+			    u32 rid_in)
 {
 	struct device *parent_dev;
 	struct device_node *msi_controller_node;
+	struct device_node *msi_np = *np;
 	u32 map_mask, masked_rid, rid_base, msi_base, rid_len, phandle;
 	int msi_map_len;
 	bool matched;
@@ -643,9 +634,15 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
 
 		msi_controller_node = of_find_node_by_phandle(phandle);
 
-		matched = masked_rid >= rid_base &&
-			masked_rid < rid_base + rid_len &&
-			msi_np == msi_controller_node;
+		matched = (masked_rid >= rid_base &&
+			   masked_rid < rid_base + rid_len);
+		if (msi_np)
+			matched &= msi_np == msi_controller_node;
+
+		if (matched && !msi_np) {
+			*np = msi_np = msi_controller_node;
+			break;
+		}
 
 		of_node_put(msi_controller_node);
 		msi_map_len -= 4 * sizeof(__be32);
@@ -663,6 +660,22 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
 	return rid_out;
 }
 
+/**
+ * of_msi_map_rid - Map a MSI requester ID for a device.
+ * @dev: device for which the mapping is to be done.
+ * @msi_np: device node of the expected msi controller.
+ * @rid_in: unmapped MSI requester ID for the device.
+ *
+ * Walk up the device hierarchy looking for devices with a "msi-map"
+ * property.  If found, apply the mapping to @rid_in.
+ *
+ * Returns the mapped MSI requester ID.
+ */
+u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
+{
+	return __of_msi_map_rid(dev, &msi_np, rid_in);
+}
+
 static struct irq_domain *__of_get_msi_domain(struct device_node *np,
 					      enum irq_domain_bus_token token)
 {
-- 
2.1.4

