Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E32360ECE;
	Tue,  2 Jun 2026 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381843; cv=fail; b=qOtsMygI5XDH+HkPS4h7+ET5YlxRnGonzwpm4k4PP56vldhzT2cLgjuOnVLqfS3If+E0xnqEeEa9+axb0zKkkfgWtmhgdNUI6ZDqJxjokCdc5hFwTGRxdpr88AvuB6T+LFwpVBCHzDAXcCWJQG5NwnLByQ+4CQc60sBIWnE2+Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381843; c=relaxed/simple;
	bh=g7CBfKJG9vt6KX+cPXPE+TRSdNKwjbLmbLGrZSAqpe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hlc/0u3qNUQqMTApssWDfZESt/3QrDZxVfJ9ZfoqGnB9pi0+pWn5cihdkea3O6AglDEv504im9Xg6n3fQj5QoJ58tlcHr28prsMVyddYl9yyb/MvNGhODD1HHeLJjlZxTUu4PA654CwbuB0WqEAgC8iC4PP6GRRHlJ5xX4QkFak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=As7ELST6; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="As7ELST6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5OlLEP/jG7z2u6+aWGxMNeHF82AbJqxsyjL4cKmLPjWuiqd2q0SAIM7EVr1a9b34o9We5xkWPaDxvQ64y3/IrvSU3/3kgKgYOItAlSKoqX8ECm5etuYuBYZmJaRNQUzDm3bwhPCNKPWCRvZ+82sg8pgrY5PItw0gRnT0kQwQDbPHMGMmsmIB4fZOnHFmW/kNDmqoZQpz7I34PgCgn4FlxZKXNPajIDhpLleih8yQZSE2aQGsvPGnFLlDpC7SpwGlT27Aa0N2B5S4lhDgnYnoE3Bc+lwDu+/irVQ288m8V2EDfdGHB1XlqElJ68OS+F+/mkPoj5HMJRQQQ0+TVb9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZkdmYfbx7WNYnS3SaqhK2QMgfkFTNUGtiY2MJ1VQUg=;
 b=B5q2L8//C8X3O3raPRGwtpgmk88SWWdX/9HQIOkyoJeiK71Ev/5JLcoh6luvOF1qU+KwnbBWDiB036jyDmVAAcjNCCJduvqKigRFKJEw/l5yGbeaq07Xj8lE5vDEDiXoccl2h9jEdja+8HOrYwtHpXusm8YfwjoEWima3UAvNttCz+qHx6iLwR8srQc/rIgd0jgQm+UmBCYB21ZQHwmfEuisnqT1j8QPc5Fh7nD4/uppNvSWHYe2gbH2jDITXXXHgOajH53Dao4PQQh+R1mk3lzy1vBD8L7K70WIe4Y766PpGSq1leyMvSHVeYRe3jl6uVUYgfWlZEtCk+kEWh+uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZkdmYfbx7WNYnS3SaqhK2QMgfkFTNUGtiY2MJ1VQUg=;
 b=As7ELST65jl17qdR1mU5pnTMhpzDBnCVBOizVINuEdEoqMqQlkX5VTC0iEu4TInnzW2coEEHfom7Orj5bYICcCNRmGNWSOPYu2gb1t6v8Y/GvDlTb3Z3Wwqqp7Y2W/+kuBXT+LpaIZBwdFZUC4ZIrfsbJdxBHfHpziOvYOXAlQB1qWPaaltDDelJff9tFOg9jGdRQ6hbR9TrW4W++Qb3dpzSCDs8MsPd/6tgqtOT0zaQc1CKZpXjbMJO2JNVCifVmNnydtezJ3A7Dp0oRQvRA3r4XbR8lzTqD95Nh/RvBQkAlzhTB9xxwb1N5u84hpQsldmQcLwKHzuLMTZOXf5NfA==
