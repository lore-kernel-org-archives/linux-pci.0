Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756533555B;
	Tue,  3 Mar 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520954; cv=fail; b=mK2CCvQQeSowMJcAbE8Dv4y4A1TOaV8qkZaMEiRhrgQjvoPCdNCBxIIsgbmXWsHD36IkXZi+klmljz0cV8VxN5PWFWQFYPbVrzYo3TqsWHEcyU4e6Uzm/62pituCpYsJacexBuN/qZLr75JdN5Cpstys5pDoDT0TCjO4waUV6e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520954; c=relaxed/simple;
	bh=qr9BGECjnddRxq6Y55Ear8v8TDZhFqM9U6XbxlPgmKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4k7bHWYG2dC4uF1IKwcTbenmOHy2I6QjuQxdc0YCmlJmA8LU/Ns+XfxV0Kzb1kP5sWVKKAUEQpGy6OSX/UTC+iJwSvF2xQU16tFpf7foiRb3jV4jcZyTRRPyYsPdU6P1eH53lqRsfOTCZl6Z+Es3wiU83ThVjiztbGsv1GTH44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9AsW9ml; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9AsW9ml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhhNafcjmX6HyUjubmomf/qozrGILACdm7rLQmjQ8R8BrVwVE0vnHrPUwUA+Dh9IFhkw/9CDtrWJxilHm/TxLiDPUbqTXCV0q1SjGSqdmo2tS7Jgd4XFCWHaKvRYQokTXUi+GROL05QQS0jn7Z9tnkpuUcAtOA0dzw8e+D5qyyXbGRHuDm61CtNuNABoRuv6DlRAz7pe6L2snjLj1wYBxh225t2BnCce7gOAt44nkevq36/OYzCWcdGWsRQopcq4WwTrM+W7OErQV18nf+/LSJJTgMSKrRiaklLkmJhmBWOuG5NUrb1woniU1qVCsM3CoZI2IPSvwEMBJreL3DKGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMywdM2zlWVRoxF6FaQVIcT9UlXKyIQp0fw2YuyUl9I=;
 b=JdlJ8iSHUgx9e2y0Ijio0QBb/e0hNcP2Y4+F05TjYGU6sm3b6lWwYWwe8RlDdINLDwu+5U6f/urYskREg0hZFiBuBi9r6LX1+hZjfYf2m3cF4PHG48EH8vC8z6E6wmih3Arp9Bmk9L0oY1eAh5wnO6oyXUanzTuTuB/Y0Z34O7TeRkaBfTRJiGlcpz029C41Qwr+u1SKCfBQYK30ZscDELmkw8MVkr6E+Z8UmUt2kyMPqrQ/rLebIss88SKRRd0pc0ypLNl9nrhD76sM7v+wmChQIFvGNjFTilvcp4bnwAefd5hvPrBdwWBfICLD8eiZ1HZvK+1gJjMVY+gQl9eLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMywdM2zlWVRoxF6FaQVIcT9UlXKyIQp0fw2YuyUl9I=;
 b=R9AsW9mlsLbBHMta1lNMrGFPT50/pvNKbKAFywcdYRz3Y4azVQ8FKeZ2f2ryVobT1RlCXP66ZY5RYMhF4YMI3vi0objW0rEyF4MYX4ksEvhd01pV8bup2BKmsPghRnY+dvcYxjcP9SlTvhkrIx1AlYjovceFKuTke+VPUZn5jBLnz9+ue/Qoxa9+L8pSKbPKQQ2RR68IgKMYGpvyWb7BoxcVShOYzn6XN95u7U2VvtuM7Y93+0i99lSY5mzvYbDxsfubOIvix131F9I5VcURfYVkQM8tALOfflMgZQpNVS0cgFCN97+sN/8pO23r80p2BYjRy+2RT8+vfAyA9zT0LA==
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:55:48 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::17) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:55:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:36 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:29 -0800
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
Subject: [PATCH v7 03/13] PCI: tegra194: Don't force the device into the D0 state before L2
Date: Tue, 3 Mar 2026 12:24:38 +0530
Message-ID: <20260303065448.2361488-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b7bc05-5140-4faf-6cfa-08de78f1e6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	gjbTaCH4O4WxUQBAB4LgjFAmejhsyuk0bds42FoTbt6DUOnt6hySIFQ242QTfJ7WKNPuiIFWcywnbIabGlhKb4cTnC3ZczyEeuLVtLuRvEpH7jYMwVVfzdfk0S00GCwtB3lzAQtv/QJ9cJ6gtLXKOcnsfHIp2+YGDjHF2+u4liO52UThB33BTLDIBTPeDgmwDs1hovkiTMQN8bDSrfJIZj3BoSkz1FyGtbRUfsTiv11sSLqaUo8fSHr2iDHFgQXEezT9eMfjQTT/LJTKSvcNz304jsfecekb402XQpdxBLu5zegcNjI7WnkYg/RABr05e+0wDvIbA8gd+GgmAzGV3LbwUc9zcyJJQ0s7C74UdLxUOTOrjS7LyN+WKfv7wTzhZJ/ipuncvuNFcHgBcGU1Eg75HaquDRGBwT4wsBlF4F8Bmwwkd0Xd40DyQMzqxzQK25oqOX+UnSFhu67rxEDHnow1YXletcWSXLiqZpXg0+slBsGdm6gz9czWbS81vTS5mI8kKSZkmKYGx3reGITTUYqq1A1ufhRRI8nc7P9LganKNGLlLueZn+0GTGwMbkzIQcOkSc5b5JcHxrDblvR8D58oSgEFM2nqzuZ8G1BmBrhoy/9xR1Us/p6iE3s7yYm60Zz6S/GOQE/E96xiWZvB8b1YOVvL0VGA0inxVlfE3LnxIfLU6S9LVuuAxzjjYqTjs8osjZWygZal6lLA6H4xD5eI4PfEWIMYeYNE8pUu8W6zNNyT1HKZqGPHaUFAPHeBGtVEoEM/HzOvjBk1iMmHpT7cs8KoXszdJ0934AiI5Pxsc6hdpsaExZCSWF237xXOb9nnEWgHFdoU44lQptQG6w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lmbk2sbBJX0r5nT3fMs391mtUvQu2rxrSUUOjL4gmipYdwCEs+de77O0/9ws/ZF+TyXG9cv9uCh6JoZbiWnHsGQZiaFN6aeb8hcdLZLs619IFsumuc2KSrarG/HFgTlDyI71aWYGOo6j/+L0WktdMKVh7XXAJwawfTctl2xbEv5u2yL5tH/+L2qJCwQe5iD9zsZsczuHro+wjmNO3xzNtQaR8WoYsHMYp9lmc51kgCaRvD8fulzSWn2o9V1+KyiA0fueyNNzo747Zj+kjZc1HdK+S9ggux7Wt4yOJH2nR1Tu2BYDSRYpLT9wlIVAiRg/Zhok+8Y1TRbXGdapZhlAF161MLuHG8zoGrcUs5EiESwJ/gBu1ijSTnjbJF/YVJl3xC3wfEAgq74YIgiHNWUdrTcA/zydLohccmPSGYKukMF92mubG9HP3F27xt9IKydi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:55:48.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b7bc05-5140-4faf-6cfa-08de78f1e6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe Endpoint device
should be in D3 state to assert wake# pin. This takes precedence over PCI
Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
which states that the device can be put into D0 state before taking the
link to L2 state. To enable the wake functionality for Endpoint devices,
do not force the devices to D0 state before taking the link to L2 state.
There is no functional issue with the Endpoint devices where the link
doesn't go into L2 state (the reason why the earlier change was made in
the first place) as the Root Port proceeds with the usual flow post PME
timeout.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: Fix commit message
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index afbc0bdd8a93..831986de584e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1258,44 +1258,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	return 0;
 }
 
