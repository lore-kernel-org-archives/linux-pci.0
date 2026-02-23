Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74B18DF80;
	Mon, 23 Feb 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872223; cv=fail; b=oceDAahkV3lVJboY590nbv45G9MUqbAEs1QoWotlcSbWNMhtDBe4UlyvLr5PmJUEk0m+xvJivD4eqwWN3KpR3c15kojAik/vFCoT9WqhlH+DmwhNx1O7zdvNLllJEgV+Y3FWtMvrxxWE1CcSlOhV28T4d3UNxXmZJDmHApphZoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872223; c=relaxed/simple;
	bh=Qo4m6mDaimp0qqQ6X60l3Luu26y8MDuY73Hwb+kYLHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDcK2tNBf8VGZK5mTimJn0iIot/bNZ+Wl81Epgo2BnECN+4tF7UG1r7Hz08sBk1ma5wwKv9qxHU4VBvDbgQNCWUKUEzua7X14L6/8EnyAON3s4B5oujHFhP7i4mMROj+hrUzFFnpNKeKVBULGk8XcjF+2DP0GHMd6EmNLvlkLaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HZjHyNdX; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HZjHyNdX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGS9eiBDPpNH98EenqQWaqwTniwQ97IQ++vaBFLTEzycYVfTLu7IttZaIB52XwX+HXda/RNxw+wds4Ti1zfBE7i3KynFRXujl0w/CDBdb9NVia/z7ygLDHakEuwduYEH4wan9hoOJx0lbT95S1+AksuPXZJER4upnlA4rO5UwHOGPUJjCfaBgMIPLjKZJt79u3vxTPuZ7rjtsnTyXZQUMP0zrVBSJEqgHzjJgqxjx/P0RPH7QnMCyoRVIOr70CPbIFuakTr89pZynlaAEc5HymSPhkO+5shKWZYq6Ih2S2RypmNPmT+WNUpOFDEOd8FFuXPCwOwJ/qKE2PcrPtLqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iejwPM4A+RJMm4P8DSjTsJUDLux1/J7yvrTzJEEvUis=;
 b=MPhNCb3V+K2OQZFufUgJcpK+4tV/OFsBYGPlkWtRbfR3jLp4q0pxHWLkBmFXV8Rz4VKCcBv0gkOSAhWPpFHvLKDd1ziqYt1SeiAtZhbXEU44PvJw5Dxf0Vdy50Y7xhyMJ12eKtD4fwE3FUXQpSK6Xm8+2c5lwb8skL065tC7D8ubk7FaSH/mUcjiGHMptZBoUme+pGdvA5j5/V2CR8JSrKXw/hcJebjEAwXKbFbvzyUAmgJQ7g5tAyvUR9F0Z7CsUdakVtDqKS80zWrHFWZiGSK2sOdUxlWLhsQF5/iIoAssCTaiMEBe2eRA9TVy9hzzywk/9nOF9Qy+ta376RAI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iejwPM4A+RJMm4P8DSjTsJUDLux1/J7yvrTzJEEvUis=;
 b=HZjHyNdXPo2+vn6GLwtdUFHrbDKG5wcc7V4YJe+0mOdmcCXMzACywiWxh+RzaEtMzuVS0/6bSd3zs2Ur/Dua8ZF5Ad1es4rfe4NlWZLNPwbRi3IeBdT4WYJMuoYrvDVTc4V/FsWuWpaSW/TxSUyJr9HKsOMFO8cIeFPb1x3HwzDEM2zJvvPmb3AfGadRfxzP9mpfS8kBu6SmtHLRBl/2Qfm5wpxY8gcBdogPY4nwDhCDfT2sxkzSqlQbYtFXJAb+QYm4fdkmJiGE7uX8polN2lv7/1fHIrNK0SXk5BTODMUs2YzIkxPPQnBmrxsu1ms68TO00Sp8uWeSRzcGcKLRYw==
