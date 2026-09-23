Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3D3E9C2B;
	Wed, 23 Sep 2026 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147993; cv=fail; b=h9toCu+VMbPcXp/UVEffq20LVJJ/IVKRZdhSm30wa7VmLCJddfcZ0a4sOAGn1eEiSOq+RsstA5Gd+SvUawXbV9hGlkJF+KmL3UvlQYa30zzpGrdhId6BxJK49P+G1lYLA8N+RvqIkAxE0kb8Gm/BO13CXilYJJXd1PNWPCuDIvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147993; c=relaxed/simple;
	bh=L0bDu5C8ugjOtsezjS9uQU7QfXuniUL8IyBzosBdDl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/aBm18g9Wvy80yQ2teK8uaFdWD1kPHK1tCRi83ukGX/c3EAOT+Mdj1YxYIlEkKmc2Ljv8nNBKEjWfgoRZ09r0spFIQ0sAM+EQbdn5Yv2OMIlKSYXktWR7lADe94CSfthyGyKd6w0O4D82CRkWLcFh8QXooNJqzxfpkPkRLRgGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kVf7D5cM; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kVf7D5cM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYmEbX3uc8EEc4trID/qGJLrTVbiVaYmeNMBHb2t3OlXsfDZJXP1kdLWwv5zHqxnHL72k3zoL+PYPmb1YJPMT1tmwKDpYaUJgDzP9QfEY/x/y6pPtbaSmYYDh+aPXn7odhNO2DiraZ4yy5Efn4KwXltwT5iVlu4IXolOc8iW/ydwWw5iR90MNP1VeuhntwUKb7ACoXZO9PdJ8rAI/tVkWAIU69uUEX4gvUCgbIfSE40BST74nU/f+Q2mtlrDfFV6R+vBkxeAAZBIHUS48/AP6tRB7ri6h3q9JYVHNRLRP4F0IPRnRsQgD3kNSHcEAes1EzfwpYEIO5g9ajtlFh+9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/EJsabbqcY0JvyQzgR5UEHQHq0zKTbd31NGlJKDK0o=;
 b=AvK6BkwcI0sGGg1yV8o5DoX1ddMkL2vKvkPgRgwP/DLD1x7t3TqEIuS5EJWBTqRBnjjPgaT5t+vZUM1E9uyB2hA6kBEB48l1wywdg0laoAplCStieRxXgIqyjOlRsylQBEwFzgnS/IfatV+KIgxHqCFv2iRL552f1Emt0gQBNIyOF0In6EaWBjuMkA2Is7fYuMxcDyuIgQfjwGBnbHGlcMKZKXhxn4fZ0bZ2JiBfa6qoR+ya2MMuOAmUaKQhfTo4xP6AUQEy79cKbrgOaSLUue2X+2/pPDuunCrIIUbjW8B2ZyGhb4FSJ0791l5FRMsn6VLoR8kSHJ4ger4DQ4jsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/EJsabbqcY0JvyQzgR5UEHQHq0zKTbd31NGlJKDK0o=;
 b=kVf7D5cMZJpZyY5WznX2FmosnWymHzYjFXNZpthK2nXJcxI4OS708m3ChYHJ3+U6ho0vpa9w+veT+ucIMWMGlwTRblMvhELoc24hSgJqRdLnPxorAGcxywKWdpvpp484w1VMTv3vYSqeZ5rgWOaq6Fng+9pqZ3Trx2MzgN7IMHBAdAp7EVRR/TtwWCBoBBiQnzqYmJCrKz7dN0wUA54RcNHsULek9VD+7PPUnjwcGFOz7isdxmwHGhXWMOpwJO3WwWpoUYMrpRZHMtq4lnuvGQFyZyQlFmtE05srsND3hSK4AJid6eNTsqyhKl+KwHslRaxwpXLpzcXj0b1/TOGWSg==
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 07:19:38 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6b) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:19:20 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:19:16 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 5/5] PCI: dwc: Consolidate RAS-DES event counter fields
Date: Wed, 23 Sep 2026 12:47:06 +0530
Message-ID: <20260923071706.1134320-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bcdecd-c2f1-438d-3b04-08df1943072f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CYMshs9wlY/l+LHgUk0VTYIuL0WqeCwbRh4ocLuPzuxka6GK8a5rn5lzPYn9/FykMX13iq5n8xnM1Dq79bEu5x5lNODpxdR+che4d+rsQYYsBIeA2+KAb7dJv1+qtBE69jQbAFuZ6S9OEGokuENOyU3YbsLBX+gqusYzAvepLYh2nYIogxlOTdngkQfFJDnkmRmcKLxRKyKpuht7Ti/foFosVYriGEwTbdxeO6pkUxxpPnrQYPvdBz+q9wAHtnm0ZiIpDDsvJtIJIAqJdQ+onE37tjfdC8rgBgvhaREw38KoEktkJSXcPtooF/L5/OGTUzEsm7mPsWerDAFSUDPC0SnoI9jvyAs/HCVhv44ICDOhJDaBhIYrxai9+V8CQw7QcLXI0TCzux89dwZE8pBuwcyCnQoKn4x03xqahKe7mcypdvxbTQLys4c71GbfZT4uXPFurky1QtYYSALNouds2ix/siDwhAwupCSML6sCzCu/8MZkw6c/CCB8fC8/Z4XDE1vq6zkox6MwRx5NSPNwe+CLJ2WsP+VuAysXEN3NfMz6J/aucL+jkFpRGeFyzGWWh4bqvwKAopB3CMHVCI8KVGRKCLUDU7GzbQQHWRMRQRBbGgBaIq4keEwMgXm02YbvFAPXzmX8hybh3JGhC+gBzmEcP8752benhdtRT7w34c+s+Ci1cIkdhvL38+kIYbawxuA/IuraXP/AxH3Z1FfePw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SH7BQ+QBxnuC2Oo8YCOjun/tqvlUD9O10zESF7TwEbgx6ckKckqrFj/1mDzhdr0N9kB36uX69rM+xZd1OS6d2p9bSL6XzEsAVsYf8Qsr7RxzL5d8UeRI3PQ5gx4AfofaJtY44p40L8vP4cB2/SoL8Pan5pexawix3X9PMlvN+s0WI4ti3Je5xMVb25AmeUnVXGJCj22R60UmqXecrKc2FYrfRM9LEXMTPjhtTsFZoETnaGU1CwEHeF+WYdNrxk3kACqSiyguhXg6Hjjp4ZM0ZctWC03IAMufSlo3Eb8j2R/5PX9eErBr5phreZRp7rAAKz9PtJZDKQdi4uiLr/YGm8BNVI5eVaLoy/UHArF7XWo4V1hKygPCLO0ZJTWbAdEj8B8vAYy90aLh1eqv9YP80glsRj/6VPvImZnRAjbbY1bHXRZRDa6UbYN6EZe8xlxa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:38.3698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bcdecd-c2f1-438d-3b04-08df1943072f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432

