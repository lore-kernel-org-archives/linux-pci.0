Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611408;
	b=zWCRhXEbNvRQVR2KqudA7mZj44m7l+jC+LTtwupAHu+CXQZ8uq1KL5IQwD65cZIFY4Lb
	 ogNJmAhT/BZEDN9tktJyDVKEnmYLAMBxa4Jpx19050WS9ml2kISzfvr8oM0o+BBh/+4c9
	 NbBXOWPtU4WQKH/Y3Vq9uxdTXOauN6I03+YkYup/ZpAAXikUQGHSnUnMrByUFlpEwXz4R
	 X6WUW+MVfvjh39vy+bRq6eqEJZ3ESCaPRkGqhtzKpNjLpTG4cvzuZML73ie2XwhGB21lk
	 eRp+rxkpamYLJ8PxttMltqnV4hFIPtnUflcTQCioLH1Sv+QrGFgFNlu6Hhk5cY2twpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611408;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5qD3uYIn0GV4uPcwXYBnj/aY9BeDFWDPM1ijvxKB/3A=;
	b=FtVYWJI/gpZaJl4My6Oem7RL4AdlsCdiDMmqyK+5hUSjh/qShP1atkdRk+7hmL2JH8TR
	 gP1exuv3EIprsVGbCLNjR+XvzZbxiRfu0Ec/pQFx6KfvnvjOa/As4yzTPzeClIF1AAih5
	 Bp8WKk37RinM+ziZ7GWvUbiG6LgF2BSWMZxDQpJ5JKvXMKvA2/ZZlcfOG8l1P+9oL0Pwu
	 1bV0wy8qhOGF3ze+nSyVk+68hy1xvTZAFP43FeKXLJVsKAVHz1vrK7gcGmBdMm70F0ZTG
	 wlGAXgGUZVIaSup+bhLNEvQNQre9hPByN4K5Wp7TdaR3AsnbdwhfISyRI1wkPxtYGkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cq4OQtHU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.43
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2B60A2608;
	Mon,  2 Nov 2026 09:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB2B60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cq4OQtHU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaobVBSc7FzNyghqz713Nr+3fphnoj0KmSB7VQF6/uLlVk45i6D4hlqTrror9XLgOL17erVW7X1uzkS//GvCusRseZxJ1q9jlTg3MEfRDxjDm9L0xb1AnI2OdbSSnP+fUYuV+Ygo8y410Iic50XYPlj6TnWrb12t/lP+VhTdEOWwqd8Wk1S7mw+lZfUFuo3TRwKa8PygTmNofjJ1lhSRVBKk/oNjYP7bpxJdd4jLTXXP0gaFVtR9ee0BBNjzLLpS3R8XoxzW2iR0pZhVPCJvUdGBMkn2k+oqaubgtMXHn6CWwkK+A5drblbHHLDIbCpPQ+iRZ2TpptTJlHWbO+GOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qD3uYIn0GV4uPcwXYBnj/aY9BeDFWDPM1ijvxKB/3A=;
 b=fEBrNaK1HM4HNzeuZzxgTI2MgP3n36RPl0uSCBDz9cDhJsN9iJtovxLNKVBmqp0Qd41L95E6tbbB84SG9Yb3/xuzuWvz9fmDhTk7F8dZ6B++YtLP1xeZYY4glrsynyUw0ywwTkt3CboJ1OcdoJt2RMTKZXbXgIuV7wyrDu2RRcpisAQnfUM3rRXrhtYXJJKDp+snzQ4Qko4r4SsKLLmSp6CqI2QTmWSuMUI4FHgMtCKSuVNAe80UKL3MZBgvGmmVVuDCa20Zl5r/CHglOgiNarK5Ob4Ky9TIRJfAgWPOz+PXuRf3sHSTE8r71etldgnVxayKM6eZ51otwxLwQZwE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qD3uYIn0GV4uPcwXYBnj/aY9BeDFWDPM1ijvxKB/3A=;
 b=Cq4OQtHU8zS8Jp1LGEr4+drQYgNBfQGemvapurLg7k/E3VtleQLmG8Z1lIzaQGKo9jrT5ldzQc/1qj2v/m/LTq39tYzwSpXuPbRNK8LfzqmmLggxKLLcDdlSriQJluyFuPHM/uajdpyYzSHQe6bPSV6d43JKyHNONoeas+j79+Tn5MSwnc1ubEWGHpgBqC7o45Ql4wWWfnNpMTGEHeK9muIncIEhHJZBlqOqE5qxebT5bv8hPXBXDaTuIy8mg82DvPKN2qW1i/xl09tG63FSUpa6Hc1pjxhMis9cd15M3vJXg/i3AeDXxc5udVVNPmsYUDKNkLBLQpJ5mowucmZteg==
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:23:22 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::38) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 09:23:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 09:23:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 01:23:07 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 01:23:02 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 2/2] PCI: dwc: Consolidate RAS-DES event counter fields
Date: Mon, 2 Nov 2026 14:52:38 +0530
Message-ID: <20261102092238.3917883-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ce4170-be0a-4a3a-47f3-08df38c2f0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261021123027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QcT0fKgA6xOEUfbvQnL+j3EcJDZxube7LlINATUtYep36N6lAVUCynfsjv1PtGc8hovD1jQeT03t2OaG8ACse6KnFLLEvk42aD4S8F0VDcgIxp+jTUsoaPy2Do8MpjUfJqnl032hNQDGAJXV3DXoiq2qs5qoR25Jon75OGCInkb/WOJZx5U0ldW74Iaa2wVfSAMBEffpmlk+/9bE5GE3IFTpQXfuh9tV1uEHl/T959G8ziRhZYf4w9sAYtz0vn62ymiJTPWqvoi2ZUHSX73RrQlINoNL34LJr2aqUR3pRnkIGlwEXmuypvkFSds9amszK+7mG9uhxP5qQf2c6BFnvkw1wSOahUr4lSBVvrGcWej9W3N2lQ5mhiwiFnCdC4n0X9YLD8pREgWNfjzz2vGQO+tifeTgz4xE4HOQx/SArVwhmxZeB1NTmYxQ+BhDAc8L43G7QEOz5IWdSFBEr0cgitEXWyjzLyMfp0b1c148zlUSQWCd3WPxASxhNICuNG++UKEodBq18ERpyoSRB3Qq5Xp6j5jp5agYm5eLmegXMdwKlutgGwVPjd/vHa8LbHVseUhzhMgLoob5nOVR7xnPP+mlI1pVQ9G3L74GVWuPXfEl7YpYW7Sobw+0zrFsHhmwJXyR0NMhy0n1k0Km9/P1ZVovpwnaeNihdoiMEFyQKT/ZLe4Ntn3KkEPhKLydcMObQ7pK1xWK3oXMkaQFJ97HCg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CX75ekfFls7h0o3VEMTEkBE7wtsSqWuyhqddzp1WW5mocF+ToA7ZZJEkOMJ6XkVDJEhiNRvb+mzWFp2sWhR4e5/y9iuXcvJszQBJLBChYgjZ3PL6Qi6Vd6KvYS+Bqf2SPQKNFSCg6e5H73LrIP6VfyxDF0JOPCkXvalL+3O+y9C13begwAnwFppFhVGZ+Vywg8JArXWCPfNfoWhaDwIm1PS4cYc7wiez0XKRW7Xyf2sFFCahZFIg3WkA4itxo3NmZ5ieqtubltRdFnG2JSE9nQeSdr/W92fFtG9dr5DSt5a7QKS1p7nFooUqNOizxJrvphUBS81b2VKcR6XpYL0kjWvxIHBx+2t//+Gq2IXDkN2JqziHFbjnPl5W7rsgzC/CBrw32pzB/Izaqq9ugr6v9GMlLHWXu9mEPlY7TJCk488rFrcrwiRW4ON/19b5Pp73
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:23:22.6342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ce4170-be0a-4a3a-47f3-08df38c2f0ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787

