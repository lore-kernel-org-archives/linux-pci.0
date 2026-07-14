Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A2377AAE;
	Tue, 14 Jul 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054425; cv=fail; b=iaV6rOoUGbvV7YROc03PtGDxYortQlI2IQb4/RihCgJmbX53JQyFHvdeeDNE012V+CONfaTS6YFicSg9qPZ2EhzYQFLX0eskcKQSQYpFzxQIVO1r0Q7Hi0wos2xj7VYaTRRKyxpISJnvbQqJF6D7hnmKu9pfWA24EHnAxnQCeVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054425; c=relaxed/simple;
	bh=PrHVjIVlAtiIHovVYCY/NG4Ow1D8kIukLPX6b+7TxP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVs5mkRDWQr29g2y42cbPIXMGgBRI52DP73mVy3IPy6GxH2sSxI9P8Rw5FgXzp4bfD6UOqwIx8u07jEVtknIKe6On67ExPX8d2x/C6Tavov9G5BehB3lt73hFDrYl2/v496vGZ2kOO5w0lCJeO9uxsmZ2PLBp0SSbc2UMMasSzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j4u16xqJ; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j4u16xqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKPJmB2TEPLaCxP6qgfdQA7tUKVxcLfgDxkQLy9hkxWDViOC57VZqAwxHU2a6fr+Mkxo9L8oYyz5iOovZxYKrgIn4O67xzBffPvK7q/7+vHaFqhe7NK0mIq4ZxyFMSBDG1CnqMp84sEXtrjyIgGzmI7mTTuJOwQlsQJYtdBK2EDjOERabDF1IBzCoi4Oynl3zfwoEtmo1nwuxPS7GJ3F5i6vA+ygfs0qNPgFFvN6xVOiSTMMIOFbUH4wbgnyHYpKZmj0aun1jyIC/LVP7QJuca/0RYkueDkfmPZLnmkmabh989V3zNZyegXz7Vco7p6u7eVBxP0k6HEOW4MzosLDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzEriI4wWfCRm67tRc98s7ZN6x11aFl+yvj3Gvzm2k4=;
 b=qcaq1ipO2AUPI61QWUuBMeh9COMoZ6LRMV8EiuL9rscfVVlDdQ1SJTuuo1/bAUTvb8i0gRSo5fNJzXNRL18HNFBehU1b1z8Ombhq33ViDfPKpkaqzTP1+QowDXMCdkLUR/FPByT0AfQe8JFuSe4DYOUlMqMYIYsOd7bbUQTjKWIn9OfDgJyt3pwlEyJDBHMmcxnmj2Vo1zDdjdhDBb4LrTETvvizjNB1px4zqEIMv71MaQD/hokPvaZT1AhecS/UW+5OZ5yU3WojocwUE66smzxgSTQu0o0kKnC61IDG/hXHbqoH0ahkOfmG1wK7B5/n3hvXQ0HM9NgN9wj52C/SNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzEriI4wWfCRm67tRc98s7ZN6x11aFl+yvj3Gvzm2k4=;
 b=j4u16xqJB2aCjmII3MusCNLT1PjTBC15O405rOswVIE1uk4nmRuP4x9J9lykiBGPBjN2Zfz5N98IlhCR55xtQ2847ofzCvXIS5lobhCCenaOjDQOcswzZq5t/l5m9grtxT+L6auO+4BzNPBUUt9DEJY1xWo1df4OiDXOsB0a2eg=
