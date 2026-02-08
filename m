Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093E2F0C7E;
	Sun,  8 Feb 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574146; cv=fail; b=b3Iu4poTZ+FP4sT6lRvvuKo1dgQvsI49o3ZLHUmVllTUIzUkpIL/pr0tzhxJd7edHK7bHopDnrPpgFx8/eQmvR6d7I2uhnwgIS8qq1EFD9Qu1WuV07AjcX0mXyf7ZXbAepgwZeW2kiPVD+zgb0gN71IxzwUpSMGfB9G3kNEKcuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574146; c=relaxed/simple;
	bh=UD5S1S0QhKGR6dEmCLXeDyvphGdh3UQ7+EltKvz8olc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8nohTBUC8Kfkm8vRdB0mAdFJ+/eDMa9AJatoVumu4CIqGjcNNzRTnsw22HRURHIxpuFlYX0665oMelgHGBaV4EWI4R7kVRj2v+Xhi8wyKLmH70PLEYD2p044IvwL/ncWaCTzlyercVfTM6AT6dVmtg946yWJQH/hE9gpBVHoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tk3yw48l; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tk3yw48l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4iepITwHLgaiH42k6MkesenZzrkxg0FMmyBrvSzBEdeyobYIYEm333KKLvTZ7FsMByTYieMt7beB0wKIvGPWePvFZqBY24dSsmcj02bufsnW+H0u7b4rurokxOW+4XUw704fIXoFeNHxwsXMn8p0qr2ZmFwZ3a8ZMvWHgyUdxOGYCAsguKs4AtiEPN7VXGGrCMQPIguSeG9cvNM4kbGBqvzR3gdiApGVpcKy2N7+z83HqHxmjuSFRcfURhhKCT3fPXePdjjo90tNfBF5oCx13hUB96qRcx0u3g6Av4TSOE6bWP+sV3Vo5BXJRl1mf8GX9cVZxYAyvceg1lkAcRs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf0+AibtiYhryPFs1XY+JAdxBxOxKnEM2ULWrEJU9co=;
 b=RK+yRjiABsyPmzkvq2pWD3q5ofrOh6xiyfTbONKOYeCzukDaixm7W+QVVZOSGGgKVQbqRQHXYToAYP7ftTC6ifdGky7EfML0OY26LQrgcSBGSMIUcMpElSmy3aOtRnffhx5ecMAckdLn4dXxu2uOx30Glg+pr2jpzLVH0kfvC2mlphaRWhJasq4aV97+SBjnUPKtsNAoLxRDsbZE1BPnOJGnjAEtewdFlVjo95K3TUw80dbgd4B3B6tDsmpNhupu6VmW3hPw5LOEvU6VOzSUU8I9aq2NpF2oDN4+KoDrQ9ElH+f8e1Nju2i+fJMm3+Fndz023fxzV0Il+i1u/2Yvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf0+AibtiYhryPFs1XY+JAdxBxOxKnEM2ULWrEJU9co=;
 b=Tk3yw48l/KaT3XdjYXgYFe4xsIJhH5u8eX3FsBLewjLXEAEEMvROAIMXIJfuCrjxtR6sXdMTazDueTYzCDqStNp2YNEediaHFHT5jM3FlvKa7idEoIV/aiqOpFry9fYDJ2zn4HfSq4ooKf9Rw+7nrkJov+jdtrtQOLpFCgsvIyWISmK+c3kHAyEZg9L1i+SYhpQfPbJBEcQmUax5CltZHzBDtF+ypHKNRfUwV/NzFmkCqiDptF3XsoAQvXVr77X7uMNM9XRyz51K2G6xrHlLhMiQoSlwNZfqSOuCnKftLJHDJM57PlM+UnqoRe7kJFk/wePu7JYg4qtvYA7xRo1pLA==
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:09:03 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::5e) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Sun,
 8 Feb 2026 18:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:09:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:55 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:49 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,08/13] PCI: tegra194: Disable direct speed change for EP
