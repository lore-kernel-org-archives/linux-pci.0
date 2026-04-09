Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F630BF6D;
	Thu,  9 Apr 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741840; cv=fail; b=Jf8+8kD7gTiZvDymo61FAzJPdX3v3uOEMbp9vmVorE8bBDrdzACgRu39B+1Ygsv74L2N/jPHcWaPlLlIq8lQY6vNqynnKKs1g2yVaMkpNvzGa3t2BvT0ZcOgW5HLJMW6p+Ypm7d0nNk7hx2IxpvVvZ66iy4TF2Ah/eFxF422TBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741840; c=relaxed/simple;
	bh=eAHItLiBYE4yK1DX5WMtG1FQ6t8yJw6XI3451UJzxos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QryMWos3B8PUi9R4qwBKEKpS8Mxo3bZGUfytZ/S044HBZ9qRFAERafardPgdS0Dch158ktkPysHgPy069NMkl2lFuCk7RcrPRm0Jn8+/jwefLw+jr1UxKhTGed/3tJBtnbTd1lSNcx5MWpD7k6fmAaFmtEnTggGHJhHbt0FiAYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hS1a+9hD; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hS1a+9hD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFQ0wXwtbaYvVWaZ9qBUrYHaqoOOSlcrbeOkND9Xw8ISYtOuEiYQ+GeJD4iaIXv6K80543XiJfYLHwE4jLSduxln1TRvaO8wtfJHlWh/FQHIJKMb5br8kOlxKXH6iKpwhTf43nn4OnV2uUqjXF3MqT2ljGvYYhAiaT9QtuNpRSm2I0whpGw/lhbO+SD2D86Gk+ISfoBCOmFRjtXPkUr/vN9H2wNCx0X+kMXWmplLpV/APjf5V2Lvd53l2rZOeWs7D+AuXC0SFZpofn2IdSZjhh0Cw7ulapS6bRiTtcWLNZ0ikbqgL+oQ0yuKUTNb9Dbc+lppBuxK/EZCTlCjPsPrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/t8Tos4Hitv8Im1HTU0NTNJxP6+jfmpame58mpWsrc=;
 b=CBgTIX/ExP/vOMT48wolmfzdJNaAqhtr1jqoC7hAtB2MMQDYK1fpy92FYJm51Vz7Rt7f9E7mKugFVsh9/+1dGezgj/q9vrs6WFCYTw6/rg4WGcvhQhO815N4Slm8FppR12BvKEziShlfNCLfjZPkExhtlEhCHqZvC3xLldWdeLNKJJJqgbCeMUnuKB5Ri/mEMyc47J33ptdfk4t6NkK8A9YXD+ThYKKc94RSrZLyL6UWjEjziAkvy6pTEAAnuPDNsK5Q0lxsUgJD5XIIefgmhK7/C8zkPv+1zCau05na4jdNGE4L5sRcS3rugy3/TSqvP4DIigyNhtQ+LVoZH8aEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/t8Tos4Hitv8Im1HTU0NTNJxP6+jfmpame58mpWsrc=;
 b=hS1a+9hD3YFGlKpP6PFA2wsCI8NZjDsVN6lCdjDJ0hHMHPaHkA9bIQtanSpWg1UOTKHIFvEiiQ5KT6T0kR1NAwh2ZoqlhM+jlLn/AkGXK+8VTr+hzdrsRNqKZiLDeiLDEViOjIdC3qfqF/kDrKN+VPxGvn5AxI73mzAdvKfPCV/crjUsDUg97bnNcn8OyY7YTtA71c04stavmpoQ9cgnebdVdgxDtxpEqQ1ZPvytJri0eSGmXk8feu4gQtqS779WHsb7TDkWNeshjGJVpgXV8/JC5ZQlOmd9T19De5YdKJL+b986r6QvJ/D7sBryaSXF5Gnp9jukUXbaWI4mIVWtPQ==
