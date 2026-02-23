Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0610369220;
	Mon, 23 Feb 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872412; cv=fail; b=EoZjWGTOV4T2uKl6JgycIaPQpYex6ws6Plfmq+b6bNTqKkpZaHOqW2aWLS6zozR/rHd31VeXFQ0F+jFXnICpDDItCV9b2E9rGXWoYlULgD7Wq9LoTG9SxlvKjZ63GsRysQA/Cq9/jbAVxqNxxpM0MIdGPhu+AZPbOuCXtK9jJEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872412; c=relaxed/simple;
	bh=K/IdGnvzluQiGqiLqFLb5XsNqE3SvuI8zHdxt3OjPps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOMKEXP4A5QYg91QEEdPhFDBg4tDdvNinWitXlMmC9h398ZdBduWWLu+1w856Zf5kxn79gAFFVmjpH+byBrhY2V5t47ao2H4idaLXT8HKGaXG0RGilWWd9KdLJFH4Pb50TvivsmcDFiRaRucMaWmrXN1X/Um6ZxOzM6W9oFKHvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QwScmZsE; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QwScmZsE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTMvLmUndg64LO8J7tln/8FyL4YGO6U8LuHq/7xTs/s5KCggsiCQNcyWLVdhaqKZqbDGxzcXzqRZ+m92cRteLV9NpB80vesp3RCx8HFsVkguAPXbO0fh6DEWvwiTrI11hVKnBcqoxu6yX33tzNhkdCUBWJbU5sOZwgQMDATyw7RWtGSyJrEPZg1fyXx0VrRhwllADFz0ncZFaxMPDgw88kQiFXYy3aZQ6zbNoH5AIDID8KvzzZhPFcf3/DatipNQLLYkDoegvdCEQRdmwHepzSjIsZApSQ/1Q+sG6b4ApxAUVkFP00RaoynPYLkd/z8BXYK4F0P01deKFk3Ho0UjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nJ+f2v/3wK+F6tqTx1Y8mNd60idMqUzpG7v1UR2Zmg=;
 b=dAc3Wq4FxZA67fzwiUAd89NygXn44S5AV+1tYcWGjsbYS+Xx+K4hfgHYKsbCncRxooClO3IsflEZ8jc/DWDBeZhkZOtCFfkOITwyb4OfuBnW7RzeBrIptBmXlPb3CWnL+A8AWu2fzLwqg9jb6p7Wy23eVhpGeaNRsNeOnRub5oriuR4Zb1DD5vUWsyFSXRT4ueORs0a5YOMO3CRd6g8C3ZNVp+zl09WKNih/Zh9TmNCb3g6sDV4BbsybvmkKOwo9eSuypVvsfagkzvCY12HNG6+BMT0c7iPv5lZkxXgDog98O6oScY77FfO+RLpPHGA+4qwEceccxO/GH+Swm3YTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nJ+f2v/3wK+F6tqTx1Y8mNd60idMqUzpG7v1UR2Zmg=;
 b=QwScmZsEvaxcEg7/orkd3K3HiM88jTPbiZL8I8SzFksbFnuzOayiyce3rqbTtuT+SU/gv+BKCbhY1+R08V6CXWFEugMnDHwJpYFbOdFhdh73CMybFVVEDKZt7DezfexPYFU0wZ3dhIhQ2UE2FhcZ55nX47BaLpuQ13FrXXYM6HQ6SH4rAUrDyjDetl5ej/59/6w5pBKcrIpWqgvUDGFt8AlvAoCSMNAgCY3D6pJfNDYs+eCDASlQ4uu5nmsV3oBHzklZCjnxK6iT/GCNshS5ngWOqiZWOAxe3ibHhGPa8rD10GldyJTHqxeqTFFRO8bhSDO+1r6BaUbq1ID4PYwA8Q==
