Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] of/pci: Add of_pci_get_pcie_reset_suspend() to parse pcie-reset-suspend
Date: Thu, 12 Oct 2017 13:52:19 -0700
Message-Id: <20171012205220.130048-3-briannorris@chromium.org>
In-Reply-To: <20171012205220.130048-1-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This helper can be used by drivers to determine the expected PERST#
behavior when in low-power system suspend (e.g., S3). I've found the
expected behavior to vary across a few different endpoint
implementations.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/of/of_pci.c    | 25 +++++++++++++++++++++++++
 include/linux/of_pci.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index e9ec931f5b9a..ab2586f86094 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -137,6 +137,31 @@ int of_pci_get_max_link_speed(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
 
+/**
+ * This function returns true if the PCIe controller should assert PCIe Reset
+ * (PERST#) when entering system suspend (e.g., S3).
+ *
+ * @node: device tree node with the reset property
+ *
+ * Returns 1 (meaning "assert reset") or 0 ("don't assert reset"), if the DT
+ * defined a valid behavior. Otherwise, returns a negative error code.
+ */
+int of_pci_get_pcie_reset_suspend(struct device_node *node)
+{
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(node, "pcie-reset-suspend", &val);
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_pcie_reset_suspend);
+
 /**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 518c8d20647a..df453893080b 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -17,6 +17,7 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
+int of_pci_get_pcie_reset_suspend(struct device_node *node);
 void of_pci_check_probe_only(void);
 int of_pci_map_rid(struct device_node *np, u32 rid,
 		   const char *map_name, const char *map_mask_name,
@@ -69,6 +70,12 @@ of_pci_get_max_link_speed(struct device_node *node)
 	return -EINVAL;
 }
 
+static inline int
+of_pci_get_pcie_reset_suspend(struct device_node *node)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
2.15.0.rc0.271.g36b669edcc-goog
