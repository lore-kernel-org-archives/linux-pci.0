Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EA1FC7C5;
	Tue, 17 Feb 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307755; cv=fail; b=MymMIl/7araAmhxugJxKbztLzJzUnUvxKegydS1a3pSDCa521PeOZ5NwAy0h9Da18IPAPj0p1QUKBmzaMrwl6bUcqXtBHPzO3EYwteWMXk7rkWApb6aObrZZ0o9nywjt2yKZ9i3TVdcGjSAz9AUijMfNl4rqzXbb04S2EyJGycw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307755; c=relaxed/simple;
	bh=fLcjbf5nhBOLypER8bEOMmHdO4+rnljtxUDo2QlEAS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf0PFp2G8eg4K+AkvJx3E1NpE8uQoxTDf4XG2orFaVA3gaqpIecV2qgUXfNScZfIMeLsZlSwwmTkFBqDeSKICWxwn8YF7tNTjmmLxYgqGnzwsS4qwqO8NlO7uHWBaJmR/wvmfIRT6edgO+DJNuk1n+hRO0J3LDGO621UYtGq46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTlC9TV5; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTlC9TV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL06dI8d7FGKm2EVvKw2pngMKANuzcFYsyui0jsM0G90j8EKdMFuAAVKtxba/aBBQxks9Qi1LPXsuIfzm4fcRr6W3PF3GzqzGA4QxH7zvWN/S6KpFXLcY/4TuBUqW0uKGXnM2k3i8ltzy38jv18mFwjXmxwGeGUr2r5Kal/MoeaOdJIevrj4oZ3GSe4Get/xPehTCXs8hBg8idkqgM6kFDbCt4J4vuk8Yab+QGShkmb9RlDTgz0VQtFIMRTP3p3RdgrwZ07LuM2VM1K3cA1QfJSv2BXDpW2tm+Wx1hKq1aGCPy54qAS8hbXv2B3m72i6qIg9GfuiFfRxpu508FJ0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x87qLFIwjMy11SClFj5ppEKOiiSgaKx7mCThH85Mp4=;
 b=lAFO078718yPrbg5dbEJ7TmE+RY6Ay+ixvLh+emermLT/WugVgr6nDAj04KS0PQQ4xyIvH6i/aFt0l395PT3BpgZGGS1eBpJ57uQFjafJF1PGVvIgohSvhkP/hx5vTbeKZbFxNoESecVxXPpQ7p/7hcacPGn5Y/2hB1jDlTk5Y6NG2inJtAOjt1rBpuuwHekk77fBF5xT5JkxkQ98K6vBXWxGZarXFPcTwiovEHO97ca0PyJnIr9FxnGIx1LPELvRLXEQUTQ4Onsvcp35vVO/y/1aslje7hfSIsum0v1TaAiJ9nnQz43cX3xA58YTbU3jp5xhOsbj0WKwtdBJ82y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x87qLFIwjMy11SClFj5ppEKOiiSgaKx7mCThH85Mp4=;
 b=MTlC9TV5Nugi9xrophKpUsB09Paa3Pa8eWO+CQ5Nd0mtTm1X5vGOCww4K6Fb+Y9ZsuPOd3nzVsG7ydj9mxfPhuh3WBFaxHhPTYp1sSIEkaVjQ10dn/RvQiZY4IwYbZJZ6sktQuJr5i4m18c8XZcM0vNR/zRiuZZyRe2LGr4sEgTWXK0qBAdnZtJbYqBZP30Awd59yK2uAMrSyruWI75eppWddY3xiLzk/fiXjNKQiY84Kwrr5ekQv0tm+zKICURrynDPwuwt32BdVsdGuo84oRAsmEA+b4zpo2c5xitpxwUlHbd3NuLOvwDazIH2WdNQV0JBTq7lRBr+3c3cBeoq0w==
