Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE944F96C1;
	Fri, 18 Sep 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743422; cv=fail; b=iJcfW0ryIVn/Wy4m7rEARB0M6sN29QbhwJ5CavOMvSYNC9/55U31xj4nXHw6FJEaQS8DXLm8rwbSOxCmttpVN0M3s7gcrqBkFpWLO3R/Lsl+MzxXgPHSaZV8BEKNYF8JBLlR5Hr0feWPAoacBQLMJjZmgbysKp+441cI/6lXfKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743422; c=relaxed/simple;
	bh=wuBw8YeZb1Z5raaCv7ll1oTmjW5AWhSX+Y2n2QCYeBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Scy9IRwNWBbDJGAmYEFIR4A9gPv5EpT80dlnFcDtCoZkOmWSGG3aQJcJneX4bB7wHCjkim1+y2lFi0D7rJC1gbiA8s/0/mNi+sIgJd5hgXQsW1BLOCyChBH3VgGUmpdOFpzb37QK9LS6IiX9ApOhijR9T+9MqsXmbre00dyt5iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJRu6ELa; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJRu6ELa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2h5EwCmEKo0KrNR82sfY7NrbTzLguqLTGYi99snYpn6QNXEsUNoZZ+xXvTImK3iEoEIiB8qZ7mE6B339KQBVgfQ4JGWzSdg02QEL5ewFa1TOpwLy+R5WAUp3aE/vNCQg4GiHDiQKSk7k963RnA+w4sw+bSixfTuBFf93BHj5IlSFZpI3mMM0tkOxNd0AyNXT98sE2a6icZ2OwggEP4QidzczVQGzx+o9NOnOdamT0fvcuH3PV6M5N54H3KPfdYs8TzQSPbAsv0obq2A2U285Ip2JXIbAT4eczKV49bxx7rgYSy2AWHjSi35HL7pFGS29dBca4MUDr1f6nAHXDO4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8I2YqlTXvuMxYr0kB6BZustc9alF8S36fI7xUyCBVI=;
 b=QAtvbt+sdwGWzxh7RZ9R4b57DOQHLiAE45Bfxfl+zDbFTuGVIsedeLiwjgJyYUQMp81as2fFyuyx7FP+A9Va3jbIeWlmtthRPXJBEVkOaAVK9IYBwFOi6k8HY5IbSGLzBkLt5DEqEMOvipisd5KdRKwQaMsA2ZtpvYbrQDWwO4wd46lY25g6YL7/zYwXmgM0fQ2wXMW1JxpYOhcwP+j9bjlbFFE/LuFiCHSqw07tNxMD16j5U32HuAMgs2oUaY9MI+YXs5ihf7PV4aiqIXqSQIDJJF0+WFhGx7o3l7MZf/vEtT+BWxWvXe7bE0YkdJ/9x/u0Tmij0xiBLHo4nfZgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8I2YqlTXvuMxYr0kB6BZustc9alF8S36fI7xUyCBVI=;
 b=DJRu6ELaDTYZJkESsJXE1sAsAFlGXj+wYuNXkd0x1+PaaoZP86gV+3Krx+x26CTLs72TfQ/+MAQFSLurhrVt3z6R64345vYH4v9F/SMH/uj3Y/0EWr6/GJE8O+TI58tUTdtWZQcOxhohyJlhEZQ7BBqUffPwXT7Bdpk9dgrbBiw=
Received: from CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 14:56:53 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::8e) by CH2PR15CA0001.outlook.office365.com
 (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 14:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:53 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:51 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 07/10] PCI/FLIT: Add support for Flit Logging Extended Capability
