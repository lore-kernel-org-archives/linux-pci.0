Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F5368299;
	Mon, 23 Feb 2026 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872199; cv=fail; b=G/P+jJrmOmvkL4seHkFFqAH4cdMLXagIpBpaKPLqBp0hhx/lFqH/wCUeyrDO+FqRsQ9tHLT6/73xm7w8qfdFrLWYWKYDUCDzaAtE//op3tWTo2imUoYzrHViXmqFwhX+GkPgoFcLgJPuqPfvHEWgTwhKbzz2gc5Jl7TZwk55brs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872199; c=relaxed/simple;
	bh=XGhjTuZFr5zX+sqLPGhUInnjDkP7g5VTTHkkUABgc4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBb/bh7jV4d3hf1tacTihT2iqosJ9gXkNUXee+noNqV9x53DWaToZ4FBrK4HGBaGHtIM9iClPHwT+9nerOtYMa5FwinzcmC6W4/nyw6SkpEvdPfPhjrKo9ETDewl9QvYVWzXLxcyHo304ctDjML4QBVPfEyQzrhLMutMxyzz/WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uIwJXUjG; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uIwJXUjG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGgYX6jBZQwYVa5Nd3ZNXRqRoTUjFfr5/60GlpMBZ//GeM5xWQqg0QGbxC3ReoLINJqdiCGC4ATaPCVdP9H0I3EiQFM6MMIQyh2B8pHTVqvagqXEG1JPLuy1KQcLinsvoHUDBkcicRb5WWFgdxRxp2lLjFvrRxJZx1whcMymHgWrhB7thQ6+8lbCdR3nhBs3t42ZBRuVjnE/iNrxOI1Z9hWAa2BwptnP9NOgWjQgLmgK1HIXHuhsbbDw6K1m8sVSLIKdtt64DeJdjF8AjTHf97i7BfgiyZIZM1O0pJUlWuTXn64JQM8vL5+C8DPvXy0I19w9i9imqP9JtP26ungU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vOORNbL1mjvGDkuNj7lcCzx6Nf+XyQxK5ED1z2i4eg=;
 b=P6r7m6M4X+MiX4nv5wGYrQBQFLUZNShdFQ/LK6TXy/dqfE69K/fqWwjSQJsVK13O0mctHFAIjmeSicv1PF3M2O52iLSVqq4ccD9a4JePXhPzqNSVYScIR2rL6n9B+z20KBCNEfyBsJyP0vSNEt8CzC4z9hALeWusQeQojYWR7eULfB8OycK/dJTVpOFmh0vI5Cp1mGIjjP5GC3PRFK/UhK0VCXsnzkaavmEW52EpF9tTTn6GCDDBvSadjXuAUBAZlEO6CvYJ+OnAoU6EJb7TYPA8nZjM2g/xhjrj73+yU3btCbnuLyTFNh7IdBPDejdCgPC+US5EWYueNr0U/tK5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vOORNbL1mjvGDkuNj7lcCzx6Nf+XyQxK5ED1z2i4eg=;
 b=uIwJXUjGOOujsR/1M64PK9La/EMoq1FSF2uG6JbnxoynUvbXwj8XfA8DbP30bGUTkHTawszQr+6EmyGD4OAuy/3k9UcXCiWNTgDtjsQjgkxRSw7tF7MFf7pKZYfPoIPtjM9zMjEnHZEa6XyMDtxIcw1hbCiYluYYYUd3vJ1+/gSHnh9e1a2suEADu6ychLV/fdFjj/kWJhuN8JeW0yZw0h06fFH4nqdXwthlbOy4BfndIe3nTitWaUbWXLRgdSiolp6oTzgdqzIgTRvUMVbLlq+hpU90Yrxib7Jnh5M0DMVzMkImpyQMngVHkX/Jcy98cUPdPaPsQ1g6vzxHQMnExw==
