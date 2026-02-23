Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5F369231;
	Mon, 23 Feb 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872419; cv=fail; b=KRQna5OIzfOfRhY23oUy68cQZDbngfgz0dv177eRNcBDlE9MIyeyOmc6maNCMkdopZMD1DtnVrKe+15nn6OlFTRBNC/Dp1+jJmczK9wsImqUXy12tIPUQaIebwQ8oxsXQu9Y0nO9miMIKFYi4/W4HiSApn9rDFd2iMsl5NKhKag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872419; c=relaxed/simple;
	bh=x8oudOmZYhf7xM5G/Rfe9sNHxdHsVgD3W11U6qYkUv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSzXcA3XGg0d19zZo20uh3yZh4KNr1Yx5z96AsIDZpT0OBCfv3L+2Mlgotb5UlMi0raiQyxfoHdaD1yuuom3imH/wYxJrr0wfnzHGUMHhtnEC0rFXUGqp3HBcDZNvBWb7Dbo7rnSpnfUJTJHYgSy9Zas30SmP036zBu3gb8ct0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AcKbNauG; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AcKbNauG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhJp7gXZj3MeWWtcYMsGM6ORKeNziNqEvkcUiOINg21nmjIxiQEDB1dVmzE8jNjS2n41p0i7Py1r5VNjmb9QDrrgKJBLPiP8x6dhr8MF/HwUStx9q7KmGyvdDOkMRJrap4jVtO5M4jUEfQ9eyvWM0QXoa/Ac8GdAERiOYunt62BxPiEWUUZb3irXcVrqVyCqud24pjKPequYq7kDhZcYFiIwW+GwpIe1we+CISW1mJvM9c5KSDPBKkUqZJsN7T1scJSp+nxr1aiHLAUMjPcC/N73NGbYBwNSDudcST8w+iI9SkPp8/7Vb0WM+X9Co5WUC3/RtUj8JKPK84F1BdlGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i0EQ8cPISvpFL13ChT3uBk3OVU7GyUbo33ViWlOLJM=;
 b=frsqWlZLvBx5RW/tR8Z0hLJNW/V+4t1vHLm99OX3XARahhxsO4fA2dwrdq69fIZf8BznGU/QOqdcwL7hNdQqLfPMHBvdnD0C8oOJFPLByjPrRSANaq8Cf0Fg/msJKg85+nvygth7wpP6KySt0hfD0rmKZlIbG/WkyL2JbC52g45JTMBvF7XroRnuqccoIp5FE7muhnUpLwmPotJYWcsAAelpl4SwuP3hlkM7PYWMo/w5FyD0g6PPvckFI6IqZ8E7Q0Ev1rFVK+gmGaa+H5bLsEKveokRHgkiGQ0WqOe+E84A3MfJkQWX6cz56sM87HdsyUdH8uXhgFXXQR9AMDq1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i0EQ8cPISvpFL13ChT3uBk3OVU7GyUbo33ViWlOLJM=;
 b=AcKbNauG7CZZn2DiIlDDJ/kOZj43o16nGCLk3LKtZ1FAd2IGr9v4f8dSzJcEC/JFqZquCwbAu304a/g4U2huEOvayeRkER2ABva8Pv8vrZ7sxENGt0TnaVLxwh4xxJZTHxAJ9rGomEinQE+mSyn4V3cJ/nYI+EvCCcgisMbLyGSuf31WCNzx10tISyAtZrkMSASKGmXkB5v9A4SatYg7BvuI/YWC37yVcEKmFbhBoRvasZqqawpd+L00mc6zE0NGvS8l+e4bhqV+k99LkXOHQ4wQ+9SAe/SNHW/dD4wm5X1R+eq9AyNP9VtqpOCz3wIsd0N4uiaooEI6zK3+yEKvGw==
