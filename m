Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BD480DE9;
	Wed,  2 Sep 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356414; cv=fail; b=FFi5mQDNxLsdHKqU47c2KzLwWkp89Ne1CzP4RrnszCAGISpOX71Mw28IfezKOe02wbDDNiaPYRyFFtWPOeQPcSfVGT0/FkWLMnKOlmVT4ms5BdfD7MdjtouaWBvdG6s8ycAEEvyMrKYTeddAY65pP+VrhQT2LYp7iLdaCKptONI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356414; c=relaxed/simple;
	bh=cYCD0zDnUfqvbQzX2IrosUE6vzQuf/TA05RMCjGQWUY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S49jaB9T5U9h43MctZmGJWy3CyjB6UzHMZXHTSCK1NWz1lFlidC3nhVgCCXoRCOff5VlKZ4kdCefpeQOyXx6p6G1KPHgwwEx4shNGULT/FvyjBFHlrEJb4675MNomi00cPd4CNmjpFVGTgms6uTvVbHNNWGSrN6uk/E1dc174kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k53Zmj78; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k53Zmj78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EofOGhJCY0NNAg2Tg/5M/XXbaDQnUGY4sC24exGLcz99rbsTttnnhF3Qrss8YDK1I8uiIIgiOGzoVeu19zzKBJN+iyBkoNh+T92oMmNxbBKlCY+KW6fSdAAoQpoXXSA1YIK1N1loa98OGCF7tVuWZdz7SVnu92XuPlOGPUqh3/w58H2i1YYCLYP/X5ztiEpoUrCBZmjh6Q2u3PLW5taw1uhFHgZtNW+/iz3LSPrkQLiKw3KnQH9ANbpwzKcTUv9EN5yQu/kUqSzDBFozw9cC5oKVumpnfsyhvcKxach3QwGSZo2sP8IuuF0JTvzciECXsKKIATjHQoKObZibEUi1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYqxXpLLcCSg3yiOJRyG1I+INGPoFYpJioL9CL33kho=;
 b=v3P8JZNh0iwyB1SzXwHReqPTzn4k8ZZjlGSLEVSKNjyED3Xi8kqyVD8TUG3nNoH9VPnY2djM47TWtvDj2j44KUi5lU1+qpxwjFyVhKdgWtDogqush8Ve8dfacv6Tv67cCu2a5vmHKn9NerOe9qxrM3HdFDBr1lr8w4BeXcAYrrcjvuo2vEC5MQwx5P+np1MYMShrlrFgwSeT1KaWrsMV3C/DEGFPzN6Zr4GOW1SZcm+twd7jDoN9Mig5ypCoPPPUI5o8Ux/AIMDMkG6XTBwDNhQ5RqvZZG2RinavOnWIUFJdymVOGN5DSWxmNEUb57aSptsgnSFc/FsCfO8vVTdr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYqxXpLLcCSg3yiOJRyG1I+INGPoFYpJioL9CL33kho=;
 b=k53Zmj78wTNbtPw4NXoV7RLh0N8uYzevil/7oI6F96ld0Oj7CLC6juOp8j69dzY6KgSVjuiUKw4iXKBPVkq6kGiGnNZ2pfybGMWXY5ZsiEOM8Kb8cVmvkMRR289IKv/HA6dToaaGzHLJy/mCoHnjzaRKbTgPPoC98b2QWyxerII=
