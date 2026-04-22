Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84443168FB;
	Wed, 22 Apr 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865794; cv=fail; b=CSrmnyfQQkK7WFPOaWP+mDmU1TKQUD2CJ/sI2NSM0pIHUQaRMxqJLC/JZLca+yER7XbZ8vtRKA6S3mg3fM4G96UraZsPXowlZg7c2ztEoZnai8vM/CaET1AtTbp2iMy6SS0PylZV/GHyeIfjG56l8cyDPIqFuA9Iux11ipHbzOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865794; c=relaxed/simple;
	bh=O8HLv/YmzGRgf3PDSDPmYeV5mPmG9MlUo4yRgit/v24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jv6JSDQS8yzDz5ggiXWfroe+6eLLItZVApCiGYqmCGLsgHQc4BkdKEcayY4xGyYtYoWsNu00yqr6x7qQJSi1HcIVIGc8VFTUxKT/atIk3cld1eaDVn1J5SyuC3p7OVnmunqCo2dwQdj1lDWBXE2cTklbtAJx6pebMc179JV+psU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ki79IvRo; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ki79IvRo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIXg/KD4qBs1yIkcaig9eKG3gGk3/lvYdQ5gD2mvyih0wYUHAnwTJ/mpt4A9Iq45izqvX93WElZMZ4geGFIGFxTMKctYumITP9kfJ5ZI8oPv27VDGxKbVS6wmj1O8JHj6SBEjmO8/uSriizRS/CxCqG09hddDRXYx/GrLc8w+s4rugBuoMIxKA1tatcqnGa3hGEcc6C1VrrapWVQJwJ+RoBXS+JwuD7D1I7ItIjBHZ55fc9VgUJzNbMFMWsZTnp9CyUhfJxd3Z1JwaR0+mIMuzCnXIX3ppKubDjYh/zj+CWO7qqOh1+zfKiGADstdC7jaCV2OyalllrgJ37ETF7SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N7lqhEExXkzNpxPJoBMFISj4bPUtzKeYFLFQkVAyqU=;
 b=jsRmhacz/VHDbsdOxGZPxVow7gQC3b1IiwlpG8UmeuLCG2Tp6uUDBpoVc6/ql3Z+2JmV/UKaKSzjejl9f/+OFMgSxiZCW0Znox2/2IHBrj1HsCI/n64kbMwXk9h/9xgXwp33cLbN+OYEbX1stcDfVCTJduPeqYDPjmnfDNiNcYiizQt4vHb8CY6gkcF79MCwsGyfyAikX+fuQh9GCquEznBpy6RcPwOhY4YYYqnRn2eDbgUxtA9KKiBMcnu8t+qHp9jHd3iTAbaGxFxXrMwgLiRd6JUyRPwSX+qkmDoQgTxpaf0EuTyDZCu2Ka9twm4JDXfMPzdNYZFpIZIgn5axjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N7lqhEExXkzNpxPJoBMFISj4bPUtzKeYFLFQkVAyqU=;
 b=ki79IvRon8oBQp+L/2NikbrBJ+BKEN58LYK4ML/NIMdeNIIJjc+3fiVfuIv0afgNqmGadnRlmE6Rp0yO5Xo0k72vCykWrKQ5+4wezzqr/SEbOd+CmxO1muTc45MXHHqJTBpBm+7P+J0IT4cnlzWWM5/uhI2BiQ8x6A0UAiRh4sqzEX6tMbQkXJxdswo/Cx0jsbKg1hPQWWwJxwzegCNuo8UMA2T1O34U9t26+XDYE20Fzd+jtFyTDJyjEces+x0RuMpkJk90toIsZJvP4Mg+kj461Ks8c+6rqcJ6+/keDGii2xYZNC2tw+wIW7I0MIk7740q7X3VIYmhbufWCf1MvQ==
