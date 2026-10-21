Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563285;
	b=myPXQ1iQjAEGYktEePwaGEJRlz7mS+5jx6L9bY3XtjonXaZBgV8u7xMBodrasT2f4LsT
	 dqJ19Hugi8h6txsRv9UJJuLilunyhMzyw/dmtGpqNP9au8fNh072PsoL4I2XdIXj+olD9
	 yfkbwCFKUMCZSj0N6x3uHknDBvntCz7mv6V71ERbT0k03s64lsTRjozzj7/xgZU5zh6dn
	 l6fTCMpW67kWhFvAldIPvOuYzvdviFmU4vfSWszMlKqH0pmJj3HHMXLsTNU6Hkj6Z07VI
	 Y2QqZPhfgPnu1bKDsArrY9sXqDr393VUqzdJWvWstu4pzoYvKHUkXTcUXE/QZa54ZZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563285;
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
	bh=O/oIWKJSJ8TERZNgqx75Ss4zRewhoDGyDn1rg6RkD7o=;
	b=b09+9Hf77PmeoremSrm4saU+a9V+rfWKOkc1fFXFZFMYZg5vkxxslg4dZrxcO+6LItWZ
	 wBSm/THt0Hh96d/Gbuhlopa/ue9IvM7+bGXNMaLiS4J66jv9KhrwQCBCbfDH5bc+/eE/I
	 Exg+kCTppZ0Wh91zmxGhihwohZi87dK3aw28Nl2gd1DF9bVnGSj5pjJlPrDvZwI3Ihtm3
	 rrllWYSREAq2ryps7iZ2KO6NNhCLvP606UaGLVRNd1xiFUMYB7M7Ef0LqwLaQqnfwVPfm
	 urmSE3G52d0pIRerThLlF6Ubqhw1NFOvg4bXOOKDr+fv/7xBRvnAIboyuOR75Jr5YYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I1QoUlga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.35
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256E606A31A;
	Wed, 21 Oct 2026 06:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1256E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I1QoUlga
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksb0Q2CBiRczZ7tqP47fc6cWwMdqJEEMxbVef859upNjvzb7rlxBehlzbio1Ft7t6H5Jm0UoQDY6Af/t/n0IhCNIUx+tJNGG4f4AN8uTbbVFpSxiBrKG9AYr+Q6zN/AjxDueUV8cJsXqnx9YO+b+ZfjF+5dc9ETD+7GKBYboE4oVzAeSoFhmmcPqPLe8Zy2H+k/DywOP0mVJpUQHF6dMp5MyewAagrzBnrM0FXZon2I6p28EJIUq0kfzcZwxamhMJy2ik/Lp9wBlwnWX9Xc0iWfagv1H3ZSs6a6BVIqIEp7mmJQRuQVSzKfU+ypEWND0xsiq0NTWNOoZExu5c52hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/oIWKJSJ8TERZNgqx75Ss4zRewhoDGyDn1rg6RkD7o=;
 b=MQfLafkv0GvpQIzNWF3JdnzzlYHp2FZxI75FzE2qGxVOzyiaJpbLmBaGNZeLGI1Biqzq+i24Tl1A4V8hhfXeAQhZy3wFjsmiPLKkWA2/FlGcKjcc1lsfoWT8mlmolMGmtQYmdDRDZsXnKzY1veYTvzYclES/3M0uH79PVGLt9gS59DQ4sh8Q4ev02tSPRIs6/kVw4df+J5SMx6l/RQGmPudDA57tzXkG0ZY33t5zU2XLpxkIYQ79FRX2zkOhdPa3ewIdBI9AwTg2eb5QAzqkVBZ5ErLz91U0KTc7rb6OyddzRERST48cLZl42g7ceZ/L501kFPfulPhiwZggw5xB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/oIWKJSJ8TERZNgqx75Ss4zRewhoDGyDn1rg6RkD7o=;
 b=I1QoUlgaeQ77EALhebnNU+FSG3AVLNLfD+Kttmcn9f/GKVcWExgn+KcRV2F+oza/Fef7REbrKwIN3XHaZ/chqauWC7ZAZ8xif8ArXjaqh8M8HUSgpCDVFRIq71CcD9muAZX9nTcdA4ylnstV8qf8YeVEH5mj4LYAhMor6CSP766U77qeOV4j1LhD642VFC2TI0YuKcwaJqphzyfuBDJ4ENIzeAQxgNV6ZmfPm2TpN/BsxBnsL0UYYL1JhrccUlwrOgV9RwMEIlLzONgwLRuNV/Sq9RahAIp21tvwhwjNxfV4CNggpjdsy2AnNziqDIJAMPhpZAAE3tZSTmxzJUEr4w==
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:14:41 +0000
Received: from EA8PEPF0000000C.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::39) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:14:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF0000000C.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:17 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:09 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 01/10] PCI: tegra194: Propagate REFCLK select GPIO errors
Date: Wed, 21 Oct 2026 11:43:40 +0530
Message-ID: <20261021061349.1265704-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000C:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 532b5a71-1960-42ae-d99b-08df2f3a977b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uca8x+G+M2pO+wUhwHR/ZeHJVMY9xYWCcIjihakKufKklZuaGRh07qyFrz8bD3JLRzbeZUYxRSK1k29rK0QqG2LrnT2pdnfxnt2sqSHflyQlkpr/VNEuMvzoi8DjDXwJ0oKRChKOuM4HC3CLq9ic4wb5GtlZaDj6J98eRhF36lxU8NxAm9ZuHJ5FLM1XHjTV5FAKLrW3GN3kUFv+34AmuFEk9mHNQI3xkJmNdEhh+DtmkiQQncZQl76KA//uxIdtP6rV6zh9oE5MxvRCurQYiqoyefZhkzodnG2RKsoFKTG3snYFXZM88AmkaSLaLSQlIfAMz1g033VVnbt20H8R3MJu+MlUffnWBcRIj9ft87xCsZ/V1EiwU7LIw3EX8KlMASZW/pzwT3q5zy7RKY137xkP78SjtqG3KvjOTEXWjhOcrdkghpQm8s8F+O4psHW9G+i0equAp1l2iS6AmDJGnpGzDp0GznRnZj5D0D57sIjF/sPJQxxDbQx/Zjap76jlijgP5k3DLaZjBw+/T/AoyHqFpun4sRHZgcsVzpkpvcFlnFh6u4XI0uAhWU8iGgCYHIqBhZ6wNWDGKBG72zCsgRV9z1cVKq0oA47CBn1KujqASLQ6v9jPkPvnKLyMjRi0s3o4YlHAN/8OMCHHPYpEUACXoLRu+3r7Jy0FELiL7LCzHGl2geJ7I/5nReF1sW45D3uzHm0TJX6m36y19apnvw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3HaGUKeKCR7EGd9KIcZFWsFXICd7lGYAZE623LS3TIxrV8VRjpgV5gth+qq/fWJSL6rmtm56yddO/soGI5I4OJZN4zWog673CWRu9Rc7d7aBQv+pw1OwGLGWiQgvWK6hJp2KX9d3ryFc1TWjFR66LS//izdflmO85Y6NB4p1ZY0ARFjeEI1Yxf7aVgqW+41PwCSRvqxQ6PZrxViJq7Hmn1fpHSy1dP+zuX0+WMMymYwHz32zJtNyyrfTLqXOb38K5fK+j2hP7HdDwd2lWcSnva0hVZRP3fdDXArybJqa9cu3+0uf4hNhOdUFllhO138cgBk8DmFDkSs/P03IX3GROWiFYZ2mOIpOl2hNicghlK93HJvlBhYKWfSsdtyhr/Wb4/Jf/cRXM5JZ3BMnOuLdS+I5n0GNr6d3HdfJhqyx6lVunQ7dV9jFzCba0g03flW1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:40.5108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532b5a71-1960-42ae-d99b-08df2f3a977b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

devm_gpiod_get_optional() returns NULL only when the optional GPIO is
absent. Other error pointers, including -EPROBE_DEFER, describe real
failures and should not be converted to NULL.

Return dev_err_probe() errors for nvidia,refclk-select so probe does not
continue without a GPIO that exists but is not ready or could not be
requested.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9b349b3430f1..6104a22d930e 100644
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

