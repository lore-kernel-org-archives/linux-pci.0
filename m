Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AA311C30;
	Mon, 26 Jan 2026 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413647; cv=fail; b=RfoWi53BlfP1U0LPhBxiJ1p2/OPkTEgwygVnqGlhfdkX1Kf4qd/GujdvHa8yQwvpzmeTtRRasKVUNjJ3su6iPeG0QHzKFzskaI39oC61wnv0UUJlFTSBlhaPQv0d9tm/0je3bimnSSACLxUpqkSPiJC0/+VzsKnXIjda1YealJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413647; c=relaxed/simple;
	bh=dqBFo4XhUCelvmT7OCcfqm1CgIU7g9uJTkDCyIQ6+iA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5rUleAiahI30EDViVqBN3+vm8G2prbKAflR/ZvGb9HqHaSSOqsRiP/VJC0P9iKDLnOEND5Snt5zKgbXA7SmZwhLKGxE80Z4rqpWdtwKAqouL2rG/l226QSklBCYG6Pc+W8X6czBNZJUt8vfnRKF4M1VDcDnuu/3dMNcjPUmjTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nx2rBXBw; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nx2rBXBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZsggSHwKoUGX9UHkZLPf6lK51QjTDDdnuXc7tDtaTaKvigXz3TgY2RwKqrFa/ePAH865KmoPWoroHLRaUV7d8zTZNZ909SFhf1KbgDy1YUNacG2K9AnZfP5QI2uWBpO19M+4IXUQYdxT8K0vEH+/WiiVWZfe5XsG+6v9QIzkJpipBOfFygcHsckc5u1bgJoAdpfzEIj7XASnj/S5PGhojYuFEZLjDzf6ACCmtgNLxQ54+M57sKW0e+Aue6Nt09laSJxprZNcnvn1YyhWKLdWpPdHd0+NfxZJxznkx3MHX8xZseYYlzG2fuXAeIzDJMFcYlQn0ZkbTuALXejc7u+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc5gJiFxfQVXEORyX8tz9kU8UoOCpZ0VgPrLJ1OuLaI=;
 b=oiOVLaP048l9bF9kFgyW2l1a23Ya1w/bjrOJvTszCCiiAMXSvC662NApeGI2vbip2pEVef07FOKVvkAxthhuXUqTq333fATMNqWhd9dzvqCaVa89VH/w/RDZ06cLZ0K6g14UFCSOKtVkWV4axJNsUacfnY8koSneWDK4DpxVrMyzh/luOtvaggY8TenG1OkYLdJajqVVp4qqGueuiLxpL7tJYEOOzMchx5Dz5fcPDhvWPRu244iaeratrBbPr//e0qEb/aQMXH0L3J2Sn689xjruiRapalwKLIvlHbtG3VCc8sNsXcApPZkEKqleITiF+alzB1lUNL39fO4svnP7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc5gJiFxfQVXEORyX8tz9kU8UoOCpZ0VgPrLJ1OuLaI=;
 b=nx2rBXBw/UxWB8prKVlyx40AJz11WIwu703l8vuTRPb1x1crh1Nx4WtWkhC62GaJoHY5IAFr+SI6E3863aZbdCHs0f5+9A2+GLCd4JZTWyDK7T0mCv4MlmIRLHWfs+FFOyp8dRINikFqNa4ROQxzdK/SW3sIBRVn73gbUaxOBSgBR0csB6J/d7CeoU5y3O4AL99naT+19vMhwvi05O6o2mWYM2adhTms5yq8VazCJoIbWBMtYGmsTrDI26oMqV31xoIdTQm1Uk1C8IijP7Teln54AQTW/PsDDfzQuH7jZTZ0x/KVMluE6KxDKaOKeYbgV2IvGtrvz3CRhIHZTrqfnw==
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:20 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::18) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:06 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:00 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 13/22] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
Date: Mon, 26 Jan 2026 13:15:10 +0530
Message-ID: <20260126074519.3426742-14-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdbe266-27f3-4be4-d67e-08de5caf226b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsRHZnDHxAjBvEGbGmiaPrZ/gm3fIqfNXU0o42X+iyPzKBLqicJ/hSVsdmtm?=
 =?us-ascii?Q?niFaQrRVBZQwnHuJDrvji3ahsBRuJYcGoyTAOwJNxnxxCSfFgpWFyqQ6B8Te?=
 =?us-ascii?Q?0l4Erx/AO2Z+IYGLxKQokRVC6txomU8LcfqZzcGtbwvPPNtPHaKLBzkoPkSh?=
 =?us-ascii?Q?qyGQIf0IJ69871rRx7/n0nhwl9/I6PjTxNQNL2NRvH4P6bBj4JhpcJTQed2j?=
 =?us-ascii?Q?9a+7m9FqjYcfS1GNim4Mxq0vxGVaGOpwvgzF/Yv5PI1sTjWjp9FudmpfA5mT?=
 =?us-ascii?Q?jg851wt10mYRkHpywHz5ULexuR4p4jnzDQ5prGD+OAw8XZkz8JDLtF8qk2gR?=
 =?us-ascii?Q?92ag3StX6dUNRaLIj3LVOm2OCaTvqZRZ08P+g+1GxCfxd+ZHcelX05jL18sA?=
 =?us-ascii?Q?j+8H8/ueTmB0E6kH+tMxHbl4cPLaVQdbi3EixT76n4tqOXc82IicSqlAXO+4?=
 =?us-ascii?Q?yZYXvBI/VcbvUTF0NzF/qdfniFB6USRP4MLkE2pdZwCSkmi+znh4xMJli9ez?=
 =?us-ascii?Q?H6JfP1qbIAgd6V+u6p7G7Icj3F2KfqUybpftiZ2ti/p6vSbYbNNN+qdscciI?=
 =?us-ascii?Q?6z5dQtxe+YlSm8Wcae91NajWbcIfqVBHsukQxTW4GCcDDaYXTk5TV6pJqzQm?=
 =?us-ascii?Q?P4e4zN3YuBZeMxRWxc3gFS/7W7X+Qwh5QSNKqN6Jz25KUnY3gdWfrK8lkmXE?=
 =?us-ascii?Q?8mHoNu6D/3livyckX+Q2CsaRavtnNRLRoDwmkDWSAZfYxY/BX1n8XYY3gvyI?=
 =?us-ascii?Q?biJszsslWYRRWtY0sZSHJLpd2UwmDNsStoEDU0Iy7q1MVgHTgzlsY6kXIawo?=
 =?us-ascii?Q?EOgrmaxM9dxOLDLfA1Ucy603Q6S+3wLwmyvQpooPGL5xTczBnv7AhX18EqyI?=
 =?us-ascii?Q?v2M5Yr4LGjuHlB3ZYiFaqwviei83BNNvEzRT8uz3kbm6/x0AK1nq9obYEkRU?=
 =?us-ascii?Q?0ri57JolxLFXVs9zkHLg7Z0NDMkuwcwqiGTsIjvywJyYU49n4fMBJ3SWHOS2?=
 =?us-ascii?Q?XnwPQq1pkDbaM4w0gPpkdQj6zT/ClXYufHglKNIjy6O7KJBrVeHjoZ2ifnBo?=
 =?us-ascii?Q?N2G/C1u7nw9ydiq9xNUFJ8YOxzqVoz+0QWMoptidq71iDFnYzG2+yAczlw0t?=
 =?us-ascii?Q?bgIejtJ4GUa9Ew8TyQ+X3Mz9LtpABI5QgokEcR1V1Ecr+EpR3UZkAn1Sdqfa?=
 =?us-ascii?Q?Hkr4E8YLTy9TtobAG0ZQQllYHWaOfyqC/yOpZUDxXv7Yp4hMXPN5bNF6JSUc?=
 =?us-ascii?Q?XPZqZBCB6Nhc58MhQTsOmIvGpY46Gkd7xDUSd4tPETqMzfaTazcdifpe6f0i?=
 =?us-ascii?Q?fJ7iL7ucyTPZ9/Mtr6RwE31yXo4gxMZpSR08MchIQw2cOZuMImpfpXU8JeOo?=
 =?us-ascii?Q?OZ5UQhoDWnr3fHKqGN7F89jTd7CXsXgQf5/0OgE2tFpq5hZHEfxxpow90+ei?=
 =?us-ascii?Q?wM/5Re7PMpfkxbZyE2Yf5EyK5+CZr3Z9oOS7Vkmr9tJZFVKQ4J+BSo8hxqTo?=
 =?us-ascii?Q?vR6aA2jMob8aqlSlphhfAFuhHLsbJ0yhtMRmQJ5I+HCMC7moUV2bVCYSC4s6?=
 =?us-ascii?Q?lDizKHRYZ8lqU40f/HEDHEUE+BoCmaA2LOpMNRM5NExlSOlqz0GOyTTOpi9Y?=
 =?us-ascii?Q?e9QZLJbCux8Q2TrKVie9Pnzgiaf2j7/C8JcCQIgvYLQ0nZVZyABk5dyPV/1B?=
 =?us-ascii?Q?X9O9gjjVX96xhsY1YztVMpjMoGo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:19.9377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdbe266-27f3-4be4-d67e-08de5caf226b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF

