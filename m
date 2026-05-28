Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82703AE191;
	Thu, 28 May 2026 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961142; cv=fail; b=DcFY2yogdkB1I/wm1vp6IyRTzF6S7IbzaYOnq0vdEB74abk8YqKgpLpceqGbST1hBXY4E6nVX7pzqf/vkyOoc2mi+DX2IxlDjekX38URQzhhO+3Azjz3cZUKBHa52Mdw2vucOTP06NajEJezR6nwqY+tXRXY5IT6dIZa21hnu9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961142; c=relaxed/simple;
	bh=lCPkXzsYyXmcv5AC1o5LOSeqHH4//PGNrmLWma6rPRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sE055h5DAwhsektvvtrcQjm0uMWzIF5u6Fgo8faCxe7lj9qsVRr+K9OQBZ1QBsdK7EOzn3mjnmCVrzvKbCIpSnmB9CLPk7cs0WKW3IaxxNmTLnBOo05a00i8I3o3/Am/r2uLS/BMNazszD8aDPhwHN6UTqQUSKj1htf1LcVisyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O8FVrJe/; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O8FVrJe/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWFKVIs02Elp90ALOvjbt0QllVLT1lFeEmH5rJ2tvWZRZV0REOnfpLrId6gPqpb4w+NN53fe7yz5tAhf1ruzqVQ7u8oZHpgh1J0Kp609MpbWbivnHpsZ7i36/R+/BfMcICDxvYA39EUn2ErtwDbrxpQGxpHnufzgfY+n5BhvNlBaotYzp2nL4iKJd6sSWbtqssjcwFqA2IxSoQbPGtNeSNzWMLV6r9zaIF3duIURM6eo9pT1Ex+C4BXlmMPgaGfvmeHUkC4g+SmthIzOpHLoutLcaWeL8YzynedFKxwR/a2zSBCD0THhV/GB0gweCukl9Mmo0HIViz8djsoNH5irTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTtU6/VklYSi/HJ9+epUk+b0PEf+qftKFvI8lq22C08=;
 b=CQe4lFQ8sI6OK0DoxUeqhCPuVbl3yhBY4sGUOtR9FGTNSXX24q6ArjssQhbB0bxqI709tCZE+O0W0X9GmeQwTekU09ryblCPSTQjMoYMh1isUa+3SCvrBGzlYfnawEBRncLCUMU3vIdZVm5ouJ1jD+AyrXmQ7tNTPCXZAIY9mi18inZhM8yIAxokFmhQ0/4naU2Hcsn/F/Hr7u6PTMWsvtFzgV46Rq8UrzWOGY4ZTdwHwcuzrr60I7FMvukHCJny/f5LwA8jJruOpK1bFnL0x9iatmBgtshk3K1foyZtX6irDPGs1VXnN/RyYBRiDxub7ipcDcFwPFU4JIpWJmfgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTtU6/VklYSi/HJ9+epUk+b0PEf+qftKFvI8lq22C08=;
 b=O8FVrJe/42C0dUOOkHS7cLKwbdIkdvB3fuGwtbi3gAd7MPhDNLSbBG0tcwCit+ekmMvKACDWszUnLyc3kiRWhH4n5wMaQ3aYD4Nactek7e+7qT9x1WlEnoJ3lbYhyPVbizdQSCPjOaTh3VWHU8JSzLka1Mu1h/GuedUmW9r5Zj60j+0hyUGB/+VmtF6KDrCk48WZe9ErPUPnFMr2bF5f+bezcvl1bi7TLSH1Xttg0Pa8J2MfOjdN8j6X3zihPTxWK+MBU6OcOJ1nSd11iqxnafWEO404U54BRw4rn7ZdToktkxDcm6NZPQ/92Mn/2nLahMIi6JqBVRssfSOz0XszaA==