Date: Fri, 18 Sep 2026 09:56:15 -0500
Message-ID: <20260918145619.3016889-8-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8a6ff9-1aa7-4c24-beda-08df159513b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|5023799004|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cApch4lbYiYgU2psM1+S4693ga8DagMCc0are8+/vclukvrpKd4BEDWNrMUlsI9ukIEc6dsb4Z5pxpEek6ubNooxQrhO7eqs4ma/Svzwh7dGCpqqeXtklO99czFyBJYNcZv2eAz+1ge13cmoLetuX5QFC88MVfncomSU/BtXkcqnDB77gVlE/auo6wpudMc+y3ZQakeAGhKdOAWy4gleTdvO50THBUcpz9v1IHDoZC1PJD6AJtwXOjLoGNw744a9JGZg8zz6UBQSBjWu7oce1fJsi3dtngpyoKbZY84HshD+Al/tg4wGZzB5dHKS3RaRyQ1aYmOzPKQ5QcqBgv2CyuMTxfISPTR225megOoBG6Qdxm9llnvIH5TI1kqWKwMtBD3OIFBZD+KRcvSWCDb4Oohnd7N9IcLi126/WvqUx0JG1j5iZnAz8Ci5g4MFM4P90DzKMb0LS6pmcU8zc0l7e3rrAG248gqxOQ0w3D0rxA1zKJDzTsAecX35J5QpoQ8cYkiT0AGL2ylPPUZo1soJzxsxG3FfIPQsgtVJEkVQBXZU5pXFpAtJaUvdD/rKYno0NPQEg3wV9dHw2VtXrgKcyUToT+cIBVyDF8O+PjYpWnztZdvlJ5W8Qs6kgPTqKc86q9UewJ4SiyDCsWWlYOr9MnVNxKDoxmd0xABdOQdfAvKG4HNqXxRVrsEZp1BK1V/axWupam5dMwo+MJbY2x2ayg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p8UKsCTqXJX9PwwTf+x1rM6HWYKZe7I4RIqHGI1DisscrHcqhHKMzA0d1eQSNSMUUbn6/oHgzBHs+ztl+qkyMYuXo0OqSCegdCtSXEOEaQxs9YXhjigAm4Xm+WPq0wRORCLLyp1Er/kgqsFnD4msYKTi8jlYkqXxD8JA9nAIgjkUWpaBj+Ayfu1/N00uMpJrL2zeQjpLmREengwznO2IVDf4bS1R+p+c2B0e1YW1IhT07xvTP04zMgD/lHCYau4n2XKGo4lS7JPttykdX6KNYSdqvEW923Q/EteL4VzPTeju2pQZAd1ylPgY5uyXCj4Hd/VV94gBXWbnLAUHUAwgXyCnA5TYr7OHzO8dSacmgTaSoeS5JXUbrJjQfpT+USRM3dD2ErGWbdfFdS/A6qfToPAHatn/5DkhhdxPQLlbk9aVt1jq1nTmQcC2jGIFwmYT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:53.4491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8a6ff9-1aa7-4c24-beda-08df159513b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

PCIe r6.4 defines the Flit Logging Extended Capability for logging
erroneous flits, and requires it on ports and RCRBs that support PCIe
Flit Mode.[1]

Add a port service driver for it. Include _OSC negotiation for control
of the capability.

The driver claims only the port types the PCIe port bus driver binds to.
An Endpoint implements the capability on its Upstream Port too, and _OSC
is negotiated per host bridge, so accepting control leaves those
instances with neither firmware nor the OS managing them. Covering them
needs a home outside the port bus driver.

[1] PCI Express® Base Specification Revision 6.4, section 7.7.8

Link: https://pcisig.com/specification/extend-osc-negotiate-control-pcie-flit-logging-extended-capability
Originally-by: Avadhut Naik <avadhut.naik@amd.com>
Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/pci_root.c       |  11 ++
 drivers/pci/pci.c             |   2 +
 drivers/pci/pci.h             |  12 ++
 drivers/pci/pcie/Kconfig      |   9 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/flit.c       | 324 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c    |   7 +
 drivers/pci/pcie/portdrv.h    |  13 +-
 drivers/pci/probe.c           |   3 +
 include/linux/acpi.h          |   1 +
 include/linux/pci.h           |   6 +
 include/uapi/linux/pci_regs.h |  19 +-
 12 files changed, 405 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/pcie/flit.c

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 88c65f34e305..402686a9ca4c 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -137,6 +137,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
 	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
+	{ OSC_PCI_EXPRESS_FLIT_CONTROL, "FlitLogging" },
 };
 
 static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
@@ -520,6 +521,14 @@ static u32 calculate_control(void)
 	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
+	/*
+	 * An OS that requests Flit Logging control must request AER control
+	 * as well, so pair it with the bit that was actually requested above.
+	 */
+	if (IS_ENABLED(CONFIG_PCIE_FLIT) &&
+	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
+		control |= OSC_PCI_EXPRESS_FLIT_CONTROL;
+
 	return control;
 }
 
