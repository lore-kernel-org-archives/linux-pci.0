Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B137646A;
	Fri,  6 Mar 2026 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784078; cv=fail; b=tEjxHcL80U6rM+QjXrgn8EF99f7SPGI6dR2AMFxpwA4gq7xex62qnvH0MNekmNKVt4whkUk3lWj91Qn5j3xmFNRGycr7I2HPzyXEu+2f04+isoD0VWHUZ/gLvLhbXDTHIcI/XPUkFNbIun6+Hmx8HHfN+GuI39gozXol84IUBoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784078; c=relaxed/simple;
	bh=XEgOw5Dy8xYLjxrpOpZlxphZkVvcEun/qSz3qxscZ94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCHK45ANbEeWZ/yxZB597nVy0Zw5EInYqEUwPG31l8Gntb1Z9JFCASWkgrzROM0DsKv/1hHQNsVtWdoV/fDuXxIbpWBXNNJeQYon0JsrYqNVWryxwtjju9Yx3jgcBAqeR4HBO9+/0nSAAKfpH1xVEE/rm+0UufY0NYB050MQA+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lnXuVJ+8; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lnXuVJ+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDNDV/o1AnyWtTMtxcUv+AjdBEj72vZawE2heTGMb/7Xo79qmD83ECDO+XXSDusjhHg9fbzBzqJx15lfB5RvyxqQWe9pip9uXaUV6PS5VOKuEhOM0Eo2pu9gqRs00WzLvZjunIB9izCHS1yyoZcOKb558ZCibpkCktilYa4SbV7KXO45dc9nHKYFAmRFt03/WHRR25IdwxDjMWJ2ADRp5+QG68NTwg1gEnepyQ3NNw/L0Zue+F2sn0SKKij3N+4sHo0J5PGBI+KTBrGKasut/W2UhYWCPOTiknlMZpsjHxAHRGRh3540QUQsbXfaVOTts416kLVQ0Wjh2shcTULOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OYBy7eJfu2lE2wIOWhCjZZtUAhIzdRmyk1ko4vrCAY=;
 b=brUdKKDa8Y/hm/hX2U9mxcPF2NKil+UK8bR3hwN8NM49n870tOPIGADj6HNIYpi1AbUJDxFyTHoQeLmH0rVRk1XmpSYDfWm/2vjuADKvIqqZ6g3ra5POEh7J/53cEqd0HGqQLWRApdqppCINTdaV0IUGabJ8z/b6U7ooEPEO+S036W66Cdv9Wb1b2XAuRPJIM+1sx4vm6h4tsvkmnJPGiw+QLz+4+cYxGqkGBWW+yoa+V4qgA2/WsteHONFmhEMTof5W/3mqWchsYMshtOoBthx0WDOflPdtQ0Qy40Svn0xELsJ1mS+2BnO9NTnjBx1Fja2C8yaz1UNRWZe81OsUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OYBy7eJfu2lE2wIOWhCjZZtUAhIzdRmyk1ko4vrCAY=;
 b=lnXuVJ+8/W60snCCgTiXYvEXQ6hRwOOq0M6f6Mzbtr8CIeCNSf2edwdwlyepRIKbWxICfpVtzo2bhsFOMiUMo16i2cDhamKKVnax36S5bcfCb2HRsksUwM78elDApb7orU/I5qoaFlEa/wjWJEmnIs14uP/BRjL2IrA7yYyaBrM0EPhSIbyAXLmgUskvGW8V+0spE1jqwthBFyM8xYqbMivY5ao6ybmOt3R5un4J2pW6cwQn/DGlns484k6AQte2rpkBT/uff9d99CYoXyAzWIqCsj01eIwzJlHBpV193cLjEVocq5u+xMYchk//l6ro9n90yn+UKaYY3ImGRWgbrg==
Received: from MN2PR13CA0034.namprd13.prod.outlook.com (2603:10b6:208:160::47)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 08:01:12 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::27) by MN2PR13CA0034.outlook.office365.com
 (2603:10b6:208:160::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 08:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:01:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:53 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:51 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH 4/5] PCI: Add cxl DVSEC state save/restore across resets
