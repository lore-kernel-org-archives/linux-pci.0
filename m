Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A92F290B;
	Fri,  6 Mar 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763108; cv=fail; b=dFI/PL20ODhPDWA9zEN8uLGU3XZP+dERLiBUTzT5a9h5qaxNqBmWKAfPSkrA1izpcx2Ven6PkRGiG6JsYjGNWXLPpQomZabsHSSYtU5nbSll4GB1TXg0v8kSrzlT+HgWj+dcSqDH7J7ZR67fymwoXihkhd3tq86Ibsi61h1VyN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763108; c=relaxed/simple;
	bh=DPzA16DC3qCqSKWdRWw/3ByDOos37o4wJMONfhD/Ojs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tj8NC9N97fT+VHmQ3hIotN6dmZZjGE2NMtJXfGZ5UHdhF9z9gsCMxbxHMLGYO0hNIfZiTkzjs/eVs99Dmi1vGjk/iGY0Phd59qmQEDdneWQFBPUdi5TlW8zneFKb19V2AjwIJOAWhPGw0AjF+vr6kealc/Md4K7NtMIKNkuQwto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQ+mTIf2; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQ+mTIf2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbQE8aoEk6/VoaJvb7jR9xIxSsooqSNHn+kvnwsVpNavLy//iKjoroq2wjPdojYuc2aAyKjAkYtF2nIY3zA+8D7IaY6/jtgOA8ZxHLfMf9AhxOk0pi+HCj7MT2dlpEKBw1rRfIaJ0dKo+x3ElLvL9jD2V7jCxiJp1kx14yZ3xw/cYmzM41BY/xEueql50CjfX+zVEgKXXlwKSjC4ekKS6glU3NNsBs5nrMol9BoLAkecmmNXiHzZ4dvP0klCnqZlDIPtkdyrXvNwKo5YNiudRYvc8uqCL+Sitalq9wINTLrhy+m+tiJEDyop0j7kvvYs8siLutgqqW6FsehbA9pd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UajVEZZpitPse/bc43gtuICu94H5EDjF4K8WCv7Hhp0=;
 b=OezsuMWbsb6AyxMVEDEfdTugYA0CreP1h6OB4chnoY1izjrrGSZGOxPplgUypEMmI0rM+Svmez37z28bErBuWVGPazmOBuGaOcEuYxksOnhCfMRCfPb55oI/v/bAILDPlLc/OSQSl3wZjWl6DFVGZLYPHpkF0QmAzhNPmp4JlI0Y0uXzJ5q8MM+m9fy7kblr1yzsJ5GKz5MAxA/4OY9JfZcXxEAzvsjujwelSLNSEfEKIsQpAYWoY+d0u5kSoaKP4Hmn2kOMNjMGQOYnyO70f+dsRXIMouzXqTQrbzKJleHj2/Uwh471N+9eTSGFl0CSnkzErrdMrMi9y0nG4T1o4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UajVEZZpitPse/bc43gtuICu94H5EDjF4K8WCv7Hhp0=;
 b=XQ+mTIf29dpw648VT9ZlRJ1wrByZ7x+8eiGMvdsUNljJmQM3K7WVGPxBoypeNzRPcBL9J012kK2/XnWBGX0bRDVq6AXsDB7QU5sCQpdM9zDs7JaNVpuaGmTt/KDcF0rzPZ0PcowdJSXNczqKlLYwN/bYKnXeXwnJ3Xb6guTpzpcIH12O9iyzeQyz3KuGPkmVJYFwzy3khyZsWQZXW+jce66RQdnBqgS7BNgM+ryQrbNxS0ao4ASCCAqqf78zeSkrmFoSJOS3xZuQ7aV07NPen9uq88yHaw+3Zxi5lsdhsZ78dVVJ/0r00nmGk6ufgaSSy3lIBIjYJhDjkHgX5rwIYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB11629.eurprd04.prod.outlook.com
 (2603:10a6:150:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 02:11:42 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:11:42 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] PCI: imx6: Change imx_pcie_deassert_core_reset() to return void