Received: from BN0PR04CA0133.namprd04.prod.outlook.com (2603:10b6:408:ed::18)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 18:40:06 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::36) by BN0PR04CA0133.outlook.office365.com
 (2603:10b6:408:ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:40:06 +0000
Received: from yaz-khff4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:40:04 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 2/5] PCI/FLIT: Add support for Flit Logging Extended Capability
Date: Tue, 14 Jul 2026 14:39:47 -0400
Message-ID: <20260714183950.1620016-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714183950.1620016-1-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 26acf787-cea8-4d50-6ae8-08dee1d75354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	k47oHNLYf7KTp+ace11mGqpYEmiLDQZxipD43xTBnhqtYit1GE+gIHJ8V+pnAh2Gsk1J9WosFnB5KkKOQH1Zx2fZG4j6Rrmx2LDol3x9clv40q44OyCZETxEPfkFrTO+ZMVrR2JMAXoNBgKOmapZrImYgaO0rbXZhjV+tZGCLRa4yPnaSeCHbi9w348S5ANK+fneXHMuWzms7A+j4PtBpRTuUhSTXjX7ogP1/dDPDtwQh7EKEcGY7fQn03FXytlXZszQd9GQN6ZDK4+67azQ39M2XK3hLBOh9x7se9Rr2cE1RxjZcB5OTWRi2gevfsd10N8Nlvc8l296T/fP7sWB7sPB5atGtYWYTE0o0yXIEu3Wjh6ONaHICEEg5gUVcPIJkoQrjHOCnML6msnUXcJqFqMc3EdrlQcdYSJtocrQIm3SA7V0ALtVLtUCbma6z4zBZks4Ia7zFeb21jD07n3CA5avKBywJPgvKkH7LVCXXAscCoMgWc9txDouaX1SpLIt3KsTvQ54A7bqAt79iHM4+CBkGiflIPiblGU1RKb18c6/8WDP8dkXIDm9hphswrX6gk9v+4dJ2/tIKQdFLEO6gcDszpw4aFByO7GjTAWveNe9MHytoaVu3+xnyDvBuJqFkRcnIPVo6FxSIKg/FDBknB16GdsX/kDHrr3U96wTYTMFSmrcYo/XVhAAQzhOnnVoqjN101ojLk4pJhUr/Lmstg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7L8/YgiDHNzNKdHP41Z2pKrE6cY+Afkh1Kir0kZlu/PjZeZjWKEcUw2/cIyLnQuMt6tKqyDHca70eiqKP0pxuPNyJsDlW0hFziRJE1G/XFW4yntlctWw/Y5vqOKSddFZF9eGp93S6OJ4egbEOJkyWrAQFFTIOP0VZa8t9vn81H3gB0M/ysT2xCobyImG04OXt6DMsqYbKi45CSKkfkoQbIspZnkBzH8PZPHrPTc0dKQGo4tYpoO8m2dwnJfvCJyzIwg/Ex9pDKaLacffbmGqiMSRfQG7yutfP/AgM520k7NiqCdWDkTvWFvC1zmhMLrT8ux8p0sql+auquHPi/51PR+p3OZIZuvUCeTRX6SJ7EzhMi22SbsodUPJEqI6cXPksOsID3qsIiEBM9xJNuvCdYhUQ7+bTFjmPNw0Z04IGspsTtNybHt3T3rcvE+Jkt0K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:06.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26acf787-cea8-4d50-6ae8-08dee1d75354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

From: Avadhut Naik <avadhut.naik@amd.com>

PCIe r6.0 introduced Flit Logging Extended Capability for logging
erroneous flits. This extended capability must be implemented by ports
and RCRBs that support PCIe Gen6 Flit Mode.[1]

Introduce support required for the Extended Capability as a port service
driver.

[1] PCI Express® Base Specification Revision 6.0, section 7.7.8

[Yazen: Fix ups, etc.]

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/pci/pci.h             |   6 ++
 drivers/pci/pcie/Kconfig      |  10 ++
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/flit.c       | 170 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c    |  15 ++-
 drivers/pci/pcie/portdrv.h    |  10 +-
 drivers/pci/probe.c           |   1 +
 include/linux/pci.h           |   4 +
 include/uapi/linux/pci_regs.h |  14 ++-
 9 files changed, 227 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/flit.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..31d04366b980 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -894,6 +894,12 @@ static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
