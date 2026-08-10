Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB673DA5AF;
	Mon, 10 Aug 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365816; cv=fail; b=elDwZcQbQxV1JzH81OF/I0Kowd0T7Lq/H6cwgQ7X0mXcYRjqxGS6S+yXWAGXuc/Syx95yBpNRfige/Y1X4rg8YoByx1k886qVcaFRi4GRp+sqEmaIpxCvjVdYoeTvF9PGYbADdcER3/Uv2YWXmNUkVc5rr8YNV7mltxl1UdmgKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365816; c=relaxed/simple;
	bh=L1ADpQKeXGL0liuYUxZzasdnRDNYGQT0zf0A9XPeng0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlesOLybyyUz7sJMVSl4gMhO65RuYmFv4Ln4G+nRH0JNkkZzs2SF68ASbM6n8XSsoXIGtbSKSqLq0nuNaHIgRkOd7V9Ovvb0dI1ZyCYI9yG/esmRROhadT9zTAVY5af2vMiOR6xPivHSH7arv3vLv2Dl65Tv7s1OVK2LiSvCWXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jjJ6bW0v; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjJ6bW0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+tl+9JzyOz7d3zYwrI7WRGHdCKD2nHP20qZn+VAw2rkZaG30sHLsCIJirt8353wUTXtNqyRO4KY/Q09WVTYIRDqfDG2/xE3HPjEIAmP1X1H8C/nqFt8MCe6B7yVixa8eXT353hFehuLG04FyLdrchb9RNR23GxSGn/k+YWO4K8geISUhdGBj0y8coABEUW58x/vv733DR/maoBltrWGkGK9zdUPav7ZWSt6c46KOEjsMtDVIJ75GxIMitaBCCnocSf3M3Yy3+pEGWBpkvJbfhWAa9/9+E7LBEwLSx1bvlDIkDD1HBPRqqX+OdvvFcONkr3vmXfwFERAZjcrcmkbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuk0mfD52jXS1Cz7cM9gPx5BJJ4Zj+YQ5QxY2V57xZQ=;
 b=EpeXzl1p7a0U/cTAT6DtEzu+5kCXXoL9lD3tay1sbLM2XtfBCo9BE64eYZRSF4lhMr0n9Nx0hSc5AM3xOskljTLn/HjThwjLSk7PTXWq+TSwDdiL5xuPCXN9/30qV1nOMA/FFRfBQLV0MhrvzpQjra+E2mZpPoPfdNGYnH5EQtRF8zMKzmJtIdsG38vwvACtjZeVIVZ5i/+HL+MDzQmisFIYRKp++labyx9lNwW137KMS1mi78dCwVko+9xC1OROn8qNVW89AuCsqW18tWgxFXAD1XS2uACfFY30sB1ixzH2V0HElIDJDruVkAftXKJkoxVPrfS6OmlhDHUAJKJy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuk0mfD52jXS1Cz7cM9gPx5BJJ4Zj+YQ5QxY2V57xZQ=;
 b=jjJ6bW0vUkX5MpxennrFFnF5t/1HgUp6kuwbAnk/3+Vq/w/BCjiegEBkUI3wDNYNyVOIEaglxDQHjDC9ZVxXxEbVscOx8ftuI+oubw2lLFX29SdZcCPfTUXGgzMHLJ8LFfZE6zKmwC/L53jC+8wc1f6IQqL+GugFn11xQZpNz84SMh9kjT/O11X8oVtm2w+gHK4LWskcPjOkmS/H+Z9578gV4jGqgaEcVQT5InWML0bvZTejqo43ON873iELB6IoljhmXTEGu3aDkFp49jFnnzwFcVRNIn3ro1S5zu/4zuNYZ8vQ9BISI36k52Vc4Md15umuFrNYZ2PyOmkaz2aHag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:43:30 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:43:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v9 3/3] PCI: Remove device links to PHY