@@ -1040,6 +1049,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_ltr = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
 		host_bridge->native_dpc = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_FLIT_CONTROL))
+		host_bridge->native_flit = 0;
 
 	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
 		host_bridge->native_cxl_error = 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..c1cfa0e3d75c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1798,6 +1798,7 @@ int pci_save_state(struct pci_dev *dev)
 
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
+	pci_save_flit_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
 	return pci_save_vc_state(dev);
@@ -1870,6 +1871,7 @@ void pci_restore_state(struct pci_dev *dev)
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
+	pci_restore_flit_state(dev);
 
 	pci_restore_config_space(dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f43c5330fca3..53a90f75cd76 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1000,6 +1000,18 @@ static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
+#ifdef CONFIG_PCIE_FLIT
+void pci_flit_init(struct pci_dev *pdev);
+void pci_flit_exit(struct pci_dev *pdev);
+void pci_save_flit_state(struct pci_dev *pdev);
+void pci_restore_flit_state(struct pci_dev *pdev);
+#else
+static inline void pci_flit_init(struct pci_dev *pdev) { }
+static inline void pci_flit_exit(struct pci_dev *pdev) { }
+static inline void pci_save_flit_state(struct pci_dev *pdev) { }
+static inline void pci_restore_flit_state(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCIEPORTBUS
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..7ddadad57d3f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -146,3 +146,12 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_FLIT
+	bool "PCI Express Flit Logging support"
+	depends on PCIEPORTBUS && PCIEAER
+	help
+	  This enables support for the PCI Express Flit Logging Extended
+	  Capability, which logs errors encountered by a port operating
+	  in PCIe Flit Mode.  If your system doesn't have this capability
+	  or you do not want to use this feature, it is safe to answer N.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..14a5222920b9 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_FLIT)		+= flit.o
diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
new file mode 100644
index 000000000000..7c0b9c8dd481
--- /dev/null
+++ b/drivers/pci/pcie/flit.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Service driver for PCIe Flit Logging Extended Capability
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors:	Avadhut Naik <Avadhut.Naik@amd.com>
+ *		Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#define pr_fmt(fmt) "Flit: " fmt
+#define dev_fmt pr_fmt
+
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include "portdrv.h"
+#include "../pci.h"
+
+/*
+ * Report only a link accumulating errors far faster than the counter drains.
+ * 0xff never fires, since an event needs the counter to exceed the trigger.
+ */
+#define FLIT_DEFAULT_TRIGGER	0xfe
+
+/*
+ * Per PCIe r6.4, sec 7.7.8.2, table 7-93, More Entries can be set again
+ * mid-drain, so bound the loop.
+ */
+#define FLIT_MAX_LOG_ENTRIES	0xff
+
+/*
+ * Per PCIe r6.4, sec 7.7.8.2, table 7-92, an entry with none of these set
+ * and Flit Error Log 2 zero is Reserved.
+ */
+#define FLIT_ERR_LOG1_ERROR	(PCI_FLIT_ERR_LOG1_UNRECOG | \
+				 PCI_FLIT_ERR_LOG1_FEC_UNCOR | \
+				 PCI_FLIT_ERR_LOG1_SYND_PARITY0 | \
+				 PCI_FLIT_ERR_LOG1_SYND_CHECK0)
+
+/* Only the port types pcie_portdrv_probe() claims get a Flit service. */
+static bool flit_is_port(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	case PCI_EXP_TYPE_RC_EC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Without _OSC control the OS must not touch the capability. Flit Logging
+ * control is only meaningful alongside AER control, so require both.
+ */
+static bool flit_is_native(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+	if (pcie_ports_native)
+		return true;
+
+	return host->native_flit && host->native_aer;
+}
+
+struct flit_info {
+	spinlock_t lock;	/* serializes Counter Control read-modify-write */
+	bool cntr_enabled;	/* Counter Enable as the driver intends it */
+};
+
+void pci_flit_init(struct pci_dev *pdev)
+{
+	if (!flit_is_port(pdev) || !flit_is_native(pdev))
+		return;
+
+	pdev->flit_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_FLIT);
+	if (!pdev->flit_cap)
+		return;
+
+	pdev->flit_info = kzalloc_obj(*pdev->flit_info);
+	if (!pdev->flit_info) {
+		pdev->flit_cap = 0;
+		return;
+	}
+
+	spin_lock_init(&pdev->flit_info->lock);
+
+	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_FLIT, sizeof(u16));
+
+	pci_dbg(pdev, "Flit Logging Extended Capability present.\n");
+}
+
+void pci_flit_exit(struct pci_dev *pdev)
+{
+	kfree(pdev->flit_info);
+	pdev->flit_info = NULL;
+	pdev->flit_cap = 0;
+}
+
+void pci_save_flit_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pdev->flit_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
+	if (!save_state)
+		return;
+
+	/*
+	 * Take Counter Enable from the driver rather than the register.
+	 * flit_isr() clears it and only flit_ist() sets it again once the log
+	 * is drained, and a save landing in between would capture a zero that
+	 * the next restore writes back for good.
+	 */
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, cap);
+	if (pdev->flit_info->cntr_enabled)
+		*cap |= PCI_FLIT_ERR_CNTR_CTRL_EN;
+	else
+		*cap &= ~PCI_FLIT_ERR_CNTR_CTRL_EN;
+}
+
+void pci_restore_flit_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pdev->flit_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, *cap);
+}
+
+/*
+ * Serializes the Counter Control read-modify-write against flit_isr(), which
+ * runs in hard irq context on the vector this port shares with PME, hotplug
+ * and bandwidth notification. A lost update here leaves Trigger Event on Error
+ * Count at zero, and per PCIe r6.4, sec 7.7.8.4, table 7-95, a zero trigger
+ * never generates an event.
+ */
+static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
+{
+	unsigned long flags;
+	u16 ctrl;
+
+	spin_lock_irqsave(&pdev->flit_info->lock, flags);
+	pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, &ctrl);
+	ctrl &= ~clear;
+	ctrl |= set;
+	pci_write_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, ctrl);
+	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
+}
+
+static void flit_cntr_enable(struct pci_dev *pdev)
+{
+	u16 flit = pdev->flit_cap;
+	unsigned long flags;
+	u16 reg;
+
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &reg);
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, reg);
+
+	pdev->flit_info->cntr_enabled = true;
+
+	spin_lock_irqsave(&pdev->flit_info->lock, flags);
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &reg);
+
+	/* Set default trigger count if not set by platform, since zero never fires */
+	if (!(reg & PCI_FLIT_ERR_CNTR_CTRL_TRIGGER))
+		reg |= FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, FLIT_DEFAULT_TRIGGER);
+
+	reg |= PCI_FLIT_ERR_CNTR_CTRL_EN | PCI_FLIT_ERR_CNTR_CTRL_INTR_EN;
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, reg);
+	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
+}
+
+static void flit_cntr_disable(struct pci_dev *pdev)
+{
+	pdev->flit_info->cntr_enabled = false;
+	flit_cntr_ctrl_update(pdev, PCI_FLIT_ERR_CNTR_CTRL_EN | PCI_FLIT_ERR_CNTR_CTRL_INTR_EN, 0);
+}
+
+static void flit_report(struct pci_dev *pdev, u32 err_log1, u32 err_log2)
+{
+	/* Software should silently discard a Reserved entry */
+	if (!(err_log1 & FLIT_ERR_LOG1_ERROR) && !err_log2)
+		return;
+
+	pci_warn(pdev, "ErrLog1: 0x%08x ErrLog2: 0x%08x\n", err_log1, err_log2);
+}
+
+static irqreturn_t flit_ist(int irq, void *context)
+{
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct pci_dev *pdev = dev->port;
+	u16 flit = pdev->flit_cap;
+	u32 err_log1, err_log2;
+	unsigned int i;
+
+	for (i = 0; i < FLIT_MAX_LOG_ENTRIES; i++) {
+		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
+
+		if (PCI_POSSIBLE_ERROR(err_log1) || !(err_log1 & PCI_FLIT_ERR_LOG1_VALID))
+			break;
+
+		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
+
+		flit_report(pdev, err_log1, err_log2);
+
+		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
+
+		if (!(err_log1 & PCI_FLIT_ERR_LOG1_MORE))
+			break;
+	}
+
+	/*
+	 * Re-enable the counter. Per PCIe r6.4, sec 7.7.8.5, table 7-96, the
+	 * status bit is "Cleared on 0b to 1b transition of Flit Error Counter
+	 * Enable", which also clears the counter and re-arms interrupt
+	 * generation.
+	 */
+	flit_cntr_ctrl_update(pdev, 0, PCI_FLIT_ERR_CNTR_CTRL_EN);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t flit_isr(int irq, void *context)
+{
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct pci_dev *pdev = dev->port;
+	u16 flit = pdev->flit_cap;
+	u16 cntr_sta;
+
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
+	if (PCI_POSSIBLE_ERROR(cntr_sta) || !(cntr_sta & PCI_FLIT_ERR_CNTR_STA_INTR_GEN))
+		return IRQ_NONE;
+
+	/*
+	 * Clear Flit Error Counter Enable first, so the counter cannot reach
+	 * the trigger again while the thread runs, then clear the status bit.
+	 * A message-signaled vector needs no more than that, but this service
+	 * can land on INTx, where the line stays asserted until the status is
+	 * cleared. flit_ist() transitions Counter Enable back 0->1.
+	 */
+	flit_cntr_ctrl_update(pdev, PCI_FLIT_ERR_CNTR_CTRL_EN, 0);
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA,
+			      PCI_FLIT_ERR_CNTR_STA_INTR_GEN);
+	return IRQ_WAKE_THREAD;
+}
+
+static int flit_probe(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	int status;
+
+	/*
+	 * Not devm_request_threaded_irq(): devres would free the IRQ only
+	 * after .remove() runs, too late to stop flit_ist() re-enabling the
+	 * counter.
+	 */
+	status = request_threaded_irq(dev->irq, flit_isr, flit_ist,
+				      IRQF_SHARED, "pcie-flit", dev);
+	if (status) {
+		pci_warn(pdev, "request Flit IRQ %d failed: %d\n", dev->irq, status);
+		return status;
+	}
+
+	flit_cntr_enable(pdev);
+	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
+
+	return 0;
+}
+
+/*
+ * No .suspend or .runtime_suspend counterpart. pci_save_state() runs after
+ * both, so disabling the counter there would put a transient value in the
+ * save buffer, and pcie_portdrv_slot_reset() restores that buffer after
+ * calling .slot_reset.
+ */
+static int flit_cntr_restore(struct pcie_device *dev)
+{
+	flit_cntr_enable(dev->port);
+	return 0;
+}
+
+static void flit_cntr_remove(struct pcie_device *dev)
+{
+	/* Drop the IRQ first: free_irq() waits for the threaded handler. */
+	free_irq(dev->irq, dev);
+	flit_cntr_disable(dev->port);
+}
+
+static struct pcie_port_service_driver flitdriver = {
+	.name		= "flit",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_FLIT,
+	.probe		= flit_probe,
+	.resume		= flit_cntr_restore,
+	.runtime_resume	= flit_cntr_restore,
+	.slot_reset	= flit_cntr_restore,
+	.remove		= flit_cntr_remove,
+};
+
+int __init pcie_flit_init(void)
+{
+	return pcie_port_service_register(&flitdriver);
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index ca1b9dbb8b08..6328233c75d7 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -278,6 +278,12 @@ static int get_port_device_capability(struct pci_dev *dev)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
+#ifdef CONFIG_PCIE_FLIT
+	/* flit_cap is set only when the capability is OS-managed */
+	if (dev->flit_cap)
+		services |= PCIE_PORT_SERVICE_FLIT;
+#endif
+
 	return services;
 }
 
