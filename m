Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F43093CF;
	Mon,  9 Feb 2026 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625482; cv=fail; b=YyeQKgFC+wHeWFuDYGBHy/JRxcNVZMmJTzky0VBCKPDViL4deZRHwYLcU+mDQEPZ5AGlkpwr69/7L8cBOXw/eTSEwBZIbuSW9Kh6WE6hiohSJKToXaeH1OBMIkdPZvB8+8buEfmkSdtg302SMp3aTBa5kQuNc4Q7+Cwg2kiCiSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625482; c=relaxed/simple;
	bh=ZDruEd/MKZ4VVvHfQrkn+K+6dovwVnUlvXolnMqigG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sK4T4hQZlH7y2CU6QKKa0xWJLcJbIKbudVRDSykRYUWYAvrbAgpHATRbepzoy5mQ+Z+Q5bNg8Z3uSLtYJVure5GOT0z3dWKkaxafCLuLwDyUiDUl0Et6CdR80iLrmKteV3+nOQ67qazObAvsv0+s2iWss0GJL93Fif10aUHN55Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ev+CTtsY; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ev+CTtsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejYj3xjv0huLNmN2Fot90pfnAet5ZFDnTWR6kgHn40zuJe++QRLtv3C8vUgfsiizkKyauttzEac6vOciPBXO6oX2MVR6xLXe8b07lbOFzS/8n9MrHvxBtd1OCNnvSybVMMaX0n8Ij8IiwV9Pk6pNUCM9dDLSmC5c91hQ0nVWF42IFriVY9O3e8obqbpl/WQPXcejCR/Fga4Y+2iMrS7MNim24eHn7lz8ItaVdl/ReCo1Vh5PDKVQ7uqcNh2p4CtOmHS6PR36U0FcFwf4Pxlaao+qQ0pJRHxyG4xP8ixP4GdK3unOud77x6DDTefHJoIWASMqtwmwv2MoAGC5gW6ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=wHBnIaLGvhRsnnB/M4cs0Kh8tF0D6qTcvGCIMsEIS2AyydJL7x+WuAmNI4Wv1rbWh+6y1GIVMsjkkqhYWL3yXS1+2brUSF7HX+ps/DtZL5XEXN3ezWxoSdAfyPwCw+HQ/by8TV3qVotgo5Jl/4ePxU6EQehTIpmSP/f5TiWabT9oUjgVTvvHKRY89qMXqEIch5grxjy1yG9J3ARLOmifdwtu/RAQFpMopvnFzLRziWkiuGI5Tra18EgU/7bFuDNGMFHadTXfYf0daendEP0n25HdLgxvT5uDMWRyZ+giPOmucD6tIUK0EOir3MVne0qlZE+syZWCPBgSVueUIgTrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=Ev+CTtsYzTbEnH/GnilqwfvdWTVWJAFszGcpBs4oqvn5tIGtwhZpYErG+PzgdiIDEMAF7fkDxcjOgNB66QvzLSKVCAkvBAyFJBgBZycYSKe/AD1TYLqV1qZGrJDAQh16VRcOZvNLa0N+hh10nrZxxcpGp4gyxU57JT4KJ1mqL+GHBqk92OY2HKzElVvPCba1CbagzcBfUTr8Y2XyTUtdBjDOPxhTA4pWzvoxRSK2nISm+6PH8ndX41eqE53QfJRl3sp2U6XYFR39DQmr5SFvR1mAqpbmMPc5FxrsACFh6M/w1CG8ffWBiNscfArRlay8Lk7Q7Dx43ZRQyL2jpX1jIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7180.eurprd04.prod.outlook.com
 (2603:10a6:10:12c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:39 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:39 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 08/11] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:51 +0800
