Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0B25A33F;
	Thu, 16 Apr 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338044; cv=fail; b=KYHe8Ys7UE8q30GcN8jXQ0n3tOLsopNllzFHLGfI/eVp4Dmxu3llKnm3qSVsKckfBeIOKaiE9Fj/X5xjnJ1CW8NnVo633bnwHCkglrGaV0eRRB4er3pXtcGdhQwS7r3PnIkc/+9XdorIQpDv9qNVm6O/YpQRyT24pjhhunaHH+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338044; c=relaxed/simple;
	bh=xzPgWC3CfkAwVk6V3+XedDsGclq2F+T1PYkPZp8gzu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ieFNJqyh8PoVkGLAiOsPqZptuqctuPTnf9IyEOckAJP6X0gPXVWcG7dqHA+rV7eqxcJek+qcPfuW7J+fPNYhuXO1As5Wh00IbRi6JRsJAJOP1WKmKAkmo+0AR0KFNIVSIp0FFdiLuRiZ7NJ6O9SUuGwYqHB8vXni0MkgDfPvvIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=niYOWNyg; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="niYOWNyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOQvGm4XMv6cqH5eFDKEuILnpuhrpuWAZJy4GKOCtG+r+uRZ/uDM2AdvZZ8AWsUHr+kUXw8R3L+w/7xTP3Rxsh3qxgPqcaupy+7DtWEezvfuZqwbTjaPt2qDS08bZJu1nhFkfsi8UCvAyFOwvP23r4LNR/5kljcDo+sam4dgtl1XLYMGtuAXMkUdLD1/bPfCvwzeQuDJ7OIAULxVpkvQV8EbqJOqyA19FHw+2edm0IjWkiLVPgWoZOKmEuScH4QRLA+brtc/k9PFUYnz5DMBEQt+4bwz7YC6+LNPVw74wxleGnMrasbXQspREtoXuIm0Bh4UnSmbwPVhzXUOXJ6XWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=O+ZlbtO3UQeefnpZY7YvGOp9r5KGAzPC41EyF6CVCohmyk2q5xs61ccvF99XGPIR5RWu6kRkqZc3hPGttASwWPWQe60dH3/V/DaMgZem/c0pIhdlUlH9BV5r9NrxmNzHXvLLyi8hcqOdmpQQEQLmrfiQ8gC0Jd7a6CfDCiFAsZzE2fJSH1lKs6sxlGPZyqs7w1/yhiVgD4T0MUXD+bYN5vHGTogtWBnzmA13TQF0ydT3okp2EZnKcli74BDAZBS5SCB3YwanmZ8CqjSYBLes6aHVFhIk36DiMfrBfYmkAB9MPyxwxjIcAuVKOdxEqR0mvkjR1LrYb31jOkzk65d3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxEOfEJmu7MQ0GpoL37Z+tjpmvyLoWFu6FhEGGtd7t0=;
 b=niYOWNygv49vHn72+g5neiB1VamXP84KwtkHAHHBRVfeW1sV3gKVkB+XqkW61EQR8rEMH/bI5V9fBL7kly0WcrU3kOR0Ck/88b+5j5uDxx8X6cC9f/cftqoL2siY72l3iAGQi4MBeYf7J/5FG068iDM2+ehypxdc/VlNCqmHTZUHIfJeArvOIVPPHaG46g3YKzWWe5cdWuQtMA6okKhpPQsOIBIXAB1kUr1KkF3THVyF4LRfZ3nOe5Nc0UtDBoRt9yQeTEXPn/dsc2TMvrjEKWVehQYkBAHObLoxWlVB/gx/xuobtk3dnJRIAG6v38ocqKFtNLGHn/XvAugpFWGsug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DBBPR04MB7897.eurprd04.prod.outlook.com
 (2603:10a6:10:1e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 11:13:55 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:54 +0000
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
Subject: [PATCH V13 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:19 +0800
Message-Id: <20260416111422.183860-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ec9c14-fe50-4a69-563e-08de9ba93f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lx9FwxScjNswwCCBKvHaFXLscTLF6Cnr8ETQtICu38kcFeyAPWGALPOQIQ+Md/XkYdoK6RNqaoTuLi2an8fDrwLXLjR1BDNO799GV7pJQkxp4oxMiJcP+x6VatVhtUfLFHUqhDWMxqDekRmwWeNCoy8dRMQ3q1NhYgvZiRyNWONSWAc7XZTsLLWV2GYJhgW9o7Im/edvrCvmihG0Q6BJVVxkamiThzV/OqRK+WF3WB1ETcQj+g6HaiceXFowYAC3wsDsotGeebaHytJtu4oAvSTMNEQvJ127+IkzYBH+NdWDsoqAGbZIj/1Y3eNQXyQ72Fx8kBxmu+nZNIsihQsOvd0jYAS4CduJcUrZtMVa2n7X24A2AsE1Tt1Y6JNOG1ITRn4aJH9Eu9qnEnzlagPcK+5wZcfnLVjJWv2ahFYlpH7nD5w9EkoFPby+KWj21y9da7sHJ9c9u9iGw/X3rCg73MmpanLA9QysxMdB2G2TvBY3M4iQDoftNMUjvCO13LSXlpIqtQV87fI1oG7Oyg+zPX8PbNxeVVM14fMQRNm21mIICul9dL6WCHoj84SJOOfvWFN35WSTlyBcVUvuUxE4PFan3YqOLnTFvTMoYa5tDK0gY0bOz7ETZVPLZAdMHzSjEPsM4nFd5nbRRTCvcMTZOTeCYirTvnselmUq6fSDaXitUv0gmTesbWhYGf2LO6rz0Uh0OCvsBKeisaSgFRjIZ2fCr6r7NSNxuGzD6AvpT1MMg7GGi2lpx6sU1cYM2ihnen0oafyh8kv9Dg/bJA01pWNvmcafRGunLUd7DofUDSVAF6RGzCbc5gxBiL+bw6/x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HvC1W0bPVwY/clV2ST9ZvkJMSgdZ/EmfPOpmKSwKKS+3jbhjl4TtctwvXIH?=
 =?us-ascii?Q?GS9cy4pdno297arPRIgjydV1xadY1eaX7eq7e5F0jkBHoBs9FiQF/auWarEj?=
 =?us-ascii?Q?h6/DZFhYJQt2/A3gYldXWtSLUA/QQcwcMzqD0T2zgMEJ0WsTOFtwLPr4RPeK?=
 =?us-ascii?Q?zyPKE0JU4gB7pk3myzyw0eqYfH/UNX0Jh7wMcoE2Ch2p8SjHmv8W040J0wpq?=
 =?us-ascii?Q?DSyahdsDcwAsU7b18qMF0KW2MSvORtXgAUc8f9BF+dNEnFm8crxY+gFbulwG?=
 =?us-ascii?Q?nIDM7+IyKZPI+SAlaAJVcKzl20dtFWD4cG9Sq4Kqc3qdn1Hd/nee0YZeemOi?=
 =?us-ascii?Q?3TzTf4sXba1NI+olW9iVMYv1IFf0XFTQvlcHk4TwlentL1Kp0ZkViA7QXSTf?=
 =?us-ascii?Q?HNg7E3YPnuYxcPNZVi2G0TdMLTjmUBFzOZqBh0lJp0pgoRXMy+2Y1XmHImWz?=
 =?us-ascii?Q?sBm0LuYznSaP1isFBEWo4OTkW8tZDhKvaBtL2c7OzC/QBBN/zgGaJeIwiZ12?=
 =?us-ascii?Q?MchSr51l3xyTiQmo/5I0bUgHMxxyLpcqK/HFjTQ+9CNAmcELO2/B8UzrpjcY?=
 =?us-ascii?Q?AGn5jNZ+EPZmHV/O5azj5qWaO0IK9dQKoxmZ9g1G3SlR7XlVwHpNqm7+lFEa?=
 =?us-ascii?Q?5YxmgxaBcoCPzFef9PUmWgbYbZaWZRQzQrGIkWMn+Qi2/DARwjgZ9hr2y5Ah?=
 =?us-ascii?Q?Yy2/H8OV+6IZ1ImVc9P6jmj3GzQHxJt5GRjXbPwx0cSorUZnwAJ1QF01bn4g?=
 =?us-ascii?Q?BaMUoEJ3ZBfodo/Yt2EMsb0Clc5P2zrFc0uuqt0m/7Mt5O+Lzec2IbD0bngh?=
 =?us-ascii?Q?hlV6Rm992w7AyjTs8ZMWf4J7N/iZsKNRJFKaa6H/mxWRoie3nPFOoiUNdQPm?=
 =?us-ascii?Q?+6iyS3NVBdyADEM9t0oYbQWy31qpYtUYdqb1nkN2+MJMKjZAS2y5OIfLmWK2?=
 =?us-ascii?Q?kXsG123hleebCdiJXKZeabzLY1CP97PaRHR2znohqhGsNfXK1AEQ7P/kF9OC?=
 =?us-ascii?Q?9yS8/PmcXUWcaKYUCyudju9XIQKI5OGAkVqM5tXolOipWhBjEnxf/MPJg9mm?=
 =?us-ascii?Q?u8sZJ51jKH//vv28Mg+45hPRI5cYodpyfOKlCcLe7FXa9q/dGusk8JCsp0Aw?=
 =?us-ascii?Q?e1Ug81hzjR9lPIVaVcKaXxvlUlkD1JsA4WviJ81XdnD6S0ODK6/yWZM7hevY?=
 =?us-ascii?Q?TB1w2hKtP/8qTFjwOzmOefURfBw/cVxv/rlZLbzJYENSDKamv0R5MNR2FSTJ?=
 =?us-ascii?Q?rfHSUV4LkBf3Dico9MQJQ4ZHltvUuZhycbSQEf5Q7OcrOL68GJlhIFby/EWN?=
 =?us-ascii?Q?qPKc9ggttYUHyghn+p22KUNZwaXqahnZKrbfTgoyoDQ+/9vRFEQ1bBq2+oKP?=
 =?us-ascii?Q?sRIZBK6zr05+Q5hHI7pf+uL65zkvxs6sF+1mMouLf55oM7c+9xHFMjjYIw98?=
 =?us-ascii?Q?u6DHsNZYUAZINZKb7jD2WJtiy6tqOkRPsPfMuT/qiYdJhfUbGMdDdLqp33ok?=
 =?us-ascii?Q?yEGVptB+Hhw0P2lSEJNMDhFAt4sT/xbGaV2NSDmp+uaDFXKtvokd7vRaKDnz?=
 =?us-ascii?Q?wbMPTVxZ6Psm2d3zmzFSGTas2HfxPhQBleTs4gHd4IypoQmnADquHclFyIut?=
 =?us-ascii?Q?UNXDvAb/3Nv6h14hzZwMDMbpw6FExwrhEfwVn20W/rqOU+ll+Mye4Av0Oa61?=
 =?us-ascii?Q?EJ4F8Nku44F3YjajYg7keLp0Jr5zPpe7zlJuD6SqmbUI9ighcAwCGCcgQuWb?=
 =?us-ascii?Q?FYs3ougbAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ec9c14-fe50-4a69-563e-08de9ba93f53
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:54.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5atVCZ6FIk5RoPO8g4GfOG4GxHv6U6zDp+npJAjXm9f4LB3KJUHvCJ45HmSBp1CEOjMXQgVCS/jLTVYoOwxMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

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

