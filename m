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
Subject: [PATCH v2 2/8] of/irq: Use of_msi_get_domain instead of open-coded "msi-parent" parsing
Date: Tue,  6 Oct 2015 18:03:57 +0100
Message-Id: <1444151043-31084-3-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have a function that implements the complexity of the
"msi-parent" property parsing, switch to that.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/irq.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 62cfdc2..89ebc61 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -580,26 +580,6 @@ err:
 }
 
 /**
- * of_msi_configure - Set the msi_domain field of a device
- * @dev: device structure to associate with an MSI irq domain
- * @np: device node for that device
- */
-void of_msi_configure(struct device *dev, struct device_node *np)
-{
-	struct device_node *msi_np;
-	struct irq_domain *d;
-
-	msi_np = of_parse_phandle(np, "msi-parent", 0);
-	if (!msi_np)
-		return;
-
-	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
-	if (!d)
-		d = irq_find_host(msi_np);
-	dev_set_msi_domain(dev, d);
-}
-
-/**
  * of_msi_map_rid - Map a MSI requester ID for a device.
  * @dev: device for which the mapping is to be done.
  * @msi_np: device node of the expected msi controller.
@@ -741,3 +721,14 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	return NULL;
 }
+
+/**
+ * of_msi_configure - Set the msi_domain field of a device
+ * @dev: device structure to associate with an MSI irq domain
+ * @np: device node for that device
+ */
+void of_msi_configure(struct device *dev, struct device_node *np)
+{
+	dev_set_msi_domain(dev,
+			   of_msi_get_domain(dev, np, DOMAIN_BUS_PLATFORM_MSI));
+}
-- 
2.1.4

