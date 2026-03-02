Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D763A450D;
	Mon,  2 Mar 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483842; cv=fail; b=fb6BoikKu6Rlg9sdaicv/inBVcjztqpS37jYcBpZJQjHDmuDKylSEkJqTUkVaJc2l/5XXknpS6e8gjiBAVudDJw+jdDAVIoZG5T2p0bFC2KaIHhu7kvHdaJBUPH3m8Op9SdrEkOWlaayaz6pNCMtFfbCvYw4QrwwIsPVNV2Wdl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483842; c=relaxed/simple;
	bh=npYKpl/PdFtrsZno05TqiauNhea6DuaVddyY7cKXGbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEmsyuuNneiw43YF1OugiilTdv83waLFwZsEMCkjh/ofkolPZXqfK0QorE5Wrpohz5JQk0aRBAGkKUES1p0PIh9uIUbx1lznJxcIy0Q97cSAKTmdHWP4X1EVrBLsE/cE3WGf14QW5hd6uClW72iNN6YsZHRQv75tjenNq4N8E7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+FO3j0s; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+FO3j0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SifwQGlB5FrzFLTO0HOPDhKihatoNRQ2yZSN0Phj9R24QBM80WqxNvQbHoWe864CLixhPlWp3egKget8e6oqKKRZ91JuAUNEDuM0c5ClzNXcx6Z4TYSyWQJwTGl5JsM5tCGQqhHyomFnM8tl0iDR1yNiaXRXaUHZAgHk8lVx56xh/VzB2waGQsHf2edZDz4N2JNyuuQddELo1BXlB9Z8zEUcglSgRemfzm0fRkIeTRb7Vlyjzr8ygl0/f/dtpkccPq1abm/f6Jad1HTJwV8OTgxO9LQY5DBJFY1C95Wce4okdP73tBpLx48CD5b1N4W5OLItShjuz1FwVmQQNLtX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBiTwwnJcIwVmw+lCdbEcpXi53g4MwN3yWIuo+rKoH0=;
 b=KcwbqaWnxEjtDU6SjRGbtP2zJPseEqqBgvcL90JDyBkqSwTN+6+XCAh19qaKMiNW6PdVDNi68MBeNbfVKr9/RHhQF3ph0v5UaMK22tKv7FpqHDH/6oWRDf/6CXp8RjAk+k0jS9nzHYMKE4t+xuaJ6ar1tbTfZIayL7a5lSskZJ/ouNFckRViTbwdPRnCbPMi+9CXEsPVNQdIOHt3AasN7z+nhjn1NhkLTe/Nb6lyB6q6zdLsf7dk2etiqJE2gb2tOxQIR3f+141b3OSrGOTwrUC+BnzV1krXpIhHM5a32W4sc7+oO9umMbFHD4cLi+zqLTXDfO+xTzLfoXnLCX2j4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBiTwwnJcIwVmw+lCdbEcpXi53g4MwN3yWIuo+rKoH0=;
 b=V+FO3j0s0CBy3yHVSkPPAXgtswhEzIPSxOKToV0lEji1mp708PCNiLTNW3vbQIrSpRHfI70EPhLxEvSLCsvOO5H1qi/XqcoeX854MiNruaK++ocMNVbV8IXHlP/laP8rqy3DZbH6HqnP+wH6Myn8CaYRM33PllcWJs8Q3NbibCU=
