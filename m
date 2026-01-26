Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2E31064B;
	Mon, 26 Jan 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413593; cv=fail; b=gSB1RerrymjFVRc1RRKXOR42mhXVKPd9/ud6Gj6SUQtUqN5XYRd8NLe4PHTaHOjYHWtJrFdlYGe6/0hynfQRdP8PEgLoDhGg8dN6YtYGIk4AsC1BD6pYgaOSxb1ssW0hXexrFvVw0ip25rk2CPeDf9tv4r3DLtrtO158G80H/Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413593; c=relaxed/simple;
	bh=qksUTW8qGZPbPSapS0+O7TPr64xKPCdIwlMCoLiFgkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HV1FlBE72PYJRAFyxkfkr6Qj4SzD25GI6D1L+npxPxJZzcmp8IRPsRjZuQ1y8ONiSiiBeWMw1D9b3+TdnyeL+4s5F4WwO/reRV/YfQVf/+pU5EHm+19K5eSmjeQMkSD4NDz4LHP/RmtSUHWXje2A7MwurAUFODjoVqxjHL8j55o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxaDOL7y; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxaDOL7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDJctlIpRrSU6lFAdu9b0cMjecsnaYkR6LX9NvaciL1NQ/xB/10QtB9vzuD0we9WfY7tz63RMY57ILNzHvTkE2eKH93frEV32uQPesdRPjT9qKJ03U81hZnXFcIEW5HJAU07tb60zh045we6rPXX49rQ1UbBFvr1uqeK3k1QtZ9jhXPmdUbjysWqbfRAg+34b45Oj6gTJmTGRmOD7V3/gVHXO/K0PhiR11VtTHGaB7JvZIz/3pgGEOtNCNUKUrp1cDhmqj2F7YiID5CcVW+HXQKBRIhwRQamXfTXoUhK8o3rPOFqnq3jvRGTmts2D/qojM5vzWQyfAMRR+5z7SyXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++R2iWiyMt4JnDkppVbQrGiIyYjeNNXQIyDUszKQhuY=;
 b=CeHlMHiF5MBj4Xm+7YjkQMLk6oPpbGKJWHgfDeCQiZ3UVpjkFQ0eGoxTMb6D95c7Ci7CkAoC0VEK4sMQQCjQGLGceFyPHOsS5soHFLEFBb0MH/dRmAU2g9/G1RxJc2a9q5KkcwYKChdABDJZtHlDsPgcE8JOuRIK0Lm2v/aPheJHUf7G8GrV7c38loEfl0c+CgczZQQRYtpl/QVObbAQkDEnMBRK3Qhy7NFteMOlXOFplrn/suUVCSDmClB3QzsT474AuL1BGRIqwb453nIlWWSAf90XLkO6NdXVOfqwtcFlHxGR/KQmVQC7ljRhAZqmnYKtLbsBFJ2JYkIlPdQxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++R2iWiyMt4JnDkppVbQrGiIyYjeNNXQIyDUszKQhuY=;
 b=NxaDOL7ydy3khKekWLOjhJzN+SeOQYeVv9GMdafRwcXw41EKfkFX8PX8E5kva7Ns31X7Y3Dq7WVy5gnuVj0uLr0pYXhOEEooSvvvw/+Z5Y6PAJYnIrTqozwsCXzn6r/vxhkrMIeqW9f3ym25uk6ga48EnY7WAyjtcVBmlIMqOu9Tg6fABtOtZr9ayMcIRShAzdDPXkVfrFOClnXJ+0Vrh/z17p+0BOKxThSsxpJ+6kxEtl88aGyvZSz3D08enomiqtSvis0sNJ83OtDwVG3uxAW+Ahx/XqwnTOCFobIpQNKngapHkVRtjQg1USK+hLem2Fm39fhZbvNHDqjJVRlyDw==
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:28 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::87) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:13 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:08 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 04/22] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date: Mon, 26 Jan 2026 13:15:01 +0530
Message-ID: <20260126074519.3426742-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: abb655cb-0456-4eb9-eea1-08de5caf03a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X9VRwMyEjNYARqDG9Ey+Xx+c5skf1FEGykuuLPWPGCo9yfeMwicgqzIk8X0K?=
 =?us-ascii?Q?5IIKT9CwIGfEywUQRS17Ut/sgnpSzvONkX5JYwQFuBO0oa/zxb2PYYJ1xwhe?=
 =?us-ascii?Q?Ea31L87V3e7mYtTcytGkWDwJAQWVHsxClgKKQL7C+CT+eY05/AJx4YIg4w6s?=
 =?us-ascii?Q?+fT1GYy8TAxkBt3DQlG27vKmkqLxES8Zhr1rms41z+iZHiFySSBD0oMmeVfo?=
 =?us-ascii?Q?+4XcoNrZBX33YsjHXrBoEU9Me2zTax+xSi8lSGochvJNqSRNmzk4Trp23J6o?=
 =?us-ascii?Q?/TKzPUIU1ub1bokyPz8WCXjtjPyfQ16NEODfih8sepaFO0+WFS76bqaepaUT?=
 =?us-ascii?Q?ZSDTvTn93etIKUdqBkk5K6L2UMiJBOWYxwj6MvvkzwAGWLpgpMN5l5DPU0y9?=
 =?us-ascii?Q?zCg2gagPQ6g//DnylFYt6RXOpn0i2+8U4MWwmua5MGS430IItlThhYII6Ti9?=
 =?us-ascii?Q?Ai7sXjm0DflbZ6JQwrQWhNqUkArpZ9u5CNQ25XSDX+CGRBisBiInhNFbd5J4?=
 =?us-ascii?Q?r2d+mw59rLM4FqBuBdLBOVw0t4vM9fHFM4wRxhOz/rRA1woD8/tNmaolLkti?=
 =?us-ascii?Q?vnHxf2ktDAqUm0V1r149/GdwzOCdJdVqZ3TcCBqSx7XOn7ft/xFYR00MIEFv?=
 =?us-ascii?Q?2hNCM6ey2e63bQavxQcMS4yOjAh+veMCQTwah+FbrFMYLtmlUWOZkSI2hwH3?=
 =?us-ascii?Q?K/7jTFcyaHL1wqiOQyQPEFxXYSPNA0DCNhO5IJzca+ELsioFW5v5lrjoJCpM?=
 =?us-ascii?Q?NsUwZgfeRYWcIV86DilnqpXE/DY/8bDPSs0KacuA8Osj+rGBWR+jRvWTAgrH?=
 =?us-ascii?Q?Z3ypEfxWoAmOpGjXZKNkpuWFXuY2BLEYsUIur57pFyJH7Zm3qhcCWXXBgHqm?=
 =?us-ascii?Q?Zq+kdGqy6wDHxSHQgyVjSeQ0Eo5Ewow9gF3wfRekyTb+bxAXICv3zjtXZoj6?=
 =?us-ascii?Q?uMUmUsOVu1Oc1autw2MvyjGQTa3vjW9xtKix6RtugyDu40hc4QL7jP4xbrxV?=
 =?us-ascii?Q?2H8FSqgVT7emEML9CxWNYrvmJSkr3tv0l7tEYFTCz2dH7doVHwIB7RSEcvOL?=
 =?us-ascii?Q?MDb26YxXVG+/tqZe0Sb9jCzd0QSxdlts9FIkCT5VyYXLBAqDaWMqMGWzwnn4?=
 =?us-ascii?Q?thcWRtMWfubXv49Rj4wAZACZPa0mW3ViCoZ77lYaXjcu/oOzfceGcD4F65mu?=
 =?us-ascii?Q?eKdmkmNAB26b20SZgNktOvqThNEYAjPDe1maNOgrDH7k5kADS8dhbd+n836B?=
 =?us-ascii?Q?EBVGJoWCbHuENINrENTLHAI3j7CycuL3Zf6dw8CoH+zJC3N3y50qYPi5VVe5?=
 =?us-ascii?Q?9ZsXmn3yWqvuZAv7mK2vpSokOfW+xGrCUd5eUPRMr/vbDxv6ZCpl1c2N+B+X?=
 =?us-ascii?Q?UGSpNih5XHwdR8PT38S/VxusYQA5ZCYrDeeFiQuL06qhpQaxcHrDD50BqxkU?=
 =?us-ascii?Q?jSV3HlwfbFxZrGaHK99ml4gePY3IKXmV7yWD5LhopNxEH7Ib3NbD1XSojQ1u?=
 =?us-ascii?Q?/L2uajiutFVSSk03ciKThp7KXtng4aZqke9V5Nhy4aSxwDxJOHObjzBDyjJA?=
 =?us-ascii?Q?JQGsjVDvWiUtafZefOyw6jbsbIs3L3ex/nCkBC2A5oqXeEla/mgnl0a5vAgg?=
 =?us-ascii?Q?fgQmUtzMM37QQ7ZKOchxX6tq5Ye/CYG4RtpqH14BBbJ8AirdvDLFJd4iSdQr?=
 =?us-ascii?Q?/7wZF8GgNMM704cwU1PfgxJXBQg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:28.1929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb655cb-0456-4eb9-eea1-08de5caf03a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

From: Vidya Sagar <vidyas@nvidia.com>

PERST# and CLKREQ# pinctrl settings should be applied for both root port
and endpoint mode. Move pinctrl_pm_select_default_state() function call
from root port specific configuration function to probe().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0b8c1a7ca232..04ff211deaea 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1645,12 +1645,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2106,6 +2100,19 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0) {
+		const char *level = KERN_ERR;
+
+		if (ret == -EPROBE_DEFER)
+			level = KERN_DEBUG;
+
+		dev_printk(level, dev,
+			   "Failed to configure sideband pins: %d\n",
+			   ret);
+		return ret;
+	}
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.34.1

