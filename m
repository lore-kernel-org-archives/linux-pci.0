Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 05/29] PCI: Add is_pci_*_resource_idx() helpers
Date: Fri, 12 Apr 2013 15:44:19 -0700
Message-Id: <1365806683-26717-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
References: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to resource pointer find out if the resource is some type resource
like bridge, sriov, or std.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/pci.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f4da78d..14b7de4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -107,6 +107,29 @@ enum {
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
+static inline bool is_pci_std_resource_idx(int i)
+{
+	return i >= PCI_STD_RESOURCES && i <= PCI_STD_RESOURCE_END;
+}
+
+static inline bool is_pci_rom_resource_idx(int i)
+{
+	return i == PCI_ROM_RESOURCE;
+}
+
+static inline bool is_pci_iov_resource_idx(int i)
+{
+#ifdef CONFIG_PCI_IOV
+	return i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END;
+#endif
+	return false;
+}
+
+static inline bool is_pci_bridge_resource_idx(int i)
+{
+	return i >= PCI_BRIDGE_RESOURCES && i <= PCI_BRIDGE_RESOURCE_END;
+}
+
 typedef int __bitwise pci_power_t;
 
 #define PCI_D0		((pci_power_t __force) 0)
-- 
1.8.1.4