Received: from BN0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:408:142::14)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 09:38:51 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::29) by BN0PR08CA0024.outlook.office365.com
 (2603:10b6:408:142::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 09:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 09:38:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 02:38:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 02:38:40 -0700
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 02:38:40 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <alex@shazbot.org>, <kvm@vger.kernel.org>
CC: <jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC
Date: Thu, 28 May 2026 09:38:40 +0000
Message-ID: <20260528093840.4018-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: a023dd88-5419-49ce-b503-08debc9ceca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	x8bLrTI4pR8XNNlzise+fm4IHDCeVtFUZSGQaWSeyiutcbMYf2hoU6JdbxL55Sw5zVAMpE/0XthAF0yPyr2QheSkYL6q+ApWTrru1hbwsdq4NZ3wqxT+ZIEEZB+hiIiTfjaCO/BI2g+Kpb9u4NwjaTqg9qZAXbdeXCXwUVdRzSAgSmM/TM3tyrfvYG1l0Q5bY6SYtCixdNwyQ8NJzQ17SC+ZyZMvlxUPVPKFjt9IYIglHzT1e2H3kQSp1d/GRFjMWqXml8TekoLwfn8xNKlX0lvvSdg9WUE6CyX/33/yRiRRafn6SWzlhHM4oMtmB3PRbiadB8ZlYlIM+JsFnkHnUOmRJ2xcTJK9rYYk2Xqp0XvhHsma6mb5dHurOTaCgdr/7sbMX3HP4gVPSC/t4xTq/EXwybUffC4ZlE7kxoqtSpDNF4MTOlLkpeUHXLG4WBbZNkU3BwACxoTPl6rtLqeBL0zLvIPLyyGJeQtFhoGrATc+Ap5Rhr+tkCv1wb4VwmIAlNzFb9rDZqZUrc5gkcuSpNh45eeFxFsJ710pM/2nn0NC9h3cz2nxl0oX0UiZzyDDKwllkZ3Xo5rpfw2fPa4NShJNG3soCUqo+IAIRqgxGzNeBr8w8e3qR5v9L2UHmHPsi5Qcfsr9xjRqETbFVa1kqf5D+JGJjW7jdCUSI8Zw7dzxShH7nfUhA+eHNkj3qZdS/woEsJo1uK/ueGrhiYTjtMG0RKzuOGNqzoWzHItoenU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nHJKXsJBMOTi3xg6q77KgIMrqAvnjg4sZ18oCweYEebYK1NAb3Z72LsZ8WE7loX/AWU1GZ4VyBipYU/5MKx7lPLhkBdt4peEsJTLk9h4tOTWyfHx6n7rnoqjVXJsU9gwY5N7UiWpqJtBH+rkpi4gOfIIAc1i9+GK9kGcCU9lTEx3u38QCXQ174kn6KopYrcnn6k6oZWwKWhwJ6kV3zHblB44a/vCZKRxctvTQnP+FLQuKpBx6Dq15CkMv5SSzRdFcwtUXZkBaAwiJAYD3tqsIp/KCpIZBxDAKQSPo+kT+b4JeVRsLt7vyCPXuvxp9s1v6K2wFmvjgXwrDxpDnmRa+/aNk+jeakbr8ASrY+lqrT7vm0S4YTU3Yv7VVh0KEHe0WuWgmOsFJxMIvPj6BCRy7NJUI36d6+X20fQdj+NQ53Z5qNE1oSx4MlmNWJJX/BDf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:38:50.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a023dd88-5419-49ce-b503-08debc9ceca7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
the existing legacy BAR0 polling path. On probe and after reset, the
driver reads the CXL Device DVSEC capability to determine whether the
GPU memory is ready. The CXL DVSEC offset is discovered at probe time;
subsequent paths branch on its presence to invoke either the legacy
BAR0 polling or the CXL DVSEC polling.

The memory readiness is checked by polling on the Memory_Active bit
based on the Memory_Active_Timeout. It also checks if MEM_INFO_VALID
is set within 1 second. If not, return error. This is based on the
CXL spec r4.0 sec 8.1.3.8.2.

Considering the large worst case wait of 256s for the CXL, the wait is
kept outside of memory lock. Only after the wait is the memory_lock
taken to check the state.

Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
field encoding.

Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 144 ++++++++++++++++++++++++++--
 include/uapi/linux/pci_regs.h       |   1 +
 2 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..04fcc0d088f5 100644
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
 
@@ -256,10 +260,89 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
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
+		msleep(POLL_QUANTUM_MS);
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
@@ -275,7 +358,10 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	if (nvdev->cxl_dvsec)
+		ret = nvgrace_gpu_test_device_ready_cxl(nvdev, NULL);
+	else
+		ret = nvgrace_gpu_wait_device_ready_legacy(vdev->barmap[0]);
 	if (ret)
 		return ret;
 
@@ -313,6 +399,21 @@ static vm_fault_t nvgrace_gpu_vfio_pci_huge_fault(struct vm_fault *vmf,
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
+		if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done) &&
+		    nvgrace_gpu_wait_device_ready_cxl(nvdev))
+			return VM_FAULT_SIGBUS;
+
 		scoped_guard(rwsem_read, &vdev->memory_lock) {
 			if (vdev->pm_runtime_engaged ||
 			    nvgrace_gpu_check_device_ready(nvdev))
@@ -712,6 +813,12 @@ nvgrace_gpu_read_mem(struct nvgrace_gpu_pci_core_device *nvdev,
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
@@ -846,6 +953,12 @@ nvgrace_gpu_write_mem(struct nvgrace_gpu_pci_core_device *nvdev,
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
@@ -1143,14 +1256,24 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
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
@@ -1165,7 +1288,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
 		goto iomap_exit;
 	}
 
-	ret = nvgrace_gpu_wait_device_ready(io);
+	ret = nvgrace_gpu_wait_device_ready_legacy(io);
 
 	pci_iounmap(pdev, io);
 iomap_exit:
@@ -1183,10 +1306,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
 	u64 memphys, memlength;
 	int ret;
 
-	ret = nvgrace_gpu_probe_check_device_ready(pdev);
-	if (ret)
-		return ret;
-
 	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
 	if (!ret)
 		ops = &nvgrace_gpu_pci_ops;
@@ -1196,6 +1315,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
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