Received: from DS7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::12) by
 SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 06:30:36 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:8:25d:cafe::93) by DS7P220CA0110.outlook.office365.com
 (2603:10b6:8:25d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 2
 Jun 2026 06:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 06:30:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 23:30:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 23:30:16 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 23:30:15 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<clg@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Tue, 2 Jun 2026 06:30:15 +0000
Message-ID: <20260602063015.3915-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b9dbb-f5d6-4d8e-48a6-08dec070748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZRLvzoWtcyBtVAu87XQL/K+EmKl0q+V/bHQkctWMKOsOIZeUT/8IjNuEiNdLaf0PR6ePO+zvZABQ/BRklq3DCwa1fxZfSN8qNpT8IXFXcUFv6iBY4nzpxGRHbvxAKWAPDCjSE/RWDKpamzHYxFZckfgQvCpHcKJ/cYEJlKrBE4zlce12SUgqxNcRKDd/gCTklqv1LhYbbjxb/H1On72cVxSUNdE5ILN9lbjKSTcyKjS0eFu+9IlboM7YZXWom3nNkh1r6V5VlrI4TVdZ0uIlUx+H0spTMV2XBtsc+WsHbHt3xFWQ/ddM1Ebs1tfxiK9nk4DndvALDmLTi7H9DKuBesB8W04/mPV9eRgaLnwIsyaxbTmqqet5n0DLoRnrRx5+Y49nQPwAqUHF1NM0gsgLNITlwkvFmsvMCRuFqXMXTKadbZblWWYPqlaugONZOd9kfrLObUUYXcRz/qIjMFAQTS333ALfpG7gb0THS+vW2h119vW/mr6opQHFlv3lXUSuuNfy7mVAVuxiQNZ/qU4kh1E3ZYjDcUqRCmRZ0kH2vyc+HZoaKit/CPGaBRTTlqg+1VS5mySpeRRvJ+6l2CIS/rVlyxaQxYNW2pjKWdh6hbxlDZxAv45O5FuQjbXTXs00Ni+VVD9FTyShbc4NYCjdYrlGVS/1hmx/WRGk41qGTP75sYVMtKD5HGYEZvv8TvyJnAqGcZmN9ot5llmwBQPCvDWQRCoMoplAwP8rUW7+CGo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8YXlPWxZ9py5TW/Iaigba5Ny1iV73AIXleC+KIUVyPgOldJm4D0EaV0zb9gtjYxsUi16lxfZmc+Ks5IDp03MtQXuh8NeZ1NIEIqI9wlFqfiyfctHMucnf6znjiYrCKS2yihjoXsSaFPT/CjbTfzKQK3ed9paYjNW+KOHQOa+zFrWCFY95iDRQO0NEoLKn3xob/IZOIafF3zoquKZ4Tlm6SrHzj2NnOrp4zWwihTF/C3htL3sMOUutwomhjt7YxUmo6/8aaa6nyHGBa2t0o0JIeMCrLrrBHIQ+Rz3yRG0edWuuwl0Mkc2C+22Oe6b4c3awQZ4kNbd6ePH3+N1WL7HZxu14L6CRVLvre7k1ZPu13/HGPndK7eGOS0pDRkdgei+vb24qUqaPktAVGBUXPL7L67jtIcqDwYflZIREn8ar7VOfUoTlShR8BjiU1CGxPVh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:30:35.5863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b9dbb-f5d6-4d8e-48a6-08dec070748d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. The CXL Device DVSEC offset is
discovered at probe time. Probe, fault and read/write paths then branch
on that to use either the legacy BAR0 polling or the CXL DVSEC polling.

The CXL path polls Memory_Active, requiring MEM_INFO_VALID within 1s and
MEM_ACTIVE within Memory_Active_Timeout (up to 256s) as per CXL spec r4.0
sec 8.1.3.8.2. Given the long worst-case wait, the CXL poll runs outside
memory_lock with only a quick readiness check is done under the lock.

The poll loops sleep with schedule_timeout_killable() and return -EINTR
on a fatal signal. This avoids hung-task panics during the long
uninterruptible wait. Extend this to the legacy based wait as well for
improvement.

In the fault handler the wait runs locklessly before memory_lock. If a
reset races in, the in-lock recheck returns -EAGAIN and the wait is
retried rather than returning a spurious VM_FAULT_SIGBUS.

Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout field.

Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 162 +++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h       |   1 +
 2 files changed, 151 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..4829ae29cff0 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -3,10 +3,13 @@
  * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
  */
 
+#include <linux/bitfield.h>
 #include <linux/sizes.h>
+#include <linux/time64.h>
 #include <linux/vfio_pci_core.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/sched.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/pm_runtime.h>
 #include <linux/memory-failure.h>
@@ -64,6 +67,8 @@ struct nvgrace_gpu_pci_core_device {
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
+	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
+	int cxl_dvsec;
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -242,7 +247,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
-static int nvgrace_gpu_wait_device_ready(void __iomem *io)
+static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
 
@@ -250,16 +255,97 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
 		if ((ioread32(io + C2C_LINK_BAR0_OFFSET) == STATUS_READY) &&
 		    (ioread32(io + HBM_TRAINING_BAR0_OFFSET) == STATUS_READY))
 			return 0;
-		msleep(POLL_QUANTUM_MS);
+		if (schedule_timeout_killable(msecs_to_jiffies(POLL_QUANTUM_MS)))
+			return -EINTR;
 	} while (!time_after(jiffies, timeout));
 
 	return -ETIME;
 }
 