Received: from PH7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::18)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 13:49:44 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::ee) by PH7P220CA0069.outlook.office365.com
 (2603:10b6:510:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 13:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 13:49:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 06:49:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 06:49:26 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 06:49:26 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v6 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Wed, 22 Apr 2026 13:49:26 +0000
Message-ID: <20260422134926.653211-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: edc38090-702b-4f14-6ec1-08dea076026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ldah7swR7/6naHksrK6xh6IZx5UAJpKywtogj+YEphT1SctFAazAX5XJ8xzL8lu5mFKl9TatdF3S4dZNenVsUn/YN4vsPx8vJ1ah/jxkRrsuDa7VfZaMDpRf4BtOoHjiXPDE887ulRCEb4lkcNt6akA3axRWcsGzOhIdo0ZLaPfXrlSbsPALlZpbcpjad3ap4r58r9uzdSVjXkcdiMcKzeIdfqvHg/WLFiAVaEfTZ71yVqjW4IopQLM1lKkuwLxYG/u/5YoBBJiOEBZKUbU4pSCJTBtka97pYJsFn2KCbs8zcgxZlC9AV8/kXZJ+xp3v5ImwYljnzDoAZKQKUzLY0HSJJwMGdAzyoj/FuKDsu8jOiw85TH0N2Wht2/547KVM6vdBAlFe2UJls5+elR8E95UPJp3A2TFdUmgh94biSY3HmZVjWbyG8PNcH4jqRmA4eStzyqe75zpZ0UHmGHmdht/ra0srmMUaPugwLmrTc+fBRX+OWrkut/iyGEQZH4CUUa8d6XQMU/N6DoxOxet1CS3YDsD8fFH1uQkuLM228cVE6kq83TtJSaUGtLmYRl6hRS8oiJDWWr+Jxr+Wx1PuSjQoeTY8Pad3dZl6F2dvUmiCadqYk36UvH5gHa8gwMqoKl1FEbAiig8XWSsCeLHuEOvHKgJx2ug4KWf+FuLNk0Hci5fVl4GfOj70rF00cpDzrSI+gpm4WzineN3qEcfOiQe6rj/lPgeVhe08GEoH9Wvtwf7ooi3Y6ZXXtqv70ENHIAXwBXb/qfpIgI5af5+zIQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WBTk3pKJTiozCBZAuyOFCLgbXd1g0AKGGxApZH+y+u2EqJwy1/SZdq4srFRWyH/C6MenOexu0kZVYJA/f11Q6bphRWyFzwh70maJ/ZXwWQ62GoudGKvGCN4RRqLztierK/Q7CV3I7G2asjmin5ufQBOWqQ0tyoKDx6p1a/J2Xo6cPBlkdmN/E203hmL5VrbpXLmZV+UCF6q00E1K/zriTDNS5CM1twQXC2r8nAjgGdMHXTRU5nqK4lI0HejipTht6zusDsb0h5Qp7NfS/anIdHltySzR4p/Na1g78o1ZvJefuqrWDIft92l0YBjHtWPR7t29+VA0ocUvEl68vQ5BEQ5oqslTd5F8rN2kg2SzmeRnRsucIHR00SNpOGA+0nOAwAYEcU3yU07bYEZt7BTAnsHzhzWYBQvqqxuaJS3EaqV3QqZZGS5AYu75N6J787eA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:49:43.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc38090-702b-4f14-6ec1-08dea076026f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. On probe and after reset, the
driver reads the CXL Device DVSEC capability to determine whether the
GPU memory is ready. A static inline wrapper dispatches to the
appropriate readiness check (legacy v/s blackwell-next based on whether
the CXL DVSEC capability is present.

The memory readiness is checked by polling on the Memory_Active bit
based on the Memory_Active_Timeout. It also checks if MEM_INFO_VALID
is set within 1 second. If not, return error. This is based on the
CXL spec 4.0 Tables 8-13.

Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
field encoding.

Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 107 +++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h       |   1 +
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..4e1d20ad7510 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -3,7 +3,9 @@
  * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
  */
 
+#include <linux/bitfield.h>
 #include <linux/sizes.h>
+#include <linux/time64.h>
 #include <linux/vfio_pci_core.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
@@ -64,6 +66,8 @@ struct nvgrace_gpu_pci_core_device {
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
+	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
+	int cxl_dvsec;
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -242,7 +246,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
-static int nvgrace_gpu_wait_device_ready(void __iomem *io)
+static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
 
@@ -256,6 +260,81 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
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
+static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
+{
+	struct pci_dev *pdev = nvdev->core_device.pdev;
+	int cxl_dvsec = nvdev->cxl_dvsec;
+	unsigned long mem_info_valid_deadline;
+	unsigned long timeout = 0;
+	u32 dvsec_memory_status;
+
+	mem_info_valid_deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
+
+	do {
+		pci_read_config_dword(pdev,
+				      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+				      &dvsec_memory_status);
+
+		if (dvsec_memory_status == ~0U)
+			return -ENODEV;
+
+		if (cxl_dvsec_mem_is_active(dvsec_memory_status))
+			return 0;
+
+		/*
+		 * Once MEM_INFO_VALID is set, derive the MEM_ACTIVE timeout
+		 * from the register.
+		 */
+		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) {
+			if (!timeout) {
+				u8 mem_active_timeout =
+					FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
+						  dvsec_memory_status);
+
+				timeout = jiffies +
+					  msecs_to_jiffies(cxl_mem_active_timeout_ms(mem_active_timeout));
+			}
+		}
+
+		/* Bail early if MEM_INFO_VALID is not set within 1 second */
+		if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
+		    time_after(jiffies, mem_info_valid_deadline))
+			return -ETIME;
+
+		msleep(POLL_QUANTUM_MS);
+	} while (!timeout || !time_after(jiffies, timeout));
+
+	return -ETIME;
+}
+
+static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_core_device *nvdev,
+						void __iomem *io)
+{
+	return nvdev->cxl_dvsec ?
+		nvgrace_gpu_wait_device_ready_cxl(nvdev) :
+		nvgrace_gpu_wait_device_ready_legacy(io);
+}
+
 /*
  * If the GPU memory is accessed by the CPU while the GPU is not ready
  * after reset, it can cause harmless corrected RAS events to be logged.
@@ -275,7 +354,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -1143,14 +1222,21 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
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
 
+	/* CXL path only reads PCI config space; no need to map BAR0. */
+	if (nvdev->cxl_dvsec)
+		return nvgrace_gpu_wait_device_ready_cxl(nvdev);
+
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -1165,7 +1251,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready_legacy(io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1269,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1198,6 +1280,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
 	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
 
+	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+						     PCI_DVSEC_CXL_DEVICE);
+
+	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
+	if (ret)
+		goto out_put_vdev;
+
 	if (ops == &nvgrace_gpu_pci_ops) {
 		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
 
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

