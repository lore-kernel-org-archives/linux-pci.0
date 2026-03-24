Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF393BED39;
	Tue, 24 Mar 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379387; cv=fail; b=BHPZRrGQEEGOQT82my0+11z310oG71U32Yh3n6CIJsj7rDRDp4Yr50MkmDpvCs/8bGdOSw1EfHXnd7QkTNXk9jzYkRseKWfXf3PXR7CoRKcVMKgMYzRGae/4BZxvMU5m2c+Fn7XHolyLdtfi1ZFCXK600U8rYQFO0ejtITLAwp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379387; c=relaxed/simple;
	bh=WlyvtuM8u+WTsZSyNvRgd0G9UKkjNQaIaAHRxbJfo18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMDaiYzoxAlMg8P1jE+2U4OXp1lm3No+kaPlgd0dgZpBSl7ZW5485Y0PSdy+KIOh7vWjLcLFQlVr+g4xiqTxlaYM99UcYxLY7wBaBg6xnxMTjrUzhgDOe1dVUyHM8q5wO7P5UdLbAEu0oYLTWHr+Exjb01MRHnHvH4nx4qAux68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQ0hn5e4; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQ0hn5e4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOJj0BgAeZJmWV7mV0aOIi69HoQbkM53f9SWakE/LNrOW5WHB2izExGgjo4cdU+wbmu+8SHIIiCfl9OboHk9m7TU38CWJC971AMU1Au6QJMXm9lc5oPgUipTf8S5vWvdqbgu35KNZ5f5pdMjxbRnZpN5BQF8hIyTAwVMZCDmW7db8dPwa0cw4S13ZS1/9RuPVLMWFvmIoP+HY19kGuNXx/Bh11WJiqI9V1rHIf0rwvNke6namLq98uuaLfOGl3x4AnDl4TqqP39fN2u62HPaqbwjC1DY4NzTmGkU+GSy9CzQ7gASuRKr2LZtJP92Yw+E6VIgJVWYdZ3WsxUI54qTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VQC7jRLiMm5+2iXrj12d7y7yXCgjWHrPJnch9GEheY=;
 b=vRHvXCRVT0pGmWNMg5QiIOcdtr/cuswvJbv8urbIBYZlVYjq+g/duPAjUsZACcGpPb+DpQuRcwIqpkRvlY48E/wDy3Rz2aR3KOvyxvCIFc1vnxenw2Z2mRTF1itY4VAEmxPQ/ovIWwX4Q2kHsWAxuxUr4ad5gCjxtrFmcMOh9yJyfBDIUl9QYmgwvCRDR7NYwDo8fnFA0ZaAi8dgQ/k2JAh8ZSHc5gLnZWkKPRvsNGAxLHqFdpvjwODGi60Frpp4/a22RphG2WLAWb/vBMhX66H30sI8peDA4SBPAU5IUg+csdgcTCyz4HX04uSvOS3nxObbomZ/RVPbShb0dXIDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VQC7jRLiMm5+2iXrj12d7y7yXCgjWHrPJnch9GEheY=;
 b=WQ0hn5e4vsU2VThuf58ZNccvldGPIgUeVzKCD1laSdvIUDRAm0r9m4OKryPd9x4cp5RouP7hXF5GSW/7pxg4JxhVYEx0wTfDwXLo0e4Nrse6nGco8qJ3lHcRM9gYmzLReQNhOLNONTm4/AqkSmSUz7RheCQcFX8ELE6c6NUzo6gpCC+69DrFZuZTobHqiJVdPPb3PBxyosiUMCFY843YidLkMMC0zWZMDgl5+5eAshS/Ua13/BhXRhkd/8wfeYgmGKEfU/JXE7sxObKWZwJMgsOhoYBJP7y6pU4Fnj/Qom33bSs69xASQcXZuZEW2rqqrMF5sIU/A4Etq18PeVnn7g==
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:38 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::c) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:18 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:12 -0700
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
Subject: [PATCH v8 10/14] PCI: tegra194: Free up EP resources during remove()
Date: Wed, 25 Mar 2026 00:37:51 +0530
Message-ID: <20260324190755.1094879-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 675a705e-4df3-41de-c546-08de89d8e50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mPJbXWVMSodXe84/ZpR4n+Sx8Qf9hTNq0qSz4c/2Zpq3GuWac/VwgltSAAIHUFn7xCUXsNAumS9j8qYHDXwg1XJEwsaHs9ux6gQ8CZ+4wjOhZ9V3e7Pjy5O/ajbYEC2jEOstbLWN/kB+3WdYAHqSNJjCHK0DL7x8cLbCcduhrbiJXpEZoJNYgi31JsN0Sv1Smnumgs/lq0EISq5oCFmB6bSG40MfG+SwuiGVo6edlWSgdq5iC1v7r3EJxlqyttLPLtW9V4CqwcgbGzBp/ZPsDaQs83mgjEU7j1eU4d67egr8x3greABlQ4rlQsGclGKq67SHgp9I8XvV+XQ+wP8/CXk/qzXktSwuw2ptRrfQ93OucTcVXnML9ex4XMuXa5Mq04oxlM+M2mZ9MU7/31H8ss437dhjJVIt9ciEpF7hz8ogJUQ9RLH/jG0Nj3IOLkSy1YuhGqEL2SW9P6U2uHOcqEF+bU3R22xy4mLQh+oS9ovGM9MJp8lBA4+GwhpeeE1krGFHlv0T0x9qfPRf2rIYlrJUHxrW7PpmFE49Ui2Wilb/qEPC+KzeoFbiArfgGYIDGUYDx104dgeUugKimjf7IWKDbMOy30MqIIBG3qSMYh0TaVkbP11FA7jhdWGih5Jifcv1DhKdc7SHDqU8SJdF5kBGpFZQXDHuC5LiYkkcAJh46KJNCH7yzMZzgz/0jyvlOtw4/oERJuPhLqkYDSY5vmzCtnvKRAcUaT317EESQ0nfn+5KdF+uXW+qUsHvhB29Uicn/a4Fs8JhLtL5PbS7+E8Job4Hc9OLJxrEAzPXkVjG++6wVRSLSsz5/vPrRwVU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N+1DySPeX6XFiBpWnUPKLQurbLZcyIYoCxqpR47gWc09COhSi0EiihIxetbgUjI4ERM6AHzUwBuHQ0kfgcR10oq9ACJ9XMM2RksyFbiZ7HDde4Sw5MKWc1MLWKHdnyqEl6Cjb6BwZreEv42dIClNJk7iaTDtw1oecz5r3eNI31Jcj3QpxngewyqQT6lGmL9CnTW/CBpr4U5m9ZIaXPnJFwtFl4VJztQX6DyaQ1IqZJ6SO/vnYiTo8r8iqEZ2lsRgPklbzfYFclHCK28nzLjw7Z9owmDxs2/+S3d5FmtAzpW+Tik1GlK71bZGovPo4QkMkn6q50p29UY6+oXOghvn0LKn2zhVWfNG2Ra73wK4tp3vw6rZerJHYNFu8TK/3Z0GobF0x3vqq/3LgA1WNhQhlW5gLpLgy221bIdc9YHqPZj6td8U0qd+UZJU0L0jOFQU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:38.0056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675a705e-4df3-41de-c546-08de89d8e50d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

From: Vidya Sagar <vidyas@nvidia.com>

Free up the resources during remove() that were acquired by the DesignWare
driver for the Endpoint mode during probe().

Fixes: bb617cbd8151 ("PCI: tegra194: Clean up the exit path for Endpoint mode")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V8: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 375eafabcf88..1cc80f3065d5 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2250,6 +2250,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2261,6 +2262,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_deinit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.34.1

