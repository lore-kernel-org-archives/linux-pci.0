Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7A2E9EB5;
	Sun,  8 Feb 2026 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574129; cv=fail; b=h0gz0gzZSyDFQQcU2bkZcIPVhwlXuaEEC9ZdvvZ2uKWIEKZmtM5gEkhC7yV89HbDGKzb5brl4AhllILqaScgo/vEA5y243ibUNk9/zXCShvrQCMTkZc479CgOU9N8IclM0//ilobeK74QYY9L6kEZoct8rdndGTLR76JtwwqU70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574129; c=relaxed/simple;
	bh=LtVWRHaQ4JNVuiQLVnGolxi7O1MicNm1rQxwDoWTxVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MP5fsemhpAD3c5ExwHgrfawOgDq1l71E4PogXPhk/xQRm9Yd2MI+uM5maeEj9PslMG4kLE4KDhrzKykLuR6D9RXs58g63e0gtFXh1SVCakJmBOfo1g5qJ61uJLeVFnVHrJ2Va1WOaelm93iRgwkPtJaUhQ6nnwDci8Kg/bCBq/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fCvWAGQV; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fCvWAGQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJoQT8AM+RI1OMZSJtXDDemdekURGb6z5gz+BxzXm2+1GxqhYlwKZe5TX+Ib9+i7mjb0gavvIlSAEMJn9noBrtzf3LwvdOJ8eZxHSaZzI3MMv3ImTJ+9Jhve8wv1K+bx9b65YTQ0HUlWJ6Q1kJ0CI7Y4ctcpyYv5FFVugdBlsS3wUtt6bnkt69pZyFruG7ClMrcUwJnc/+sffu9KHzkEUl1O6h52VFzk6lekc0P4+lv9tA8bcI0KrgSGTX3jHqXxni1fuBvXjdH9Jtmqqg6Nt7lf1lAGTRarNROFExEoO99xGriE0JYOSz3F16cv1jQgh+uEKRoNVaW9QmZ0u+u0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Vrdihx+NL4M2HXLqEloiQTaLCGwAj9lRXRULvIP5FI=;
 b=QXvMUVQlQOwBKWuhW+UrWKamSkcpC8OCw/KMujxhgyszLWGnyCgm5r7CeSipFtG8fiXxKsMq5LTdnoK2gHEKhFs2XmRw3T/Qz6N1bwz+/QTmChGDunu/qxZbqveKsesFzKMuAxe1ppQMkaf0RwG0Tok9FO3xeZBR/tsQowDjfMBdZOXLvqEFXLBtbFnuoDdm/RVn+ri+3axr4HENLJkOqE8udNoPdbfhnWyE4VVJeLMHa8nKk+k8T3lAbz+oyl7QzTYgsmqdkb/KHUGHQW7begyNqdTWBzbihSN8qC4q9sg8z1GmkA03ownMBeMNybgQ4kp28UoQtp7TCL4ZAJzbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vrdihx+NL4M2HXLqEloiQTaLCGwAj9lRXRULvIP5FI=;
 b=fCvWAGQVaK1hbil6qWcSoBOE3ZGZHclVj42EADA0/kQEHM06wNHaC/6D9MmPtrRoNvPAriXEAeTq/5sxUKX8NQPsWhNnPauQ3QSkdbBrvDz6ZE0GPLFfIjJM8hqLWjOzWhT+dpPQM/yf71qPoAcSRZo04MyMxYcTwPVdHt95LL99ttohGi+6K6rghVtXfuoMiMIyvLOwPlUlvp4HFXEqQJ0PYP86VB+rCiXFrd9EbykUQtMMsbb0ACKfeAVipJw38kPXJr3Pg+Vz4Sy1L72WzCIqgVXCxQ3x6suwNQtvhecc/PwRFOpwMoYd3RjOKUCz3hiEOP4OYzIEKX0tsyD6jA==
Received: from SJ0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:a03:333::34)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:08:45 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::d5) by SJ0PR03CA0119.outlook.office365.com
 (2603:10b6:a03:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:08:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:32 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:26 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,04/13] PCI: tegra194: Free up EP resources during remove()
