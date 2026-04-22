Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F815372B3C;
	Wed, 22 Apr 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850472; cv=fail; b=n/+k1i+/yelmopjzlRysm/L5TK/sOCro/5xhGJdZhrwe8dFC6HA27c0p9rhBXdSRlIYa26M/N9vYF4pKlGRN0vxeAjnVSVuFntKkwFQcAw38z9sITDGu/iRfBcbxmu3bQnMnamcl5w339SokuUQbd9lcZ6EqwZcUAJ4/dkOuRx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850472; c=relaxed/simple;
	bh=B+IUcdsIJ2cNFPRVaG+xcPg4bNSXo9vHqnC7VOsbhpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pfk4/Dcktb/Kgk53AhppUJzsc6+CTwPnNbZ+ez7bOwEZiTXhvlSxmeYKGJF0emsMFuGkds4vBrhy3ke4HF5uJyJ1siHuQoFdcStnqYovgSckJfKbFKXTOXtTF14DX8G8vcMePGLOjZMZOYQ5X73MfbAD2zdKUuGVRyVQDiHC/zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/YZYv8n; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/YZYv8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS0X5Gcjfs4cCVzBJSFfApERq7kQvEVZ1Asm+6WlZxJQRtf2Hq8dk8LLY748XyYT8xS8/ShS6qY9ZpMwtgVEBbkmzAnR3Gi37HuzpSdxKpm368r5gFRAzVXxs4O03Qq7j58GI7AUMT3fU47hWocMoHNLAD/XRUlkWXacxYLbRngcjDV/2PQvEWSbP1r3Ifh4hDeKyxBWlVpZNjdmBRK0UNjsZpcfXjq+s2ogV29Wbywz7qO/43TiTCWqhsA3BPNj13n/AX6hjkFEZPg3iF+K0RGoiaE4rkntisAJ+HEiaoFbA9ed5gOLULrPutnbm6XxJsC19FPLW48hKoPUdaZUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGVHqOPs/4jMGkcftvgjRX5BCFrejfz9iGaZzDJBg8s=;
 b=Ied39/cpu7eTksWed5N9ISONZJ7BHpQGty74WgqxtFIMwuf+EcngIBF5gDxy/2IsKtAAgzfkeiNuKB2i+MLrwcRo3FF6Sg+Fetu+25Cw6qpF4eFOUguV6WSAe+JpaG6nG64avN2iQwv3OQoEdgVHy/8JYwg7k7cWwHbHM/PZOaNJE2lwZQj7FX7SDXsuwbjSkScNOwLeQigZQdnr7YHIgJNBvaDWMszWCya2l6TfOytbKtRotF0hDiK2TECVJMV6ctfK5M+IRdejHjCGwLXNgxsRv2fwtH+qy1Bg0qYHhNdf+6gNKWG0+8QAGcf0uspxVEWV+n5Sd45+Jy7VUthMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGVHqOPs/4jMGkcftvgjRX5BCFrejfz9iGaZzDJBg8s=;
 b=j/YZYv8ngScfy3zjJAID/Qgy/9dh50tGjrDNBLsrygAi91AZOc333VZsmHlux3adTUL9VZF/fajHcToY1jMpKTAPpP6J8Qrn5hTFnVjIwq19xE52QApZ7YobUIDye0m/tK+/unKtmasKQ2wBggXU3ji52iaf7+kmLjMkeyLIKaPIHBuJJbA9SuvYY0ISNeRkgCtDjcZQue6MAhb92opCdqFz0BO2qCVkLj2EZA5DasCQbY0OcfeL7dmtx8xyFbDAX0Kp1DKMMIUcwPdMZLTaxg1cyh2Q0dkB9ullk8fIN7QlEYTdD+WyqDSpZ0qMNQF8J2fEm4V0C2J9S2+klAPxDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V14 03/12] PCI: imx6: Assert PERST# before enabling regulators
