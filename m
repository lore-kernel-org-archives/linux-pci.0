Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B20392822;
	Tue, 24 Mar 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379337; cv=fail; b=B5d6OFgKFCqEaifWhuOx5TAZrzuY0zmv0Bw8J0GTgKNcMoDe69js530SJ6PLC9kxueV8yiEb4RDrNAbew53frKLB2BGYZ1kFwjFva5vfh0yEh2yJcw174uQtt06fummJyUI1tnWcRB2F9E9FkNiVX7Zzs0WS3dcXKehn7FPOfLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379337; c=relaxed/simple;
	bh=ZjFH8Q4T+R+aAtEsfh61PAHezn3uQd65oGRG5vLXQ4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKRW0fkJfek/LsHgMiAkfbIwZgjVPXshN/H7phErLnabMghvPX7nLYulSB6w1lwAROKFRdSvndPibTJcjoXe0Rh4nUd60nYSiLZdL6RrKaL1S2IuBgDKVYcdSeAiGL485oSKE9CDelqrjfBofENg7hS507fC+GpoZJZF8trkd5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f38mGZDq; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f38mGZDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh0k/CcnO5EqgPieojEbb2KaRjDCuWIgixslBS50X2AHLw89RkXu7VaqwwpR37u6FErn468xtt5KG0K4tCCp8b7GKUtdBadCdKgsbVQHLpzUzFOg8jsnj999WsRb3msc7eHL4DVBOlqZrXFrHdIF41eDKukfWxOiyaJxMp4QqQmhlY+LX2+4y+PnB/Zsp+Py9j6mW2qxiWubOn9XQtnfW9K2sP9Dn6eR4r8J9MVPzuiCYCexLXJrSiaCtbM36ZrS8kzdQNTOFXIuxXyvawKnipR7AwZ1oYJ6ZaHD7NIJ7P0AjIV5gtJTJXTdVFUkrsfzH/V+fgRZYesxwg7uuewKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJI1T/xQITV345OU8YDQiApgYoXe1O5SmVjmZlwKNes=;
 b=eUFVimmlqk47vfahkoJxzBPcTRPpuMpA53yjI1UVaL0nBbLuPkvuCCOuzYfbRRtVpyj5agkXD7oKVMxTHv9D8Hxt9fhlbJiJYa1famNdux68oMIC+3B1E+vg8rpBZEc4nJ1h8WpWLj5NtMdcJe/St3A5oA5xwb5S+/q221mi9m84P70mar5VdkRCGQM+v2XOnGe3h2c7CNO31Gk4aiVaNZXG40P9DZuU7gGAZPVMhxdiGLGByon1+b3qzXm04kZkq8XPO7SEsr/bp7bpZWnc5E4vuV77gvdPsWRkJeHjPdpeCr4T4SSBvzxIoKxt2tOAcJpzXZb2IEZuaCauSw9tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJI1T/xQITV345OU8YDQiApgYoXe1O5SmVjmZlwKNes=;
 b=f38mGZDqjvBV26RruDYHr4DJfLEoG84BUxzLlTCJUnQRgS6bu2R7fGq4xVw+eMVbGkPuGPa6Wd4HYYZIpMYsJq3aDWmtuKYJ34fbPjdo9tap6NsjuClc0AtxxHJLiopOmsEcMQ4Vb+OWCpqMwxAXqH/sqFcdww2ylFLIUxdjDkd20G49PFqZ8Op0OvgL1Nri2GH3WxdYVoNp3KjLLuvwXIdeEZ9KE0BQXs0vCvddEZp/zLR5L2lRFBVe0ZvmikerHJBbTHoWnEm+RWn6IWuEDbHXBLzv5w5eU0Y2Em7ZV6PBpcAw4ClZu4c3NQOTY15xCe2+YQ5ekA59ByFnqTz6Bg==
Received: from BY3PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:39b::9)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:08:45 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::35) by BY3PR05CA0034.outlook.office365.com
 (2603:10b6:a03:39b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:08:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:27 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:21 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v8 02/14] PCI: tegra194: Increase LTSSM poll time on surprise down
