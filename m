Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728C375F9E;
	Tue,  3 Mar 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522481; cv=fail; b=u5DUPCNSBg2ydXOUWMpx/o2C7GHsZIyHB66j/bIsQMLmgiIMOJvUwl9dk1AyU26PB8kLGE7Vj9OgwX17FpuhWYicit9usrBA7tDb++xUlRZ00fOutOkuJz3PnCTSFEA+bSlymrW2zmtGuIz/YC2jePTbJSU4uoQE4Iry/C/e3b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522481; c=relaxed/simple;
	bh=JnF4d5Qlk79coWHPYIMT4l9KsietsLx8/22TMdKvRBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTDbxOEZ9kC3HEy73o4te/quQ5crJ7805gIow39p8NpRyO4fvVwu5q90fjXgkwXQSQq/1cI9Pih2+/pLb8UGgDWX8ipgq4ljyALECz5wgNDnvIsz+REl/C77poY7iGkPYzis+C0bOOa9sbi3q8ZJUP2A0aL/DihGDXmhwF0DZWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2QcVcsM; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2QcVcsM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHu33uvOhWOyWl4q2v5cYYABgzXdpgnBOY6wn4fTpw26L/zV7cE4HI3BkrsMia3pLz2swT5SwTWP9g1Z1PsPHkMwRrjCjf2RxFFCz8MMlLokekXQRHfBw8XAcnFZ+EIGhXDH0bYWzEWJ+Vaz3DqBnn50Uxu+l/CbmzGr5BbVSEAJyfHmrKFgmxzB/vlJE9NzbzCMAN4jeYgykpSvwbYbsdUku+37SQ8dned1aIXKIpM1FNcbqgltPi+8qb/sWeWyp7NVTCvpZxOaVnMvVFKjrm77WV62Iq8olD6hox7g0B8wohPa7hQ0cncc4EuQv9UVV5wzJKLwrdYVb9PQg50flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6cV6wnnh06X9jRatZpzi8D3AERKc2DVrWzFQMFQhI8=;
 b=F8uJOoXBsTQ9QBuAjrPDilTrCJkD00unh/gvLTvDR7xM7JOzrke1+fW+GpXTJagwywlSjsWE4NyQngcXxKLJRj0r6Fv1Ufbz/NppyW0FdrJgI1x8E9L0WWFQwJuKMKlreu/xWPiMum+JHAad+c7XP5PbGVAgABSQCGTiYcWQqlDLjAcXfAE4URT/U4u2hEOxeKellIojgdh+yaoOYlkGSYVdK3ElLbR6KOQUk1cGtl3XWRUEdmw6oXSsjG/i4PvjNkr4wrsHRpLsL4yVC02VP5HlAPpZPZ+MyI9ki5/EBhOElZbmZUY1k1yxpjFdGVNe55roZSUUouqExmpzsDYUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6cV6wnnh06X9jRatZpzi8D3AERKc2DVrWzFQMFQhI8=;
 b=V2QcVcsMKcM5Y9NeIOG11/XEnVvxJPPsPLgRpfF+3XYcCGEv9j8MssJ76gEj1qKOPaE815zSU/xOe9E8w1jBBd4yWnFP/ip/EEuHz9g9A5KQx0eRBm6wTmTeEirlMC5hpyFCUsEzIu7JypgThDUXJw2tCFE5pPvFgk+eUbL303UnR/xfP+GlGei3lJmmmEPgOAl2yhKdGj4NnVi+cREoQjKVsHojvjw84e1QKXFrO+JLrVozhInOjILO3qNc/6ew3Yi7MfQ9MOpczXJ1HhlFWqyPKLOMac5GoNS8Clnfq8zGUlf8oq+mSZ3Csal/U8kIu0kjoGiQi7e+AP2SgtN3Wg==
