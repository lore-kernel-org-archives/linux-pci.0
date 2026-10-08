Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC86DCE1;
	Thu,  8 Oct 2026 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439308; cv=none; b=Cyhd5m4gShpYsM+M3k14IJbsCAqlBu6Fx6jyoZcnQ1wZkUpkO/Sq9We2DaiuBYtXAWvhPSa0noiLvfxjz5+08Pb+N21ZFfqqWgKRcE1dONg5e1NxWCDOtqa50D3jWYF59O0m9lIxDykjLEPfQr63h717rTKQHuetIekxhpqERng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439308; c=relaxed/simple;
	bh=po5Uj39tnz3e9D8mz/lsqW7r5Yj4xNT72s/2hV6fux4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSU5sEDwP2RmHy9n/8l75VFQrXsSZR6rCJNjoc3B4+HDLolkeME46icsNoE1WGSCdE5/rJJp8Cho0NGYvRZUVGQVFVJoe0i7AJlvGcCc+qDxpIxA+6LztcEaWSuBbIXwPzlunpmiT1z+v+PsD2slUbDJ4mUpj+5DwgzxGhjafqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThMPDxJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThMPDxJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE41F000FF;
	Thu,  8 Oct 2026 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439306;
	bh=9PGOVqncJHPJK5CYAV1ovh89NlJJmqXLIrs5m13gCns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThMPDxJAg0WW+D2ciB0KrfbaWfgWDXEebrxfyz931jwTfNznWCK3N0ZXZc1FL2kxU
	 GMaqMsXo4aqPwJUfZ7o3df74UP9nrIg6xqEmX2VcBSoKU29jWtMbYRCFjBH6LXEkfN
	 0PMBItBiaXfLF3ZO/bTDyW4b7DivH3hVnLoSRxmc2bmgr77AK5L/Iyvg3uxXlx0kd9
	 Tu7Xn3/t2pqs07GHhmexosuHG/WKKWMsNpuJSe+4Bfo49DUI1ePuc1D7wSJxLJI74t
	 qb0oX0ZQQQLFryqtZi75ajrV0jPmWuFiaXlkYh+ZPdL9sz629ehbQRtx64fMsUCm3G
	 Lf4LWg4QMWIwQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
Date: Thu,  8 Oct 2026 11:29:49 +0530
Message-ID: <20261008055955.4014342-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A VMM needs to forward guest-originated TSM commands to the TSM
implementation managing an assigned device. The IOMMUFD vdevice
identifies that device within its vIOMMU and provides the appropriate
dispatch point.

Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
optionally return a response. Define common operation and guest
architecture identifiers for CCA, SEV and TDX requests.

Let vdevice providers declare the TVM architecture and supported operations
in a u64 mask. Check these capabilities before dispatch. Define a
one-past-last operation value and assert that every operation fits in the
mask; reject out-of-range userspace values before indexing it.

The ioctl return value reports errors or the number of unused buffer bytes,
while tsm_code carries the TSM-specific result. Use userspace pointers for
the internal request and response buffers, and u32 lengths matching the
UAPI. Reject lengths above INT_MAX so successful residues fit in the
ioctl's int return value.

Cc: jgg@ziepe.ca
Cc: kevin.tian@intel.com
Cc: joro@8bytes.org
Cc: will@kernel.org
Cc: robin.murphy@arm.com
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h |  8 +++
 drivers/iommu/iommufd/main.c            |  3 +
 drivers/iommu/iommufd/tsm.c             | 80 ++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          |  3 +
 include/linux/iommufd.h                 |  9 +++
 include/linux/tsm.h                     | 23 +++++++
 include/uapi/linux/iommufd.h            | 82 +++++++++++++++++++++++++
 8 files changed, 210 insertions(+)
 create mode 100644 drivers/iommu/iommufd/tsm.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 67207914bb6e..f90efe2f9d10 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -11,6 +11,8 @@ iommufd-y := \
 	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
+iommufd-$(CONFIG_TSM) += tsm.o
+
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2560b4faa6f9..64e0d9e4da16 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -730,6 +730,14 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
 void iommufd_vdevice_abort(struct iommufd_object *obj);
 int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
