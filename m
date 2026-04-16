Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58F1643B;
	Thu, 16 Apr 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303932; cv=fail; b=sExZ2wq3Ch8xrSKaukQPrVZL4/qBR1c+0WfbpQeCDgpuhZjKE7AkGadtbp+O+WI/R1ko8zhRPB8k+0goHVwL17b+pkNiiHJk+gpCOftF+dfvpp4r8nibIAEqQL7VUSwA7mAbJZ/9YVj1tIaWdCyL7yCArHO29rw9JpK8CSPv9Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303932; c=relaxed/simple;
	bh=zyy46RCeSc6gcpsPMeHG3R7Qnm5WRGOy2WdJakTxPpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzf1FScU/tlU+oRcIVtfKQytYgdZZFE+bKVQaLUh6P762Se8na0EVaI83FNokIrF9CYbpxM8anxo41JG/uERAL+Z4z9xNGhgFBcBncPgkkZt2SYC2OBeU4+dazeLDrOZQDLY5Kw/XgVDuKQy5TH9sBlcYpm3oweaZ2XzkcHVrM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nk6Zb2+d; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nk6Zb2+d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqVJduAPZDRIyP2ZlalvVwajtfgAuwOx+yAgLDNiiksKLoYXotSUqRtqeJt0ynsTTn+IbzBPijRolxjQuHC3HIAY0SWRPeMM/6kBO4OZDySFEI6FMiU1R9tInnRcYWsCZFPGVXt33Gebwxms//2VnohFHtI3EbuW4Zwx2smLo9GliuRWRI9mf9kHNBTnaRp6IWyitQFNPLJZauEMw7RL5koWLhwhF7akbkhsxAP+GIGN5U4EUINs9BXf7shhnLMGJJtqQwkHO1BHu2Ln0vP+Ggw8pc+WFRI7izAKs9xZvokEajuwe4a509mt4kB/Zbs8Y6iW3wlSbMZnBL3gjBWQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVrF2afIAO04+rkv1v9aSPXIFRC8O7Y53EIltUpShl4=;
 b=FwxyP+DeHZtZCJ64KW51mOxC5Jp5FojKwpJfNqL8CLZyVz1onXn2h7mRIPaOeH0FdmCkvIu4XZvRV+AQ/FW9Yb8IElG27ybY5Ug/Z0Cs8OfKCE+0p4FQkUuw6KNKip0Ucrr+Xtfcj2qE1U+Jcq9Q3kHA2dxcWmWcEPBiUhyIKx537RMjzh49mg3Jjr4OD3WUkQ+Hjs4y9y7AiZMknvwCMmQEkADJGBwtR8sCGJCmGz8OXSP0PbwsKm9NXYJ6JFZNeUE7jD3IkuggPepMHz+mxItT6jVtw8sidDve/IHQCneuIhnaxJTwpZ7jOtJX+DoizqB+O+viV9HcGbNCioYCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVrF2afIAO04+rkv1v9aSPXIFRC8O7Y53EIltUpShl4=;
 b=Nk6Zb2+dhGinMhNXQ/cevS2VFLao2d9X7plUMmCHuQycgqfKq/wYxJ6vjXrWrkHhwEM4jLDiGH6VzSA0v7/yTwt3es2e7dSIPoxSeUqdFs1bnQ3A6jFxQAFgrG3HgSFX8Q78YZ+ITmLT4D/A58f4phv6bpHH+1LPSxGQu3jF4Wh7vSyT+9jPMGzuA5QZeMD77Ni06hc4b7INYTrvSgUCF65OzDw7hF4qPFX0yf57hFw+h4VHL2vQ1JIn2VlNOvgWxgsazoeydjbvlFAVKA+rbu+U4eT/E1jT9HAMrWjr7I6q/tcQLii5ZOr1Z1gQNYWk0Q422RgmdsZNwOKlsNDtIA==
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 01:45:22 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::db) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 01:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 01:45:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 18:45:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 18:45:05 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 18:45:04 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Thu, 16 Apr 2026 01:45:04 +0000
Message-ID: <20260416014504.63067-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: f086d314-f634-4995-c188-08de9b59d26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XQL9iueo8QI6007w7jqNKFw6rNwRRYurtInnezQobIW5n+CmBauQsOo26EufpLD/IvHkq/7ie/akjIO8lpRzVabzJVBkVL3Bo1Vgmi08xRuhrwabVDhcm6gNEnzjSaWkRAF0DFfOQbZ7Z3osYZvrJPJBiv74hgZxjyWjEvCRzcs4oxyjcfFkIQI+Hcf5dIHXgNka9oq/oKGHMR1jYeoAPMc1n7Be+12GNCiCTolw+0OWF+PZua4I/gTV5fRzBfUljfLqzGVOPua7JR3B32+Ywe35arP3N5sw70vvfsLX9dLQaZ7Gr1Dm8cmXQnjHWj2NEiU1ijO9ekkHKtOO5fvt5EHZKwcj9ZVmS68A2TrCLxUS812EpoxTbtF1p5eyJUWx0q1Fu2vf9POZfwAlJZCeQPrYlZKUfSWFKdXDtAorJWYGecKoCel7RzeNhb8Nn4TkygeBN86Ih/BpUREVSHTpzfLxPn7P0zjdO7vpTzSNWXngf3wskdZvPiYpgjVvGFfslPrKKm2Of8BzXiU5kXTRF86541e2VrrXsTv9tbtvMnZVCGD/xSzGYzoeiaiGa2h1bRJIY5yragbsCRY+vdoJh9ioh44NTVhcaX1fG6lhFcpSp4gwCEl+O5jX+nr5MN2ihXtPc3Ddt5RtFCJWP9s0pcQEowyx0edJYKkPZ/Z/O/8d2qGoV2By+ACiQQASdkSIsMsu96mTvLuTJuljpTyHO8bKCZFuOF7kQFpMQJdWtsONH5nMhFQ5+QqsKCvR+8ANadTm4A0KKkrQUY9VMhwyTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cYS39FNVHGu5UEYJ8PLfcZiwjFefzjeJ8yKYytY6MErN8nFLCKSjTGxuOy3OAKEWul9pe5792R2r+luTCFufeM2u/EZM3fspdQToDBIzoE5T+gFdOfGaImJLgYgmdNNB+MV5BOSJwZT83Y/YQGETzmgOpVkwZMLp0M9ooeh9+V12B4Bdv1oBZbi6/pBfrmS14oTMkvZ2D7L4rNA+p2/kL7IDufCySdv/7n8D75/gkDAHqbRS2hUP31KpfKQtg3OqWlwF0mliFMzr54+1EI1Yiqy0hc4EPsnqokSxWpTAXBfaVr3dU9B25U5smcNBIGLOUgh/znApybChSnrtReFhhDTGh8DZk9xnqVFbVo/Z2caEP6HKwxwu5gB0wSXdoaGkmBkMXsmhdfknQF9MKVNZUlu9NgVoxPplmZnH5E28nr1mfY6kgTlj+NDG6UIxVgyT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 01:45:21.6311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f086d314-f634-4995-c188-08de9b59d26f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. On probe and after reset, the
driver reads the CXL Device DVSEC capability to determine whether the
GPU memory is valid. This is checked by polling on the Memory_Active bit
based on the Memory_Active_Timeout. Also check if MEM_INFO_VALID is set
within 1 second per CXL spec 4.0 Tables 8-13. If not, return error.

