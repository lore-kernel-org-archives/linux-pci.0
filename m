Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566236BCD2;
	Fri, 23 Jan 2026 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134609; cv=fail; b=rQpmM5TJE9LRqP8u820s1TWmBCzPavmWMSHjtK5makv7QDmIniTKQspoiSPSG6xNtBDHCglcQ+qWpAjU2Mve1TE0T7kkGAmZ820IhBE0Hih7FQJIulHDON73AwJVSSCree1+Pn+HoTvbsyFw2YQj7GwOrTxWvNuM68MoCgv4+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134609; c=relaxed/simple;
	bh=dGLGGGayHF1kXMBXPouDMRXOhNmIWfXdQITz3dlnR8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGSJFnZ6lR7r3BPPO1t2Ikel/Rwe/nlYv8f6BxQthp/ZPEAgcx9to8I/MOt5Tewy2WN2Iz/g+h6mNazLFRxcSxu+COg1zwcR4HE/4rAHZlcSONILFqXlcGkVgoo2+CaXT1eYYyw1ZXW9KeIMPNjdArexXM6B0ZmZQKScMrW4Dh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V7pjGLd3; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7pjGLd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWno8VhdE1ELkriTy6LJZWQo21EauxBwB1znynXl4CK7Po3sW9bHs+yI+KkIQLPfN1Gl+SOUS2nUkwi1q26nlqmqDv25LnFC5fBSkGh1fD9Nr8vXJQEO+oNV+Qn5ty14GDS+t8/Es9Bli/cDfXnd4d2Cm5yP/0yaQJ2dJjgr/jQrFIxRnKMUBptZL3sUdRYYZQBmPHYf7dDqPtjoWAcJXs9l9J+IrEPEz+xRYztm/ayxp6v+INxb2DoeVC/BY1YXl1cC0dH28SX5lV2AKEgBZn5h1U3VgC7ualrr2cij2jJczFNWz4Nm8IRnyXZWlilEUZmzBPEnsQdP+8XakQULEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=YEMogC3zmO1/ntzuEN//WJ7hORFaIoWs7M1VI5PaiM2k1+j5rxzboDxRct/5KVU8/zk3jG0wpqmMUdMzVFU+Hrq3ogZRq2tWQI3Quu7c0GBz5r27BZTy+/MmXLLk3rncs+JExWQNKXrfdDIP9dHYZwXrazw88qw9QhRoz4hpgSim4voMHhDGCg4d6SCWa0XrxQTWw0FgKkpcO/uif6/vWXw0xj8RDK1z2/7AkEzKOvO+1i+/cPVcTwg7HNpX91PEcrG9YHUOm7UEc7jDXYljrPBG5XNQzc4im2ggD/xpxU/Yn62NzekcuAxjF3om84C/tVc258LErR6YSgpTQOssxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7MWOqbVCYe/S0udzXx29xH1QVeJxfwCDNt3FnYHEco=;
 b=V7pjGLd3589y3aKMZDzvCoo6DQiG6QMpIJdcGpwc/uh+PliBPIkBDgerO2vgc3JpyRLIOW6mY5qH+7/wo5+bitNOLIG6QMlc3xEyXr7USUPpmvEsegkGqfgQvPtUecAxsK2Mz+x/gjhXD8E5GFfkiD3UcrqVnPfHaRNsPZXmv+3euCM+6X4vhuZ73sYHdJTqPaF3ONL6vJNHvvk7g5IQvhf3mgdMiR3VMTXqEF0+r/p9lJOPJEQBNjV29hvbQbcEExc0mGuZay+4rS4u9uqi+RqCYWw+6EOz8r7fdFi4lvT87WHop0wpgDFwqODLuL5LdLUSREVw5iEOc/aT1HQsQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10332.eurprd04.prod.outlook.com
 (2603:10a6:150:1ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:15:42 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:42 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/10] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:39 +0800
