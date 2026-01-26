Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190443112A1;
	Mon, 26 Jan 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413625; cv=fail; b=ahRZ/P029KfwcqdDC1z2zuyLi0qUdSAWpIAY67/RUZrD+yzchylbFecc++vfqhUdLJEvN/kXGmgb0CTWhwDQXwX/Fyk+8DhtFnDxqiqtC3B0jR7+k5Q2Terg1WjmOcczQalik6nrtcyHviLGumpR9zVgI6HGO92/R27FnsHD1Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413625; c=relaxed/simple;
	bh=9svn2tiJqyGCzPtWKBpa03FebwqAqVHRkiUVvBBb7KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2cLr1C8TbJwWO2o6wqFge+eX3+pG8US+lZrX41+lvlhF2Ji8a/n6cRB+24vIElyPtkug/cvbWSAC4BTktNtv2T4HrB3gpdRIqtwtQsCY/LffX97Il267tQdI1M5O81qR98o9pAbc/DsQOhN6wEKYIJtr3FJwt1CqQ+sVNy5D7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/9EXfH9; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/9EXfH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diwmzI5/gFv5xvLHkKNAZtuqQLidC3EJr39UJCEsgwwUSlYKPPEPh9tSJFirSuD/2RPq22X0rn69C8TyaP5aBIXwaDVKzEPzDvFNtRXcF8x4zkGGE+xLQQnor+LSAAciYnELZfw41Noo79rF9S8eXTOnK3O0azZcayylkeBCVj/gzuUBVd8suS9xiqk6vMQwFFaLTMToDV72xEoUZkgl+PUDyW/qq/uWIbxKuPXoQgk7vggCCzo9d8k1xjjNLMgVtDVeYxMiTP1S3Z19hhQ2yC5SHG/yp/UxJ6tn2wIfQAHeN7w4swQJdLpN1OVS4ChKGV71GLaEBi3L2T27EBMUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=456rI14ySvIKZR45SYPhUAtM7EgMiwhbgk/HKQnFTrg=;
 b=l2k01DEqhdOtuqs/YymYVuWqovZFsp5E6C94kQYjkgq1Jlg733DaIBvCl98Rm7zxeEL4CsJQSR69wvQk6lS+7FF8VVUfiMEnzfmfjHeitz6hUHEkDqorHvuoMug5mY244X29dYaDXzPq+0LsU0/RTGDbKmwaKtm33ZazIsTOgiF3dNsiClQYUj2QHpUgwZHCmfg4KgY8VYtgYRL5RDz2L6oxzqFV2LCoPKpxkqVq2LOSd2It/mOL8TAZr7vnHKQhsAx98SoP2aOyjfdYAz6peeURHrtCLrJvTrGZahGTEEIIiRdTOhrZ20Gp1/Sew2oAWJ33VR7bnn67BmtHPjYzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=456rI14ySvIKZR45SYPhUAtM7EgMiwhbgk/HKQnFTrg=;
 b=S/9EXfH98ZevbQFJgEXe2ssymtggITSCjaPOm8DXjhApj2TXwjg6SooXyLF9YqAiPfeJkDt6xNSLZVUP7nLA0FYDH2gqUxvOQjsC7ltOQIE8LztdPLL9BTvqbOKMrjDYpSYug8ZsXw7rrEi7YYdRMnM5wj7jwbPgTJiTjTj0tqOBkI5rkLMdf7t+F5i2FP77u3f6PhmivwePOPp7x84X+RxK9V5nqAaSI93CD8pkZzXOdJNgMNlS6J9wnjQH8iw3R8rWtx4Qcmjhr3Bw41l0G0Xc4pvb9gcSWbE0u872B8KUIwOtR3kLGsjjUvgAc+nUikHnzVLEPxsm26wjJ0P8eA==
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:00 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::70) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:49 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:43 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 10/22] PCI: tegra194: Enable DMA interrupt
Date: Mon, 26 Jan 2026 13:15:07 +0530
Message-ID: <20260126074519.3426742-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 125335f5-cc60-4f48-3137-08de5caf16db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgADpF8dUb+yG3sViC1ghm2x2JUnnNm09kpHP18tzSrQ0ClBSxtjPMbTmWAE?=
 =?us-ascii?Q?v0Mtf/HkpPSxT76FCf8KbEtxIJxfRNhCrYzHQRRehWkxPjIKI/NJAHWj0NyW?=
 =?us-ascii?Q?VuL/JnHI+lyBtTadWK/6nGJHfbtsdScXJmicbhCpVYUqXNs6ISqsA59y74GX?=
 =?us-ascii?Q?Lm+mJ0WKK5aCS5wc71SN76C4I2k8wmMzo0YJOK6IK9pNv0VJQr8W0rZXQfGV?=
 =?us-ascii?Q?eL8FNXYhqMIJoJkc575vFpokJ/xASwyWt2ts65lcM45pRWZFu6xHhOexZn5m?=
 =?us-ascii?Q?rT/UhHOsMJehtA78gPsR/bIYAxH1QGh2eJy4n9DJOXtcOLEbX6rCLLtOzPRr?=
 =?us-ascii?Q?8TQ2Upi4NXumO+xCdJ1kRxSdXKjwjYYngyybXLZ7DpLJFGPEI8hqF4sZKoTy?=
 =?us-ascii?Q?52naGfa97r+nTZpsiLo15WcYkYM4yIjKuv8OyKG1sM1JoiKosEnxmefA4nRD?=
 =?us-ascii?Q?vSg6X9lUoutdxM0+PF+lsMJVS7DGk06p0dAz3HN7vKOsmwY6kzpF+ef9YNWi?=
 =?us-ascii?Q?GimreudvoqtQl0cSlObe/LqovZhb0qoMKfTXWKy8HVxhLW5vgdexBYNkb9bD?=
 =?us-ascii?Q?Kz4XagRZXrq+7Y0qpTGes4Czo5Nj17NG3wzf0VmlRknopG5MJNojw2WSoEis?=
 =?us-ascii?Q?eHfJfYvZSUuh/qnrcHD0oXW2GD9BgfL6j7brUcHfrRycE7YlwcV+skr/r2vp?=
 =?us-ascii?Q?kFP7wMHLDrPS4XlD0cdq4PMoz4mMyRUZlVTfELUAZ8yIRiD7PertLfKRaR0Z?=
 =?us-ascii?Q?GIJNyObpaSKfUR49yqwnT4drooMMjutVQWcqHCZVv37Th/8IK43K1EfXReWq?=
 =?us-ascii?Q?+QLUUt8dtxKKgc9CgMKByw1uEu6ZDn84P+DQxZ1I/OIl06qIA//ZygQKeKUu?=
 =?us-ascii?Q?gabnjmxh+FlgYDe9Jtu5YbO0G8NwGKQKnZF0k14e4ECz3vsRQSLVMJER3NxW?=
 =?us-ascii?Q?2vjt+K9nJB5QIBXWsHDgEP1vLO2xzucqFJcVWLz4eIXrXVzna56BoFcvc7nA?=
 =?us-ascii?Q?xv/EJDJh1uC7kC9SPkr2Hr0OYYYAGrCWaEA+Y4AfFq6BcL5BZp9q0utZPCDu?=
 =?us-ascii?Q?3J7ZN3GzwHtcDTjfvtSn3s7klXHmkgAXOceiHzC/BKsLiy36ZsCUgguWqnQ2?=
 =?us-ascii?Q?jBQtkWsjzKkLpA99CiZbW/beBHmMn2UVsOBRKF4L3rSQHS3ziVOE/WY516Za?=
 =?us-ascii?Q?5Gce7RSU5gjI4JDr8fypJRpy5I7na4dWrg4OvbVKMzQo2ObmNnnbqN1TWLm7?=
 =?us-ascii?Q?SfY1pxr1o5fN3xXbcr/7Q5kNmoOHidEx/LeB8to57I5hyq1wvsls3PpbZxnc?=
 =?us-ascii?Q?K5UIvwQmSn/DtH9fSKgM9j2AuKtmRF2po7yEU/UKqkd1l67R85lU/KmF9p3Y?=
 =?us-ascii?Q?aFvCp3h8m5gtIB78w37RRizS8UwWb4UQ2fnMIi0WAx8wO+ZBhmUAt/G8iTzT?=
 =?us-ascii?Q?Vo7oaMBekaOmfqJDAw08j+dy26OZbW+0iggnfh+PE8vbjj8R+Oi1ZFqS8O0b?=
 =?us-ascii?Q?XRpNx4dGD/tHHYERl6XgC0TpSiXyFfYBArezoN8mYE4/63WBLk9h+klIAH5j?=
 =?us-ascii?Q?BsjpxmG64RXuZc06rVaFotG4bkaJGJZWg584sFpHN1kpp8sdWuUQeqlqXX2O?=
 =?us-ascii?Q?emR4xP9GThx/0u5PI7Wefjifi48mYIaEFtFDoK0I/cz5Plcq4yBwFwM8woto?=
 =?us-ascii?Q?w2OzVjKLvhBXEd4HcahHTmiczwY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:00.5296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125335f5-cc60-4f48-3137-08de5caf16db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

From: Vidya Sagar <vidyas@nvidia.com>

Enable DMA interrupt to support Tegra PCIe DMA in both Root port and
Endpoint modes.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 58f33e7bd5a8..e5168754b92d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -91,6 +91,7 @@
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
 #define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_EDMA_INT_EN		BIT(6)
 #define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
 #define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
 
@@ -555,6 +556,13 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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
@@ -774,6 +782,7 @@ static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 	val |= APPL_INTR_EN_L1_8_INTX_EN;
 	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
 	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
@@ -1839,6 +1848,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
@@ -1846,6 +1856,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	val = appl_readl(pcie, APPL_INTR_EN_L1_8_0);
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