Date: Fri, 6 Mar 2026 08:00:18 +0000
Message-ID: <20260306080026.116789-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 3311d48c-7c01-4801-03f4-08de7b5687a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	ed91s5hFrppx8fcO9jzbf8nM+E1mBNQHIJ0K3MhmSU4kdd/EGdxGk9mX4iNmr14q9Cud5cwcqitBh0RaMCNJPlrmc4jr+c7q8KsClRY9xYhmOSWNkmKUST6bpudxqJVfPtGFtWYwn+oKONcN15hs67RNA8sn6t3FLikGO4TyzJJrp3LzGES/HPimgAkhakjJSXNTdBZihLZr9RVaJzp8n596uygpfWkEZxuGMYRhkqZTyZu1ko2HAUD7CH/IzY5S6Pb2gStxS6cdJC6foCPDMchhbP32EcO2QaDLnF/KHtvyZdxRoVDwA8qW9wsFE77f7aJd0CCWAKZ5MwrRrjHNkT3Dm3WL4TLcucgGqUAsEOODn36dVyACuYdwrPKxXxopif5rvx3tE4mlqodCke85M1VrMHilOxcyX5hfowlxpCUnTOwr/BToT24+B4cWKCaFW5UKHo/NXWQ/fQLoukm6fqKkMjfoS4Stk03UgASRZzXhhF1/a5poVwpbcWhA6qy00oEtXTi+r7MQPM3U1LLUfbE8s0jz6Mq7dL+i5eF5F6h9EfaV5PftDN0V7uUenmbVwtYypxFllbR4Q3V8iwc0Q46GY/egWBvan+tvjDSJdTXRK/Hvo3HY7Uvdxrqb0TCB2hewT6AUBmNNsWqwxyz7L5MRejnohb4RK4zPGF9PLODDGm6yzPdAIm/glZ02Z1Kl3jSYwVN0AI3hE5L76UXbiVjzrPij6pDmAGpsha9siXnemhE9WaqcZo7NGUVV8yLhIg1HlK+MDu50bo2g3bA1/A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uiNV30UGk2XxugviaAJh0k6q2uMoc/rlGi/IdwFBxmX9x/hJrMerq7aRpJjFvVsjE9MydAp6MSA0s4TH1OuuqfFttXr9NL4Z4CszLYzkp9tHTJDlDaQEplCB6/2i0pLsbBPCmlkFssN9is82eXf5hN/fnq9Vxiun4opn++WofvqTcMjE2vthDVkITX3/Rnnf5lWi3wJSPtdnyBSIQ/MGeQ0fWAgGfneUa7NjEUWh8G8kr6UbAWD8+2OoGL+COlLOorS1dIbS5ARIXKI3KtNuwxqUTRLHj1ZmxrOjpegodsXDuQs2KtcYPt7simoUD7w2THQ8DE/EUUFzGbYbTlW1ys702oShk8yESc2bycm2Ygd88FN0cAhdbHZn7veqmzVz/3wW1DuZ2qJ712yBME39IG6m1NHts+SXrl4EO4ANM65urmHKUZEyRKA5r1Gfkwkw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:01:10.4318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3311d48c-7c01-4801-03f4-08de7b5687a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save and restore CXL DVSEC control registers (CTRL, CTRL2), range
base registers, and lock state across PCI resets.

When the DVSEC CONFIG_LOCK bit is set, certain DVSEC fields
become read-only and hardware may have updated them. Blindly
restoring saved values would be silently ignored or conflict
with hardware state. Instead, a read-merge-write approach is
used: current hardware values are read for the RWL
(read-write-when-locked) fields and merged with saved state,
so only writable bits are restored while locked bits retain
their hardware values.

Hooked into pci_save_state()/pci_restore_state() so all PCI reset
paths automatically preserve CXL DVSEC configuration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/Kconfig  |   4 +
 drivers/pci/Makefile |   1 +
 drivers/pci/cxl.c    | 177 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c    |   3 +
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/pci/cxl.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e3f848ffb52a..6b96650b3f31 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -119,6 +119,10 @@ config XEN_PCIDEV_FRONTEND
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.

