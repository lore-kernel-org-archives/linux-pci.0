Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C763F4105;
	Wed, 23 Sep 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148209; cv=fail; b=JrRqQ+aD7QkoAU6Rh4qPLrpxqgFvGsw24mxLlxY2uekjFnYbu75F636bLbVEpN1JnX352pgrkRsR1BLfNZGKCKS9rHA7ZGzbHtQp5zhYGKlIY5zdj/sW8CkYG3kTIgFjXNSJfjdmk7OcGA+3l2MTmDm6Ud/zN0EcRTCCP44M7ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148209; c=relaxed/simple;
	bh=loA+4jXit5EkuM5vxWz3ssNIfSFj0fdNX9LaUvdaCrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMX/0tgPNSgrocnjvERxxkKdzcnDZGHKR19a8/s3Ao9TK2v4/7bcdTkJfNBB5pX/4TdpQOHh0hHamV9OTa/V9owtSRBznci5Qo9DFeHP5Cx4XhKBaJF+X0ALID1kIcAYlxv/VgfXzNxastpFwY+1tMul/wA/dCKVDOs2reUxiCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f871odsQ; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f871odsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5lBMgK7HivmHmjB2AimcSBjHKbE6ZO4NU38c3I3LHqXq5mE45eDfHn7/SU2N7+3HprSTMt4WT5B/lc/FOthA0mHOytwX343RkR/tJ/2vY4gcsCQy2o7YVl3z6A5ReQozPHyMACvDNUMnQQLwFz1HYWnggpxBWUejCkhdM37/AYJE2uVKQM43jcBZ88i3s50/rs25K4gNgatdvt5P/lPaqwLCCxadhr5f+EV4/XXx2E44EgElKu5dL9e2/v3tbWHR1RlZTpbZvGSnF6WLaAsFaZiVx4HwlXqwv36x53nCYpNqvyaBl7qt47BqAq/qHXWBrUWXli5s3B4ST0GKqdzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWEmFjSf/slJOgitbNIUQNRTAuHpAzGOMMbiis9qKco=;
 b=tslNu3HOAeXieaOz7h77FRxQkQqYsIaSuxOS6PND/lu62fY7wmPEaoH7dLfnT6jokUaMRe23XKcDDj/n3kzmNAQJ8eZ6CtJOIRGbDfr2NpcOM9fKWzID6orzQn6Jik9EWJk/ZTZwvsP8wunuzTjBloJRlKxO2Ai4VbZT7D1rE3wRklWTrpPM+AzHiujbI0cooIX8YeaZzHvQxYaZzRMoEg/1+wuhzgUIZPInlj1eRdWhZCyhUugRRnDJsSs5N2rztKUbMLEOuAyLjbeEJYZdFstWGn+Wd/1et8BNIMhug8eUMXzTZMsDN8pY93kwcj75zyh7KI/upSDADoo5vP7c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWEmFjSf/slJOgitbNIUQNRTAuHpAzGOMMbiis9qKco=;
 b=f871odsQZx5rx7iI1cvIegjwCvArn9mJDomHQk52b/ESLDX9HHzB3jUsuhK/PUimNcise0SmmEHEorkh5O/bZyfCY7Sj7GH9imnim6zDGw8BSS/52XVL8Ah2R7JYkqxm+pTPkdAvDCVivmpihO5zeuS1Gs34f7N5vwmORQP3AN8hEvS5RKKZ5X20YRxB/hY1RHTcme5Gq/9bsXIZV8eCtR4YddCvPgAy+rAxp4iJbGhfn3iVwAu8S0wIyRr9Mqrme2/ZCLeTLim2VfpRl4enhMPvE1i1OdvNWE38vPMF+2lz7YF4tfMBBql93xZ2Y/4nPLvM9p6x71R2HUYFvdzMjw==
Received: from PH8PR02CA0042.namprd02.prod.outlook.com (2603:10b6:510:2da::31)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 07:23:18 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::9) by PH8PR02CA0042.outlook.office365.com
 (2603:10b6:510:2da::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:23:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:02 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:22:56 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>, Marco Crivellari <marco.crivellari@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 01/11] PCI: tegra194: Propagate REFCLK select GPIO errors
