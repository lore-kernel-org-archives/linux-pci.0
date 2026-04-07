Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB63AC0F2;
	Tue,  7 Apr 2026 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558583; cv=fail; b=mfO0mM12a3De5hHBZWZYDIQ9pkRaXbqwNbqfXHmwiRllFCMKsgQd/n5Lhc9HovfNd6wjyXFu+G36wzhFEt6MefY4JSGgeH+NkwMhzz+Mv0yMk7QOMz6nyTW6CcUkJVmM/mSI9F7pw9m4vm0IkWDhNtR4gdGigDGDiJR9F3u5+1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558583; c=relaxed/simple;
	bh=qenzXLklhHlqYAtsHgiZ91iUxT0DbrT62hGAnMX5908=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZJPxpF8VTFM+uw7dvoQvDlEM7WUSCM1vkEWcXDX2USS9DhqJUJnpzntDZW+IiQU+KhyGOaM1EFsya9SsgxT9TyPhGBHFmB0ekCH1yYigtsSyoRoo2vhRywlP//OJ0kVQws7RZ/w4IvS24ro/tIzuETNfGJQBobrlG9D6k2xXkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=al+TjRl9; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="al+TjRl9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkEMSL6zBOk30L2QvZ6JolhkkzxoR0jjeTrqItvyyO8lppMWNp+bJVlCViA8Y6jHdY7RsAFnJn7+6yCMulDxF2vj7mhmCF8RTEr0WivKG9y8gvf0xwrwL2WYN5La3EDKdm79ckshlm9t5BdxEP5X4YMXYF9zOom9tsPjFV6lfvKnodQbAeZ4MUR06sNk6mzMBTDTSGon/kytEgtxmIqCHaElhuK/O0hIngve4kqS8hZhe/cZV7Zu/VTMEftYFeOn4CZFfZgVHXRC+51ln3kQijMSGJBj0S0pCYzxYj1hCvhNvCXQeB6vAKe2Q4yDLeNS7Q9DMwyB+6PMUK0a2RSfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=E2IwaK4E7jFqgvYqKddecXU/qKc5gwgZYUmYZLdOclhRot21WnoBmArpuwJC6/ToesTTmfeuu65ddKuP0XUGd9ZV2jLPI3qCDiupE4ND86c4AJ0H1eMDwzzCNElDiIFxHIMYZ2He/kwDcLtcGh42qAmW5hjx4Q4xYuXet3eTufoUzEsOQXaudO7bceG9kX8F/WZJtb8U1OS508P2aU2AnDPlrPw5SieGTaGkAsuePQmChhoAMkMaZ6dhDCsawAvLLvqB13N8Ce71GoW6XGzYWthHUrEFPGLvIB9NeJmEq/sdY3BqxbGrbVPIDBmM2UeBrRhDpS5XobQRGjrswRBXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=al+TjRl9YDr0QBBoCPumWF8m1oYTEA3oomZv5BPuv+cKUxXnSXQ1MkyQ2v5zm+VFu60kCC0xkeeDKT9tSnReNK1RhttMl7Kta/rWOT+LZvQyc39fsuVZGdiglFay64aUls4RsUq4CL60w0aMJhynHut5iN1AorUanu5vywvn/CJLyHT9brT6Hr+G+o7D7qvGqV8eY8NC0LMW8hQgKZuAwBnacPefYclsGePuuRs7fnN/sAO0GErb770/iVOb4UEncEY8sr5lgwiDdYLmLDMYfkUhQHzg10+Zrwsl4jAUfT//zcQHWRORwRMXcrlK6hPfWZjiHGSptQsEysg1++bEFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:59 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:59 +0000
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
Subject: [PATCH V11 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Tue,  7 Apr 2026 18:41:54 +0800
Message-Id: <20260407104154.2842132-13-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ade168e-0631-4f45-b9fe-08de94926f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lu036R/n8FbAiV4eysGvpevR37MP/780bacrwPsrOmpJCDNc4x02A6eyBJfn9AGHQK7fIVHiLhtx2vghyRLgwxKfuqjsviQUNeqYbez8u28IfYzWoJPsCWN8iywkZcESksHxlmTXIDiUoYmMBTF82relAlosWuMXPYvSmZID6UBNXWrM84fA0406JqxzSRJ3cGDtv+EWYgdwRfXazmMhqSmkQmopOez8ejGzatG+8a3jVXlNtSQGw/c7aSVgJI3WZmIvgIu0b6W/sTNY6hDD2ynopTz9nvaCHlECa8VrLUaWkWqT7nQgA6MvpW/FZF90ddzw3V67sBb1kzLK58FjhwseuUEn63pYHb/FAwjiIHw/Vi+PJ7ateBYyn6QAYeny9qBcBxGBBpHWE08IFgihz9abRCuwDFkoSB9s8+q9Irt5L7aEuw3HS+V93/176YbVxpzD0XEOFZBtOD/Cy+1XpAoo/Qn88sYGtD6a91h6KkRWs3rCFrZlO0Id+ZlMko1g1hZyMxhMJCh11zTRp01sU2QngecxQo0wItPbNjAAYCoeB3tydATWI1xo3mW7m3myWt1YOjRee13A620x3hCu9V9OXMYKyz7zTzyxfDlhF448GcUEZ1jaxYdDgweX+qlM7Hnth4kCqNbXXnLDMq8J/yxpBKBhO5/qj2YvC1AibDMho7plaYq3aYEnXFfJNM1novmPwd2j4aNndo360o5p+LlMXehxQ0fPkpcYqXx28Yr1Q9RUC6W8JRYVUO79YYfeoAVZyCe5q4xKYV22piH0zzH80wZl22hcz8gQbEf2Mlg1GG4hq339BC+zIta3Uppg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUHHLIVZ8dce4UUomYlkLgOyatWzw9B3f8T68Uy9mZQSUAghIFh6zhxTrQ+U?=
 =?us-ascii?Q?cCEmtcXy73Hv+jZdF+lIBhYmy/bJucqVkeb16jvUbVnVaDjzea5WHJs3FIo1?=
 =?us-ascii?Q?JLryiejKNIuU27QWrkJGRpJmIuIUpeRSXUQcsBvqWbbspRNt0jgf7Wp9vgWy?=
 =?us-ascii?Q?P2Sv8uyHslQ8rDxNCubjOH/CdNhnSuD6p9BjOLdHtPuRfSfJRnNv0KcRmCj/?=
 =?us-ascii?Q?51KHeL/ZKRs5/wnyuBYnLNz5ArdkR66smZZRh+5c1T4GwkZg+SRJKSZI0yc6?=
 =?us-ascii?Q?7ODU0PX7lx516tV195mcGsz8WMvLhQLb/kmln1RMNL+nQlR+PvNLvjLPxRMC?=
 =?us-ascii?Q?6QEfVk2L4ddLsprOpE1k9e89EahF6T47vbiy+uBbvdAbFMD26TaZODvEBjdb?=
 =?us-ascii?Q?EhucJKO6aN5wU5rOthwB+t6DcrsuAAeIkGh+avn8rENLd1Ngb6wEecJg6Oza?=
 =?us-ascii?Q?KRu+BvuPMkJVfIKyrEtiEAYJ5zjHSr9qKzWuxV8n0KWTbJWl5ZKk7fKUZFJf?=
 =?us-ascii?Q?FnijHkB4bJuHnX0ISBuabABnW+rFXINeCbPHaRUFcLo7Uy10bnZCbpkBi7KQ?=
 =?us-ascii?Q?1ANxet0Ff6q6V2DAqTLvppJarNwDRNRRD7kQPDIbF+5GS8ermDr8wPlPjsyK?=
 =?us-ascii?Q?fuFVBP5o+kPBjcYHFxc6d7ZZ8szXaRQIvPaDsaQ1oPGhxSbhoN8/vJPAbOsh?=
 =?us-ascii?Q?iH+CDv1U98o/dizm0Qt6mA+2rvJbuQrKlDzY7lhQ5ObpI3UNMvuUM/GDIlZP?=
 =?us-ascii?Q?cHjWMCx7oFEXpmLOmOjRH+m4x/NZhTK1GOFDkk4MZdG/kIBnJ7Ezc2GKDiOK?=
 =?us-ascii?Q?+5IQWMx0N9W0yHAowK4S8Y9FmB+eJVhxG5D/b5rcYtcXraza1mVZJNfwBaWW?=
 =?us-ascii?Q?h6qDzH9gZD+mFwS9IbrsH22BZye6LP06xSlwnBLatwmCTOsRuNWgjhTWyI9J?=
 =?us-ascii?Q?bIaKMVZWjc+cJ0MnxrUnRpHpn4f2J4VjOxf+812iUKzA7nYP3pwiJ6AvROiw?=
 =?us-ascii?Q?bExvvGhfkGFPD2lZpugvzutP3VjO48/SgBlyM60qGl0CyQyLs/Kl3H+xc9L6?=
 =?us-ascii?Q?Dnxkm6H7lS4zLbSUTghKOv71SJgbBzlWevT9FIAORLIjhcWphQk8tHXhFQAi?=
 =?us-ascii?Q?YGWFCehqS15hKDFLL6IE/XKYKuOjyRlFZu3Mw2GcoTnyPjNvCl6Zm4KkXQQ+?=
 =?us-ascii?Q?QMsCssC2NHc+iGhX9DYS/LZkp5NnuJt66P0lQr1M70MKsRCUHQufvIn9nRaV?=
 =?us-ascii?Q?K9fzjtPHZD8ve89O8TZoQGbl5J5Iaz91csSh/WpR8ncmyH/t2AmqI7/JczoR?=
 =?us-ascii?Q?pNzuQG+wzFElB4RH2KV1fyzk40gRMsmbjGOwxf6+/tow6clR227FWTTOO9nt?=
 =?us-ascii?Q?JpQF59YaFwWop3ae4rq+TFVjHDY+Pqc3sDw09zJ0csRpWEIdlM35wK9v+dxo?=
 =?us-ascii?Q?0tuuO/PfVIzkNX9PQvtacDBeB7eue7rdgdtOkfLQP3yuVTfgAvKSeyQ0S2oq?=
 =?us-ascii?Q?8hOqmqBJmHbrtpHJDyI2uhlhRZOg5Fq8AEfnXSzBf+2dJXykut4A3CKhnoiC?=
 =?us-ascii?Q?o/JHN2qflLPviF0J2BllJUTZ6cgy+HvOv1iBM4muwGJbuzG1CCFJ8Eb9T1VL?=
 =?us-ascii?Q?Y0CvYksDwct+uqZ5JCsKVpfYGqttG3A+m/+ucmxBeX3FrJXc69svUtOZwpi/?=
 =?us-ascii?Q?j+9xSMkqtBswxQrQ7fb3mih81beI302iNlLALlczRyIZ3kPQnA4vP/63gna+?=
 =?us-ascii?Q?QtkigS2FSw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade168e-0631-4f45-b9fe-08de94926f71
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:58.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeUxYFj9OODM+in4x2LSeogN3yK181s2UG6C8udkLFzK0rAEGG1K34Pe3KhnTWMAvGa6UrBNMMRrMy1La8l8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index e4649d7f9122..7d820a0f80b2 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -553,6 +553,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -567,6 +568,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 71394871d8dd..0cc6644f98bb 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1890,6 +1890,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1967,6 +1978,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

