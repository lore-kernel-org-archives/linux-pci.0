Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og126.obsmtp.com ([64.18.0.251]:49002 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753537AbbFKUIs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2015 16:08:48 -0400
Received: by padev16 with SMTP id ev16so8974982pad.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2015 13:08:47 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ian Campbell <ian.campbell@citrix.com>,
	Marcin Juszkiewicz <mjuszkiewicz@redhat.com>,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH 1/1] PCI: X-Gene: Disable Configuration Request Retry Status for X-Gene v1 PCIe
Date: Thu, 11 Jun 2015 13:08:14 -0700
Message-Id: <1434053294-10962-1-git-send-email-dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene v1 PCIe controller has a bug in Configuration Request Retry
Status (CRS) logic:
  When CPU tries to read Vendor ID and Device ID of not-existed
  remote device, the controller returns 0xFFFF0001 instead of
  0xFFFFFFFF; this will add significant delay in boot time as
  pci_bus_read_dev_vendor_id will wait for 60 seconds before
  giving up.

So for X-Gene v1 PCIe controllers, disable CRS capability
advertisement by clearing CRS Software Visibility bit before
returning the Root Capability value to the callers. This is done
by implementing X-Gene PCIe specific xgene_pcie_config_read32 for
CFG read accesses to replace the generic default pci_generic_config_read32
function.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/pci/host/pci-xgene.c | 48 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index ee082c0..741a253 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -59,6 +59,12 @@
 #define SZ_1T				(SZ_1G*1024ULL)
 #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
 
+#define ROOT_CAP_AND_CTRL		0x5C
+
+/* PCIe IP version */
+#define XGENE_PCIE_IP_VER_UNKN		0
+#define XGENE_PCIE_IP_VER_1		1
+
 struct xgene_pcie_port {
 	struct device_node	*node;
 	struct device		*dev;
@@ -67,6 +73,7 @@ struct xgene_pcie_port {
 	void __iomem		*cfg_base;
 	unsigned long		cfg_addr;
 	bool			link_up;
+	u32			version;
 };
 
 static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
@@ -140,9 +147,44 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 	return xgene_pcie_get_cfg_base(bus) + offset;
 }
 
+int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 *val)
+{
+	void __iomem *addr;
+	struct xgene_pcie_port *port = bus->sysdata;
+
+	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
+	if (!addr) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = readl(addr);
+	/*
+	 * X-Gene v1 PCIe controller has a bug in Configuration Request
+	 * Retry Status (CRS) logic:
+	 *  When CPU tries to read Vendor ID and Device ID of not-existed
+	 *  remote device, the controller returns 0xFFFF0001 instead of
+	 *  0xFFFFFFFF; this will add significant delay in boot time as
+	 *  pci_bus_read_dev_vendor_id will wait for 60 seconds before
+	 *  giving up.
+	 * So for X-Gene v1 PCIe controllers, disable CRS capability
+	 * advertisement by clearing CRS Software Visibility bit before
+	 * returning the Root Capability value to the callers.
+	 */
+	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
+	    ((where & ~0x3) == ROOT_CAP_AND_CTRL))
+		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+
+	if (size <= 2)
+		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static struct pci_ops xgene_pcie_ops = {
 	.map_bus = xgene_pcie_map_bus,
-	.read = pci_generic_config_read32,
+	.read = xgene_pcie_config_read32,
 	.write = pci_generic_config_write32,
 };
 
@@ -483,6 +525,10 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	port->node = of_node_get(pdev->dev.of_node);
 	port->dev = &pdev->dev;
 
+	port->version = XGENE_PCIE_IP_VER_UNKN;
+	if (of_device_is_compatible(port->node, "apm,xgene-pcie"))
+		port->version = XGENE_PCIE_IP_VER_1;
+
 	ret = xgene_pcie_map_reg(port, pdev);
 	if (ret)
 		return ret;
-- 
1.9.1

