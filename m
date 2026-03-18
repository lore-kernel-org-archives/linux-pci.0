Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D454364938;
	Wed, 18 Mar 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815351; cv=fail; b=K8GfWrKZ9RdJ7mAiY7jWGJmPp6Wzl0Q5ziVNToPdaUS4gGlF0oR/XVVgzyeUp9N7U2o167SdUP63tGF5fZsq200LoeuWDLWw6JN6c4LysH+0eoT5Pk+i6kqdkwPwO7+bZ9h8L4WSYt/SMJlTJ74Ftz6uikRjxJlg8+5kooF7U/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815351; c=relaxed/simple;
	bh=JFM0W56xpsazqyVZ7LaCHxqR38MWxGJijkOLJtpkbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUvNsMqey7eLJfKq7OU984o28x+ZU/o+tTrEsC58PKVNtxYMAN6Blt9L0KNbf8WZpyetmBd0Q/F7ElCkyXq+h2JQQXPUcFK2lnfPAaCF4nDAMkO6lDSuPNUOsUEpmDvsG1QR5BGT4RWFB9fejexaVKIZMYFuU72kinKPOVk0XM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U02Ts/7v; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U02Ts/7v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIwXHbxxZ6k2/K5n7Q3RZBEICReInHQGuiRVDhjWaPaiJUdvZLNV5mweICb59s8rCkNIwEH2lNY3O4CNW+LeMj4FSee+lAX/jLeeJZ/oB+WvQkqrb6RMyjQUbGO+CnYhECSqFDe9QK8U+V1Iib4T2yL3uYt0z/OyOZTrq0YPb8HTL9zCTTfTkVLnsZBALkjWYX3+g/47/8L4KFN6T9YwyIhbNvimRmYs6JWY8XI2ZHWpfHLsLak+Xx0YJN5JQDUBY/2jBliIiTn4Skv3pjRycM6yW/JeDNqMQNlkmmk+zNVWpDuAyoV5PTveCiy5RJgu3BxRe9poOGfPGQ+Yq3BuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=G3HTlMt4itGRDKLwKz8osILSctuWQWMEr1gU25CfTLhROXTWHZMj8DBRgnWO2uJn7+R6LP5CfbNCJRscUUryjsv8oUJZd6UWc9/TYiU36VXhH9ZeuCX1Q5F1uT2sPv9uayxAwh0Beg5eqDaV9CtZiQBOWpsmkeYUT2MO7BKy1Z9ISnmeAJeJ/GENftVrHum0eTYPpVagVQ5T8f52yZMAgrX/aGAyLgCErivqsCG6oQbgO1N6+7BVIN9QLsxkuZ/4XrZ2Pk3717wKF6Oky/+QrxGglSvmapdg49Z1zcCy+PRZFFK2kpJGLmIK74/rw6dJyx3nQV3hJVRhUeE5E9CAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=U02Ts/7vHTMgAcd2b2PHVfkgF2immCG7ab4q6EGFBY3j9HlYpi55VWWgZOulsLiiJuTfyAHL1N/aXfLz1y2oqscyWiRs2mByMat65+jyegXBKEQn5zuE/JfoP15tabyXL1vnA4scw7g3OBquDH5KgqMrG1K3BBNS+d4I7pwruWBibgg8pUA91hZLtFe6BBwnYQJZB+1N9NBa+gUHDOcUeUCyNnKbcaOJsA/BcQik9xeAm0/jARrq0BjNModOuQ1BlbxhI9pQTLmk+7kzKITJuU4+IkVnKE40OjkC/yMEBekFt8ReRv/7E2PKQrvqvrkNWJ3eRDmBUxgYlmoNiUsRNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:29:05 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:29:07 +0000
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
Subject: [PATCH V9 09/13] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Wed, 18 Mar 2026 14:29:12 +0800
Message-Id: <20260318062916.2747472-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac934e5-1708-40fa-668f-08de84b7a866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	7bHDN+LIJCZc8jA5xYCAt6yQcbMLh4lWj7F04Ct8OwwTk+XThmBEPHkFIKgdBL/F1Y+FoKPV22aV9MuFLTBtcac4+9HVpITHzw5oQ9IoasuRAFoH7QpFx+JR11ToPt+J38nhKpY/+9M182ihSWX8tVF7S8OfVfppe8G4ZHxgP9wfuZyMgSdZHiHS6ySjeGJqH0xwR9tyHk/Rs74lO0QWOfaeXSnSeZLlv2Mwqph+tJTPQw6PJjw4VT5Tbh/q49We3RfpQvqSYsRGkZb6UwUppQEcv7zkucMlkjLbhebsNBJb4yq7Z4tYvAk3qrLsMdlJPFmHPUkUHbyBH9omJaRz6IVZ/fV+XbHpTfXrPyECVsJ9AETmDlyZnvEmIS/4mYuGlPOQSuKdpRN675GhTUe2P9oKk/mT+OIxhlGcBNQ+UgBXp+yX3YKj10ejBhigO26vMI9Zjx5ZiGqSZZ8lL9Gy+Nk3GaQAlqcglVGnn6NgINswUpvCy4fxt5mblyVmQodBbFaR+CNnovqMyRe02Gx/nzkC+06UIa7+KgS5d8ZWje8Wb+2znWWf92QU9PuT9CUBG3+BD/zhVe0zqc0DQk9fEDfo5VOa+EqzEfFku5ACWc5Ht8hxEq3Lu+7J4lJkseX6vYiHzb1kAW+QAqIH1KC0Lpmfm4YBEp3/Ew3dvlXnRiY43LTCu1Aj0cHFMkN227NAn9RAYqUl7egyFXC9HWioHV261sVfp9jTPddAVCMzwHS95pSxi2S9ub6Cjc4ZTzyfpdIylmTn8z+NIKbD2PRz5hJHYf9jY2B+szW23Q4qyu7b05bfVd+ObvLBChFDmcid
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wng/WQJ3anAEkBO1xLaxXrGi4t4gSkmKEFGu6e4upkMwNwq8/WVzzy1Uw3hg?=
 =?us-ascii?Q?f8Vov6mwq/MwkWhKBvIA81IlmXrfB0xDNREQZf4IarwDZL+EZ3RD9jtkN8Fo?=
 =?us-ascii?Q?gby8nm6Ui7PmoB2uDvLlIZo/Mfd8Vm8d/g29XQquF8W31JANyovgB9NXj34+?=
 =?us-ascii?Q?WRW5LlqC8uzi/UBHc95slm+E0ouOA7wN3d3gzgLFgT0ZldZmCeVxRRrbpya7?=
 =?us-ascii?Q?U1rQkulmxpFAoIFD8kUJS6PO4bk4n3H+0kzot/IZyLOpOMz3vZqvcScf1z+x?=
 =?us-ascii?Q?KVwZt0jmVYJwtxIp/zzArphzGknsKawU6DrMREwMzL9wMtLdXme16FnBDPWS?=
 =?us-ascii?Q?Hc7pGOL8+k6q4ydJWKraO7n2fheuymK+vrixDh+EJSKI1mxVwfEUwxJRfqCR?=
 =?us-ascii?Q?FTOQtcn5p/sQptDJzV/4x0Dvmy8poX20yvMioV7IhLtYGbShSyJKTNAWVk7H?=
 =?us-ascii?Q?Ffux9A81ggZeKobuSgjLtzweluSNp1PgKMbRaPiB3zPIGZjbT9R2QOUW3tca?=
 =?us-ascii?Q?gDO4PpmOgg8xt94CmX5ZkMHtwcmFralN+OOlNjkqAgHknluqh68W3XkQtCVF?=
 =?us-ascii?Q?jpfK+nmmIfCYtcd+NSh9/vgkM6Dsk6bmvJmzig0UphovC06Wcb+HWb1+GJ1n?=
 =?us-ascii?Q?bGYKVe77QaZvOlqwXmbFr9ct4x2zjKpTq7jwqVJVyB8+tMOoCiwBb/yWdSLD?=
 =?us-ascii?Q?MVOt49iq69d/8G7I2lW4ZcpPkSk9LmdFTvCtyBHlfFuXl9/R/+3j8Hi0FV4N?=
 =?us-ascii?Q?k2zTVCnD9rGo+LV15cZePQpeoyq1QOKHtrSAKIGNOlPcbnmNQB1TFM/ysP9+?=
 =?us-ascii?Q?VBTnoEvfqVCEZjb1ZgD9SH1+guyjv/J2NrCmIGfex9j8kdHAmvzaXPy8js+C?=
 =?us-ascii?Q?r/BTzzKg/EsGcS0azCm6eQx0CaYGWAtqtxVY26MzrO/AN98VzSIus0IZ75iQ?=
 =?us-ascii?Q?L5CYhGMknE1KwCI18djXDUWPqTiXlSDzQLJGVB2yTLhVmcoYmHYvohSx5Iin?=
 =?us-ascii?Q?HhhJA4fFz1aSGGrHt3GJZ2wmL8wTI+cjCn3iqCpc6bBpMJSBcPjnaSMGD9b6?=
 =?us-ascii?Q?IirVz97hOqd/jlcXjK+o8LFBz9KRu2oCtuJdGoQmo6ApdpKglHyXne1Agymw?=
 =?us-ascii?Q?fBubd3z6ieCeg5LRvO3k2nYBpI9PAnQQWO4DWGSUvfqRFUd+GrX1bTP1Atu9?=
 =?us-ascii?Q?77QZUHZX8Q7wXhTOSM47bl9TN322D3nHWlejLshI3jidi4GO+JqOdPKc6dr0?=
 =?us-ascii?Q?2sfxzVz0nzWYGM3xOC721ftw9XhP+GCIhfPQM7K80hjrzjpeg+vcoqRDK5Gn?=
 =?us-ascii?Q?Ofkf7o7SUteByiE1fH5t4+9zlpD3q/ooDbYkj3FhBiaU8j9Pmo/dNddwofyY?=
 =?us-ascii?Q?dvmhbOU42z15y1np2cVBU3jY3Ap/t8/I6WJB4exd6vPqtoLzEqMwxh8xNmAM?=
 =?us-ascii?Q?C15o82IrTvZEU16lAyLFjxCmCATGZPOxWH5AtgLVSQacE9NkFqaHj41SxgEx?=
 =?us-ascii?Q?BvLTuiz4j9YAbbVg/HAhJN3S+lCVklxAXgatRvfck4/KCR6Fsf6X0NfY8+cC?=
 =?us-ascii?Q?jDjw7xGl+80EBne9CdwCeiWN7hqIMS/kGGJgQWA3pbKGETFgbmoiqwFhtgzl?=
 =?us-ascii?Q?wMHRqRgWTMfZPvbXC4ahZeStmc67URiXE1jEhshiBqDyLnkzJetiv3JrRrnA?=
 =?us-ascii?Q?hGevatCunuv2pK6rOSEIgYsA5GaMyg71tFT9Ff/Av3/cVdL/RwR5ztqTLWAI?=
 =?us-ascii?Q?Knq0xFlEAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac934e5-1708-40fa-668f-08de84b7a866
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:29:07.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITaGoFSLzbk1EI4iMZcSXPN4lkBGfGVT47woxCR2YsQz2bCRYHPByNbjT3hMgTQ3EsNGlq57IyKhMiLQMjfFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

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
index f2e1854f38a0..fa96432697ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1369,6 +1369,17 @@ pcie0: pcie@33800000 {
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

