Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA23B2FD2;
	Tue, 24 Mar 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379368; cv=fail; b=e0yuo35uLhb/39Rz6G8o4QNBmc/j/axmXjcxTVCCqEdnSzvekjLbUaLcJuUHTOPDwt2NSV3p3DLEt6KaZm6QseJlzmodIaHNPKg6Un0tCFdvH1n9K8+8QCFPkD5SwFSdgEXj/PJowr99RUeCUW6v9iZ4yixRkoA39GPQTX6VT/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379368; c=relaxed/simple;
	bh=Dkd4NnaBEohBFV9EVwNxyMDkfaGPDDng4U3qVpMemss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1QIr4I6zjwcgsMWaBPSPkbn8xQWp/6B9ZZMbrFv/kclqrKX4iBr8shF7N6wQcMctomeYZIZWqXcZ/injA4M5gU1nUZbsDevYtTQZL94SWxzvwplct0enCmxhagjCIMTUeEDmLS86OqtlgX1CylhkPew0Bx7pALY7PQFCwvhcrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E17ppYYF; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E17ppYYF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COg+hTQkYY4VpPR47mD8rgmzFHjCzc+iTO61jua+VhUyVG65t6W5smZUGZlhZKEzYgylfuaLgZt8XEw7ZySu2LNXmrvxE9b+aNO/iJ/hFVwQQZImOoIHfa8yVNBaiOg0c5r9gDXyonjJtoE9n2pco2/7IekxLQ8qUWdlTRForyIEWiLhx+qqwYkhFuP+NZdB+I1Z2lwZ32yylB0aZhCPs4oJp9WDcN4EsnBCM3T5RlLbsAc9sLX6/FSPHeo73LiPAuejH3LnwdJauZ2eL6xLmU7hF5fnTKrOp9JGjl9MAtPb36hyA4EwGlj1XDs7tVW0QqqdeUe2TP4MqBbytdheew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1tHHpBhDF75G2OuvHbYCGXgHC5teDjAX+pvtc/K0SI=;
 b=tn4Z44CE0eWtBugozXvFtMC4hTVtgoASacX303fvJeOdNGpITcf+hk8sbk7IS0RRRkYI4pRw0loBhqAUxg3RmvLspHOkPBd+XKGMBB1zzHlb/bFWw0Hd7nsuuKXymdo98jcz3X32zt9ZX8fu+T9gnSaEMM9VGzLEgCVuFUMFR5qb8J+OzRA7vJC5+kdtxTy0l55Nuidld5DbHBNKCs3J7kyUnZiHCQ/WdS0KZTtpzciOaNcG+GcRXlHPQH32EP9tFUeSFmqwAh87J4aBr/xSjxU66X2aA4IHI82TW+zi0rPF3bjJk0IFnHyL2l3wboxlslmqZBdCmTSTo2FkikXPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1tHHpBhDF75G2OuvHbYCGXgHC5teDjAX+pvtc/K0SI=;
 b=E17ppYYFGgTjnsZyPaO7E4fg9TqHUiML3x9E94Tw3IJ7SuRkqgmh1jAL8PgJ07+H+m+LUO2LLhei+xpIaTzzWC6IevtT95/0Bgzjn3kuJsivXINMUWvqAoF1OprKH4SFBtyrwcJc0lTe4QOXhC7NHzWlY3BM24eto0okprH/ZxfGlEdwVLTC1/2iltuh5XxaYHoKX5wlNkf5ssPUJuu84DsuWkLEwO8AuB8GEiPVe1hk636TQ7PKYIHVG2aZkQ3LzQA0lFXxWFeoaZ2Z0lilCVHOa/vb54IZCpdg1s+Kzj6B6Sd5Dndx62BBNyYff11hOAnm90TnMcTTfXZGJkC4lA==
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:13 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::44) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:53 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:46 -0700
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
Subject: [PATCH v8 06/14] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Wed, 25 Mar 2026 00:37:47 +0530
Message-ID: <20260324190755.1094879-7-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 349130a5-3906-4d11-bb3d-08de89d8d66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z+FoRKbQ/iG/alDUO6wAm9GO/I/OGQPdujBmZAkkA2wBFDFaqrpsQ2d/ysa5dmRiXLw0GtjmbpTpcQy2P3/nbG1nMyZvTaxGzpXXCcgDtfPT1YyLw5Da8iIilx25s9KpqegbVFNwnVDAyB+IVp28gNt2rNWHvAS/0Y0LS+rxeDg6PJ5GHES+0ZBrgTXixP2tpf6bj03DM8+1WzFWhRaK38FmpEu7LC8h3SwSedsE47V9PlRl1/NCVLFnePJsmgBQjgzfBnsJwLXkziJkNVocGohTYuh31y3jjv9AiK7vbkJPzlAdhCDUaUCxDLWF0R8WU/EaexX5K5Kz+r7rXWWrQtxYEB8KJtpRaTH8vy9blQdh6a1GMefFo4tRfEYHJxSls8ArtQA1cnQ1qiKoWmG2RUssZI/ZxMvtImtcRuMfyX8HRNvVaGXGWiewWP58LzDaKrNAkT0V+fCNRgXID+a0uLdZR1SB7G+5GGu1g9hQfAeZMcWZhJ8t0CxXcsSOtHGey7TvxmpCkqvWqZH5nKSpINLbj7nKhKWT0F4tkAU7QXlOXFYTqcpHFCM7CwGNY2r7+EHgxbrTZqBOrH9CGDbATdpvg1AY4eDAAVBXvpM0R153hNvbFlqVNbTgexqss3QjnIx++x6UGC3XmE8nlRqsvguv3KS1JKpZQOVH953YZiBYft5cj2HZ7LG6WameCB46iLFYRPMgIjPrWSHyPnvaxnhHMphM6ewaRPemPQDCzRmnG0oNtzD1CoDMQOXWarort8KHspbttf4LQ/wG0g691F7bO8VswsfvwR3Kh1yj6Zdkk0eyOMMRrWPFbiIddpks
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n0r3a7bbwQtgbKTPAzLhpddVbz5IxwwmTQoThjvUUiXkhvwu7Zek0AQ9WVipDb4Ok2yr7ybGMwCqM7VHXr0/iG62E0MvzKBS0QgmuGpH7s/+BrqRLD88JyUZZ4xF/xwGPDxbEvsx04Lxv1CJu7j+L/Gj6U6lwqBeyxusP2+1jGHKzjOiEG6tmaNVkAZ3QMdAzBz2ivtzxLEka9orwllKYeXPtdNf+CVKBsv79jqHPoZDKsIA8hTlungLGMZrfye4R9QFmk5UkvWi/OBFBaUHhoutst8EMfFnAGrKWjTi3gGwxowfWlXfTlkuyvDY8u4/jr+LcSP7DGlmWw/iuX9o+ftu/DxxTak8WR346cGzFrm3rB6f0T8qwEBfxuo+M8kTTDYhmxu+klnRS6UXHW/t3NAxiP4w5t7F8KQXnyz0FFIutQOi0Nie459zjO9gD53f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:13.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349130a5-3906-4d11-bb3d-08de89d8d66c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

From: Vidya Sagar <vidyas@nvidia.com>

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V8: None
Changes V4 -> V5: Added Fixes tag
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f3428fd3345c..e0b17ad3052d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1167,9 +1167,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.34.1