Date: Wed, 22 Apr 2026 17:35:40 +0800
Message-Id: <20260422093549.407022-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: da00a706-4c09-46bd-3ac8-08dea05258f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	FCcQiBNkgCYUAqiJVcTc4NnP0PNtw6JdErqQXc9AH0m2gXbE2a+0CdtoS5c/AlPq/gTP9+bnJJSd+b+KM7Mgt2Ml7AH7ux73fC97aH8hHVKDhM/bgjzciNvy6Vr6f6xtkUL4XU0baKWvQwF+3Ra56n0zYfbUjPELtn94uwpB62eicHjHGuFjikivJD3nssv2Ti2SSAfYL3z0Wqivlk/7d+sA35KFJdxZy+CF8C5/NZnMlxWrj5JwkTWJ7luXbbHCAMPKQ6T+6CoOmcEOLHh4wVH1EP6XgMRUSUe2nwmbu/DX1MfbIyrdUau5okHXZI1qSZOLR+IocVtRGvUKLwlFizzspDy4xU0W/GGyAt9trsz9JSCwzy5BT+NxHnEt36lJ3Uvg1IOjYTEBtaXI3nA3Xmr+ee9dzEf0ZYDG5zVzAT/px4tfT+rYLYUgTjKjR5UxQ/mXoQoGQxMU22DgWvENWBioZ3G3eXL8J0++e2c7fIEhnh+TCEtM1/357DK4O1B+icF7vT3Jh5gpBpn1V1EsNaTpAGNKRlhPpkh1PrEpZxYJhDQRtRZIBKMAi/MU3Xp+Rv0kVZ0hEblkkB7XZmIVg/K+XK8UldLQV30UtdSPNxVvnW48OMM+8WucHB0+3Nxv8vxrYJ5tJnYJ4ebmqK/CHqUxJhEc9IM6K896qEoyuN9Uz1IF9Dx+JAR1J4Nsh5EkUqfeA+GOhRJEjK62DBYhGMEU/8QtxkshanpyDZJ2M7V83DL/d8SOHxfN2Wy/ha5WxS2Y1dDw7C+Ud7r+3Eu6MrhNiMMKBlWyK0CCcpJ9AGwg5tFJ2qrmBN0keZnDB5Yn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRih8NhRVKSboZ/nSwpATq8rUwCxKZqM1s0q9ldfDxfWpPxSLGDBJf+w2Ryv?=
 =?us-ascii?Q?86JnJHLDzpa/akUekgGZXPgqPAjlMB5qh+r/hhJi1x/twbiA02qjZgWJyy9T?=
 =?us-ascii?Q?4EReE3G8HGiUSn+nbyXMcg97xdNjnkhAt5/q+JHCC91/AZ3+SwnnENJOp+xJ?=
 =?us-ascii?Q?Nk84YqUVJjdPrcVlZBHU8e2JMQTK2ZJLfXVafs87UmJLJf/4InshD39dJv+u?=
 =?us-ascii?Q?M3YS+FaTxcdYgfi8ZQdPGqVq5K90sjsRy1YMqY8ISwGbsxZXGsrWJS7b3xa4?=
 =?us-ascii?Q?VkZ2lnFlwAbUDV2yjHUYgUaSkN3OXowHm/vrTNhJpDc1+WvC1qKwYGUV6pRv?=
 =?us-ascii?Q?qzgmatNT/xu2X9D7GD5uW2GKM/ILxL2O27eCjAUn4S7dJPlNMzZDkrGtiylJ?=
 =?us-ascii?Q?TYLrstCbs1y01YydTQPlDRm0J7OiGSTsgoU2YxtW0jUsevb4JoXGBKfn0QD1?=
 =?us-ascii?Q?8vSTxA2jEYjDXxhCZjKr41VLCzY7bs346q7QcRQEZ8fhQIh7HstyI+iulJgE?=
 =?us-ascii?Q?ZzEyvy/iNSQktUXFzabXUKU+4YqNGT6y9XrQr2BBzUS61rIKkKfK2ynFs+g8?=
 =?us-ascii?Q?SgWqd0YTvceqrGdbAICd8Dit5CB+nljs/w+5bWSNoCOFUlssXMJZLx0bDEAw?=
 =?us-ascii?Q?bSFgndK6fagvNQo8sLZLyeNKLPDYYkE2na555WErSA6ixjNArxS7a6pzoFgZ?=
 =?us-ascii?Q?ESVAlwghYANM8i+zZdKCgzXkSp7sroZ8y/FsUjB5eTdBQaGz31DDbeo6Tuug?=
 =?us-ascii?Q?9EzoT6Rk3CkoVPJCb0fMIKnCdrE9qp8djYA4OoDMNWox84TXPENTFQz4VTNG?=
 =?us-ascii?Q?/2qz7FHInppK+mMkgO/p3JcMhmsLpe/k+fAmpsE4Tlci/oMJL4Dxka3/EQW+?=
 =?us-ascii?Q?AVaR+MMBy/6c7tZ/BD1jSHOOY7et3ZMKhwSeU5h7iHcGLMvzY77sMWZ41AVY?=
 =?us-ascii?Q?Bg6LZbFfQDemMr9BrjaBS9JCn0ehXU9BzyT+RLFqXtoDUnZ3GD4BU44N/Ck1?=
 =?us-ascii?Q?6PmIJh195StlKHmqsM/QnRvaaiC3wAO3mve4H98zh/xH4m5uzNfaUSQdxnD7?=
 =?us-ascii?Q?JfZqgyjsyymQociOym44A5Rt3NGnMwH+E/Np9u9zo4OYxW2MaFn1CR2/YDI1?=
 =?us-ascii?Q?U4a9LJX708dmiv9F8ZzOooiBEq3oI3GILh+WJOaNCMFMI/Y+4Lgi4nqmlGyf?=
 =?us-ascii?Q?gkWtuvgaM1Dkvl1KUH0unfQaUVzmIQp/tXV2F+mOpSnA2DdfJ4eRTNIydmv9?=
 =?us-ascii?Q?aLZhZsRY+sYs6QCUfOMBFbCgF2lkw6EwtIcDArMC+Bes1OTurJGeLrUcTJGd?=
 =?us-ascii?Q?55Y208T8CQBBddquAsneDakoYVgnz1HNwJxTWosAdwDz65ctUDijViUvpIDL?=
 =?us-ascii?Q?eHePUVU6KU/IY158FB5maVSxeaxOt5zrnkS43z2c21b+mf9xhLvnCAXH55IH?=
 =?us-ascii?Q?Jag873QXS6JB+KDpC/7vuX7955aEKZirDc2VZR3PdTuISKuuDP3Ut6v8eT+n?=
 =?us-ascii?Q?WY1nsGtDxoAAyv3hpZC4FOj0wVlzpkfb+0K8xV4EjejF5cGv5YzKhjrZZNSu?=
 =?us-ascii?Q?KcOLlmzmnQv3UG7Ho9tBeoDBpAAEiu0Kf8k562pCJyFTv1MrkcWnbdqM7DTy?=
 =?us-ascii?Q?1F2zB842SY9yDfPYUWu+UBj2qrjknhXJS/YsPN5KmFa0DI/P08t6RKuarNWP?=
 =?us-ascii?Q?VHHe1dSrVx9MaI0wyFb24kIyNv0j7TihL/tfJOQ/r0BsIDMkxZskLvk/v4/+?=
 =?us-ascii?Q?yXmY9wIv2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da00a706-4c09-46bd-3ac8-08dea05258f2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:27.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2XpXgZWy2BsP06Fwi40calf95hCPvXgxpqm6gtMIlq00vn6mYEYbodBbtJn63hsmk4RGlMpeHQBR4IJS1drDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

