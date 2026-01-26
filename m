Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCD3126CA;
	Mon, 26 Jan 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413659; cv=fail; b=YkBpN4hlq2WO1VHDtRjadkBkTlitQwF4krjfxpBC6VhdqXjJAonpWRRGrmjOCET2tfzHlczFOfmNHggGp7yeOKFYiuYQ+me3G1kaH9Gjzr4TIiEjFGwgqqxC4Mt9n3ADWz2mYbEzgxqhnI+yHvw5Vg31WYwFdz69AZUbAHz23V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413659; c=relaxed/simple;
	bh=R3XeF6LUQQa7KCxutwaH15/YuqbJSSPg/Dkbfzhy9yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obsSgc56HNV1C0RAyPsIx1v1VFlOOiZS81wVpgPFwkd+AJuRCbrp4tJiX8CzlfiSEmZFnCYxCQZhTZ5i+Yy600oimeKA3GXkaQ8Mpd7wiV3qRiGej7FkVF+MYFH2inVSRt+ziUlfaVJm75zCkzj2/SYT77n1HRtUZRZMnspASz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tAvS0zbI; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tAvS0zbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bizJDk3BpDBHBZLceaxCw6TE0MxXw6hFbnlexxw2AV9POG0a8D494MT+v0gY2SwuSFBFYvfvNvWayH7LSHcymdLb+c/g/p+fb7Bsaxwt06rtIUFira3XV58BIwNY+TXNEZXpT5QKc3deuofLDXqhTLz02sTRMqad/QjiuTSaK0HoIEVmUbS4rNuz737pnt3PCC0DVX4jWTPE2WZGcAfo6xlWd/qu0nnTzWTFKHbOVx9G0lk9RxVGas7K6V3IMoXFtcFY+wsTJpSU79dxFEiXw+pmXog920CSygr/v9CS1wfwSeysor9dpUBUT8w66e2wfh+shiqeZUU19nDqMAvSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJptTJc4zlf1fj6wGQoVMFinx96SC1ncR3a7kR2zLCs=;
 b=wAlT6VFdy133mSsMWLIFhY/cT3XBL3q9p2MrmoigZX2XhJt0wGPPj19UX81d1fyAbgyAVJbgX8HDPJnP975FI8fdVC9FVURlGOYFi2R19lXr8kRZiyB5nfuv4kBruF1KP5cgl5DiWpZZuIJrBWuKi+Jt52LTAQQ+xxqSKbs1ZIp6Ui2A7ugPYRM2EZIoPJ4AKLEYXpNQ6dSWf8ed9w5sVn5hIYRVG3Sqy/O0R9XU7xQ4R+5AVBZe4F9hhbYds5qjzzlMgVBle3qECDetzeU+9tsZoktUkAXIirzXcjMj5KhLp3r4KLDTZ3OQC6ZbivfhkXdmuwv7iLl/k3S8eqE7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJptTJc4zlf1fj6wGQoVMFinx96SC1ncR3a7kR2zLCs=;
 b=tAvS0zbIr9VINEQUEFeXTWwijenuba/5BeJPuCzaSEbXUEnVwxkZ4BKPFnqB9P5hEQdy/bH3ZTv3ZBZdlKTSUUlzmUVG7N6L8arctbaUdH1f872XQ+ZOvgJEn9WtmuBNMKaQmc0WDr7gt1dM/WmK+jAl+9uxT2VnheoO3Lv1WOxB+P1AEeU2nrwTS+woEfH2qLu5QKGm9EkHqeIz4s0CcFq82NkqlOrPUv//jkBB/Bknu9/AG4aD1thKtbH1GNLZI4SON25LLfFqrmbHYBYk6JnpiL9MZ51sDxyTD+6SjnOCEZgEMHDIr7JLDfLccgmwzhMcyY4PgWHbSZv/TOhAdw==
Received: from SJ0PR13CA0061.namprd13.prod.outlook.com (2603:10b6:a03:2c4::6)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:34 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::9c) by SJ0PR13CA0061.outlook.office365.com
 (2603:10b6:a03:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:12 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 15/22] PCI: tegra194: Don't force the device into the D0 state before L2
