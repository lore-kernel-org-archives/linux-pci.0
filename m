Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EE251795;
	Fri,  6 Mar 2026 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766232; cv=fail; b=XSsPiiNTF9ICFrwYK42iky4nE6Hn/QmcOi7J2wUhQjsnMMLBXQoqcM+hEiVq0g7GRuU6RsMCJJOv4F48wYB3HvsmOJFxDP94FW2PkIPPhxJjrxQQROR5cNxF/A8euKDZKjtQmNQS0ofjigkqfNoxO+v0V2Uojm6gB2c44Jdk4mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766232; c=relaxed/simple;
	bh=J7zCalpOj6J77dnkm8QgED2BpXuMMf2M5H25Gj2M8pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JGzJALFoXD2ZIK4J3OxfSWBdeh3rd+youPusi6PsBbJXhZkY9RIBgMxgdGBoqiUn9F5qreJyoHVqzyLu1MgfGXA0vA/0a8NhsrmeTBFKWLqrigaU+oqRF79cxhMAhBE739GgHV3j2OMOZJ8//vVC/FS2mCtK88xP+GergA9Yby0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFXUdI4B; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFXUdI4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr4Roqjcy5Hc7plRNeKRj34J7wdyuhPh0xfpKiceiqWy9sfsiExZYISSIWeV+W2d8pXAsIzR0DymuDbXZDQScTnkO5qmtazwtZrqUmDR4fLj0rClsMDSeymRQroxWaaahpBFNJqFNfXVPvkE3lmG6D21Cr4nIjdFxtrujORIoTraKmj3lEAEiRe9S71qG7gqyZG+t9uXt0sX0Y4PG3C3bbV3o7mSZpdmqKQv4HzIAkS7jTlXkagTh4iz9d1TSNn+ivrH5OfEcYhYVcqN9leKr6pOORsJ7iylZgVOF0dLFuXoRT/4rtextS02tBgVqUvPJUVeheVil/Tv7LBdxQK1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrlXhUxfnMbOaGInTw9jm4DgL6a3e+kug8MUXO+31Nc=;
 b=SiJBfU0HuzE061QTH2aJX+aCvzOjP/TJLkiscjL9JTlMTxYSP6VlRs2Nq4l04KDyd/n4NrrItkHgXdZOpHAnzw9hGnKwM7d0S9Qf1u7x/BzppNeHegALz3eEPmZOoxSAj1sB0hwWJ7u1QppAUkPyTv+VzfbVg6X7fun7Cj3NcC+t8YJXqYUyX698jg6d782MHGIE2Mo0ZfMwi+0+y+e9VWioefzuJwQJaWp+z2cGGVzEkxgz+YkIZI5KL1mhoycQkWoIDXnsNGJ2I8T2G+YV//o7dq2QjLtX79DjochQWVaTQMeHQgH8IxmpTrQzCHLjItgZYnVDN8HSJoyETeSVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrlXhUxfnMbOaGInTw9jm4DgL6a3e+kug8MUXO+31Nc=;
 b=TFXUdI4B1YLxYPPeBks1uGnUNwlL/uS56kPVZnUz/1wgRPrZhFKpyH5wQxZSE/BD43RjGC/sdAL3KkDbyiMEC1AAgE5UubmIs642hMZF5gQoZuVNVfMWzGnpI9LK1goryELGJi9eL9BnLjgXJL8EnYnzyg142NUpcEbXhJyQ1kvJU1lN+tvT0C+urH8ol4EtiAr9vX07KqEuVJFSx4kud7MFWYaI0psjaF8DMaiG4KM1twQIq5npu042rORxwa1uDbIbJ6LwbT8xYQXKxYLeBKT2fdo45rBY3Ii1ZM9lbxC5ZnMelClFVP1jtmEeB3hep7rVtVS/hX7cPQQ0bctdzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB7640.eurprd04.prod.outlook.com
 (2603:10a6:20b:297::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 03:03:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:03:47 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Separate PERST# assertion from core reset functions
Date: Fri,  6 Mar 2026 11:04:56 +0800
Message-Id: <20260306030456.1032815-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: b33a8287-870c-4216-beb4-08de7b2cfc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	m1g28XUY4naVNzjdHyrg+HGF2vQy4Wg7XfesBEoYpwDKRz+XsYUfiMddIHwfkFuUpt0P5rz1hcR8iEGPv3l/fegXaFtvWJA81rFLTzM7bx2dakcTwG0nVFoGCF9OXVcJJP66HryG9YxPSZRhQgdo3JqqrZeY2r2bfIYTEgKeAnnQ9qU1XCwuzrQMme3yhHDY6K5MV8vzLDvZ9cy/JJD4twRANGyVqp5FOoQvTgN1sfckA/BfGJAvfLWZH1iMTBXkersL+8AJkGd3E6ODBGM9ALeFe8J9uWy0dg9JjRbRoAa+huPK9zKdFoYiqVIKu3Eu2uPZu0KJgKvGyclCY/aY1RhYdJpmD01S/VgUPBuLRdTxb2CEo2ZwIw87jWk7UjmDyaj3wIgVXsdJZ9UetsOygLR9jIyVQsWzncgst5VheiL1Kwc7ViN8aVZweIwH6qRnON/UeNMiLc0CilXXqhd98ebQUQtk3TE5jLB4NEiNQg/oXj3RlBD7410X7l3udLF0OE5NAVrBpsKBH6FzmzDipVk668cu8aaFCQJE7KuTolAZPsLnikQIIeQMi8v98IqWgyU12SzaEbgvRDinhmD//2qSpuTH5QzMZSrn9nvG1HBbaveQBXD6sE2LSVvHIDEjS0jlK9Dl8LmwNfhI96Ks71tkqS3BWK/hT5fVKoQCqtVqw2B1UhIqvoUMWrQmGKppXO8yYAyGedQSMR7zlLrsX/3UFJwKVTQOYlHihHqqlByepSxaxZHqFJ12hc1z/NA3Vaf2oDbISS7V1Y3BZelBZE93cA+lB3boDM4TIgRxWQII+Rh1DYLr0SiOS+DeT+/8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVeKA9KN6aIIyyjvzk3cB6Z2f8PGUm9YBjPvGr4EmuYu8TwSBh9or5cLD76T?=
 =?us-ascii?Q?ujXgViN1ro9hwaZ3cBFKXrLvKFhivDZDA3pXKGjYnf5QefEL3UGk1jCmYakq?=
 =?us-ascii?Q?h9mL6R4MHsjgtrsY69Lz6D0g0YTlUAm8+Vx1ec/oujRNHpSvgo+RTvJINyuB?=
 =?us-ascii?Q?gVVX9iDqinuvM/KcAXVg9P4UPA2VUqKsxZuzIA2IEAvk+EA2D2ajyggAasJ4?=
 =?us-ascii?Q?cY1bbThxHeVcRCVY2v6SgzNVCPELczsayrlIa6TzZeHHNLx6wGC6CYeJBAzw?=
 =?us-ascii?Q?r4NOVenC64DVFTWPdt1t8MTt2bg7CqA1wwKaKORBWAjxc6+D503DZeohNZik?=
 =?us-ascii?Q?TCyDAXTc2ddKADVIjjPw6rUJ3XvuPQvswlEGSH4Qj+SFQXwd9G8a2VtEt/1I?=
 =?us-ascii?Q?oztt+2cl/+BKsBiGURzVLGIE8ysiaZP1mD+1Wy/U+Kvl4KZEnib6MlCuqDx0?=
 =?us-ascii?Q?bgxscdfLupAgZWwr4og7JSyX82HuXDta7rLVK04KP0270vuddSRuz2spvBQi?=
 =?us-ascii?Q?+OYpqouuFocLy7MtEE0HOFAzgBDRy65Gue70UT8xKiZQpr16a8buXqUaHBH8?=
 =?us-ascii?Q?323VmyiekLNOrtJaBy/hRGgPmFwRrGelpW04AaqMvhAHDE1y9H1j2IXlX9be?=
 =?us-ascii?Q?GRe2iqvgOLAGEuBU2Aikfl2nnrb3Kz+qvVlFuHcl6jnd7vQzQcCVX0QiY6av?=
 =?us-ascii?Q?ZtR7wny5c0JgoyuctNyZsdLetDMHBtsbnEvnwTi5VUN0x6/6bg40Mz0FeCWz?=
 =?us-ascii?Q?2mTENJSJKlQs+FCu2dIVJRiU9A1ZVd3Cf8/r1Pt2IL9d31cG9Wn5u7gJqrGT?=
 =?us-ascii?Q?Ek4ZKsgnJW67H2rpJRWEV9MOvFXUnE/CZYwlfSS4FBvmh/qdaBXCXTJCBc1o?=
 =?us-ascii?Q?keku5X3hwR4ZiDGO43QnDuZlOFgWWjFpS1eu1AK3wtFOt74HNgBgLj1jdewC?=
 =?us-ascii?Q?fxPOKx0gC0V5AHMQxASbAgHYCeMwxYy3U9z9ccFGe6bac1e6NjOeRq1B2jpZ?=
 =?us-ascii?Q?cG0cXPPJyhV+vo9qswFKkUmnrK+PTXziT2wJBtyfqRxZBNd98xAsiOgBq8E4?=
 =?us-ascii?Q?pBshi9Dm3vNhEhJ+bTvul84+FmCyP7mYbMUPpsobX7cfQ28DcqIp8NWSMpTt?=
 =?us-ascii?Q?r4o4ASTV+JTagC4QlBJ0mg7Rktp3yMuZ9H7jJEAQF6iKPTWVG99hXcfTxk4E?=
 =?us-ascii?Q?OfgJ7/1L7+kdprlx885TgH0MAOBJxlJWWOHQSqj4F0Yi7mSVcjR8nkBmeJfb?=
 =?us-ascii?Q?XRSsT84juwJCQwgQcCnnc/GPdum8BYsUed1WghNZs1dEGO5h89Fykwr3yoiJ?=
 =?us-ascii?Q?gc4KYWu3fqO1FAkYeQiyHZ/R3/mEe8K5Yje4RFGUGpdqePlxD96muPQvw+TC?=
 =?us-ascii?Q?U5ueUNdHSuEZU38YuODN7G/JICVrfK9jbH1/Bvcl9GaH8zkIxLGluAE9MdNa?=
 =?us-ascii?Q?AWo7tzn0JOKEMIO2Cn+97Rrgdb/ETj93fCcWt1DUbzKDx3S9bdky5nLM6YlI?=
 =?us-ascii?Q?XzY2uBRwc5yMrODfWcnejt+1aZls0mrPQU0M26a/KKsUdtmFIRfx4FPTeWSX?=
 =?us-ascii?Q?5FYkm7naEP8XJlv3SrqtX/tpj3jiHSRvzPnzjICfkz5I/1DRKWYURfWbloZZ?=
 =?us-ascii?Q?tcj9ufRH+eHTxcmcLeZPJ27dDNj6FkyzjhhQPavikLzqr/MedIM6b4Q4h93x?=
 =?us-ascii?Q?LuDku1aXJZVZeqhYJATKsWC4Rr2bYSXVQ5Xfzp3PibBX43UFW5dKIeVFh/Ee?=
 =?us-ascii?Q?IntTkZoOgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a8287-870c-4216-beb4-08de7b2cfc6a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:03:47.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffvqUAxrixRViX9fVvZxvBugtwf46gKNBFAfTS6933dS8YSJhmMTdCLL96bf9anU+jjcD9RAuGhCqkoN8k/EGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7640

The imx_pcie_assert_core_reset() and imx_pcie_deassert_core_reset()
functions are primarily intended to reset the RC controller itself, not
the remote PCIe endpoint devices. However, the PERST# GPIO control was
previously embedded within these functions, which conflates two distinct
reset operations.

Move the PERST# GPIO handling into a dedicated function
imx_pcie_assert_perst(). This makes the code more maintainable and
prepares for parsing the reset-gpios property according to the new
Root Port DT binding in subsequent patches.

No functional change is intended.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 29 +++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ba6e7c7ee625..d80d3be28ee5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -901,9 +901,6 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
-
-	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
 }
 
 static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
