Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13E386439;
	Tue,  3 Mar 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521152; cv=fail; b=O54AfIj31oAYKUzUKgVNrh3vXBiitGDnZyNI6SyipP8aI11iUCHSG3foKCozhbBGemwHjd8kPRoV+IuCePhPmQVDte9iHndcNxDrQ/eEQ0jukeREc5kTehKqAfNFUX3FW7P2c7ygMUpttug8RHBi3Vd1XZu5TXG1xu7oLK7IV3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521152; c=relaxed/simple;
	bh=e614jC3a3/m4p+J7p8Aytsx27ImB2atkWusrW1gfNgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCKHAMjva0PsAWmuFthm5vCnhS4XrvlGKlYqve5iW2cTYABdEPSFY/yCBGBdOJXyz4CcOLJ+vykBDWkW2nnwDEbfadKVhaKgUZvQmj9MnvuipvnV/+JJE6Qh2WdVkO3LYqcE/CYCom2u/tdgeSAIyw8uH3lqvDB85ab/X7gO3Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFQraENO; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFQraENO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxLm4LtxSebkdb/ExXYsdKsoMMO2gucRVRQ+fU+zpKBaALvv92jY/9LM1g2DYnawoCc3ESYr0Z7ewiQ7e+pqQe0nVy7WtCJJTNX3yheRY0E9jSOaFozPW7a6v/UZx+RQmYDXcDk8zzVMjTudk1JT5qhjS/ZUbjqFpf9EgPxK395beut7j0wW9DW9KmVhW1fB3rUAr+IrnLiokpFol/nSN/aHDmjKS/UhcsyGkaxHseAMX6dQwuUGEhchAJgOgaHLMMV7KpkULAMNOQ5eaI4pNFEn6Lyo+d58W7k/cfiPxmsVvBbTY57yYDnn9uOCJ5Wy8y0Rh1Xsn0kftqDiaJWwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa794zdA6za31haBgGFFP64BlyoB1Rhlo3tGLczqcJ0=;
 b=QPhfen+6eZyCC6DDO/0mv7TZo90eJegK5awwPtc1Ly58xOGYn1S+Tt54bFrs1LFV8jT8C0dHHAsj0hpZtDz6xQdhgDZWMPm94G01n2h4buUh60Is5JI0os/XTN57Z0MyfIUdgnQP0YspZRKgaNMZa4ygsDgHsDieglndc8D8+3aCdLGHt+JcHZ9uhTayvlHDflFTUnUEEsIEYSf/dL5pNGl8XXdv+05ombGFxC2ByZASKNeiptb76WfOLUvnWnePifbyvSfyBQA0M1Qua91giJhXEpT7l5Fgvj96deFV0dVTvSt4YUpfp6E5yxDsFMZTP2++NdtZmsHxzV/tmO/qPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa794zdA6za31haBgGFFP64BlyoB1Rhlo3tGLczqcJ0=;
 b=jFQraENOTmTRBqQMuPss6F1ZYNaIDDxwbDFiLdbQuvRmZJ95L6pwdWG/9jKPLxw5b5u7WxCjKjyQ5ReN2ServfrLUUvJDx6sL9tdfCcZybp/fu9pO1WvuegYUr0o1HdK0kqclf8JpkGLgt77VS109JaAryz1nEiCr9QH6VooZ9vvbUMt2Z3aRdN928loZLe2fz8m5iFT7Npt0kJJelqAKT5aK3s+Esyn9NsquU16RNrInm/9X5122AfgMNoT1MGBUySXypdvklYo6dtg6z9m3iK5KS0rNM2DPXO/61X68jC9dvLQNZxYGqvvqDZJelEWd0WuY92CjG6vIZwVFvKNsA==
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:59:04 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::fc) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 06:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:45 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:38 -0800
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
Subject: [PATCH v7 4/9] PCI: tegra194: Enable DMA interrupt
Date: Tue, 3 Mar 2026 12:27:53 +0530
Message-ID: <20260303065758.2364340-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4c33ee-6fe5-4430-469f-08de78f25b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	uk1+iroL7XDg1OVWz4biIx5PZpD7FwmNFlQmEyTq0jOQbFydtWJNvpYcOtngajBO+vI05N9OyZKAFn6Uhy3u6/5WWebeTHB/tHJpVldx/ssxbgwSBLLuHzyLgqsq4wRxp002/YwhBsClZVlHvefBSC0UwioLItIlJKi9et73xMrgopArdMrkPRioBXJhAEStHCScUIbfGA/LMPFTEXlZKZfhPoRY4VU0/5wxH1A29NLi6pzOsTBs/Me5WwWJn9+Znv90wgjf0A9j5n4/S4HCmBG07c7BMufijevqJf03D+wIhxExLq+kpAOJT4dK4OHxIx8GGsPIVOUfmt7NvNJ19gBPVVHnBdx1zDdsb9QzLzOh5RLiQ08sZQL/c4k93pEzXP+HBnWvkS+M21zeLuGzlNQGOmxztfD1SvXBfUwOjkS2WEkYfvAkKtiPIy3ljJIf2zCwFQ2sD/AcDTUb/2tUNsoikNzwzfBhua8Cz6xSIDmvMPFox5MsaOsdzMdio5Ig3YOE5/04usC3dpbaQRHqd2hxhOPGW0PlWq1wLHGyhmgfc1API+cSfrDWlsZb6Eidp82e8F5lFB1nVjG4BN/duB7YK/YUz7k+8OSBpphoQcNDSga2r6q7Tk2EN29PZd3DmLreOen+D4jPX0LkP0RreEQHT+9M6R+xsbqaNc923oYnA6o+1XcMq5JTK0bmGBDoD4PWYiFmZ9roA+BvCWWbauPNqmdMN02k5BSZNBnkuOvomo4XxjhOJDLLOuQC1yJ030qMV6SStvqWrLGbxt4L5SNJSUqEfhwxasH2/Vx2wN72v79eHlm1slMzT2i8qqugM0WYBYKNp5TCMcoKxAFLKBq2gsRnMqldFLDSCZVUYls=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rwOl71jlL5uUui6MkPAZYTgX4lQfWhKQ8+nnTE1GBiEixtDirnXeHvPLK0DxiDXykBuFtigu7zPEwvDS9j86bD0HqJ3X3q7SloS15EUaV2ZCdVNJ4Pz7AaqKmvzTXobWpSU31BL8NQMZL5In+jVBrr+qPuuhlRX3NBKXaq6T+J/F1vWruImKHUquM00TFzpwh6uR5b9ceyFCWxM7hfNcHPbup5SPh0pWuLNDkGFs4w++/0/c05YHGCvh2xeDErjdW5uLYgTXDeuC+F3HwBVdG0FfZYBUCE8JONb6IXEJrxsLMNag64FLOztF4P/lmcBp36i2gLx6pJc4s3cWXBqFqL3cUPKhRvygwKYImVS1K3hVr73WEErfK41WmgT9fQLMduQuKXxoryj4ht/rio411gwfCZHhy/pgnVsc84wGpSq8eAi2/qXbBQmQ/ZVXyOS1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:03.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4c33ee-6fe5-4430-469f-08de78f25b05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Vidya Sagar <vidyas@nvidia.com>

Enable DMA interrupt to support Tegra PCIe DMA in both Root Port and
Endpoint modes.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 352412680b4d..918e864b74a7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -91,6 +91,7 @@
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
 #define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_EDMA_INT_EN		BIT(6)
 #define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
 #define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
 
@@ -543,6 +544,13 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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
@@ -762,6 +770,7 @@ static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 	val |= APPL_INTR_EN_L1_8_INTX_EN;
 	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
 	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
@@ -1786,6 +1795,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
@@ -1793,6 +1803,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
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