+config PCI_CXL
+	bool
+	default y if CXL_BUS
+
 config PCI_ATS
 	bool

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..a6168ecef9c1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
+obj-$(CONFIG_PCI_CXL)		+= cxl.o
 obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o

 # Endpoint library must be initialized before its users
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
new file mode 100644
index 000000000000..abcf70de9171
--- /dev/null
+++ b/drivers/pci/cxl.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CXL PCI state save/restore support.
+ *
+ * Saves and restores CXL DVSEC registers across PCI resets and link
+ * disable/enable transitions. Hooked into pci_save_state() /
+ * pci_restore_state() via the PCI capability save chain.
+ */
+#include <linux/pci.h>
+#include <cxl/pci.h>
+#include "pci.h"
+
+struct cxl_pci_state {
+	u16 dvsec;
+	u16 dvsec_ctrl;
+	u16 dvsec_ctrl2;
+	u32 range_base_hi[CXL_DVSEC_RANGE_MAX];
+	u32 range_base_lo[CXL_DVSEC_RANGE_MAX];
+	u16 dvsec_lock;
+	bool dvsec_valid;
+};
+
+static void cxl_save_dvsec(struct pci_dev *pdev, struct cxl_pci_state *state)
+{
+	int rc_ctrl, rc_ctrl2;
+	u16 dvsec;
+	int i;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return;
+
+	state->dvsec = dvsec;
+	rc_ctrl = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				       &state->dvsec_ctrl);
+	rc_ctrl2 = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					&state->dvsec_ctrl2);
+	if (rc_ctrl || rc_ctrl2) {
+		pci_warn(pdev,
+			 "CXL: DVSEC read failed (ctrl rc=%d, ctrl2 rc=%d)\n",
+			 rc_ctrl, rc_ctrl2);
+		return;
+	}
+
+	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
+		pci_read_config_dword(pdev,
+			dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
+			&state->range_base_hi[i]);
+		pci_read_config_dword(pdev,
+			dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
+			&state->range_base_lo[i]);
+	}
+
+	pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_LOCK,
+			     &state->dvsec_lock);
+
+	state->dvsec_valid = true;
+}
+
+static u32 cxl_merge_rwl(u32 saved, u32 current_hw, u32 rwl_mask)
+{
+	return (current_hw & rwl_mask) | (saved & ~rwl_mask);
+}
+
+static void cxl_restore_dvsec(struct pci_dev *pdev,
+			      const struct cxl_pci_state *state)
+{
+	u16 lock_reg = 0;
+	int i;
+
+	if (!state->dvsec_valid)
+		return;
+
+	pci_read_config_word(pdev, state->dvsec + PCI_DVSEC_CXL_LOCK,
+			     &lock_reg);
+
+	if (lock_reg & PCI_DVSEC_CXL_LOCK_CONFIG) {
+		u16 hw_ctrl;
+		u32 hw_range_hi, hw_range_lo;
+
+		pci_read_config_word(pdev,
+				     state->dvsec + PCI_DVSEC_CXL_CTRL,
+				     &hw_ctrl);
+		pci_write_config_word(pdev,
+			state->dvsec + PCI_DVSEC_CXL_CTRL,
+			cxl_merge_rwl(state->dvsec_ctrl, hw_ctrl,
+				      PCI_DVSEC_CXL_CTRL_RWL));
+
+		pci_write_config_word(pdev,
+			state->dvsec + PCI_DVSEC_CXL_CTRL2,
+			state->dvsec_ctrl2);
+
+		for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
+			pci_read_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
+				&hw_range_hi);
+			pci_write_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
+				cxl_merge_rwl(state->range_base_hi[i],
+					      hw_range_hi,
+					      PCI_DVSEC_CXL_RANGE_BASE_HI_RWL));
+
+			pci_read_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
+				&hw_range_lo);
+			pci_write_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
+				cxl_merge_rwl(state->range_base_lo[i],
+					      hw_range_lo,
+					      PCI_DVSEC_CXL_RANGE_BASE_LO_RWL));
+		}
+	} else {
+		pci_write_config_word(pdev,
+				      state->dvsec + PCI_DVSEC_CXL_CTRL,
+				      state->dvsec_ctrl);
+		pci_write_config_word(pdev,
+				      state->dvsec + PCI_DVSEC_CXL_CTRL2,
+				      state->dvsec_ctrl2);
+		for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
+			pci_write_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
+				state->range_base_hi[i]);
+			pci_write_config_dword(pdev,
+				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
+				state->range_base_lo[i]);
+		}
+
+		pci_write_config_word(pdev,
+			state->dvsec + PCI_DVSEC_CXL_LOCK,
+			state->dvsec_lock);
+	}
+}
+
+void pci_allocate_cxl_save_buffer(struct pci_dev *dev)
+{
+	if (!pcie_is_cxl(dev))
+		return;
+
+	if (pci_add_virtual_ext_cap_save_buffer(dev,
+			PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL,
+			sizeof(struct cxl_pci_state)))
+		pci_err(dev, "unable to allocate CXL save buffer\n");
+}
+
+void pci_save_cxl_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct cxl_pci_state *state;
+
+	save_state = pci_find_saved_ext_cap(pdev,
+					    PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL);
+	if (!save_state)
+		return;
+
+	state = (struct cxl_pci_state *)save_state->cap.data;
+	state->dvsec_valid = false;
+
+	cxl_save_dvsec(pdev, state);
+}
+
+void pci_restore_cxl_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct cxl_pci_state *state;
+
+	save_state = pci_find_saved_ext_cap(pdev,
+					    PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL);
+	if (!save_state)
+		return;
+
+	state = (struct cxl_pci_state *)save_state->cap.data;
+	if (!state->dvsec_valid)
+		return;
+
+	cxl_restore_dvsec(pdev, state);
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dc8181f13864..497720c64d6d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1759,6 +1759,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_cxl_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1841,6 +1842,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_aer_state(dev);

 	pci_restore_config_space(dev);
+	pci_restore_cxl_state(dev);

 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
@@ -3489,6 +3491,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");

 	pci_allocate_vc_save_buffers(dev);
+	pci_allocate_cxl_save_buffer(dev);
 }

 void pci_free_cap_save_buffers(struct pci_dev *dev)
--
2.43.0