Date: Mon, 10 Aug 2026 15:43:15 +0300
Message-Id: <20260810124315.433448-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810124315.433448-1-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 96619bf6-757d-4798-915c-08def6dcfb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	icsor8+uPeiW/AYL9HpqOmmDJ63fl274sPAVbE8+SrQzCglYSAeXsBR5zCsBfPN/H8X89olKnooCJRZpqUMl6Mmb6FK/xiPi00dSfIK/HY2FWVoffOcT4p2KKocPSaNMS/k8vZmpOfs62yLysmd+CnZfeGYzcFqZKvjHAgHuMhHm496ecrFsLldW6F1hd4eAiqNZrZBDm5uuOJv0CXHr74UiHxI8eskr88l/mcefNXPHLCcor4dCXyKz/ABo2qfCwna0fmR/VFyo94cN5XDBOIuMTQcIKBYI02kc0EEY0knNHjwLemfsiMsTgaP4A5Roh53PpDVJaBRv3pLGV74td7efgGA4nIghs++eywKdLfoZ98iUKpNAnnf9+FFtmqytTcV4cdEff0Do1393xDkdhBeUG6Ju+F34Ipv2e0q5XCtmzdOpOGPT+DmVt/Rex3Y1ymNeoL2YWZ8kQ9g+jouftP853o0wv1cm5Ny1o60tYwhL6dPZoXK59YV5DoD7qbnx8aP/xIEFvPqa1XaO+KVcBSlu07tz/lV6UbKuzqclk5sFXvBkTU7izH1XYD2KWlJ7Kfh+uIUQxSvQyS69WKbBIWzYh6tMyHSiOrPtl74ka53zcZDyx0r7LT6LrFdrw2vnf+2wT5w/f5KRMS56UhMJzBE//XFwzX5od63A2MYxB8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzZJODFRcFBvcDM5Q0o4VVF6YVdhMVlWenhaRXBDT1dWcFhBcDEvb2FEbDF1?=
 =?utf-8?B?Qjc4eWdPM01BdkgxTTRtcm9kT2hIbkhKem1YUnNZdHNweVBpQkpvdEJCVThW?=
 =?utf-8?B?TWo4VWFlemJDUUs1YksvVnlTeFVESTdhMjNyWVVQWEJaNno3RlB0dzZTbTBG?=
 =?utf-8?B?Ly9hZnp0MjNpdGI3dkdRMUduZmUvc3d4bTY5Z1RBQVpSL1RqQk1GditKdjAr?=
 =?utf-8?B?RzR1ZGF5aUlDNkQxRGNoNUROMm5IRlYvOUNGVkNhcnNXVHlvT0JTQXF1RDNO?=
 =?utf-8?B?Zmp2SXJyYjhmN1lPOVcxTU1WZzhyMlN3MXBHNHFnU3dvOTRRVG9mREl0dUJa?=
 =?utf-8?B?aUNhelhyMVhTVWw1UXFJUnVZWDlCRnMzL21zNDZzV3ZsNENxRFdyUnRNZG9N?=
 =?utf-8?B?cjREY2x2eUR5clZlSnh2SHdCVnRTM1duVkhYOFlUMGdYK0tZYkJrZi9sMER3?=
 =?utf-8?B?aG5aK3BzUzZKcExqWVdCWGs0WVVoVEhzZFFpbTZvWUFIeENDZjNmUExQSC9H?=
 =?utf-8?B?bHJRSXBxSXd2SGZ2OGtXVEJpV2lBcWZESXJvWG82QTJPVWhnOTZJRlRSZHNs?=
 =?utf-8?B?Qm9MU3h6T0xzTnlEQ1ZiQ25ocHpZUjQrQ0dIald5Z2NDc1pWR3ZxY0h1YWhz?=
 =?utf-8?B?dFRqUjlvaXdRWndkYVdUTXhrU0dERzJmeW1mNFpCODNZVkYrN1lwbWlScEl6?=
 =?utf-8?B?amRGTHVLSFZSV2JhQWlCMklHZWlSdEhzcW40eFJrS3lDOEE4ZzErcEdEV3hD?=
 =?utf-8?B?ODA5UTlDZDgyMk40WUZoMllvOFlRNkdJUWpmL0FiUGpITFNYYXUrbEZJS1Ra?=
 =?utf-8?B?QWtsT2FHMTFWQ25BWVovZjc3cDdISzJqTUNHNnljaFcyc1Jhbkw2OWFVTVYv?=
 =?utf-8?B?VHJPTldYM0F2WlFzRzdqVXVrRGxpV3lYVisvUDFaaDZ0N3FjQnFPNVJKdEpW?=
 =?utf-8?B?akJHOXE5K2F3UnJLak5JYUIrd0lkTGlXNHppRWRma2hIOTNJSjd1eDJGa3JE?=
 =?utf-8?B?YmV6eXMzNk9qbGRJM2hFTUFGSW9VQi9haEcrUjlIZGxsdU1wQlRNbU1VM24x?=
 =?utf-8?B?RG5Kd1hmcDRTMVZqeVF4UG5YY2g2dmM2d3ZlNFdDZjN1S2xDOFR0QUExaUFX?=
 =?utf-8?B?OG9xaUkydEw1R3RHTVdOMUt3ZEVSaXJBN2JYZU0xclU2cFpoNVpnL3BZaFcy?=
 =?utf-8?B?OUZ2a1lkWjZjdVBuMlRZYldxZEdWZEJBeDZXSk5YRi9JTDRLOU9iK0p1SEs1?=
 =?utf-8?B?K3BEbkF2VTZmRkpEd214ODR1K1UyakdYaUIxSjRMWTdmQnEzMXduTHZBZ2lm?=
 =?utf-8?B?eEdmT2g2OEV6dEU3L2J6ZGxQNU1jR2lzYXd3NGtvajkrOUpHNmJ5N0w3RGhR?=
 =?utf-8?B?Zkd3ZVBjN3lNbVZJV2ZKQUtBUnBxeTBMT0F0a0RwSzdTVmlMV0tYRnRiSlBD?=
 =?utf-8?B?cnh1U2dVOUFSVXFIbXI2Q01KL1Z6VitnVWdaS3RrSkpYaVZ3NktWR3d5Qkps?=
 =?utf-8?B?enh6UC92SGpraGZxVDZ0Q2hOb1RiR2cwZ2hLSjUreG95b3dxNDBYUFR2Wklz?=
 =?utf-8?B?bW9MVm5IVFppNGF6OHpXZXpSL0FJS0xZV2dUS2Q1RDUrU0wwMCtuVGVnQTFa?=
 =?utf-8?B?QnRiSTlNOU9lcEFkU3RMejErVlZNV0d1UGszOGdGK2VSUUJNbFJOM3Z6Z25S?=
 =?utf-8?B?MEdYZVRXQWRGQVdsVkFuekFTd29BN3d4RWhtU3hCZ2pHemFsZjdxTzRsNlpy?=
 =?utf-8?B?YndWVnhsZ2J6bmRROUVxNC9Wck1GTjE3ckovZnIzeitJclA5aWkwS3hldnZL?=
 =?utf-8?B?MXp0aXg4OUF1dXJCV0tMVWpHUitTM2tNQ2xoTWJzU1NJVWtnUzk5NDJsei9i?=
 =?utf-8?B?amxLMDhGUkpBS0VhWEZVMWVmbTZSbVdEK2p3ZThPQ2NQNkZIU0hvSHVITnRu?=
 =?utf-8?B?SzFic3pMekVYaW1BK09JZ053WDNpUjRla3gvWm8zblkvcVc1L3RhYm5ycm52?=
 =?utf-8?B?OFRHNFJrKzdPYjZWejZqS09uSG1NREoybW5VekpRT3V0NnErb2VFSERQUFpv?=
 =?utf-8?B?aUc0MlRTdFB6M0RQT3VVVVhld0pzSWZZVlBKaUJUcDIzbExlaUhzR0p1ejZJ?=
 =?utf-8?B?YkZhNmhVWVY1NGZ5aURQMkJneXdSTHpSdFFHVTZIT1d6RDlFQVJOMVdWV0lQ?=
 =?utf-8?B?cVQ0NDMzSVFSbmFYQmxIS1dBdks0RXUrdFZrZnF5WDdNMDhQQkRqVHkybExS?=
 =?utf-8?B?OVdxQWJTSjlVRjZCRjhqMWRHQ091dDhSZlU3SFNqajBwYnNpaUNqeXBjRlhM?=
 =?utf-8?B?MlFCQnRUTm8zSjg2RWVyeFdUOHN6SkFwTVM0OG9aVGkxaTE4ZEJQdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96619bf6-757d-4798-915c-08def6dcfb96
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:43:30.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScSUc1kVhg03FaScWJh+U+Age6dMzR5s7rCqkVS6FkqLTZWwQ2qd2EpxH019+dcOCcw/EwzVfC3IhbXooQI5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861