Received: from MN2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:208:239::23)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 20:37:06 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::43) by MN2PR08CA0018.outlook.office365.com
 (2603:10b6:208:239::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 20:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:37:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:04 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
Date: Mon, 2 Mar 2026 14:36:39 -0600
Message-ID: <20260302203648.2886956-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c73488f-b03c-43ac-09c9-08de789b7794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	cf2iIhDXPXh/gwxBSD+bCygZQoVuUwQ6g1H0hWybO7ho1Um/v0QU5g8zp9OCZEHxB7JPeTKMX9v6u/WL/z/XWuXhSqLe7p1TJXKXtKgWs0KYhCG9pN9hELZtC5qfiJ1pVSJVDQ3yoO6crd394FINWuAFhI1ppPmlYIxkUO2MIuy4NONf29fr6vw+vt/kjSidD5phvwp2xOd8uEFxU24yYygQPTfe9LBs2Y1eQvk0pki+T8Gq7NVPHc9/a4Vu7dChMn+UK/DwoyamedXVnYHFA5JRbSJ3RMm0XymxQ+tn81fySEHycHvc3yOMoH+5wzcKi5ycadUo/LhkD+UZpnQ/A8OpZy/Mec1P7GIbbM4S2QoWYDFku0ydyJ16tUDhf58tLmTw9bMbwdKQw+zqPCdElgBwjKd0jJfbOMJjV6JUzm4to4178s65ABXD+YmnhuqdxTGbruSfJf6I+vszwvbzL46lZSzFzw53VQdnrRsTNzbKnRumraIE+A7lFakOuUnyip+V/ilwhbBBd8TFvUBfpZ8W9T1uCBIGhdX1GutKbk2zoupjErTbV4LlJJXAdSf06iFHRiWYRsB1+5boDfyyrJ0i/k7UPwzs7C+7grH+gue+ai9j6pk+F+CV0yusJFzL1KdkOvUpkd5VFRO/u9V2S1VIzeZZIxoL/YgGrUwc2clipw9gRZmN7beXLoq/WSqGaqHN1it40rEcTZ/GzzKYwx4O709+meGrd8m+hiM7CpPH4yHgYePe4qIvxPtm/1AmcezoI3s7l9De4rtWoB3ajB32/jNw++I/S29FRNSNXITswUxaNn4s3IZ/87hGIqaK3QCWk2Do5EmS3BWrvdiuQ0oqoI8y1t+WcoKjLdyInJc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eBinJXwGlPj67uxdB5GUlUfvNGj2zrMcuDySg5crRQD51DAyyFxZYP5Bz3bdhoh2gabcKarJa+S+dGzs6PiudDcAy3NBSdvVtcqP9XaNBT6J/eM2QBcqqBJnJwipFLdZimGcKJGC2mgCH5E4X0jXsMf8LQrpJpFuIMjGNxOpqWk6R1ufcxlyrs8cVEycGXqrUM0s15j6g5yIaPfgMMvETy0TAYy3ufHvNTl+T0cufXMJnyzc/urXY0iO6G/X7ybWOWBFjTGbxi0mLtzOowTswp0qNTHKoOpOvFJD7Tpa3xxbQU+9eg5KYMeBCi0pFx5YvXbVvCzyXacVRCZGeG8ZtExDY8KxLZBbGfB11zkJUgIdgs7+A6WHRCu1zpOMimfPzfEnI4lKv2s5CfxhFX8EYf6pfUgPN9fQAGcZ0vOk3Y/a8LqrwNTu/rHeD2v+Ffz7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:37:05.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c73488f-b03c-43ac-09c9-08de789b7794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
soon. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used as an
indication for the CXL drivers to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology will refer to CXL VH and not
CXL RCH errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol errors
named pci/pcie/aer_cxl_vh.c.

Add a kfifo work queue to be used by the AER and CXL drivers. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.
Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.

Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
This will contain a reference to the PCI error source device and the error
severity. This will be used when the work is dequeued by the cxl_core driver.

Introduce cxl_forward_error() to take a given CXL protocol error and add it
to a work structure before pushing onto the AER-CXL kfifo. This function
takes a reference count increment of the PCI device. The kfifo consumer is
responsible for reference decrementing. If there is an error on adding the
work then this function must decrement the reference count.

Synchronize accesses to the work function pointer during registration,
deregistration, enqueue, and dequeue. Further synchronization fixes will
be added in the following patch.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v15->v16:
- Add pci_dev_put() and comment in pci_dev_get() (Dan)
- /rw_sema/rwsema/ (Dan)
- Split validation checks in cxl_forward_error() to allow
  for meaningful reason in log (Terry)
- Shorten commit title to remove wordiness (Terry)
- Remove bitfield.h include, unnecessary. (Terry)

Changes in v14->v15:
- Moved pci_dev_get() call to this patch (Dave)

Changes in v13 -> v14:
- Replaced workqueue_types.h include with 'struct work_struct'
  predeclaration (Bjorn)
- Update error message (Bjorn)
- Reordered 'struct cxl_proto_err_work_data' (Bjorn)
- Remove export of cxl_error_is_native() here (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by
- Update error message (Ben)

Changes in v11->v12:
- None
---
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/aer.c        | 15 ++----
 drivers/pci/pcie/aer_cxl_vh.c | 87 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |  4 ++
 include/linux/aer.h           | 22 +++++++++
 5 files changed, 118 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..62d3d3c69a5d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d916378bc707..2e996e339d7c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1152,16 +1152,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
  */
 EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
-#ifdef CONFIG_CXL_RAS
-bool is_aer_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-#endif
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1198,7 +1188,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		cxl_forward_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 000000000000..7e2bc1894395
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/types.h>
+#include <linux/kfifo.h>
+#include <linux/aer.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	struct rw_semaphore rwsema;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rwsema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsema)
+};
+
+bool is_aer_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_aer_internal_error(info);
+}
+
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
+		.severity = info->severity,
+		.pdev = pdev
+	};
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsema);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered");
+		return;
+	}
+
+	/* The reference is held as long as the pdev is live in the kfifo */
+	pci_dev_get(pdev);
+
+	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed");
+		pci_dev_put(pdev);
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
+	cxl_proto_err_kfifo.work = work;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
+
+void cxl_unregister_proto_err_work(void)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
+	cxl_proto_err_kfifo.work = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
+
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsema);
+	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c84..66a6b8099c96 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,9 +130,13 @@ struct aer_err_info;
 bool is_aer_internal_error(struct aer_err_info *info);
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..f351e41dd979 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -53,6 +53,16 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @pdev: PCI device detecting the error
+ * @severity: AER severity
+ */
+struct cxl_proto_err_work_data {
+	struct pci_dev *pdev;
+	int severity;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -66,6 +76,18 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+struct work_struct;
+
+#ifdef CONFIG_CXL_RAS
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
+#else
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1

