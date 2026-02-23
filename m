Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F434366DD7;
	Mon, 23 Feb 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872188; cv=fail; b=WZLEjfgFeeg3QvyJ2w/ZvBBymxcrYYol4vCA4em/zveuz1q1iWZ0JqtV7ZYplCxg0jeLKmzEKuaGXb7YN2UNb7wkuVY5MjjE4BCOpaNsBZgIXWCxYqS/nvlwVkKfftdZh1K7snmiPkfuXZQW+XortDezXQdtadh/my0ceSt0xO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872188; c=relaxed/simple;
	bh=xEOWVjag7iOR+szDhXZ0BlAug4c9C4nVN12AyzpRD1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loBt3QzuleO18wWpE9vYLKhllQCTXW7Bel0I9Bs4YLagcHgPUmIH69KZOmufDWTFufuc2IojNdVMWFjM04l3QKTwQ39zxnGUFgIQ9/jsESM50NWHjmY/RAOEQPhSO4JS2m3dy/eHwtxfB2SETM71GvsJqzGEsLxJJnNboI8xsjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Be8FHmoq; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Be8FHmoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoobNk8UdxRrpJ5k3JcWxR8G2yyBGGTo4dA3hNcMtLODcHQr4uowOD/Py7Kxpkjtu3WybegA+7rqkCgxQS7/tOluZTP5UnUNeRao8dktJkYZDsLvam0BcavSHCR6G5d4Dvj6KS1YAaP2E3l6Le/C+dwww1MVcWt0hkXw9zre8UUm2oWVD/SyeRVFUPdrTcipSVxxyqDZ9Db+XOBZrMCmiBt2lbM873hohRzkiT7TM6+4+cMnKEAbslJpFM/U/jdt0DhTfn3lhF+nQwrhYrBhwoves8FXcqTYsFa+BlCzyLRyH0e9XyesHC/H4oU0f8o9CL2kaDgcTyZ0K5cpu5Qu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcqOz2xmEqrKJAe3x7aFl+P7tRdeLla9mauds+SAZ+Y=;
 b=ynGBzQvE8kg1JhsEQYMBIqx1SJEGvLW83lHs4FlU5R44XEgLIHzFwGhCQI4ivBLh/2UsCTxsjLtVVIQkp3wsBUH6mac2Z15HDUB0HlywSKoxvL5oGcVvhfvOzGtxenpl2H/it2b/rL/+4Ro6rm0P4ohA326v4dwP/PvB0vPQoCRiuqQ3whGkGz1BFCigjnXbKPyibe9ld4TfEW2SWZ/tmyOrmGfCW+HOwPFZ06qVc63529zwbIp6Lx4nQgnROJBsPczu6xmM0eoQdQT6MljrjgMIkZaRr4E+pmji2sA8X0BrTYjT+iSb4jJJQMu4Joio59ieiI02o//egD9lzF/Jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcqOz2xmEqrKJAe3x7aFl+P7tRdeLla9mauds+SAZ+Y=;
 b=Be8FHmoqnstk9jN1bZWhywf2RT2mKT3pwNWQ1dvKAXFZ0q9PllONNcC0bFldVWhcnLGg5sgKn/u3HPt+yNPjz5oldZB0zXz/rzDhepm1mdnLD+i6XI8A9kJbGy3nIR7Mih0irMl+RkMDZAVUAflZ0RdHPI7+O7XSZnK1lSMX5HQXDpHduPkWr3XHnOfwFDqGSzIQbyyeB3QU5CsDjrtmd1CCM9i57pJ8n187gE4PJk1ATtThNbzqgvi3fE7F9LweeUXQMdquK3eLXERD6y9vLIM50xXGur29SeOHEckIXAeBr1UO3Gs2fxjU+qKhiMK8MwZpBipb8amSV7M1nPzBBw==
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:02 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::5d) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:31 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:24 -0800
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
Subject: [PATCH v6 02/13] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date: Tue, 24 Feb 2026 00:11:40 +0530
Message-ID: <20260223184151.3083221-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 87014d1a-6a25-446b-34da-08de730b6002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILhnIp/7WpCOeTjEKkOX3g/OYaauMu4hJIG7VmbEZ2Zy5HD3xciyNt6MHKRz?=
 =?us-ascii?Q?T/zR8gygL0YDIbjAPTS+x6fSdc1zeSOyMVC+Ek9muTCVHfIYGF9Odz0eZg5q?=
 =?us-ascii?Q?2ScEsI9YDLId9Dkoyp6ZCxLws6P2wEGWMGQwKoqezgMkxgHRXpSwq85Vqsz9?=
 =?us-ascii?Q?5iE/4ewqzLbm7W9vprFawys6dntS9bXYdZ3P1hMt7jPnOLrsbAfxArN6JXBK?=
 =?us-ascii?Q?UWnKyds2FI4ZeA1eh8gvCwduJy6dcFjYeD5OdpTrHZZ3N0yBSuGFz6BFsFmI?=
 =?us-ascii?Q?gLIvZylZ63YqFvCzmsbRjuUwBSLZnDN9S0YV0ZDt2oiTVVNZGvQsADpIssFB?=
 =?us-ascii?Q?C7viaF4VxLy3XXja1JDsw8smE/SyTtqg0pmGKkqOvLGwEKnMsy2rIONFR9a+?=
 =?us-ascii?Q?dug3LuDuMWY5OucZ2laxvjSqqEau4VO5Bquuf2ZXweraXCy6kxCX0TL04ODI?=
 =?us-ascii?Q?mWC3QxWufmyioWbdA0Yc7d2jG7RQyMfVYiLULiWM+CCrxt4wlDTIPSVLcye/?=
 =?us-ascii?Q?lXxQ1T+3EdyW6pwYY80De86sgl7RQSEGnEtT4Qrf/pcxFyWuODcQvLTl26yG?=
 =?us-ascii?Q?kesT+pu5PsqeRRWYfssi+wY/vuiSxIvB/awfUsEveRZsDgdJ/UGFt6aqOX+i?=
 =?us-ascii?Q?L4eUYjm/x7uD+TNNob4DahLWDw5YesSTpCF+Iuso2DMTJGFETcxCevyOZvHf?=
 =?us-ascii?Q?Ea+qPI8vRUTNQ0LM0Iprx2Msc7HwHufI+YhiCnKJScfbssVM6Hsvid3pnGb8?=
 =?us-ascii?Q?KV94ab9/EfiztD6ogsQeuJ4m7ryVYMuq+3NYS7d/cYsPtDLtH3/GPMksgm8M?=
 =?us-ascii?Q?6RkReWj3aVtuzNw3ybwbGqP8GJ3eEYMnMZHmEpIvf9CWUyrL0/N67y6aEDt0?=
 =?us-ascii?Q?aWyLzfv/QJx70S2EGtvWfKP+60ADlNkeHOqNxudyXD9e34d/j0zx9u1BTXLp?=
 =?us-ascii?Q?F6duH+ExNiMYaSTaz7HSm/gtO2SoJlqcC12mG2LYuhow8slLVcRdasLqjqK1?=
 =?us-ascii?Q?GkAJFwE1hv3YNM1DXNBK2THn5OL0ccxpJuRxFp7JXRW5ZJ9L39gW8/Luniiy?=
 =?us-ascii?Q?kAIkGBzKbxs1d/ekhkPipQLCDlDeqTtbYE0DpK29kQfj8WWULp0ueVFJSIVA?=
 =?us-ascii?Q?TClXnAyI8yoYhqm87efjRW9zki2QY6WmZgIdSOyUMQDCgHq7kGkommiG1K3I?=
 =?us-ascii?Q?DmzakG6LIu6TGluXR7VH4q/qlCoXoeZUTZaEkPiw3Jtsgdabg7/maWdvw0ac?=
 =?us-ascii?Q?TRwi0WCNCBH4zh9EBGlvoETJBT7bmW55Deo/3ONyUzp2AgEjRC1/WRB8w3cZ?=
 =?us-ascii?Q?vOzDRL8oh45XAqmkITOGaKwKwAtV924Sm8SD2y0TfW2XpBOR8XNONmUUD95M?=
 =?us-ascii?Q?mku3vw5zI+7oHR1XDqqAb+KDGWEKlgmUjjrFsN6C+oT/uoHnq2UgrrUiS4eu?=
 =?us-ascii?Q?9v7iJHb5bg8+2HUQqQaDZIBQ0GZdZRUhQomaaHMwVzKGBV14yRYHdIpTp19E?=
 =?us-ascii?Q?hdNgMlrGKcMacLD97VPa+Bh/kHtV8EZKy3SvfPZYIT/84SfF6U5jjPXcppQp?=
 =?us-ascii?Q?f484V9s+4kE63r/XjTAmkxOpvAbQxyKuk3I3acS65FuhoABQX7zCLpAL7FlU?=
 =?us-ascii?Q?Sf0hPX+KgtnBp7Wgvi/v/T2XYZk/HwIxoPk361WSuhvY8evO2+DifyrbPxkT?=
 =?us-ascii?Q?wVcbsX5Y84aVLaB6dW/s5b4lDBs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mLO7xZH436hudLbZ0WwEbphmIAGvtQtaM+pi7LrVLiV167OYokEHzzKglSUKKmam7B8ZeaWm14onWLPvLnztxyezHsvlxiIBWso2rBTAvTF6JfZ6etY+uuZw7omS6yc3dXrYRXz+gimkboKfujIVzqlM2d3h0RQuUvz2jEJd21FvCzZnIQCRXSZWXYn9dhqobGJGeYbMonpB7dVU7vYLKQYp8khm0YhroIe4Oz6eymttXN3k8dV21iazVKBuyTxlqGkof1EipJjlAhF2rbcEadFRgzen/ZTEeY4LZrBRvkFB3VP+JsydFF24+Yie16dMoCxQOy0n6cvV/S5EPWQOqkiDhwWClNd/9FQD4Fzf6h9OsbCXMRqahjOuqQjJZfxvKwRNzCCWdZDoQ1YGozrQGL0W0w1ZTMh1y+dbmaLCyu3l/qO4JfpLRmp44tEF6zkD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:02.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87014d1a-6a25-446b-34da-08de730b6002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

