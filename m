Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D142901D;
	Fri, 16 Oct 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136495; cv=fail; b=r+xVMbx3MTyJ7ZpY3hKpW8h5aIZw4EwHao3W3xZGAufJh0/34Pq6eRo47fSnI/vBQKvE0uNluJldA9RzsMEWWb40T70WVKUd0ea1W7PdyMUtjPgU0KamnjMO/mUIKmndehap6R3M7OH6QD7F63D3pHck//nWRlGtUpDAhPdUzeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136495; c=relaxed/simple;
	bh=7mRlv9QYDkczX0d810PfxI4XSAOeGkYuzFbVYnSOSj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiPPEkio2lCEUY7gVXwwjUMcyY7YnjGF6b1ZrHylrQXL8skMWLZBYt/vQVTNdwW5/Q8neIMLM5kBHJOcRZsd7dtW1O/rkU91dSFy/1iEOUl93FpXxy8Pn11O8VF+1CzSGybehaQC0cw/GUME4Bcz/Hg/PYUoEWPmGPkgRusnSdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mywg0XK+; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mywg0XK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3SiyOo/62q/ER7FY3adFTpHHhIIXBxExDrqsuEyJJsbd+jGYQuNH3rXRb5sT7Ku5OXKkveUQXubwrkaCKOGDkk0+d1msGVxPDAdrWWWkqlMI3B016w2E6Dt6Spj36RMz3oyRhEe6PH2txeO89GOu4Qn/CQz3xrNfgPVPm/yPPH0rpwCnqWZA65jm5NKSV600GU+PQ69YwZoMRCJ8MPkolsVSCCfaS+0VQFL7NMS0geJWb3mDEk+xSLKu1KQ5RZijogRozYysliM4LELNJwHYStUBje+c8tn7Sv6XPrAx5gGUWhpvMpFqGNtIUoJknB2gu/7dfQtxGWxoPQvTw8RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1MHAzyCBi+1ledJynZ0l5F1IpcRkr8gmkw2eQ91sn8=;
 b=YBGmVThK1T3cWeP4qplxg3R8Qo8fkHSmQnR4qkqGmWyD8Pv2VPP7mT0UAg81SykuQxLaqvi5sd1Frlxoq63UaqfIAEyPqL+9QbTWx9hDAORlWLHERr3jjxELqVewf8uoWHBJTSqRDXuAv+iNfP5EHdSiC6Qfm9SAj6SN/YS48Z5oIIpveewXDtNA7cw/JVDhUueNMLi/ddvtWpApLwuSmTY3JW5MFYegtPLe4VVDc7yO/57QO+xyaqqT9680H/xJM4ASI7gLXXRpQDyB4LdSIRFWpvs2W7FLZjFHffrcmisigbRW3Xfdu8daOO4+u6nHxFKkQrvfUMABgeefwuIvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1MHAzyCBi+1ledJynZ0l5F1IpcRkr8gmkw2eQ91sn8=;
 b=Mywg0XK+CrQj5x9X8PIv2zbVEAZLBfXu3RvgFOI3Wt3zCOfpQF83b95ysQgaGjr3/YBs09g6YUvM0+bip8Sg4RwGCA+CVfDiihsCtRpWtNhtXc3s/+RxI1QsR5oPawd7roUzIie5YO8/7ngWxqFy7+aeCFUzIPV39btU757AFYqn2d/6Xfx001z1QAwGbmYB6u06UIhs0NqyZTUz2BBtQmqJKkpdOLXN6RRfXwVBtSslgxiUHxDH9gg+4UYLMQi4tfG+MfP2X2CKcUt81Gn61iWZYhLguyNc8Z+D9vAyC44MRuX1UGED1y+5eGNk9q55jJ0YDhvMbuEBoTHZeirIkQ==
Received: from CH5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:1f1::21)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Fri, 16 Oct
 2026 07:41:28 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1f) by CH5PR03CA0023.outlook.office365.com
 (2603:10b6:610:1f1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 07:41:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 00:41:09 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:41:04 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 5/5] PCI: dwc: Consolidate RAS-DES event counter fields
