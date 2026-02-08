Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2C2F9998;
	Sun,  8 Feb 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574122; cv=fail; b=O4d4/QtdTREcHRv8gCMNRzTjPsJMX5rY5fJEWOGHublusSXtmQtDl98vN85zykmTrtAFaZa9fr51NJHf565+DhggtEwHG/Hq/IHd5h7csyGr8/sbj5WxblanyNVM1Djt8S6DWtgC4aW5xatc9tKFmon7DELSuKki4iFwEo3NXE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574122; c=relaxed/simple;
	bh=YAI5yoiWjlpjE36qex4v84naiQw4+QdyXEzMM/CtEO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsSQpDRz+S1OybZs1aX2QFH7vH17IrYtxbH7Od04Qgukvee2QBA7QqcZnc2iqMy9/ElEC1pe4PgcdGE60G2VTUlVSIhNronsRotCJdSEKqugmf8xguytxaT7U0uWrlIlX7En9JQmtur2rYhw4f/7qSSGpu9V6FM0ltyzKoAASfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvbTPsFb; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvbTPsFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv8QVkjxbSWPrNcXFSfbAygKQa1bNYimN4vCLxRJHSpnab6DDmL4u1DSxe4nQp0SoEzWvwzcjptaptFwPnh4yhYDsJgwplhk0KX8Vp3dfz8jMMIV1bhebefNWAs4N8VeaYg3wSY/HadJ68YiL7J8OcjG3bb7fLNImz8caof+YsK0nhwZE7Yzkw8aiU2R8mfNGBlRDkI9mLjedR18e0xhApdrdOKSpdXe7kFPSQabCguArx7SL+l3FvG1X17qCKa1IpZPyBPAerDrSwKi1aXKul3VNRUsLpVqBEFQCWouxIwH04WUILalGas5y3VIh2yvxN2zN+ixGwqZBzP9xGSk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjupiCA1e4gtL/lve7MJUi1UlycauBcC/omnoNN9+CU=;
 b=IJdvlX4MKEuyaLVojVocl4S91tXnEwQeXKccJDibeXe5yXXenhpx5plhzFziE0SPsF5vcDByoaOzPJxSnNEqWF2gxzg9+PC8C0jBx3/xTwyhzuwmJMIT4roE0/aYIJ5wKi1y4Aulg080932VHgHMK9fx3Ki9G8tlHBSbxQ50yQB9jK46Q4/Hk89+0h7Oc9wTUAo/JSFuN3lBNENfWKaXd3lbWXsG3ufcY0IFpZtBeFB5oaq1ftlhu5xGRcl4mDWnOITeh+6X4+MjssWgNfUdDzLgqAU3epIbAgG/y0jOnmIy4jrBva5NEVaUBg52OgaeXKGA1n0/Fs6zVWO8Juua5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjupiCA1e4gtL/lve7MJUi1UlycauBcC/omnoNN9+CU=;
 b=HvbTPsFbejGBP2bHfaDCMXFdrnJVg2X44mceJeNAkkIUpG89399FuS7gjSvp8TYoc2gzkQLudlDStdsyiI7/fXxi/+gGjELRIAfn7e9mgnxp7zR2HzBwWlgGrjxEH3ZKJo1g1BNqWmw/fwcaCJ0oQmA71A3FDdVXzcAHDuitVlAlivME2lD2mmWL2brE0TM1Icpc3XpHd+GmyV1dW1WMuDs2hk7qqOufRTqU4q1QlbQnlM0/65cwGd8KUzDq4fyC2iIwFqlu+OyzveqiJ38Xcwc5FbgyGFp/AW5X0msVhBAIGOwRLBAF4VcbAvg4iaQ6sn82ugDU2ZFuG/Z2UOi/JQ==
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 18:08:37 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::37) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.4 via Frontend Transport; Sun, 8
 Feb 2026 18:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:08:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:26 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:20 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,03/13] PCI: tegra194: Don't force the device into the D0 state before L2