Date: Wed, 23 Sep 2026 12:52:27 +0530
Message-ID: <20260923072237.1139013-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 39631d20-16f3-48fe-343f-08df194389db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|7416014|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iIjcZUQ/IaaLDdQi5cNo3iCzn/7sD/QgcNpUc4Y43AXOfSUEX9Ds7oVHTQXDqioFqFKbmvtYnR6fvuABQEWvET4cAEXjonDh4736kyq7dZzENiPczI+2K0+MoDFlpn5VaDrnh3tGPtHxxWeMCB7XFu56Jlp01L3Va8Ytt6vqcNss2a4Li0pECSN5xwhLnQS7EUSbrgrWuR3ZEOCiR61hvoImBGLVhYLcrQp08pqhGuPqthG1BCfvLQgAzeLk0PngwQfyOjqVCfULHkwM0swwYGVRU4ti1jq7bzafHt/vbPig8f7iKyk4DSfMxB8gENA8Rf/tZASVIAt13p8rvSekyvilS/SMrlQK1tlSbMSVoAgFTEOSKxttC8D+BrSmTaUY1WlKiRkatGs9TWeQLOS35OOWxaIAn+2hZLDAN4CjzpFAFgJ+biiUaIEigsOCDuec5+9Ha0XOI3OrDvmg9kcd6svvBRukKPBpkTBnJZVFX2eqX2epJMM2mrfeAbhX0kArDjIwXJokc4iN1N4eTVToEd62odvAb3gfc0xTeLzC+T+WVWDmBMU99a2v8ZpUH3O+mJYsTAuUmjs4zPKFxl2X/EGKXW+/EG7PRTTH2P/2NVV6DkyQn7nHxvmA0ov3ao6oHo1HxVxhgiusjNiaabbv4JkbDjVzWa5kwScDkXD4JrlLnETZVzASwHdWnhjTm7Gm6azsKKpujImwZzX6s6ug9w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lP/qpIoVEAsfy2jRaV299q1Qc8hQ5rBgC8MpV/3FBUbTxeKBBmEC2eg6rtU+IL6fxWBYhAT7+w9W6Ryn1K+5NhrwTjoDwiH+NzXYn8GCb8EArsXc/jJQTAoC4+Ndji/ePq3C9MDhypv7cnD7qZOHjp/+rbCQqzeymrpIgqI0z5dr+ZFu/sBvkg6An3/yMC2rCeF9VC/zPyxNESUYZ/ue3pP2IXz5jAA0jiFjp1kM9/9LQrz+YHZF4a0/qPVUx7Ez+f9tpvSFnv5F/aZujh0TFzMEnW30pIcJDXLpoR/TYbeH9m/nAyir3cZTp7s2rKqjEdWXkmr52oyk4TSA+cWqHoX1uRTTvLDboWBZrfpSyfqwKlK5t/bogdpdb1gXkqiNhTtE4XL2Y4q0pRYDGmvrTiVy8XNW82W38VZMlfTYKjtStPK+jLX6fC9fVvwmq8WW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:17.4987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39631d20-16f3-48fe-343f-08df194389db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

devm_gpiod_get_optional() returns NULL only when the optional GPIO is
absent. Other error pointers, including -EPROBE_DEFER, describe real
failures and should not be converted to NULL.

Return dev_err_probe() errors for nvidia,refclk-select so probe does not
continue without a GPIO that exists but is not ready or could not be
requested.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2462da8664e0..f2b75bf49a12 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1206,18 +1206,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
 							     "nvidia,refclk-select",
 							     GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
-		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
-		const char *level = KERN_ERR;
-
-		if (err == -EPROBE_DEFER)
-			level = KERN_DEBUG;
-
-		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
-			   err);
-		pcie->pex_refclk_sel_gpiod = NULL;
-	}
+	if (IS_ERR(pcie->pex_refclk_sel_gpiod))
+		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_refclk_sel_gpiod),
+				     "Failed to get REFCLK select GPIO\n");
 
 	return 0;
 }
-- 
2.34.1

