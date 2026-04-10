Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2B1E2614;
	Fri, 10 Apr 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788215; cv=fail; b=cgdpgi9Y4kcafkhZaPrtiIRP5WrWZ+tS3qukLDhEI+3vuEqqZatRwI40hmFgQd01x56bLzeWNNxB7ZkSsx7YFvkbsPxEY3B/htXBdBXcInjlIbQFh593wHrSPGGI3kRxC9DkwnzlFAnROgsXcV98QoqxHx+o3H5HyZmd7PcYJjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788215; c=relaxed/simple;
	bh=A6iRAkqRTnQwRrqLsS8rJAbdrZY3jnB8fB01H7L3KCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipMQ9UpgZ5/9NIo4Wh1bcxpQA/3QJswVCbh9ZJVTOEw0vaNlJWYRfbMELgSTqPd98Z5XPddx55EIO2XWGjxvgF6yplPG7JCn5WP15yHWVpmLinVA4uLnYBHm4WO1DT3FXAl5umj+Mt7KryR6tISavselfwYvcL3JLPYUQ7pG39Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8y3ZB37; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8y3ZB37"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE9OfI6FjXq2QNxWrBPERZGEzPFRN5Syl6t1LlReuDd5RbttIUzUKn40eoHjnq0UhEcSiA3hreD4x497y2sdRZ+dFLb1CMtI85vgAgUajoE3t7YKaKHiiWOfwXxdhfV7fD7AWueWsOtVR1/P3WKyC9RRrcA81H/dlP7fHdbueWwlRhkHYV/mTvfrQOPGK1Cii1Yii31GTGw2A3MXM/vpnJnrsfcRMinIQmpNlgOGYikypNxWj7PPihCK1R7oSevwdQNdzD4Y9OnOqepXFYAkqnAKAMp4JLpPjxClCWYdvZos2kJT3pO4POUYa7y2Yj0AwUxyfLHfjGSHyQ6VP+hKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=e5Aia+R8klBEbAA2AaYngun6YvzwihdjTSMN0khEs5P9qMHw/2A8r+LSzWwdEfSWiYtB+1uFP80KFRUhVuSVTSo4ziNFxBKrQs+vpfLD5fF4udF+ZJMVQI5O0PbCTcdDLktRYi2MDte1K5oJFaV9lQyI6IUOh2mwLyxQgdCAhEq4SBYXGBUO4ZGToOQCD2P+KmcvLfeC3qvY0AjvVb5DK5jdO+TvKxQZ51FO42eaDfLGwiOLndMxdZaQQVS9x+mkUkNhbAtNQrUvU9JLVAff3Om5TiZK79ctM8HImSkF+I4+xZikKg+UssDJPop3Eb09LepozJw8or5y6ARjB/4Vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=k8y3ZB37np9VdJZRGEpavfp8zyrYeIFlWQLW+uTVOqOIvBD20c6hGc6EnppJwbjodY7khYxqSYYj/uYH/DpqFK0U6WbQ1loVIqUU3ZoatpWIjlRlsc86z4Hwf+iTPacT97ieW+kyXAC7EefahaOa+ZJYzGqjcMYd6v1gf84RZrpQaFei4GRbPyuVHgAnG5FCkLjb2Nj3DlO4SAi8CrDJjDV5EBFQgN0MesZCwl2nEQWX6ZoOpfoCSPROhONYHAvXKZXntmn8DPe5d1kvIj01PNn2ZqP+2kO7e7mzHf+ElOlBjYlcCwprOzPuaHWymyIZJrbD7pAu5r9wDIJoHe6xsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:11 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:11 +0000
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
Subject: [PATCH V12 06/12] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:49 +0800
Message-Id: <20260410023055.2439146-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: aa928aa2-c949-4ea1-b4b6-08de96a916e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uP5UY31DCjk1JsKofmGkKNduz9g+R+APC8mQKSA2FEb31aQSqg3xmGBlMbh9qP5392lpKE52qJHD3pWJbtRIsLbGvyOT+523YI+RE7zg0PN3rWMlKVe8fJo5+k05EfTRJgQMPzE397NvFCb+k5XalpINKHfyJhvxgNVQgCU6nB1R/NsKXZ/cLeQAskDFwz+5fhClqB4wnuA1mjK0YIQe5u7ZsZ/eOem4encnjtCv+X5RSh4MprWco+WXFJY69eDE0pTotyJ8M0/1QfAiHOGMg5Ms/bN9NJsMPP0YF7Urot0o2/SFDemRml7Jo+UFRJLe5iESFWIvs8Os9KwgokOp+rl5P+VknMKrcBLmF7qk8CV/Z4MB3lltTG1H2l56tbHMHp322LlaVuPs69wYKSUtL/a2LK3Q/DUu88hyyJMkbbApzXZJTMSpwwV/LempZqt9RKS1C+VR9PRxYZHAh/IMTZcQG26Y4QGFme+lKIl2IPbBukBiozbVrxDQJMrpjln7HI3i4M5HkdSGjDqkj6ALVUzG0Xfbi7zRqlr8tELuUb5B9+GkiCq4CuDQGKOvvznyOmMzHHHeB81HOomIyufX7hlteO526FbIGNqzPYbvWut4nFdetu7+zDT8LsXFLUZ/Beh/XfWXr1v5vSwOkT2ovWFX3PY+oYyZYlS3tJvQd7PsvvxPVSl0l4S8VG/VJeklR3PDFSFOwdrOAj0lDEisvsMYy4J7u/1ZD5cNOYy6iKSFHMxvuEvSLcNfcj7LiA9jIcOfNrF10YGagWSthbRmmwsbpp6f+W/LCyF4o0DSPKRYBEQpVkbU6l02pvabGoFp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h7SQSPEVneyaYanXvPLfK17QuBfQ1zT5e7OP0gaWRr2Em0dF5l24Jnd2GVG8?=
 =?us-ascii?Q?BQCHqTj6hDG+2F639V0WZTCnhvkF7usShxaXa1V9k08jRXh4LeqGYN6rwGx5?=
 =?us-ascii?Q?J60q0+VUGQ/0bLVT5E1L40kLisuhFcql+XYczVLhi1dt4cOcmzXKmO0C5ms+?=
 =?us-ascii?Q?xw1BMp7BnR6ueM7iIMbyCXhAUJMvyq5MwS/fEnAXlad+vEWmNZAardtyM8E6?=
 =?us-ascii?Q?IvzzZGObZCvOg11vO/PoDYIkCrcQihiEoif6ISnCaud/j9AS62s2sABK/7EM?=
 =?us-ascii?Q?CqKub1G6oOCNX+d42WxSbHWKuX4Bsf4FTzyV4zUQ6ZVskSTtlYGJAfia8ESd?=
 =?us-ascii?Q?4WSS9rR9Vln7bYUZJOWhkZSbL+CQH3+srqQM4sVkyQjJioaIxhVIcbmATuDz?=
 =?us-ascii?Q?hFA5MTVyR+6Is1XZ9VnjGWExs8kMkyPc8KAJWOMIrWgUaBcAzr1c3WLvwRQH?=
 =?us-ascii?Q?gsReTAXuZ9aGW7J1861L55f6uYVyxGjj/c19NOMgE7OpYIFOsHKubNexRr3c?=
 =?us-ascii?Q?3bXmtES6F8Ber5qHDbI0KvM7zxMImWMrBYh4iVHrbKqudYJeQJ6rbZNnBULS?=
 =?us-ascii?Q?hAnDRID+jx8Q4ywOBx0yCpJ3rXf6cjslKBTjyxb8H2yOWtdEkV8ZX6ai7Vnk?=
 =?us-ascii?Q?yIJpunErzAbXs0gRvEfgLNuoIPLDxn9zgwZgedWAmpMfLZJSQoF89AxG8fFq?=
 =?us-ascii?Q?yUCYfq7LWpPbu10+veprrvelguAnF66F7h9o5PIm0BRp79DaE1Qen2AZcp+i?=
 =?us-ascii?Q?LoVfiNq4rVLcdyg/tydmeXbZYhBc7JtXjCNeMxfOx8qZ6Jzg5Sb+GUDEl3uJ?=
 =?us-ascii?Q?t2ASKuCMhWsh5ebg2kowMpkLMV2cubDoDdTlq0BYLFGJttWAenIoW4fWuu5U?=
 =?us-ascii?Q?DgZiiBWGjdS8L1NgLdFBaSRQNDHE3aS9brHc5v+d91SM9uY067c3C6v+ahpV?=
 =?us-ascii?Q?cv3ITiseASIdNS51hA+y78c/goYI/K/C0MtwgvNSdW/zRymCO6eSgaZhLZZd?=
 =?us-ascii?Q?1VjeuCGdRg3yLqBRpve8ixL1/retN1+CDd2Y2Q03doaKKLOOGygp+/WCMGGT?=
 =?us-ascii?Q?uz/1brq1uxWhviY7Hqfr+LRJ2J/PWARywPciP0LdV5h4ldmpUrSSu4b6pWsx?=
 =?us-ascii?Q?C6QSFAX2n0roeGa+IESfMAML+Wiokv3BPMQUZNQi7bAO/ztsUX+5qxrhiVam?=
 =?us-ascii?Q?tQtLkfcePzdTN6dJSbGAc/79liEUksqzxmgzKwcEX2LxPHSqXmeFqUTB4xYS?=
 =?us-ascii?Q?Vmru2jGvb0m02gToUHoGrR9Z/fy74sujKGLNH0wHebG/Y2LZLlMnTu/F5pWi?=
 =?us-ascii?Q?n402wMoB5KrYgCXRpeSbLdYOiQkUSY0Op5gLawRuQjuTQdGVvimPoy0htm+k?=
 =?us-ascii?Q?fWK2W2TCBFs801sE30q5E7FbytfLHwAggW++dqJV9tOx/6UFeaVALPUNKJY4?=
 =?us-ascii?Q?6Q824Xi2hEQ5caHKlTBpG/3ld7sUSjWnDaYXFGlREBtJKKEV7iPZw2Csfc7f?=
 =?us-ascii?Q?dR0d097cv6Co47g1w0+B/5DXE0RxFkJPHlO+yCd8aS0lDad5C/l6/wEGlkb0?=
 =?us-ascii?Q?A67GKXWNGblvcB1bzhE5ZVuL9g8huee/yBpubMcD6NUFVM8tVlYmEt2Ysi8G?=
 =?us-ascii?Q?J73EtR7xQJCM9YMT9Kr6nKiF/xa4/o/SgwtcDTSQKWG6xvWV6KQEUznsZSAx?=
 =?us-ascii?Q?v+KQSxhN4mKTzPTYkx8SzySKRfH/w4AyHDBA8jwMlND7/iG86VmtmPj+aqFO?=
 =?us-ascii?Q?9U7g4ccCDg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa928aa2-c949-4ea1-b4b6-08de96a916e6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:11.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ykhNT3UgWOzbv+w5Jh7WqJfAuxSAy2O7g4JEcfpNk3iG0r692aA86EhHHzsoc8piFAx5Gb8UhC7ZSyz4ayUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..338de4d144b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,16 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index aefae5a3a6be..5484c398aa37 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 	};
 };
-- 
2.37.1

