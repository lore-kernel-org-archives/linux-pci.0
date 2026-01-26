Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9A311964;
	Mon, 26 Jan 2026 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413666; cv=fail; b=e6GqabMsWXL1UoNiKq6QX86C0mczfTff0HftbzR3vBsnhUWK7H5tDpqwqrYRENLtXOY8XbirClGnEAa2x7KoyWQDTTwBDSHJosGte5QDcYPMdwtiulUnqvjLCMVa+/5Ilk2vv5ZRe32GsG7eHnkqiHfw/K6B4IfeXV2s7fR92j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413666; c=relaxed/simple;
	bh=8y1TDj5hW/ET3Uoawm8Ft9XdXTsWVFx7MnOklkWMCqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTtbwmJX1z5cXiptgwCOVpqqu4p7x0BLBQI2kjUCR9PJKVyiYyRqtsq3lz37cDdQw0AtxcHiYlh4OOAU4v98LLDU4LNAmg9TvkAblpqVVz8lqJB0lu1rpGXx1zu6DsZL17QmdWUlT8cClsxlClFkYmaWp3oFBuNgwC/6UcSo5bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t32Wfk0a; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t32Wfk0a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cL4tr56Kv1Gm8ZH5v6b29peaHIa97IVOXTneB6GD2cVhJkf57SxUR7k5UxNd6mqWSqSn6PzKEbutGP63SiriGh2bWF5MlyYzJOksYZFeIhmtx4ShUVP4lkc7mjpTSp+eIxjToVhZVb37LTHE6ixElFQSdmBo7PxlBgTxDw2WeUjEkHq+3ti0oHkwqF3S3V8lHCnf1ZxU+n+xtqaxoUaCS4gzljUMwiNE9655+SuGBKUlBBpcmWKuac0xuhKSmeEXun9M5dT/4AJN4XIvgENeAyJhsmJuxMUOlDMpLjeJKRfjTVNznV7UKfFbCV9QCL0MUPOxtVF1vnEjZmr3qUNwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glKwOGdTjEo4YGlfB4RTLEqEVPyoINgMjFgPwghRZD8=;
 b=Rkyw6mwTzbDcJONPoKlhtGUZwb0HCV3UtIgxLjPfEhCelqWOmKK4Iea+iAkqPoChFJpsWLutuPoZRFVGWWYvYJCE6AVIewauW9xoKHowf5B3o+pAm4Z/OfKkKrQVoP7JRrvzAH0zPx/m4lMRBP3clOlE4p9K3ol92Uh6eLnphd11rkKcOWIEqp08vSeTC2F1v23yFXEyuq5JpghOcqpErVEN5vVfmGc3w4kfnJLIH3BDvU/LvaTGN7XhroDNbB8bc7VSyP0E775+muNangZBUpmWHN1sKhEj8OWJD6faiNjTjrAajlxZ1UWCV+EU+Jn4zMGraGju4zbAfsjb3VgVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glKwOGdTjEo4YGlfB4RTLEqEVPyoINgMjFgPwghRZD8=;
 b=t32Wfk0agRULNcSpdxyTgmEzvROfVsbu0GLmM+WHSGvpFkj7f+bMtrjx9fQPX5g9f92EUI14Ikz5afNE88wqgqdzt8rUZnibNv7QnXDvkejSd90YnOVwf2SUqLymF+kTSeT6O91KVrNBbX3DJzVVLrAScfGPU4Fp8SbRFSoUCh75ikdp190bPlqGlJqywpCSvMgh1XoxzJesgwJ8V5H25wzZDhM1rbY8AX7t1ZKbrArbIBn9lRTTlamqsrhAdW7pWg2ozlDdx/5H52IStFgMeyn6J2JzL+9dQ+gqmMA7c6UoM+haJhMfCRz7ncRirqwfREEDE6ipCDCYABuAMzjYAg==
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:41 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::43) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:18 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 16/22] PCI: tegra194: Free up EP resources during remove()
Date: Mon, 26 Jan 2026 13:15:13 +0530
Message-ID: <20260126074519.3426742-17-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b484ac1-8ffa-4622-500e-08de5caf2ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0ym+MNtr3RJ/0DGqwCyy5aLqWtX2CIl22+pH3QC6uMK9mU6wmaWEt/t4oaj?=
 =?us-ascii?Q?61ubM/DbeTWAljxgFsFEjV8XGJliwuigZAEb0Zs8ZGSGsml61oGJeQYguu4W?=
 =?us-ascii?Q?r4QYYL5Xlek3/tRhXwhyjlpfjWbWpefaVHmHOmpPSvD/hhezosWLVjAFp2sv?=
 =?us-ascii?Q?xNsnOaSY9v5OIXKjY0TVV4v3Q+lp8++Zs9Smf7xelLODV0cmWJoLbI8oHwqc?=
 =?us-ascii?Q?cJ1WqocZOj3sAfq1mJifITKv1s3MXlG2AqdTe4M6DPx/7khgC+iO6g/CBAyU?=
 =?us-ascii?Q?xCHHvaCtUuP44Kl94glNegJ+z+BGIO96bj/+fTGMxtkUAaLYTDeXutESZkJu?=
 =?us-ascii?Q?5Ur46+jnD41d3E0OQ1AEUhK0KK4Z15I104f9FuwgwKpl6+bkuDLelDvFwTlm?=
 =?us-ascii?Q?CrZ83aitv8/jGHGMBj9vrhojCbqyZ3e5CteLfRH0/T/Gh4p6WlOVtzpi1cPb?=
 =?us-ascii?Q?sqq7YtoNN8ueS0JHFK/nmDjaNonWdxK8G5OTQcHRpnOAO3G9W22f/T7AQ8Fm?=
 =?us-ascii?Q?IyblWhkoVjgvtLHnTmD/7ZfLxFsCCSkeIM4d/V4eP4H8GyCpqSbQ30lLf4ZM?=
 =?us-ascii?Q?6KKmTWt1JRT2SSi3labXA5JF+oRkAc/k2wb9jq2VUZFZ3G6Q5KQbMjdKzX9i?=
 =?us-ascii?Q?XimYX35EcDKWlwqUzjdw5/f5ZHBZx+fWbAHpgn8gi35shW/USKjjJs/uedwm?=
 =?us-ascii?Q?Ffay5TT0gWfyxDUO1vdn7JJcNPh/MMqgtrLFhSQZLhVxwkAsc2T6uJMOmEf0?=
 =?us-ascii?Q?VNLGxjOt1XtN3FGlFCRF8pxuA2Q5LoM1XWdx/r8MgaAJoLb00L3ZmbrUTGEX?=
 =?us-ascii?Q?GwugHZPDerRlC95SPcU4mTtXdoqBxG7KV9f4w45+Skr9kqdlhekJGEgoL1lA?=
 =?us-ascii?Q?UZf7AElCpzhf7HmDqAatnhi5F2V+g3DjcBakU2Uhx9Va9lh+yw3gyYAhjBud?=
 =?us-ascii?Q?DBBfYOQAth5RdI6L8IZTZovNPgskSInSj44+USPJz1la6aKFXAMmT3CnykOy?=
 =?us-ascii?Q?HqpaA0/uM6sEHypEmNWAAxMTGxnRiJ9CD+1pbHrOpo68boQ5EdrWW6HodOaa?=
 =?us-ascii?Q?m83APmuSiVireZlJdglhsU//ERhztGTXR5goVb1u05/C2z7Uhzb19M/mdwNW?=
 =?us-ascii?Q?ohZ2gH0htMWL0re8u0dou0e/7YZQuRrVMdplQPUTJXcZZbhVX/DHn1Odn+tJ?=
 =?us-ascii?Q?J1Kgss5HEzgQaapETR63XttGLhV4IgUgXgncLSYFLJLlnNBJfsHLl2CoCjpd?=
 =?us-ascii?Q?/ry2BNT7aFcwLEzqcPRREOad4Q3m9H0sOLSphOQV0oaaRA5AW+Ne9LhkzRZf?=
 =?us-ascii?Q?dCDD27Mmh2W/Bu3i/i0EK5TtyaQoPhm3g5yJ3kYsRHysr7Z9gSKyvKBHZm84?=
 =?us-ascii?Q?asb1WRhnj/NfVbhLN+1GqMHsn0yXhy/f7hyWPA4nwbDQzu0jbp0YAm66T7O+?=
 =?us-ascii?Q?Vgrv6ZyBh31QbifMiC1nb/YMEfdzAksEnfKhnNRgS5Mh/by7T+TKP+Dve0VA?=
 =?us-ascii?Q?NPc8qIFlI/t21IFbqFT9luhXkTW/TkAn7XX4a+gn2ZHRiH0en449OsNQoT8m?=
 =?us-ascii?Q?lqvFQ0FrNvF4ka+gTKVGtl+9OQv9jRKVtaNEjFYPQ9XBtsOBxS5h5FQi9fMi?=
 =?us-ascii?Q?We5obP0IJL13utkjwhdopBKAe2vjZGVowwfGZEe7eFTxlV1iBAi251/7uos5?=
 =?us-ascii?Q?lsxloUe1KiPYlMNuhFH+n2k2xUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:40.6913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b484ac1-8ffa-4622-500e-08de5caf2ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

From: Vidya Sagar <vidyas@nvidia.com>

Free up the resources during remove() that were acquired by the DesignWare
driver for the endpoint mode during probe().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1a269397150a..d490dcebf960 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2297,6 +2297,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2308,6 +2309,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_deinit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.34.1