+#ifdef CONFIG_TSM
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..577eef2760a3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -453,6 +453,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_tsm_req tsm_req;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -516,6 +517,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_TSM_REQ, iommufd_vdevice_tsm_req_ioctl,
+		 struct iommu_vdevice_tsm_req, out_tsm_code),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
new file mode 100644
index 000000000000..b28ff8640345
--- /dev/null
+++ b/drivers/iommu/iommufd/tsm.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 ARM Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/limits.h>
+#include <linux/tsm.h>
+#include "iommufd_private.h"
+
+/**
+ * iommufd_vdevice_tsm_req_ioctl - Forward TSM requests
+ * @ucmd: user command data for IOMMU_VDEVICE_TSM_REQ
+ *
+ * Resolve @iommu_vdevice_tsm_req::vdevice_id to a vdevice and pass the
+ * request/response buffers to its vIOMMU implementation.
+ *
+ * Return:
+ *  -errno on error.
+ *  positive residue if response/request bytes were left unconsumed.
+ *    if response buffer is provided, residue indicates the number of bytes
+ *    not used in response buffer
+ *    if there is no response buffer, residue indicates the number of bytes
+ *    not consumed in req buffer
+ *  0 otherwise.
+ */
+int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
+{
+	int ret;
+	struct iommufd_object *obj;
+	struct iommufd_vdevice *vdev;
+	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
+	struct tsm_guest_req_info info = {
+		.op = cmd->op,
+		.tvm_arch = cmd->tvm_arch,
+		.req = u64_to_user_ptr(cmd->req_uptr),
+		.req_len = cmd->req_len,
+		.resp = u64_to_user_ptr(cmd->resp_uptr),
+		.resp_len = cmd->resp_len,
+	};
+
+	/* Every defined operation must fit in the vdevice's u64 mask. */
+	BUILD_BUG_ON(BITS_PER_TYPE(u64) < TSM_REQ_MAX);
+
+	/* Successful residues must fit in the ioctl's int return value. */
+	if (cmd->req_len > INT_MAX || cmd->resp_len > INT_MAX)
+		return -EINVAL;
+
+	obj = iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
+				 IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(obj))
+		return PTR_ERR(obj);
+	vdev = container_of(obj, struct iommufd_vdevice, obj);
+
+	cmd->out_tsm_code = 0;
+	if (!vdev->viommu->ops || !vdev->viommu->ops->vdevice_tsm_req ||
+	    !vdev->tsm_req_op_mask) {
+		ret = -EOPNOTSUPP;
+		goto out_respond;
+	}
+	/* Bounds-check the user-supplied shift before BIT_ULL(). */
+	if (cmd->tvm_arch != vdev->tsm_tvm_arch ||
+	    cmd->op >= TSM_REQ_MAX ||
+	    !(vdev->tsm_req_op_mask & BIT_ULL(cmd->op))) {
+		ret = -EINVAL;
+		goto out_put_object;
+	}
+	ret = vdev->viommu->ops->vdevice_tsm_req(vdev, &info,
+						 &cmd->out_tsm_code);
+
+out_respond:
+	/* Always copy the tsm_code as response */
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		ret = -EFAULT;
+
+out_put_object:
+	iommufd_put_object(ucmd->ictx, obj);
+	return ret;
+}
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index b7489ed259bd..f3d5b5a7eb4a 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -2,6 +2,9 @@
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/file.h>
+#include <linux/cleanup.h>
+#include <linux/tsm.h>
+
 #include "iommufd_private.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 3267717f676d..cfcf53b7c9e8 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -24,6 +24,7 @@ struct iommufd_ctx;
 struct iommufd_device;
 struct iommufd_viommu_ops;
 struct page;
+struct tsm_guest_req_info;
 
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
@@ -125,6 +126,10 @@ struct iommufd_vdevice {
 	 */
 	u64 virt_id;
 
+	/* Guest TSM requests accepted by this vdevice; set by vdevice_init(). */
+	u64 tsm_req_op_mask;
+	u32 tsm_tvm_arch;
+
 	/* Clean up all driver-specific parts of an iommufd_vdevice */
 	void (*destroy)(struct iommufd_vdevice *vdev);
 };
@@ -167,6 +172,7 @@ struct iommufd_hw_queue {
  *                include/uapi/linux/iommufd.h)
  *                If driver has a deinit function to revert what vdevice_init op
  *                does, it should set it to the @vdev->destroy function pointer
+ * @vdevice_tsm_req: Forward a guest TSM request to a driver-owned vDEVICE
  * @get_hw_queue_size: Get the size of a driver-defined HW queue structure for a
  *                     given @viommu corresponding to @queue_type. Driver should
  *                     return 0 if HW queue aren't supported accordingly. It is
@@ -193,6 +199,9 @@ struct iommufd_viommu_ops {
 				struct iommu_user_data_array *array);
 	const size_t vdevice_size;
 	int (*vdevice_init)(struct iommufd_vdevice *vdev);
+	ssize_t (*vdevice_tsm_req)(struct iommufd_vdevice *vdev,
+				   struct tsm_guest_req_info *info,
+				   u64 *tsm_code);
 	size_t (*get_hw_queue_size)(struct iommufd_viommu *viommu,
 				    enum iommu_hw_queue_type queue_type);
 	/* AMD's HW will add hw_queue_init simply using @hw_queue->base_addr */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 381c53244c83..4bce4c9fa6f0 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/device.h>
