Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7F26AE5;
	Wed, 22 Apr 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850508; cv=fail; b=RoIUFjP+0rVH09AljEpTyB5NtaWEgvjwHoFNRbj5z0KFfheLoglojXkyBinzMJDc6XJLAwwgaL/EYlNANjK1lW0gLHjDHNFzdh+E57DEEYBeXdkXlzsktncjnBby1V2rqo7RNdIe0fx2WyqSZCCsfpjvNltcvmVVOTAaNcCIzPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850508; c=relaxed/simple;
	bh=p3VWd4Zk987X87jiTogJXJ5Nf/4FV/Sb9DSkzZu+rrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLNng9vv07BqWL9h/yG1iARfklLkZP2zqZ3dgXAFlNlfuWDWtac1/wt6Qj2dCT9rKhl/+LnIxzJClDlZqIXajz3BRLHj8fEwg/TGy9EUpNXTwaTvejQUuEBPxghGyMVQW3+cpaWD+V3xgN/fGdYFpdIHZK3d4XpUbQUNPBMWfhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AMWyqrPK; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMWyqrPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUDR1RY57Z5/b9I+dUOkyuiA+9VvPyxOH21ZIcvjnRmCZkSdpM7iMiQYjITZZ8C6qUZo9M9SJ2Z5cjNZNZMt9dekF+KI2dKFrXVaegmuUU+DyxGHT+zFXbpoD5+Uu2ldO/QaAya/6DrOe0ZkFRWsyV57FKVKTd5WdHb/EtQt1y3H8HqGjxLkWZZb15dv2bwY6dBRsRzN3wsEpsqmP/Z1/fzSubhF/r+OT+ix5AnWVfeYHOAbNFd7aKB9X9Hg5Zy+LGSdpQJazmMMyN+GAV7PGO+PSsEqHfDVbJXr9PeDDqzBMEiJGR4ges0xlP8Sy7sjqudnA6QWvv8Or0etN1h5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=u2ehFTK0FzXGQwIw2bzS59oN6ey5MeD2C+t+ecuX6iOWLfNo1N/lfmdYNjrRvDrmxr7/+xSX8mWUtAuiDXzUrn+TlwZ29otobc/Qq0hXvVORx2GP620RvjzyN/5dFVYF0OqKHuTLF1FuFUPAL/zQ9ZUd0gJLuAPxo+QxZ9OG62EtGpSEy7pNQq+7hPAjJgLrUdAGxSJx50NAyDAtW34akS7zcJ9ZpAdtUufI/XRRyQnt7EY1e/hWzMtk6Vjeyc0yuIrwb7ssXZAe+TC5+SvwRevnX2af/PL2xHN7qVrImcRNnqCoZJ0WNIEL7YEmYOBo00hqSQ3AkKXriA7F4kbhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnLsoxBtlKwwKIXSSpdqg/p60UkV42ewo5fGCfmOMXE=;
 b=AMWyqrPKHT7TRyYmZk/WLlcUzVaJwD7m6yxZ4M50qBYh3ahm5BHN6KIkDHbDXjczlVQ+x+kqV2GLknw0CLtTUtb2gCXIZrFMW/ml9gQNrb9wcDg7BqwZd9WCKLVDECBaHr1avrR5nB3Gzw7CV77SukZtOGxltnFkxA0A9pKqmMrGaiq4VAf18AEzi1KGfeaUSNiHhWFLwrkqcZV0buahznalEq9LmscMSwuUjPSZGCo1feX0RdqaVTvAvdFq8rZ646CHFTai98YfeF6ykigbWhSIp37GaZbl1y9jHxRgJE89obPDBAssBg8lHQzpudVgPHVK9Yh6Asv/HPQFC1B0pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:35:04 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:35:04 +0000
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
Subject: [PATCH V14 08/12] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:45 +0800
Message-Id: <20260422093549.407022-9-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c7042a4-19bb-42bf-5123-08dea0526ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	tz59wJILt5/UNQC4ILylKkNum0ztDnwAwED1CDR4kNsC1RH8mKa/bk8KdtEXTf6uxrm11mA59TnnQ52ysXIuLWbSDqs/y0BFexupJ6ULPxRxGwfxowdLGsv2gb2mG+qyWxWbSoXJR03IOcDw7E/rSjR+69SdCThBMzmO4bO+JGI9WPm9k5vvCxkp4gN2LH3iagwMdVhgkC8n/YsUgoiG86QIq+xA18pZ/8q+OuDKTVUYRkQVHWzTE0HlVWAam/pXpZykAWp/ja/LM/jRAZtDvpehBNSjBPDrnLL0BUsYB23q2PrOoJxwKq2wz8KPE+i73/2yvQjM0IqKflAW7akzMYZdw+wz2nn20qozD1ciGPrMn6yxPEvdXXJvTgnkOPvOJfWHldpxUbpcXHjs47HTYorlhtI0msBO9omJYOqVhoAqgthbRJPoDatLlHpMXH6Dmwnmrk5k9yUWFfcvyziyrtx3GPK/Bb37CV60ZXKf06hHfcjx1HFz3TRvCKFkhe2Qakow0tDdTnQKTmtZh+CbaIiSFvA+iETklKANskEhRcbvpeQGgN68UL9UBq8d1VAJFIGMSoL05exU3xqAN0Bgf2x7J1lb+Db4pzQLcVG6j/lJt+AtWMxGDpDnlnmswENtZ4EMuQ149cCzpGbtJeuK1svbvZYimN5jQtA/FrB4Yzc57sldUPVCh6zG95Xun6ciDnmkWZzi6ZHi2b1WNp8Y0o1Emc16mrxo0tz/cxT/JJ7jdAMBPM4g8IEyg5ooGF2xAwbsXM7ZU+wMnTRNuwxfzg98ABhAAIMvTbK3yBkgCG1r6MjIqkKCevQTtY/h/4xW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BFU06ufekowU+XNBDhggPvO8rQR4FYw9Odn3Fsus2qjqKYPrNBXskVM04Dfk?=
 =?us-ascii?Q?YZ5IsHmLVwSHg8xPxB2PGwfveucRN8iGB6LYf49sM7VzlKOY5U/EkGnQGtCw?=
 =?us-ascii?Q?ifZSs3zeX7BnIB0FBDWI6Ff3FMIBw9Q5Yo3kqX/YTLOOXlFIATjLg51MJddv?=
 =?us-ascii?Q?rCStXmU0ytsK75YCs4DGwNupsxfMyVPK+3R82hWSOPhR5COZ0F/q+KI4gqSZ?=
 =?us-ascii?Q?Ivk6k8R8c4rgXtJQccxMpeu0QrM1Htl7EWFXXtl65Do4jT7wJZJEfchm9SFw?=
 =?us-ascii?Q?59jA7xByI6obbuD9DBUuOuLUqsIsBcIsaXj+RW7Pb95xlxduxMC5ge6eR/d4?=
 =?us-ascii?Q?ZnqhqEBNQzLuDfCl2wFeebboZJCLfs5Rgu6ABPrzZvqGaXBxM7o5oxhop1iF?=
 =?us-ascii?Q?GiPA3cO5v3qYuq6G04wJ2+J1BryrDLrKrQlcOK8N+KoWD/v7oZ6yc2bRlEAl?=
 =?us-ascii?Q?i2f9vYIewry6AXwKcGJ8svDcHk6PjmyLfNfnWQSKBorIBS5pxteJisX2XHA8?=
 =?us-ascii?Q?+Pb0qnZAuwe8m4WUO8jFLfoA4gbnx4hbzey7LtCK/H7ygG1XgC1PwInN35+o?=
 =?us-ascii?Q?rpAhYrHW06vkOiHKTPz9KXPuwXRJorIcjGEnjXqeZwko4v2WWDflNjyRdLv/?=
 =?us-ascii?Q?0wJ12/89rEEPdP+qm9tVJtEmefiBqt0SjrwWpsSip3Cp/X+VFzxrI3gCUK1t?=
 =?us-ascii?Q?/kBqYDfb3IEDczpVRDlf7CJ9f4/NrlVu4CaeJVlUBEVSrkzit+e9w4IHR07F?=
 =?us-ascii?Q?rk2V/GlYAqsUg/2UwO5+9kqGQT/vU8leyacWbvCdyKVJ4xCxLDOquzqENA4V?=
 =?us-ascii?Q?pze4W0QnH4zXJ5YEYl+Ob16/hU0ongPMLpjm8Hb72Rq0p5aZXoXk0sqm5w5M?=
 =?us-ascii?Q?gC1KL5DGhRr4uf7XQjVn9t6GuNVjfgOgJQOnzlw84z2aVmpk5oyudLj10v3e?=
 =?us-ascii?Q?RkChH1+B5+6sIz+ImvEml9x/yZsMFTsgsJXhiP7EUBNhOVy+f66HcRiqEzqj?=
 =?us-ascii?Q?Neokro1Kbk+rFeEYnwRgmltHyFJ5e2wJSH/Cpj1EncWDmsyk23CRpu7+D7Up?=
 =?us-ascii?Q?jbyKOk3O2AT+opevHq2pilLHI2r85OSRjwLaCmX52ntbAs3daxZTC0FspgJa?=
 =?us-ascii?Q?1dwFtW81choJgM6KgijHgx/NDRnamopfHXdKFHM4y9ljMudqSsu+4rfa+L34?=
 =?us-ascii?Q?F51bzhZkAftS3DLc3DacRmEGlAIhWvgM3oGB274Jl/sfp6qx6dxZ/Nkj/An3?=
 =?us-ascii?Q?//avpLytxGOvkNi0x/6R15eJTFpr+mDN9Cr2AjkY29zd3ywsOAUmL4Bk50Uo?=
 =?us-ascii?Q?2nWG/ycd3UNyc3JKKwq6WRq+QJFdTc9W0cPlaRqgzS6uPSzkyGHQHJTjwF2x?=
 =?us-ascii?Q?eTf61euTS8WO/cROgfw0Gxxo+1pB5mPLvENQhHMa/hDA1wA9Hzzs6Vw39+7g?=
 =?us-ascii?Q?eDqS7ENbpFbshTaOUnnXlGONbtLCo++HMfp/N4lHTLIm0a0qrsyelFNa+DZ9?=
 =?us-ascii?Q?Q9rh/1dBZed8D7/+jizTzxughIUqy9uD9K/SfXMcFNrOTMi0E+BhlDdESSHn?=
 =?us-ascii?Q?iQnV/2SDdkZCPuQcGEYPbKxsX069U51V2mQAkFvoIgscuM7Ke52El6Bm5PJc?=
 =?us-ascii?Q?FMeGnOM4gqT8Y98cdxfdGGfaY6hwJyVx7v9DLFcZ6OO9yE1NbfcmIilpAobo?=
 =?us-ascii?Q?vSbGfQGXZj+aqFxNIGwQqw/00PZeEEqIn3LQuH3LVYcvZYHQuPuBZ4EekKh/?=
 =?us-ascii?Q?7QLRZa84TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7042a4-19bb-42bf-5123-08dea0526ec1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:35:04.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzssiJk7v0PiV7NXtAY2yHViPG6ICQW2/F8T/GYXJvPPPsAbFOs859QmbMFW5GWi3kEWAzq5uaicIxLSIsEyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4cc5ad01d0e2..5cf2998d396d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1370,6 +1370,17 @@ pcie0: pcie@33800000 {
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
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1