Date: Mon, 26 Jan 2026 13:15:12 +0530
Message-ID: <20260126074519.3426742-16-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb66671-f266-446a-1b9e-08de5caf2b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MngwJR3E59p62z+uGumDgYEiC8STi+DtmN+xNdouMrTeJfmlr5cl0lv5Du6N?=
 =?us-ascii?Q?XmbSZfPfOMu9+auITypxH46T1p8Ys9rEq2a9ixpDoJ+XokqFNBID3IGQJiHk?=
 =?us-ascii?Q?OpVRVM0c/sGmpl1d/GcTk8+4uIEGf4t0lmbcP5mGsjtKwcSwKOYfCJNyc8Gl?=
 =?us-ascii?Q?NK6QwKt9EhyvqAVjyF332wTW58fC+53DJCIH9DG1orprfE6TVqtDD8ihTI16?=
 =?us-ascii?Q?N1T/gEq3lOgWRnYDV7zdpioZaLk/rxcsv+Eqmu/FPshnyWwYsbvWVRUY+emM?=
 =?us-ascii?Q?g0NidHYSkIm2rguHFga+UdivcxXvCOtNkrEMDZJsqC9fKiFiRQQ3K7AWv62V?=
 =?us-ascii?Q?yTXtg4hYzk08kqQmFdzqbdXOyq78XQD+wsqwjuceYHBEqIKDI/t+tioG/el+?=
 =?us-ascii?Q?I6I7KMND2fM0CKPM8n6bDkJNgPvfUR7CVA1zwBKAlxpzi+NeG/mNrUOXEIRo?=
 =?us-ascii?Q?TssJFjjuJ5a0qsf9OaDo0xwvfKfiJUr504jW54lH1tpIEFKy8rFre9OTxhrt?=
 =?us-ascii?Q?8H+SQvQgbj7ldkqDEKbwoiSj5HuGQn75Bkes3cA7bpgCue0d0yVNUOG9atgk?=
 =?us-ascii?Q?4AjvLOLGCOHtpjiVa7yOp0UBQhcGCAXEos4C+n5ZWw1q+PbVaEENC7J5mdCO?=
 =?us-ascii?Q?vDBmDMz5NUFSISVtWwwhwNQGMAr2oD+5WjhZXut5WuXYn02TIPLpDczFx/Ip?=
 =?us-ascii?Q?lvdQfXYvUsHsicMCxzmJSwbyupmPmeUFpCMMbc3DuUTrtYbEzYMrotTEgJWD?=
 =?us-ascii?Q?ZAbYnrGR/F+2w1g3xZxjtKddCqr1HUozcA1+V1UBSlQ9DQZposzI/btS6tL0?=
 =?us-ascii?Q?hgx4YimpeJuYZAm3/wliVCkQWIOPrZvFeBkFuMn2cqsaJoBvCK4/oTREICG9?=
 =?us-ascii?Q?ai4wt7rQ6zveNZcO7nt+L6h9jLuDRKhU8pDrGsosMkiFcUSpVe9QFZvivF8Q?=
 =?us-ascii?Q?8yd0kcLSC2r73njpLNpAyhblsgCqYBJVcqWnlywIrw0nz6hPl34ltduzUovs?=
 =?us-ascii?Q?Wys35uv6Nu068Us8bKyjCpE5MuXFaY4CQWxWEjJIIQg69lOL41yjZ/1Sh2Im?=
 =?us-ascii?Q?e5NGjoMuUBfFkn+YT4gXCQu4bUqsODE4cEhLCWzmm7Sc0ucOI2u5leaBY9RR?=
 =?us-ascii?Q?lt/rg750bO5kArpkPn2rXBY3EDjFhkF3DQ+S1neV/VpZxRTgQfYPJyYzkwm1?=
 =?us-ascii?Q?WXaZ7LeBnj/G13+SJNPJmyxoM7Kh8QmppKgVrgHdlUvpWobIj54J8RB8b2nB?=
 =?us-ascii?Q?xOWvbASc9weStBf614Xq3M3yLqwTvUWGrRm6aOb7Ci1bG+u14qUxr8TwfStb?=
 =?us-ascii?Q?UW0jg8LK1ZPPUD+Aa/dD7+7WZWJnTKqKOUxHgyzUbvuKc16vp6hcvYzDZ84K?=
 =?us-ascii?Q?rdHdarySrWXAXjy7cZu9JeXb85F5Uy/1EXv8cCyO8OH4PmnlB8VG2Eim4FWF?=
 =?us-ascii?Q?Av/kLny1uVJTwMDFVBpjY3a+nB/9Q07tRy8/bBnzbk3cIXCt6nbt0ku6FNL4?=
 =?us-ascii?Q?AW0MhCL+iC0TEt5kgWSoVjrl8To5xtIYTxjzpWWOTGHC3R5DlUnROb/RwQqA?=
 =?us-ascii?Q?MCX5luTSLXyr0d89O8vZoQHX9e4Y6EQUSzj3FDW/TEzumcQh06H3fSjt745P?=
 =?us-ascii?Q?Fdxlv0d+aGNIi5A25AOXCEHTRSa7bdrSVod/S8KNFGnnN2ADbI7BqVBZThaL?=
 =?us-ascii?Q?0ETRmAkZBPYELeYlsYHikCLpG6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:34.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb66671-f266-446a-1b9e-08de5caf2b1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

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
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6fcfff93d4bc..1a269397150a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1283,44 +1283,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
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
@@ -1650,7 +1612,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2402,7 +2363,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2479,7 +2439,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 			return;
 
 		debugfs_remove_recursive(pcie->debugfs);
-		tegra_pcie_downstream_dev_to_D0(pcie);
 
 		disable_irq(pcie->pci.pp.irq);
 		if (IS_ENABLED(CONFIG_PCI_MSI))
-- 
2.34.1

