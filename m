Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746338643B;
	Tue,  3 Mar 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520984; cv=fail; b=MkmMDQy/D1rv2j40pKLn8y0lTuv5Pgg9iQ1m19to9xxJcxkuu0mOkrUy6qdnuq8jWS8Qf+i0TUjAEpt92B0C1Oe0meSYrLebqY6thhM/9SvVRAfNM0ezN+YG8J3RmzlYxERU2LXUAl7NOqdguh+oTxj1ZbJ8Upg6JHov/nbDlIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520984; c=relaxed/simple;
	bh=8G2p0+C7+apaBvNpJz/F0WYtVBujLOa5l8jbb0+M11w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbCovLRXLJbRhceNO5kvhZDIsfqO+Tb/JmVxsUOkFhUSVRlUwHPWBzzDUpzJ46tht6Sx/GIwYtKo0HsQZXjQ13ZVXl3LhJPiqIlFC7Fx5/pmUCmbJyK0OamAH9pO3dY7eU8uWvMTn5uTZgPlyoQdWEqrO4MWZ0YQabyM8Hz8qZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UX9XV1Sb; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UX9XV1Sb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeKhySIbsVR0aH4sp1/XhdiyxYUDQtfIR/4d5cq/AIYs5RwJPWQTHK1+gykBhWymlwLQI4dERFeJuHwrnbcZg0Lif0200FKniVBk6yXl5m/Ur2xtXY9zhAqImO7K9gUVyi0OC+X766wFwaBm48xHa10d9AGVMYzWzCmah1jLHeL0vdm0jDuOyLtAbI8hChsI+y2dzKHzLpLdP0NMa813Rg4xc9Vol4AegaHK4bwk6AvSAFdvsPbota9inlUTaBFnnyt8tLoS3OMr/tw08hzBmJYFLp3X6POB5aUlqPBcOSuKdEJpuUW2bwjvZP7V2R9D92dQJeUzZFbhV7MXkZmjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4fsYgDNo0mJjce6YgegRNwVG/asQnkld8eMApLG7Ps=;
 b=Cje2F02trJjCgQ4p5O7RV+c/jEa63B1WJMISKcWGWriIiTzDfEqj5XUjgUN/4nDxWN+v7jAxY078MfZDhHzk1j65wM+Y+ASqf/ZP3NMnC9AKCVNpUZEfXsnMMiQ+cirEFnJdh87DrWZ6AMg6NHub78Qypo78UDXIr9k1B+OaHm6VMAA14FjISLJMh8BZZNvT3pdu5fAb7BecGNT+kaOflvo1El8SSaYpPo+Ril33dM0nAoQONSQO/ChHmlMM9XYTDmy1KE+0lf0dRPrYtI9hcNRlAU2E0hgAC5EAwsCpfigcmmSzhaugm0rSYi7bF4FK5UkxYOchlJIlJTI0wSle2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4fsYgDNo0mJjce6YgegRNwVG/asQnkld8eMApLG7Ps=;
 b=UX9XV1SbO7tbQX6VXxxj/I639XEO9omRJkB5zf2XJWGBJX9pX2uWTs+MEa+0O5E/yzrKeLejF+Xv5kn0ixIN8EVymF/H6yM/7NppQ28/L+L98Rq7vT1P9A1cgUUrsnZ3bv0uJ5SNOJpfR33UU1M5gA76jGl7S9t9Z0Z1vz3f3Lunn7o+vXHsdjoIZlrCEIfcNT/HUsSlw38AffCsd4YWMa1aSFqX/d9d49Y7JwGPCSTn0Fkh7e3aLkcPp4wv33/KZsATWJqcF5zMtY75S5xy/BFqUdrdIhK1DSj07i3sSmOfi0y3sR0fWhfVecxD1d41UAbdeb0POQaxAAzlBeiH0A==
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Tue, 3 Mar
 2026 06:56:19 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::b0) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 3 Mar 2026 06:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:04 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:57 -0800
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
Subject: [PATCH v7 07/13] PCI: tegra194: Set LTR message request before PCIe link up
Date: Tue, 3 Mar 2026 12:24:42 +0530
Message-ID: <20260303065448.2361488-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4ee52d-4547-48ba-a8e8-08de78f1f911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	UGdEqvDXTjOA4xtMrrY6pkG2ysHdIvTSbuuw8W2EA0EwOpzhB4MCAElT1YzEZYmLBDHGAUHIGMDBVLf03uIF0kYBHlSOmFEj7So7udhvCEwfkzZmdpSRqyvx0Rw840jx/bum2fS2WPr2O7cB0Ecm0U4+cxQ7o3H6ayPSYWiA7pUiycVlxjzGPziQJB6C8QVOBukp5foM5mWjI3QFGEPCiI1ToRILYLvtN2YvK1eXKc6oBU9IP8+uXuJJRa3fcHFzk7ej1TsPGBU3RxieWbIDC7P5jKCu9IPfbEv7cnjooaVpSvubVqOP670x8HsyUAWd2dp/k73lj5VH2yKNQzRibkimszc8Z5WXrpwKgTzFz59PgiXIbl21WOc0vOMivKleUoSCp21E+IwRNDB3Gyb8tuoQfWRjb11Jk6qq3sIvdoDMBO7h67m65a/+WTw94vBK595UqQTyF5DsRkPbQDDlZyxKPjdnZI63hCs5jopptTTW01jYbRo0AGfqZ9nSAqP9+gxRmAkeAf4KjDVE7nlRWigRnHHMW7ztDJqcH9uSGEnVcqco7z42W57oEMEe+VxP51ILEIkkDf+u7BUD4Fl/shjUDZAc8xcy0gBc4fE+lg2Y+m2P/Ex3Mg9uCPjlqs3fJDxkWWuTVkP1Ygj0TcYG8ebZI2HSJncnvUTgPBoibqWFsVfyVA42U3CJaY1QfUClqA2hGpcaGwy7CkLjgAIe1sCkQ39v27DnO75exBKWZ52H9IFRCeQP3bVzwEtQsa8pCGfQnIZqtEFIi7vWuKwiK7+5l4I93u5KamzYBuXo35+UwdPtnn227jxYMuIjFaACW8bSPw/HPO6yfi4acSWu/pH269hp56FspWYXwTQRXk8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TZOoaJsKq5QS3auKswKv91I5C+7XL/W+6te4xmJtqkyUfYpBY9Pl43Fhb8M+pvXTrTaz/z46yYK8WQlFaV4yGYx5DIjfAQrje7zMXcfzz/XGKI+ssydFPJmBXtuZXVXXRrOYwSY8ppuWzvTrC9fkVJDDWDKzBgiS/p9R55DDcYclZ2C5JRTe9nyhZ33KZ0M7UqaH/Ij4qQ3qQ/bI2XitukwntlhoEa5qaGYZ/snVPBCuwhBX8L89xSNktp4eucCkOV6QTisyPSluf9bewmQeULWuvBbv66snNMcSCv4fu13mX0T5IF9aG2nmptcmRbXqr5RG0M6VN6Je2RqAvyCAvQeAJzu9cYYtnMasxiZT/0UEnpslb9V0bv/q48E1rr9ji36t+yaTEMoxHI0WzS+QdoYyQCqNrcQcyySLdhGx/oy5FPUtWFUYJ5vnfzP8QoJR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:19.2465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4ee52d-4547-48ba-a8e8-08de78f1f911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

From: Vidya Sagar <vidyas@nvidia.com>

LTR message should be sent as soon as the Root Port enables LTR in the
Endpoint. Set snoop & no snoop LTR timing and LTR message request before
PCIe links up. This ensures that LTR message is sent upstream as soon as
LTR is enabled.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: Retain FIELD_PREP() usage
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2da3478f0b5f..b50229df890e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -485,15 +485,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	if (val & PCI_COMMAND_MASTER) {
 		ktime_t timeout;
 
-		/* 110us for both snoop and no-snoop */
-		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
-		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
-		      LTR_MSG_REQ |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
-		      LTR_NOSNOOP_MSG_REQ;
-		appl_writel(pcie, val, APPL_LTR_MSG_1);
-
 		/* Send LTR upstream */
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
 		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
@@ -1803,6 +1794,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
+	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
+	      LTR_MSG_REQ |
+	      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
+	      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
+	      LTR_NOSNOOP_MSG_REQ;
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