+/*
+ * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
+ * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
+ * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
+ * 101b-111b = reserved (clamped to 256s).
+ */
+static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)
+{
+	return MSEC_PER_SEC << (2 * min_t(u8, timeout, 4));
+}
+
+/*
+ * Check if CXL DVSEC reports memory as valid and active.
+ */
+static inline bool cxl_dvsec_mem_is_active(u32 status)
+{
+	return (status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
+	       (status & PCI_DVSEC_CXL_MEM_ACTIVE);
+}
+
+static int nvgrace_gpu_test_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev,
+					     u32 *status)
+{
+	struct pci_dev *pdev = nvdev->core_device.pdev;
+	int cxl_dvsec = nvdev->cxl_dvsec;
+	u32 val;
+
+	pci_read_config_dword(pdev,
+			      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+			      &val);
+
+	if (val == ~0U)
+		return -ENODEV;
+
+	if (status)
+		*status = val;
+
+	if (cxl_dvsec_mem_is_active(val))
+		return 0;
+
+	return -EAGAIN;
+}
+
+/*
+ * As per CXL spec r4.0 sec 8.1.3.8.2, MEM_INFO_VALID needs to be set
+ * within 1s and MEM_ACTIVE within Memory_Active_Timeout (up to ~256s)
+ * after reset and bootup.
+ */
+static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
+	bool active_phase = false;
+	u32 status;
+	int ret;
+
+	for (;;) {
+		ret = nvgrace_gpu_test_device_ready_cxl(nvdev, &status);
+		if (ret != -EAGAIN)
+			return ret;
+
+		if (!active_phase && (status & PCI_DVSEC_CXL_MEM_INFO_VALID)) {
+			u8 t = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT, status);
+
+			deadline = jiffies +
+				   msecs_to_jiffies(cxl_mem_active_timeout_ms(t));
+			active_phase = true;
+		}
+
+		if (time_after(jiffies, deadline))
+			return -ETIME;
+
+		if (schedule_timeout_killable(msecs_to_jiffies(POLL_QUANTUM_MS)))
+			return -EINTR;
+	}
+}
+
 /*
  * If the GPU memory is accessed by the CPU while the GPU is not ready
  * after reset, it can cause harmless corrected RAS events to be logged.
  * Make sure the GPU is ready before establishing the mappings.
+ *
+ * Since the CXL polling wait could take 256s, it happens outside
+ * memory_lock. Only do quick readiness check under the lock. Legacy
+ * keeps the in-lock poll.
  */
 static int
 nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