@@ -834,6 +840,7 @@ static void __init pcie_init_services(void)
 	pcie_dpc_init();
 	pcie_bwctrl_init();
 	pcie_hp_init();
+	pcie_flit_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index bf18ca415990..975f83134a5b 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,13 +22,16 @@
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 #define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
 #define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
+#define PCIE_PORT_SERVICE_FLIT_SHIFT	5	/* Flit Logging */
+#define PCIE_PORT_SERVICE_FLIT		(1 << PCIE_PORT_SERVICE_FLIT_SHIFT)
 
 /* Services sharing the PCI Express Capability Interrupt Message Number */
 #define PCIE_PORT_SERVICES_EXPCAP	(PCIE_PORT_SERVICE_PME | \
 					 PCIE_PORT_SERVICE_HP | \
-					 PCIE_PORT_SERVICE_BWCTRL)
+					 PCIE_PORT_SERVICE_BWCTRL | \
+					 PCIE_PORT_SERVICE_FLIT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   6
 
 extern bool pcie_ports_dpc_native;
 
@@ -56,6 +59,12 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIE_FLIT
+int pcie_flit_init(void);
+#else
+static inline int pcie_flit_init(void) { return 0; }
+#endif
+
 int pcie_bwctrl_init(void);
 
 /* Port Type */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..6bf62bdadc8d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -674,6 +674,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+	bridge->native_flit = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
 	bridge->dev.type = &pci_host_bridge_type;