Received: from CH2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:610:38::26)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Tue, 17 Feb
 2026 05:55:46 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::6) by CH2PR05CA0049.outlook.office365.com
 (2603:10b6:610:38::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 05:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 05:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 21:55:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Feb 2026 21:55:18 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
CC: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] PCI: tegra194: Use 64-bit BAR layout and reset only first BAR in EP mode
Date: Tue, 17 Feb 2026 11:24:42 +0530
Message-ID: <20260217-master-v1-2-727e26cdfaf5@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 422cd343-aefc-4093-8df3-08de6de9319c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVJCLy91TWRHQzE0eTJFTVQ1amQ0dzMwWW03eFFGa01mM0JWU2JDaGV2d1E3?=
 =?utf-8?B?dWpLWjRmTXFBTDJhRUtjeFBFblZDUDQwOTAvaWtORHVLNXE4SktoRkV6UmdP?=
 =?utf-8?B?Qm9LZW5lNTI5R3podHFoeGNMWlJQTVJWNmFiQUJvcUpOZGdHOXNVZFlJeGI5?=
 =?utf-8?B?bVBsWFdLOFV0M2lBdzNmVUNNSjFtOWJBaUVFclNvaUc4YUJPMzJ6bjgwMFc1?=
 =?utf-8?B?cmtHQ09NcFgwTFVhdktzWG5YckJVclZBRzFEKzkvSXZ4QnFSYWVwanJVWHBZ?=
 =?utf-8?B?bDkyQlg3K2llWFI5cXY5czJuWnZQWUxialllbUV6YVBOSXFxeFhaZENsR1BY?=
 =?utf-8?B?RU1NNDdhZlZjSFlUQk5mYytCalhOUURxUURWK3pxdkJUYmMrTTdYZHJYRzNv?=
 =?utf-8?B?bmRaTkF2UkR1eUNuVUNtcmVwbm02TUVDRldBZWpLa1VaMFdPV25vZENoZ3pu?=
 =?utf-8?B?Z2trdlU5NklFK25FejZud2M3WUFicHpraW1FUjJWVkE4V3RIMXpocUp4Ym5i?=
 =?utf-8?B?aG5yZ3FRcU9tV0dDS3ZGOUl4bHpEdEY4ZUllRlZsYUZtWHpSQ1U0M1hLbU91?=
 =?utf-8?B?bDRzWmd2d0ZnYTBNYXRYT1kxSmVuZlhSSzJReFpIMElBdTZXRytkNDBLdXdY?=
 =?utf-8?B?SVNvMDV5MFNWdjhkdTZqRXdCRkxHWXM1UXVmQ0VHVExveUVwVVQ1dk80WGNS?=
 =?utf-8?B?cnpjSXNUZThyZzVPMXFnUmJibm9CNkQ2K0h5bmw5QStoZ2I1anpMODlZMko0?=
 =?utf-8?B?K25XUWxmNDB0aUJvY3hubkp4Syt0eXFnUkdzeG0ySGtLTEpzeURJYUt1dXNh?=
 =?utf-8?B?QTFZbzBnSnFDY1h2eXZKclpUV1V2WHh1UWNIMXZwTUs5SEc4alBKS09reTR1?=
 =?utf-8?B?Y3FJUXN0TlIrTkJIWHIrTkY1aDVrUHJ2TU1oSlNKbEUyRzFianRyWm9WSm45?=
 =?utf-8?B?TkVCUUdrbTRYQ0R1YnluVHhYaU82akExWFY5RlJ3Q3lyeTFMWnd5bHdqL01X?=
 =?utf-8?B?bkpVdXpyc0FCbjZwcjl3TjIxdXVybGVoM0xtYVBaaUJYM2xBV2NOdG9xS3pN?=
 =?utf-8?B?VG5rMWtEVDlQbys2b3FoczJScllxSVNQOWdiNEdITjd1SGF0KzBvd3RhR0t5?=
 =?utf-8?B?VkMwblBSRU5QV1JyOEZxOHN0ME1QZ1FldDVZallDVFZNb0Ntcnk4Q3g1Nnoz?=
 =?utf-8?B?UkFVbko2aVNSd1lyZmJiYVN2VlhNaDREVGtNcTF6YklTUkpjaEwyL0gwcHJI?=
 =?utf-8?B?dDUwNXpja215am9ucE5EQTVPRUY4MHh1K21nTHBsb2UxV3pZVFVhYm03eHo3?=
 =?utf-8?B?OXIxZjh0YUtKMDB2UlhaditTZmljZzFLaWxzRXhpOW9QTWYzZWcreSsrOFJr?=
 =?utf-8?B?NUJLblZ1VWU1Sk5kWUpWazcrNkxOYnlydjdXT0UrS0tOYk8ycWE5L0I0bVpV?=
 =?utf-8?B?djJDTXJKTDVtdWhCNkZ6Wmo2NEx5STJpLzFybmpUZVRyNFdVOW0yS1dJblV3?=
 =?utf-8?B?RGEvcWRjUFZlWVZBTFdNTFBhMGl4M0lsMktwelgvcmJRYkh0YUVRVStzVEhs?=
 =?utf-8?B?NzhLQ2t2VlNJNW9weUFIaXFFcnhJcVdDdzRvTU5QUml1bVRLUDI5Q1R3UUNz?=
 =?utf-8?B?R2VJMDZybTZSY0s0dEpOSDluZ2tLSGM0RVpITEdxbWE0VjVEVCs3SGc1RHQw?=
 =?utf-8?B?ZlVWam50eGhud0lldU12b1pCK1lJNXpiMWxQQ3NGQlVpaE9UeXhYbUpWMmw4?=
 =?utf-8?B?VGFwZTF0WjA1TSthSU9pUG1zK3BZejRneWQ4R0w5VnRQVkZuZEZlNXlUMjhI?=
 =?utf-8?B?VnpUWFQ0a3RVM0p0aEtwS0VOMk0rRms1SkhMUitKL1BNbHA3bGQ3VGpCYnhD?=
 =?utf-8?B?bmFxdmRPNmNjZmZrYlFCdjF2K0EyaVpUOGVFTE1BaHRCRHVqUVdneFJ5OVRj?=
 =?utf-8?B?MGNUeDE4UUEvRStmc0NVQkZHT1JCeHhGc2RHZWUrdTRPT1lMcDE2RnJtSUtv?=
 =?utf-8?B?MmpCSFZWTTVxL0h0dEh6dlhRNGJqdGI3ZCtmSUF5d1dMbnQrUDN4NUJMTTlj?=
 =?utf-8?B?ZDNjUVdNdUlOdGxhRjJTTElmWW5OZkhBTUpxVTdweWVJSjRRREVkZ1NUalAw?=
 =?utf-8?B?Z3lISGJHMksyWGxKb09XVFN3M0FRQ2tzSDQ4U1puWE9vWlo5WS9PaXFZenR4?=
 =?utf-8?B?SnNFQWxidEF6TUZ5Z1pEZnVoamNlOS9RSkxFSTFOcXllV2FUenhEWkRqOXdW?=
 =?utf-8?Q?XYl2cXiSxZC6WuH+F/ObBqbK2pzoIp6ocsbpqlRQP4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v+lUwcvDySUQLGetDuI3v4dEW+SLGOwvmtb4FJxvKLwKP+pK8Bca4r9ZI3eiHOfrEXajf9SObYXg9cK1j9WNH86vRnBIamtMPAqh+dOKyqjqGFaMomcTdl4dFZoQzFMbGBUHBOlK2d3Yy23g8OvtPgTzD2Jww7HDA78JUJB5+UbwJ2RPjJEDd+wgB1RZtd8aDx1G/gf5Hu/Ei2BzSdgiPJlLEyOV318WY5fk8s0mgOlKia1clLGGzORimUy5ZRYk2KLvhLR7uAUFofQJkCmXimVSPNZIXpc4LLi6otGXdrDobBNcY30dXL9Z40AWK9IfI8njVUkT8zUb0c1cFuHw1s7rIvEU8urS9QNXJAd3HbA8gnTTQOSGWbl4V2zsIYR3c85HouXZ47McPDpOjSr/OfiY9FMzlEb4HbtIPvAw/cJ29YXtX5Oz7uJPsw4Fljcl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 05:55:45.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422cd343-aefc-4093-8df3-08de6de9319c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292