Message-Id: <20260123021445.3782170-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0766b2be-91ff-44cb-aa23-08de5a254f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KLyz8CQLr/E8BLKbCC+n5i3Wc26DfLGbfKUP2Mz6x4XFlytTc/LCX5s/RZcS?=
 =?us-ascii?Q?tj05o/Gg2oafbHmC1ixsWkxyWJXrGfOT2925+ravU03tCJPFkryt7cGoXvj9?=
 =?us-ascii?Q?b/RVDOvpQiayQC22RraGHqtg866kNKmbMx07eNyS4oe+Wg0W83DNE9zniMrH?=
 =?us-ascii?Q?ksOEm6Cq0BMvG90eUOtPD0d3+nV+E60e03wkZPDxDk5mk9WfL/dVyxmwzQg7?=
 =?us-ascii?Q?eNsymH3PgqSzfPoTsP1gB9jPAJu8Mw86kLoIr8wYRuGB7o/OFKEW4r+yivlh?=
 =?us-ascii?Q?0lPCbipfHuDjCHasuHTYLHc+uMlxaAZVm+4rZMHpXit+wYHz8nHq8289FUAZ?=
 =?us-ascii?Q?Z/QrLyj3pOVdZUzl/8ILxFNUIOM/hwfj+8fCNH4jn9CnMvaowoaK3Rxzo+VF?=
 =?us-ascii?Q?71Eh9CQxPzRTf3HbA6Wd+3S2Wuaea6wH8F2GOUb0zUZ7xg2ZFe47f+Z5Vqdw?=
 =?us-ascii?Q?BJWi9nNi7llPFS5GJGldVAYh6SLVtveFzpzUHitEybP4SjXHYodJM353W5A7?=
 =?us-ascii?Q?FsSyk/Ub+XUtcfDELrBJpKUd3kJWiVuGv16nE9gXsWHUPsMq7iaOtUfpqvOi?=
 =?us-ascii?Q?7jwz/YFJQaAYjiNohIjBoiViYMcTaad4njNPECWeHzH+kzPLGq3i7qyuP3l6?=
 =?us-ascii?Q?Z3eoJRQ7HC3qukiy9o4D5qI88k/Nm/L66zbMlzOABHYI+FRsvpvcG5Zj31nB?=
 =?us-ascii?Q?20B5TEf2lPy6M8WdfRFdxwHUCf+fjF9AOJ141KdKN46tM9tByF4QurX1+wHk?=
 =?us-ascii?Q?dcYCkyw7ZYgV8UXQV1jdfFsIBszNyIQKFORTNM+peYKzXV9hYkfA5nvSCs4T?=
 =?us-ascii?Q?gbYbqWBBLwbOjIx8Thm0qzR7A+YZjVbo3aabnGmjDxIfVLMYIPpRpIeJBtGD?=
 =?us-ascii?Q?cSHsC8QZsvGT+LVnfBjcNJBsEDFOj1gCe21/iGU5T+0mBQ2vovnGVURid6Mq?=
 =?us-ascii?Q?ANn5RTO2Ez71Lbp99qkPlb2tA+Oy8CsR/iWnPYktLwV97a5lJXxPEaMU5sah?=
 =?us-ascii?Q?DSTCaADCVfhgQ/p17bvIPfgHUHVmD0KpHLEzTdHrkImLHzPbGTpXOqUFoXA/?=
 =?us-ascii?Q?DHmxhhw4cOS+BmA799wrYxyLSJ0AOcKEzIAQUYsUwHMT3WwuxQTzfmtsyGnb?=
 =?us-ascii?Q?CSYoq1ZJiKfQo0Dym8JLznOeOigzFVfY5AwfUGEn7rs3yZ1J4P21UW1JPTdL?=
 =?us-ascii?Q?LggK73Kx0qfe7avVyDEIr0cCuH1AqP+UZgeR4aZh66FQ9G4D5LeDTq9FsSmk?=
 =?us-ascii?Q?NSR5uq1VJnXHeCtgdGUrvfWm7FypJ6FK9jFGyBMKLmZKQNOMrW+r+7CoChiJ?=
 =?us-ascii?Q?4vVyhe3/rKF9LlXxLGUKpBWQOPOl75KnWMKb2T4rOXZGcdsQTloMMuXPlWoA?=
 =?us-ascii?Q?uk2fv7Chu5PCq9P83Di7tvGlLSa3AL4KvXXJJnN6u30Q92fOSXzMG6uX34HG?=
 =?us-ascii?Q?gSN60hs9ZuXQtEIqqC3VUJu9owBMcavx12k+OUzMhXp2hUFZSoS9AHdmqf5l?=
 =?us-ascii?Q?e5wme+3P9DS63mOd5fU1rQ1OM/T9N2Z1seMWZpOD/PmTUjtcjw7wc3kS2pq5?=
 =?us-ascii?Q?f9RcCn0a5pK6tkjzyhfh6y2I9ae1hVbnJMmIv1n9CmlP0T7kToTszcrWQPYS?=
 =?us-ascii?Q?eVzPrJWcWEavf7Bn+YEykescubpr4JO1nnmeXUj1MFjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9XQQkhsaQoExP10IA6HB7RrNsSrxcw6R89WxVFvZFKpbxyoNma5oRX2c5DI?=
 =?us-ascii?Q?/9GjeNH+Iy8suqqUyTSNLXoE/aQYhTOSfvbI9OQsfiXYsYnFmsXqDndFNsJ5?=
 =?us-ascii?Q?HsGTNGoBrbtb109fQ9c8q18u9Sa8s0jT49sw+lbOK2wZj/9TQCUMLOCBf0Ds?=
 =?us-ascii?Q?ULVY6UdOhSIHGMAEUX5E8h6pXlPqtt48WQHJPEWtAlOOYV/tzZW2SCkQFiyi?=
 =?us-ascii?Q?KkJ3NngjyXJQmZaGZhW2+oLaQ3aRyHohahLh2uq5+2VFUtAWK5zEiE5H4EHR?=
 =?us-ascii?Q?rNeg5HftNHtF9naCMeM5e0wxxUC404toXTd0yxGPEbMWFPJlBjblw/iONXai?=
 =?us-ascii?Q?VDFfpvkwTUN0pZS6V7WDhsTeAdAHYP7/ONxxnofk17X/Sr+cUPKLdv1tfbWs?=
 =?us-ascii?Q?BQVGazsdexRl3+Zp6vPS2tGt1iB5ZDWfErN8tuoOd1lM3Qm+EeJMKPSt5O/Y?=
 =?us-ascii?Q?kZCHj2ycLo/9Pf0Ujczte+Kx55tI96Ev9EkcaDw6H9awIk6NYdz4lQT5FMni?=
 =?us-ascii?Q?z6ZC6hZKBYPlMmxOZbGW42kPpclZ8ib0W7X8gSC+ImytQJRsqvMmy6D21sWw?=
 =?us-ascii?Q?rchxqsgDYzRsAH5bZmNAdDXzHJc59gscowljl2voHgNl7HfIAWAcd06XHUmA?=
 =?us-ascii?Q?dkg73wmhke5huMpmVlCHuXGZaple/mF1D/2HmTk9eKwGFbb2Itjetqoc/gzc?=
 =?us-ascii?Q?fP6kFFPMoDR4zFz3vtJ2FGMHfXPanlY55+u/mYo/Kv8v1dyza0t+eLIKY6dt?=
 =?us-ascii?Q?0rzjfHOaBAGUGZ5kbrK4vkkswrX5i4uao5AXIPUt+6gRql6mAorC35KggadU?=
 =?us-ascii?Q?rCWeGbfLCZ8zlv1/HhueWNTVxbDnpedAihIQHZvB/PPSHp9j8ulQ/jRA80Rn?=
 =?us-ascii?Q?yo6NhzoXMxqHp0fc4KWO0l3u3Dw91+Cne3IOd5vwrlfJOP2NdzOgcY7L5lHq?=
 =?us-ascii?Q?CY40GXssBntWeVPkeXZ2Ebk7gvvzTtcQBmN2FJ7TGebTpy6mqmB14Rt9OMw5?=
 =?us-ascii?Q?xNzOe05qDmHG9ucjabZ4tqGUQaa/PbPPEY8xP+ihOV+wqOxSEpkeB2Sgq8rN?=
 =?us-ascii?Q?e7YN41gsmHrU+c5DOY+eKCq87lO2oY7svmD1b5zGyeNzwPGTV4syhJ4DN2Ms?=
 =?us-ascii?Q?v5tG6X0iOhKyR4C+BtgfrB1JydM5nb+mRrKclhrq4Zf4vD0nHDXndv5+TFOj?=
 =?us-ascii?Q?tr79g1SZpT6cae0I+3bhxydSfmAtK+xVQaQyL5JNTto76mfpCkk7sjfugR4r?=
 =?us-ascii?Q?k8qDQkb1JNOSg9k99JvAm+Ks9YLhtImcC7pfKA1g4Yv7EbCntwZ9E7i5RT1U?=
 =?us-ascii?Q?5MC4ToyOS1OGyeDvf6XQEhMkXvlY6K+vaSsv00FBus4SiELhMByDcdrwUeRX?=
 =?us-ascii?Q?g69cV+URcSZfWPbJeXPKijMkuMCndsvfCVWV7mDKET9yU7KX6kdxLXnGyJun?=
 =?us-ascii?Q?sGgqWfDqQbQ0grC0Q8YjlJHYzWlRPHZ6s0p64ClW8eKCfyCHastxYmIRCXE1?=
 =?us-ascii?Q?u1/eGpVKK5j7zSEwU9Y+hpQ+GlXc4E16XsILACLHiRaUUaknY/OzBG8sR/d2?=
 =?us-ascii?Q?aB8crplgd/RRdNiZXgT2ipj4PWJHYB6zfKiajcnt4GhlGYBMhZsFqgWZdipY?=
 =?us-ascii?Q?Rt8HGMykG2xn8Q7D/1pJotGFdlNc8un/KZobvtOJVYeMQLzTjS8o2FP0vdPc?=
 =?us-ascii?Q?9VP9K9m/NahBzHs4rM6d2Wmqljyv1cOagUZ/uJvf2YqZ/9zf5ccFGSxM8jYR?=
 =?us-ascii?Q?m7+8ci2V7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0766b2be-91ff-44cb-aa23-08de5a254f5b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:42.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2S69Kth5dr35E4kNF2fKjhcTPkv6hsK1nVK2ycyjrQYKrvmxj6HjpUgYcrvzMG/CZoCV8J2ixPClJNsDYX58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

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
index 1426f357d474..d42363cb5105 100644
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