Received: from SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 07:21:17 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::69) by SJ0PR13CA0125.outlook.office365.com
 (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 07:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:21:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:20:55 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:48 -0800
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
Subject: [PATCH v2 4/5] PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
Date: Tue, 3 Mar 2026 12:50:03 +0530
Message-ID: <20260303072004.2384079-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: cd865aba-9198-4d72-23c2-08de78f57597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	hU/FriUDJwKmjyXDXTmpJ5Bo3XCDlMTmxIkq2BgqLT/cT+BApUpKxxt62pSSAcxR/vwi0DnmF4zZShoLsWB3MYjayVgcPhuGIic2/a9JqxOLTV3S7uO+CcJO/5M01OSzrDRlDAXBipmEZwWUepsnnvGo3wqGvyFtg218TmJnTa23HDSs7CcWBcT+zOIGBL6CzmLhIb3EjEdDp1ATYkZqb8UaHnPQA77dN0iYs6D8bKNtIFvrP6v06bIRhk9OAPJWWQ5aMfrClIlBEkSqm+XztWsunDOqu6nE4c5sUDirSIYcfEuM/C6x86qf+GgWl3E/XIgxiK/wbbqEbpiLAs5imblSZWnTawFEROZBznZo1roELxvOUF9zFJft/plT/hUGOcNRNFIGkBA8fOB9VwMQ4DmDYLdvzCop3dLnGN5WbZ+YerZ8u/3ukHsw831rxVkb4K94DxmINJf43QK3ztPE9UuitL6H7UjDAMWUlrxcLxFZblvRG/ctS9orAumeszONMPR4VGAE/0L25KA9qzl0PZKlidcRWf/tlyPedjPrUl15zbVTFi7saz63bzngY9eN1CT6kdeeRlfHzFDLMB8B+7Ws4CfuDnLrNeQ28DuVNNG3e0hqgJyVYW0g3RQLSz1wwq3SplLmGLwcHroYud65HucSyBUux4MZPEXa5zYD+NsfQHkE1B9lQnLU5+IhpvHEa+F+rONCyT0gU+U3IgvCg0TSJD9jjjWy2HCICpp3cdpijWVlx3JuYAcbBBEBBvGG2dFm2KeGwPMvIWmiVrzE5KH9+UAhl8KlTOOCk/YHtAAVXYVCK5Ea+rpSTcrY37cFMa7VtcuA5gt6jOQBKQ5vwJTATR11kvwJuejC++dfjDs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZaHkeyHMd+Jo99arDABjeCToPxWNjCJn6fCgdB+sLVSjCfol9Og05v0b0/yuh0Rs5iavO64ipffUNWOfq3CaQK/T7m/jg8xKtMlmYNW7Mg6HzLdqrhVepLRFc87Qaz1AhDpLsGKC6AEDvNbjKlah57l+Ka+jTwPnKTm+qmHcPyq5VnDdR8f6knPNThTGIdHXSUBZST6aF9p11fPkIvvQ6yAYNE3j1u6pJp3EMvGZ1W7Rq0V2gZoxgXiEkrjYQfOy582USHBH9gyKbhCyyGxDTyBLZyx++ayEKYTVBjiM8zPE53mkUiqitiqJTYB+hp0jEPkIaI/fSubixG0MKSCWRQvFBYftLyyMd4eEeK/pRFrP9q+D5LxMKfEWrLEEHS4Y5QRlcF8Ks4SVlNgzmDwJtrWuJluuyF3bLJZ301KHJAlr0dWbegtwcbe16VKsv5J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:21:16.6830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd865aba-9198-4d72-23c2-08de78f57597
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

Tegra Endpoint exposes three 64-bit BARs at indices 0, 2, and 4:
- BAR0+BAR1: EPF test/data (programmable 64-bit BAR)
- BAR2+BAR3: MSI-X table (hardware-backed)
- BAR4+BAR5: DMA registers (hardware-backed)

Update tegra_pcie_epc_features so that BAR2 is BAR_RESERVED with
PCI_EPC_BAR_RSVD_MSIX_TBL_RAM (64 KB) & PCI_EPC_BAR_RSVD_MSIX_PBA_RAM (64 KB),
BAR3 is BAR_64BIT_UPPER, BAR4 is BAR_RESERVED with
PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO (4KB), and BAR5 is BAR_64BIT_UPPER.
This keeps CONSECUTIVE_BAR_TEST working while allowing the host to use
64-bit BAR2 (MSI-X) and BAR4 (DMA).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
v2: Split MSI-X table and PBA reserved region

 drivers/pci/controller/dwc/pcie-tegra194.c | 44 +++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2f35f18ba766..be60f80ccf6b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2001,16 +2001,50 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-/* Tegra EP: BAR0 = 64-bit programmable BAR */
+static const struct pci_epc_bar_rsvd_region tegra194_bar2_rsvd[] = {
+	{
+		/* MSI-X table structure */
+		.type = PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+		.offset = 0x0,
+		.size = SZ_64K,
+	},
+	{
+		/* MSI-X PBA structure */
+		.type = PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+		.offset = 0x10000,
+		.size = SZ_64K,
+	},
+};
+
+static const struct pci_epc_bar_rsvd_region tegra194_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = SZ_4K,
+	},
+};
+
+/* Tegra EP: BAR0 = 64-bit programmable BAR,  BAR2 = 64-bit MSI-X table, BAR4 = 64-bit DMA regs. */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
-	.bar[BAR_2] = { .type = BAR_DISABLED, },
-	.bar[BAR_3] = { .type = BAR_DISABLED, },
-	.bar[BAR_4] = { .type = BAR_DISABLED, },
-	.bar[BAR_5] = { .type = BAR_DISABLED, },
+	.bar[BAR_2] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar2_rsvd),
+		.rsvd_regions = tegra194_bar2_rsvd,
+	},
+	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar4_rsvd),
+		.rsvd_regions = tegra194_bar4_rsvd,
+	},
+	.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
 	.align = SZ_64K,
 };
 
-- 
2.34.1

