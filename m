Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AB233134;
	Tue,  5 May 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002262; cv=fail; b=Pdm45xli6zLlJj+CFGywP5l92ZxhSlo9y/bGsGxsGJHDZHiyAMXBWAx9PN4LnL7wiLjgCSX2PrSV4iZW7WO196m67DSzeSuYA/9qm9gfYR49BmhEc/T9woAXcMPXf4X3dcnhs49dLLCspj0xRH76q8Y2yM7Eb/hCTA4V2NewNbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002262; c=relaxed/simple;
	bh=EhCCs9S1l1xLKoM+WQodyiCyYvi1fTxYHL/1V1axl+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3VmxS7U1Eb3kttF4EoNvp/75kowWUYkUEBZP+LTiY607lo3Rv9+ccjiScnvL/8Ucfo6v7c3z1PN0MwmsvGGgXtWEayqPi3Ef1b3ujwz5swmQWzUtGYie/KO4p0lJk0WFgwrL7UQ34eOoWvUbJOowhsZKfSIeUIi0axIIeEQ3fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dx3OFNU4; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dx3OFNU4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwfHQKgX5My4HK6zt3ugijzA1ZXXN1EhMEjF2oOIBNAwB+bpsRQjIvnoENnDfIFsoJyL6qLAzfy8p+BSYf++0E3qMMRzg9csvh5h5xBQNswHHvLJWZLZjWEbuSWuvc+an2LbxusUuJQP1t8LJGCCYJbl9THwUc8joL3GhyDRsF3MSUWemUiKB/diQMlmwHIhGEJbgrt0ekftAcvLAMW/75ok3yeD7bV+LZVhYWgD2/ieScVQltUeE0Tk6Sl7S3pJTiqgRUDt0IZ5SlQFYdwvZ9/Qfb3H4Vy3/oe7HgLZbGDOqSVC2LEurYiX1CdJmqKKXESVhZhLFcQ3SbUsBC73tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqK7Orfdi96EmEFs2QT5Le73WovWCZ5J0gC0m4h8U8Y=;
 b=NIdUGc6yFDJEbN0UGim57HG6COtqg9z29wWOTx4ngve54waS9PIuF2FG/s+AtRmwk9IT3S7qHg78X7RR3yQ1ivCUkF4rh95oBHIdBX1nVQi+wVq6YI2Vi7xgYIWMZ0RlVV8k9ojhVlv1kJ0xIdU/hFiLA3CwGFFQ8B6oXFAQRPIdS7cZxmCKjvqB+gJhuQJRah0vaX5xeKgjlQfrv6LdJpotk9rxfKtM2ZTd7KbGdFI4y/Rys4yaRjDsZaIJSrKNxOgBcn+ymsaTvC4MGz2sN6MKLafBt1RzWhme+IQ891zww5Lsd7l1RcbVPQmu7JPVbor+Rk19rvCUq4dH4N+DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqK7Orfdi96EmEFs2QT5Le73WovWCZ5J0gC0m4h8U8Y=;
 b=Dx3OFNU4QvHkK+GE6tu/n25rAh8qNv3SShxbd8mGt1As+pL3s9EOwqHk6rFOaqUjA+v0Wnx/k/Pf2stbtJDGmbJFuIex9qcoak+NPvkJ9V6eTBwFKiZ+BUgXXx7qiGXBmrdkVJPnS2AAGDW1EXhAS+yvjub4rY89kjnjj4q+NZA=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:30:54 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ee) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 17:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:30:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:30:52 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 01/11] PCI/AER: Introduce AER-CXL Kfifo