Received: from BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) by LV5PR12MB9755.namprd12.prod.outlook.com
 (2603:10b6:408:307::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:11 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::5e) by BL0PR1501CA0021.outlook.office365.com
 (2603:10b6:207:17::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:38 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:31 -0800
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
Subject: [PATCH v6 03/13] PCI: tegra194: Don't force the device into the D0 state before L2
Date: Tue, 24 Feb 2026 00:11:41 +0530
Message-ID: <20260223184151.3083221-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bbcefc-6004-4a21-1199-08de730b6503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWKeBm5gTpsSKHF+LdfncpkGNE5r/M/2FhmzhglEKBkK7OAUTLPDFr9h2dmM?=
 =?us-ascii?Q?ngvfTma5nzrGACKJKlTEo2Zjf97BhMXC0Xp9OTf1xixPvPiAXVFlvvPx/Rv6?=
 =?us-ascii?Q?3Rz4VIUcWh86GjAWcL1apNL4o0iqR3e/1HbTmEY/p80897b5y/iY/3xGmNLH?=
 =?us-ascii?Q?XNaS2peEfUkAieD3XrFiiJWHnVoVXbQGDZ+7rtxx12YQH/EsNP5WgLjE/A9H?=
 =?us-ascii?Q?cMv6HAT4mTi46h/y53PAl1vWaKZF+up9HLHf6s+cDg4Mo8pJPmPYy0JQylNs?=
 =?us-ascii?Q?KdE4UI/cErPNxj3Gj6CjJnO9WN/3oGTi7L9ooFzz3PlZnEQozqlN+v5zNe9g?=
 =?us-ascii?Q?qahr2L5BnAQj8MeDUMs6xZVkiHPNTzygjPQMkrdM0BtvzZLRZTLJz1SXTxs7?=
 =?us-ascii?Q?LJN/zvfQmLTnHfX4YMOVT+cYffRGX5h3boyshcuprauMsCCmqM07UMki59cR?=
 =?us-ascii?Q?Lmo3ecxLwyd1WA6Op59WmTolnHnTRJlYkI1kKvHmVYii772Xae+8kIYlo0/0?=
 =?us-ascii?Q?szA/F3mWWjS80cdBQd52m2+0HTcxZ1LeGjE+vCmpfa+t2OxcZmWiBomAadEC?=
 =?us-ascii?Q?f8kpsd+orGMXPoRXP1kqYLKI7ohjKuZ4wz4uHGXdwG9qyD7XH/TSUaUhc6FD?=
 =?us-ascii?Q?60eugdstMt82UDxThRRb2iTsDGJp3ibgFkAqbTXqgFJi9dR8V6f2kji1Cm+6?=
 =?us-ascii?Q?tDLIC8L6WSvROcoDcVb6sIrYa5IbcZcXMBzdHkEGEXMrbvdFvjddmjvlXhdS?=
 =?us-ascii?Q?xjDbXJtNKKIJ6NXhMEtVR4/R+EYh+C7Lx3boaTv3L8LoglvRQ0zDKA8bMHwy?=
 =?us-ascii?Q?a/ZyLrVxO/8rYpamzh2ifCV2ISb9HQ0rk5gCknXZs/ZT3X5bXW7ej2Oqmk0E?=
 =?us-ascii?Q?wlLFVMrrYsQfBoNdGaDJXrxFPxRI5fOE+YA3PN6oka0qgGmQ74mN11N22Hbh?=
 =?us-ascii?Q?gjC5kTsQ4C//FC6E6ufBC+C5Ze2duVo5eybhfTt54pbNreenIZkE9YEp3gSs?=
 =?us-ascii?Q?rsRH6HFmz9cNw7XKvG7/x6SiJUVqyPzeP0USVuu9hbH30BOy6w+RRGY1eVLb?=
 =?us-ascii?Q?P3fFclF6wqk2zE6KfwDLe62M4K4hvQku+7yrQ4gOQafrsDTA3jatiZLNWCo2?=
 =?us-ascii?Q?hHWeYwtn2AVhgRrJE4EtUBz+eYFUkDP6UELVRJtZ2peAOuol60dpL3+B1J82?=
 =?us-ascii?Q?Yk9jd4VAiNCovE+8wpLLAyHpAP08JXUn3c5/Bs9HQRyBIEQDE4a84Ofb7n4A?=
 =?us-ascii?Q?J2xF69HqrhQysALOpsMS8MQ4iG9LOIuru81vOnsIQjSAFrMYBvRmevj8Pm05?=
 =?us-ascii?Q?4SnoY31tvi4XeHjCMqWirgtu3JXier0n/6EDGC32Pyv2cygwYxyXY3hMeAP5?=
 =?us-ascii?Q?Do3qjHaZyIbVjMgswM5tNU5OO9jGX1hxzeUZgYk/YhTX5U50Is9D59u0p1AT?=
 =?us-ascii?Q?l8j9Y5Cs1cy1tbA1vPR/xjWC7Xcau0DKxvGn3zaSnDxmLGdUbZNu8olW8MRV?=
 =?us-ascii?Q?y9j1Wm6UJa/Zzo+ztDMt1GEzp/VQwXi7eG9j7ZLo0v4zZBWW1U1cFDH/r1kt?=
 =?us-ascii?Q?L9hbhzGVQsBxOlIqTcxDAY7KYMCJNIVINdP4E+kZzhY08+w77XSmpVs2jZSX?=
 =?us-ascii?Q?J7U13h0329iSSWIZrIl0hHcB105V9FQHkVJeegqLpXu3sLjgUFFEeemwqL73?=
 =?us-ascii?Q?C6ldVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MG590wXEYk0jgKK8rC0O/UQJVYz1gRLCLfQX9nGInrkARu96lSBxkHP6LTa+SoB3yU9Hmn3AZ9AHCcsRRaurxGaShBxbeYIE6L/FeJhkG2ul+0JodFG9e+TCpvqq6UV5YIly0UshEqEpv3jswZ1mXOnGDmVeAAh7yNO4fiTLF+017HBN9xIt1xhN9+STNRFrbCZpydAT/ghfddG9lhxS/ba0Z+dEQBQ1aQunVBBZSLw+x8BHnrQp5VYDjLwLNIAwOhSnt9yYqOw1Jr2T5Ql6uS0KbXrbRxtRjHRrkYlmHRHDaeaof2/g+J4lloCdqhAF0oDZhaVHnPu4OLbME7HhdUMNMR9caM1TAMD8KGWSzYTyE/BTp/N7eaxJISvsvlwRpLI5QM3cTa0RxvE8fsItZ6W2NThdKIjCRXycYS4rIuVof+vs9xCeauziIw3ecZBu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:10.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bbcefc-6004-4a21-1199-08de730b6503
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755

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
Changes V1 -> V6: None

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