The PCIe endpoint may start responding or driving signals as soon as
its supply is enabled, even before the reference clock is stable.
Asserting PERST# before enabling the regulator ensures that the
endpoint remains in reset throughout the entire power-up sequence,
until both power and refclk are known to be stable and link
initialization can safely begin.

Currently, the driver enables the vpcie3v3aux regulator in
imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(),
which may cause PCIe endpoint undefined behavior during early
power-up. However, there is no issue so far because PERST# is
requested as GPIOD_OUT_HIGH in imx_pcie_probe(), which guarantees
that PERST# is asserted before enabling the vpcie3v3aux regulator.

This is prepare for the upcoming changes that will parse the reset
property using the new Root Port binding, which will use GPIOD_ASIS
when requesting the reset GPIO. With GPIOD_ASIS, the GPIO state is not
guaranteed, so explicit sequencing is required.

Fix the power sequencing by:
1. Moving vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init(), where it can be properly sequenced with PERST#.
2. Moving imx_pcie_assert_perst() before regulator and clock enable to
   ensure correct ordering.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 49 +++++++++++++++++++++------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e35044cc5218..735127ed1455 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -168,6 +168,8 @@ struct imx_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	struct regulator	*vpcie;
+	struct regulator	*vpcie_aux;
+	bool			vpcie_aux_enabled;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
@@ -1222,6 +1224,13 @@ static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
 }
 
+static void imx_pcie_vpcie_aux_disable(void *data)
+{
+	struct regulator *vpcie_aux = data;
+
+	regulator_disable(vpcie_aux);
+}
+
 static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
 {
 	if (assert) {
@@ -1242,6 +1251,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
+	imx_pcie_assert_perst(imx_pcie, true);
+
+	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
+	if (imx_pcie->vpcie_aux && !imx_pcie->vpcie_aux_enabled) {
+		ret = regulator_enable(imx_pcie->vpcie_aux);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie_aux regulator: %d\n",
+				ret);
+			return ret;
+		}
+		imx_pcie->vpcie_aux_enabled = true;
+
+		ret = devm_add_action_or_reset(dev, imx_pcie_vpcie_aux_disable,
+					       imx_pcie->vpcie_aux);
+		if (ret)
+			return ret;
+	}
+
 	if (imx_pcie->vpcie) {
 		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
@@ -1251,25 +1278,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	ret = imx_pcie_clk_enable(imx_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_reg_disable;
+	}
+
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
 		pp->bridge->enable_device = imx_pcie_enable_device;
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
 	imx_pcie_assert_core_reset(imx_pcie);
-	imx_pcie_assert_perst(imx_pcie, true);
 
 	if (imx_pcie->drvdata->init_phy)
 		imx_pcie->drvdata->init_phy(imx_pcie);
 
 	imx_pcie_configure_type(imx_pcie);
 
-	ret = imx_pcie_clk_enable(imx_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
-	}
-
 	if (imx_pcie->phy) {
 		ret = phy_init(imx_pcie->phy);
 		if (ret) {
@@ -1782,9 +1808,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 	imx_pcie->supports_clkreq = of_property_read_bool(node, "supports-clkreq");
 
-	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret, "failed to enable Vaux supply\n");
+	imx_pcie->vpcie_aux = devm_regulator_get_optional(&pdev->dev, "vpcie3v3aux");
+	if (IS_ERR(imx_pcie->vpcie_aux)) {
+		if (PTR_ERR(imx_pcie->vpcie_aux) != -ENODEV)
+			return PTR_ERR(imx_pcie->vpcie_aux);
+		imx_pcie->vpcie_aux = NULL;
+	}
 
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
-- 
2.37.1