Date: Fri,  6 Mar 2026 10:12:47 +0800
Message-Id: <20260306021247.991976-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB11629:EE_
X-MS-Office365-Filtering-Correlation-Id: 671d3573-cad7-484a-7d9d-08de7b25b574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	gioukGFqOnj5ulzGYbzv3xgi2zIGhWYdPjUr240THmE+8mwubEwNdLr41DL3AdMbHAlyvzbIZPECatVNxWqlKTBwtoR7TKkrY2Dkl0DjLqH7X6WmHu0qBiUhWJLV872CR/eXIPyxxb/peayyhCkGWcAFAKrclRDSNU0RFTTRUJP6k02E1cBlQE2fU+6bW37R8JlAvvs1PQNm9CbmM/MxSP2v54Hh3+oG2kqMW1ik90LIXf1xQAPF3pe7NT/XFWmfH4jG+CvY9L2JCOg/Fz5/XuFSjsf1NPIhNS9bS2a++YtjwSAo6Gm7Yp7aQLraEl3ytzG265EDT8n4I3i9eo0KjsGQlm1gQEAj3idkUDiwpgAnRhH5ZZWHAvT1iORjzxwEPGOl/Da/zzqaupa83c2IKR1a/LkmiwDQVpf8V2b9ht8cXBAXq4VCs4T0jsVFd55BepP6v1mn0oAXhkNePBUfrVbvfKNXAJxXSSXB0CFGOibcT61BTN7ETcO2NZTOr1qiQzTmWZ09NXUHT3pUZQjp0i2Tre8o6SdU+YeW7ZNqKKba7klLsEWgjBlHr37IVNdftGL+vC54RJ+rApR/CP74rCm7vJOzqCpcdeq5QYqTCOMYgMTVia8hpirutIeov0k+R8DngFGGuzrkN67O0kJ3MpyIdIQtmbgq4uPasvcsz4a4xfJPPsN72Qhba+7fVFLq/R9Xgu0ZNpPc3ZajR5VQVznewoLKVZAIz0KtKzh9GiLRqb2GZ7BjUMSJdhRuItdi/S3yHz5GGWMrbZRmRQ33UVLvNgltYUCcrJzYl5byd3BMOxU1Tbcw1Mp1lANZvQpp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgJcBIA+WMbubyHkHhSnwQwzcTYXZ3manKuXcXuiYKsOS+dQ5uYlrvffLXoo?=
 =?us-ascii?Q?6K2FTYYvCscGNAaCn33cyE2WgVs2BKfBVXPiLGGL+5iFN2v5VL8nYR10qmc/?=
 =?us-ascii?Q?7incy2WKvNAQpcFXmPSIsN+oWUjxjdS/qe9BniaPZ3mVuKOXp40p65YrEc9q?=
 =?us-ascii?Q?bfbdJ6UaI2NcSUtyCZRWgJH77Nhsc4iIj9L6ERbMb/ZISdDc2XKxTOR0h8S5?=
 =?us-ascii?Q?ybA5Vp4OuPBxVyBA+8SCV2mvf5rElmvujR9koDZrkpA7XRLcEIZZiL45khUv?=
 =?us-ascii?Q?N7CSW1p3bofUMppHmg/PICwgv20f/BfSAsCyqn0M2LpoyTAIMoK0M3983obP?=
 =?us-ascii?Q?7kEwxMDHYfvrbhqh/sjnhMLgZuYxx0UDk5kpS4vf2Js1G1xkBCdoApLm+r4M?=
 =?us-ascii?Q?PCB99jwGLRncoPy/Cd2LmvnFMm5jFp8OgmB9eYQscyMu5jYoKmBCDAP3m/sN?=
 =?us-ascii?Q?wwnlfX8OfV5Pa13sKJ5S85AaBCg3hjFoUgU1KMkmolaxsibg+9s6/h0SkWVI?=
 =?us-ascii?Q?/l5FuKLLiavXpfGDJ4ByCm/xb/M2BPUDE3Glf5vh/GRb/3FMzUUjIkfhwW8a?=
 =?us-ascii?Q?DmQm8msSvho5qkr8qdx+5Skng3QnUkmyHdYrv0xxYrdfVgY5ARXC7ibHt7oS?=
 =?us-ascii?Q?bruLOfdV+R+YA867X7KxrU3/sZbWsIRQuFMx+sjj8+hYu3pAZBtabIDQSqaw?=
 =?us-ascii?Q?F/uXryUBGaK45ihEEZJdQUvenLI2diKA9QJJWXOgp/6WsaDgFEwWgvctrIFV?=
 =?us-ascii?Q?HTYjsDHqUDHcpVEI2IFfGoUb8AIUije8cBdcdKZjEsjRBWlxBm5e9htisbUe?=
 =?us-ascii?Q?63iUIL4DUQfX7bhv/a+tSY9+SVCrGNr5BaUIfPzlw8uK8H8MOZo7ddHJNSIJ?=
 =?us-ascii?Q?CZ61B5BrkGgxkdqbIxKiOY4CIrwmWm5aZBuHo1FTCUFxZbGiIPR61kfT0NFg?=
 =?us-ascii?Q?LqVWbGe+X1d3roX3G0LwcDqGtwB+FVOPDS0hNkVM43YWPDqTQ6JNCPU+M4tU?=
 =?us-ascii?Q?Zis4QZilFEVRlIdJANVgu3zWLNyEMV4SHlH9+2UUL/rAiIWtr/TphDGfwirf?=
 =?us-ascii?Q?gymDMKlbBB/WX6lagC+aLWMToiJyrEqGUIczFhNm2KPxZIwZOLd52MQJluZb?=
 =?us-ascii?Q?TTiHlStGpQBdg/E/1lhOoVdAwBHo8aqEZapDfJVhFQ4o2Gp3TXLCV6BTy/oZ?=
 =?us-ascii?Q?koniwmTl+VYfE1JSMPLvCfUsoHYwL4/VZ9CMTT8tQOtiFd6fyf7AMwVsm2Uy?=
 =?us-ascii?Q?uZjBiJfK+DJgbOVwm/+cE+wJ5DBATpyF3X1LiE0gpP5cgyVTQqXtEmvDNDIb?=
 =?us-ascii?Q?zI9T8a7uriT7m5WAHolvXrhcc/aUWpK+yLzRLRVFTR6AVjL6kHzopRYnJTv1?=
 =?us-ascii?Q?SM7sx6OD9aApy7AC8I/fwF3Jiop4dd/t1AkX5o69vo9pS7+gYgF0OQTE4UKc?=
 =?us-ascii?Q?zhCyNq4q206CSyKnwwj8STra+7xLM+bYBd73eJopc7JoUehq5YGUdoQ3RXls?=
 =?us-ascii?Q?rwabe7Zp/81f8x9hMrpqkCi701xefzFBKfvBBtROURj2U879JC7/JwXZwa0T?=
 =?us-ascii?Q?NZxdFETWhpdnJ/7mqW5f58Wns3shEspZ0QFTdSExZFSp9DFju9dL5mdzs8jm?=
 =?us-ascii?Q?lNYzGDcr6/ZmlmpJrypq9BxSOhJgIoqIqeBWyVenc8z1qrBfz8CFFQ9bsfmk?=
 =?us-ascii?Q?KO5ijEyffVJ7600gFMBp9OWjahi9QCjvkxOlbF1U6vb7Q8tm/t4pqgSkiCZZ?=
 =?us-ascii?Q?j31ezNwR6Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d3573-cad7-484a-7d9d-08de7b25b574
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 02:11:42.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxLwoCwjr5jZBNpo3FslBdPhblyrhseVVi/gR8uGhXrF0IAz0GJh/InxNaFUh7EJKmg1IwKISof1HoOhRVGQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11629

The function imx_pcie_deassert_core_reset() always returns 0 and the
return value is not used meaningfully by its callers.

Change the return type from int to void to simplify the code and
remove unnecessary error handling paths. No functional change intended.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in V2:
1. Remove the Fixes tag.
2. Add Reviewed-by tag.
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81a7093494c8..ba6e7c7ee625 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -906,7 +906,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
 }
 
-static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
+static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
@@ -920,8 +920,6 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 		msleep(100);
 	}
-
-	return 0;
 }
 
 static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
@@ -1292,11 +1290,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	/* Make sure that PCIe LTSSM is cleared */
 	imx_pcie_ltssm_disable(dev);
 
-	ret = imx_pcie_deassert_core_reset(imx_pcie);
-	if (ret < 0) {
-		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-		goto err_phy_off;
-	}
+	imx_pcie_deassert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->wait_pll_lock) {
 		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
@@ -1613,9 +1607,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
 		if (ret)
 			return ret;
-		ret = imx_pcie_deassert_core_reset(imx_pcie);
-		if (ret)
-			return ret;
+		imx_pcie_deassert_core_reset(imx_pcie);
 
 		/*
 		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
-- 
2.37.1