+#ifdef CONFIG_PCIE_FLIT
+void pci_flit_init(struct pci_dev *pdev);
+#else
+static inline void pci_flit_init(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCIEPORTBUS
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..1ee3c85e63c1 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -146,3 +146,13 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_FLIT
+	bool "PCI Express Flit Mode Error Logging support"
+	depends on PCIEPORTBUS
+	help
+	  This enables support for the PCI Express Flit Logging Extended
+	  Capability, which logs errors encountered by a port operating
+	  in PCIe Gen6 Flit Mode.  If your system doesn't have this
+	  capability or you do not want to use this feature, it is safe
+	  to answer N.
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
index 000000000000..12f2b6fbf1de
--- /dev/null
+++ b/drivers/pci/pcie/flit.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Service driver for PCIe Flit Logging Capability
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
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include "portdrv.h"
+#include "../pci.h"
+
+void pci_flit_init(struct pci_dev *pdev)
+{
+	u16 cap;
+
+	if (pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &cap))
+		return;
+
+	if (!(cap & PCI_EXP_FLAGS_FLIT))
+		return;
+
+	pdev->flit_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_FLIT);
+	if (pdev->flit_cap)
+		pci_dbg(pdev, "Flit Mode Error Logging Capability present.\n");
+}
+
+static void flit_cntr_enable(struct pci_dev *pdev)
+{
+	u16 flit = pdev->flit_cap;
+	u16 reg;
+
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &reg);
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, reg);
+
+	/*
+	 * NOTE: The "Set Events to Count" and "Trigger Event Count" fields
+	 * are left as set by the platform.
+	 */
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &reg);
+	reg |= PCI_FLIT_ERR_CNTR_EN;
+	reg |= PCI_FLIT_ERR_CNTR_INTR_EN;
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, reg);
+}
+
+static void flit_cntr_disable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctrl, flit = pdev->flit_cap;
+
+	/* Disable both Error Counter and Interrupt generation */
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &ctrl);
+	ctrl &= ~(PCI_FLIT_ERR_CNTR_EN | PCI_FLIT_ERR_CNTR_INTR_EN);
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, ctrl);
+}
+
+static irqreturn_t flit_isr(int irq, void *context)
+{
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct pci_dev *pdev = dev->port;
+	u16 flit = pdev->flit_cap;
+	u16 cntr_ctrl, cntr_sta;
+	u32 err_log1, err_log2;
+
+	/* Read and log Counter and Error Log Registers. */
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &cntr_ctrl);
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
+
+	pci_info(pdev, HW_ERR "Counter Control: 0x%04x Counter Status: 0x%04x\n", cntr_ctrl, cntr_sta);
+
+	do {
+		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, &err_log1);
+
+		if (!(err_log1 & PCI_FLIT_ERR_LOG_VALID))
+			break;
+
+		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
+		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err_log1, err_log2);
+
+		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
+	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);
+
+	/*
+	 * Re-enabling the counter is the interrupt acknowledgment.
+	 *
+	 * The status bit checked in flit_irq() (Interrupt Generated based on
+	 * Trigger Event Count) is cleared by a 0->1 transition of Flit Error
+	 * Counter Enable, per PCIe r6.4 Table 7-96.
+	 */
+	cntr_ctrl |= PCI_FLIT_ERR_CNTR_EN;
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, cntr_ctrl);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t flit_irq(int irq, void *context)
+{
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct pci_dev *pdev = dev->port;
+	u16 flit = pdev->flit_cap;
+	u16 cntr_sta, cntr_ctrl;
+
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_STA, &cntr_sta);
+	if (!(cntr_sta & PCI_FLIT_INTR_GEN_CNTR))
+		return IRQ_NONE;
+
+	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &cntr_ctrl);
+	cntr_ctrl &= ~PCI_FLIT_ERR_CNTR_EN;
+	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, cntr_ctrl);
+	return IRQ_WAKE_THREAD;
+}
+
+static int flit_probe(struct pcie_device *dev)
+{
+	struct device *device = &dev->device;
+	struct pci_dev *pdev = dev->port;
+	int status;
+
+	status = devm_request_threaded_irq(device, dev->irq, flit_irq,
+					   flit_isr, IRQF_SHARED,
+					   "pcie-flit", dev);
+	if (status) {
+		pci_warn(pdev, "request Flit IRQ%d failed: %d\n", dev->irq, status);
+		return status;
+	}
+
+	flit_cntr_enable(pdev);
+	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
+
+	return 0;
+}
+
+static int flit_cntr_suspend(struct pcie_device *dev)
+{
+	flit_cntr_disable(dev);
+	return 0;
+}
+
+static int flit_cntr_resume(struct pcie_device *dev)
+{
+	flit_cntr_enable(dev->port);
+	return 0;
+}
+
+static void flit_cntr_remove(struct pcie_device *dev)
+{
+	flit_cntr_disable(dev);
+}
+
+static struct pcie_port_service_driver flitdriver = {
+	.name		= "flit",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_FLIT,
+	.probe		= flit_probe,
+	.suspend	= flit_cntr_suspend,
+	.resume		= flit_cntr_resume,
+	.remove		= flit_cntr_remove,
+};
+
+int __init pcie_flit_init(void)
+{
+	return pcie_port_service_register(&flitdriver);
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 53144c99cb3c..1a649d6f4ab8 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -31,7 +31,8 @@
 
 #define PCIE_PORT_SERVICE_EXPCAP	(PCIE_PORT_SERVICE_PME | \
 					 PCIE_PORT_SERVICE_HP | \
-					 PCIE_PORT_SERVICE_BWCTRL)
+					 PCIE_PORT_SERVICE_BWCTRL | \
+					 PCIE_PORT_SERVICE_FLIT)
 
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
@@ -151,12 +152,16 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
-	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
+	/*
+	 * PME, hotplug, flit error counter, and bandwidth notification share
+	 * an MSI/MSI-X vector
+	 */
 	if (mask & PCIE_PORT_SERVICE_EXPCAP) {
 		pcie_irq = pci_irq_vector(dev, pme);
 		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
 		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
 		irqs[PCIE_PORT_SERVICE_BWCTRL_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_FLIT_SHIFT] = pcie_irq;
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
@@ -280,6 +285,11 @@ static int get_port_device_capability(struct pci_dev *dev)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
+#ifdef CONFIG_PCIE_FLIT
+	if (dev->flit_cap)
+		services |= PCIE_PORT_SERVICE_FLIT;
+#endif
+
 	return services;
 }
 