Date: Tue, 5 May 2026 12:30:19 -0500
Message-ID: <20260505173029.2718246-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 087854f1-6da5-4b33-d07a-08deaacc0f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nz0S4gfR08dSZe98yDUbo+0tXWyBEQaKGBsz54UzAizLfGnhbZP0khM8WKLW43ujQj3b9j2S4ECnxBas/kKRRVf+V+Yyp085KcqvD3U9g7xeI95vUIZOUVeW5oSRK1Ji+9ihmIghOwqbJEaokdKhHu4e7trwX1K40Q2ApYWfQYgGCYgwH0qspwa1VgBeivjsfZFmKQqZhSO1DUzhBXELtRnQidVQPdbcYHg74ZeSDlLbLGTulyPhOAXgww0a7u0SyCQ+orYFavVNrm5heED7L8MhNmH+ipo+1mfyLwZPd+C+qRMu7TVG2nvK+bDzA+Zw56DH7B6UM+jFBlgitiJPXD60j997ESUehGxiGxS99ttSPOOKxqT+g9qKOiOa865Q1bbVa6XGw/NFgJ+0BPQ/dTsQqFrAdFq48JPR5yQ9xn/tSESxzp/l4A/zPGHhl/puUaIHhAPq8a6+d1b/tMq8FFWNGrJZlsuS7mbCBeiFho2VUxxdLRP1eRE2+VzNDgHo0xxmpSedZjYiI1DvdTSRljQwdfCuu+uL7+DxX+iMqTyido3kjR/5XGvdQatnaQ8IIowUKxfTLUM3k4gMHhSp4XtJ7hw5u8YYTIuUSBuj5ZfsRbtANeB315Fl2GTu3K47Vtbi1P6Gh0/mfd1C0bhCsL57pNLZwvkmUPEwJfzCHSNTWuBr4D7QGqlaN+SQ1bgllmPBkYjKJrUjoapSF3T5M6jgQwIRm4nDVKDZnwXos6kX0ad2kFvKnPNuSETG+4jgG3XbtlgP6u2+y/N+0X0Erw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z4pF/9PrVBvpmlqyJTvTGGDSOaj/edzpntFeKej8EdYeECo1bu/KWAgKKO0ValfnKZCcHZueIVhJGiz6pVmU3uLiXAoNQ4GRAbmd6pDICa3Y71hDzS2s/XxvZ0l4JZzW5IT8DoWWpSJDsIzlYmBoUlO7i0vtKyrocEhcWo9SJ8dfm1mREszF0xzPr+yW4R7CiZliK7GUtphq+bcXft9dMsw+xvx1QL2Qr4szV5vC9xKevLlXF8IzAyl/j6slDRm4U0uv+AyX5y6VHaiCVb31cN8HfZuiziVa79mw9BA+ixv2d+m4LrWaxvRb+kQLRkezVDUnigraTwgG/EpzBydkp0Z5Gqaflu9MZnpjCTcQXOV1qYGDYICnGwrDubGBgeRmshZt64iJJyMMFOQhVli0+9xP+2Lj/rE4nYzlo6zmLqIeWom8cA7xJMRHml6udu0x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:30:54.2364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087854f1-6da5-4b33-d07a-08deaacc0f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

CXL virtual hierarchy (VH) native RAS handling for CXL Port devices will be
added soon. This requires a notification mechanism for the AER driver to
share the AER interrupt with the CXL driver. The CXL drivers use the
notification to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology refers to CXL VH and not CXL RCH
errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol
errors: pci/pcie/aer_cxl_vh.c.

Add a kfifo work queue to be used by the AER and CXL drivers. Multiple
AER IRQ worker threads can be running and enqueueing concurrently, so
include write path synchronization. Pack the kfifo, the spinlock, the
rwsem, and the work pointer into a single structure. Initialize the
kfifo with INIT_KFIFO() from a subsys_initcall so its mask, esize and
data fields are valid before any producer or consumer runs.

Add CXL work queue handler registration functions in the AER driver.
Export them so the CXL driver can assign or clear the work handler.

Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work
data. It contains a reference to the PCI error source device and the
error severity. The cxl_core driver uses this when dequeuing the work.

Introduce cxl_forward_error() to add a given CXL protocol error to a
work structure and push it onto the AER-CXL kfifo. This function takes
a pci_dev_get() on the source device. The kfifo consumer is responsible
for the matching pci_dev_put() after dequeue. On enqueue failure
cxl_forward_error() does the put itself.

Synchronize accesses to the work function pointer during registration,
deregistration, enqueue, and dequeue.

handle_error_source() is intentionally not changed here. The is_cxl_error()
switch that routes errors to cxl_forward_error() is added in a later patch
together with the kfifo consumer registration. This way the producer and
consumer land in the same commit, so CXL errors are not silently dropped
during bisect.