From: Vidya Sagar <vidyas@nvidia.com>

When Tegra234 is operating in the endpoint mode with L1.2 enabled, PCIe
link goes down during L1.2 exit. This is because Tegra234 is powering up
UPHY PLL immediately without making sure that the REFCLK is stable.
This is causing UPHY PLL to not lock to the correct frequency and leading
to link going down. There is no hardware fix for this, hence do not
advertise the L1.2 capability in the endpoint mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* Reworked the change to resolve conflicts.

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 04e6c34f47f0..5a3e85c53dd7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -239,6 +239,7 @@ struct tegra_pcie_dw_of_data {
 	bool has_sbr_reset_fix;
 	bool has_l1ss_exit_fix;
 	bool has_ltr_req_fix;
+	bool disable_l1_2;
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
@@ -700,6 +701,22 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	if (pcie->supports_clkreq)
 		pci->l1ss_support = true;
 
+	/*
+	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
+	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
+	 * powered up immediately without waiting for REFCLK to stabilize. This
+	 * causes the PLL to fail to lock to the correct frequency, resulting in
+	 * PCIe link loss. Since there is no hardware fix available, we prevent
+	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
+	 * in the L1 PM Substates Capabilities register. This ensures the host
+	 * will not attempt to enter L1.2 state with this Endpoint.
+	 */
+	if (pcie->of_data->disable_l1_2 && (pcie->of_data->mode == DW_PCIE_EP_TYPE)) {
+		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
+		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+	}
+
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
@@ -2515,6 +2532,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	.mode = DW_PCIE_EP_TYPE,
 	.has_l1ss_exit_fix = true,
 	.has_ltr_req_fix = true,
+	.disable_l1_2 = true,
 	.cdm_chk_int_en_bit = BIT(18),
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
-- 
2.34.1

