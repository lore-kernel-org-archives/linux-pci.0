Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31516345EA9;
	Mon,  3 Aug 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795572; cv=fail; b=f7E3asqWo9TwF8jeuklbz9RwMIhtz9V6V5Zk3mp3vsRFePHWnb78vHvL4kVncGKtr1j+Usapj1NLvgaEO30NdrM1zuSUxUAiSi5V+42Sc5F8XU1QtESj2ADMerKdxSUIxRmy2ALXjiGrE2nczI+w9kA3x/ub0ZnsPUc1MBDHkxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795572; c=relaxed/simple;
	bh=zCT2oyE1hAa+5gXaHcjK2xHKVwFH8Eks3F8ho3fyfX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iff/YCKBwI8+FPu0dMrlrNGgP0+Aq+ixhBl0yDGseRgRZZxO4VHwCsk+WGanhy4/5TOrgCJGutNgGtKxUgMNlVjbWL5BPpk9DnIFeyV/vT19raPsD04/swhSgSTOhgWGp/0SEg+r7Y36STFj/B0cdTomCjvvmxd39f9Tz+DkLMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=koNKD2FE; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="koNKD2FE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhjxP4ANaZUS0EFvt5cz6m1uBP0PZzV89fSfw+Hynh5T87MTh0t5QAoY19zDDhnm/joQErznSxvKMkQl0+onoxdIB+SoCdg5atyHZ4r8WCTA9RM9jm1uLrhl/p8r1thCCVBO15QPCrGzdB3yvgdj+nxaklXCJr8ul1zYuhCyUA2xkBnUz9w9riiRvi3YcGma5Z9O8qu0Nhy9CxP6yjcZWhKbcb0oaOgYYDSXQLnRjstzwZU/oEgxYhXMojU7R1uiTY6YFRi4ZgiD7PRPpGQhC5aiZsVXMtVa5HaKqu96ZqtRbvo7soWaLxcGDQoiKfhEUQDvbsUtuTOUeY8RK28I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9alLP8u+7Q0ESLNv37Oi1JqrBg/jRw0wo8OilFOkxJc=;
 b=xHSo7Fs5fqwkwE4b45m1MR/Vash5i61rTt6Hs5ECYoSauHJA7AdGGjgUcFaUqSd6294XyyYng0KDshcQ2q3eYlpNG/wW4ivMJ8u/GTZ12ZSHMrYwFP5GEVyhx89Zo2XvgYQLDyT7rFtU2mDtRmrpaCF7Li+jM4/kk15KiiWhvvUOEDn+7LiNyzz8MqN3qCuZ78UnnlPv7LUrSyWRS9l/kooMbomWC8Evkwg5NIjjzBse99gRgWshIDyyancODSHy9TphTiiyHcPKwFHlR3VfzesWkikiKQxOWiFKS68z3elnLRz4ydaaE19VTsYaSD4vjYDUQDZAawwdmyAiUPPvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9alLP8u+7Q0ESLNv37Oi1JqrBg/jRw0wo8OilFOkxJc=;
 b=koNKD2FEsNnECvMD8wTTR4LdgNloI9xoxUWPoMDKSbvBjlS6dOyp8BTIQVtlY63bK/7b5rcXxVRD6zhuA9ooMjPnW9+ReF8KyB+Ms4bsqxCujxm2K5FVljH0bJC8CfV3md0KTKdsNO4mcAPlrJeD/l56TDkTEEg4N89GJV1/X3s=
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:24 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::66) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 22:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:23 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 06/14] PCI/AER: Introduce AER-CXL protocol error kfifo
Date: Mon, 3 Aug 2026 17:18:02 -0500
Message-ID: <20260803221810.3685703-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2d6ea1-bce6-405d-ce13-08def1ad4620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S8P4AnFpYRq0uaHR+OwGWfE+4l9UBLXY809CoywEdi1j7e+fR1/MbiF4XeqyCvyEV7xM8WQwy0er6rpP9HPHsazOWMP9LBxoGFB3E7FsOYvt7O2ON4NjTP1s8Gec68xDdOMxRoTgM5rZZjcjFKAL88mHDs3y66wR9WtbxqhXkNOaZKwrmeZF0cRhdddm/YrgmLwIW+Er/DCwLH2Rsele//Y3fKMuyG2Xts3SMN/6Haj1anwjVKEPeq16kfbDOzCgWsb+c99cYs/BHuOgYULLaDOPawxKzOMFDt1u6pbQlTWPGVMaxnfGgE2LTzt0v8EGjqTUgc/k0lolJITT1WEOZsV3XwKIlX/W1Lb/p3YHE0DM/QejTh1BGGZpjI3k4hE11R98BbCvXw+2/3Pc5wgUFNJd/HWUnGRX6LsfY+NxzNbgI7FP2gpDyQ2mP1woD4s5HMOI1QQOpH2PYRMz+je7QTJ8WhiWy40W9wdn0UkL5JyJkAYjKye2THfqy1MPFa3sWQQg6ePL5QDHLYvcQ7nasSI6qUyyz8GxfvI54D3S1zcZrtsR7BdSzZGeq4HtXcNs5fA1z022bw+0i3SBh2uiP4iG/B66zgMxljmbyGNULMV4mzKz6JgGooZUg4QPKh4uWrIg8WvoJf58NE3ac3MiGYwcuS6JHcqORLGyceRZNvIWil1KxSqclbTBMTNLwl8TBa4t3BTLgq2peZtj59UyIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	55IrYKilL1TpooH383ma195u0hcHzedBofNZ2mZb/aupGowlGYSaNdbwV6WgQFfVItx/2VRJ4xY8+l8Mpvy53YtQwsXqWTEeoIeEiuiXAlkahusDfkXZ+Jvlkioov/rvk80DZnOMRKmuzJw8fIpEXK4AsbCZQrt85oQE0RpzlpNCBey3pqmP1vw2PyASUcIBtZf8GYcoEGcRxR/QGle2HV+qHQokFCu3vK9ceD0C/W/Fe5Oorc5RfzUCF4JJamn88yIxIOBB4tTDiKhC+yqtMuwhhW9J6E+RhXsbNGpV2Zkc5ebLuRFwFD6cCv6J9CCSnlA4HEkths9btJdHqyWVRY6RjnwPA4UwBVBKzBhwT18ZqalozvB6rm3nBQuhLYl9K5bfolLRr/Rqa6AMt2SDU821YuocVIrKcrJxUTQapyp1HXKE7jLwZrTRcLLSdHh2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:24.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d6ea1-bce6-405d-ce13-08def1ad4620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

