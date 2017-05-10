Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:32085 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbdEJSmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 May 2017 14:42:10 -0400
From: Ashok Raj <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Cc: CQ Tang <cq.tang@intel.com>, linux-pci@vger.kernel.org,
        Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Helper function to query if a pasid has any active users
Date: Wed, 10 May 2017 11:39:03 -0700
Message-Id: <1494441543-8216-2-git-send-email-ashok.raj@intel.com>
In-Reply-To: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: CQ Tang <cq.tang@intel.com>

A driver would need to know if there are any active references to a
a PASID before cleaning up its resources. This function helps check
if there are any active users of a PASID before it can perform any
recovery on that device.

To: Joerg Roedel <joro@8bytes.org>
To: linux-kernel@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org

Signed-off-by: CQ Tang <cq.tang@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-svm.c | 30 ++++++++++++++++++++++++++++++
 include/linux/intel-svm.h | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 23c4276..f167c0d 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -489,6 +489,36 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 }
 EXPORT_SYMBOL_GPL(intel_svm_unbind_mm);
 
+int intel_svm_is_pasid_valid(struct device *dev, int pasid)
+{
+	struct intel_iommu *iommu;
+	struct intel_svm *svm;
+	int ret = -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+	iommu = intel_svm_device_to_iommu(dev);
+	if (!iommu || !iommu->pasid_table)
+		goto out;
+
+	svm = idr_find(&iommu->pasid_idr, pasid);
+	if (!svm)
+		goto out;
+
+	/* init_mm is used in this case */
+	if (!svm->mm)
+		ret = 1;
+	else if (atomic_read(&svm->mm->mm_users) > 0)
+		ret = 1;
+	else
+		ret = 0;
+
+ out:
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_svm_is_pasid_valid);
+
 /* Page request queue descriptor */
 struct page_req_dsc {
 	u64 srr:1;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 3c25794..99bc5b3 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -102,6 +102,21 @@ extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
  */
 extern int intel_svm_unbind_mm(struct device *dev, int pasid);
 
+/**
+ * intel_svm_is_pasid_valid() - check if pasid is valid
+ * @dev:	Device for which PASID was allocated
+ * @pasid:	PASID value to be checked
+ *
+ * This function checks if the specified pasid is still valid. A
+ * valid pasid means the backing mm is still having a valid user.
+ * For kernel callers init_mm is always valid. for other mm, if mm->mm_users
+ * is non-zero, it is valid.
+ *
+ * returns -EINVAL if invalid pasid, 0 if pasid ref count is invalid
+ * 1 if pasid is valid.
+ */
+extern int intel_svm_is_pasid_valid(struct device *dev, int pasid);
+
 #else /* CONFIG_INTEL_IOMMU_SVM */
 
 static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
@@ -114,6 +129,11 @@ static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
 {
 	BUG();
 }
+
+static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 #define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
-- 
2.7.4
