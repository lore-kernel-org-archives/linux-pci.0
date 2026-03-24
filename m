Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE393DA7EC;
	Tue, 24 Mar 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379516; cv=fail; b=ZB/rvNfOmLfO425A3/hfDo+urcmDiWtpHEpcONGiwh4Zh9ZrKczlNvkHrgaH70lya01cRp2yQcd1czI6He3BswM79V10e1oN2Efkv61LOulT7GHpnaZKCvDaTMZnhKsqKk9a4YxdPJFfem2yhLAGiX5PeFIbkrY0+t3uNGmkkfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379516; c=relaxed/simple;
	bh=MZfOquNYjL8fMb9Ddp53OVkci72XxOpCnMmBVDlWqwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4hQD9nQGJKV8pwympmkgatZKKfMoPacG4BLKudTq5e9B77UEqg4GK7LcRCS3HJdOzDXJFI2DyyH2ztBbT01W3BFW5QaRJ3DPsruyvIr6oaR+lpbLz9SRuWyTkkulbJ3JDe1bwFp52aX7/YPDdmDy4WbsMY28FFDBCNwnXB8KVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/DHt1oA; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/DHt1oA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQx9V6xpB7sXyEPuKNxMH1I32Led9aSvC3Ph6WJj6Jyqa+ockQzxT3uLcU8ys4X/IJXfU1hw+vmtGZpX4gO+dzc9sihkkguvwmtA1VGZqlRW8qPua/Y6MvRzkmVffPDsqo4C+TA1zij6piZXk1KpuxX2pKxYnAREt5Wf9uxKrPponqXpC0S3BdSGz2+Xt71H2VoSCSmYZwrveTr93KdniLDYoF9AotOfGZ+5NBJytzYMt9fXLOwicyIj/6/pHm/iWfdSNVU1iXwkqkHwNFbejcqN/3+8Nl6dVRf5ENSSpIisK0Y2TA0pEaCMRTW4I+zWEAcUJUKKbyzWEB8hOvKqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epk2Yrf3XP4s7MhfXN6Gg5cGelFKtM65iLjB6Sq3XQo=;
 b=jw4ssA9x/F5V2jKi0tY7Vw7JMWKBVXFItFxg5sVvU7Re2hIC+nNtwSZweFjDyMZcloPYgLd8jeUcn42O1lm2eVbxi71OwqLXvhQCXH3VtGc/pdjNJ6RRGLSfBt3ulEiou4p1hHFQdEc868Xog7UlqPXImkCGuM3EYTuR0hO/2QAdysdHLETWT9ig68feYtLKvwaK1BaIqhDR5sem8jGRMmQEZtzPNd3UuqEilGcCSXHdHRufGJaO6IWfCNqrNo+kE3+VPEgBJCKlzuchsJpGPS0ysX4H8O4u3NSRIYP4jRP3hEXe/MozMUV7NYiwz3qJD931qd+WWKqxcTOmxNfIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epk2Yrf3XP4s7MhfXN6Gg5cGelFKtM65iLjB6Sq3XQo=;
 b=C/DHt1oALZtSDiUlicqrmt7xSxpg9g7r2sMOzwvrF6z0K/25PLbJkLhytmDXaS0HfmM9Hf174nPZwfg7yqqhsjCKPeANPi7XvSfvTZE5REoa1GOahHQl8MtVaLWs3TpPYyKF2JO48wQ9RJGucZUMH6KWdHc9eTrqjxqQWWKjvAq+CSriEMvT1bbi82AqelxBExKJXmX10gPlqR6YqVE1kcLThUqlVmTsbWuBXN8+ebsod5WpM0gvTTZjdALiXij1uol9VFs8z7rzagyhXAb5SmaJknC3spzWFG2bEQnA+DxDBidLP3dJSxwkyW7Lin6YkZdFynwjdCD99oEZR0NmVg==
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 19:11:43 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::fd) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:11:21 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:11:15 -0700
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
Subject: [PATCH v8 9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
Date: Wed, 25 Mar 2026 00:40:00 +0530
Message-ID: <20260324191000.1095768-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cf1db1-24b7-4f45-2677-08de89d92fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XfAyPtEnZ2KHFmGM9ai/Izo5jHCDmgzLhEK6qKQkf7ACr3a5e6zQHZ2dsAQSqRMUgGd6rHiSyRARn97Tg+1sam1Cqq3dDuzu2Pb6xO0XO4mbmkoGjOVclkw+qnTTQ2k9tOwtd+Hg8ntUghDaZNXf4oimg17qBUfva8H/H2uk6Fz0KPYZ0H+wYmSVqu6wzZjBFKu1aOXmX2AOxrhX1HFx4cVFYWCsiW5sr/oUwKH/nXcKbYTwkmJbE/YiZxYnC3BGwr8BBWktUy/yfwKrONjrC4hKcAXsjZwFGgpMRscPdTEqNO5u71qxKSADQHUKdouvOnZvpHtScujznOUR6uQqdmIZiy71LCjLaF1rA0+1QAam5EGSQLphZshbq/fbSkGGWYYyMoM9rczL+7PoyJGYnLUKJuwim0nXAAlbJGcwEkgJeru0WMRRmEMndh6FhRGz8aQUP7FCsL0ak6z9aLG7J1EtTwIbV1wgrJucFYVi9gz38UAokMXAR7GzF8VR8egO6+puQcs+QHjwjGAjO9DZ/Y6P9mik2cUl5ZKwwXOeusClk9piKL1O1JrWnpuJ80+ZTiG1vSPMymlsggp/2SnKBrBaty57bgbjQ6GfCckVUHv4+9My5UPqfezzGjE2dQWER0jJW3IDnlE8BB+5NgiaKV/M6WeVn0V2A5mnO1aFDLJN4sNYYyy2gW6LqG3YL5oCtWIErjx/M0YuWEOYBPi2pp1UWRD3Ay9okouXCHemId/MI4lFZ0AmUL/73ygzMGoAeP8spRcKuo2u+kG7VmTGXciHPTyOeR0Fi9R7Tswxcbggb0osq8cUOV4kUP4XFjTu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E7YR6oEkC3zgoyn8mCKRV5X/x8zdeueUGW8o6BRdB1Jg/WdD1YJ6TiAj5zeBcFiLqTbd10Ui3x1VojbT5sQsTU/grZu2itq1MUyr6arTLgsoK8KxWQnpq5MPAhUDafMtkOZ95LgXP/nAsU9ASH8hzcD5ac8NsNix3/w5i70gybZ3f8wPCeAf7Ac9cNlFXysEhXwV9/Nb9YtE4x5dlzOV/cmBKP/FCR/zw0GpZw3Ju11pT70RNPAV6kSTy0bKWeOfLaPVKz4NkPITrmxnpmFzq6WekUANtf7Us8yAIkDzaXypOKnwzK8+agEhVJZbPpAEfYTOB3VdjuBzBcor0RM139zDZacWePGlVxdR5CBBLwzDtDs7cFKy4tLvvnjSg8OQHBzkIM10rnFhfumNKJ0JxU/cgC9bMhyou535wUigbpX8+q+Fhb0DCjNDfYz8lqZJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:43.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf1db1-24b7-4f45-2677-08de89d92fec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
device tree property instead of of_data. Convert the value from nanoseconds
to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
absent, default to 7 (maximum latency).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Use aspm-l1-entry-delay-ns instead of of_data
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3278353b2c29..a856a48362df 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -272,6 +273,7 @@ struct tegra_pcie_dw {
 	u32 aspm_cmrt;
 	u32 aspm_pwr_on_t;
 	u32 aspm_l0s_enter_lat;
+	u32 aspm_l1_enter_lat;
 
 	struct regulator *pex_ctl_supply;
 	struct regulator *slot_ctl_3v3;
@@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
+	u32 val;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		dev_info(pcie->dev,
 			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
 
+	/* Default to max latency of 7. */
+	pcie->aspm_l1_enter_lat = 7;
+	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
+	if (!ret) {
+		u32 us = max(val / 1000, 1U);
+
+		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
-- 
2.34.1