Also add MAINTAINERS entries for both drivers/pci/pcie/aer_cxl_vh.c
(new in this patch) and drivers/pci/pcie/aer_cxl_rch.c (already in tree
but previously unlisted) under the existing CXL entry. This way the CXL
maintainers are CC'd on changes to the AER-CXL bridging code.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
- Defer the handle_error_source() is_cxl_error() switch to the patch that
  registers the kfifo consumer to keep each commit bisect-safe.
- Rename rwsema to rwsem
- Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
- Add work cancel function.
- Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
- Add fifo_lock spinlock for concurrent producer serialisation
- Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
  kfifo->mask, ->esize and ->data are set before first use.
- Clear PCI_ERR_COR_STATUS in cxl_forward_error() before enqueue so the
  device is acked for correctable events even when the consumer drops the
  event. Uncorrectable status is left for cxl_do_recovery() to clear after
  recovery completes, mirroring the AER core convention.
- WARN on double-registration in cxl_register_proto_err_work() to make an
  unintended second consumer visible at runtime.
- Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
  in aer_cxl_vh.c
- Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
- Update message

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
 MAINTAINERS                   |   2 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/aer.c        |  10 ---
 drivers/pci/pcie/aer_cxl_vh.c | 142 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |   4 +
 include/linux/aer.h           |  28 +++++++
 6 files changed, 177 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..93d4e43bb90d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6433,6 +6433,8 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/pcie/aer_cxl_rch.c
+F:	drivers/pci/pcie/aer_cxl_vh.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
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
index c4fd9c0b2a54..c5bce25df51c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 000000000000..c0fea2c2b9bc
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
+
+#include <linux/aer.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/kfifo.h>
+#include <linux/rwsem.h>
+#include <linux/workqueue.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	struct rw_semaphore rwsem;
+	spinlock_t fifo_lock;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
+	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
+};
+
+static int __init cxl_proto_err_kfifo_init(void)
+{
+	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
+	return 0;
+}
+subsys_initcall(cxl_proto_err_kfifo_init);
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
+	struct cxl_proto_err_work_data wd = {
+		.severity = info->severity,
+		.pdev = pdev,
+	};
+
+	if (info->severity == AER_CORRECTABLE)
+		pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS,
+				       info->status);
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
+		return;
+	}
+
+	/*
+	 * Reference discipline: the AER caller (handle_error_source())
+	 * holds a ref on @pdev for the duration of this call and releases
+	 * it on return. Take a fresh ref here so the pdev stays live while
+	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
+	 * drops that ref after handling. On enqueue failure below, drop
+	 * the ref we just took to avoid a leak.
+	 */
+	pci_dev_get(pdev);
+
+	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
+	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
+				 &cxl_proto_err_kfifo.fifo_lock)) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
+		pci_dev_put(pdev);
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+	WARN_ONCE(cxl_proto_err_kfifo.work,
+		  "AER-CXL kfifo consumer already registered\n");
+	cxl_proto_err_kfifo.work = work;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
+
+static struct work_struct *cancel_cxl_proto_err(void)
+{
+	struct work_struct *work;
+	struct cxl_proto_err_work_data wd;
+
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+	work = cxl_proto_err_kfifo.work;
+	cxl_proto_err_kfifo.work = NULL;
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
+		dev_err_ratelimited(&wd.pdev->dev,
+				    "AER-CXL error report canceled\n");
+		pci_dev_put(wd.pdev);
+	}
+	return work;
+}
+
+void cxl_unregister_proto_err_work(void)
+{
+	struct work_struct *work = cancel_cxl_proto_err();
+
+	if (work)
+		cancel_work_sync(work);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
+
+int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			   cxl_proto_err_fn_t fn)
+{
+	int rc;
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
+		rc = fn(wd);
+		pci_dev_put(wd->pdev);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
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
index df0f5c382286..78841cf4268c 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -25,6 +25,7 @@
 #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
 
 struct pci_dev;
+struct work_struct;
 
 struct pcie_tlp_log {
 	union {
@@ -53,6 +54,18 @@ struct aer_capability_regs {
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
+typedef int (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -66,6 +79,21 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_CXL_RAS
+void cxl_register_proto_err_work(struct work_struct *work);
+int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			   cxl_proto_err_fn_t fn);
+void cxl_unregister_proto_err_work(void);
+#else
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+					 cxl_proto_err_fn_t fn)
+{
+	return 0;
+}
+static inline void cxl_unregister_proto_err_work(void) { }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1

