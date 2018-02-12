Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 09/37] iommu/fault: Let handler return a fault response
Date: Mon, 12 Feb 2018 18:33:24 +0000
Message-Id: <20180212183352.22730-10-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is really convenient to let fault handlers return the action to perform
on the fault immediately, instead of having to call iommu_page_response
with a crafted structure. Update IOMMU_PAGE_RESP* values to encompass most
needs:

- IOMMU_PAGE_RESP_HANDLED means "I took ownership of the fault and will
  send a response later"

- IOMMU_PAGE_RESP_CONTINUE means "I didn't handle the fault, let the next
  handler in the chain take care of it"

- IOMMU_PAGE_RESP_SUCCESS, IOMMU_PAGE_RESP_INVALID,
  IOMMU_PAGE_RESP_FAILURE are the PCI PRI values, and mean respectively
  "fault fixed, retry the translation", "could not fix the fault, abort
  the translation" and "unexpected fault, disable PRI".

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/io-pgfault.c |  8 +++++++-
 drivers/iommu/iommu.c      |  5 ++++-
 include/linux/iommu.h      | 30 ++++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 565ec01a1b5f..484a39710d3f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -63,6 +63,9 @@ static int iommu_fault_complete(struct iommu_domain *domain, struct device *dev,
 	if (status == IOMMU_PAGE_RESP_HANDLED)
 		return 0;
 
+	if (WARN_ON(status == IOMMU_PAGE_RESP_CONTINUE))
+		return -EINVAL;
+
 	/*
 	 * There was an internal error with handling the recoverable fault. Try
 	 * to complete the fault if possible.
@@ -272,7 +275,10 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	if (iommu_has_device_fault_handler(dev)) {
 		struct iommu_fault_param *param = dev->iommu_param->fault_param;
 
-		return param->handler(evt, param->data);
+		ret = param->handler(evt, param->data);
+		if (ret != IOMMU_PAGE_RESP_CONTINUE)
+			return iommu_fault_complete(domain, dev, evt, ret);
+		ret = -ENOSYS;
 	}
 
 	/* If the handler is blocking, handle fault in the workqueue */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c475893ec7dc..9bec8390694c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -805,7 +805,10 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  * @data: private data passed as argument to the callback
  *
  * When an IOMMU fault event is received, call this handler with the fault event
- * and data as argument.
+ * and data as argument. If the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the
+ * handler can either return a status code (IOMMU_PAGE_RESP_*) to complete the
+ * fault, or return IOMMU_PAGE_RESP_HANDLED and complete the fault later by
+ * calling iommu_page_response().
  *
  * Return 0 if the fault handler was installed successfully, or an error.
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 65e56f28e0ce..d29991be9401 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -189,6 +189,29 @@ enum page_response_type {
 	IOMMU_PAGE_GROUP_RESP,
 };
 
+/**
+ * enum page_response_code - Return status of fault handlers, telling the IOMMU
+ * driver how to proceed with the fault.
+ *
+ * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do not send a
+ *	reply to the device.
+ * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the next handler,
+ *	or terminate.
+ * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum page_response_code {
+	IOMMU_PAGE_RESP_HANDLED = 0,
+	IOMMU_PAGE_RESP_CONTINUE,
+	IOMMU_PAGE_RESP_SUCCESS,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
 /**
  * Generic page response information based on PCI ATS and PASID spec.
  * @addr: servicing page address
@@ -202,12 +225,7 @@ enum page_response_type {
 struct page_response_msg {
 	u64 addr;
 	u32 pasid;
-	u32 resp_code:4;
-#define IOMMU_PAGE_RESP_SUCCESS	0
-#define IOMMU_PAGE_RESP_INVALID	1
-#define IOMMU_PAGE_RESP_HANDLED	2
-#define IOMMU_PAGE_RESP_FAILURE	0xF
-
+	enum page_response_code resp_code;
 	u32 pasid_present:1;
 	u32 page_req_group_id : 9;
 	enum page_response_type type;
-- 
2.15.1

