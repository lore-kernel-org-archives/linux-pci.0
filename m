Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [RFCv2 PATCH 02/36] iommu: Add a process_exit callback for device
 drivers
Date: Fri,  6 Oct 2017 14:31:29 +0100
Message-Id: <20171006133203.22803-3-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com,
 catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, robdclark@gmail.com,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 nwatters@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When a process exits, we need to ensure that devices attached to it stop
issuing transactions with its PASID. Let device drivers register a
callback to be notified on process exit.

At the moment the callback is set on the domain like the fault handler,
because we don't have a structure available for IOMMU masters. This can
become problematic if different devices in a domain are managed by
distinct device drivers (for example multiple devices in the same group).
The problem is the same for the fault handler, so we'll probably fix them
all at once.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-process.c | 31 +++++++++++++++++++++++++++++++
 include/linux/iommu.h         | 19 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c
index a7e5a1c94305..61ca0bd707c0 100644
--- a/drivers/iommu/iommu-process.c
+++ b/drivers/iommu/iommu-process.c
@@ -223,3 +223,34 @@ static void iommu_process_detach_locked(struct iommu_context *context,
 	if (last)
 		iommu_context_free(context);
 }
+
+/**
+ * iommu_set_process_exit_handler() - set a callback for stopping the use of
+ * PASID in a device.
+ * @dev: the device
+ * @handler: exit handler
+ * @token: user data, will be passed back to the exit handler
+ *
+ * Users of the bind/unbind API should call this function to set a
+ * device-specific callback telling them when a process is exiting.
+ *
+ * After the callback returns, the device must not issue any more transaction
+ * with the PASIDs given as argument to the handler. It can be a single PASID
+ * value or the special IOMMU_PROCESS_EXIT_ALL.
+ *
+ * The handler itself should return 0 on success, and an appropriate error code
+ * otherwise.
+ */
+void iommu_set_process_exit_handler(struct device *dev,
+				    iommu_process_exit_handler_t handler,
+				    void *token)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (WARN_ON(!domain))
+		return;
+
+	domain->process_exit = handler;
+	domain->process_exit_token = token;
+}
+EXPORT_SYMBOL_GPL(iommu_set_process_exit_handler);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3978dc094706..8d74f9058f30 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -56,6 +56,11 @@ struct notifier_block;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+/* All process are being detached from this device */
+#define IOMMU_PROCESS_EXIT_ALL			(-1)
+typedef int (*iommu_process_exit_handler_t)(struct iommu_domain *, struct device *dev,
+					    int pasid, void *);
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -92,6 +97,8 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
 	void *handler_token;
+	iommu_process_exit_handler_t process_exit;
+	void *process_exit_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
 
@@ -722,4 +729,16 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_PROCESS
+extern void iommu_set_process_exit_handler(struct device *dev,
+					   iommu_process_exit_handler_t cb,
+					   void *token);
+#else /* CONFIG_IOMMU_PROCESS */
+static inline void iommu_set_process_exit_handler(struct device *dev,
+						  iommu_process_exit_handler_t cb,
+						  void *token)
+{
+}
+#endif /* CONFIG_IOMMU_PROCESS */
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.13.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