@@ -836,6 +846,7 @@ static void __init pcie_init_services(void)
 	pcie_dpc_init();
 	pcie_bwctrl_init();
 	pcie_hp_init();
+	pcie_flit_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c84..db80faecf34c 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,8 +22,10 @@
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 #define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
 #define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
+#define PCIE_PORT_SERVICE_FLIT_SHIFT	5 /* Flit Logging */
+#define PCIE_PORT_SERVICE_FLIT		(1 << PCIE_PORT_SERVICE_FLIT_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   6
 
 extern bool pcie_ports_dpc_native;
 
@@ -51,6 +53,12 @@ int pcie_dpc_init(void);
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
index dd0abbc63e18..a1ec44b04eb0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2666,6 +2666,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pasid_init(dev);		/* Process Address Space ID */
 	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
+	pci_flit_init(dev);		/* Flit Logging */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebb5b9d76360..a8d8dbac6640 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,6 +592,10 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCIE_FLIT
+	u16		flit_cap;	/* Flit Logging Capabilities */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..774eeed80bed 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -763,7 +763,8 @@
 #define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
+#define PCI_EXT_CAP_ID_FLIT	0x32	/* Flit Error Logging */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_FLIT
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1187,6 +1188,17 @@
 /* Physical Layer 64.0 GT/s */
 #define PCI_PL_64GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 
+/* Flit Mode Error Logging */
+#define PCI_FLIT_ERR_LOG1		0x04		/* Flit Error Log 1 Register */
+#define  PCI_FLIT_ERR_LOG_VALID		0x1		/* Flit Error Log Valid */
+#define  PCI_FLIT_ERR_LOG_MORE		0x2000		/* More Entries Valid */
+#define PCI_FLIT_ERR_LOG2		0x08		/* Flit Error Log 2 Register */
+#define PCI_FLIT_ERR_CNTR_CTRL		0x0c		/* Flit Error Counter Control Register */
+#define  PCI_FLIT_ERR_CNTR_EN		0x0001		/* Flit Error Counter Enable */
+#define  PCI_FLIT_ERR_CNTR_INTR_EN	0x0002		/* Flit Error Counter Interrupt Enable */
+#define PCI_FLIT_ERR_CNTR_STA		0x0e		/* Flit Error Counter Status Register */
+#define  PCI_FLIT_INTR_GEN_CNTR		0x0008		/* Interrupt on Trigger Event Count */
+
 /* Native PCIe Enclosure Management */
 #define PCI_NPEM_CAP     0x04 /* NPEM capability register */
 #define  PCI_NPEM_CAP_CAPABLE     0x00000001 /* NPEM Capable */
-- 
2.53.0