Received: from BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 13:37:09 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::1c) by BL0PR05CA0006.outlook.office365.com
 (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 13:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 13:37:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 06:36:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 06:36:51 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 06:36:51 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <ankita@nvidia.com>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Thu, 9 Apr 2026 13:36:51 +0000
Message-ID: <20260409133651.92580-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a186f2e-dd3c-4c5e-25f6-08de963d1966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0indadCnXRpxZQ2I2B5XP3mw9EADehAPzxCxzmX17kiKWMjzAaDPG9JpFDXDoUHESO4ucKRY6Y96eIsV+51b8ZaX0km9vPFPd0O6MGr/Lfm2VnEAm1J7odCs30lQpinRYJh876Qag/2qH7zimSTwruJb9xwK2fQ1mNe+wWqjHuXzOlklQHs1Jr4ic6OAxI3oX2NY71bAjPfNxNMw7rrYhan1pTO5Jh0Pr43kIEKtTdaX2aoAeyve5v9P5Sj/0LZ2//UZZqJ3d7lR4ACrTuDC1Hx2vXJTs2+wC8dYp3k+l/swdpcF41ywK1/7ymhXkPTWsBMxlHpf3Xj3NVgIGAJ90o6Xkq+v0d5MH4rK1jBSEvUgoMuwnHXE7A+k3hodmwpM3Tw3g7e8MFRmBeSepKxvyjuI4Y4oAf07hKKSc6dkmU1VaWpNLCqR4+Jj/t8vmDSZX1CKyGuzQpDAwAsKurKyPpdX7HTPkbXmyq3hgEHwvpaH/y6VG5StRBYFIo6MqGv6JcP+Dmygi8QXzNIhyIIVMBmO7zWDRkJYH3LY2i5dVAZUb6FqVMcYOKvYu4W3fy4o/9INquKIAqEIyviO17+9V441c0gM37OoIEjebEIX5uTrHUEgH6/ay7YW005BlBV07M7H2EWDae6Z6nhjbkC4ZW9javgx45Y0+pyApDFIvU/NsB7BDrv9e8EtK17T51TmtdkHkHMJDYgmc4p8vXpJC1e0+TLtAYUEUnPigiXsE2gD7L7nAizIWvy6DVMvUS7wyviNWgenFf1p+h62aRvAtQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3VT97SbBXssT5YYQ2UZJFJUEPRjl+5iIG66pN1QxCQ93s/IsPIcq57qwWfTMSxMyuC1e/0R8A+rCCzCuILox8PAqlHi9xgxnHsZY08AsW0AnznpYPOpCdT4PAUnL5zVctAj/KMqsAE5RoZuoO/h2JOL0vDBNUekhBt2P0htMHhCfzQn+B7kkR0muD/JvlcmqUSjjTNRc082TtlZ9YzWKFrdxULwEYTEsNEiuyVbvfDVWWJhJ49iif/ti8q/qn40F0Hzuk7974TyP0lngUahHdObtplzr8D0yct7CCN2BXU9QJBT4lDATx2iZ/2uM/jMADVhSw8GFOgkyx/y506/9Fc+n+R7+6ZNTpCS4/E3ekFfgyFZcCdN71MdmgUW4r6iTZLfGn39+9uA+UH8xuV0blyPVJSR9g3r644vO0lte1DpYzhhUaWxeeCiKfDxHl1vV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:37:09.4626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a186f2e-dd3c-4c5e-25f6-08de963d1966
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. On probe and after reset, the
driver reads the CXL Device DVSEC capability to determine whether the
GPU memory is valid. This is checked by polling on the Memory_Active bit
based on the Memory_Active_Timeout.

A static inline wrapper dispatches to the appropriate readiness check
based on whether the CXL DVSEC capability is present.

Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 75 ++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h       |  1 +
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..52f7e3a3054a 100644
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
 
@@ -256,6 +258,59 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
 	return -ETIME;
 }
 
+/*
+ * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
+ * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
+ * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
+ * 101b-111b = reserved (clamped to 256s).
+ */
+static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8 timeout)
+{
+	return 1000UL << (2 * min_t(u8, timeout, 4));
+}
+
+static int nvgrace_gpu_wait_device_ready_bw_next(struct nvgrace_gpu_pci_core_device *nvdev)
+{
+	struct pci_dev *pdev = nvdev->core_device.pdev;
+	int pcie_dvsec = nvdev->cxl_dvsec;
+	unsigned long timeout;
+	u32 dvsec_memory_status;
+	u8 mem_active_timeout;
+
+	pci_read_config_dword(pdev, pcie_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+			      &dvsec_memory_status);
+
+	if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID))
+		return -ENODEV;
+
+	mem_active_timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
+				       dvsec_memory_status);
+
+	timeout = jiffies +
+		  msecs_to_jiffies(nvgrace_gpu_cxl_mem_active_timeout_ms(mem_active_timeout));
+
+	do {
+		pci_read_config_dword(pdev,
+				      pcie_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
+				      &dvsec_memory_status);
+
+		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_ACTIVE)
+			return 0;
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
+		nvgrace_gpu_wait_device_ready_bw_next(nvdev) :
+		nvgrace_gpu_wait_device_ready_legacy(io);
+}
+
 /*
  * If the GPU memory is accessed by the CPU while the GPU is not ready
  * after reset, it can cause harmless corrected RAS events to be logged.
@@ -275,7 +330,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -1146,8 +1201,9 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
  * Ensure that the BAR0 region is enabled before accessing the
  * registers.
  */
-static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
+static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 {
+	struct pci_dev *pdev = nvdev->core_device.pdev;
 	void __iomem *io;
 	int ret;
 
@@ -1165,7 +1221,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready(nvdev, io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1239,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1198,6 +1250,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 
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