From: Vidya Sagar <vidyas@nvidia.com>

On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
and Recovery.RcvrSpeed transit times are 24 msec and 48 msec respectively.
So, the total time taken to transit from L0 to detect state is ~96 msec.
Hence, increase the poll time to 120 msec.

Disable the LTSSM state after it transits to detect to avoid LTSSM
toggling between polling and detect states.

tegra_pcie_dw_pme_turnoff() function is called in non-atomic context
only, so use the non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V6: Retain only one fixes tag
Changes V1 -> V5: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 96d38571a7e7..4ac6b1cea13f 100644
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
@@ -201,7 +205,8 @@
 #define PME_ACK_DELAY		100   /* 100 us */
 #define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY		10000	/* 10 ms */
+#define LTSSM_TIMEOUT		120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1591,23 +1596,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY, LTSSM_TIMEOUT);
+		if (err)
+			dev_info(pcie->dev, "Link didn't go to detect state\n");
+
 		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
 		 */
 		data = readl(pcie->appl_base + APPL_CTRL);
 		data &= ~APPL_CTRL_LTSSM_EN;
 		writel(data, pcie->appl_base + APPL_CTRL);
-
-		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
-						data,
-						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
-		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1681,19 +1685,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY, LTSSM_TIMEOUT);
+	if (ret)
+		dev_err(pcie->dev, "LTSSM state: 0x%x timeout: %d\n", val, ret);
+
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
 	val = appl_readl(pcie, APPL_CTRL);
 	val &= ~APPL_CTRL_LTSSM_EN;
 	appl_writel(pcie, val, APPL_CTRL);
 
-	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
-				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-				 LTSSM_STATE_PRE_DETECT,
-				 1, LTSSM_TIMEOUT);
-	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
-
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);
-- 
2.34.1