@@ -912,14 +909,6 @@ static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-
-	/* Some boards don't have PCIe reset GPIO. */
-	if (imx_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
 }
 
 static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
@@ -1231,6 +1220,19 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
+{
+	if (assert) {
+		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
+	} else {
+		if (imx_pcie->reset_gpiod) {
+			msleep(PCIE_T_PVPERL_MS);
+			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
+			msleep(PCIE_RESET_CONFIG_WAIT_MS);
+		}
+	}
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1253,6 +1255,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	imx_pcie_assert_core_reset(imx_pcie);
+	imx_pcie_assert_perst(imx_pcie, true);
 
 	if (imx_pcie->drvdata->init_phy)
 		imx_pcie->drvdata->init_phy(imx_pcie);
@@ -1291,6 +1294,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	imx_pcie_ltssm_disable(dev);
 
 	imx_pcie_deassert_core_reset(imx_pcie);
+	imx_pcie_assert_perst(imx_pcie, false);
 
 	if (imx_pcie->drvdata->wait_pll_lock) {
 		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
@@ -1587,6 +1591,7 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		 * clock which saves some power.
 		 */
 		imx_pcie_assert_core_reset(imx_pcie);
+		imx_pcie_assert_perst(imx_pcie, true);
 		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	} else {
 		return dw_pcie_suspend_noirq(imx_pcie->pci);
@@ -1608,6 +1613,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 		imx_pcie_deassert_core_reset(imx_pcie);
+		imx_pcie_assert_perst(imx_pcie, false);
 
 		/*
 		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
@@ -1845,6 +1851,7 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
+	imx_pcie_assert_perst(imx_pcie, true);
 }
 
 static const struct imx_pcie_drvdata drvdata[] = {
-- 
2.37.1