Date: Fri, 16 Oct 2026 13:10:26 +0530
Message-ID: <20261016074026.564302-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016074026.564302-1-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e81741b-3d1c-469c-853f-08df2b58e366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|7416014|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zAdam983QikIl1p+NOwA/e1J1kOSMAhgJ2oS67/zQdoxjRmjNOxLu1nDsfrrBGrKHId9opdrBGdjHqPLajHsPUhT2S9ptvfMrljrRRloaIltGDbA3sXdJdwv/BzyNL98GfUn6g5CVr7Q2JZl96F1OjiiZtY9+MPPOkOFsCedgyKJgg1PkIJjjE+U0+pCpsDKId1DTW5n1sY0BL10HomBxXcfl4w6/7y6P7Eg8eLOiNCuvgXs0KFN6E1KpsmQCWQFDBtzwtUl9SRa8Uj4rYWD4yw+3ZHYuGjqe1EHLg1BP4t886aqeVA7LKLlUKQRT2jTM3WPG8OTfH85ielVyuNm8XQmu3OXgz+L1SmOmAjhmzKNQfBqw6ZdcrlVeG4AT01em8Mtmn9Pj2OMR2szWPbVhyomdTEaQf5Rw5Hox1GLr2+Bg+0BV554Yli+PzlDOTwNa1bIiHdOUUgOWdHZvbuvNij3iTg2p7bbIQAOiTmERn35K7RMal7UNdy5K+a+DEF7R9UQ4cqzdkjHG2UsNbt4HJw+TEfI1ZWgxy3SOYqq2CSUvM94D+BFjEDpgbAz2VHC0iyV8EPUK60hyCywBxPb0Sa0agtnLXTdZxzYOHq8Glarsg5Rlgcl26/JsasNGioY7VtiAo4ZAV82qjK9SJTPZ8vI4Z/krVcefebCVYHJYlv7DNLGNXAs72TDW2xdCmjZk0KliNdcESNzuKvcs+ntrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(7416014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hDQ8/gBEeeAj0SYeh8y/diTrJn1W23NflEQPwiqpriiS5UF69t1SjKM4hHkhQ0srhEWabCz0pQto4NiNQP2dEYbLeReTAwCkmHwyZzN6TU2jkUOOHrO04qAfN++oaw0uFFaaQfgW5rbLylkirpktfpoAnZZpvaUopgx10YnKnPsk6gCtjy/iRIPVEQvHnEwJ14blFnNbW7AfYYrMJUNOGg7x73N3TxxkfVpxvlRKzekrixRJxHMPgCA+F2y+zrlqelDlW0ZcaSvJFS1wWc3jZnO1YnlNrfSZqhcz90Lx9hrmrpZgjXfiCUt5vT/flSTXCJBOSZj2+jvSE1APuZeBY106GS58K4MiG7dd/gYoM/2YqZRN7mlNPWjbuN1CLyVUzQHrOXK3g365lGNithOMpsQiTUzxQkTUocQyk7O6C0ZCmjwkI0+8TBvgWL9hlEV4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:28.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e81741b-3d1c-469c-853f-08df2b58e366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

Use the shared DesignWare RAS-DES event counter register offsets and
field masks in the common debugfs code instead of carrying duplicate
private definitions.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 56 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index be0b84665c9e..19752cba50b8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -31,14 +31,8 @@
 
 #define ERR_INJ_ENABLE_REG		0x30
 
-#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
-
-#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
-#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
-#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
 #define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
 #define EVENT_COUNTER_STATUS		BIT(7)
-#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
 #define PER_EVENT_ON			0x3
 #define PER_EVENT_OFF			0x1
 
@@ -356,11 +350,15 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	val &= ~EVENT_COUNTER_ENABLE;
-	FIELD_MODIFY(EVENT_COUNTER_GROUP_SELECT, &val, event_list[pdata->idx].group_no);
-	FIELD_MODIFY(EVENT_COUNTER_EVENT_SELECT, &val, event_list[pdata->idx].event_no);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CONTROL);
+	val &= ~EVENT_COUNTER_ENABLE_MASK;
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val,
+		     event_list[pdata->idx].group_no);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val,
+		     event_list[pdata->idx].event_no);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     RAS_DES_EVENT_COUNTER_CONTROL, val);
 }
 
 static ssize_t counter_enable_read(struct file *file, char __user *buf,
@@ -375,13 +373,16 @@ static ssize_t counter_enable_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CONTROL);
 	mutex_unlock(&rinfo->reg_event_lock);
 	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
 	if (val)
-		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Enabled\n");
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX,
+				"Counter Enabled\n");
 	else
-		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter Disabled\n");
+		pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX,
+				"Counter Disabled\n");
 
 	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
 }
@@ -401,13 +402,15 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CONTROL);
 	if (enable)
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, PER_EVENT_ON);
 	else
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, PER_EVENT_OFF);
 
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/*
 	 * While enabling the counter, always read the status back to check if
@@ -416,7 +419,7 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 	 */
 	if (enable) {
 		val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
-					RAS_DES_EVENT_COUNTER_CTRL_REG);
+					RAS_DES_EVENT_COUNTER_CONTROL);
 		if (!FIELD_GET(EVENT_COUNTER_STATUS, val)) {
 			mutex_unlock(&rinfo->reg_event_lock);
 			return -EOPNOTSUPP;
@@ -440,7 +443,8 @@ static ssize_t counter_lane_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CONTROL);
 	mutex_unlock(&rinfo->reg_event_lock);
 	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
 	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane: %d\n", val);
@@ -463,9 +467,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_CONTROL);
 	FIELD_MODIFY(EVENT_COUNTER_LANE_SELECT, &val, lane);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     RAS_DES_EVENT_COUNTER_CONTROL, val);
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
@@ -483,9 +489,11 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					RAS_DES_EVENT_COUNTER_DATA);
 	mutex_unlock(&rinfo->reg_event_lock);
-	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
+	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX,
+			"Counter value: %d\n", val);
 
 	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index cb1d1a98e61a..e7cdf1c69744 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -278,7 +278,6 @@
 #define EVENT_COUNTER_ENABLE_ALL	0x7
 #define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
 #define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
-#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	EVENT_COUNTER_EVENT_SEL_MASK
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
-- 
2.34.1

