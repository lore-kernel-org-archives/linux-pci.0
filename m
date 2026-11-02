Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618901;
	b=Vk9NZ0OQZl6v/5Yg1HW3vbjBAdjSIIhIwbb5KqnGkN9J2Y2mhukuDn+tEPu9Bju1+Wuf
	 GAZEPD+ZnQI3uU9bQa105Ao+/WQKqYmKCJi0RDtFwPlYtNwJkoN5cSriHCOeEbktEiKRa
	 KhxN5nRZ1A0Bc4PGsgw66R/PKWaqMVaarh6FRNLoP/2scQNgCV6raO5Z0XaH15gRMhnZi
	 tB5HUh6Q39YBSEpsLlmPZTp5R0e8vcdX5i1Y7ozsXwjsQdA9NYTxqu8mx2+ERJsoFJZAx
	 mFxD0f7u8xFIP0V0xaKJNQRzZpOCFrkMoXPoQ9KZZAXhJHTZP81qkOoAQxwZgnF5CmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618901;
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
	bh=Y1yRdfZi5q9QqZRowR/KikC9/ifFEdo6eYqd4dymKcc=;
	b=bYbRDehz1iy7jH3p5oO2Y9lJBbSKeyJPkMjcWOel1vwGFNupJVUKZo2Ch/QCy/z71B7A
	 3Sz652c45Adi43yyxeYGJXKE1s2rhEETOMV3+mNTEyKWtSvRHeX5OfnOpXI+q2hGphz+u
	 LMtkFuv6pp0quR9paze1graJPONVtnuh18Ys+anr3MmBDr11ikCAnVLUKzcCZJ31kkE2x
	 mSX7fWGYvIhePK73+4F0s8YJxn+9PLsOvYNm1tqcOBSE3LCHo5+Xpxv3G/SCrIE9zDcqd
	 +Rx7CvdjQZmXHeF0tnWFkvCssvjyL1EUgSh3M/rkmKjq4a+/iwbCdP5MbzUkCGlyvjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SG2hcW2i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.26
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A0606A324;
	Mon,  2 Nov 2026 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 580A0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SG2hcW2i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgKmAc87wZGmh0nHAS/vjmZAyEEkyudGlaO9/gi3exDxiE2n7maTWCfTNLvzvcwAJMifZ14LsT83Ws34tgNINlATYRMg888CInqYMEHXZb7z+OmYJyuWmrWz3PixUfLaGex/QE68qnUOhKeqPJhJOQnhksbOZG8qeAt003P/uW/fLH7T7DwdMFZVGG+AN/P57nWi0XPLcnh8qpUwsXdZPUk+B200HVPABg7oj+19A6Hk6RAChAMpRsyakF+BGoiwYyw7UTogUxYSl9Rx/VBRgH/JkTC7GOE3vEfwxwsPpXzItYkphxSgkI9aIeaYkZffl53by5dLY8zIxnHzaxKNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1yRdfZi5q9QqZRowR/KikC9/ifFEdo6eYqd4dymKcc=;
 b=dLi8GvmS2MhslhG7h5aKVL46RkaQtG+2gPsrUsQYgU7TbvZNwGIOL4jZ65rubMRgYf/hTgWIDivTST2XVeI4qYH1e6AKUbzUjinNvTDC7Ky3GJc9e0IUkhP3A3/G2S7N2hIbBb/R5DmSobaYZj/H3q8ya+g4j1L0wjF19QqheFu3IXA5UrqMMi+culEulakwwWtcCIo1G5001llDgYyeN4U7gzW74P7sV4GV3FVNs0IRwoGWP7TH2k1R/Af8BoDHPNjJOdH/gpuzfRO4RvxHZtzP9PpzmMFEFdbZt6cDNem0uhzbH8dks4aoKQs6ioK/1J0Fx8+y5uGqW8KXhtfxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1yRdfZi5q9QqZRowR/KikC9/ifFEdo6eYqd4dymKcc=;
 b=SG2hcW2iO2+YvOqV/doWAQFVHTzMr4bRc7WhzIfUOD+6e2PELcWqSixcQDuJJEi49hCVDk4ZunPBC3PlUVKt3SYef31/IkDrYQzl+Nab3hEha1uEzcGI7CPULMavyAPjNQ6tzfr+Q43kGA/O1k+IvNj9nHAmLhkMwPknSIV+9Wt4KOOoKSyZn0k6a+iPH8i0C8jjCEH988WLpxCRMzZ4SfrTPEDGeZyxN2+D1QwsaDc8oKP/l5TOpsSQd1mweCxnVT5R979zDzFn5cwIB7PE+/tQR29/zKjyumnsaSVWSYJlhc8to+XZULtYfPvA7cJrM2FrX5ffwsRXKOv2/lkSbg==
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:15 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::6e) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:00 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:27:54 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 04/10] PCI: tegra194: Do not skip no-link Root Port remove cleanup
Date: Mon, 2 Nov 2026 16:57:13 +0530
Message-ID: <20261102112719.4022633-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f227479-5f7a-439c-4a80-08df38d4632c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CREUXq9F9FUWoY4YvioJTI40393hQcUxAj9mgsAaQ5PCd8892uLb01olHLOjP6XHATEIKxYFkirx3PXa4cARntxl3YQKUpxgarA91HaSivHq0gK7j7cbwCH+AII8APAb8wGPzACLnaia8XX2Rots7Hr7NmoWgomJfw0TjqxhcZWDSZw82CUQ9d6FBnq02P9DStdrt+h8ZkOd8z5AMIEtkiHjxaZeGI8EBKYGfV9St7KPBTIeJ7dseBvcvvLKizkJqqnBMHP4Z747+WAcHDEV7rE1QGbgQSjMuLPMcOUYxpa371ZQqKI8j21rmo543a12dGcoMrAPlfen3mqVBoURlzwbv6u/RknuUPMn7Z3yIOpIhgpdKOZPlzm+Z1BmGpNrf8cnB1cZa48dEoYvw8ORr5DfB5Iy8jjP3M8PS0wOU7UmQmpkeL4g5dAQGhK+tzwXIPsVsZ0STTbp6Gf51tQfvSsxdcD62yyHqcwVOE5tzVIuXqGLq6BiNEvf3plyX9ocHUH2OoXtgkdAqjGDr3OZsRlMKXbXigU3y3mqotDQTQScLwlxMizLqTwLQk/zNQUZjEhsVWg7hdXh4ADjCDSuU0lc41hxDUz8fE31kMCLLYzE5UtN3fqJuXV7OWhb4qyJoxyNQBB/PxNReHAt1bv1hnlsGQ6qgSa4/4Vf35y6XKPqRigMghsblf/c22Xzadqp0R46ivwYbQmezHlHOfsqbA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g/oy9kjj3tuEERVsbl5ArodY6oKHQzY5WRIK9QmpNunbkmFFsro+6vdNJp7yUF+rLw0wx39LLcx/ESo32jGqWwcVoRYXKELfifTZKWB5d+kS9tNGaJ43JVMmfn63KoLZBcNvY/sfnwUOS1pl4wAd+WVpHDwYo3mUQ37BFxA8M5/VMqIFRqgbafQW59TkcE+ZRyQ4eASNUkzkkfQM1g9cuu0HVOoYluOR0+Z3c4EISKjG8eHsq+guGOF42nIr1BLfR6Dag9VHxCbVqjVZVJ1MMWDKE7wr29CnnErKQQcqP7xLgmJ7P/pnMEce5ShlczSOkFgC+y8ls69PHdtIcE22QpYK/FCFqMJkH8Btv744ZhGN0Lmaw0zePC9SGJQrI40Z/oP7zIys3MNA+wyNlKzvjSC/xfQFF+G000zgW0l6UmQ9pf38ms+yL3VMVyLHr2cO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:15.6308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f227479-5f7a-439c-4a80-08df38d4632c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

tegra_pcie_config_rp() deinitializes the controller and disables runtime PM
when link training fails, then probe treats -ENOMEDIUM as success so the
driver can remain bound without a link.

remove() returned immediately when the Root Port link was down. That skips
common cleanup such as tegra_bpmp_put() and deasserting the refclk-select
GPIO. Keep link-dependent controller teardown conditional, but always run
common remove cleanup.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7560422c5953..0027c0adc7a1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2353,19 +2353,19 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
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