Date: Sun, 8 Feb 2026 23:37:41 +0530
Message-ID: <20260208180746.2024338-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a40ed07-a8c5-4dc1-7d1d-08de673d23c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5U80U6lXKM5ZU3pGF5bq6DZ+BdaexhKkygZiID8H4NarGi7JpOCyv7hvI0e?=
 =?us-ascii?Q?ixW1HwmXGmmlceeWifmbPYdhvz8TI1wL6vkxG9PDgI3lCEUdhimRe7fKkhOq?=
 =?us-ascii?Q?TWp6APgeldi9eYHsYvgIdfx1lUxISoUgqsu58rBVBCU+816ZtDZT4JfPqMJp?=
 =?us-ascii?Q?UYvQCpjc48VO0bm6JB9Ebfh9VeBdFvpKKtANLSB0Z3t3AEYiCUbmGiGJW+Al?=
 =?us-ascii?Q?3t6zud2kAt5Q/m/N4ayWBd2aTzXR/ehr3jviIH63MsfMYmKJGl3ZHn9DZp1C?=
 =?us-ascii?Q?1K49jYZ4U8MmKkvLJBvZj57MaL4CAwTDPQWC1XxRCmqlbv7nZLfJHTzhIAJG?=
 =?us-ascii?Q?7/5EZVrFseo2bQ7L4yaBD6KHM+fQ6jqrCRRtQ6TWfgWbZOVsbd7SXoRLQ4CN?=
 =?us-ascii?Q?9WoaSdW35xWhx+pN2whtdGjI+dIGqitSDZmFOBb+I9Dn6i9iekGC/AdM6O18?=
 =?us-ascii?Q?fMLhI4QxuzY/C1MrIYK9nTdR42afqbC+wlTwcPZf8Aa90ClIgmuebG19jNVZ?=
 =?us-ascii?Q?cjN6MZG2sevropLwQB1Nut2QmTtg+u8mVghf44+ptvLYfg88NFhzypZiUoaY?=
 =?us-ascii?Q?F2ViCQqt5yn6iXFTMkGspQmDIf5PW1f142dv8SP3cMmbENoCllr+fX7ie9Kd?=
 =?us-ascii?Q?lx6T8xqXi4AGTbxZho729UEkKMF9KXX5r45+2rcvGgebZwGqYkg2D0c/3og/?=
 =?us-ascii?Q?F8XhG+Ib8wYB6p3QsL1ZCfEQ5lC06ittUCrQVb6a4vMMnTeXeLcsP/+a9eMn?=
 =?us-ascii?Q?trlOOyMCxlzrsL1zmQhPOE4ek4Vi1NUtQSbCIaCuqZtW2AKAB+kpEYRS/7jQ?=
 =?us-ascii?Q?H8XnxQcJGCdF9444JC44E6HB3Eg0/iN0BvxGf9vh7vLwSTGZlVvpMJMKzBiV?=
 =?us-ascii?Q?serNHtt8PK/CiYohbfF4yL8/pw5TMhKFBqGsK9r+g8vUAHOop1nvOt0SrK4X?=
 =?us-ascii?Q?iX8exZuvbMr1YqSnjkxeeZPJowywEsTAN68BdeF4qWDBE4Q3RWUNykjocEqx?=
 =?us-ascii?Q?wCkMqlYY46khi7G1W/n3+P/5NJ2LhNudBokjC4uypV4FKbswgysB6xqw7sss?=
 =?us-ascii?Q?Qt5MZX4rdVnPDOCcl8JDqU8tcxvQwRaEWMR0/dp3BDjD6Ln6/2wHSWwRppFw?=
 =?us-ascii?Q?oI3CnzOKiOcH/MCgcUAxiXnRxFNXFqay+ST9dN2wcDwUn01CkBv1fTz0dhIe?=
 =?us-ascii?Q?fPWP2IBSLgNza+mJjmrWllx6ntyVyyBlODJrAnCI3RvShYytIxuwcfc5AK4n?=
 =?us-ascii?Q?60HDuZhbafHargt/rkbo8t0+3W39CSSG4+QRWGRrDL4gVxO0AKN3cJGcqUWr?=
 =?us-ascii?Q?wwfAqwYxy5wnjwQh7r0QeOHNAPr74Wc31pWVdgVCrFpd5fKoEEwiWu58gDLR?=
 =?us-ascii?Q?EsZw5AkWgdFsn0ISeJyyj2N3mb5uT3tHVZ3g2R76ZiTsmgdYEYLMaGcw04Ip?=
 =?us-ascii?Q?GOL+ccueA7X0BfO8s4/TPDhdQfMXsDbjusJdtkceDke1wmMnNNKIGTO0576s?=
 =?us-ascii?Q?+djOQZKQ630EMvQPRA7Q+x97dTaq43MmG8FRotPSeEVZY4M1R7J671lziYNg?=
 =?us-ascii?Q?bx5buzvj5iS91e+34HVnZEG68447vxfPmCAj5n9lXUO5C6xfGGN9mmFbhnOF?=
 =?us-ascii?Q?O4gRflrQc3HBgCVdq1hDiR+H9RAmkMJKuPUwlvWN8duvx3xfBsr2emcEd6ly?=
 =?us-ascii?Q?s8t3Vvt8gBoV0KueirsnOEDTEt8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4hQkPkM8MOmGoDaxLDaHPZGrjgsVDqrAH3sL6voxMcQRPgplL4JPbQTsAB+yEyGQEZ5ho4a/pmjboPKg9DkvUVzktwbLUQ7qmRM6kFmAXim/8UKTHTMAy826e64ZZEdYRg4RsY7Tam08Q7NQ77KJEbOOSKdAr5dpIo3w4EKfQmesUo/1vsulfvXSIH+3ZHByHm56jFLmHQA2UDHL1Mp/3iZNCly3Z+Tt9BDl9/seQrbD+oeGZjhfmxxSAjLwU10rzybqUMX815QXp4s8eNsCxJRCM9LKEFb8CZ4tUN3jPvxRafCoL7YXol7agKbr9C8aGrrrXY52D2jvp7JEnPHCFmW3CE6ga477QG4DOiprBA0cJibfJbrdJZCuaLf5R+glWhPW8fg2DC7TzFbmT1CDoHXDeWu6ljeCDJJOEHUbGo5XdAkD3WX5qjZdpgMDuXNF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:02.2817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a40ed07-a8c5-4dc1-7d1d-08de673d23c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

From: Vidya Sagar <vidyas@nvidia.com>

Disable direct speed change for the endpoint to prevent it from initiating
the speed change post physical layer link up at gen1. This leaves the speed
change ownership with the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 80da5a032bd4..7463cb1d9606 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1807,6 +1807,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.34.1

