Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830E386567;
	Thu,  2 Apr 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123487; cv=fail; b=T/7RF0jO3qmXMeg7dor5CiPqL0BMukERdP7GlXZ+W05yCs6cceH4UjrBTKxTyl8wMzJR0EujyPgbdMdnDGIoU8C6EUZenvykpwY5pETR9CwVMZXOORug2ZHt2TI0V/tsZrCA6QSowW24oXBcpmmuOZlmat++jtuhlwZpT+J7AE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123487; c=relaxed/simple;
	bh=bhd7sdPMyTLTMWxUSfuz2/r3EYJn8I2Uwi0UkbpZwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWd5GF0zqqXJLM3/OzaVyS5noHJ8ClBJRiwB/iA1USTL+HdgWp9n3dNBQrfeWyS86oPWhTNM4VXjeJNgsbeXkT+nIKUMumjX8jku/CNaHiSzKXyUj8XDhDK3SopemvaCBgtmdurWnLUMyAqr1PNlmB2PG6IPUau+XhZk9R4+zUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nhQYDmaa; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nhQYDmaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKzBMEeEHT0NFcA+dUiJTBtlnBieqKoZDpGAyi6omoCG6Hzz5/USY6iiNfE6H6WF6IQ61XPkhthT46ikGfWWHEuaGIvzuUG+NJJf/otUg4WCH93df+UbBSFpte8oQKs5GgaOzIpRi+HePO6ky6v70mY/1mbC6Jjp8ddHMV6DLYIKIPdKjIfCVy8OSvkJR7jcpIXC03NX7jIz7OxMczhHtRI0Xld8QW4tYRAzKMYB4RBL4NNiADw4VP4ti5anyIpVypylPdKE8MHRGFQv4UWItSmYz6CCpDkEUe2XKrSNswZs+AulboFCqHEKyQu6J4eBVknaXSnfbgAcCpTt+mvPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=YASL6FZcCU3zbFAOwzlSDrAO94llHaaeogAEGVUau7wIFiXJIPcIggzEC6grw24LkuP1Q99d5oBO42jWI/QCG2vU1Qo/cPAqteu8IMEi/K2AsTZb0r0LIiwgFMnaW2dQaYsjOxH1yOxyoXflQ02W/XP7GXLh4iiPLQzhRKwV0vOwuCJKVCTQgsHHnRrVe7zicR/aoSTa645X5S+jmHNeQm6TkZjKIQMnPY2wGMIOKnKCo9nGghsyIEG7WkLAAMrwvrMt8xwhXHelXRWggsMmCenAFgPECtrso9nMPWC4jNBolafb8XBK57qVinjtBxYTlSbXgR0Kqeg+AoVQitTtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=nhQYDmaaLbIdG4T2yKCtwtag44FY4YPK4cUos5wYfHQ2Vj9ktX9GIvboFeFELsSjJG4xR8tmGQQrgCEoJ5jNYp7fbiN2x69/WbRqMsTtiCQdmTiVhXPHAhMMHQpOHyRtxV9LPR0lZm0ba6hhj2Jui88jvQlrDl65HHkO98g5yzvQ1a1PYbVhgB60Y6J12THIN492QcqKQC1/lDbUOIRSi57z+q1chy4bPUN7HRQbwJzB0ZlTcvfReDGujVYlHKcVq2dEjYyC5DxG/LzAO7Qqu6RGeuckGlKT2YCCkxNEOKb7EPb5smXStHpNP2mfBNU6NfAvTOlrTyCg5kg7XsGyaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9865.eurprd04.prod.outlook.com
 (2603:10a6:10:4f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:51:16 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:51:16 +0000
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
Subject: [PATCH V10 12/13] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:06 +0800
Message-Id: <20260402095107.205439-13-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2c2d94-b12c-44ad-8d3f-08de909d623f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kmyZ+Hxc48PqtYbP3d/phb5kXhr3pdL9Bz0ZdeNQCS6tEOta8aviQtEE9LUYDj48QXLZqIsJhSufw1QCaHentpwfFxFOQMhH/EaCgOfzvcqM2nlTp6cdaUOXDasVhgLlUDVJDzcelRgcrSef1wUYI1e6RfU8gyiw+xlp0q7sZv1hXGDHrtuE6NFTL9kzNZRa7Yf1iSMVcLeLBrCnwgA/vxj9i9+hp2sqljVcxBe3d6S0hhiHoJLrtJx1JyitvJnfNnD7zmKhjlfIP8lv7PnHFNxMEVU7n3okVZVau9Sz9fTepNcW5sQQ2gAuFWYvYIzIqmc7elfwUdTkk6EX0U6vUWRALjOIiyqUxT+Q4tWC3qR89RrfYlCcL7JwmCVV2JpDcmiJKp2S6qZ34DIIXZYABcysC+GHqnvKaGfklMjIitj0ZqpkMzEIQzSu9kppJZJOZl6oJR4LMBT5+5C3Tt0qzeouPfoyMIghpbLkMKyr0aPh2KAhPZb7d8SBREkWP8stgnvxwx04iyyzH58KxFaimE1qkry26Ntb+mj1PrJWraeBLli7y2T5qGdM12AnIhi9d3yc9MjmocKxpHzJ81I1vYBBsk+6Z8G5zZC2dq/qHnQice3grzj/rsK95vRk6fTV50FPHeTMw5sZDhXeuc007z8wpL1oGVCOL2/7UzThriN3FxGTEbDcYdJpyrihVPvib8BmZnirDJ+jeiNWrdFUXLx/HquHrGV6OGmx+0rbS1j5wVG7SEZysYIObnTSit2ra/+5nDYVVHCn2sI3k2VjGovb/8p5/xgAWNsNe23+FBCOfpyUUBUbmnxFOmkHmZOQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aw+8NtG2PTSSW5kuu+GBKM4FjtZzd/NLZC5QORf63+aQT54IIzJi26dmsMDw?=
 =?us-ascii?Q?XMaHdlpHEwWe6cWOqnhaSYzhbQ+56UnJYhnOCF79qXlCM6B50Rsd75+P0vn+?=
 =?us-ascii?Q?fJJFqwb5//Fxenov3n3MQQ20B/47rHTKIEshnqLQ4aNUneutU6NyN8pYsZlz?=
 =?us-ascii?Q?Ukm0V//592Vy28Zu3NYeqi6bChb57crrM7HYs/I0FaDVLESBobi/Mrbx6XUw?=
 =?us-ascii?Q?MMnQpgwv2za4kMc/IlTTlGs3IA6GsC8XONP1zn92rt89dhjrDCeAT9RsrkXQ?=
 =?us-ascii?Q?8NfEcTb8U7Eys0iWMMekQI7dqt8we7IH7eWgL2iWPpY4FLd1e6xxgeqv3WfA?=
 =?us-ascii?Q?8TcRRXTDnzwnxe9c8yncQbsiUqhCvl5BKi1qCLxU/h2J+1u5VX0V1yDDBt70?=
 =?us-ascii?Q?JPdQzq9JGfJSqP3StF6IKOOC+moU8OcvEtDHW4RZQIg5vBjbqxxV38gKkSa5?=
 =?us-ascii?Q?iFFEJK7TeE3/dnQrzkVpQqH8mYN9RS+zlM4AssJ40u+tp8sczw5HTLdAMZww?=
 =?us-ascii?Q?ny3AS69P0JpJ6oqTqcchSY1Yer4PG3oFIxHTTR/94gJpOylvRqxZ4DRAJA+G?=
 =?us-ascii?Q?IwwjOj2JMEtD0N6nLfuVAPg6v4W6h/TyiTdWrN+xhFFR7QnGn+IdI1e90bl2?=
 =?us-ascii?Q?OJ4lr3kILL/COJ0caZGUJ92Yro12z4mdEdkfNXhmFpsrv5BznImg70b94DVh?=
 =?us-ascii?Q?2YStJmb+agp4j6OlzrbJnzcAmaqHMDhZlCfbd79k2hT6l2RKF2Q3Y9ti4AeM?=
 =?us-ascii?Q?bpUgn9fVK8UcubmehIiAbrWT6nJOqrlnvaOfwf1DntnjbgLZSipT4IskYmYK?=
 =?us-ascii?Q?745GMlkNoV9MVupRXzRLi45aGm+AJmjIwW8l0iMEQuwKU9B5DQq5ArM+JtQ9?=
 =?us-ascii?Q?aM5bQIfv1xtqmuSh5Q9aEEuJjENIdBo/+xoIU+GAeIB2UP5foOSktoj0r8xy?=
 =?us-ascii?Q?R+bMQ/RJ/zhnPFoa0h+5qet0A/R7BWZOMmXob5om5rMEcJ+23LEPzuSQR6cR?=
 =?us-ascii?Q?Cc//SsgerVopjyNt15JgPDCNuRk737K8NwDBseipTFDnUZt9kfavsT+wD7cZ?=
 =?us-ascii?Q?CgNDy7FLW0Sray4NFGUu1L5VLIm5uPumeSHXFKvXsX7mm2UVSqXelwOJDde2?=
 =?us-ascii?Q?4Wgh1quV0+To+BRPXgO+UIGNqxTTAVWOrsSo7YZwPJCW79cBBl/wBgOkoZRN?=
 =?us-ascii?Q?xC7NEfvXgTOW5CN3C+jCMZu29OAKagPuwHZMmRHTCflSPzpcyAM0dMG0SZ5Y?=
 =?us-ascii?Q?9ezJinFbjyUBnHdNaDks6Jm54C5759pxniWARvzMMJ3d9xT4KlYBtHGO2bpt?=
 =?us-ascii?Q?w++YFlPVgj0fKXc+9BVkcIpaYx9SvLv7IUTVlvfx/f46M8FOsRNdTfn4ZDhL?=
 =?us-ascii?Q?OlKl8LUAGNSrDIYazBzow5xXSo3vsW9tftRARDoOGF7vcBi16qhOiclSUYqE?=
 =?us-ascii?Q?zs2reA15Oc7T9CRuhy3ZNKP2ETZ2fPHopTPRnio9RBxM1EtQVxtlyv/U0KLR?=
 =?us-ascii?Q?W2LjyZ5DyWR3DHg0k2jK62ASiSw0hmXosW5x8ah8WgNqp7qrQk2WvQGDn4+l?=
 =?us-ascii?Q?jBg2YkiohUjAabs4BUJ3XBcPke0eiKqgMieyVENC7CXNh6SylaLsQGlwINoa?=
 =?us-ascii?Q?YPpLPPXp2v88mo4zGGeeXF7Bt7ws9b5EwGQ5eiWmfnaQiy8XFjbyDmlI07Jj?=
 =?us-ascii?Q?s9g6nUeZlteE24tfnRTWyrr0XYP9rNeSGwKrmFAuqhOpjIg3fQeQzooHhwPP?=
 =?us-ascii?Q?WwJi8PGjqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2c2d94-b12c-44ad-8d3f-08de909d623f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:51:16.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTdbfgKkW+VIEZMG7NaogXC3wtT+ljgNvsHh2PL1rzveiYfkCD8ygewsf7qWpN3Q8LID95aF62sjcT+K68oTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index bc62ae5ca812..39108a915f96 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -675,6 +675,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -691,6 +692,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 011a89d85961..f706c86137c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -810,6 +810,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -817,15 +818,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index f2c94cdb682b..2e4fbfe0ca16 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -41,6 +41,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -91,6 +102,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 623169f7ddb5..489e174df4c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -730,6 +730,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -746,6 +747,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

