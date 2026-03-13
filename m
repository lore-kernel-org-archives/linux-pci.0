Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9B33C1B9;
	Fri, 13 Mar 2026 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367731; cv=fail; b=pcWRITDXJuX+ngXRXgye1tiKzpzt+qUVRLzQcIFW9/kpuealOCeyUokUADK92rVCro+zsbP8n1j4BqBzBj8a4EjQUIYaswN/mb2o4WDFxP68clLHcmsubYrgwgnOB0WGsSHRnHUnzZ4G4tPziyw/BX6DFotmvIvbn6BJXA8lbNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367731; c=relaxed/simple;
	bh=g/mzX4X1VcTg/9UXn1FE9QtXpTv3LYjabJPq1eqvhqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k0wIY9JT+Cz3ne4UrEl36xhKkXRdvrBUjh1pJUeyhxyajAon3wu7btuyr3jPdFvHriuTUg2DL+JI4X30Z8xxpFUJL3CqF/YJvcI+Z3gY3OqglhjCQsseRCCfHZxaWZ/I2o0tfpHMEP/P7WnoMbW0CgwfltvgA11Rtrxtq9WPLMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T9o+qCxx; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9o+qCxx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hINg5rRTRpoLOiguaMEeyn+Wxaxtp15mZYCFefx3qL/6W+470XIsZz8AHCgM+i3jaVvs18J8ymlYIvBSaRiv+1YWliXGL8/STPjKWIpy4KxWdbOQC92dgqz8yq4t6WCQz8LQQrU15lV+xfMCiejoALrGDNW6JmRsAYyL9pKrxvDSIjKGMJldrP9freOq6IhvFg7l8uWzUUeRff+g6Za+eUg3Ua4yLBN/XHA4QUrAEvQOEn53cU1KuVjixhWC2Fsj4sLMKivwPpEawWDHX9qiMjy0gfl4SLdmispiaOKVdkkG7oHo6wRZVq6O8tK+WEE0e5xoSAYXShlWqdDOAtOrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIIaGc3NQm5K2GQaqJlfdAuQ3HYw6MiTjImMeGcKclU=;
 b=ZXSoAZhQ8YRL9qpJ94Fp3CAtIDNsW1yJ67QjqQOBr+8+gfsD78S1HvdmGgXGo/9LyPIE6wFwEVsLOLZsW40wyOMKCyToNATtcVBIqLooWdS3ofwy8VF11PlYWx+uDblnTLip0IRKUE9xGaeQWwHD53qKuQy3vCeQf+juthtqTXDiOoGk8+y6NaEAN15awJpFPXjYFaq9kYRS/ULG9owVaeMjHs4vpRwFFaBDP1Khika+6nv5087rGyLbYNFGVyRy6WZdowFgUP656qV562gakOQF67u93wgefZPjYqxYrddHUoMRGW27IsmmB2J9uDN4/rg/S8Gm2l55HX/wg+uLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIIaGc3NQm5K2GQaqJlfdAuQ3HYw6MiTjImMeGcKclU=;
 b=T9o+qCxxG87ykNMJczZP67vxrEmY/NGlh8vFTrUVitRO1dnSTOX4X2Qfzo0LxRwcjvYOMm1o1LJybO8ARsNcK5iQvZeM9JDAvkcUKcB6vCj3rfM45Ku1JH6e2Bp+h57DAYHqezipUkhJ5g00Fi5nsqqzEpI7hQdN7kwGvYsOqvlf58Mg+XcD/YvYZkxqWZBYPT6n/zCdlM80l5tIkYIVvg2GpxS3UZY8Zsip4EDis+nJ5Ko8JhxqfRiQFl2qQJdecyMOjVkanbotqBS1O30MM+1G/cchXrc5zntmfWq5dWJQbEZR6+N66el7TbDQkCxAQ6+SXoucU+Ve0L6XjBEQ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:33 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:46 +0000
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
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 10/13] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:20 +0800
Message-Id: <20260313020823.1592389-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: e367db63-4536-450f-a066-08de80a575cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aXk6jEYJgmkouwPSD1oAmcm2LvKvEoeFWeeBoh03CoqAx50w0pnHwQBlFPwFMtRrp8CmDlS0kZLZckR8xfaYfXC9Tx8IOBJPprD5KPdZkl3vS53w3XcbDk3bMpJCZ8Aa1SBEkpBt9z2ubh65TKk9bA95mHM5zqjTIxoX1rgyzwBQWm+DvxTwPHqqOmf5qAntdhZAx+SuYRinldOpMuVAywvBU6waa9XeMdmr1gYsQKnZzrb3jnLuOLoVQw2+oaDlbh5CMgt1BvenHlljY9m/PCLRk4VOnQMtiDvIJT9r5CE31h5A4CQM1vSu4JoEXXzMlFQsOmjxoSmCABssG7au4icuwAQOPcg8YCrrWxYNCo2tXNsi7XQC0njZ0/ujfMA7nx3Ft3L3AFwNHddvW0cDD9l7V16udx5p2xXrrXugfza4Pyvq89Fm86YjK1N2rb1TvAZnjhe9CRPVFdHB+xoG9EJX17491jX/48xX66R23W5E2eu7b5yL3XcIwj4s4fTI5OvMo9InSz9WirjlolDGEBpc9Ye1eR3z1IwYqXw+9hstv08bTxUXvwSwyl85nnYC1h8kYmSvODlYbyqkdjQ33YryUmBYtnYAFojdv6m0CfzqbT5NU38M5wWdG8XgUMiE956O/9jOAWlLmIjA+t7Kd9hXwzfY4cyLpVj28xLxnV2lgRojg53U83dp61wL4ojPSa8cK8YRHORzhmmW175lsunt+vm8F1FgBk6UoldIPBBdPl2UVUbf9YMR6NK9lH5LYF1cMb0qO4D1A1zlBcK+HwNWYluguznIVRVwO6mscw94THNqlSdFcMWMkLq1h+tv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PP5fjEKpjsMEuTgy4QF/lr/FH035C2f+c0OgUE4XZLtCvVpYariOi0oL4qH+?=
 =?us-ascii?Q?L4NwnZE7++pqX17WwuJhOkV2AuoNapONT5+LgxaUGFntMUWKADGK1NhjBwvr?=
 =?us-ascii?Q?zb1UWd6sRE5vl8WJHDfUsSWdVIZ8UufHJiBXtNn9Yiq8NVk79WCOwuZwqdRo?=
 =?us-ascii?Q?4oKQSaRe7ujP3i4JRs497PzSr86zL7FEYDFS49WgQO8AWe0aQq81UtEXNvyr?=
 =?us-ascii?Q?Tc4Nu0l0lRqaJ0Kc5nvizrVbaBPtUz7f9CCe4/Qr96q6mG9gUPXL3I3MLBjB?=
 =?us-ascii?Q?s7RoERitRJa9wQxCz2M1ENRC1pMB5XcTKq2PsXBCcTsSZ7tDtPbtrnd5ZOmz?=
 =?us-ascii?Q?cmr/reE1G4rG2oq9B51hZxpTp2KEU2fd39gQG4V2nKpy6wsEkgw1Afb138zO?=
 =?us-ascii?Q?9VXcQgMZ/KYAh5rpgYNG3qwnHYzVY1CycoG17F5Oz845E35Sf+vSyXAZbvo1?=
 =?us-ascii?Q?tiqBaj4zUJgToWAMbGWVLHMLQqzMO3yJ8LHZY9QVc0924PBwR3ZVUGo9/H5B?=
 =?us-ascii?Q?dPhfBiBAM/ejDXLxnmWGMF6rPVJpYjkskK4q3AOVwENYFVHgYb6JZcWnWWPc?=
 =?us-ascii?Q?+4eEfe0XDOhLj1yTJMmNmNtgJgoZQ8+9h5t4u6RQEjTwlvBnWlVw6JCXlZTg?=
 =?us-ascii?Q?FnPb8e8jhdldvmMEg9R3P0Z/YbzdnNgKJWW6k65baURoiLbI0SR4kwhtKkLe?=
 =?us-ascii?Q?TnGbVemxfdnBbaErw5soMCk+tnvV/XcP1ZT2zxWwfwkF3sQ8nmhJSaATKe3L?=
 =?us-ascii?Q?9UaIHMNk44FZM2dXjYC2O7KMjpky8qh6hA+pxXYwh5ciC7v4hmWCzT59Wy5c?=
 =?us-ascii?Q?qOmGoKXXVvwsDI6FRqIySIPQU4l955+na6RWT2SUuLVNolhchQ4+0RIyuLA1?=
 =?us-ascii?Q?adtrb3E5U1R+w++I7EAacy4XmGc/ysHfhxRQcBDoCdsA4LIfNGNGDn7k1RRm?=
 =?us-ascii?Q?xGPZh8dJlkVjQrKRgNOS6ZpWG0oizm4i7/I2Pap5rpIMzH+A3cCRCCe0LsNm?=
 =?us-ascii?Q?CuvoazbRqZvWGtZZE3BvAjf0PF0jXaVUBe4eMpKW9z0iKSKrtraqylmYJXBZ?=
 =?us-ascii?Q?TCTj+OjMNNN3aqGVD/80lq/IStdnYhar5XMFe3tbTEShb0xbk3xkI72Bw7AL?=
 =?us-ascii?Q?P4CJMTggB4dq2L1QCCHGRbjbZpAPPZNGNQfbDEVLPhrIAcsZyEAxOaRVzcew?=
 =?us-ascii?Q?o9QtTL5Crmlj1PuMLL2Rq/At5jh9kArIWvaF6DKH/YVEt0JzD881o5Z3JpjJ?=
 =?us-ascii?Q?7xqjQh9EMPL0jEPwCC/sX5aO1hrwTUF6bh7KlMUvdv53Mu/Uf+9/jc7KYnN7?=
 =?us-ascii?Q?+9yjxEd7EB1xEd9BoVIQ4mUVFsTkOwENv1+MwNJJAC2LmL0wLGBSzdvUNOWG?=
 =?us-ascii?Q?7QTPFnZ0Ls5l0NFmyfyNS3sfP7WkT8tpAQnlKxan0szUZpAdQiT/xjnAA0FG?=
 =?us-ascii?Q?KM3vrvZSgvEPlOyUn7OM7nQf5nLppupWC8lqGOBQNYHlXIPoToX1l4/H0tib?=
 =?us-ascii?Q?7lZ5wAnGe8pAOPm8BjzejfKvn+xn1QkS3MQeEQmEjE9bwySRhVU9oSNjXd0y?=
 =?us-ascii?Q?sJVob0S+VqS/9rjp1ZKFmADJeI/e+r4HlMS7mnvkl3ad84IcSAErtPLmt7It?=
 =?us-ascii?Q?jTGVX6WECJ+rjuSfIsn6cgL8so8rAHTPJRjZkv2O5Vg0jr1l+3yDV/+tF3xq?=
 =?us-ascii?Q?HqtiOiF/uGHtf8OH5+GDuQSxTvgJs0DqEBRW2QrJ/uQ1tDjxhdlB5sf55BFz?=
 =?us-ascii?Q?dhP8hGHzWA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e367db63-4536-450f-a066-08de80a575cb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:46.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5SrGSIImLJeujHjf57At+nGfvu2eoxpIn2Jtx7WWsd9Qn5t9vGAj/ls+JR2TeK8hYkQzoNLIccZOS4Ffua49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

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
index aedc09937716..9bdc8d000d2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -769,6 +769,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -782,6 +783,10 @@ &pcie0_ep {
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
index 9b2b3a9bf9e8..f66667735a02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2266,6 +2266,17 @@ pcie0: pcie: pcie@33800000 {
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