Message-Id: <20260209082454.2097628-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: d87f1b9c-0c37-44f6-0a6c-08de67b4ab2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+H1wv8TxzJBiF8joZw7mhkP9m0/XxwvNM8W7x2xtSeM4kYz3DedgyjXKCbyp?=
 =?us-ascii?Q?VGbbiVfkLMsKT2IDWiguxIG7ki/7Rcecl9E0NxfZkDidLSoGVo9eQGJLT3PP?=
 =?us-ascii?Q?PusMVq20e3Nhmbs3czkn/ttugUOacjw7TnPPiIesNFhW2DPOcD8Z3S8Bh29I?=
 =?us-ascii?Q?qpRwdJ3rr7OSahV2kySh1RNrCK0C1RKmdNa1BzcExS8QNWEGGTHVjCWFpLov?=
 =?us-ascii?Q?2mY73ixK/oXmG3ruzIOIPcr8FmNfuPpH2Z74NrEbq08xE1CVkCO2tATnQOR/?=
 =?us-ascii?Q?igx8mu/fyvLHbbyZvPAkeiJrsZacfeHC9bQNeBB75EvhpgIIw/bxQUuf00HF?=
 =?us-ascii?Q?GZ7EX9B1LMqxv36a/Cs7TSb4xZUW+CavWRSmyj2KR4vupUyyFUCERqM8Jn1R?=
 =?us-ascii?Q?s1yXeWPJAN932IsH0Ogd+YcsRodgodRVLX71s6s01TGEh6GMN55mJQ4doZT8?=
 =?us-ascii?Q?rzJLaKt/nmZZ7f/pbt6D2vpyTe5N6R67nTMXgjJkIvvItmv78DKzp8JvLm37?=
 =?us-ascii?Q?awvbuNDc2GhwrVwT0mx/PXy3iMcxjfkaO0qhMWzEKNOxEpT8noXwyGJi3TYo?=
 =?us-ascii?Q?5wYV7b9EDw9fitPSJbNTjo92y5MPEA/LgnaOMB5G4p9fX54cGa9FdwU5QYaU?=
 =?us-ascii?Q?1YhprxWrJGVkc2W+u4MwEwLsCNxrZYw+EaFUkvyNf/4lD8/no/ibGZ4QMmUw?=
 =?us-ascii?Q?7gK+an8nQ5ifBWDZmZ/3ERqGrGoWADfsvUT8b8Kqo2K7anZ/NuAJBeokZ0g7?=
 =?us-ascii?Q?21w20RPDp+f2qj+rnstQ7ZdmEKLrJiLZXCiDJTrC2NMdL1VXKtfm5ek6o/VK?=
 =?us-ascii?Q?P7ZB+x6io9HXR0etfwZQf+0k/C9XysX+zWM1o3b8TBHEpXZGNyzktp2nLEPk?=
 =?us-ascii?Q?0fEhBxEnfADvAPCbu1B6aze+eyWcwsM61cxmblbjspDJuL6Bz71R/fL1HdOY?=
 =?us-ascii?Q?RLsIXcaksAwlUK7jI5FDo9gbNsBuCDsWnlzGhUaKVDg0Xzealo8mG5vljZl2?=
 =?us-ascii?Q?i+iXyUuRI50xpBQ84YuLocYSlxHZBiNsxmZRwZb3M3SnDBY5nSbaViqL3KTy?=
 =?us-ascii?Q?IGap4k/4nS+ds8zFENEXIwJZKmBz6SZP3jkSho/6DcJ3+0vQgOhlafsiBhDX?=
 =?us-ascii?Q?q0IsoVUt3xUT806WSvn4WA80jkKc2dssD9tcyu5eAKHH2dAgxDBF6RXLWsSL?=
 =?us-ascii?Q?+WLBuYihGGiQlxZUCWOkR4xc9ZDquJk8PQGhnMbE6Oi8xxUwHxIvk4bVYhYK?=
 =?us-ascii?Q?e7rKkSWj5jXRHjElvVgXVUb5WwpIWbz56+cvnROS7KVw+uAHvGTwb7NBkFpy?=
 =?us-ascii?Q?u5mTbGyOmRnWsZBdEgmoII9tQ0HwSw7YqAHsgW0w9QG8nRiTxjrL+R7uZ3pC?=
 =?us-ascii?Q?BmTK0K3xEnvmiq+zG1YvQv7G3T9uoOiHzRm4Pqp+YJ3S/QYiG0QIV/h259AA?=
 =?us-ascii?Q?tZtZxnHsvxwKdLhrXOEx+gLERHcUUK1w+SDpCxnB6e8IZMksD8/yw3Nuh+jG?=
 =?us-ascii?Q?VlPGTfp2AZ9Z490BLbhfBLiGIaL+Iztj8mUqw/wtQPdUplTWJjpR53/ctimK?=
 =?us-ascii?Q?Yt2JXCyZZBnxY6FK04jgvNfdddOS5F5ExgazRLQ7xfCZa+M9Jph95YFXvyG7?=
 =?us-ascii?Q?g0MtTtMuVB6u7XIRHtJHX+A5k2uWR440DikGytx3+8v7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RKcV33yFEjwNIMXBFa9O87qiKEkR5LbP7LXgElpLJfdKI3w9uKI5rgpRWLm?=
 =?us-ascii?Q?Xh7uiVOHPQTxn+PdeRJgvvB0xriBNEGshlb03JjhMol+y2qYJjzcpPjzD9Tf?=
 =?us-ascii?Q?gFC27WAF5UTKqi1+ZBlfBrhErZc1Cx6TkXPWAa6nHVL70EwvI7hXJJva6fmp?=
 =?us-ascii?Q?whjJIUus2nxA2zqqPTHX999zpjHinfhQ7sI2Z2V2nJFBDKyL8EIlmPKTZI7l?=
 =?us-ascii?Q?HMUItAyx07hIBpeDBd7Al/lM34BXeqdYPeERfCdaQSUduUQSTHTVZWV2PiaQ?=
 =?us-ascii?Q?ccBekLxFebDRTZGeuwe8mqqyqaV2c6Uq1GI42IxmRg9fHYL5gmGEvbp+CAjX?=
 =?us-ascii?Q?iylBSt2tQMxou+0VNH+HsfeDtGCSBtUYrgt4YYH566PIQMJUg4hIhj43Q3oL?=
 =?us-ascii?Q?MfRgvZsf1AKTW1HmhSO1pPwhTy1uaBw2edlB1ip9x29+X48sO2XY8buVP2An?=
 =?us-ascii?Q?xio9VerV9ihgdnyvVTqgyH1378pC8HfKp3srVimO1Iz1eNxmNqIfzPKvlSkK?=
 =?us-ascii?Q?rrP9en1EbKsIGW5MeezLV1xlb6CSg2uk9enPqh+mdOXIyS4gxznmpBPnSLuW?=
 =?us-ascii?Q?8qJog2dh86KNkYky/6rbsQ2Pt5TQdw50+lv3PQPiA1GXRfpz4tPQTC5h4X5N?=
 =?us-ascii?Q?FfJ1HG2syWccCiTokN7yJBQOH2SlhZ8L/CZHtMQqnfuSTr9gZ6Z9AL+gPKx6?=
 =?us-ascii?Q?tVJk4Ebs/a0650sLNsRVZS5w2c4Rm5pz7GrsgVJbwkuHmNM9RneaUVq17QZT?=
 =?us-ascii?Q?tAhiBVDzjkLi9IWO1C5qefFvg0vUdRnPAtF9mdOE3teSmIJp0TfCjwC8XI+w?=
 =?us-ascii?Q?w3BZaOdCQmO9lWHrj3gWQKeuBDKRJq7y4oO8ahrWjoJTXalU2ZYqsz4dCLVM?=
 =?us-ascii?Q?SOGji6c7tGs9AVXoHaGiySSgZQH/7m3z4FkmUO+TycmQSssv2WFNEZECA6CC?=
 =?us-ascii?Q?Ey1B9DmXHHMY6x0qF9TWGezh0UbEZK3dB7tFNEDtLP7b9KTA21cuxl8tPqU8?=
 =?us-ascii?Q?oD7b+McIktIGzXe/w25706ymSyM4kjgRspP4QSRfrU54ZAghyaaR0jFSKqTO?=
 =?us-ascii?Q?w2JD02sGjQlwFVaVgevo3JIOrh0W//lnxJ4VN5B9U0MsqQ4DUvZy5nXc7cvl?=
 =?us-ascii?Q?mXnke6fDbRsIF2Wyukhl9WUrB+a0jkO3QIdE4Mp4lqLaT/ikOiKxu2LD+zGi?=
 =?us-ascii?Q?ZI6/KB4i2XRqFHCgI7iWgLaM6VkrMjaDBXxdu78MEnbzWex93xjtzQ97vzCW?=
 =?us-ascii?Q?iOFYenzltmQlJFgcqcua6MbKp2m3xtSjLdSaC0UcKIUZ7lzw8OszPK5bFC1w?=
 =?us-ascii?Q?7GhkMHRyOPudnPORLac+cYWnT4joelGc5eGv8CMGkSTAT/HjhB8Tla5yZmsc?=
 =?us-ascii?Q?f7b2FEA6YqpJiFtLUC9pP3KQtwnCRuw8Mv74NWclVDOIH5vqxvbIaZQiq5/v?=
 =?us-ascii?Q?uIxj4bLBZ6I3IUnkwE/1GqQuEx1X60HPNxhMjj5ZYKinUmSUfrw0hIe4oGV4?=
 =?us-ascii?Q?QaM2Pm91csra+b16ZKqdeG2KrfeExzB8wJAZofhmLZJ7yj7PeBmfs+geARW2?=
 =?us-ascii?Q?/ctMNJ14Bz6PLnDxRIpdwkK/ylTF12rfSyO4xF3v18q+A0KDZMgoxBqCSDyI?=
 =?us-ascii?Q?Tg6e8TDyYG2xw2qRV+qFbMpgAB7dHN/MQwohXCvWXuUjBwUnWybMwMgu0d94?=
 =?us-ascii?Q?/z4eBPNy2HDdi5uEH7PVA98V5DX9Ivh7pssBahQXIPY8sIKS256YZAqkY2Ud?=
 =?us-ascii?Q?34KaKnWITQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87f1b9c-0c37-44f6-0a6c-08de67b4ab2d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:39.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqDHEGsMRc1kh0H4VpejcHS/hWS/7bkLaIs6pmt19TVbyoQmzpV0aeL9z3rT3ZoQNTVK0eGhAtpgBexqUe0UlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

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
index 50850cb6d287..dfcdcc739ec6 100644
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

