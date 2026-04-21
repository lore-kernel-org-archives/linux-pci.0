Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793222A817;
	Tue, 21 Apr 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780437; cv=fail; b=LnV1PYW0YmVgQ3QO6dOJEGtJwzmEoeR7+x7y/sq21yiRmqucUfQCp9TK3ASMCuNqxp2lh78w5lP0P3TDPE3/svtV/aKNGJ1HriRm9VlDTbTghH53IbIGTr9e/7yGp1DBG9YAqYKiD6AgKrBOOQdiFhqR+/hWG4ZSZCw78kbim+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780437; c=relaxed/simple;
	bh=AEFId4OfriJ5ZUxJatkYxxyITOWDgIIJjVcSiBdkgBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehBnWxqwWbhexDMTj6jcC7fY5d/wjwWnFHfH1P1E5yFwMKJBm/D4XiM+K77HFegZc5hRkGfm5+BD+RHggwXViasOquiiO/KzeAdDYU4o/oO3pklqshloKGQDyVj2lm8XyySPLw+Ic3ZpDDGaMDe4YqFDjJqPf0rLK7rfp0i3Hwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XyEXdC8b; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XyEXdC8b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCl+x3DN6ybS300w0zybxdnOFZDpDFHqaJCONl+QLcYWbq2FsFSZcpiArfFMR80M10v3rMmnrmiPKmtOCnCU/iTzA6zyn82pbTY+5thFODCLp6Kys1tRKIwQ8hQLMyuYJnm3SvUuYKsW3ecULZ5UCMuXHKwjMC053IpfyKx09RFATMm8Q4DYYeIAlbfBuRxiLamPxs9VT2t8SYmlBQpAIdVyH5kRo7N/+4pM1b723WuHFzYZ1q+HwV+7fG6Yh98kgZNhberI5R3sNAiIEizkQo1htobtRgEn24+CDbw1K/QJn3WfjnPmCOfC2rm2ANOKcFQbvbaUoSQ3SlGaGzPelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE4MV+paewvYOV3cO4ngXyS9zrvfipDwfQ7KxHByVHA=;
 b=FOGGyZpym0CXDUub5hOmv3M1EhRo+2S6KAAOVt5fS3l1zily/S2pTxh+vUP6pSKeDkdYAKt43h1rXcLVva7HR/vKvIM0j6/QSPizjLMi7BnG2hLuOzu7KBvFOLUsMn76HvPhOGWr5+eBaSBZ04Is2WZBUD7hkVySROY8j9cETGG0cK6VooQxsFLzqhg1+HRiyeIxS1dpBAe1A00EXJvjvxPGGIsWh5Ugnt8C/siHiRIeTHNQ7CQL4A9OjJhjoMvQQzrGc6wXIXjgkZEizYLeIWvXmM3qeoCp7/p8RaEZ/r3ugpFYlLtzVF2W0q5tfAjzWYMnndW9mhxd3PdVY0hnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE4MV+paewvYOV3cO4ngXyS9zrvfipDwfQ7KxHByVHA=;
 b=XyEXdC8bBCkQRllQOgKS5sXvfmBgMMmeBMA/F1pvh/SPs01/ixqq0ULn62hlHn1mA1thA0DqlAZJj81X1kQGvKUdVZYlCbpVSAceAQtzmjEP+U2KC/Qq+hG00PTiyyxvO6WS7LYsDj5/OycdCCQdgbdHY92tVia+NH6wCe+wCTS/blhB/4BX8blsONJ+gTQEuLObBDgAG9dHQdPDNHponFnMmmpYQFtGnzAGiubzVew84liIf3P4rgpmirT3ZM8MlKmrs5vBWDA6TgSSjYkhqLJWN6wiOXN8LvfKp8l1GbBEoqbghOvJMIev6ttx9uxOnWwPOv7imx6FslkCIzZbkw==
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 21 Apr
 2026 14:07:09 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f8) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Tue,
 21 Apr 2026 14:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 14:07:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 07:06:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 21 Apr 2026 07:06:59 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 07:06:59 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Tue, 21 Apr 2026 14:06:59 +0000
Message-ID: <20260421140659.748577-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb13472-13ff-4baf-c96b-08de9faf4668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KX46BxXgwxZIx3iNoz+oYvOWwCScucyEYP9M3W59sR/+9003FaLaQ8ZCVRvcYR3W1wl2pbRgNIFlWUltC9PVUrYvt0OZpHlEYococz8sH1fvUeJUa8CZAAnHOJSjG1XHh9KZil594GatkiRkcwzSnDLZu/5Ze6DHYUfXr3Xy2LmDodEEysJ3mytNvwn9WMH3TOVTn2g1M/eXH9HvMDNo+FHMrT3xerglsTUZ08ny7oFSyFu8UpK9/ilNTlklyWNhZN8rhvkeeIXIwR6m5mf6SrreCFgeC/HqWWeQ/Nd4C5Uh4dPVKAl/5SUVPGw4pyCZjM/0Me3wGG+Kf8vg0sUXIrt7xL3wEnO+/vqYNhkSnQCIzUpyiDEIouXsaBuW/vInrCtDp+n8X9W3KDFzdC+gKA1mnKgmASuvTyNHDYxiPI6Oc/uKOuO4ucKE60yCHgpz3TYQZTIG4KioIS+L76FrhEVCfhopm9eM8CJxWVWeWWFwtLCiXKPpYv+NhRNp7Sqg1YD1markMqYDtWxQRTwEvIdAKLM8plyMiSdqkT9KDYG8C/oTcu2FWsCxgVNImbSuNKzmM0XTcUpKiSXFrV/yQ9NZ/s8w3WzHUN6ZLoVfs8e2J2V/y2c57lbnDi4OHbhnK43gv4WSTegqR3Pk+Y5MwZUuBDcVUJuJDDCvjOTMTEyisl3Zg9TMcTIsvaWF7cq6u0lrFN1n4RkU4n/t/ehz+3ECXGIrIbCnmUUVexT9sXtYQnQFQbaE9AWIpRkSmjBhTcq4gm2KYyTfgeMFXB4eSA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CZHG4CS77Nhbk7cZd9dtGVzlOeZ/OjvmJnK3sVtwo1AfzfbnZTIngt6k4ik5dnO4Ns3Bt/w8Zd0q/yRj0Kz88Y4pO1LicDga7cQW311yhqaKLMTLtKSaE97DzxGrfXsHxUHWnrJhA+rIysWr9KlK0e3rKRgeB2g/U9DNzVHmByA9QsHzpbccugjNFgXSFWFUVmCzAJsclfOFLAfsjVQgePOwT5JlzCuWZ6Lf5mfoPk/Vj2QT0VlFMc/5e7Qr88tDkO97V/9l7l/U4wH4ivTB1xEWtlj/9xJRnkOa2IvG5kkuCRrOBjwPr4YZ0tKoNX8/nsC4GpvLDaNr1kaE7fgrJjvu0WKoUoZlKEUkS1m/SUDcHn3pu12lEQkSZrBb+4CNYZlNsHYpFrG1RzRqjaSwxg7W8cvMOtW16LWkjNBakeF3tGRgHFcAznEBbfW4kHhc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:07:08.2306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb13472-13ff-4baf-c96b-08de9faf4668
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

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

cc: Kevin Tian <kevin.tian@intel.com>
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

