Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbdJFN2i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:28:38 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 09/36] iommu/fault: Allow blocking fault handlers
Date: Fri,  6 Oct 2017 14:31:36 +0100
Message-Id: <20171006133203.22803-10-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow device driver to register their fault handler at various stages of
the handling path, by adding flags to iommu_set_ext_fault_handler. Since
we now have a fault workqueue, it is quite easy to call their handler from
thread context instead of IRQ handler.

A driver can request to be called both in blocking and non-blocking
context, so it can filter faults early and only execute the blocking code
for some of them. Add the IOMMU_FAULT_ATOMIC fault flag to tell the driver
where we're calling it from.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---

Rob, would this do what you want? The MSM driver can register its handler
with ATOMIC | BLOCKING flags. When called in IRQ context, it can ignore
the fault by returning IOMMU_FAULT_STATUS_NONE, or drop it by returning
IOMMU_FAULT_STATUS_INVALID. When called in thread context, it can sleep
and then return IOMMU_FAULT_STATUS_INVALID to terminate the fault.
---
 drivers/iommu/io-pgfault.c | 16 ++++++++++++++--
 drivers/iommu/iommu.c      | 12 +++++++++---
 include/linux/iommu.h      | 20 +++++++++++++++++++-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 532bdb9ce519..3ec8179f58b5 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -91,6 +91,14 @@ static int iommu_fault_handle_single(struct iommu_fault_context *fault)
 	unsigned int access_flags = 0;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct iommu_fault *params = &fault->params;
+	struct iommu_domain *domain = fault->domain;
+
+	if (domain->handler_flags & IOMMU_FAULT_HANDLER_BLOCKING) {
+		ret = domain->ext_handler(domain, fault->dev, &fault->params,
+					  domain->handler_token);
+		if (ret != IOMMU_FAULT_STATUS_NONE)
+			return ret;
+	}
 
 	if (!(params->flags & IOMMU_FAULT_PASID))
 		return ret;
@@ -274,7 +282,8 @@ int handle_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	 * if upper layers showed interest and installed a fault handler,
 	 * invoke it.
 	 */
-	if (domain->ext_handler) {
+	if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) {
+		fault->flags |= IOMMU_FAULT_ATOMIC;
 		ret = domain->ext_handler(domain, dev, fault,
 					  domain->handler_token);
 
@@ -290,8 +299,11 @@ int handle_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	}
 
 	/* If the handler is blocking, handle fault in the workqueue */
-	if (fault->flags & IOMMU_FAULT_RECOVERABLE)
+	if ((fault->flags & IOMMU_FAULT_RECOVERABLE) ||
+	    (domain->handler_flags & IOMMU_FAULT_HANDLER_BLOCKING)) {
+		fault->flags &= ~IOMMU_FAULT_ATOMIC;
 		ret = iommu_queue_fault(domain, dev, fault);
+	}
 
 	return iommu_fault_finish(domain, dev, fault, ret);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ee956b5fc301..c189648ab7b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1258,7 +1258,9 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
  * @dev: the device
  * @handler: fault handler
  * @token: user data, will be passed back to the fault handler
- * @flags: IOMMU_FAULT_HANDLER_* parameters.
+ * @flags: IOMMU_FAULT_HANDLER_* parameters. Allows the driver to tell when it
+ * wants to be notified. By default the handler will only be called from atomic
+ * context.
  *
  * This function should be used by IOMMU users which want to be notified
  * whenever an IOMMU fault happens.
@@ -1275,11 +1277,15 @@ void iommu_set_ext_fault_handler(struct device *dev,
 	if (WARN_ON(!domain))
 		return;
 
+	if (!flags)
+		flags |= IOMMU_FAULT_HANDLER_ATOMIC;
+
 	if (WARN_ON(domain->handler || domain->ext_handler))
 		return;
 
 	domain->ext_handler = handler;
 	domain->handler_token = token;
+	domain->handler_flags = flags;
 }
 EXPORT_SYMBOL_GPL(iommu_set_ext_fault_handler);
 
@@ -1824,7 +1830,7 @@ int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	int ret = -ENOSYS;
 	struct iommu_fault fault = {
 		.address	= iova,
-		.flags		= flags,
+		.flags		= flags | IOMMU_FAULT_ATOMIC,
 	};
 
 	/*
@@ -1834,7 +1840,7 @@ int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	if (domain->handler)
 		ret = domain->handler(domain, dev, iova, flags,
 						domain->handler_token);
-	else if (domain->ext_handler)
+	else if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC)
 		ret = domain->ext_handler(domain, dev, &fault,
 					  domain->handler_token);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 37fafaf07ee2..a6d417785c7b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -66,6 +66,8 @@ struct notifier_block;
 #define IOMMU_FAULT_GROUP		(1 << 6)
 /* Fault is last of its group */
 #define IOMMU_FAULT_LAST		(1 << 7)
+/* The fault handler is being called from atomic context */
+#define IOMMU_FAULT_ATOMIC		(1 << 8)
 
 /**
  * enum iommu_fault_status - Return status of fault handlers, telling the IOMMU
@@ -97,6 +99,21 @@ enum iommu_fault_status {
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+/*
+ * IOMMU_FAULT_HANDLER_ATOMIC: Notify device driver from within atomic context
+ * (IRQ handler). The callback is not allowed to sleep. If the fault is
+ * recoverable, the driver must either return a fault status telling the IOMMU
+ * driver how to complete the fault (FAILURE, INVALID, HANDLED) or complete the
+ * fault later with iommu_fault_response.
+ */
+#define IOMMU_FAULT_HANDLER_ATOMIC	(1 << 0)
+/*
+ * IOMMU_FAULT_HANDLER_BLOCKING: Notify device driver from a thread. If the fault
+ * is recoverable, the driver must return a fault status telling the IOMMU
+ * driver how to complete the fault (FAILURE, INVALID, HANDLED)
+ */
+#define IOMMU_FAULT_HANDLER_BLOCKING	(1 << 1)
+
 struct iommu_fault {
 	/* Faulting address */
 	unsigned long		address;
@@ -161,6 +178,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	iommu_ext_fault_handler_t ext_handler;
 	void *handler_token;
+	int handler_flags;
 	iommu_process_exit_handler_t process_exit;
 	void *process_exit_token;
 	struct iommu_domain_geometry geometry;
@@ -633,7 +651,7 @@ static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_ad
 }
 
 static inline void iommu_set_fault_handler(struct iommu_domain *domain,
-				iommu_fault_handler_t handler, void *token)
+				iommu_fault_handler_t handler, void *token, int flags)
 {
 }
 
-- 
2.13.3