Received: from BLAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:335::28)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:33 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::71) by BLAPR05CA0047.outlook.office365.com
 (2603:10b6:208:335::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:43:04 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:58 -0800
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
Subject: [PATCH v6 07/13] PCI: tegra194: Set LTR message request before PCIe link up
Date: Tue, 24 Feb 2026 00:11:45 +0530
Message-ID: <20260223184151.3083221-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef3ca6a-4fcf-4e1c-aec3-08de730b7231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZj82K26GJ0wXQuVzwQHNUL7DTMEu0LwSrplIO/lItUdnnUQYxmHy6n3W73M?=
 =?us-ascii?Q?uKm/wJrcIGH+tj1RoyixyONA16ux8m3qz/zM9rsW03fC1bYMo3622rFnbk6F?=
 =?us-ascii?Q?yKOwHEbyflcGJOf8uPb/QmfuTxip8YRNRBK4jj1VxBCMQTYupKRNTROJl1kO?=
 =?us-ascii?Q?axEW2WUbhtaPMKJX01J7yUA18WTHRFFqT5PA2A4Se2MxnSN2EfvRYnbgDiXv?=
 =?us-ascii?Q?1bQmrrjO+FHQamGhemk3DkgruKh7jkbJPtI8tMutyJ1HlIBOpr54VwwHe2TL?=
 =?us-ascii?Q?c133imvHNnWjFdihn+pCk50cgzLBsR9dOTSoNgMJHeUpirSxm6ynRHnjQ2UF?=
 =?us-ascii?Q?eoDr89dhAB8eDrr8sgvF2kMeoX5Xcwh+hLlDxu0u2+YmeuqmYr6I74JiZwLt?=
 =?us-ascii?Q?g2d7BNHSY0PpTG/B8Dm8jfSxs56jwP9xgFv4osMHsmI26/Fc38dU39/hL355?=
 =?us-ascii?Q?QzX4cexzNMM5MMQ/Sm5JSYjUeyysTJmlvYG8FMrgylngJsQgCiTRPpwJAlQS?=
 =?us-ascii?Q?nvDk+wQAELE+0B+IxzWzzUSedS6QoX86Yqoi1oEYFWOnJ/FgNpm/AVMPJKAz?=
 =?us-ascii?Q?mXpwdP2QhVcpsGmx9K0vdafQdOT49lObTyAeOZw0fwUECr0TNEMQvIBPYEOj?=
 =?us-ascii?Q?7iU/mbV6aCc97QtjVzzanYOnifZxFNn4SNS2rKYk1zB6byHsySQd0yCQizPC?=
 =?us-ascii?Q?l0mj8BEIr8hQSF1nK9kLIDApP0Qdh5IRf24Ndj3rNrg/oXVa7sUVu5nPLsAG?=
 =?us-ascii?Q?vAHoXRkjFfQarTniyTS3K9CJFnOxrIKb+lTmBA8syW8zku+fvD2UlFTLTz1r?=
 =?us-ascii?Q?D9jqWyTk0w3Wg1ELg60Fb4/j+K7l0mcWpb2Sn/yUryn1YPhtN2QkzlB6GLYp?=
 =?us-ascii?Q?1VMDieMK+f5d2PEHoS6WcNs+pBZwLKNikI5/Kt28sZ8mHEBSQFXGws5HZ+Sb?=
 =?us-ascii?Q?flqW4/C8IR0z8Xto998GQoMYEky+aRi+wzEtHYfuxMEMaw/6pPJl9MgjjYqv?=
 =?us-ascii?Q?gosgwXHBRFJe3k/zkb2CMmI7x6dy2i4sHLRS1/QET2OkRlatRA61HH1RZwPG?=
 =?us-ascii?Q?jntBqI31wz2KX7f5hH6t/K/fWFeiYS7dUz7vd7oRElsmWcYaQiNpqGv/Sgx3?=
 =?us-ascii?Q?RSlZEUNwwoh3ZT7DHTj0ZLpoHga+/8pWXGJr8g5YXEm8UhfTbKNcXhLClXmd?=
 =?us-ascii?Q?/VBKpdzVcH59T4D2tcAJjJIou9PLJHkiq3xUx0inIDmYDRGLBVWuRn44kiJk?=
 =?us-ascii?Q?+SSdxKjSC94JeMc1otsxuNvF8aK7HtM2Oy2sskk1VEmFTtRZThmIAkmIO6hB?=
 =?us-ascii?Q?lcGSfrxFameeBzv85rz9cMViQXrHhXWg+ZvZ5Fl36MvohjhbjCnBvkH4iQeB?=
 =?us-ascii?Q?aB0oyrQ6jEyx7mFlVoBLfomHRa7iBV20+M4E59g2w4UyQ8ZMhl6KM6Xo/3k5?=
 =?us-ascii?Q?rIpfz7+gqtzSLOAu01EjJv4pMQpXs+jJfYdGc/zOWdgivGzfRHN1GlS8oejV?=
 =?us-ascii?Q?ieThDaxrWknCijXFLfNXVX1tfgmIg5bo9kKVDKyJBQxFZNfJYSE3GqqYlZOH?=
 =?us-ascii?Q?NjBEZF2sD/RklEvcPRqdhOp6nRL2VnbVHqdAoaLrI74XKnMoO/23NH37lSn+?=
 =?us-ascii?Q?eo4lJUi1812B5pPIkjGgfjIDRTZWySkpljit1a6mrwUzvGK404KoyEKdQB0o?=
 =?us-ascii?Q?ooHkka10FJRJIzCkQnLOiIEORnk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4xFSY6zsnRUgty1zatfEmSKc2Hl+fJt0hc8S7jY7NF3bX9MwpusMuAckA4Sd3rAShrDLDtxCEw1eqxWpuJpkc9DTsSkucSXcfWNi2VzOexUTCMPq5H3S/76zG9hRp5gIzFCxr3QbCLqLWWV3iKyJRzuFq347/zUVr93dJJ0XNbWIf5UcpgZBheEQkCf7Aod6bTTubU2Nedfujacv/q/Fl1KDzMfMXKC5LeHvjyyKe0kc3sksSkqgFWb/qiWLVNhkp7CnFDbBcFSfzwFhAgkkRLJnJdnvwfrfQG1actPkA1fYtp8ggYxidCXQmsvyqCZ1gHwpTxetYwHVHWpIK3D3D3psgZTVeP2tUWRpY22s+zfyJgaRXrXKz6WHsqZEIbrgLbCsP5SPn7c4Ei2r6HKg0gn6EUDFKQGaeSt4kDfuj5ie0FtJ2gpl6HJrv/zV29iT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:32.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef3ca6a-4fcf-4e1c-aec3-08de730b7231
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

From: Vidya Sagar <vidyas@nvidia.com>

LTR message should be sent as soon as the root port enables LTR in the
endpoint. Set snoop & no snoop LTR timing and LTR message request before
PCIe links up. This ensures that LTR message is sent upstream as soon as
LTR is enabled.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a6868b77e3b7..ad1056d68d6d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -124,6 +124,7 @@
 
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
+#define LTR_MST_NO_SNOOP_SHIFT			16
 #define LTR_NOSNOOP_MSG_REQ			BIT(31)
 
 #define APPL_LTR_MSG_2				0xC8
@@ -488,15 +489,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
@@ -1805,6 +1797,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
+	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

