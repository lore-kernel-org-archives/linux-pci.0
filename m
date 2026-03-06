Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEC378812;
	Fri,  6 Mar 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784081; cv=fail; b=BhZ0I5xxsNTqkKcqokd+Vo+TV8+0CUz+ZRZKYoY+vOW7mAbkx+TnFUPqQhdLF2txIDRdlTGn9kVnZdqdmgjJFm/bz8RIgzEFfbm9PS4yfbgiQnttA175lxIgjNFuBiqrOC4RG0TLHpn1M99AqLYmoq1jNIJyhHc36yju67gK4h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784081; c=relaxed/simple;
	bh=RpGvnhmdgHZi0wj/plrBo0dzUp1uwlLQTkzrVyjkGvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=on8oiuAWOlxqSUDaSP76q+NExjWqUQQgEA9dcRHJbaRm6tqxFM4jekAYN3bQi+NGXsrnoCW/nvPkL9UGjVwZt4qJhSCWRXi28V15eMd8DXw63ZQwBglChnaNU8hNvoeUutR5KjjG13zFKNIXjBetRzphHTON2J5/Oke0GUgoC7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f2Iau3Xp; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2Iau3Xp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XA3VdrON260GaWXPA+eLYCF8i10Qvl1RvlwC11NFzmlL1y9Q6bC56gtFg6HsGKIOvsxdNM6AUv9apIym7hnxQ3muigkc2vMCrn2vFTj3ue/e2IC2bNRin6QunlJYglhGPMlVPWxo+Fp2Zqvo/24lVLDWY9voMIQFSG4SHBSgk3bTEEudbufFtMbr+BeESk0jXmbqFPE7QE/C/agy5m5TZ3ouNOMqhDeEGeZZ1WFVFtjguWE6vR8UwtjCeaiSxrqfERRlQepk2M5nB/Jk7gfIn2q9fg5YOrkGo2PaU1FYa+5Frz/oYR7WAlaW0lFTntERjKI4NOvpywfyhs2j1/7/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=203Tn7P5et2Jpl9uC6hxjxKmfgDpjfSc6M1IiCpH3F0=;
 b=KxCsObd7QvMGXes1AcFGErxH7ACpczK8BTvJlu22Gx1pJSWxgl2Byb+pFXtnLwym6Yj7L5mICvmu2RKX9QEx1Gl2hjKT8YEEAOwWIQmrd/Hazg8IAbVQXRNuetGkala0be9MFK0FTW2Vo7gqF6+8PSrKpN4N3i3e/PM/FsCsqMABELdCqk2iKyKiOLpvb1JEnLSQ5S5RE4wfUbq0Ni3gcLDGoqMJmPFtKZ5pNo3Uh6IqV9lfERSz9Y00TggLVP/XpZncCqUyb3tuvUeJNubUwwF2KpiYbTtP3z0d2fufb8poYDC4TQolC05NaPiAtdk0mt3Vp9AVrZnrKfopVPKaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=203Tn7P5et2Jpl9uC6hxjxKmfgDpjfSc6M1IiCpH3F0=;
 b=f2Iau3XphjsSR1T60bKgnUCn+0tYsJ0lLU2MyMlyWa0A12MHBhL6oPRH0grJKjFKlM7xwicnFaRVjfZocWlnA7Pyl+RbWHop8lybjgyDSj4Y/RRu7z0FJLxr6k5w79MTZAwuqkjXK/kER/GUpFvJ06QLmLqU6U5oBTZN3VXHXOJPKIpJyJIn7ujwBXG6UcE97o+i9jhEgeUHhS+Ezi7tQy/q/KDi/5Kt2E9YbgAYiDez0UVnX6Xtef5qd9lvZjvlB/SlStYJROyiPeEnmPyG8/QE81lfpv6A3gKjv3oWDqP/RuG0DQgNxp67RiGzMan/02eXJuqGg92+pL/N5tp3ww==