A static inline wrapper dispatches to the appropriate readiness check
based on whether the CXL DVSEC capability is present.

Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
field encoding.

cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 96 ++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h       |  1 +
 2 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..70020af85901 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -64,6 +64,8 @@ struct nvgrace_gpu_pci_core_device {
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
+	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
+	int cxl_dvsec;
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -242,7 +244,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
-static int nvgrace_gpu_wait_device_ready(void __iomem *io)
+static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
 
@@ -256,6 +258,76 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
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
+	return 1000UL << (2 * min_t(u8, timeout, 4));
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
+	unsigned long timeout;
+	u32 dvsec_memory_status;
+	u8 mem_active_timeout;
+
+	pci_read_config_dword(pdev, cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+			      &dvsec_memory_status);
+
+	if (cxl_dvsec_mem_is_active(dvsec_memory_status))
+		return 0;
+
+	mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
+				       dvsec_memory_status);
+
+	timeout = jiffies +
+		  msecs_to_jiffies(cxl_mem_active_timeout_ms(mem_active_timeout));
+
+	mem_info_valid_deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
+
+	do {
+		pci_read_config_dword(pdev,
+				      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+				      &dvsec_memory_status);
+
+		if (cxl_dvsec_mem_is_active(dvsec_memory_status))
+			return 0;
+
+		/* Bail early if MEM_INFO_VALID is not set within 1 second */
+		if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
+		    time_after(jiffies, mem_info_valid_deadline))
+			return -ETIME;
+
+		msleep(POLL_QUANTUM_MS);
+	} while (!time_after(jiffies, timeout));
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
@@ -275,7 +347,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -1146,11 +1218,16 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
  * Ensure that the BAR0 region is enabled before accessing the
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
@@ -1165,7 +1242,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready_legacy(io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1260,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1198,6 +1271,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
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

