Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA7377AA6;
	Tue, 14 Jul 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054426; cv=fail; b=MeXmqPzqC5GXSzwMHkPiFudTaZUUU9E+AiSvd5kZXmDp39yEdZGOx7F9mm6MFFSynphmyqvqcZBpP60CoXZAZd8381kjYV4LG+zutXyFAQmGLdzDxDRik3JreS/yLcbEwlER9qeHF34Xvg0mCJHnhievd6uGoj64PcpIh1UAPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054426; c=relaxed/simple;
	bh=DWlKiEuBb45H5WAsReEsrVutfyquYJG9N9WExzA8B4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc7C3fNKgCn+Aia43fU8kwzr9TWYaDBM4scZcqDVKaTxPJafSDEA7pCQJLDF8k8E3m5oNMWv/vN2tx7k4/QeUwilvNOiaLr8iVJWDQH4pxy7K18vjyO/HuC55iQCB1ZGJaq3BTu/g759c75hBhyCUgzFdIF4MLHL6ME8ghbjtn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gf1fnr9c; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gf1fnr9c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3PF3oL0RlGiE5+1f2dfEm9XBO+F7pjEz94NaKwR+35dc8vameAVTeF+F0Ano6qT7Tl3tWdqfvtgMgexupaGZyxifHunWQYQq9hGZn7jIm8iDrXEDU373a+Qd+XBo0BcCRHyp321eVrMgI9B1pcCMejJ80FGhyPPnkqFLPADxzURtJrU0B3cue68CrOHWmVmgu9M40Ot5zOrWj8piEFrOzGnFqBHSGlVqgjW/EuII5GxzK0bB7PVo2TddxVmQTuBvMQRLno5dxZ//PusyW2ekl20XUD7P+EFSLWBIT6T+8aR32NjKtgzsRvPBqBlcO+OiZfDLXI/6D85UQHIcLzDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z2A8YKwIaWHz9gLRVYhz/34O9oFxpr1gXFu0NbpiS4=;
 b=iCn59rvPxS1OHqpzzBI5Ps3zCy1JQlZMsBn4EzrJ4hliAJrY7hXKQF0SazogahfsB8sE+fVbpQ/apsojbp1vVvrU1kbjhgdcxZgCWd+UKUNPn2NnqEw2we6xYUVK8F9dos15A9tzorrXqkn7aodZHGpAMpsgJpvlES1hO5bNd72Unv9mcmMzZkod6OoDw0CN2lvZjbTaiufLS44f7JvXGy10XBm/81a6XG15kMaKfjlUmR3iFmEd2oPTAg8pqmTGPtOmKzU2olaJRBhKULcZzegjS3VX2rqeDqAgQrricK/LeE5FZR8FRxWqHqrvw9qYglpEsMHR0XF0vzv1SXLAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z2A8YKwIaWHz9gLRVYhz/34O9oFxpr1gXFu0NbpiS4=;
 b=gf1fnr9cLKpi3cdfMxkRPMvBm8aPffx36SyD2ha70GE0xd7uXrnJkL6pylOfAgJRuAj5A6JOvXPLEuilBuWXYNkQ1bnwKP3C66PblkF9MZbmsqbxzWUyFQknAYkVxMJGdnpR0kzagERxQOtU80PKLqVDwMsM+pg/5GgIwVA8VmI=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:40:06 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::94) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 13:40:06 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 4/5] PCI/FLIT: Add trace event for flit errors