Received: from LV3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::35)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 08:01:13 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::43) by LV3P220CA0025.outlook.office365.com
 (2603:10b6:408:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 08:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:01:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:56 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:56 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:55 -0800
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
Subject: [PATCH 5/5] PCI: Add HDM decoder state save/restore
Date: Fri, 6 Mar 2026 08:00:19 +0000
Message-ID: <20260306080026.116789-6-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 831f9ed0-b5b9-4640-d61b-08de7b568901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	kf//94Y76+sDwBTAAk7/hVOGDMVcXzel0WMxU6066aoDnBOaHslyjlqlo6hKxv+Eh4S1qV49dUTDXzfHulCmOhZPBhE7F9HaZnvBtZjrIwPFy29ojDS5Oh98Kq24iYyFekTWm9qfH3ITQ3MNEKN3xwEySeWy6MctIg57QbmN1lbtMu6NcSzG5FoKi7W83NQvKj4nLsiLBMsLyn/RavWu0qWCMpTZaBe/ToSa7p+VQexoEY8vjGJBy/txutKdk7R9SBGr6vxZhzPXTAX7rBKWSnl6I6jJ0slFkz5vdkhDWXvsyIZtt98rtLUJoUvpBQOkdt0zqwAaSXJi35b7/KyqYk6tRgPzMa7SY8Z++4vdojhNz2wMq+9oV+21ZBDfxluNNEaLSxui/xhcjLbV41IH86b4w2yDTCQjOxAa6heWKB4z7nSCyw77uP8C++IgUSk7/k5ELN1ossQLhH3rVCUA7tVYq9wJVX/Kxk8lflpSQ86wCIZmDCf6SyEaUmYplq5vTZvxLMiPGavK7ouiyFjt8vZlFa292bH3QjwiPMFbX7xxdgae8J9BhOYyr5o9WIAoN1mIdvZ8J5xWEa1UhmXz5IYci1/Wkc96Pcx5dmybgzYZs0LltrEn977QoyQIOv1UFXXvarRKdXPi7zmqZRpMeg3Nq1DlDqYMtzS98GG7sTQCvWJ8jNlXJVLnNylQr5xQasvp6O2UArlX03qMCQ6/lkjMF2lPWb0MAebyjwF6u5pavKYsfdmKCx/DPDnQOHsmQsptAYzvQFADocCHTofGKw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RaWFwMZTvwEDxQQCEfZ6fpu1NPDfvpFSdFNWhzF9tkfsYPvHOhs9D8xTome7YumJt4zFHoyqOZBawzUorD0x8hamc9iJRzls+Znk3a8YobeZGZsN7oGWYrJddl40YawongXfC4kkKov0P4yGqk5NavD299SqfcBKng5hrP4xFiSFi5Xr4yNTjeYMkhXA9hhOVLy/wmsAgLTz8ZHo6FoR0qiNd/ifNd1RB95zgoByTOwf23wBQf7IJaf28auDn9wiFY7mAPV8zaXssw06/CNMXIaTW8uGxZIKvvnE0h9frRmpacJEbKwgV+cVsZzCEiiM5Z9ry63KKUtFXyDutczUStDaJPcwTh6PlAMdY+wXuHpj2jtUrxrp+3EerEBiy6Vkmun4NfkoxEHh2VkbBy3qsDptplUsgKtQhZzQDuabWFEiiYVCKZe/fyooSWcvSiQ8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:01:12.7277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f9ed0-b5b9-4640-d61b-08de7b568901
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save and restore CXL HDM decoder registers (global control,
per-decoder base/size/target-list, and commit state) across PCI
resets. On restore, decoders that were committed are reprogrammed
and recommitted with a 10ms timeout. Locked decoders that are
already committed are skipped, since their state is protected by
hardware and reprogramming them would fail.

The Register Locator DVSEC is parsed directly via PCI config space
reads rather than calling cxl_find_regblock()/cxl_setup_regs(),
since this code lives in the PCI core and must not depend on CXL
module symbols.

MSE is temporarily enabled during save/restore to allow MMIO
access to the HDM decoder register block.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/cxl.c | 297 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 294 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index abcf70de9171..ed246f32dfa6 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -2,15 +2,31 @@
 /*
  * CXL PCI state save/restore support.
  *
- * Saves and restores CXL DVSEC registers across PCI resets and link
- * disable/enable transitions. Hooked into pci_save_state() /
+ * Saves and restores CXL DVSEC and HDM decoder registers across PCI resets
+ * and link disable/enable transitions. Hooked into pci_save_state() /
  * pci_restore_state() via the PCI capability save chain.
  */
 #include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/cleanup.h>
 #include <cxl/pci.h>
 #include "pci.h"

+#define CXL_HDM_MAX_DECODERS 32
+
+struct cxl_hdm_decoder_snapshot {
+	u32 base_lo;
+	u32 base_hi;
+	u32 size_lo;
+	u32 size_hi;
+	u32 ctrl;
+	u32 tl_lo;
+	u32 tl_hi;
+};
+
 struct cxl_pci_state {
+	/* DVSEC saved state */
 	u16 dvsec;
 	u16 dvsec_ctrl;
 	u16 dvsec_ctrl2;
@@ -18,6 +34,15 @@ struct cxl_pci_state {
 	u32 range_base_lo[CXL_DVSEC_RANGE_MAX];
 	u16 dvsec_lock;
 	bool dvsec_valid;
+
+	/* HDM decoder saved state */
+	int hdm_bar;
+	unsigned long hdm_bar_offset;
+	unsigned long hdm_map_size;
+	u32 hdm_global_ctrl;
+	int hdm_count;
+	struct cxl_hdm_decoder_snapshot decoders[CXL_HDM_MAX_DECODERS];
+	bool hdm_valid;
 };

 static void cxl_save_dvsec(struct pci_dev *pdev, struct cxl_pci_state *state)
@@ -132,6 +157,269 @@ static void cxl_restore_dvsec(struct pci_dev *pdev,
 	}
 }

+struct pci_cmd_saved {
+	struct pci_dev *pdev;
+	u16 cmd;
+};
+
+DEFINE_FREE(restore_pci_cmd, struct pci_cmd_saved,
+	    if (!(_T.cmd & PCI_COMMAND_MEMORY))
+		    pci_write_config_word(_T.pdev, PCI_COMMAND, _T.cmd))
+
+/**
+ * cxl_find_component_regblock - Find the Component Register Block via
+ *                               the Register Locator DVSEC
+ * @pdev: PCI device to scan
+ * @bir: output BAR index
+ * @offset: output offset within the BAR
+ *
+ * Parses the Register Locator DVSEC (ID 8) directly via PCI config space
+ * reads.  No dependency on CXL module symbols.
+ *
+ * Return: 0 on success, -ENODEV if not found.
+ */
+static int cxl_find_component_regblock(struct pci_dev *pdev,
+				       int *bir, u64 *offset)
+{
+	u32 regloc_size, regblocks;
+	u16 regloc;
+	int i;
+
+	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_REG_LOCATOR);
+	if (!regloc)
+		return -ENODEV;
+
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = PCI_DVSEC_HEADER1_LEN(regloc_size);
+	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1) / 8;
+
+	for (i = 0; i < regblocks; i++) {
+		u32 reg_lo, reg_hi;
+		unsigned int off;
+
+		off = regloc + PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1 + i * 8;
+		pci_read_config_dword(pdev, off, &reg_lo);
+		pci_read_config_dword(pdev, off + 4, &reg_hi);
+
+		if (FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID, reg_lo) !=
+		    CXL_REGLOC_RBI_COMPONENT)
+			continue;
+
+		*bir = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR, reg_lo);
+		*offset = ((u64)reg_hi << 32) |
+			  (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/*
+ * Discover and map HDM decoder registers.
+ * Caller must pci_iounmap() the returned pointer.
+ */
+static void __iomem *cxl_hdm_map(struct pci_dev *pdev, int *bar_out,
+				  unsigned long *offset_out,
+				  unsigned long *size_out)
+{
+	int bir;
+	u64 reg_offset;
+	void __iomem *comp_base, *cm_base;
+	u32 cap_hdr;
+	int cap, cap_count;
+	unsigned long hdm_offset = 0, hdm_size = 0;
+	void __iomem *hdm;
+
+	if (cxl_find_component_regblock(pdev, &bir, &reg_offset))
+		return NULL;
+
+	comp_base = pci_iomap_range(pdev, bir, reg_offset,
+				    CXL_CM_OFFSET + SZ_4K);
+	if (!comp_base)
+		return NULL;
+
+	cm_base = comp_base + CXL_CM_OFFSET;
+	cap_hdr = readl(cm_base);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_hdr) != CM_CAP_HDR_CAP_ID) {
+		pci_iounmap(pdev, comp_base);
+		return NULL;
+	}
+
+	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		u32 hdr = readl(cm_base + cap * 4);
+		u16 cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
+		u32 cap_off = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
+
+		if (cap_id != CXL_CM_CAP_CAP_ID_HDM)
+			continue;
+
+		hdr = readl(cm_base + cap_off);
+		hdm_offset = CXL_CM_OFFSET + cap_off;
+		hdm_size = 0x20 * cxl_hdm_decoder_count(hdr) + 0x10;
+		break;
+	}
+
+	pci_iounmap(pdev, comp_base);
+
+	if (!hdm_size)
+		return NULL;
+
+	hdm = pci_iomap_range(pdev, bir, reg_offset + hdm_offset, hdm_size);
+	if (!hdm)
+		return NULL;
+
+	*bar_out = bir;
+	*offset_out = reg_offset + hdm_offset;
+	*size_out = hdm_size;
+	return hdm;
+}
+
+static void cxl_save_hdm(struct pci_dev *pdev, void __iomem *hdm,
+			  struct cxl_pci_state *state, int count)
+{
+	int i;
+
+	state->hdm_count = min_t(int, count, CXL_HDM_MAX_DECODERS);
+	state->hdm_global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (i = 0; i < state->hdm_count; i++) {
+		struct cxl_hdm_decoder_snapshot *d = &state->decoders[i];
+
+		d->base_lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
+		d->base_hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i));
+		d->size_lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i));
+		d->size_hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i));
+		d->ctrl    = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		d->tl_lo   = readl(hdm + CXL_HDM_DECODER0_TL_LOW(i));
+		d->tl_hi   = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(i));
+	}
+}
+
+static void cxl_restore_hdm(struct pci_dev *pdev, void __iomem *hdm,
+			     const struct cxl_pci_state *state)
+{
+	int i;
+
+	writel(state->hdm_global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (i = 0; i < state->hdm_count; i++) {
+		const struct cxl_hdm_decoder_snapshot *d = &state->decoders[i];
+		unsigned long timeout;
+		u32 ctrl;
+
+		if (!(d->ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+			continue;
+
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		if ((ctrl & CXL_HDM_DECODER0_CTRL_LOCK) &&
+		    (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+			continue;
+
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		}
+
+		writel(d->base_lo, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
+		writel(d->base_hi, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i));
+		writel(d->size_lo, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i));
+		writel(d->size_hi, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i));
+		writel(d->tl_lo, hdm + CXL_HDM_DECODER0_TL_LOW(i));
+		writel(d->tl_hi, hdm + CXL_HDM_DECODER0_TL_HIGH(i));
+
+		wmb();
+
+		ctrl = d->ctrl & ~(CXL_HDM_DECODER0_CTRL_COMMITTED |
+				   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
+		ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+		writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+
+		timeout = jiffies + msecs_to_jiffies(10);
+		for (;;) {
+			ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+			if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+				break;
+			if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) {
+				pci_warn(pdev,
+					 "HDM decoder %d commit error on restore\n",
+					 i);
+				break;
+			}
+			if (time_after(jiffies, timeout)) {
+				pci_warn(pdev,
+					 "HDM decoder %d commit timeout on restore\n",
+					 i);
+				break;
+			}
+			cpu_relax();
+		}
+	}
+}
+
+static void cxl_save_hdm_decoders(struct pci_dev *pdev,
+				   struct cxl_pci_state *state)
+{
+	int hdm_bar;
+	unsigned long hdm_bar_offset, hdm_map_size;
+	void __iomem *hdm;
+	u16 cmd;
+	u32 cap;
+	struct pci_cmd_saved saved __free(restore_pci_cmd) = {
+		.pdev = pdev, .cmd = PCI_COMMAND_MEMORY,
+	};
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	saved.cmd = cmd;
+	if (!(cmd & PCI_COMMAND_MEMORY))
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd | PCI_COMMAND_MEMORY);
+
+	hdm = cxl_hdm_map(pdev, &hdm_bar, &hdm_bar_offset, &hdm_map_size);
+	if (!hdm)
+		return;
+
+	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
+	cxl_save_hdm(pdev, hdm, state, cxl_hdm_decoder_count(cap));
+	state->hdm_bar = hdm_bar;
+	state->hdm_bar_offset = hdm_bar_offset;
+	state->hdm_map_size = hdm_map_size;
+	state->hdm_valid = true;
+	pci_iounmap(pdev, hdm);
+}
+
+static void cxl_restore_hdm_decoders(struct pci_dev *pdev,
+				      const struct cxl_pci_state *state)
+{
+	void __iomem *hdm;
+	u16 cmd;
+	struct pci_cmd_saved saved __free(restore_pci_cmd) = {
+		.pdev = pdev, .cmd = PCI_COMMAND_MEMORY,
+	};
+
+	if (!state->hdm_valid)
+		return;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	saved.cmd = cmd;
+	if (!(cmd & PCI_COMMAND_MEMORY))
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd | PCI_COMMAND_MEMORY);
+
+	hdm = pci_iomap_range(pdev, state->hdm_bar, state->hdm_bar_offset,
+			      state->hdm_map_size);
+	if (!hdm) {
+		pci_warn(pdev, "CXL: failed to map HDM for restore\n");
+		return;
+	}
+
+	cxl_restore_hdm(pdev, hdm, state);
+	pci_iounmap(pdev, hdm);
+}
+
 void pci_allocate_cxl_save_buffer(struct pci_dev *dev)
 {
 	if (!pcie_is_cxl(dev))
@@ -155,8 +443,10 @@ void pci_save_cxl_state(struct pci_dev *pdev)

 	state = (struct cxl_pci_state *)save_state->cap.data;
 	state->dvsec_valid = false;
+	state->hdm_valid = false;

 	cxl_save_dvsec(pdev, state);
+	cxl_save_hdm_decoders(pdev, state);
 }

 void pci_restore_cxl_state(struct pci_dev *pdev)
@@ -170,8 +460,9 @@ void pci_restore_cxl_state(struct pci_dev *pdev)
 		return;

 	state = (struct cxl_pci_state *)save_state->cap.data;
-	if (!state->dvsec_valid)
+	if (!state->dvsec_valid && !state->hdm_valid)
 		return;

 	cxl_restore_dvsec(pdev, state);
+	cxl_restore_hdm_decoders(pdev, state);
 }
--
2.43.0

