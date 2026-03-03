Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6358347510;
	Tue,  3 Mar 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520947; cv=fail; b=pCAwfloWmmNg8NN9Wa3sVkObpgma9++r7vk6dU42B54Xk9qdwWG8WtdMxUJYj/JLP+B8hwT9AEVmBhrVvD2k5HzX7y/WNNtRDigWSO7vgnXBugeHIVLwv4rL2xQw0G/LXRdDhuHxUvNywpstex/CAkONHpUH9+mbBb3jGCU9DKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520947; c=relaxed/simple;
	bh=8h/LPu4k654wwwYgfy0gfessnWR9Xg/dodcD5CMKuzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFRQRjXeqORuc2M7aLSd8aK7ALUS8dIeJp2s+dH/qQATm4NLHJi7onho+ZS6jYpEpe/ZwVcvZkMYYU+N0FgT8ncON2rCXE/StMirkiz327pGSNdAPtNYCuZs81Kbi4hPcmVnPM5cVtJSA7r1cc7pIdNAAc8mBjVIVOx6TduWjek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpKWNjDr; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpKWNjDr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbRtIX7A/kjTKUi0ZAkzUMjJlUCRBq49+ERvL8qFcrW4i4gAZ9kFuDz9iieZoiJks6CY8JsbHrJZhkkktgRIlaoJzM3L3oLCR/3v/8XzBI+MtQmLthXwUBmNbIEMpB2+Ejso/TzJ+u9U3Ka9Q22QuvdNDADWDPF+izQYtsGhWgsDCjp2eqHPhDuAU7ELUVmxN9ok1geuJJmrNnwlCENNbQ7+l1m8EQ4I5wL2Yza/AwKZstQYGBn/DRBbGPiltYj0EUdBmGKL2gVacnwA6x2rD7ZbWFPM4FPKv0kZDhow88M61Qfz9zn+HvlmPoT6jWKxF6rwjWT4kKGClQ/OkifKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqwBOth+TWBnAgBtZ1DuVXqnpT/+VKOJ8NB0zEv8pjM=;
 b=ij5k9P+SvrXhHwnlpJ22aWH+gy7VK/NJB373qEGG+dddwRnv8vE1AlKG5byuQ7nsOEtFu3+lJQQND9ernZsTRjQ8JD14kIOHb15odbvHhz8jj8JIhekYQfZhYVXbA3HwNGgygiogzof69OSdk0ccRPPm1UnZN/b/Z86GZPSeGVj1C6HHmd0GKpMD8STgZ97NSNCsE3WAlcBeF4+Whc+AwSqy92FLaG0zbPd3/jlEjoaqv43Xd/jiRrkJK4rwMzgutkHVeoS3002YYonBULi5lYxJ78ANGPjBqeKUtNYG76APFLYEgdJ5V/py+4Hw58CEN+pc2b4+0cZHA2pIHpzM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqwBOth+TWBnAgBtZ1DuVXqnpT/+VKOJ8NB0zEv8pjM=;
 b=ZpKWNjDrTL5pJKP3lL2hGjtNLEY/ZlKANiFa5tCfVRetUhD9Bj1ld4XTxKgB2Po22iZiKNpuvO1FT93r/Us1Z37Icp40R3Hi85MQ/XATcU/74ACTQ2bJeDI/ETyoCoGXF9MnMFoDIVUYIf71W0AdVIhIr9f14ZzID/OPj0st+bM8U6JGQg+rwP+KzxKYJQUo9VIm3K7Kri7+exaJjPOi6jIxsMrq2wfD9bJp+lfvnWTAuwtwf5/z6swvsAb2XjEWK0FVveYoQE4l3ALYilB6YWiNkavNnZlFKB9/URaTQwtTizpT4y9vSoBcIlrudosnfm7ZZkj597O2oa+5DGucSQ==
Received: from BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:55:40 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::2f) by BLAPR03CA0048.outlook.office365.com
 (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:55:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:29 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:22 -0800
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
Subject: [PATCH v7 02/13] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date: Tue, 3 Mar 2026 12:24:37 +0530
Message-ID: <20260303065448.2361488-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 939e9aaf-139e-4199-5025-08de78f1e18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	7hHJCtP8D5EGvbJT6eH1qYBCb5hnBFUiqQoMh7LCBymRc7gHHpGcAlq4hilsO0TGMTNELewGh3wuzkjQNpUg1u7wpTx1WCHfddeH9p4yRWvAq4OT6MXXOhLLvm2XyxISwf6lXlS0zQeLIqGvDTYINvqzZgM3rCUP8xENLTgvdsvAloYL7alEzCLWjIdRpCNL38r7U8cQRAqJ8J3TDJiRm+qNI69cD0xVcXOh2qByGK4CEnVzYTqBnbO0SirifklQ0dFp7PmZhtKEJzCyc9kjF06io6dtl6gIOxkgkr6J/LAGpUg3TEYErEP5t1AEEvXJB2+KZBx6xC39xPhGoFUVpaBpFilzZO4kwOIhTFrT6qk/ROVKapf0rcLF08gzuU/bMuKB7YO0WpK2/YloHfw8V/TO8aIlfVly12qt1LSG0jtBSdYjYDZ1T1+equMF8YGjPJx2BriYEF5QQlBThz4JUSPw+E9pgZCAvacZhH8l8GTLobwO/o0Kr9z82+236RjPp7u30IroGhB4ANoCIdVbT13WJ88sqDpZ9C2bIascLlJWr6ABpzveD+2mMOC6bQ3fM8QifHdMvTWEfKt+lA8d2n90GwNwmpex6jTNjLhVAPKuS3sl7naeE0UdVNlHcEytI1XCWAt1EN3uIhOCZ/qxEfN/M61RlIvtJcblr9zM8CtO9/DdjN4F/A89PLpRDgSo/PDFcEX+akTas4giitB329FlclEL0i2l8QFdNaU4o2c3x7796gHEI4OknQ1XRTNDf7FwcsSNwIB1wSBt2CoalXgB6aoBkqMP/Py231eW1ypUrlDICI5smeUAXdoZxLqJPB3DQ4rsUmIY4gatQx+tJb2rtMfLZ3I0mSbsa9aN674=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pko7a+sdgyaVnSVcUHbdtT+086OMr+sha2UUhTcgwXJd+pK02LxhALFHPeKu3oDOUvqPfNuMgRxUZ6js1kjU8muNhxzvOWBzNMS/xvp9ABEr53/TMTkQllgAAvEK0To0FUQqkGk8Y4ZNwC95950zrWrQJJ2ZyHbRixc0wOA569ghXzx37uQpyEIlgVtVHP4Im/6AP7wnDnLb0YPskD021ZmO4WuHlxEv0uQyLRLxXSf9c9f05nqZTPjxYdmc2Q1acH3Zh4V7pxsgwobnSig1Xv42W9ZiQHJxxy3eEATQjTbd1VWdA6ooELfo9GFHFUER2/CAaDqz+5XcvFeMRN523T2Y8yWIdHMpDiZjJGfOJ10RCv2QH2JOb+E9Zxc9voiCEcOXI3vSi530QxK/1J6fY0NMzQclyw0fASZQmfPRu9ZpRhkX2MRZO7nlOTl7SkBg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:55:39.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939e9aaf-139e-4199-5025-08de78f1e18a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

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
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: Append _US to LTSSM macros
Changes V5 -> V6: Retain only one fixes tag
Changes V1 -> V5: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d6c6bd512b51..afbc0bdd8a93 100644
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
 
@@ -1589,23 +1594,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
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
@@ -1679,19 +1683,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
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