Received: from BL1PR13CA0148.namprd13.prod.outlook.com (2603:10b6:208:2bb::33)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:52 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4b) by BL1PR13CA0148.outlook.office365.com
 (2603:10b6:208:2bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:46:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:28 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:21 -0800
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
Subject: [PATCH v6 4/9] PCI: tegra194: Enable DMA interrupt
Date: Tue, 24 Feb 2026 00:15:33 +0530
Message-ID: <20260223184538.3084753-5-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: f22f44d2-ba71-4857-cc1d-08de730be919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIPt3q1KoYRQFAEv3izA784hTTIYzTxZIWP1/naVmWusrDGIBZJFHtiXHznX?=
 =?us-ascii?Q?gAcgckoNUgQI/CmABtujAHU2gY9QDbtBKNeP8fwNPG7Uka1V0nHzIxyzsJcU?=
 =?us-ascii?Q?Oc74prNsy4ZiWlbSQnzQpnw2CxNJNrYnvglcRBgU5dcqwKn5EhZp3jdzHcvn?=
 =?us-ascii?Q?JfiUGV8SlTHrsAbWCjBGsqesp8ZfN2xNCQAUY8IoSfTkq1iv8lfkPd/Ov/d2?=
 =?us-ascii?Q?buh05aU+p81/t8shiSEntpJj0C3L+NgrR39GqqQiLDQ/2pU5K8TcY+5Bl/ae?=
 =?us-ascii?Q?zpq2ZFs24evsC5eigsMw5Dj2DUqfBKtA/h2DZwJdgp2N3Q7FRbbVHXOpJ8uX?=
 =?us-ascii?Q?xvV6jfyvp8bopNvZtIfvqwkeVPTlfHi2dV4ges22QxHB4Uy11+u4ovwEL0uW?=
 =?us-ascii?Q?obbO4iy0nEVYhnADpfeCJXUmZbBuWn2Txn5f4GeVyZCjjY9Xp4KaNfJ74uTp?=
 =?us-ascii?Q?Di8G8PgDA1sYkZmJiMa/OPL6iXjmL+JyQTj/XGycygPwJqF3sxiiJ9M/87xO?=
 =?us-ascii?Q?Alu031WGoBFc96gktMFAmCgkXjzI1LluLmfzP0d2MTMEYJsPr/ObuMWreswr?=
 =?us-ascii?Q?lxjXohsto1rbNXqeNGXahAYGX5ERFXkd7X1IHUiePuqdRBIT+dJyFxe6Hqla?=
 =?us-ascii?Q?ZZYHrAZn1Nq66ezFIGow7ycGU+YVdmuwQjd54vP8RjlQlqsuGFCxzyF0NJPr?=
 =?us-ascii?Q?AVbBETnd22Lq/r2Zms9Abcz616oubzOmi8Nue58louJH+BYGTx0M+L4NC5+g?=
 =?us-ascii?Q?PxSf+1bvBPMyUeBqOwirwcOIW7PaIag6IyYqSjvrVZRhUMTHrSHbb79BuTaJ?=
 =?us-ascii?Q?cHx+7SI3mUwtkcN09Cn6HCX7xSiayhGpa0tEar1pWrYmAe3GBTnTHFLtwN/k?=
 =?us-ascii?Q?HouDkTFbQ7LYUDCkf1UZGJ1lZdilLTlMZGY+RtG7q+PYZMynycUoxFjUy9N2?=
 =?us-ascii?Q?1Y/8CTb5Jr14CbLnHLyAuLX+xJeMIbVC2dvi9ABnvPirBTkl/FVrkQrDOXHN?=
 =?us-ascii?Q?W2cfUIhMBoRUyx+pD84B4FPXbPA3EAY4O7F34UixC/y1maCwP8s+qjjhXDZZ?=
 =?us-ascii?Q?A6qfffgwXt/EBucAHdxFN/JyWtxEyNI+u+Xx1pKZZGGIqqEYe2Emkx1fWidd?=
 =?us-ascii?Q?s5HncxPcmTljd0kCopz2Nbc+k9a808pxiIDRvxup3GsROZrtuO8/pAJ7fJjH?=
 =?us-ascii?Q?oN6pHFNvaV4AwVnb+j13hgXHk8jL6RnsloDFchWda0dEdWKtWCp3seeMFPg6?=
 =?us-ascii?Q?zQgAFCCDTGKau37YLe7eZptd+gOK588a8cwfgO4xofZwOfXME0yRcGn/Qeyy?=
 =?us-ascii?Q?wMORc0NyQf0bGcZcJyXIkCOEgOW5wRFrcfODxuU1I/Xw9+XV7aPGlUbW2bGK?=
 =?us-ascii?Q?c0y7fdbey1KQ0yuGiapTPUyImdM3cttBOtieTnGFfzL/vKRRdqaFaCA3Xo2e?=
 =?us-ascii?Q?vo+tbbfrGI6NI0tQDPrWGUAY6JLDShxJsrVl+TIthgm8TWC8vIMPOda/IaIN?=
 =?us-ascii?Q?3hT31nKLc0yPOoUET//R2nIYGMVBgpCSDDzTGHTtgh2vIl79Uj3EGaW/o6Os?=
 =?us-ascii?Q?YobN3eci8y3PpZ/UtvvHqfZDlkQDnOQEJfWzazVgGWoYArD2aXtiQxj1itx5?=
 =?us-ascii?Q?GlYPPtgBdeHw08vE1A5STvt7zjhdnuzHxL216PHvDo8vUJJJ1RIKfMnHC1Ds?=
 =?us-ascii?Q?CY0CQ2YHrHvjK4IZvT2+IWvFlXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dhj3oKmaKgMw2fd7yTWAvU1kwY9qW3/8glvxJyqu3QcZJZzNDLxuCAIIJE+NzIOPqn6m5gpBKGqGPtR39xaYD9hMaRviXfv3KBvC37K8io8KO42/zEV26fMJhaWOhopdh+zmZZDHaz/gJdIKD9N3g5Pg4OEWUnK4Hkyc1EN6PqvRGDiBPc71ebqFiIO9GS8uzMGJvor3jUe7zqkGnGA4cYhIp4CTS2oTAjS0AW2kPbNxOMRhN3cCZd9XMusgGfc8BCgWnTs7HGZTDSXD4PD8ZfviijiC0yp0ZN3QN2NA0/1hTYbpiYGqK3X/3jI9u2ssc9wtwJaK4RDuYgV/dJPJO6HNxeHugE2WM0Lj2JmqYnUzj5rpoYfrXNUdLkbp3w8AP4U/1w8Jz7Xs5iVXx5C2jXPbHYjtoZN2O522My9r+Fld1I6d8T40CGMFcHlp/4fX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:52.4025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22f44d2-ba71-4857-cc1d-08de730be919
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529

From: Vidya Sagar <vidyas@nvidia.com>

Enable DMA interrupt to support Tegra PCIe DMA in both Root port and
Endpoint modes.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index aeec5f8b9842..110f2adb74d2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -91,6 +91,7 @@
 #define APPL_INTR_EN_L1_8_0			0x44
 #define APPL_INTR_EN_L1_8_BW_MGT_INT_EN		BIT(2)
 #define APPL_INTR_EN_L1_8_AUTO_BW_INT_EN	BIT(3)
+#define APPL_INTR_EN_L1_8_EDMA_INT_EN		BIT(6)
 #define APPL_INTR_EN_L1_8_INTX_EN		BIT(11)
 #define APPL_INTR_EN_L1_8_AER_INT_EN		BIT(15)
 
@@ -547,6 +548,13 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
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
@@ -766,6 +774,7 @@ static void tegra_pcie_enable_intx_interrupts(struct dw_pcie_rp *pp)
 	val |= APPL_INTR_EN_L1_8_INTX_EN;
 	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
 	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
@@ -1789,6 +1798,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
 	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
 	val |= APPL_INTR_EN_L0_0_PCI_CMD_EN_INT_EN;
+	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
 
 	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
@@ -1796,6 +1806,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	val = appl_readl(pcie, APPL_INTR_EN_L1_8_0);
+	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
+	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
+
 	/* 110us for both snoop and no-snoop */
 	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
 	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
-- 
2.34.1

