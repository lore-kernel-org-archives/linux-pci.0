Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:39654 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbcJLBzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 21:55:25 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 2/3] of/pci: Add helper function to parse max-link-speed from dt
Date: Wed, 12 Oct 2016 10:01:24 +0800
Message-Id: <1476237685-14539-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1476237685-14539-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476237685-14539-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This new helper function could be used by host drivers to
get the limitaion of max link speed provided by dt. If the
property isn't assigned or is invalid, it will return -EINVAL
to the caller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v7:
- rename the function name and using of_property_read_u32
  suggested by Rob

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/of/of_pci.c    | 21 +++++++++++++++++++++
 include/linux/of_pci.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 589b30c..0c566ca 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -120,6 +120,27 @@ int of_get_pci_domain_nr(struct device_node *node)
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
 /**
+ * This function will try to find the limitation of link speed by finding
+ * a property called "max-link-speed" of the given device node.
+ *
+ * @node: device tree node with the max link speed information
+ *
+ * Returns the associated max link speed from DT, or a negative value if the
+ * required property is not found or is invalid.
+ */
+int of_pci_get_max_link_speed(struct device_node *node)
+{
+	u32 max_link_speed;
+
+	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
+	    max_link_speed > 4)
+		return -EINVAL;
+
+	return max_link_speed;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
+
+/**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
  */
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index b969e94..2e668e3 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -16,6 +16,7 @@ int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
+int of_pci_get_max_link_speed(struct device_node *node);
 void of_pci_check_probe_only(void);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
@@ -52,6 +53,12 @@ of_get_pci_domain_nr(struct device_node *node)
 	return -1;
 }
 
+static inline int
+of_pci_get_max_link_speed(struct device_node *node)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
2.3.7


