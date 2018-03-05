Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] PCI: Move declaration of of_irq_parse_and_map_pci under OF_IRQ
Date: Mon,  5 Mar 2018 15:22:30 -0800
Message-Id: <1520292150-15699-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
PCI core"), sparc:allmodconfig fails to build with the following error.

pcie-cadence-host.c:(.text+0x4c4):
	undefined reference to `of_irq_parse_and_map_pci'
pcie-cadence-host.c:(.text+0x4c8):
	undefined reference to `of_irq_parse_and_map_pci'

of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
Make its declaration and its dummy function dependent on OF_IRQ
to solve the problem.

Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
Cc: Rob Herring <robh@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Rob's Ack
    Sent to linux-pci mailing list per Rob's request

 include/linux/of_pci.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 88865e0ebf4d..091033a6b836 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,7 +13,6 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
-int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
@@ -34,12 +33,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline int
-of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	return 0;
-}
-
-static inline int
 of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 {
 	return -EINVAL;
@@ -67,6 +60,16 @@ of_pci_get_max_link_speed(struct device_node *node)
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_IRQ)
+int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
+#else
+static inline int
+of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_OF_ADDRESS)
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
-- 
2.7.4
