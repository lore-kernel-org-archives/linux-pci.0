Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2E36DA00;
	Thu,  2 Apr 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123476; cv=fail; b=u3Nn0qoRdvwNpNdDnG61IypIQ59u/bR6sbCzB9eTxAUByTWBjTL91mZZwYrUsIkxaxZLVRRmShPjka1+0aFMCWJIEyVT9+LsI6RId7dFt+RcZRWdP6Xr4wzV3JS/JmCd2ZGapP3XqkRcD61NEK+zLc2yA5CKPmx1Xr1H9//AhvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123476; c=relaxed/simple;
	bh=x+jr4m49wP+8i2/FZYDMOQfGG0j2TOvL7tn8QjaWo+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1/tjgn00mXvYIGFvNncQctoXqLK+DbgNExO+45EAFsE2/OJ0uXs/l74ML0xw928Wq2FPfuABeiqEbwn5w1FNJHlLszBDaHTwuU9+n57mMTwRVBUJHyBeUN08I+T+HVEVQ0H8GQaHELu6ZSrbRLJym5kZzMyx/IVXaDmjd3xYgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BHmycHUY; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BHmycHUY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNjSNAxrEssRbjy1psMuHRaa2QGxN48/3IDFs4YRZfRT1BwDQiKdgsSe/TEBVHl3aKlkRHHMjuFVjCP/N8I2e0io4K4ImX2tbBlp3akgEGkjkdySDnw5mqnk2fwmEWqGPsuEQbNW5k0Idw7NfV8lHK7rdbGrMQKwYzFAWnd619qcCSu81pBf1Owp6sv5gvXaRX8YvOBSIIyqFhWBdz0RRMXtxR8yI/574vCztCYEVNI5NLiByo4ypi0LShpuscrB+smJkZm5et1LPU0+KQWpWnDxUveu+i4BLCTH/4y+XugJeihKdp8IuR0ZfE4oskvOYkqoSN5MnvpE9Sg8L40Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=KBGmS3M92VIOIDjsWFPbd852IK69hJMKAGFt49SLMN/DmIbgBdXrrHABKGK0VzaJIXRQGzuVy8mNmytcFYr9XQ5DKl5zSfOqySOF3hvKMgFqogEwoY+sGiHZbYo6vE+QWL5WPYhznlopN78ng91uJlH1MaZPeLvvbqYmk66q/jFIFydFPs0vhFOGQSTFOBEXgy0akYZFjydT7jO0ocDj4+S+mgvGidS2VivoTGx/XJKApafTif8UFmpOVtrFvcglylzPpa6jXyo3Mply0OF3d67Y7VfbrBGuRjLZPdXAPgoRMd+qONsuvu6eGFxQ3trl0DmK9BRlFSZPihEkMUXWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQRbIJIKrp1TwmDhYhB9Zfx6X03aWZARMa6qioX9YUo=;
 b=BHmycHUYEL8BJAdhkfkfSRBW4t+JkRv8qWBE31tr3gn9Q23NrC+GEChwbUTjW0sYIhRXWJozMwz1jZIvSODW8qyFzxg97WH+yA42qxeBwcnhr9mYw5mjgPOsR+FmZOJ/mV57kXveWZc3ybUAcXM5LNCBdcFFVeahlmQhQk0lR09g6Iosx4kmt5a3hBMmFXw07DkpKz5IOnJwrn2PhUeyeOcwSlIkpl6ijJpC5UFRLTe058eTumRjlsaztBWV2SX78nPzDj9QpgzJ6UkfuEdfa6S0+KlbCr2CX1rrH4vndnzbuIisfdx0AEuU84jmjRtzbWCb1q9lXS8AhsyIFSCmnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9865.eurprd04.prod.outlook.com
 (2603:10a6:10:4f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:51:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:51:10 +0000
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
Subject: [PATCH V10 11/13] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Thu,  2 Apr 2026 17:51:05 +0800
Message-Id: <20260402095107.205439-12-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46cc5cd1-3f00-43c7-c30e-08de909d5e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QmaiwgQHPcIIMakHHBNn214KSd/JrpbBZdKOR8gp8sYsEv7EzE7FqPUu4a4PBXQngMvf7O2iUanXF8hOG45G/IpOFjlnU1mX8yAGGERgRCs4+mW+9Kxl5RXtjI3p0C9BDV03zNvjrDHJQTU+cStfg8tiATuU5VAsLlpsDZmHAcWsZLZ/lTq+2sITKjtbJapzpIplJRKl3ohti2HJ3N2NRnW17Cx68dKz/e5/eVxzczJqmxPXDcUBpkrCRUXfJ2qzPMWCYWPUpZkh+4nkn2fP2/uUwZ1zvcEAZnqmZZ9PY1UC1Vp3dhgCovYyhcoYII+WkoyHTDaglpI2qFqhKT8Btv7Fj9C/iFNJsWDUXg3TvzJsKeQ5EIvSmw8Rjm+Pb55PALmqmYePjMQbDa8DRggOyzXTjajo2Y1hVlvyiBr6o3s3ewIf9LRrCUQfs0t13b1Ym00OKj7kRIrSDde967s5Ov4mLXNAG0oz6XSBtmP3IPwY8bYviTSEC64u8MjUh+06OTmZxeXbEiOVIw7rxsqKV3eBpBg5RJV+eM01AX6u8g+q1mSeGaO9Cu/yHZfBO8sfJ50v1nxuat0KWrLgnF4zEfDMdEYAMZpnvi6stnxxRlak6ynFGO2pxiBa8GwpNl9PnmOpFUd26HmK5Z3v9ITylPKYCKsQkGRHY6+cg9+6v9w3UaLwujnK/cA2VXXT2i9FBC4jPcns1+C7Gvx4pl2c4J7wcBcwfIHZnQ9ovvpT9LhmfjoLQR0Mc1UjSVyzp0GFQt8984CFisWEco6dwe4THh+2y/420rirBRYAFQQb6AZKnZ3JdBZ9rUOr7BXKCFf6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ATLqb+MR59AhfCGckOUB90igNocqGci9NnifeN3V+rGt9STvV85NVvhhFraV?=
 =?us-ascii?Q?EIsnR/1N7XLqGCaRF2mY5yJLp9n0q7DMgjILkRrG7CLbG3jNNPQf4mYh53WU?=
 =?us-ascii?Q?YpTVATx2pbyleFlXhmYyQXutfDZSdobh6yvhDmycRKJ6GPOjraZWPBrg2myd?=
 =?us-ascii?Q?USXKJOs+s6n+3zZhDJfuumRqcmZwwHQqFtjBesJeP+cMGWl1Oiw6ed6sJ1qM?=
 =?us-ascii?Q?gsOyt3Ehu129dQJb4XGy1s7w89uuaoTbnqjD1ddTB8JYUFgGF7M6TVp/c/6k?=
 =?us-ascii?Q?PLvUvWY+asRpM+5Vhs59tnK3oh4tPMNRjU3kyCWJ8afgnbaFc+zL4nIRYfDt?=
 =?us-ascii?Q?6CqzC5YgRasZ31H5/xkFUXLnHjOAuyZ2NWMajntFZd5wVxUs2YxDetfvUyfY?=
 =?us-ascii?Q?gEitS+6MieBMBuV/1cklsjPPvCWmT+b5ikeUTf6fXnIkgAWRN92/Rwdjjr3E?=
 =?us-ascii?Q?wtFlvwRjwa7CU8SLsWCnL07a9fwJBRp1UjbsUO3WXcT0mhC5gY/TH01Kx3Yh?=
 =?us-ascii?Q?0B80rlCUNZcAvdBzzwrYLrfzJnse5EV/jN2VuUncXQm/pim81IlbC7lCZLMI?=
 =?us-ascii?Q?sTUZ47f3El8CQ0jEsE7e9GOdqJmIIx11SbOlV5qj3VZTBP8fJFfu6ODlQPmO?=
 =?us-ascii?Q?rR4eVVQ6fQY0OCaQyMxKatdYcXwQYgR8gbgvQ0gVp+Z7WpzwdIYxUy400+cP?=
 =?us-ascii?Q?eM3MPGwQoPxOfg1PIiycAXa1WAeXYC6zypTM2yfsuDPGEsIelhGcqGnuhtwU?=
 =?us-ascii?Q?ZWZBfybsTACBM4aY7XIQcdjP0koomYOzduy539QvyDcwfO1ZREtsk18OF+Y4?=
 =?us-ascii?Q?RECUo6FV7pny5JutsbCNQcfpeNTgMOMr/UX4pPG+G2fUw0Nz9vDcoXO1TQ8b?=
 =?us-ascii?Q?MGr9HBGVEir0VL1ALAWLtbUTLIXZtzARGoKV4iv1BH6NBAq2GULjO3Yb1Aao?=
 =?us-ascii?Q?qCPnCAloJ0XoLSv7ClzfQ9Yr+pB9hkLvAHY4jwCHzUy4H/1esTkKicQ8BSMf?=
 =?us-ascii?Q?CykDt5oEvk0nwmRuvm4NjV8emshKo24TSn46avNGuHux83NXmLObvo2lzhyE?=
 =?us-ascii?Q?dt0WWArBJHYjAruraocb8XJzyfPggpaMrObR1iokKEkDiQQLl7sJx7YYD3Pb?=
 =?us-ascii?Q?qO5brYPwUNtQU4/SVmYo1DCJer7fg0+TfeaYN5fjjYXckT4eWRBL9RaQR6ft?=
 =?us-ascii?Q?gu40vqCNGuzyG82pVJVpn25AljCYc7h7FS/sgn19Emcyrb5ysVfS26dlx3Mq?=
 =?us-ascii?Q?IGsJneJ1IPAgyfKrgqHVLvQyTEQoqOfmJbBI1hux/7dEdGyN9OtnVb+E5abr?=
 =?us-ascii?Q?esWG7sWJ+RYwomLce2y/fINHKUPA1PuftCwPj0XDGbK4K1HUb++q1Unzj2Hr?=
 =?us-ascii?Q?ZUvzZLtpkx9r2XKAXr9a/4kBp1oxbYKSg12qPQdIAd14/Z+DaC4mOl9/U++/?=
 =?us-ascii?Q?oeI17/lsrgwCKw0ETC3AgsgLxNKFAe9eeKupkb6JxlO8b9cz2uBFYfup8H4l?=
 =?us-ascii?Q?Xg9prU1YaXEhJUBLuPon46XDhzaqcDUuOcZq2WXzHPzSU5Nw7tvz9hKxx69u?=
 =?us-ascii?Q?E+HRcEjOrz4wJhbXm0NB3nbyXmo/mW5sgCEU4eildgOhlioQ0dS0zr0GQIJS?=
 =?us-ascii?Q?JcCBpQuy4ISKbB3fW+Q6el1HORaCrM8zW5l6+/zgg+6sorCxgwsIwwRtpTNp?=
 =?us-ascii?Q?UXtWfi3i5bWGoLwVujcQVTFyDDC9fa2LiL1eNwbM+eJa2U/JK9ouKmdbl74D?=
 =?us-ascii?Q?eYgVSQJi9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cc5cd1-3f00-43c7-c30e-08de909d5e69
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:51:10.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9Vp4pdmIVrff5zl9CwFKiU3+Ml3JDCTMlr4x6SLDMwG+euuA8AuZOJZVdZFvRZsK1kLliCm9kDuDyAFW9hS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a25e219832c..e60872aeeb49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie-ep@33800000 {
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