Date: Wed, 25 Mar 2026 00:37:43 +0530
Message-ID: <20260324190755.1094879-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ec7e98-0993-41a3-de78-08de89d8c5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PM1I5yY2bAUivmu8m5xG6V1K8fMC/YAxla33Z56zOr7EXXJyGrpkrP8y/uTVUQzocc7d40juS2EMRFffZ0nQxmsuR0Xo69IHRX607ecjYO1TayzmKDcNE7dV64vnZwC4GAmvDBn49ksQ25QcOT4Co3m+J4JHTWc+eJnrhyRa+QnRNa2kKPrY5F2DbP0/v8F3u0Cdl2vkwuD/3O0tZtAv490hAh4BtGAi+cLt8z8EUx628iBA8sLQapsRxLAW7p+bL7yqzegoth3kF5mgKyMzx1Yaw08BUH1UkcepuNTWOCQPcdsFsZkAHmigZo0uQqYLG4lkp6CSHqHAqQdQFRVKDmL1vnotme+xEM0Ibf7aUHZQI5gd+w6if5UWuAEIA7kT0pBSjp57lYxKo46cBXKYKF/WTBzgRMkfirSYt10L96kMvGoimcnI1l0MqGA2ifdYz6qizHxhW7Cr93P9cw0WImz4t5nUUvqEcOLIr8R8h5r94tJRSSZgG8AFUfzXaRT0uataovpAy8XnrSVlQ9bdle16G2/ejT3Nh5q+DiipvGiospVSBdiNJtjRUYY9tdRgLTmUIH4w0rLW8JIcsTmJTHayliNAfuInK8r8LvHGuRKQ63OPf7bm5OZaokBOyjkPrIoBtk6t+kfG4gEF0KoUSAhChGV2iSzy4vlxNLQR1/L3VLvJ9Ndtp6Gkv7nTudU89c7gU1xg7N2KCS/bvzjOBvpBS5ed/8c+4b/XJ0X/WJ6vQPEE5OFimmeI9eVJ2gKJkgGGlw1+1kuEwJJcNLx9DN9ne/T2Jt97gA+ACPdjX9NKbKhldhUp305iuRwOoc3E
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S5HazaSaa6r+50Wb+Dj75Ieh/uroxsvDwjtl6xBqZVj6LudTu9M/QUD0cvJgY13NrPSYPLXYq2GkSe/JlrndZ/lH4IZUj0UIkJJkCYajCMRLr9oKfjN3PRERKehlAAzjI4E+DQ1rJnxepyCB2AkBGgVSDY/DUL5zgjdfHbVPoexHvSFQkIyXtfCUySFzu2vZ2JW08gMrNzlRPy0WQuxQztPutXbriJ+GY3VSfdg4GeZwKTTtLNn7b3CxCPi1wFfUOzU+6TFarLCBa79Rri9w8Yp9RJuxsg3oOwAy26E21qTLli48492aOZ1gDPwrkMwaIWgmOQT8Hh/ey6nKEp3qEZmD9m1BXzWmFgtzFqvlI7Y5wYHN7EzmYMvIitoymZjJo7CQi3zEAVqgLBcmFndKpAQyp2SEDnk7u9WP0PaInmZ9N19aza4oEbMAWz/A045v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:08:45.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ec7e98-0993-41a3-de78-08de89d8c5a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
and Recovery.RcvrSpeed transit times are 24 ms and 48 ms respectively, so
the total time from L0 to detect is ~96 ms. Increase the poll timeout to
120 ms to account for this.

Add LTSSM state defines for detect-related states and use them in the
poll condition. Use readl_poll_timeout() instead of readl_poll_timeout_atomic()
in tegra_pcie_dw_pme_turnoff() since that path runs in non-atomic context.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Split into two patches
Changes V6 -> V7: Append _US to LTSSM macros
Changes V5 -> V6: Retain only one fixes tag
Changes V1 -> V5: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d6c6bd512b51..5b243c006562 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -137,7 +137,11 @@
 #define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
 #define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_PRE_DETECT			5
+#define LTSSM_STATE_DETECT_QUIET		0x00
+#define LTSSM_STATE_DETECT_ACT			0x08
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
+#define LTSSM_STATE_DETECT_WAIT			0x30
+#define LTSSM_STATE_L2_IDLE			0xa8
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -198,7 +202,8 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY_US		10000	/* 10 ms */
+#define LTSSM_TIMEOUT_US	120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1597,15 +1602,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_CTRL_LTSSM_EN;
 		writel(data, pcie->appl_base + APPL_CTRL);
 
-		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
-						data,
-						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
+			dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", data, err);
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1685,12 +1689,14 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	appl_writel(pcie, val, APPL_CTRL);
 
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
-				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-				 LTSSM_STATE_PRE_DETECT,
-				 1, LTSSM_TIMEOUT);
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
+		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
 
 	reset_control_assert(pcie->core_rst);
 
-- 
2.34.1

