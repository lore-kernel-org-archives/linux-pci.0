Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AED3CA483;
	Tue, 24 Mar 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379477; cv=fail; b=ibSXC4/EliHzYO8mo5fXKY2pl/xuKUEINUo43I1Ce8bqwW1Gnh11YvZ4X0maCDcPOPMDXdewI6FCX2SAVHm/txxu1zU3USH+sAcavbTF0E+QaZ6WwCRAMvOuq3vkKaLcqwVddQpEeAZUv4ylzp7dnRIjFUMXn8tbjXoMrrg2V3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379477; c=relaxed/simple;
	bh=A5toIr0dwIVEff3ENr8rO82o7yUjX9q1MKSD0I9S7LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGWB8xCj78Mgka1doyv8jhVTHDoNtRXSrGKR2CrlMX+te48MlexeKMnCzhCD69T4iPgc+f4khRPhRNAuHdd6/tQzOh03gMrPTiYkORTRHgIKcGaUyjPsHpzYJmO5NIZxqpPoTB8x7gRVRupMF4GNrowAb3XWj8jZsUGISLWSR0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pw/QQbNL; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pw/QQbNL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8rpLus/A+b2MItkdijEJRNz1/I5LKrNnU4K5I590pbHjxTOr2XryY36yrYcn6OrMxQJhabwhHi3Aj3zWJYTVl5U8AJyxUEOZ8+Ma3xWKSH+4PjAJ7kxXmCP6qZ+Z8kKvYAK3yksAGBx9PmLQZNOcG6RXcjGLFrEvI4hxe3eEMc3NPS4/rU3F9Q/cfEUUGXVXLj+EubFhZdEantAHNLWPI3mlGBiMZNjud5kexFTKuJen4XApcK9xFABR/ziyhX0LjlX+J/LW+iEZkdCtHeegWpIUoy/jy4ljGq2Mvj9WM8tddCtv2NXQun6UUGBEYjD83pXho8cC54ZGeG/xTs+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQChoUAs2bF7p+R2xRBJ7Igjh+cHrYC8I7xbDgCPmp4=;
 b=lXL5uUPT5gEPimZK0KUx8JVL4oeDKDi6/AckzBvDxbB5IlkWdbzKy2lvws8DXAxMnog0of4CCxNHMFQXUvnbs1pW41Av6NQZl8FpYV/qCc99vuKfNBqu3pQVp8OoXcpG9F+RLQB3ceCmo5wA2JTOmrC9+KXMciHM8G/CXGHWhiEMYLGXCaDuPMDTU1uZ48YjZ3KL/td5wVWs5h+nLedjBQEx0L8S/+UrUJfCpLnfUn/EsWuxuFspbpUYKO4Dwi7FE+JfPBYXT+TPrn1O5hvpdjU3WCoIgQ2UGTZrJg9+Q0UzFA3xX1SibA8I7fU2hKKJgBFX/lh3y3KC7PKFXmDmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQChoUAs2bF7p+R2xRBJ7Igjh+cHrYC8I7xbDgCPmp4=;
 b=pw/QQbNL3sO/21rvsNp2wEGcQDg7Gtre8ahzxuj+KjNP8Wsf83R+iD9ETrPCF3hWF+kENTaaT0WLdSe+gKa7iEScYysWoIYihbgTp7cSqeqXfbhriiaQroV1JbCzRIeAUB47mOf+H4IAX2UHg/4sVCAZq+K7ZRkB1DSrYxIyRlWwftMyCZQ+oBqYtMLodz3ot72/sfwTYuQu4qQ86GhELd6l7Rsfv9vuxVIU7iLqwPLcKHI8ic+eOzON+S9dm1ZuhrD7K9mH+IG3uXu8xWoJ+qjGrRa9Vy8qM4PEbvs0h9Y8x8X99quByiOXfmtjrMMgx1m3Jatk5OujWGlKbpTsQg==
