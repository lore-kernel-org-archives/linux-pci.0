Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AF3AC0EF;
	Tue,  7 Apr 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558566; cv=fail; b=fERA9pRP6cRT46eTAS9LaQ6iIUAJNDtXfCl+RlrBrIDKmIQnGzpsStpVEftAd13sx+GyxLINdF/PMystGcyDrf/ylkV6DCjWQTEb/Ucrd+4Pjtbv8e55q3Thb/uNTWZQMxv0+vwMktgbEiq+A/fpS2QTy8klRjebZWDHKS5EHso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558566; c=relaxed/simple;
	bh=xzPgWC3CfkAwVk6V3+XedDsGclq2F+T1PYkPZp8gzu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oywcZt1X5/C4VtiqauD8V2tqTVaLwHivaqVbe7YXYqYJy2JYcn0CsWJUE8zdohRbzK7dRxrZYlnS/U9v0q6r2SSvyk3HYmyA7dwplsB/P1O1jPQY8neSodFIh3CWVwn8iCBBmj6Jx6gNuv4AXYKp0Rg7uDiS2NO5jr4Ve9nCQjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KO1Zeq+i; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KO1Zeq+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA8xCCDBBfatts58XAUVdqqslNEESK+g6O0cNNEMk4JN4HJu3402AsMjyGb80h0oRwJ46Yu41DvHOMJTzwKnQlscDpMVY+v9d5w3r99ofSmAHtQ1ilHw62CeXr7B51JRLxPwXdxW1qVLsnukwabuq+Z/1IzsSK7SFMYnsypo4bUSLhXOze6pBcZaeJG1WqnKtai4Qja4WkO+0SObiJvwea5My5c3iaxZNBqhpB6Vi5BSA/KcI42uAN5r2RffPoQw4SSKW45B5YAOaPLBB1cePJP2drv87NsiJsgdiV4IEmAc+mcU43xbCUvfi8XHmyKALj/WJ1VYKr7exKaowOq9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=oCYSVZw5ysEedl2VPSYfZ2rhVGwePl1NbsojXe1g8PMVB1yvTKMcojox0sdIkMtCHvM/McNuf+cBiQ/ly8ZfCoG21WV12WmlKv8Qx44Rubgy8xUhEYn2ejOkSbv4RXSrDnWXFDX8E9xq/BUwUeq50Ldxo2XHBnlZ8GVUPSNp44wz8yUkzUPbgigKyagnVIvHi2eQPIHYMUwpZnkndJzjr4esj4WJZftxrUddVKgZkeg0LiVSNc+6++7QKyKsPoTWF0HEwp01EarZkqJ28UxA7zXQnxhtcTqC9lBJXAStSNjrXNbY0IV+b8cy2HMSa8pI4/4oR/vYHTE4clXDvQ3alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=KO1Zeq+i9/BCxGwYWztyjtO7hIJs/Ttqh0OrFLJ2efk9BXa4Lp816uDZEDtEsxJ0M25A1MM69glezUTKORamC7VYCQHc1Yvyf6tyoWdlGgMBCw/+C2Y8oKOmPLQSjiv+bgJMLOtQbuD5OhUr3v1Cpbs9vG/vOpRursAQEJWDFhLf82Y79k9q6sQOh8dhIW6GArFHxvFbOorDOHprASGFD0la9E0hYywObjfWYpSxwHs2QiIv1kPxSV7awKBD/+QU+lTULHSZMymobRsCZNxEWA20/m7IbIGVXFb7EtkubOElFTedvmspuSQdQkaqxpkUMMOgmXzLWaHKbpjI9qTyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:40 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:40 +0000
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
Subject: [PATCH V11 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Tue,  7 Apr 2026 18:41:51 +0800
Message-Id: <20260407104154.2842132-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 52842d84-f32c-495b-81d4-08de9492644a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zp6VQHzjH6UFhoJ3CZshZLz8LorbyOo4qMyBY+qbO3cPVTrME/KVy8/i75fxx9OlIz0TYpITxG9YBTKJtPtrSQD9dWaFcLp3FQbCLferXaZ4wDCHlXs1F4449zXn6s9XZg+1AeK2g48xR0C3Mlo4r5XeWVB0Tey1O/IHsDqxioeEweI1ruDe8432kRw7Tn1cUksZcvMKoCBfWbnjBTHtQ8FtSmcVhmlBggMHQtDArr+I3LsVHhExOQHhkwV0+CJSzIgbCOnxkwUwy7JqFudj/w20kxhY85qQxZXAkT2nRGQZoRQGr0qP7+fMhCKsmtMhCOQ/zTmBC8G+Vhow/g9h0HZk+9pKvfbf96UJ+/INlVhDG1cdprQ3rpt7OOgwJsgB44NdvKYh/Nm6guuEn0o30GGvcRO/FX54ttKKqNQvyny2VZw4GrvkBNpnD2T+kMnP+Ypufqec5H05W62ZaeuSF9dvB1SG3vLj+QUj3w8ahB7K1oep9M+BTypzZKlPMb+2SkIITpoB4llyrdwlchPUEMrBLZe5syaWauI0DHpzwZnGB7fH3qxelqzMtNcMgqdrZToUi7efRwteo/9nEelT/bpeDI2aUPaSIW4QLSJBGtMXbfPaGNU/FAzwQ84gUEwcufynnznqNZPe3U0UZEQn8WyuZGisPVIcCRyxgEERB2hXmFn9jq78PhC7NwPev8FBjrFE+gWmnl1GEw7n8lfS+3xxUpEoMzK0s+jYIkSfWoSyxT7Y4r/66Sy6j+UMlzUayDxE22XkCnAdepGFapVWGP4XQ6NgLX5eSkw3rBczK1RV768B98wC1gjorfcM3Red
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vePGYGK//fZwaXXThBYhLrFwfqa39NSDrKCtNwbSWzy8tV94pcwqUjdzIUBh?=
 =?us-ascii?Q?6QJAyRTbG/KiEroTOWZ7x5yHU6XXQHH4qZtx0aamEaKqE+ZqhHtN5Nc4qsAS?=
 =?us-ascii?Q?4qjyzfNokRELXNb4vTKYZh8E6JiA9i79C6GTG9im+wkpESDTsQkHkHEtxMoj?=
 =?us-ascii?Q?X4gUOkhxjVoGTcVnPKABxTexYpBbF+jVdLPTNGb/YSFA1HsQyWnmc8FQgC49?=
 =?us-ascii?Q?9WPbm4Igtv+BsjMw4ogfXFTWFSlSjIRRSIybQcFd7BDKE7Lghh+E3v5OYyyz?=
 =?us-ascii?Q?0qxgp6CFt0Nnk0VehFjELjGStDoAt0KbJ/SHFKRxDyl8dntx+fcrPOCPO89O?=
 =?us-ascii?Q?/9Pf/Na2f7JC4cIE2CVruKGmLT+ItEScqDgzV1dy7x3rfK23IRCkyMoW+Wdy?=
 =?us-ascii?Q?t9B3Ysgxw+lgiU6qRgWeLxMtHRp2Lm4l2ZcKPZTjw7csojjJm3ZwOe+OatPw?=
 =?us-ascii?Q?i6NUVDeBijXum9DFSgRNw6YypNUeYMbuv9CuYj6OD3afIybgazeUqm80uTSi?=
 =?us-ascii?Q?eM4u5fzL8ub+0C7DdioRmky9Qk0tEB6JyFayjygIACzCygAK9woaqt8ZBh0P?=
 =?us-ascii?Q?ycK9y1GwFtHEsW9qxtXVe6Vn24+NB/AiaRJBQ85YczC7sfL2SGg3yLjwP7bB?=
 =?us-ascii?Q?jtHrvrxSaDHzgohwqBAXqWFVr0qwPCyvgTiMaQtvaZCungLsbE226imXdGcB?=
 =?us-ascii?Q?uIzgaB53aq90Yp58+37+XCyCeS0AliKJiiTthIG+39s0sLZJ1g8csCH6KOol?=
 =?us-ascii?Q?qQEllpAGiGXeD1ReelojCxzPs+4RExxH4FiuzPrt0TLeQTokjaAYG9ShsK7M?=
 =?us-ascii?Q?vobKNhT0KaclErzYp/V8Vc1VvXVovE5LNs9441v6FzfN3fZ4389DbbGTNn42?=
 =?us-ascii?Q?JAiiH+HcoyFavJPoTZTEEfQgGT7bFPbqPgl23H0nHE2CW5yLIdRe6R4zUsSe?=
 =?us-ascii?Q?uHeNqvFrc9q+GKWFU7KFt1wQS0CjmlwusArL6vh3T35Sadgw2xRnex3R9y/2?=
 =?us-ascii?Q?u6X/pFYDCXPv3QIKKo+lQIaey//z834qoIr5W+AYRA75pPb2XuE7vWkc0A6Y?=
 =?us-ascii?Q?fqbNITne03Ws5ABfGfA4/99du+s89JjT9F7LO9xU1y7Xt3GfVDWQTy4r7rdE?=
 =?us-ascii?Q?BVEJOK4RZNzHwGXIin+pL7q582SoPH/xe/bXvAeQUgSSpqo76lUlEVS8rYfo?=
 =?us-ascii?Q?IJlEz1ub4r1TXlUndQJZzeilbLzceW8ZKymG52Dg7JE5T1eJ8Broc+8ZmuoB?=
 =?us-ascii?Q?fzV7+qB/37E5N3Mw/zvfH4Befi3I/8YDUHtDxJ4o8ia8IszCFeQXl/oS3qyo?=
 =?us-ascii?Q?9+IV6W5RAUsYs4FM59SfauI15KRZRNlPhfldw8veHYytXswvIhAXu7Xhl0YP?=
 =?us-ascii?Q?oacGfVi8M86y/jaOtKLG4i2U0dN2BGt4DgHcSyhfAl7oPTJa0i1M3MHbs4sE?=
 =?us-ascii?Q?UBfXHmfP3cWgpHsdt1lEu2cQmS/7KT2pF1jBgeBiTJAQkoI6gxQvfkjU+wMc?=
 =?us-ascii?Q?nH/szxYduh3vIIlGGkulsuZHrXN+mwSN5kT7xXM+v8dTtYZo2+YlAwkggvO9?=
 =?us-ascii?Q?2VaUgmt7F7EiorlG33Fy1jn+z05PaUlpytGBRTPQsSC0ZOgsS48DR7hWIYDQ?=
 =?us-ascii?Q?yWM6SLZsYa/pigAFbTFlLDA0dakcFP9aZKjjLrgMAs45/zu+cCxwS0aYtSEA?=
 =?us-ascii?Q?T4BUfxwAGMI79gsM+a2nZQyv/hhDkVf21XbXAQbZPyryhOKxqjsHFqOTnNbP?=
 =?us-ascii?Q?bATHSI8aqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52842d84-f32c-495b-81d4-08de9492644a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:40.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roIT9QBuP8ncvR6eFijMwG+3Nl67j8G0bQuIkMegWeNeC5KL45fzS+idu+x8sC/bxWgHG+ZC3jyVza1ACPlhEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 2feb5b18645c..a7f3acdc36d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -770,6 +770,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -783,6 +784,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 90d7bb8f5619..5ce2825182fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2265,6 +2265,17 @@ pcie0: pcie: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
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
 
 		pcie0_ep: pcie_ep: pcie-ep@33800000 {
-- 
2.37.1