This is practically a full revert of commit
7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
and a partial revert of the device link pieces from commits
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")

The trouble with these commits is that they dereference fields inside
struct phy from a consumer driver, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order PHY
provider and consumer suspend/resume operations. All reverted commits
are from 2017-2018, and what they do should actually be redundant now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>

v8->v9: none
v7->v8: only context change - "return 0" became "return ret" for
        cdns_plat_pcie_probe()
v6->v7: none
v5->v6: collect tag from Manivannan Sadhasivam
v3->v5: none
v2->v3:
- remove dangling set but unused phy_count local variable in
  cdns_plat_pcie_probe()
v1->v2:
- fully remove struct device link **link from struct cdns_pcie and from
  cdns_plat_pcie_probe() error path
- collect tag from Bjorn Helgaas
- adjust commit title
---
 .../controller/cadence/pcie-cadence-plat.c    |  4 ---
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
 drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
 5 files changed, 5 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 8aed8b4c3e11..13edc6be21f5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba..0ac980249941 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index b4d51adefea5..4a96e1869e53 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -260,7 +260,6 @@ struct cdns_plat_pcie_of_data {
  * @is_hpa: indicates if the architecture is HPA
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -276,7 +275,6 @@ struct cdns_pcie {
 	bool				     is_hpa;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	int				     max_link_speed;
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 3fc889944f02..bf6c5b86bb27 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -678,7 +677,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	int i;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
@@ -726,10 +724,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	dra7xx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(dra7xx->clk))
 		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
@@ -744,12 +738,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		phy[i] = devm_phy_get(dev, name);
 		if (IS_ERR(phy[i]))
 			return PTR_ERR(phy[i]);
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
-		}
 	}
 
 	dra7xx->base = base;