-static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-{
-	struct dw_pcie_rp *pp = &pcie->pci.pp;
-	struct pci_bus *child, *root_port_bus = NULL;
-	struct pci_dev *pdev;
-
-	/*
-	 * link doesn't go into L2 state with some of the endpoints with Tegra
-	 * if they are not in D0 state. So, need to make sure that immediate
-	 * downstream devices are in D0 state before sending PME_TurnOff to put
-	 * link into L2 state.
-	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
-	 * 5.2 Link State Power Management (Page #428).
-	 */
-
-	list_for_each_entry(child, &pp->bridge->bus->children, node) {
-		if (child->parent == pp->bridge->bus) {
-			root_port_bus = child;
-			break;
-		}
-	}
-
-	if (!root_port_bus) {
-		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
-		return;
-	}
-
-	/* Bring downstream devices to D0 if they are not already in */
-	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
-		if (PCI_SLOT(pdev->devfn) == 0) {
-			if (pci_set_power_state(pdev, PCI_D0))
-				dev_err(pcie->dev,
-					"Failed to transition %s to D0 state\n",
-					dev_name(&pdev->dev));
-		}
-	}
-}
-
 static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
 {
 	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
@@ -1625,7 +1587,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2335,7 +2296,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2409,7 +2369,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 			return;
 
 		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_downstream_dev_to_D0(pcie);
 
 		disable_irq(pcie->pci.pp.irq);
 		if (IS_ENABLED(CONFIG_PCI_MSI))
-- 
2.34.1