Tegra194 endpoint exposes three 64-bit BARs at indices 0, 2, and 4:
- BAR0+BAR1: EPF test/data (first 64-bit BAR)
- BAR2+BAR3: MSI-X table (HW-backed)
- BAR4+BAR5: DMA registers (HW-backed)

Update tegra_pcie_epc_features so that BAR0 is BAR_FIXED with only_64bit,
BAR1 is BAR_RESERVED (high half of 64-bit BAR0), BAR2/BAR3 are
BAR_RESERVED with only_64bit on BAR2 (MSI-X), and BAR4/BAR5 are
BAR_RESERVED with only_64bit on BAR4 (DMA).

In tegra_pcie_ep_init(), reset only BAR0 and BAR1 so that the first
64-bit BAR is disabled until the EPF enables it via set_bar. Do not
reset BAR2+BAR3 or BAR4+BAR5 so that MSI-X and DMA remain enabled for
the host.

This keeps CONSECUTIVE_BAR_TEST and DMA tests working while allowing
the host to use 64-bit BAR 2 (MSI-X) and 64-bit BAR 4 (DMA) for real
use.

BAR0 is capabale of supporting various sizes using DBI2 BAR registers
which are programmed in dw_pcie_ep_set_bar_programmable(), remove
1 MB size limit from pci_epc_features.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b4fc6a9bed1..6734d1336ef1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1948,11 +1948,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	enum pci_barno bar;
 
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
-		dw_pcie_ep_reset_bar(pci, bar);
-};
+	/*
+	 * Only reset the first 64-bit BAR (BAR0+BAR1); EPF will enable it via set_bar.
+	 * BAR2+BAR3 (MSI-X table) and BAR4+BAR5 (DMA regs) are HW-backed and must
+	 * stay enabled.
+	 */
+	dw_pcie_ep_reset_bar(pci, BAR_0);
+	dw_pcie_ep_reset_bar(pci, BAR_1);
+}
 
 static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
@@ -2009,16 +2013,16 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/* Tegra194 EP: BAR0 = programmable BAR, BAR2 = MSI-X table, BAR4 = DMA regs. */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
-			.only_64bit = true, },
-	.bar[BAR_1] = { .type = BAR_RESERVED, },
-	.bar[BAR_2] = { .type = BAR_RESERVED, },
-	.bar[BAR_3] = { .type = BAR_RESERVED, },
-	.bar[BAR_4] = { .type = BAR_RESERVED, },
-	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },	/* high half of 64-bit BAR0 */
+	.bar[BAR_2] = { .type = BAR_RESERVED, .only_64bit = true, },	/* MSI-X table */
+	.bar[BAR_3] = { .type = BAR_RESERVED, },	/* high half of 64-bit BAR2 */
+	.bar[BAR_4] = { .type = BAR_RESERVED, .only_64bit = true, },	/* DMA regs */
+	.bar[BAR_5] = { .type = BAR_RESERVED, },	/* high half of 64-bit BAR4 */
 	.align = SZ_64K,
 };
 

-- 
2.34.1