Date: Tue, 14 Jul 2026 14:39:49 -0400
Message-ID: <20260714183950.1620016-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714183950.1620016-1-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da5afd6-af2e-4299-ad52-08dee1d75380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	mPvg+ZB/qxPzeC60pDpRfHRpZbG/21rp8XNn6FzKExqQad3yyU0Tbo6Gf1iy0CCHMN9y2rnUzPPepNqaja8uDOnDJDEO2bwyqoZ++hkRgGRZTrvXjU038KMxVb+00JZ0cJHB8qcnqcNzhK1I5v8wB1ycuzIw7Sh+OdXRAsDL9x+wOIj3PJOVZU/dGq8dkJ+Yy7cMimBquT8fKtbIQ8KMMCMxhQWaCrQ3IYsS6tzsfprfH5Ab4mBZ+jltGvy5W5W/sLPPElhoNoEc+JDum09h2NfBarGdQatafNbvpAPJjlaScILdnsutJoWilYOF5ypPLE38Bj4hcYF8g++3FfL3DciZAZ0Q/RLHhHplnZdpaEuubFNSsYcV6tR9pWlB38KO6H+wN6obB+hFS3l3Acri7T6ZSPo/LJRTM38ywbH6NPBafd11NAkUqHDxYtbbdxhOo38Hviwv0cmUU+48i57ZolGHvaop0yh2DRFnhFg2lGfr6C+povqa/AZuN8RTzfT6cbaJyiBMnX7qhxljjYYCRpETVESCQ6cw7QAjmhujGWh2/k9MZ4pfxrpjp5iV7UyLHSkWa+mU2HOvFqPSbQZPllLHojDYdNL8Y2gGbB2gaM1+cn5G0sA1giTeDRET18QaYbl3/lj2+0XSY4DYZsQ+/VdDen9qvoBb8uFkNxfeqkZ1eJksC3Fp1vCW2+WsSmuzxgASAfqHGPm7uYrnUWAO8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	slpAWOv+xVOa5pikeNHcDF3vP/0JTkMFyn21RRZ1PHadnRwQqbjTF1Uv0T5RrYqK8cO0gyvpkjwoaPkLh7cthZiCRo5uB3ExbkpuUJP7CoPJSGod7qnfDGMMUJEfvwuRQIITcYOfPq5hRevMmCQvWm/M6fWYCt9hfO73va2w9nPPIss9oecAUY5DHIq05apH1Xot9mxiZN/dtke1EcwvkLit1G2M+4f6M4XZGq1tBCwVh0k96HWH98R7xQdNzOXVuB1bRhlMMEn3a/xJeGk0Jd56fiOZH2tNpIwpzwA1mxR7bBqzfHQLOoO5KbN3x2u2rrcfIqYWN+qaQYw2T7NIPTUARGNO6WMHJwuVYkDD6HGTH79AngxyrCmZvUPWCWaAGdtxqrdauM+clXrgbXOzCPCBhKtK8feiWexM5TKFBOhK62Ll7/kas9xyBPdQ50VY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:06.7937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da5afd6-af2e-4299-ad52-08dee1d75380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545

Emit a trace event for each erroneous flit logged by the Flit Error
Counter, capturing the counter control/status and both Error Log
registers. This provides a structured, low-overhead record of flit
errors that userspace RAS tooling can consume without parsing the
kernel log.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/pci/pcie/Kconfig |  1 +
 drivers/pci/pcie/flit.c  |  2 ++
 include/ras/ras_event.h  | 48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 1ee3c85e63c1..6a0f3abfbfe7 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -150,6 +150,7 @@ config PCIE_EDR
 config PCIE_FLIT
 	bool "PCI Express Flit Mode Error Logging support"
 	depends on PCIEPORTBUS
+	select RAS
 	help
 	  This enables support for the PCI Express Flit Logging Extended
 	  Capability, which logs errors encountered by a port operating
diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
index 12f2b6fbf1de..83cf53f39291 100644
--- a/drivers/pci/pcie/flit.c
+++ b/drivers/pci/pcie/flit.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <ras/ras_event.h>
 #include "portdrv.h"
 #include "../pci.h"
 
@@ -84,6 +85,7 @@ static irqreturn_t flit_isr(int irq, void *context)
 
 		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
 		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err_log1, err_log2);
+		trace_flit_event(pci_name(pdev), cntr_ctrl, cntr_sta, err_log1, err_log2);
 
 		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
 	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613..0f02928b5cda 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -381,6 +381,54 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 #endif /* CONFIG_PCIEAER */
+
+/*
+ * PCIe Flit Error Logging trace event
+ *
+ * These events are generated when the Flit Error Counter of a PCIe Gen6
+ * Flit Mode port records one or more erroneous flits.
+ *
+ * char * dev_name -	The name of the slot where the device resides
+ *			([domain:]bus:device.function).
+ * u16 cntr_ctrl -	Flit Error Counter Control register value.
+ * u16 cntr_sta -	Flit Error Counter Status register value.
+ * u32 err_log1 -	Flit Error Log 1 register value.
+ * u32 err_log2 -	Flit Error Log 2 register value.
+ */
+#ifdef CONFIG_PCIE_FLIT
+TRACE_EVENT(flit_event,
+	TP_PROTO(const char *dev_name,
+		 const u16 cntr_ctrl,
+		 const u16 cntr_sta,
+		 const u32 err_log1,
+		 const u32 err_log2),
+
+	TP_ARGS(dev_name, cntr_ctrl, cntr_sta, err_log1, err_log2),
+
+	TP_STRUCT__entry(
+		__string(	dev_name,	dev_name	)
+		__field(	u16,		cntr_ctrl	)
+		__field(	u16,		cntr_sta	)
+		__field(	u32,		err_log1	)
+		__field(	u32,		err_log2	)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__entry->cntr_ctrl	= cntr_ctrl;
+		__entry->cntr_sta	= cntr_sta;
+		__entry->err_log1	= err_log1;
+		__entry->err_log2	= err_log2;
+	),
+
+	TP_printk("%s cntr_ctrl:0x%04x cntr_sta:0x%04x err_log1:0x%08x err_log2:0x%08x",
+		__get_str(dev_name),
+		__entry->cntr_ctrl,
+		__entry->cntr_sta,
+		__entry->err_log1,
+		__entry->err_log2)
+);
+#endif /* CONFIG_PCIE_FLIT */
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
-- 
2.53.0

