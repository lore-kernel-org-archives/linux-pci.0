Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7A2DA775;
	Sun,  8 Feb 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574241; cv=fail; b=ZCUWGaULnLoVdZUuSuScJ3+WfNHcpVsMD9Q2Y7hAOLG2KM2UapWdlNdhlHE/u7qzOEuw3nDv8H5Nby/bvMQtMMGvMTgEDY8aPt9U/BVVeDwc8Zykm6UuvicYfvooH+W/ef3VJXFLPtSWKo+dlwmZeQWaQCDFt0SeSRC4PPj0PDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574241; c=relaxed/simple;
	bh=rpQ8vxxhOqsMNXNmVsHXhxOc923oRtEjMEzeMDQUypE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDgqQ8epujF41drtQiHncpBEH+96Y9X+tw+oJJBOHi5poz0Mds1SOBkry4CA0ejLnNpY8nmvCX/2ekFB4C0Tl8J2XbEp1oJNhaYtTrbBb6pBfaDQJy1uGO+jfTF8Vl4nVhE5chf/ZROUdtw7euyQFQhJBiUqNZRVyo+BjvfrEaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M4pfybId; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M4pfybId"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0IdXnyliW85XsUnnVGhBje8WzyXaSDrIiHTqQ9WwnRMIwwW+4NFNdc8D1Ec6xeXVP787A6RojonAUbj0j2p044AUpDVhxQW4+FyjBdpnItkbHwzHSVtjU3rE0/SJLtotNZq7hqiNdUYaNszI6H09jLnmTiIELDf4iNX8xwjaMh6kePKff9grme1qUHH+wSSlwa8POTnH3xKvxNbC454xjof7R+VGLaSUUDR5DRCosYEVXattt0GGcI17uWqVSQ5bjaX9Gk+FffC4wJTyPvZW/CyyUjT4gQKiXSdDj1sDR6LvYGWiK8qqeYtmYSXb6tAfpGDsjd+FcQ290tcJN1QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RymD9/cPvfrnZdK3ZjsFVtm4623yoJ3by4AuWwTvnfI=;
 b=ZjkEFGQn88uEFcBqpZkxfu7JfwXnLFrxaVneRfX/VGjFfmVo8fOQCYFS6UKi/1Mvb+9rP1e4QAzbiKLqWJNv1M3NDH5dj3gp40rafgg/x8gYxfTSpRwuMajoga02SCsvNKbyh86W2YpCUSKSfVNwyagEJrIFNCcnJSwNHjApqSMSFwlytQJ1Mqd20ZZN/9UROChUFxaX1K0330gSj0c8yyFwpepJjtUsSuVaIZdOFCuI/RmzBDQj4zSyjHwfbIKlVVE4TYsqFkAtcKTww55zUAIm3O1QGXL6Bh7qbVJ6/Y4Qea08STxaPRCX6uAXIObZQczwc7tqHqNgsE2BGoTcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RymD9/cPvfrnZdK3ZjsFVtm4623yoJ3by4AuWwTvnfI=;
 b=M4pfybIdzQUczQe6cOqw0ZRDRUVXsJPCmZ2WrKdzIuA+ll7Md3MQxEz9q7ZCR3VNECkMa4+3xEoyhl3A2luZ4d4mFOBekc0444qH7VyJppHnxL5DDVs9CZIQdVGmnIXp9Np0QyA8q3FJuQprHzT3MGPO4VUUAeX+/P6AoHHlEBshtdAMhs2dwnf5aFXwifnDaQUC3Y/ixG+QqwyhgudANmy7xPVelQ2XFtfD0M7EW+eH+2Bv1kBGF8TCL4ibsM0MYEtrXLR4lVadvY4My1CLE3+gdQYyPf3QY6pAUZ2knBN2GPAofCKnjeVst7rTzkQHg+S1vnVxYqxRyUzmojWE6g==
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Sun, 8 Feb 2026 18:10:35 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::c0) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:13 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:08 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date: Sun, 8 Feb 2026 23:39:30 +0530
Message-ID: <20260208180936.2026329-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5031ae-0ca0-49be-fc62-08de673d5aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYOeOYzIMw+ophLOlNcJ4IJFhfNgp3AHz2P6Fbqxvt1gAmFaTMHPKSMv5b2W?=
 =?us-ascii?Q?nZc/meh7OtX2QT50Qo3e0NWr5dNQQkkfoYAQbp67s8nmvRer/qNUlOg1cwwb?=
 =?us-ascii?Q?WeUGLwlLq2AMI0hqp0C/o2weu5yGdJIFRtV3Xf3a/2bciJ8EHWwQMS0BET29?=
 =?us-ascii?Q?dDuUzOQGqK7mMpsM7kT9EYRwiAXfXdmPvcbamlZjcm/H8Eb7qxwpLpXzwn1+?=
 =?us-ascii?Q?pj3T8p7M2RDWCRBTXirjj4t3gHVOovl7HtrzwtL6A1lE+w4zlrn5VSZfGN8v?=
 =?us-ascii?Q?Z5EexXUaBXfMxMNc6e57P1cdk55QSs7PsPTo1TwRBqERmoSssCG8schsHF3q?=
 =?us-ascii?Q?qlEdls3FaR/GZs40GSZ/zNuljhAGBnG+LByesf7EjZ4aj3dFkiIngGT2S/F2?=
 =?us-ascii?Q?zuJVnfBzgcnhOGVaBNFltk9OyQeBpV0BkDC+EJN+uSss737gOP9i9JwfJKtl?=
 =?us-ascii?Q?Pzt3qA2V+WVzO60gUedVp/+n4tFLXrm2AvRaCuD8QlUMnURx8ZFn8q/iaSqX?=
 =?us-ascii?Q?0wKcHRD3YyCfbALzpaiZP6bxiCP1Z6sjYYVrG34VxII/xdQDopOotFFV4gBR?=
 =?us-ascii?Q?SCJwB8j1vHo6aSJq3MMtlNWKq7S+LwSb4hm/C8yblXzlS9wXb7p5M7ABIdSC?=
 =?us-ascii?Q?lylbevWjeYMuCQZSC3DZM2a2eLk7fzJ4NzDwhszLZfMoPNM+PROeoi7/oieG?=
 =?us-ascii?Q?K9vTZ58+FPvME7QT/LPGAIDhf448gzH5e8IEHoWnyncEp8dbL25xcl4/y0qI?=
 =?us-ascii?Q?vbqJaXgN/ypheGJ2fUSGM0gLKCO7VQ+uQoKZA6+LxEoHteXA0lOTGYkn50o4?=
 =?us-ascii?Q?dNhwoE50QpcKLhnOCNS7EuqoFAT/DU3pXd7BPnkl9dB2vrf04J+6hx8WeR9C?=
 =?us-ascii?Q?COPotnyqIqZ2NZLXGhqGr2LqOvuR4hf/NHPgi2eoTt91DpWCN3S2u7+/6/mP?=
 =?us-ascii?Q?1XEEBSkqBR84a7TY4MPbHHXNR9V7Wh/zJX0Gv3dEDIuXoC4p7WVIHdGJOUND?=
 =?us-ascii?Q?CZpIdykTEvi/2f4rPU3Kec1A9IZaGfz6cGLGBO9oVX130f6CHFg/I4eVlcJf?=
 =?us-ascii?Q?foFdqdT63Yhir9gUbn3IQ2DkJ6bbFpSgskSZ4ofCLSXWY2tfbIt74jfXOpoI?=
 =?us-ascii?Q?OjzoIYaGoAlBmR7aoqniksnDFu40K2xVKbTaL16SEj56QdWhLgkixd58FuEg?=
 =?us-ascii?Q?U72ie8RSgXxDQe17rg6A84nfPYTG77h2eI3vBNIA33NXrAGHc64DbNOT6uWN?=
 =?us-ascii?Q?UcqIxcIAY/s+MoK7OokiNdGb8ftKc9hjdkE3mcRl/mpbP4BAJKxGAD266lP/?=
 =?us-ascii?Q?AWnjPMwLoFh5lB+6M/nGJhaFNNCsoP2POtGmxmvELz3mtixQInSBd15pMoxg?=
 =?us-ascii?Q?xVP3JmUWdsyV0q7bVKi0peHVx/hutFNrBW3HK8klM1TQadZY30bFdni1jO76?=
 =?us-ascii?Q?EmI9sn9d02mdJOhD0ggLSoDz3m8Xj4gh241AZQyLSRyXsmG8d3rLDZsLb648?=
 =?us-ascii?Q?XYkvGxPH1n2hSkkdlfFKYFq3NdijFP+gSi4ehoKDbiouQyQrzGnUBOQ0rs0c?=
 =?us-ascii?Q?LxSOENT8jWUSHbldSSWQRy9AvYLVynNjQSof9KQ2cpimij7c4z0OVU8Y7sGY?=
 =?us-ascii?Q?tflhpTnDUeFqTiFqVmOnDyK8g98yRxawi8r0OCTwiW0qQ83GNDCME/LPaOfN?=
 =?us-ascii?Q?/UMrpDI5UY4mQYD+nDBX6I/UnyA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kK34qlF2GgSfkvRneVDKiwpq7CDWtUNTm++p7Q3zpLGJnyPN/tkQXn7U/j7ySb80FuZln8xxiQdcTds2nPBFGftU+duiKi6oTNOv1kJaITFp1sGp7PI8Q/Eo+uU7UkfyT4rUmBP9oqbWIPd8nckNPEPngGll0Z5FA/oD9/ZEP4YpR/M3k11BDtS02NzlhP0jiVEs83M1WTwt3F2GTKZC4f00lqn2ctBoJKg29pNU5QaZ5XgmgnscMqb9n/PxyKPGdqp5PkXt/XlgXfettNWm4UO9WmbwbQMzbN+flvykORi5UeMFpD3AX7lL9UDqYiubsZ8Sqjq8U2Ntj1sJWqNMsxK64vlqmlE0/x8t1WHv940lyBsy63IJhRLUi9jQ4WrET5UVljkn7Sbmn8HdT/1GPR7Wkzw7cMoS80JnL237ZCzmZa7AGcS4elu/AWIZWo8M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:34.7997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5031ae-0ca0-49be-fc62-08de673d5aed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

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
V5:
* None

V4:
* None

V3:
* None

V2:
* None

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