Received: from BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:39:53 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::15) by BY5PR04CA0029.outlook.office365.com
 (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:39:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:39:50 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
Date: Wed, 2 Sep 2026 08:39:25 -0500
Message-ID: <20260902133933.2992457-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c932c6e-572c-46e0-66e7-08df08f7aa8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|6133799003|22082099003|921020|18002099003|56012099006|5023799004|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6cK2KIJp0nXrHjPdVBJwEhiv3jZtG8XXVeOYcaLjbbq3HTDq/b7SXQDXlRwjbPTiziOCZCfLBpdmrMgCa8IY3Ux+bLow4gvldPmhnU0P0NNLZe7Nhak76mdrZrbLzKNEoUz0zMIgEvowJ3szjmiymTNctXaUBtlmx7QleSD91/Qw8ti4fwWmXLsquRDdCIkNFttCxx4NtHpYbX39joMO2FtR/vo5trxBOlfKiSCCTvVqyILUVmFTF4wOKbFy6iyhDNEfmAJVirbCoGtV9XBz6NCFYfk9TPnPViRZjFxExmP4WnH2Aty4AHHsE2rwDMqwU72X0QxW+FfjbkZmkTPWijFjcWEClSg1bBMy8lLU8RBb3OCW53+wvJb7+gO3k+V/ikw3rrd1Ae/O464zR7ehYWSsOSUIL2GHbN2mKQX92m7OaLBxxdYW9q2YtkiAbo9gR5WkmVJnE+Syn5dVndlLsTcSCF/RrIkuCbowVTukdVmB7XdbeU6VB9X/BaTvcPa5hWQGtcWeWuVpmisLrqsfjnaNJmYUXiLcvbKXoQ/TChnAjK4WVwuuQ5EQZqklOS4hPw+mokkWzDsEzrxDJJzS6LPKZy1pP3ERwI82ionB1zgG4JCdnJu80t8oigsp6xfxRNpwC0GmuJ7F3v6a8pn/eAlNSPlpCFfoNW5H6Mfz060gyLKGjal60BQiS9LVzhkpFj2/ALGVBspNa5+4XUvm4JMMMpA8DviXqI8VYGysZsDBg7n+Bu5R+PjeviOnHgAX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(6133799003)(22082099003)(921020)(18002099003)(56012099006)(5023799004)(3023799007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y2K3o4syTQpOnykithAvxonO8TeaA8CSXGhHGZmiIJ9QEPyLe613tybw8kOlRl7ihROFzIWh8eXqtdEe2t3qmeJM73X8TvinWj3g/ktv8AEm6ruuqZLacPuwp7p9niMSY4zXtddb6NUpyVnPB57kPbR9Gf2FS5FKAmMgI5pDIVKka2GIWADHMct/zJjaVxsH+YZhUQYgyvvUtFF/HFyMyZnPQ8yeUQ59s01oDAqXYCsK24zgZTUiHJ/lAoRb3ZAPLNqJscOUB/+M/3QKO/04MXPWcouyXpMNyrI45XeIR2fiYU4YB5OOTXsaHtf6MuQWimBT5nA5X7ymnq2Hms6JpCVCyIFSPi3xfGIHl7nPvByKxZG92bxr1s+xT/DRYMQ2eQl9Txv+1yTWmywV/hbmtQJxRg8teUIS5Q1SIQccXDK+9Yp+cuaACG3M5qawUYim
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:39:51.9826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c932c6e-572c-46e0-66e7-08df08f7aa8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6

CXL VH RAS handling requires the AER driver to hand off CXL protocol
errors to cxl_core for logging and recovery before PCIe AER recovery
tears down the device. Introduce pci/pcie/aer_cxl_vh.c to implement
this handoff via a kfifo-backed work item.

The producer, cxl_forward_error(), is gated by is_cxl_error() and
enqueues the error source PCI device and severity. cxl_core registers a
consumer via cxl_register_proto_err_work(); the consumer drains the
kfifo with for_each_cxl_proto_err(). For uncorrectable errors,
cxl_proto_err_wait_for_empty() lets the AER path block until the CXL
plane has finished so recovery does not race device teardown.

A rwsem serializes registration, deregistration, enqueue, and dequeue
against concurrent AER IRQ threads; a spinlock serializes concurrent
kfifo writers. is_aer_internal_error() moves into this file and now
evaluates info->status & ~info->mask rather than the raw info->status,
so a masked internal-error bit is treated as not-set. For the RCH RCEC
path this is equivalent because cxl_rch_enable_rcec() first calls
pci_aer_unmask_internal_errors(), which clears those mask bits in
hardware before the AER status is read back.

A subsequent patch wires cxl_forward_error() into handle_error_source().

Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
entry.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v19->v20:
- Drop a correctable error on full kfifo instead of panicking
- Add explicit ATOMIC_INIT(0) for flush_inflight
- Change is_aer_internal_error() to use mask in evaluation.
- Condense commit message (Jonathan)
- Document constraints for_each_cxl_proto_err()
- Document the @wd and @fn parameters of for_each_cxl_proto_err() (kernel-doc)

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
 drivers/pci/pcie/aer_cxl_vh.c | 243 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |   6 +
 include/linux/aer.h           |  24 ++++
 6 files changed, 276 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c9..f6ca37995ff84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6572,6 +6572,8 @@ S:	Maintained
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
index d8dcd238fda1f..21dfc9c933d77 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1288,16 +1288,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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
index 0000000000000..9fc12d4e644bc
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,243 @@
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
+	.flush_inflight = ATOMIC_INIT(0),
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
+	u32 status = info->status & ~info->mask;
+
+	if (info->severity == AER_CORRECTABLE)
+		return status & PCI_ERR_COR_INTERNAL;
+
+	return status & PCI_ERR_UNC_INTN;
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
+ * consumer registered). Note that on a full kfifo a correctable error is
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
+		pci_dev_put(pdev);
+
+		/*
+		 * A correctable error is device-local and recoverable, so a
+		 * dropped CE is safe to log and discard. Never panic on CE
+		 * pressure: a CE storm must not fill the fifo and escalate a
+		 * later event.
+		 */
+		if (info->severity == AER_CORRECTABLE) {
+			dev_err_ratelimited(&pdev->dev,
+					    "AER-CXL kfifo full, CE dropped\n");
+			return true;
+		}
+
+		/*
+		 * Unlike PCIe AER, a dropped CXL.mem uncorrectable error
+		 * cannot be treated as device-local: it may signal lost cache
+		 * coherency over HDM memory in active use. The error can no
+		 * longer be confirmed via CXL RAS, and reaching here means the
+		 * fifo is saturated with pending protocol errors. Collapse the
+		 * unknown state to the same conservative outcome as a confirmed
+		 * UCE.
+		 */
+		panic("CXL: dropped uncorrectable protocol error\n");
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
+ * @wd: caller-provided work-data scratch buffer, populated per kfifo entry
+ * @fn: callback invoked for each dequeued &struct cxl_proto_err_work_data
+ *
+ * Single-consumer invariant: this function is only called from
+ * cxl_proto_err_work_fn() via a single DECLARE_WORK.
+ *
+ * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work(),
+ * cxl_unregister_proto_err_work(), or cxl_proto_err_wait_for_empty() (all take
+ * or wait on the same rwsem).
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

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.34.1