@@ -275,7 +361,10 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	if (nvdev->cxl_dvsec)
+		ret = nvgrace_gpu_test_device_ready_cxl(nvdev, NULL);
+	else
+		ret = nvgrace_gpu_wait_device_ready_legacy(vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -313,9 +402,33 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(struct vm_fault *vmf,
 	pfn = PHYS_PFN(memregion->memphys) + addr_to_pgoff(vma, addr);
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
+		/*
+		 * Exit early under memory_lock to avoid a potentially lengthy
+		 * device readiness wait on a runtime-suspended device. Any
+		 * race after the lock is dropped is benign as the re-check
+		 * inside the scoped guard below catches it.
+		 */
+		scoped_guard(rwsem_read, &vdev->memory_lock) {
+			if (vdev->pm_runtime_engaged)
+				return VM_FAULT_SIGBUS;
+		}
+
+retry:
+		if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
+		    nvgrace_gpu_wait_device_ready_cxl(nvdev))
+			return VM_FAULT_SIGBUS;
+
 		scoped_guard(rwsem_read, &vdev->memory_lock) {
-			if (vdev->pm_runtime_engaged ||
-			    nvgrace_gpu_check_device_ready(nvdev))
+			int rc;
+
+			if (vdev->pm_runtime_engaged)
+				return VM_FAULT_SIGBUS;
+
+			/* Re-run the wait if a reset raced us, not SIGBUS. */
+			rc = nvgrace_gpu_check_device_ready(nvdev);
+			if (rc == -EAGAIN)
+				goto retry;
+			if (rc)
 				return VM_FAULT_SIGBUS;
 
 			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
@@ -712,6 +825,12 @@ nvgrace_gpu_read_mem(struct nvgrace_gpu_pci_core_device *nvdev,
 	else
 		mem_count = min(count, memregion->memlength - (size_t)offset);
 
+	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
+		ret = nvgrace_gpu_wait_device_ready_cxl(nvdev);
+		if (ret)
+			return ret;
+	}
+
 	scoped_guard(rwsem_read, &vdev->memory_lock) {
 		ret = nvgrace_gpu_check_device_ready(nvdev);
 		if (ret)
@@ -846,6 +965,12 @@ nvgrace_gpu_write_mem(struct nvgrace_gpu_pci_core_device *nvdev,
 	 */
 	mem_count = min(count, memregion->memlength - (size_t)offset);
 
+	if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {
+		ret = nvgrace_gpu_wait_device_ready_cxl(nvdev);
+		if (ret)
+			return ret;
+	}
+
 	scoped_guard(rwsem_read, &vdev->memory_lock) {
 		ret = nvgrace_gpu_check_device_ready(nvdev);
 		if (ret)
@@ -1143,14 +1268,24 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
  * is beneficial to make the check to ensure the device is in an
  * expected state.
  *
- * Ensure that the BAR0 region is enabled before accessing the
+ * On Blackwell-Next systems, memory readiness is determined via the
+ * CXL Device DVSEC in PCI config space and does not require BAR0.
+ * For the legacy path, ensure BAR0 is enabled before accessing the
  * registers.
  */
-static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
+static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 {
+	struct pci_dev *pdev = nvdev->core_device.pdev;
 	void __iomem *io;
 	int ret;
 
+	/*
+	 * Note that the worst-case wait here is ~256s (vs ~30s on the
+	 * legacy path) and may block device unbind/sysfs for the duration.
+	 */
+	if (nvdev->cxl_dvsec)
+		return nvgrace_gpu_wait_device_ready_cxl(nvdev);
+
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -1165,7 +1300,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready_legacy(io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1318,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1196,6 +1327,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	if (IS_ERR(nvdev))
 		return PTR_ERR(nvdev);
 
+	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+						     PCI_DVSEC_CXL_DEVICE);
+
+	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
+	if (ret)
+		goto out_put_vdev;
+
 	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
 
 	if (ops == &nvgrace_gpu_pci_ops) {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..718fb630f5bb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1357,6 +1357,7 @@
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
+#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
 #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
 #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
-- 
2.34.1

