Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563281;
	b=UMKW/wd45KEHiK0Rvxe0JEA1A2ClHcCwEHFGzhxxvjoHlIIczxp2oVb1LlUp4yIto1HJ
	 sMus+vPDYVsaMyvsKzXJEWP2ibjlWGhxN2scba908xyT07eQLfr3pUOMQgZk7UW9o2xqz
	 zkRtNqfB0bAYjmR0i9mX0l1cUgUWAfvpCe9lgtTYeWKLiFKrFu6mZVGFBJ+xJXCoU3ycV
	 xzhGVNB+rBS/hhju6+OEgkncE0z9beBDJxJir0xA/i39v7u6BzFKHzzq1rc9FS4Sy6Sxs
	 TTHT1Nz2U3v8gpQTTpqZEfqClSII+w2AJQNnW9JuWe5oT0yfwA1qm0DUKkwuDDyQ8/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DFglQVB2I1WeCAmcAU1S5dQNMBLYQl+UnvNwZBlMLpg=;
	b=5kAbTuQF1iuiVJjC5nA+U9IPtrcvuUgYvEQSBhfvgOX0ZRvjtx1JSO1BrzWso/mCuPcp
	 wOuJWSi5adJLblR0GSJKYYZzuxbsOAUslf+dusQkU9G7iUVh5Zo5dPlHlAygVtl8XZrQw
	 2JItwT+ThAP5t1gFjLKRe0vNiMJXwODTHi9BRV82WQj99onuLWvcgIEo4TcPmECvnCU2m
	 7RVnSIpbUTeQOQveq19cCSJ24GRZDjZnd3qYLPu6FzN/TOH3bZTuafYQIjUdlc49RL6bZ
	 aBS6eF2qdXSJhM5rsJAXIeDGGZd5NfS3uROGEQ6t11FH28jjZKpcobz+NqKJmNzj6iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d1kUDU0F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.69
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DA606A326;
	Wed, 21 Oct 2026 06:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d1kUDU0F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKl7nToxOvi6vnNMsT2Wvotq3+N7F+bVAnOjw+LZZKos5zwDddq3tYnsmLi8ynVmJT6H5Kj+Uj0lPpZT9etApyaeEhvTAGUE+OXnd5A6L33FaX78hfNHxi2F2UTYWlDYmHEgL/2CmuC5SxTavna3rLo0wn2vTTiJzYG+zt3F0L0TuqrWgD51JmCr6xIkGmxKhH4skCz+EQzqoZx5vF93ZFipNKjOjKvBxKS/fs0wkTN9i9lwlHSST6+kwCgcS1oLyi+ai8/9s/+3hmqzOy7FQ03c5nf7IzFHNxAN+BMZRngtZFnEwV/onUVJCEVefHrbxKD65aBNVhWD4JUgGdwx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFglQVB2I1WeCAmcAU1S5dQNMBLYQl+UnvNwZBlMLpg=;
 b=Pz0af/UVIBU4V6DpuNQTy0uhGon51+SUm8M6/I4atN4IBbaukVNWP5RyVh10gn9k7ukDKeEFYwmu9evpdse4IC9TaJt6SN/+Q4zj60OG1BXY4hQiZS/FFrxckSjmJpK9teAJzjA+x5nlTNRq/yY8jjAC43oXXVUrRisvPx84y8hGwTX3ilbYmaC+CrxWrrAY8zFM58j1mGa/5oDMFLpH71h1biFAHUlbUnHXhaHCnDDQWAjg4dUnQ1dGoiUi8f1mgqPcDgk/40HeMfAkpr/rpGyNtPARWsiMsHn3mQzYtcvXTigTW/yQvQ072I/lR0kGIPLgfSxscUFlDDrzqKT4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFglQVB2I1WeCAmcAU1S5dQNMBLYQl+UnvNwZBlMLpg=;
 b=d1kUDU0FheZb85tEOZnRPmvy7DAS2iT5i9N9Jm4cYc0dVSUHEDLCuME8L87BjLhSKxSJFZit/alKNeuoesO2xfKVAy86sH/3dd2MleBVyjJ27mXLK8RkNakNk3UJ+KSjui3WBjnGkeqLEs+olYVr4vvOW7SCwReGbxK+A8EwkWv3PjStBfkDiiL5a88r9UmEELK/dJQJeXNOWsKBKNj+l7ifiv4QBYaLB9TgXagVdYynw2jYfxVgMNzD59XOGLtjrwcN7quGAVB67BjUg3iPKGO9PZ8RX4/v/25Go5vu4BtqR7qkvaYMiO11KoOWvaJlGL1hlpHXhds5Oa+/L+PjDw==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:14:37 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::67) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 06:14:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:20 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:14 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 02/10] PCI: tegra194: Check core reset deassertion