Received: from CH2PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:52::33)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:11:07 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::72) by CH2PR04CA0023.outlook.office365.com
 (2603:10b6:610:52::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:48 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:41 -0700
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
Subject: [PATCH v8 4/9] PCI: tegra194: Enable DMA interrupt
Date: Wed, 25 Mar 2026 00:39:55 +0530
Message-ID: <20260324191000.1095768-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7637e0-1070-4d55-b836-08de89d91a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CvjZfWNhmMKDJNJ+ZwMayaqUDNJ94ZK99sFrEy9aT8Z7OaPVqbVkMdiyVfhVY6X5oLjGybHsMn2d1yKUEpSDdIxrqy0CKE53E47JWenmFCSSo3UAWy/7Fs9bL0scJFX3ry+7RsdPvmQYqKHsvKmmAN7RlfGDO9UETroRYz/1vW024F4YR6dvEofQ5qQqvQr9D5Piy9W0BFxZRDTyHo6f8tbMJ0iv4fHxbG8OvEyXdv++x81P+THeDejqRX0F1KCDkIaMuS/tGSmsLvyPHYcHzwRwWnNXwuX4aU2Nau4vWlLqzJXOIK6cLT/EztaLOqgOqq0RRl8NDkojJfYfsq31S0aIuZGBsvxwZtwIvgnb2RiCfiI4Ticmwx2SDtvsfLR1tGr5p3D6HpvGdzp2KOYhR7Tq+D/rAjVxuEYHjh6lvnY7IadhkhGUujK1bZ0WlyW1Srv2FuTEvNBNBBXrXHLjs4S9Cip3mSmD+Ueb38v83HHOXmUX/UouTZbBDpi+prK3rLrRqlAbvni1rBuBvbWgrRhDrMUIXQWBia8AZae8NN7c8viTsJR9Zh2EOqErv0L+tkOeCk68lKE4cngkndk89O33D8ACPS+8KF0YiyCLeLq6GMH5S2yli3fXGSVgvQ/R5izFPubKKOk2flUDKgN6IHNhJlcqNy0aE02RlqAdh8pGT2U4SgBwzsnMAsT+GoYA1wc4WRSAuwYm/R1SW1c7nUUm27/qMosWuScXDR0+J/16ijMzuJlS6PJ1PAXMoKWYW6M+RTCqnEc7H3mrog6sr++DEZxxVTipKShSosqZ/05YscwnPUWQAdBUhQI5nKAf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9M6Jt2bQr8+JUQGTKhEIggJn4yrFHkdfB7W056j6x/8d/ZXZqjQRz5H+Pg06KuufTt4vX1NnbiIs81qEwfq1MHq7C3hJFl3a+jUF6NlBQzpi8ehGJWCA5MCMbBkEUJRjhjMipGy22WPUtJrydS2tOj01pviBuFfFXFZNprWd0Z2K1if8Pp5xUZ9na4/DlOjHyE8/0E/DbPcHbCJ7aXVCTBzLKjDSDv980ChRqyi1lqPX5IlM+JllE6w0aeeNVabe29cYCAsb6395eHDOx3zcgGs06tF9WUWvmMzYmmtACnmn18ppCE4HavwAvNPTerJ1VokAovLIa+Tpwob5upjplcarD5c29bVBV2wvItfLwWoLievQZ+Tau2OUNf/FkPJSVX7PP9G3fusPGjbfKpdYQXRqKfd3qz4xhoHxlD+327wW8huZiCm/Vyh3t4vhplKk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:07.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7637e0-1070-4d55-b836-08de89d91a6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

From: Vidya Sagar <vidyas@nvidia.com>

Enable DMA interrupt to support Tegra PCIe DMA in both Root Port and
Endpoint modes.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V8: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 63173f7af62b..b312d02f8dab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -91,6 +91,7 @@
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
 #define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_EDMA_INT_EN		BIT(6)
 #define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
 #define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
 
@@ -544,6 +545,13 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 		spurious = 0;
 	}
 
+	if (status_l0 & APPL_INTR_STATUS_L0_INT_INT) {
+		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_8_0);
+		/* Interrupt is handled by dma driver, don't treat it as spurious */
+		if (status_l1 & APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK)
+			spurious = 0;
+	}
+
 	if (spurious) {
 		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
 			 status_l0);
@@ -779,6 +787,7 @@ static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 	val |= APPL_INTR_EN_L1_8_INTX_EN;
 	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
 	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
@@ -1805,6 +1814,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
@@ -1812,6 +1822,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	val = appl_readl(pcie, APPL_INTR_EN_L1_8_0);
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
+
 	/* 110us for both snoop and no-snoop */
 	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
 	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
-- 
2.34.1