Use the shared DesignWare RAS-DES event counter register offsets and
field masks in the common debugfs code instead of carrying duplicate
private definitions.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 40 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 ++
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index be0b84665c9e..eb899ed7d418 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -31,16 +31,6 @@
 
 #define ERR_INJ_ENABLE_REG		0x30
 
-#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
-
-#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
-#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
-#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
-#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
-#define EVENT_COUNTER_STATUS		BIT(7)
-#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
-#define PER_EVENT_ON			0x3
-#define PER_EVENT_OFF			0x1
 
 #define DWC_DEBUGFS_BUF_MAX		128
 
@@ -356,11 +346,11 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	val &= ~EVENT_COUNTER_ENABLE;
-	FIELD_MODIFY(EVENT_COUNTER_GROUP_SELECT, &val, event_list[pdata->idx].group_no);
-	FIELD_MODIFY(EVENT_COUNTER_EVENT_SELECT, &val, event_list[pdata->idx].event_no);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL);
+	val &= ~EVENT_COUNTER_ENABLE_MASK;
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, event_list[pdata->idx].group_no);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val, event_list[pdata->idx].event_no);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL, val);
 }
 
 static ssize_t counter_enable_read(struct file *file, char __user *buf,
@@ -375,7 +365,7 @@ static ssize_t counter_enable_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL);
 	mutex_unlock(&rinfo->reg_event_lock);
 	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
 	if (val)
@@ -401,13 +391,13 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL);
 	if (enable)
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_PER_EVENT);
 	else
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_DISABLE_PER_EVENT);
 
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/*
 	 * While enabling the counter, always read the status back to check if
@@ -416,7 +406,7 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 	 */
 	if (enable) {
 		val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
-					RAS_DES_EVENT_COUNTER_CTRL_REG);
+					RAS_DES_EVENT_COUNTER_CONTROL);
 		if (!FIELD_GET(EVENT_COUNTER_STATUS, val)) {
 			mutex_unlock(&rinfo->reg_event_lock);
 			return -EOPNOTSUPP;
@@ -440,7 +430,7 @@ static ssize_t counter_lane_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL);
 	mutex_unlock(&rinfo->reg_event_lock);
 	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
 	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane: %d\n", val);
@@ -463,9 +453,9 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL);
 	FIELD_MODIFY(EVENT_COUNTER_LANE_SELECT, &val, lane);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CONTROL, val);
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
@@ -483,7 +473,7 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA);
 	mutex_unlock(&rinfo->reg_event_lock);
 	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6d788aa00011..09fb802174ee 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -276,7 +276,11 @@
 #define RAS_DES_EVENT_COUNTER_CONTROL	0x8
 #define EVENT_COUNTER_ALL_CLEAR		0x3
 #define EVENT_COUNTER_ENABLE_ALL	0x7
+#define EVENT_COUNTER_ENABLE_PER_EVENT	0x3
+#define EVENT_COUNTER_DISABLE_PER_EVENT	0x1
 #define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
+#define EVENT_COUNTER_STATUS		BIT(7)
+#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
 #define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
 #define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
-- 
2.34.1

