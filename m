Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A013D8108;
	Wed, 22 Apr 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861217; cv=fail; b=ppTzIbUm9u5fqmTxsvjXYvgFRuGoh9eY4I0ZZSCjb6KzKJSq5phdySWFetdplGLhvQxzvVdOg2/ji8zv8Q25+f2w00ryq6EdgNDcnVI1WjdJ5EJmXAG2Qw0oqUsEhwSmbWGlvJWvR6Gk16+ufofxytPTkpkR0avdr+flIFiC85M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861217; c=relaxed/simple;
	bh=ARlL2lZWkT3ER0ERC1aMfJLVpZOGdhbKKTyr4xozUR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EfWBmpe35Vx0/EH4LmJ261EHMQ4qBFhxkYKXLMbOX2wNsKL+WcjQfJAH+Ps/7fs9kove7x4NjEIIvSQWkW4hxveA6RF5pIlejxLcJ8k78KPRbW4r3nwlB+/yhYDuW50sVYAdqEtJWEfRzhfi/hcm9jWaAPBBJNFzrMZv29oeZYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZCVog5t; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZCVog5t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o34iNZsQqnxJZGSGc8w198OmpoY6YDz2ajOBv8Ui2dq/8f1MrkFq7qQ3OoM2nTPVZEhC1G5GhISy9EOED8sga22Nfi3p42Hipxgkc3a7HtG3G/EDRe2NDChHJpr8vInsA4hOrvBpSOzYEzVCFDekIGO8KVpjkqjsqHvoJeIWwFKk7CPgSPFB3AzTVlw40JXqzgeIXek1wRCPJ579WUKVmgQnPl+RPQaQScw8Fphz7XJL/4pgIgVkMsYM5DJcZImKCLcIxjzd6UIXJbeaKJk/IxULffEYgkAjdHSe9bRge92l/tXwd+3tAILJVnMbvQRWHj2bMuZdu2hCwVV4CRipIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wWPDEdw5fdqchyaSimu5EbEks8IP6ya1LAsTYt4P2w=;
 b=F3JbbQ1uib5IJ1w5T5J7hbTUvpWhSPJsMP2pxb4K80btr9F7+M7uOT5VPEsYJ1JFXXjn4lcr/nVFPc5hfNJqcEMnI4UPqkWyQTvZs7tBmp7wWsCtDRrhtYJiLfeg9sL0/fJF5ClgPpgzqSWj07m50Y3SP+hPrj9WCrC2HdBK+URY5enxs9aXGIL2ugAijewtGhkDlUyHnUcGPp8xIrJdyF3KZmCa6VVB2tM24VLcQE6w8vqC692q90iuBceZPBFWC3a1o/KdLjgii/plaSdEH8V0IWYJ7/58j4pM7ueL9YhsGpoW1eHVD5a5bMy+mGin6+R2Rn6TLtjnhGVOFYrjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wWPDEdw5fdqchyaSimu5EbEks8IP6ya1LAsTYt4P2w=;
 b=jZCVog5tyhtuPr5+nPWpGjhzq19XgVeje4oPArB0QiPKh85wVWEZXP6U95Yvw9j9/W9PVXmv/gOzQ1UuRVSlOASqI+6fF2sApEX4wC4xigFBNxWKVG42PAd1pPyt3fJG1hwWCnhSqZAywWwWFaP7akbbC34MamrYeIkEmElKOshKJZdhxYiEFgteLlXofvNt5iMOau2M0v0pGlzIGci7qZVg7d19f+Xw7LC6PBRh/KHEUIGrMvxr6x9S6JEBcf6w4YWo1UpltU1KWuRAi//M1j3HgAhsDIfaS7/FKlv9ZTcUbGBaJzRcC7KQCrNS/zvtt77eVOI8X5k+pcAVaJsM7A==
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 12:33:26 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::eb) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 12:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 12:33:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 05:33:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Apr 2026 05:33:06 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 05:33:06 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Wed, 22 Apr 2026 12:33:06 +0000
Message-ID: <20260422123306.286833-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d17ef20-5a84-40e8-3d68-08dea06b59d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kaJ9e11B/iIh+r+xxTqcHSJExwY4k/Y0upNdKRVuz3YCecxpqHIlSwlLimTQTh1aiRRiNrRTo7pPsSFj0CguTrUsaF2ID3Ijieb6dsH0Hg2zUhLR5c6EDnfpwKJ6i8FthD6Sh+6tQHhcJFTVD+o93jqVEthabmHCc28yEKhwLKGr30+xhXwncyVNW7+QIL/ZnnCwofcHy36zKjOpQmGVRbm+jthk+5yUWPDNnA0Iex1JYVUmMOrGX6Qo92LlTiFLdVRZi2lgNtYB6mXr4dIQwBD38af9+8haZPdsUNY6LEHYgkfZ3BoHcTO2garfzb3D0RjeUW4IRRAlbd06lRtwxY1lhGhqeKmiWf1ODcF34q+l0HfLSfYVXWf/Rn93VSKduTWF7XjQ5GB/12QvVkg2fMYZqH6bF4ILkKhyMZ2agAAGbcuV0BsOQAAenqji/did+vgO/al2OnPRImxaE+lUkPld2qyAIsYRWMiINJyO6O8+083MNrJK1Yyrrk8KeFaIfy8Hx8ONWJA5CveF//jABsvL+an/usRFUDsq9FAET0aaatG5EZIqTzSxTUYM8WdECTouOuDJSiP5LMZoozaptunioWHKG86s+nSpwZ/W43f6FKSTHFH/U4OJd3KGGuTQyXmP9mjuYFcPtE9sQl5+ATmE4hkp+UrHrkokMwGHkct5iMU/Rj4nRAGivNy1iGKVxb2GWl48pczaFEmpPqQhFX+awjt1Zn4pB44QBTZhwnO5X3k8tfqmyYmygD2ymi8B/AiwdjhUzFy4tpE+PYctWg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jxfNWdVeboqT1woXvB2+9WlFZO3ael/JFp/xn6vuNg76fyPOrBOgZF9n+8JIdELd0XDMHVXTHJSecpezl8dWhFpTBs2U7Az/MeYuncTKlrTngYUEy81jsHqCe4cQekBtmCBdlcD4XlnkupwsKd2vIRZjd72jgaz0Pyq2Rj8CCgXxlGSbDka9dEyG2QKThfHqvXvfQHsoUSs4i2+OK/ewNQokN5eedigUQVD0Q4Ylyup/hbgtGGZ5ekFFg7CCA8ruLmRtQv6uxwVbW0E71x2aWF45oTo4Wtdxb5CogVx0Cm/fsMVbHpH4Tghzxjlve6scGPIekuq6xyDM48anJ0HKgrHRiB2vJT9kKLjooe4DpkKq3lIc0v/kWWEknctv1bFHN/lwVaFnK8XTT+MmkW8DXNqgpuSCVPMEdmTjNvajoGwZrdlI9okmmJqHjyCQMCWf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:33:26.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17ef20-5a84-40e8-3d68-08dea06b59d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. On probe and after reset, the
driver reads the CXL Device DVSEC capability to determine whether the
GPU memory is ready. A static inline wrapper dispatches to the
appropriate readiness check (legacy v/s blackwell-next) based on whether
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
 drivers/vfio/pci/nvgrace-gpu/main.c | 102 +++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h       |   1 +
 2 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..81a725460112 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
  */
 
+#include <linux/bitfield.h>
 #include <linux/sizes.h>
 #include <linux/vfio_pci_core.h>
 #include <linux/delay.h>
@@ -64,6 +65,8 @@ struct nvgrace_gpu_pci_core_device {
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
+	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
+	int cxl_dvsec;
 };
 
 static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
@@ -242,7 +245,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 	vfio_pci_core_close_device(core_vdev);
 }
 
-static int nvgrace_gpu_wait_device_ready(void __iomem *io)
+static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
 
@@ -256,6 +259,81 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
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
@@ -275,7 +353,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -1146,11 +1224,16 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
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
@@ -1165,7 +1248,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready_legacy(io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1266,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1198,6 +1277,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
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