Date: Sun, 8 Feb 2026 23:37:37 +0530
Message-ID: <20260208180746.2024338-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: e41b75d7-02eb-4a4c-2e8c-08de673d194b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9K9ev/WWRdLeSzrhAXTV7xYujig9/qKMoIDENLSJs6h/eAKIz4g6PuTuZi6D?=
 =?us-ascii?Q?x4Nl9mwki/6PyHMRj55aLUvBqZ21P2t6i9tA80gOA59/WfZaQkX/WAg+cLhi?=
 =?us-ascii?Q?NFTY8UaAI8yuXNjU+r7aqEvwjjkn9LR+gldYOdwHrQrjPnKaJxjsOdHE1u1n?=
 =?us-ascii?Q?+w6yoCGTul21j2/tFMHToBoNtE1ngL2gzSAJO0PhjWka3HrmkEpT2OBbfELf?=
 =?us-ascii?Q?00/B2Y2wS5PNDlt4wUjXS4p7lkFDqPJOYpF83RsJ4+pRtc/WrJEhQbfAPoYv?=
 =?us-ascii?Q?SrrbL46/NN/fBd+72ed3qliFdwdN12J1bXxNjU6CJCzlu8E2GuzlvDG9SdUi?=
 =?us-ascii?Q?4SwLw+nvair2vlVBwYVUasapvneLrPAmtQ6lq1Xyy5SCWSoqcPojkFFnGsMB?=
 =?us-ascii?Q?vgMivzgpNc88zl8lt8DRyxufvS4/AgSxhkNI5fuUqitRt/TysNhjhSpUDCzz?=
 =?us-ascii?Q?ZBPEHCDakfMhbhqkTrGW/XvHVTw7OhMQzd2NUzarc2YtGROEqrwqbkvwpMoO?=
 =?us-ascii?Q?ZqjuuVuZ7mbvyH3Ey8CjYlp6NEmP6mqIe+Z5Mi0gh0w/jNiatOe1XRtxeKbO?=
 =?us-ascii?Q?uzf/dfYn+zvZX3lLEdb5X0NDZek+bJKyVZlCPb2AWymmGPFuJtAEeL75SWNR?=
 =?us-ascii?Q?ABTlh0CztcOxVWMm1zQJ3CvREQVX9MrdOuUe0GPEtsAnU5EZEKuektsVrql2?=
 =?us-ascii?Q?0Sxsw2582juBa/XuMCbbkqHxK3U+t0fmI3thEXotW+EhzTqL+VE2sFffGBgT?=
 =?us-ascii?Q?kq0qJsBJ1K1Y1wtb3Gf7uyU4rVRMzLf385EBJjnS6drrl+VOdp4+i7ocqBPd?=
 =?us-ascii?Q?CIO0k3UYP8+DV29qdQqe/ugiD8jBD9Pc5Z98yUYHyY5Mvm9gwGpljiDbqaFm?=
 =?us-ascii?Q?9UMNX3FxJhfERV3iNSlJ/D5FDffR0ForJC+KVcRwUDLDDImOCVlYPor50/Tc?=
 =?us-ascii?Q?dtO2bAMHfaFih0MAmy87VUJzp3mVeK9GGK4qLdeeYCY49af3Y81fRRIdkxE6?=
 =?us-ascii?Q?Ym1uPgp0FezaZ8inMLTAY6X/P039t4HuymNE1ukKd2Nz2YfwjS4IfOBW+BSx?=
 =?us-ascii?Q?wxzWskB6sMCHFKpI0ORMtVWk2/whk3/8txcB3PKc7afSkm6suuRVvFzZULyV?=
 =?us-ascii?Q?6h0xlvTHRRTIga2DSu4blX4a30JZQZajgznMk7EvyueWMSVxbsWVA99LH/20?=
 =?us-ascii?Q?kCRzFqtG2P0odbw/fQICtOJ0fc00+ReXQiVhFz+DytKfcdNi7zwPC5Faa0lu?=
 =?us-ascii?Q?P1Q/ETho5C16K+9LCi3tEYanX3GDcEckergZCq4AV/frnaaRlwuJQJ8S47Bs?=
 =?us-ascii?Q?ntJYJzLElFSVvo+S1OLqCLAOlHle8e3xaofhO/ONRC8ZpiTkhE9kJkGm9FJZ?=
 =?us-ascii?Q?a5h3TBBdBs4tiY5G09lfUl5T9KnXJT6Zb6lAiO5ribHhKdra92LK6jW3pdxJ?=
 =?us-ascii?Q?o0/pKH0XNiiuEadP4Rp69ys2PcZEaQLHpWxqeIdEUcE+xmGATvri5/ygtf4Q?=
 =?us-ascii?Q?d28VQQYaUlE5OE+u8LS2uMxCcJSrXFHNmxrgkKqIpMkoGpL4rt5WcDN0DfWb?=
 =?us-ascii?Q?4bY5ctqBnW3NYwaS6fUPW0jqAJDbBovF5k+uWcXOer8YI5X67SU9sdsBrDBC?=
 =?us-ascii?Q?GXkTPhjl2jgrH6hD/V1P58VVZmHS+V5Nk2WPC2xMH1qUNwARBpbJWjq6m+1+?=
 =?us-ascii?Q?gKMNrRP00DnFIhClVYGzO9Yf8QI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V+udseubUEjn9RPgWWJryZWbCKCVsWwj0mk+tCq/MDEmCZ3xybSFHXHucs3mAYG4hrZ6OQWNN/auMxNTShvdrSlshEpQxNNH+F6XJAFQDiugV/qJibihDGVTnVb1G4HyqVlsuN+cDtN6y6nMJoN1nm2I98bruWIEPLkm/MUX9Z9/KVe2QpLf1rUh9ulEcC+Kojgz51zRRPRe6+pOuhiTpBEVjC/I4BgjJa1+xtRuJO1lrgc4gBbUZcWveRj4tC7fMEg+RIJwsIgH/NB7Kcnf0h3793tnGSKg3fv8bPTKXb95DtsbklWMJtA6oNBdQMRS8/3zgZ5/GeIrOT57c4v4XyQ8hmNGyy337ZzYfTZXdy5MGs/m8K98FGAfvN7oj7y+sIVpsW8cLd7lXsZiHILNyDXFOvtVV2CFnz6sUXjHQGX23vck9773B7ZUVT3lyeeq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:44.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41b75d7-02eb-4a4c-2e8c-08de673d194b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

From: Vidya Sagar <vidyas@nvidia.com>

Free up the resources during remove() that were acquired by the DesignWare
driver for the endpoint mode during probe().

Fixes: bb617cbd8151 ("PCI: tegra194: Clean up the exit path for Endpoint mode")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 808a1e213b79..1dba3a2d8eae 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2247,6 +2247,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2258,6 +2259,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_deinit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.34.1