CXL VH RAS handling requires a path for the AER driver to hand off CXL
protocol errors to cxl_core for logging and recovery before PCIe AER
recovery tears down the device. Introduce drivers/pci/pcie/aer_cxl_vh.c to
implement this handoff via a kfifo-backed work item.

Move is_aer_internal_error() into this new file. It identifies AER internal
error status bits across both correctable and uncorrectable severities.

Introduce is_cxl_error() to gate the VH kfifo path.

Introduce struct cxl_proto_err_work_data to carry the error source PCI
device and severity through the kfifo.

Introduce cxl_forward_error() to enqueue a CXL protocol error. A reference
is taken on the PCI device; the consumer releases it via
for_each_cxl_proto_err(). On enqueue failure the reference is released
immediately, the error is dropped, and the consumer is scheduled to drain
existing entries. A subsequent patch wires cxl_forward_error() into
handle_error_source() where correctable and uncorrectable status clearing
is left to pci_aer_handle_error().

Introduce cxl_proto_err_wait_for_empty() to synchronously wait for the
consumer worker to drain the kfifo.

Introduce cxl_register_proto_err_work() and cxl_unregister_proto_err_work()
for cxl_core to register and deregister its work handler. On unregistration,
pending kfifo entries are drained and their pdev references released before
cancel_work_sync() runs. Export these and for_each_cxl_proto_err() via
EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.

Protect the work pointer with a rwsem to correctly serialize
registration, deregistration, enqueue, and dequeue against concurrent
AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.

Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
bridging code.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v18 -> v19:
- Rename cxl_proto_err_flush() to cxl_proto_err_wait_for_empty() to
  better reflect that it waits for the kfifo to drain (Jonathan).

Changes in v17->v18:
- Remove correctable status clear from cxl_forward_error(); the AER core
  clears all status bits via pci_aer_handle_error() info->status writeback
- Schedule consumer on kfifo overflow so existing entries can be drained

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
- Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
  device is acked for correctable events even when the consumer drops the
  event. Uncorrectable status is left for cxl_do_recovery() to clear after
  recovery completes, mirroring the AER core convention.
- WARN on double-registration in cxl_register_proto_err_work() to make an
  unintended second consumer visible at runtime.
- Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
  in aer_cxl_vh.c
- Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
- Update message
---
 MAINTAINERS                   |   2 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/aer.c        |  10 --
 drivers/pci/pcie/aer_cxl_vh.c | 227 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |   6 +
 include/linux/aer.h           |  24 ++++
 6 files changed, 260 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307d..3a1f1057a21e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6527,6 +6527,8 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/pcie/aer_cxl_rch.c
