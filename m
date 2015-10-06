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
Subject: [PATCH v2 4/8] irqchip/gic-v3-its: Parse new version of msi-parent property
Date: Tue,  6 Oct 2015 18:03:59 +0100
Message-Id: <1444151043-31084-5-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that 126b16e2ad98 ("Docs: dt: add generic MSI bindings")
has made it into the tree, the time has come to get rid of the
old hack, and to parse msi-parent in its full glory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index a865505..589a532 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -29,13 +29,25 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
-	int ret;
+	int ret, index = 0;
 
 	msi_info = msi_get_domain_info(domain->parent);
 
 	/* Suck the DeviceID out of the msi-parent property */
-	ret = of_property_read_u32_index(dev->of_node, "msi-parent",
-					 1, &dev_id);
+	do {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(dev->of_node,
+						 "msi-parent", "#msi-cells",
+						 index, &args);
+		if (args.np == domain->of_node) {
+			if (WARN_ON(args.args_count != 1))
+				return -EINVAL;
+			dev_id = args.args[0];
+			break;
+		}
+	} while (!ret);
+
 	if (ret)
 		return ret;
 
-- 
2.1.4

