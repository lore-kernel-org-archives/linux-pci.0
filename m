Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [RFCv2 PATCH 03/36] iommu/process: Add public function to search for
 a process
Date: Fri,  6 Oct 2017 14:31:30 +0100
Message-Id: <20171006133203.22803-4-jean-philippe.brucker@arm.com>
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

The fault handler will need to find a process given its PASID. This is
the reason we have an IDR for storing processes, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-process.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/iommu.h         | 12 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/iommu-process.c b/drivers/iommu/iommu-process.c
index 61ca0bd707c0..8f4c98632d58 100644
--- a/drivers/iommu/iommu-process.c
+++ b/drivers/iommu/iommu-process.c
@@ -145,6 +145,41 @@ static void iommu_process_put_locked(struct iommu_process *process)
 	kref_put(&process->kref, iommu_process_release);
 }
 
+/**
+ * iommu_process_put - Put reference to process, freeing it if necessary.
+ */
+void iommu_process_put(struct iommu_process *process)
+{
+	spin_lock(&iommu_process_lock);
+	iommu_process_put_locked(process);
+	spin_unlock(&iommu_process_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_process_put);
+
+/**
+ * iommu_process_find - Find process associated to the given PASID
+ *
+ * Returns the IOMMU process corresponding to this PASID, or NULL if not found.
+ * A reference to the iommu_process is kept, and must be released with
+ * iommu_process_put.
+ */
+struct iommu_process *iommu_process_find(int pasid)
+{
+	struct iommu_process *process;
+
+	spin_lock(&iommu_process_lock);
+	process = idr_find(&iommu_process_idr, pasid);
+	if (process) {
+		if (!iommu_process_get_locked(process))
+			/* kref is 0, process is defunct */
+			process = NULL;
+	}
+	spin_unlock(&iommu_process_lock);
+
+	return process;
+}
+EXPORT_SYMBOL_GPL(iommu_process_find);
+
 static int iommu_process_attach(struct iommu_domain *domain, struct device *dev,
 				struct iommu_process *process)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8d74f9058f30..e9528fcacab1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -733,12 +733,24 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 extern void iommu_set_process_exit_handler(struct device *dev,
 					   iommu_process_exit_handler_t cb,
 					   void *token);
+extern struct iommu_process *iommu_process_find(int pasid);
+extern void iommu_process_put(struct iommu_process *process);
+
 #else /* CONFIG_IOMMU_PROCESS */
 static inline void iommu_set_process_exit_handler(struct device *dev,
 						  iommu_process_exit_handler_t cb,
 						  void *token)
 {
 }
+
+static inline struct iommu_process *iommu_process_find(int pasid)
+{
+	return NULL;
+}
+
+static inline void iommu_process_put(struct iommu_process *process)
+{
+}
 #endif /* CONFIG_IOMMU_PROCESS */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.13.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