Date: Wed, 21 Oct 2026 11:43:41 +0530
Message-ID: <20261021061349.1265704-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: a02abf95-6cc5-4cce-714e-08df2f3a953a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	syLXibJLqwUkHlAQwbns3njjbgX8IUmYJr6URa7Ibl4gdZ4qbioYD8iCgw563d0mBd5FuIv3elvoVZ3+39BwZlcTBo92MfBG6TH4WD92pkxiLdUg5fCnHHWshmi4LGqzKNw6vrob5Fg5olxHPWGgKKqnnEs4zG9mf37jsCeZbg2Br5O4FOiVFkbe1HokRjaGiVMuoPVMMPrsobCaAu8GI5Y6Sq3pmTvPX6vwYNHiJI11MzufFp4hUTbYCefB+w5AqJVO7dkMRKg0KscP0mjf8JHx8gI+JBstYwSXUl6SEzsUEr2GTPf5PU1CqqzeFbapS1N3QiyJ3IhxhpIc4kDhIazpBoDlDRs38J4vqvkdN3toBpIg5ZGRtOY5VgVkP9x7T5iwTpUPpb14OFISqVNNFzRD1bqf1pgPoAWLbASWMiaRx5xlfO8In3sxdIz/KxUKGwowTg4CL3SIPmYEcFSmWS1s2+CBJ+Dz4cKRhDFWYwIvcRlfO8LBValSZ3Ub4NG3LzFRLT0Mcu+sqRdC6wIuHumlWcQ0cRAAclQdk0bqQxBstQaZITQ4sK0zM1TtohIfrqAOo6fbSfMi9am5HFXYgvYasQZDe3l3914T+oNSXpJoUYg8RtNzlffZm47n/lFsvA81LSsRkuCXlctrPm4SWJwqLcrmq5jCKW26fG96S0XX2g5TWjrmQelxwn2PHkMfk3kR1YmTTY11kN9/G5f7kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1z2efdJvVSBwTva0iGcbM7sQ7bHdxSDb/38gzTJ1vVjAhSsQAgI6ltT/kob+k4Rth69wfyUGd7kS4iqmiJWWWARZ4Q/fFxiinhg4XelrR55P26085jXeK0o4GU48n8BCvWIO34hHtOUZ7j0LjJakjDrZhSX0pEZVlCR4Z6EvksWYURi8pKBglyqjUl2mknENlbQuNNWNKd3rOeYF3vGqmV13HaRmaMLG6RScujJLrJyqstIT97gGBU6vtOSjjt14mxqQ0eTKxud08AQnhiUZXulYNMR+Gu1bipQizFFIZjILA98hD7JNLhYjby4d+WqRgFNE51Hbwwu2c4Gp7CFwehGLSOCU3NXbZMz1pS00GevVPgZAKhGMevrNgBYOJOptwaqNCPJwmiRqvfT8X9Pmbrwb8CuDMKldRtdO5oIPzqBuPsfb9AxJojMKKMUImb4e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:36.6563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02abf95-6cc5-4cce-714e-08df2f3a953a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

Several paths access DBI registers after deasserting the controller core
reset. If reset_control_deassert() fails, those DBI accesses can trigger a
CBB timeout, or setup can return success with the core still in reset.

Check core reset deassertion in Root Port setup, the DLF retry path and the
Endpoint PERST# deassert path. Unwind before DBI access when deassertion
fails.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6104a22d930e..89dbef83dd9e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -954,6 +954,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
 	u32 val, offset, tmp;
+	int ret;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1009,7 +1010,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		appl_writel(pcie, val, APPL_CTRL);
 
 		reset_control_assert(pcie->core_rst);
-		reset_control_deassert(pcie->core_rst);
+		ret = reset_control_deassert(pcie->core_rst);
+		if (ret) {
+			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
+				ret);
+			return ret;
+		}
 
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
 		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
@@ -1455,10 +1461,16 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
 		    APPL_CFG_IATU_DMA_BASE_ADDR);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	return ret;
 
+fail_core_rst:
+	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
 fail_core_apb_rst:
@@ -1853,7 +1865,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	      LTR_NOSNOOP_MSG_REQ;
 	appl_writel(pcie, val, APPL_LTR_MSG_1);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
@@ -1927,6 +1943,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 fail_init_complete:
 	reset_control_assert(pcie->core_rst);
+fail_core_rst:
 	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
-- 
2.34.1

