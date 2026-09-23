Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775A3E1204;
	Wed, 23 Sep 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148221; cv=fail; b=rnQFHsSqNbmzvV22TMdQvW9zX4Z2BhtZ730HeT6l72xIzPIKLMZ/AjBT36AZXX/u8QL5/eJvwfTs7kviuaZ7xRsFz5iPDLrs9wBzo0FYhIq5wmH59stAxBDTCLgoAphjDIexaG2npMGYocRGSZX3ykCv7A3CqlebhROd+4Rq970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148221; c=relaxed/simple;
	bh=2UqgtWpRRREJgTnuM+5y7c/XBaaJi/7i18cQsewkby4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIJdz8GhreVjn9J8z1OiiRxsc16FO2rHROu0TJSSwXGMg5RrcbbE7Cs2jcyqekk9ZCtOKz0yP3c3M2+5CAzp0RSs189rvtNkuFYTbUfTt1ZTdom2BO0hw8rCtuRSLmouVRT9lipQuAQdH7HhKUMypjYGNcjduxBzxXk33xgUhNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elHW6r9m; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elHW6r9m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+Zz4O6LsgGmzAUdHLgbVJdjeZuWRgbFC8m0OXUEAaFkrVt8iu5lERgpvxHnCBW8qi9gNeE5EjUKekYL9dBCsNDkrBe13QmAXaD8CC8E/sQcWpXFnQJivyc6M0aiMh1nlBeJJcLyuXFpC1CTBpw2nzX25fRng8R2BXZDxDX6NmvCYYGmtuiFttEkuA2D4aq3brSl1WBsFblambvtFnwYd2u5zxbNnhAzirpM9wlnBV7AlVgY/w6DXm/9GDsfWccVtZxpPEb6OnunN4TdOapaxchkWOcMesxmPLdfMLsMl0DmOI3h6e/E4osbtf/NdLzKw27nk3vh+5HzOfWhyZ93EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl3ZGGLTbdjr1vJtvChNgzufuzLyAiPINMtrJAZU2uc=;
 b=JHvHjSn2JUIk0iHToEJr0mZ8c+zjaPWHAI7yrqiGxn88Ow0OFl6GGyt2I96mWa0ohTxtC4FGyuY+RReKAeocSlc4oC3ygMiY7HkooMut+F7FQNQj1kaMkP52ULE8nDVdInADSJhIrSI0s5WS+jrvaUbFIs9Ihsl4UJrOJE6B8U2Gd+bZC5TNB/72Ze7S1SOzfoQcC/RVFcn12aaGCl/nBiEbmayOQ9GMdGtWCwOjuz2P3vb1/7QMPE5YcIHY8wP06BNWTR8jA12OpwfjGOAynzZJdauz4X5stMa9JWWAgK9qQAlZPA8gsERwyXUKiw8bnM1zPskg+s1b0mHt1qP2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl3ZGGLTbdjr1vJtvChNgzufuzLyAiPINMtrJAZU2uc=;
 b=elHW6r9m9lfzGMcaNL9gBMiQ649lNmPp1Cf7pR27R07mjmZGmhKsbdzwWfBS0yOes7I0Exs5exYbFBhOduqrrifx7w7FVMRKr74DNpR/QMfJVbbDS0zrhAB43DtZfDuLjyLXrDz3p1HvLrOYKnF32Yoz+mHFnDdtBOsP/PtZr0gt5FBEqZzzXV6x80WhA7YdsnaUGwtOUfnfAVWkThkUvCI2b4grLHawoddBqO3ForqbELqKWTk23aTFOhuyxPf69rexvN9R/BrhvhzqGu0+nxAiHOdoslPIgoatUDvWsT9GDBmYa1YZNBrcUUFHwfXaNFBZMajkCAiR6+XF0UWZng==
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:23:28 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::41) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 23 Sep 2026 07:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:18 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:13 -0700
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
Subject: [PATCH 04/11] PCI: tegra194: Do not skip no-link Root Port remove cleanup
Date: Wed, 23 Sep 2026 12:52:30 +0530
Message-ID: <20260923072237.1139013-5-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: baae6aa8-3c34-493c-8921-08df19439065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	42OwqGNf2hjCiLX1byr5jMqafKIdOBarX4gx1HzkmAtjuNMaW1xYsNxEHIbgzlPy811esPUsop9Hq9QLjuEYMsUx1SnqP7mfKJ4+W9RII+Y9JY+oItW27tvHBErAbmaTPk6/ju6CHpuT3Bdo7K2sOmG+fEP8DC3XpsNsfcrLOR8jhS0QqiRPcg1HuVLTLp/Lj7DacYjvVTyNT9gdk48SRH+/ZdRAQtmgndfrpisRHtj3sZ+YLjETKi81fmSQT1zL24hY4D6zhQtw8KJWfuRwCYK29QbcuTTTKwTsGRD2VetSA1pD6TtWjQPDBJF9De25J98znrqEUqT2ebp85N/mNdkPN+3bX3hMvh34fFkwgCd5lkBg6lQCzasJdp1n1Ge69TNkaBS5Ln2cWfouyPxfjMSVT4AeQrktT83OI1lhibgYZuQ2JA8HmVNC/P8SPnRYov/Ztt6fEgWqEdJo65Y3lNm7OQ3tvOnGZZ1axrN+5LxzhI3F4bzuSIld1ggGqolMJxiQP0Xb7EuwnjwY36CLa4HbDfhmEWmaecNn4oqAUc6pMV0ZgdJil500Po5h1tFdVTvRCC/2E5DGhXFIm1Hq0/u3taVFTBI0LOa8ihQzO4vzMtL4G5u3HJeBKPv7B31pgE7oDxnE2fMlnZ+uHZK/w7+o9xn4vh9U94ZzBESPnTb76NsS8w9cvkcs6MA+Wem65ysMthcMxWomalGIR5pTsQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zZxvVS1aNj9RrAikaZHEfgV6P957j1KLn1mTyu6SPBEuyZZpJvgmZ4Ybr8FvG6EyhIDe7xmlMCvcKFsxyq9X6+YkwE1Y2cZ9K6d7g46mRDpvxidKVfnjOv10F/tP/pStfQ0xsa3Bptlv/dnmiTeZ/hLoU4PCvAcgVF8vc3hk9JiSt+rwaXNOtH9PjPX9T9UNao9KnSCfhncL6aR7iMX6VN7TP+rPXyKTogoo3m8u9KszPBW/lfZnzrZ+2/zTUt7KaCyI8gTlxHKaZImNtMyedHmNPeGUyxL4xai7ZOe2GSDqL7BMf6ndf+05W6cJ6qIBGcbrqzEml8vBaIfpUPDZz5goDIHznH8dYwkMmDpR07UWhIQX4y8eEw5v4UzUjSQTpXfSRtBFqbR+xdsjwnnrP96tzjS0X7AVRVt3EGqyRn1tmoW1f+advogIt4uiO5Uq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:28.5600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baae6aa8-3c34-493c-8921-08df19439065
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852

tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
when link training fails, then probe treats -ENOMEDIUM as success so the
driver can remain bound without a link.

remove() returned immediately when the Root Port link was down. That skips
common cleanup such as tegra_bpmp_put() and deasserting the refclk-select
GPIO. Keep link-dependent controller teardown conditional, but always run
common remove cleanup.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b91073a6305a..aa47052a37cf 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2352,19 +2352,19 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
-		if (!pcie->link_state)
-			return;
-
-		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_deinit_controller(pcie);
-		pm_runtime_put_sync(pcie->dev);
+		if (pcie->link_state) {
+			debugfs_remove_recursive(pcie->debugfs);
+			tegra_pcie_deinit_controller(pcie);
+			pm_runtime_put_sync(pcie->dev);
+			pm_runtime_disable(pcie->dev);
+		}
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
 		dw_pcie_ep_deinit(ep);
+		pm_runtime_disable(pcie->dev);
 	}
 
-	pm_runtime_disable(pcie->dev);
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
-- 
2.34.1