+F:	drivers/pci/pcie/aer_cxl_vh.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304b..62d3d3c69a5df 100644
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
index c4fd9c0b2a548..c5bce25df51cb 100644
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
index 0000000000000..cd921ade1a38f
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
+
+#include <linux/aer.h>
+#include <linux/atomic.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/kfifo.h>
+#include <linux/lockdep.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/wait_bit.h>
+#include <linux/workqueue.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	void (*flush)(void);
+	struct rw_semaphore rwsem;
+	spinlock_t fifo_lock;           /* Serializes kfifo writers */
+	atomic_t flush_inflight;
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
+/**
+ * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
+ * @pdev: PCI device that reported the AER error
+ * @info: AER error info containing severity and status
+ *
+ * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
+ * item and schedules the consumer workqueue. Takes a reference on @pdev
+ * that the consumer releases after handling.
+ *
+ * Return: true if the consumer workqueue was scheduled and the caller may
+ * need to drain the kfifo before AER recovery; false if no CXL error
+ * handling was initiated due to an early return on error (e.g. no kfifo
+ * consumer registered).  Note that on a full kfifo a correctable error is
+ * dropped but true is still returned; this is harmless because the caller
+ * only drains the kfifo for non-correctable events.
+ */
+bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = {
+		.severity = info->severity,
+		.pdev = pdev,
+	};
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
+		return false;
+	}
+
+	/*
+	 * Reference discipline: the AER caller (handle_error_source()) holds
+	 * a ref on @pdev for the duration of this call and releases it on
+	 * return. Take a fresh ref here so the pdev stays live while queued
+	 * in the kfifo; the corresponding consumer is for_each_cxl_proto_err()
+	 * and will drop that ref after handling. On enqueue failure below,
+	 * drop the ref we just took to avoid a leak.
+	 */
+	pci_dev_get(pdev);
+
+	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
+	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
+				 &cxl_proto_err_kfifo.fifo_lock)) {
+
+		if (info->severity != AER_CORRECTABLE) {
+			/*
+			 * Unlike PCIe AER, a dropped CXL.mem uncorrectable
+			 * error cannot be treated as device-local: it may
+			 * signal lost cache coherency over HDM memory in
+			 * active use. The error can no longer be confirmed
+			 * via CXL RAS, so collapse the unknown state to the
+			 * same conservative outcome as a confirmed UCE.
+			 */
+			panic("CXL: dropped uncorrectable protocol error\n");
+		}
+
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
+		pci_dev_put(pdev);
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+	return true;
+}
+
+void cxl_register_proto_err_work(struct work_struct *work,
+				void (*flush)(void))
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+
+	/*
+	 * Warn on double-registration to surface driver bugs (e.g. missing
+	 * cxl_unregister_proto_err_work() on module exit)
+	 */
+	if (WARN(cxl_proto_err_kfifo.work,
+		 "AER-CXL kfifo consumer already registered\n"))
+		return;
+	cxl_proto_err_kfifo.work = work;
+	cxl_proto_err_kfifo.flush = flush;
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
+	cxl_proto_err_kfifo.flush = NULL;
+
+	/* rwsem_write excludes all producers; fifo_lock not needed */
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
+	struct work_struct *work;
+
+	lockdep_assert_not_held(&cxl_proto_err_kfifo.rwsem);
+
+	work = cancel_cxl_proto_err();
+
+	/* Wait for any in-flight cxl_proto_err_wait_for_empty() calls to complete */
+	wait_var_event(&cxl_proto_err_kfifo.flush_inflight,
+		       atomic_read(&cxl_proto_err_kfifo.flush_inflight) == 0);
+
+	if (work)
+		cancel_work_sync(work);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
+
+/**
+ * for_each_cxl_proto_err - Call a function for each kfifo work item
+ *
+ * Single-consumer invariant: this function is only called from
+ * cxl_proto_err_work_fn() via a single DECLARE_WORK.
+ *
+ * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
+ * or cxl_unregister_proto_err_work().
+ */
+void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			    cxl_proto_err_fn_t fn)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
+		fn(wd);
+
+		/* Corresponding ref incr taken in cxl_forward_error() */
+		pci_dev_put(wd->pdev);
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
+
+/**
+ * cxl_proto_err_wait_for_empty - drain pending AER-CXL kfifo work synchronously
+ *
+ * Ensures CXL RAS handling and panic policy complete before AER
+ * recovery proceeds. Only needed for UCE; CE runs asynchronously.
+ *
+ * Snapshots the flush callback under rwsem_read, then releases the
+ * rwsem before calling it to avoid deadlock with a concurrent
+ * rwsem_write from cxl_unregister_proto_err_work().
+ *
+ * The flush_inflight counter (typically 0 or 1) prevents module
+ * unload while a flush is in progress outside the rwsem.
+ */
+void cxl_proto_err_wait_for_empty(void)
+{
+	void (*flush)(void);
+
+	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
+		flush = cxl_proto_err_kfifo.flush;
+		if (flush)
+			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
+	}
+
+	if (flush) {
+		flush();
+		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
+			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
+	}
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c844..357310916088f 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,9 +130,15 @@ struct aer_err_info;
 bool is_aer_internal_error(struct aer_err_info *info);
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_proto_err_wait_for_empty(void);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_proto_err_wait_for_empty(void) { }
 #endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286f..8eba3192e2d15 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -25,6 +25,7 @@
 #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
 
 struct pci_dev;
+struct work_struct;
 
 struct pcie_tlp_log {
 	union {
@@ -66,6 +67,29 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_CXL_RAS
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
+/**
+ * Callback for processing a CXL protocol error from the AER-CXL kfifo.
+ */
+typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
+
+void cxl_register_proto_err_work(struct work_struct *work,
+				void (*flush)(void));
+void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			    cxl_proto_err_fn_t fn);
+void cxl_unregister_proto_err_work(void);
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1