@@ -2465,6 +2466,7 @@ static void pci_configure_device(struct pci_dev *dev)
 
 static void pci_release_capabilities(struct pci_dev *dev)
 {
+	pci_flit_exit(dev);
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
@@ -2666,6 +2668,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pasid_init(dev);		/* Process Address Space ID */
 	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
+	pci_flit_init(dev);		/* Flit Logging */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..b3d8a5bb79e9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -667,6 +667,7 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_EXPRESS_FLIT_CONTROL		0x00000800
 
 /* CXL _OSC: Capabilities DWORD 4: Support Field */
 #define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT	0x00000001
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8650c627bebb..37d01fab50bb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -598,6 +598,11 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCIE_FLIT
+	u16		flit_cap;	/* Flit Logging Capability offset */
+	struct flit_info *flit_info;	/* Flit Logging state */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -663,6 +668,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
+	unsigned int	native_flit:1;		/* OS may use PCIe Flit logging */
 	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..73482024359b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -763,7 +763,8 @@
 #define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
+#define PCI_EXT_CAP_ID_FLIT	0x32	/* Flit Logging */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_FLIT
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1187,6 +1188,22 @@
 /* Physical Layer 64.0 GT/s */
 #define PCI_PL_64GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 
+/* Flit Logging Extended Capability */
+#define PCI_FLIT_ERR_LOG1		0x04		/* Flit Error Log 1 Register */
+#define  PCI_FLIT_ERR_LOG1_VALID	0x00000001	/* Flit Error Log Valid */
+#define  PCI_FLIT_ERR_LOG1_MORE		0x00002000	/* More Entries Valid */
+#define  PCI_FLIT_ERR_LOG1_UNRECOG	0x00004000	/* Unrecognized Flit */
+#define  PCI_FLIT_ERR_LOG1_FEC_UNCOR	0x00008000	/* FEC Uncorrectable Error in Flit */
+#define  PCI_FLIT_ERR_LOG1_SYND_PARITY0	0x00ff0000	/* Syndrome Parity for ECC Group 0 */
+#define  PCI_FLIT_ERR_LOG1_SYND_CHECK0	0xff000000	/* Syndrome Check for ECC Group 0 */
+#define PCI_FLIT_ERR_LOG2		0x08		/* Flit Error Log 2 Register */
+#define PCI_FLIT_ERR_CNTR_CTRL		0x0c		/* Flit Error Counter Control Register */
+#define  PCI_FLIT_ERR_CNTR_CTRL_EN	0x0001		/* Flit Error Counter Enable */
+#define  PCI_FLIT_ERR_CNTR_CTRL_INTR_EN	0x0002		/* Flit Error Counter Interrupt Enable */
+#define  PCI_FLIT_ERR_CNTR_CTRL_TRIGGER	0x0ff0		/* Trigger Event on Error Count */
+#define PCI_FLIT_ERR_CNTR_STA		0x0e		/* Flit Error Counter Status Register */
+#define  PCI_FLIT_ERR_CNTR_STA_INTR_GEN	0x0008		/* Interrupt Generated based on Trigger */
+
 /* Native PCIe Enclosure Management */
 #define PCI_NPEM_CAP     0x04 /* NPEM capability register */
 #define  PCI_NPEM_CAP_CAPABLE     0x00000001 /* NPEM Capable */
-- 
2.43.0