@@ -851,10 +839,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
 
-err_link:
-	while (--i >= 0)
-		device_link_del(link[i]);
-
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e9b012a5ea9a..8085c4f61403 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -130,7 +130,6 @@ struct keystone_pcie {
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
-	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
@@ -1130,7 +1129,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct device_link **link;
 	struct gpio_desc *gpiod;
 	struct resource *res;
 	void __iomem *base;
@@ -1201,31 +1199,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_optional_get(dev, name);
 		if (IS_ERR(phy[i])) {
 			ret = PTR_ERR(phy[i]);
-			goto err_link;
-		}
-
-		if (!phy[i])
-			continue;
-
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			ret = -EINVAL;
-			goto err_link;
+			goto err;
 		}
 	}
 
 	ks_pcie->np = np;
 	ks_pcie->pci = pci;
-	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
 
@@ -1235,7 +1219,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = PTR_ERR(gpiod);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get reset GPIO\n");
-		goto err_link;
+		goto err;
 	}
 
 	/* Obtain references to the PHYs */
@@ -1250,7 +1234,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		goto err_link;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
@@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
-err_link:
-	while (--i >= 0 && link[i])
-		device_link_del(link[i]);
-
+err:
 	return ret;
 }
 
 static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-	struct device_link **link = ks_pcie->link;
-	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-	while (num_lanes--)
-		device_link_del(link[num_lanes]);
 }
 
 static struct platform_driver ks_pcie_driver = {
-- 
2.34.1

