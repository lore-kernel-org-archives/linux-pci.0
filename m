Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D80396D30;
	Tue, 24 Mar 2026 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379354; cv=fail; b=pIwRCL0A9/SsYNWxFPBfZw6nuMXTnIzjRU2tfA/df1QLgwY3rw1Za2zSo0zE+RGf5rLvgtEAb9PHOpPchAo77xGIWlqVAk0jU0hHq1Aa9PQrVqjy6SdvR/Mf3Vfy5buu/Vpkywrnhnx4VgN8ldIrFpxEgr8e98QYmbM+JZ45uyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379354; c=relaxed/simple;
	bh=+zM0NT533EKu1aXG2sS4YgDdgOCqs1hRrd0Na3pjALw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJbdFJ64HH08FnZg1sL8dRmFbI/EggEgdEZy1LJUln9yJN7CoOhLtrpe10QiKufVugNZjZRnQys6cR3l7FLiYec4ir8dfOuFFdlbAIRGOYZuSBD3lRtqU7yaQ5598sIDTerYPd26OGf6cZDGdwOhrZvpeFNOa2KmQt830yRXzYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phHDiWto; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phHDiWto"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obzn0Rs5xs4Axh+Hnc7A9r4Zca/W9XXKcxAn14ZhLHQ5ODBQ6T99HokctD4wLpuBjI3BcbEXVZjdIaW1ugqllS/c+ZIPVd4vFBD5yXoIIwObG5VB5H+qz4PKJZauzTi61w/fMPN7PzCBYPoYEjH/ifffS6Fc3Pcb5TvYdpVQBeZXtBuJa5FjGgwIlx/z+EBT33XUFDpp0aRRO5Gq62hKtMhykET7aouIrUO4OoHAi8yRIlY3iiFbjbu+aK/4AFuJaj9zz+apqmaGEWIrvaipx3wq2mgVqrDPemMajpw+SOZfqCg0SVtlObKKmOSlgGrJ032YZgy1FxmlqltzSSQr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSuLHz0F3Nrqi9guZiIU+wFaOd+D9xsXkpW3wfX7zdk=;
 b=qUuxQb3JfZf2PaHoWfL8u/X6azB7DJfJN0FD42OLyPhvpJuGUeWSvDdUQmKRErqIETt6jEpKdTdektrP5srin6TvD5R8GbEQhumk9+ZOqXZIci+15OTe2JJeVVtzb0We95g6Df1FZUuh98uxEr7+mqOOxPdgPwiAFFzMB3QPKGqvV1ML4hJptFQW75d8jxs3xUIYQjkHUx6cJPyWA7ICbwqdqf3T8H3xXRh0yEMmKwdq0Y4smo1olOFefHgMhH/Zh28GYaujycnVYAeftUoAoeozfnuIMIq5nIuWMv01hAyQ/0eninUx2Kih3kZ/k7IUt3dIqR0DWhgMi/qe7VwPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSuLHz0F3Nrqi9guZiIU+wFaOd+D9xsXkpW3wfX7zdk=;
 b=phHDiWtokR+8tVZDTjkK3CyhEkcI0+vfRVzb3zS11a32FHJhFRQ1Q+giN0cvvcRnorDRfSbHpNxVeUJMYloH4Wxstxx8XYf2OiojbE3o3NVBHIq03OSUWNwrRW9JPSNzVinBeRcVf2TkXYZ0tnPf3UHl4gokJdJcq579EJRJX43QrRdCxX9QQdYzP/pSoEQ9GyCFQ+1TnW6enImbtF93sPwk2tErROTMb2QAHXcZq2DeP/dN1P/iDrZ+w9t6akZV0cIWT0DOk9NK4kswxFHqmmgeOG3aWrHmiTFo/f1LlSvKy6tle/SVy8+hNZE9NrhSKHXUb4DgDCgX0wVkBHSu0Q==
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:06 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::40) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:40 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:34 -0700
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
Subject: [PATCH v8 04/14] PCI: tegra194: Don't force the device into the D0 state before L2
Date: Wed, 25 Mar 2026 00:37:45 +0530
Message-ID: <20260324190755.1094879-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae1a019-1579-4f35-4bfa-08de89d8d0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O56px8ulRvIfhHlUUMcDs2VRUpofXtp4nvl7wqd9gGV+Tu7ibpCelM5GgwOCHUCOZnm1paU2Yz0vJE1eg04hHJ7+PW49Hcxjkr/isk4jnfBaKLJh8IjPElpXlbLsC+512OZJwwXlzSL9Suxlh/FMA3ugk7STr6DSGUk6pX05wInpS1zzwfk2Zy79HcOKXCVCnDWQv4l9PGDXRwA5KKz8Ufp2LkKWqGJZ9GY9aoYeA+rS7Qfj1HqINPyplmUVO827AfAyJFPf7VWcjeBXdX/PDwgZ9f61eSfJeZ2qJSZZhG9TwowidVIdnsjaVvjXfpqzUIvmkXGtL6UttQu71PRN/soOzmiLY+GnCpd6YXzB2nmogUT0AKXsEy2ru5qAMvKg9xNKxR+1aQ3+9jTJcFh31GgGwbeNilmwGSM+9Z3TR8H51Rmc5dCNPswL/EsUnGt5MNmlfDVCvFO4C7dmsmGu7CfP7jj5cA/5L+i94H+pKbH5axZBinkOM5EqaeEsb+hoiCQPnxRvlsMrPRwDqrhxSZjDFi60hlgk12ZViorhORnznyhZVStrvc7ArCGru06ZVyE7aTY6g2CWo4VHZhZlvpyPzUrxxIis8oGPnm8bK+jTCCyBNpn9uMnGtNyrxaA1A1umoChca7M3EY1HhxRqTd6GVumeWu8qIgMuuhnVyZiHPSfi55WSiD8mu/XGX9qHDJLEQu4sqSnSJWXQ8+LktLML+z6+GprU1A4ztIyLJQ7Xxg8lHCxTbCsa6NyyLRudjuNVU/vUGt8a/ES6fWUi3imQTsLTcDt4NG1VAf0lF3jblGzRMzgL4z8ox2P/3aUB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5SDVyABcJVJ3nxsVVJVJlAJTaqa4kX5d+g+VJUDYgTmqw1ZC3I2yrXcnqulls5zjrQMoO05NMeG8uVAwXdKlmjTFVSFPyWXRJZ2LKd582rLnRmPE8w5LdjGRC6pPmkdkMEPVkeg7QDqQf0Hsd1yxGB+r3S7ang4kMgEDS0ou9R0Ck1w0hrzJCUPWCWddlmGjZD9x+sRMw6xc81wCP/859SB7k1gfkHxHAGtsIIEacXhex0iT6jSX6/Crh5YNq7ZK2doU5vL+1B+4RCmoAoN53VJU02+XfQ3oOIVVYSMvWvNZDeh1kASoPDpCpf2qMaOOqXNPkH6x3K3mvUAASp9CCOzWDCvYiWNVhh3YArQDHSw02/pY/Nwj/f+F8fOiZuhhYpHJFagwiwELcb3OeYfkWReD7XksDJ0m0mwHjMKUPrvqZIS33qVsd60kZ5kmRnx6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:04.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae1a019-1579-4f35-4bfa-08de89d8d0e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe Endpoint device
should be in D3 state to assert WAKE# pin. The previous workaround that
forced downstream devices to D0 before taking the link to L2 cited PCI
Express Base r4.0 v1.0 sec 5.2 Link State Power Management; however, that
spec does not explicitly require putting the device into D0 and only
indicates that power removal may be initiated without transitioning to
D3Hot.

Remove the D0 workaround so that Endpoint devices can use wake
functionality (WAKE# from D3). With some Endpoints the link may not enter
L2 when they remain in D3, but the Root Port continues with the usual
flow after PME timeout, so there is no functional issue.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V8: Fix commit message
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index baee73438638..7e15597df6c1 100644
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