Use the shared DesignWare RAS-DES event counter register offsets and
field masks in the common debugfs code instead of carrying duplicate
private definitions.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 56 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index be0b84665c9e..daabc6ff0d85 100644
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
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
+	val &= ~EVENT_COUNTER_ENABLE_MASK;
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val,
+		     event_list[pdata->idx].group_no);
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_MASK, &val,
+		     event_list[pdata->idx].event_no);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 }
 
 static ssize_t counter_enable_read(struct file *file, char __user *buf,
@@ -375,13 +373,16 @@ static ssize_t counter_enable_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
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
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
 	if (enable)
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, PER_EVENT_ON);
 	else
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
+		val |= FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, PER_EVENT_OFF);
 
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/*
 	 * While enabling the counter, always read the status back to check if
@@ -416,7 +419,7 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 	 */
 	if (enable) {
 		val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
-					RAS_DES_EVENT_COUNTER_CTRL_REG);
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
 		if (!FIELD_GET(EVENT_COUNTER_STATUS, val)) {
 			mutex_unlock(&rinfo->reg_event_lock);
 			return -EOPNOTSUPP;
@@ -440,7 +443,8 @@ static ssize_t counter_lane_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
 	mutex_unlock(&rinfo->reg_event_lock);
 	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
 	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Lane: %d\n", val);
@@ -463,9 +467,11 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
 	FIELD_MODIFY(EVENT_COUNTER_LANE_SELECT, &val, lane);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
+				     PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
@@ -483,9 +489,11 @@ static ssize_t counter_value_read(struct file *file, char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
+	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset +
+					PCIE_RAS_DES_EVENT_COUNTER_DATA);
 	mutex_unlock(&rinfo->reg_event_lock);
-	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX, "Counter value: %d\n", val);
+	pos = scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX,
+			"Counter value: %d\n", val);
 
 	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, pos);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f70b7da97e07..4d55339750f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -276,7 +276,6 @@
 #define EVENT_COUNTER_ENABLE_ALL	0x7
 #define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
 #define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
-#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	EVENT_COUNTER_EVENT_SEL_MASK
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
-- 
2.34.1

