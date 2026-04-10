Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF132FDC20;
	Fri, 10 Apr 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788251; cv=fail; b=DA5KBBSdIbwOdj8h6FhlqwmKpFlP8JT06j5db0iCODRs3dSgY4W8xTjZg07f8bNd05cm51wUimm4j1Lg+PQv+OQbaQ4Myzn3Pfri63ibjGuA26heAXg0Wr80ToUreW1QyO1u+Hea7nSe4lGs2eWlsx94Okr62yJj9qT0vxueHjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788251; c=relaxed/simple;
	bh=qenzXLklhHlqYAtsHgiZ91iUxT0DbrT62hGAnMX5908=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meDTxy78TyTkuJUKkMGbROp5xFpC5dA3/oL/Y3eEo10HO+fSE/ZrTwokSiies0F8zNflc5RFJkAOvY5tKwwfXV4/t8v2+MupkzReLwvxVJA7VvBtndlMvdTw6mkk/FnE1aN58rtCNsDt4wwlxcA/85vCS0SlYAvpfmDLAID4Y1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TV91SL9s; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TV91SL9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYSqYVG+OOihAT3K7J9IV3yQ1VADgoQWtnoIox+LaS8FsAqWjJFmAMKJq6C5qJXps2hwRsnYFx5lao/lGggEXCNI07KLHMnH8b+VY7Y+oQfsbRO7zFr71rkA9h4ISngA97gw3tjW/r6TTr62KKZALc8J9KV4mo+Y8teOu4UobmUuW3gJolIxcxGxUh+Qa0/H6k01RAMdHDq2f+sRfC/qAesUagqOnCIEHzD1VfGLsGNz7/BG5wjfvLzcJVo1CcyO2wScRNg0iZCFR5Kdo1RYJh4oown3QKHga0rL3tM5z/U+rvKVtm3MYz9xQOrvOAGU3Y8ui+LfZAezBFAW6Jjo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=FQZX03lKOfoIADrJNNtKl7j/rjHwvehFGb24GPomoq9+g/L9pCOLOK8UbZDxG2u7JHaioc5ocybSPWKbHmd1wWTI/G7tigWaPP5msjRuNnXQpWICm49CkO9a8b8zZEg8vFJFtkEugRjF4mtcRJ3HohDwkSzzVA8gD0nOpIEcXFATG9LhvKLs0aswayllfIK1Y0MC4Zrkv18gkrNu5QBNOrbrQoy+uzkLXojls2BhEDM9HttR9Cr9xxpNqDwC4NFakGz0FXhfStWtEYGCSTAH8tosVxUijhKPnB+sSn6R+7dwENI2HmYg3p3ej+q2nLuYQH7W4rgeqN/x6gX2kchbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJcLjZ34i2X/erIyjKhzluwnQx5p8ZpyC/lM7caq4UU=;
 b=TV91SL9siiN28aBfxY/ZC1jGHy8t+JaJyfLNn/PgfZJGvffxchMd1JnuqXElQgfQckb2rKBFd1qBi3zcAOCdThBiiUP3EOj+5VoBcRVQh0Gh14XFDbqvpO4KzolyNNdvZDr8iB24MXP5nHJzZS4KJSAfZB9nbioNZSsUV3dteycVZiUmEazXfyAL7xZgnsV4Tc2ymIMsLsapCxvtFN6i0m81GZoiS85J1YlWs71F8v7XMtOzHSPX/P5jBGgu0v6bvB3Hacz0a+DoatvMHn1yQrXcX2MQgNXTCwx0oQWEeDpk2KqkegSWicMRJIfwSHA/B+BgpYx8dT8SeDi922FAVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:30:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:30:47 +0000
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
Subject: [PATCH V12 12/12] arm64: dts: imx95: Add Root Port node and PERST property
Date: Fri, 10 Apr 2026 10:30:55 +0800
Message-Id: <20260410023055.2439146-13-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5978fe86-34fc-4d81-5c1f-08de96a92c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wSLmQmjNXyFLyz+DMldcYXc46pzuiG1FmDCsDacZGG8DXGVQVFAWvjEubXmDAq7ubvBfQel0YxK6PtEonP2xMuOWdtOgHiU/vqZHmL+2Pjobo7inlWcghpticUk74RxJAR4RQzvm0y9Guemqboh2XKQuF0odNBF8NBIjN9TeJHTCZDlepwcUbhXHvMIgXHAMmqaGlCtiC1jOzyYZwNcxnfyEk1sG16yv7VQ2snZbPzf4uHSSy7Pg/3v4B43be+lxnk9XIso63IoSqJCnv7uoJaH+om7r1GIlns7EnsM4PmJqoKOUw782z79L59Vvl3G3/rwnoz3svwcmoV4G3SzQqThG3EzA3Azlopc1eWTpgyub+cM2jfBv8Mz5f53lBR6TStcbEqjN7fc9lsI/dHMXVfFi2UuOBif6463GphrwKtsFK2ZxCu8DFEHsYB/TDsODvSTG/CW7z6Kq5/HVowLmTAz1NrBiH8qDkWQqlZX1DiyNnHu660HRyD4yMUGN8KI4sQZVWDpDM2+KBLW8mSpkPWaP6iLV+PwkQsrmBZ9WnrZk8Bzd2+Kur9JcfwPeUia14bgDnvHG3Vnhvk3sQKPPNpubWc5jThOFX25k+XJxYm9pabimsqPgPwWaYwUNXtYKJxvD30618OmPGKHK+SMMepPRy6vLvgYSrjQ/2xHsssch7zvBKcALHW+Kr1E9YaJ3fiyxs3D0al4l8U24F9/YzjbalRQSTj1UaRfLhc/5qiShzW3L4BpLRY46sG/KJDywxkZQIHdg0akkbK7KgjlDfhsdDAb9esJd1UsX0Lirn4kRyt3Wrd6qZronFUxvX6yZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qv7v46YQQxgh/agF0FnaAALfIlyXTJiLdlnyBAhTEeLoST6//+HBfX3eAJep?=
 =?us-ascii?Q?9Tr/6R1NSFRJqi7RGNUY/ziZv25f8U4avBnTU3S7GVWIWP788gHh8roOfe7u?=
 =?us-ascii?Q?lWLuHTLpinUzfEL2QtBTAXjrBcK/RaCjvkdLtj/f2aE5gcVkrTUsbfqG+wto?=
 =?us-ascii?Q?citLTuBjsk3JLTtXLAUc5tWpV0Wko2y72z+f8BX3q+9ducGscdauqYflLwNU?=
 =?us-ascii?Q?NBegVmN4sRgrWLPgwirjpUxeCOAHEBqGBI6cRrYP6t0qv2jBKR6A2rRDfdlr?=
 =?us-ascii?Q?+MRsykBXr50z4bhOxaftKmVDFvrLYTg9QeHmWTJIkOEpwhFlwt43CPkGP9Va?=
 =?us-ascii?Q?vbCe+ElvYvAvuV4A1RBd/brUHGiZww01+gI8/wCRkWdSX2+6CuX+62qchL4u?=
 =?us-ascii?Q?MbAnCd7oOGzxHBzMYoYvLUDpLJPrdkT1d0dKc9r/Ss/jPMHTuJYhB/6sixsf?=
 =?us-ascii?Q?bowcbHme3D+13oZUllxWFV+t0Ae1Atmb465dspO99EOVQMMLMzYtTXu93j74?=
 =?us-ascii?Q?yqCjiRBy897sbp5O8bHL/4lmYZzVr5i0l3a/hDCIEjeeRcFfcBtDNGI8Uj17?=
 =?us-ascii?Q?vNQsqrCPppQb1cVtv9tjjcW8WzDFYXh7Lz1QZ8UijaMJoaaFBGuYuNYBiFzy?=
 =?us-ascii?Q?tJfFLw2FuZkgS1JUBuAY7d8hRDsCyEkjx4I6GoAZxR1LUUivmKN4xd9V2AEz?=
 =?us-ascii?Q?AT1OoqQEt3pKrcnl+/uXHDIAuZ8kHu/xvn6UxBX5cf6lSvesLo8jfAYAR2Ds?=
 =?us-ascii?Q?81xKaKTDUpyNmwhKThoGR/eEKWHtEKxvNChCmAessJpPphCItfE/rPWXKGJB?=
 =?us-ascii?Q?sNRF9c0WI2bIMrPpWDtijpFnNmyk3kJdjyoCl6gxZxG6cQS+LYRxtqaRzhEU?=
 =?us-ascii?Q?eLJdGFOwqu5pET0fPi8yHSFXyNqewX5HTl6nCVhoCIoWlmQ8JJnoWalI7njr?=
 =?us-ascii?Q?1DD868khMXgRg2VoZ0f7uz18VnyX0Vf+wEX5kAc2La2YIUS5Ssw4AHnnCtpi?=
 =?us-ascii?Q?8FU7sg2pr6BIa7xTmAfP4UU6Y/kQ0Q6IuOyDZxWRU3UY9OX2WbYwIa16fGx/?=
 =?us-ascii?Q?yfTogL0kw9Jdkhg0SSlDe5oaL0ZRmqWjNVhTQ1aRsgreckEgeNAsXPRdPdXL?=
 =?us-ascii?Q?bEaPDPIYfnu9mZq1IhrGLXz4iETUNaiFoV2ab/LFwemthBePZFpWftZ0CuOn?=
 =?us-ascii?Q?vKPjGQl2r0vO++hBH+dj+UuBonGtRm0dMmTpvyamVLGGkFTt1JrGElMUm5CQ?=
 =?us-ascii?Q?1nu1GUGCwqywQCwBkTjpxN/f13IBsUofS3Atp/tK9gUyQfqMuD1iKzhqbrwK?=
 =?us-ascii?Q?XYrlpaN5kHNc8Bo3uidmqT+RGvZ7KForsD9HreFONGKLsuG72iKhg05gyFZS?=
 =?us-ascii?Q?Ll3OZnCoYh1TK7sAkDRKSBBJriKkgwbyda2KI9yVwZxbYgpBtwktXDdgMJRn?=
 =?us-ascii?Q?atw3/X5B4Tv0U58HPvj9m+0Ym+H7JTH4mO3jzeLIKfGmLVPU8RF7TJ75/c94?=
 =?us-ascii?Q?FuzXPL6EWn0yAwtbabnnPLdmPaNkL4HQxjL2yLdyyf5HuyVTC4WWrqhCa4OZ?=
 =?us-ascii?Q?dRlxltOURAoHVlcghJNOajv5WxMCxh09nicZcLqmqXToAWSyfzNUOhI16XHT?=
 =?us-ascii?Q?899BKCRjrarkCdXDzx/teuXK2cI/6nydIGOjd8YiLOPXeXhEAr4wrZS8xaTy?=
 =?us-ascii?Q?UAF9SpBNZQMiLUsQEadTkle3T/eygXXx0nRVSt+Y5u04zr0+r/lpFcaM696C?=
 =?us-ascii?Q?GSWxXnZ/pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5978fe86-34fc-4d81-5c1f-08de96a92c69
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:30:47.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP/1dkm3LinMudsgchQiJRTWA6E7N5+eRHtqyG9dvNwydj/snfAvmD2TwlE21t7vz05N5nfSjM3gdo6SxFYF4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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

