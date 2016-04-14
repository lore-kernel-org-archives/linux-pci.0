Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44807 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbcDNRXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Apr 2016 13:23:13 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 03/11] drivers: iommu: add FWNODE_IOMMU fwnode type
Date: Thu, 14 Apr 2016 18:25:35 +0100
Message-Id: <1460654743-7896-4-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On systems booting with a device tree, every struct device is
associated with a struct device_node, that represents its DT
representation. The device node can be used in generic kernel
contexts (eg IRQ translation, IOMMU streamid mapping), to
retrieve the properties associated with the device and carry
out kernel operation accordingly. Owing to the 1:1 relationship
between the device and its device_node, the device_node can also
be used as a look-up token for the device (eg looking up a device
through its device_node), to retrieve the device in kernel paths
where the device_node is available.

On systems booting with ACPI, the same abstraction provided by
the device_node is required to provide:

- Look-up functionality
- Identify the device in kernel functions that must be firmware
  agnostic (eg IOMMU of_xlate() callbacks)

Therefore, mirroring the approach implemented in the IRQ domain
kernel layer, this patch adds an additional fwnode type FWNODE_IOMMU.

This patch also implements a glue kernel layer that allows to
allocate/free FWNODE_IOMMU fwnode_handle structures and associate
them with IOMMU devices.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 include/linux/fwnode.h |  1 +
 include/linux/iommu.h  | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8516717..6e10050 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -19,6 +19,7 @@ enum fwnode_type {
 	FWNODE_ACPI_DATA,
 	FWNODE_PDATA,
 	FWNODE_IRQCHIP,
+	FWNODE_IOMMU,
 };
 
 struct fwnode_handle {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..0bba25e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -37,6 +37,7 @@ struct bus_type;
 struct device;
 struct iommu_domain;
 struct notifier_block;
+struct fwnode_handle;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -542,4 +543,28 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
 
 #endif /* CONFIG_IOMMU_API */
 
+/* IOMMU fwnode handling */
+static inline bool is_fwnode_iommu(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_IOMMU;
+}
+
+static inline struct fwnode_handle *iommu_alloc_fwnode(void)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_KERNEL);
+	fwnode->type = FWNODE_IOMMU;
+
+	return fwnode;
+}
+
+static inline void iommu_free_fwnode(struct fwnode_handle *fwnode)
+{
+	if (WARN_ON(!is_fwnode_iommu(fwnode)))
+		return;
+
+	kfree(fwnode);
+}
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.6.4