+#include <uapi/linux/iommufd.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_16M
@@ -123,4 +124,26 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
+
+#ifdef CONFIG_TSM
+/**
+ * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
+ * @op: operation for the guest-initiated request
+ * @tvm_arch: guest TVM architecture
+ * @req: userspace buffer containing the guest request
+ * @req_len: request size in bytes, at most INT_MAX
+ * @resp: userspace buffer for the response
+ * @resp_len: response buffer capacity in bytes, at most INT_MAX
+ */
+struct tsm_guest_req_info {
+	enum iommu_vdevice_tsm_guest_req_op op;
+	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
+	const void __user *req;
+	u32 req_len;
+	void __user *resp;
+	u32 resp_len;
+};
+#else
+struct tsm_guest_req_info;
+#endif
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..9920138f9eda 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -58,6 +58,7 @@ enum {
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
+	IOMMUFD_CMD_VDEVICE_TSM_REQ = 0x96,
 };
 
 /**
@@ -1390,4 +1391,85 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * enum iommu_vdevice_tsm_guest_tvm_arch - guest TVM architecture
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_CCA: Arm CCA TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_SEV: AMD SEV TVM
+ * @IOMMU_VDEVICE_TSM_TVM_ARCH_TDX: Intel TDX TVM
+ */
+enum iommu_vdevice_tsm_guest_tvm_arch {
+	IOMMU_VDEVICE_TSM_TVM_ARCH_CCA = 1,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_SEV,
+	IOMMU_VDEVICE_TSM_TVM_ARCH_TDX,
+};
+
+/**
+ * enum iommu_vdevice_tsm_guest_req_op - Guest TSM request operations
+ * @TSM_REQ_VALIDATE_MMIO: Validate and map a guest MMIO range for the trusted
+ *                         device.
+ * @TSM_REQ_SET_TDI_STATE: Transition the trusted device to the unlocked,
+ *                         locked, or running state.
+ * @TSM_REQ_SEV_ENABLE_DMA: Enable DMA for an SEV device.
+ * @TSM_REQ_SEV_DISABLE_DMA: Disable DMA for an SEV device.
+ * @TSM_REQ_READ_OBJECT: Read bytes from a device object, such as a certificate,
+ *                       measurement, or interface report.
+ * @TSM_REQ_REGEN_OBJECT: Regenerate a device object, such as a measurement or
+ *                        interface report.
+ * @TSM_REQ_OBJECT_INFO: Query the size of a device object.
+ * @TSM_REQ_MAX: One past the last request operation; not a command.
+ *
+ * The request payload and response format depend on the TVM architecture.
+ */
+enum iommu_vdevice_tsm_guest_req_op {
+	TSM_REQ_VALIDATE_MMIO = 1,
+	TSM_REQ_SET_TDI_STATE,
+	TSM_REQ_SEV_ENABLE_DMA,
+	TSM_REQ_SEV_DISABLE_DMA,
+	TSM_REQ_READ_OBJECT,
+	TSM_REQ_REGEN_OBJECT,
+	TSM_REQ_OBJECT_INFO,
+	TSM_REQ_MAX,
+};
+
+/**
+ * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
+ * @size: sizeof(struct iommu_vdevice_tsm_req)
+ * @vdevice_id: vDevice ID the guest request is for
+ * @op: One of enum iommu_vdevice_tsm_guest_req_op, excluding TSM_REQ_MAX
+ * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
+ * @req_len: Size in bytes of the input payload at @req_uptr, at most INT_MAX
+ * @resp_len: Size in bytes of the output buffer at @resp_uptr, at most INT_MAX
+ * @req_uptr: Userspace pointer to the guest-provided request payload
+ * @resp_uptr: Userspace pointer to the guest response buffer
+ * @out_tsm_code: TSM-specific result code returned by the TSM implementation
+ *
+ * Forward a TSM request to the TSM bound vDevice. This is intended for
+ * guest TSM/TDISP message transport where the host kernel only marshals
+ * bytes between userspace and the TSM implementation.
+ *
+ * The request operation is guest initiated. The vDEVICE implementation
+ * declares the TVM architecture and operations it accepts; iommufd checks
+ * both before forwarding the request.
+ *
+ * The request payload is read from @req_uptr/@req_len. If a response is
+ * expected, userspace provides @resp_uptr/@resp_len as writable storage for
+ * response bytes returned by the TSM path.
+ *
+ * The ioctl is only suitable for commands and results that the host kernel
+ * has no use, the host is only facilitating guest to TSM communication.
+ */
+struct iommu_vdevice_tsm_req {
+	__u32 size;
+	__u32 vdevice_id;
+	__u32 op;
+	__u32 tvm_arch;
+	__u32 req_len;
+	__u32 resp_len;
+	__aligned_u64 req_uptr;
+	__aligned_u64 resp_uptr;
+	__aligned_u64 out_tsm_code;
+};
+
+#define IOMMU_VDEVICE_TSM_REQ _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_REQ)
 #endif
-- 
2.43.0