Received: from BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:43 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::fa) by BYAPR11CA0048.outlook.office365.com
 (2603:10b6:a03:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:46:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:21 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:15 -0800
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
Subject: [PATCH v6 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date: Tue, 24 Feb 2026 00:15:32 +0530
Message-ID: <20260223184538.3084753-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be4cc5b-b08d-4f92-c2b3-08de730be350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgn7ZV3Q1RfyQ3D+otyM1thmpqBr9i2RxkkxOiXKCLcAvEWkKqe0aEhCnTmP?=
 =?us-ascii?Q?HnUH4z0jmIHTcTMsJFa/nBBOyQ0b0Y0L9lYp2FiGaEMzIBOmmBOhZNz/qEz3?=
 =?us-ascii?Q?BFrVtrRw0K4w8pza3Ic1aag53crSvXybRR8L2I585n1LDI98nky0km/mcEe9?=
 =?us-ascii?Q?dwGs6++aTUzTO97u9EyBXdUfr1qxLP8RBDj2skSBA5EflD/uLoAi8oZwCMm3?=
 =?us-ascii?Q?Auo2petDdTlYl9iHJDj96ts9XYX0zbHGaprOVWhXbwZt6068wA7vNXPnzw3B?=
 =?us-ascii?Q?XU7xY0rx9+O7F8alAEqRqBX/FIYfaPbQN3sLWJVAPE+gs2EZPuGJhdd13OTD?=
 =?us-ascii?Q?bfvUcv35rTHfMOJU/+AIC0oRGT+4ZFBVCBaGhg0IJaI06FFYucysLwBUk+yR?=
 =?us-ascii?Q?DepkSzJg9AGSTdcTKib1TCSwyBGVKayoszSMWYpFOa419GpcvoBeLEKEWtDe?=
 =?us-ascii?Q?vQGtGFtpF4fNSX0oBqOwBARNEi9RocBJ1H4zh9bqLWPXGmBYLf5gOpOTMGUY?=
 =?us-ascii?Q?WXxZkJrU+5j9t7QxW1UglKctdtzuk2eNjEiFdMTFHWHeNJvaeUXKWhuBkrhs?=
 =?us-ascii?Q?im9vDx4MeBIn/MMr0vIqnd0x7UslOT4/X0SUG06mGmXO5YZjaNjAtxaEKcmo?=
 =?us-ascii?Q?/+Dden6bhltKj6HO13OUerMkg61aNccRpZAtrDYoj9RfZhFk84SkDKLiC+02?=
 =?us-ascii?Q?xm8jMxHCo6c6afP4LDX+ClYVtYUmJC8+i0QjFvIKj3ztf/AZ6uQYJmOmhJZs?=
 =?us-ascii?Q?hzh20ZZs5SLF2XO0/1v/FikA6BX/DkGdtG7K4U+Hx3w+tUflz9P8oC97++h8?=
 =?us-ascii?Q?afrS7RsZwtrtbVlvCrgjPYAFTum5zGYVV64c3xRj4dCMGPojLEUU9fdx4tML?=
 =?us-ascii?Q?6st/LD893PUTHe3YQWoLENf5OY/cnfao5545+fB9u1Cgsj+uB6WTKVjR83Ra?=
 =?us-ascii?Q?4TYu80y2zxOhJ46eOcuLXknG4mJTrTC43ivZZaPbErbzMVKCgLaaehuV23Bm?=
 =?us-ascii?Q?mNePJ5Z4Ulj6JYQDx1VL7DWjuIGSIoxkuRT+ea9lI1HLLSoX6zz7dg6extOA?=
 =?us-ascii?Q?ZN790xFp2htMGAZPgNzdoOhcdWeU3E29LPnp+9LeD4KbP3px+xXi5+GWKWm3?=
 =?us-ascii?Q?rIoBBzhfEFXt5IRVO9TbPX8gGgibO5CZefzfvaO2WA+oCpIx73W7nMB49vzH?=
 =?us-ascii?Q?mV0Y7qVzO/EVq6zad0zLMlCiMqz4UOIA4Fw7t1q919YJ2wBqOvJpAqlxcQxQ?=
 =?us-ascii?Q?hJ81dTdb6WtXPj6ZwGLWWZdUScLYZbxn8rFDThrZIboZasqUzsu6FyTqzen8?=
 =?us-ascii?Q?eqXlKh4JArMlkZjdB3lKeEip45/3wSYM6tgJB+rL9toFEC1NHQq9CjFoxlmW?=
 =?us-ascii?Q?wCmP3JasQmGhwNXJwKUaS7a2fBq/olkYDNJkBMORiXocGl+dgBpJJvA1SZ7V?=
 =?us-ascii?Q?N/bZ9M7YdLbQreSeqHEbLrg2O8bS6OtUkjS55fMia2SfJZk0efboxqlWsl9l?=
 =?us-ascii?Q?9OuZXupo6EeYryn7qw1405G262uNTRVxgKZaWVDi/J3EhthZzEZkybCJdu2j?=
 =?us-ascii?Q?cUk9izRwvooVTcmaaS5nGmbwYnTxrNRvwX3ghvWbn+PR34m/XHh8IJlEp+ld?=
 =?us-ascii?Q?igf0wSpEzXjleJ1ITKlldjaY4yVUKHoqLfoI0ankk4SNJcWXGrUQWESw3B94?=
 =?us-ascii?Q?whYFKJvv3NnFiMTsX0yX6SU2rHI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z7ZVzOVKHdSJW7gnBSHwJnVdJAY0MT2evERNdoYo6GseJYWWL4NLv9Z3kyLfhiV+7F4jCRAwNFX7P8UQfyRNw7PMQzSxgrEd/IOSemZeOY8rOhqHxjH03uH8wflp80NKoTWS8z0fx5fX/mY9VGe6kaxCimL/rnT9SxIZ256iQj1tb4ew9+ujxsvE7ESF5QWRehKQvoMH+Eu/Jy1cEVSEbaAf98NQLkCCUQnsEycmKapMt541BstVsgymXimh2Zg5e8yb4VsZwzoWqPPTrMHQz6kAKzQuhOtUGRy5rRREUU0zw7CMkT/AsOi3cTBrm8/cm2bpwQlR+YQjZmC1uQvlOq7bGsrHJ6KusYzsg9OyFEuuXJuMlMs7zBA2IHY2nGqxqtu2eoiYaqQ+SXfXvrNhRwQj3VT7FiJW0ZYHe5MB2DJY7JrUf020MuXRtZOSsuv4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:42.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be4cc5b-b08d-4f92-c2b3-08de730be350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

From: Vidya Sagar <vidyas@nvidia.com>

The Tegra PCIe Endpoint controller has a single interrupt line that is
shared between multiple interrupt sources:
1. PCIe link state events (link up, hot reset done)
2. Configuration space events (Bus Master Enable changes)
3. DMA completion events

Currently, the interrupt is registered with IRQF_ONESHOT, which keeps the
interrupt line masked until the threaded handler completes. This prevents
the DMA driver from sharing the same interrupt line, as the DMA completion
interrupts would be blocked while the threaded handler processes link state
events.

Removing IRQF_ONESHOT is safe for the following reasons:

1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
   clears all interrupt status bits in hardware before returning. This
   prevents interrupt storms and ensures the interrupt controller can
   re-enable the interrupt line immediately.

2. The hard IRQ handler explicitly checks for DMA interrupts
   (APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK) and marks them as handled,
   allowing the DMA driver's handler to process them separately.

3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
   notifications and LTR message sending. These operations don't conflict
   with DMA interrupt processing and don't require the interrupt line to
   remain masked.

This change enables the DMA driver to share the interrupt line with the
PCIe endpoint driver, allowing both drivers to process their respective
events without blocking each other.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: Updated commit message

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 51bad99cec31..aeec5f8b9842 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2226,7 +2226,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(dev, pp->irq,
 						tegra_pcie_ep_hard_irq,
 						tegra_pcie_ep_irq_thread,
-						IRQF_SHARED | IRQF_ONESHOT,
+						IRQF_SHARED,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-- 
2.34.1