Date: Sun, 8 Feb 2026 23:37:36 +0530
Message-ID: <20260208180746.2024338-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: a899ebba-7693-4b09-ed93-08de673d1518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6TQALTHdAO9DvGaSSWwMT4iPP5U5MklI1W0kWaaJkC6rLbZUQ23BUPnz2rF?=
 =?us-ascii?Q?o52+RuWVdYfjwE110PkaPhBSe/ho5wPlSntA1A7F8kur1o6QC8WGVneciDIc?=
 =?us-ascii?Q?B6SO11k/PqbcadnSfxVA0zvcp3p6ocICAMS/pqOfyQUIhQZI5Yi6omCt6yTk?=
 =?us-ascii?Q?Pp5VrIzvDsIe1dGM1nfdpMKk6ozvaROfxaWAoa5j4A1jjlaUvHKzFOLMX2ts?=
 =?us-ascii?Q?6wODbC3iXQ19SrsSEe3PpMAB51mt13tzzH20lM//NLFx8RJ0ij/1Q7vRDtMB?=
 =?us-ascii?Q?k1skk8p7gGkDKhcZIMkIiVXnYjtqAHwmRRbsmZXxupoIvhsvNf2V/BTxgK0d?=
 =?us-ascii?Q?W31H9aSAJys3zPkEzg4YknrFmoDfJ9t9Z9ejO8PDZ4Yh9pCvm/jb5f8VKCDW?=
 =?us-ascii?Q?ZC7/sK6uE53c2VGTJc6FhO9SZFFglKZq6gaVjZoAz3lLjHw0jbmbViJ6rxo/?=
 =?us-ascii?Q?zr+jOYE+4DcnukoSwH05itV5rxtxnUpY6Yf2BkF22+xuq0P7U52pMQ6ZrpWH?=
 =?us-ascii?Q?+tkTgLQhVXqNHC68GYhZTx1Yjw19WyLDPLdL8voHqk/VKTpvecUrkmEBkAFG?=
 =?us-ascii?Q?zk47OJc6A0vK4atnEF761PWj26ZXDiuOuBIv7kBu8MgOc6SCcTzIVMNpG3ac?=
 =?us-ascii?Q?KKuQdPVvXp1WHYajtjBJjAlkNTq3BXKhgBuE/rtRkPDoo4jUx4FfQ7idtqvc?=
 =?us-ascii?Q?lN2SEYIXdIzRNcqGAdDfSdzplXyBr4ANXCcZ5hUCq3EHGYfms3zzXmG+h3JT?=
 =?us-ascii?Q?vsqIcugcd6QOHUk3A5WC69arkjjcAppGlI2pSESuDDEe3XiYAkktkq4+bG13?=
 =?us-ascii?Q?fqd+2gVRnmMnPM6DFpz68PV15y2XTbUGqQEEN0c5B64ce++nUvnK/IqJb5Vj?=
 =?us-ascii?Q?R9q5mRYEPpN4KMWf75lxHSDo0BSoepkSOrr58OaaHNHDfLY5MVssfEtbb8Rd?=
 =?us-ascii?Q?t3Fxzp4YV41nzKCiGWFXN38Kibsf5PirW/hQiQ2GUzZe79jf1YVLFdbAA8ip?=
 =?us-ascii?Q?OfIVAvM9RcezJj1u3eULXDWhdYVHr3rF4fR9vq9A7rc3OaI8QRhpc6K5vjHt?=
 =?us-ascii?Q?xc0L4o8AT7okDqCLnTDctulbAJ5ak+AVyETVHCX3qFcQ1+56qwlxSWnpCxB6?=
 =?us-ascii?Q?uO0/CGmLOIvTtcpTQFB/W96MfFIz9rZhtLN4NEBCyQOm5yNDKsEt8UBZ8X1s?=
 =?us-ascii?Q?gJsVKrrWDvly/XSyHPbP6wL4csp+Swyvso85eTqUv5i1KtXOvrJSKfVSik2V?=
 =?us-ascii?Q?QCLQEZ4J6vzETFjUEwMifj5Bb563DDob87Uo9rqHKtWfa9f1up6lvLPQu3y9?=
 =?us-ascii?Q?g/yNHPhMxBqItOigYjiZaVCWUYw/i1OyGDE3h3lpQg+gcEieJ3BwCQWLjVx3?=
 =?us-ascii?Q?fS3PyA2Ft5b/yj0uzbvAiVdrJD5FBLbtYVadV0p9c0PACjwU6EoAoQ073YH3?=
 =?us-ascii?Q?f2yhtF8RDBZ7kYM+0bH2L5sxzsWPAKGC3ZS4xug7NvdZAa3+5QfdWCl5c0mY?=
 =?us-ascii?Q?hUd6DiM3oEbh+clOgb4zlUP7P+0K38xkM9Guy02sm/0soHO3/68O7yD8sd8U?=
 =?us-ascii?Q?tlt4u3iOzhqKNJxUV4iy1Y5WYzzMG2C9z5JHsRgbQkGnrQ+i8BuNHkQV1nsP?=
 =?us-ascii?Q?8+chPhdBZdY20uq21aCKjQxqk0+kCvyetYPfw53hUUNou88KMVAJEC92BdGP?=
 =?us-ascii?Q?d6Kl2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bJqgStkyK2jq+CcOY381D/IRcp2O184qIGD7uHGQJQvJdyngM8TEscTT2aWBF73lL2hIEdJ5skIvsqdwQmA8GldfHJhAHjGDaC4T/w7eWlUE/7Q+djxaY/BZzXL/w/ej+SKYl7IcUFoB3Jjb2PsjGf9JeAIi2X0HKUYmF+srIqusUGlRLdNrliRkpwL/Hzny8J/Av7xqmijEHEOyRsBI5Mz2y2X0cjfwQg2vZOlf/Y7zpbRayogEWkUmmo+7HMsq8LpsiXmxD6BGKoK6CCgFMsjnvLiH9Er0Z7/kK3n1Fu1XhkPdtPBCeg4zH4k1F974WuBC4vDsdI5EEQrAia6RqgiCSTBrX09OfHIjGyX1e3YcbGG1WRVPZb5OQIbXezvHd0H4n18hHBHM8FQkirxsDwtqxA8B9S95Dj+YCDkkGuGRBksHdnk29ANJrQW6pFBL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:37.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a899ebba-7693-4b09-ed93-08de673d1518
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe endpoint device
should be in D3 state to assert wake# pin. This takes precedence over PCI
Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
which states that the device can be put into D0 state before taking the
link to L2 state. So, to enable the wake functionality for endpoints, do
not force the devices to D0 state before taking the link to L2 state.
There is no functional issue with the endpoints where the link doesn't go
into L2 state (the reason why the earlier change was made in the first
place) as the root port proceeds with the usual flow post PME timeout.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4ac6b1cea13f..808a1e213b79 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1261,44 +1261,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
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
@@ -1627,7 +1589,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2337,7 +2298,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2411,7 +2371,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 			return;
 
 		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_downstream_dev_to_D0(pcie);
 
 		disable_irq(pcie->pci.pp.irq);
 		if (IS_ENABLED(CONFIG_PCI_MSI))
-- 
2.34.1

