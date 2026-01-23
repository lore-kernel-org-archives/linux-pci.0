Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D43385B1;
	Fri, 23 Jan 2026 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134588; cv=fail; b=I/JvoYibcBDqbcD/u8fclFHb9F5JL5z370nf5ovA7C7p/kpn/GGdQnMTkGBydqagwUh4jJe818fI/gyWvKaxUH2ydq7WPXiIASUDyzRNARx+CuGk+QTk2O8AkfNaY1pyjmeKg5uDGfuxHUCgc9S7IyvrDkCltBUelifP1I8Uxhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134588; c=relaxed/simple;
	bh=bsCqGmkv2u1Exe8rVk/RPtpssCoCE9tOWWvSplVk7Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYKAsE6F+nLKmnk6rM72AvQ3Kyk7nTAJ1pBni5PyppYCFxcxrhBL7xluoKBKf0vPCbpNLslkF9Lwjj7g2JIhAb3KND2arA4uRxvh1Je/ZkW9lahN6UXQB4TsLUkPawpvZtOQ6KzWL0WmqjMTXQoFtmhXbubYcR2i4zymsVRvCKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HYxHZkID; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYxHZkID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH+YLF5JHzKkObUoKleB1KTLMzt+iuXdu/xrINyJuFWNQoqYjpIPBHgRjaDgtGuxr6ANfQ1/FLuSTiz93wXvWhzTVoOLE8M+ub7ZHRiFJ/r+BmCB0lh7gV9Mi9m3Dl/Hz11fmewWpYsD5nNu5yqhCYn6IMdHwfCTpmd+KlrC3nSDAMz8jtMOLl56/2XMwEh0iJBPfHsNw5FA2n5xFF4ZvVqN8ZUDJgpW9DcMkIqMJOYO2MlcLS8mo/KfzHml3R6rgMkYH/BRBj0Gp3pm49mf6A3CAz1HXf22cqfC9OZtwAK6OKPWHAKIK/q9RUCuzEg3GK0FyQtDCOPn2krOx05aiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=ffUAEVdbNd6xwt4q6IvgvwZatefoG/HTLCi35e7Fpi/thApZ23halTnGGSTxN+SvC+h6oc9obZRhTaQdTGedLGdf1Mp7cKcwYG0LzW7WO6QD9WOOwfSwf15QovyePFOIDHrFmmwMYeevWy2FQedUjXhMve98SydEmHVuAnNSVmENUSbxUE3OfftqlInpzOKX6vK9ozbHX97spu8k1ROfV1xkjvI1FwX0T8cBNQaNHnf8WbR7UyZNUSZ1cXoS0HL3aWi8t0V8DdI0P08oQWuiIJk8OyIbJNpTkTvrCY045BHFCqdgkxJC2sQ+tzPuG0r/GSTRkVYXPBaQpVauDz4Azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=HYxHZkID6AMVgrnBA6uMCi0T/HraZxwYSIIjHwyhdQlluyDaM788vEN/0Xjbk5jgfxItpTClJxCtHQXum5Gm3SrQI/91kg6DzEQGbw12ME6GdpH6TE9a1JZCC7IEywWGwUQolvYe45V4Ml0693OcC8I/+7XN0ZlY+VkR8XRPPMKCKAzcasQ6VcwKg/3KQwdFwX1p1dVgNJlvggD3MAPMsNx4gMfp8PJWF9FYJzNYBJJ3JAWePgfNI7G6uUsotlt6wEep4LLOGqvzffUYMcN7KD0gAocqx+JSATalEK2hXrjunlCsV91fHMnsEKsL4Lri8mYunXCE/lg5sJCEU7QyFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10332.eurprd04.prod.outlook.com
 (2603:10a6:150:1ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:15:36 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:36 +0000
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
Subject: [PATCH V2 03/10] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:38 +0800
Message-Id: <20260123021445.3782170-4-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e44dc73b-76ac-499f-5821-08de5a254bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZO7mte8xSuzNzy0JlqjKpmnT9pcdHDi8mox1l9qHhN4J2Q1HXWG7r6BCGnqK?=
 =?us-ascii?Q?uQO1A5AXD/H8/Znxv/KRsWFeEwbNIEHsC0nBuovfMF2wEoTZBUBLzp6HaOor?=
 =?us-ascii?Q?y40G3ko96Vpcn80tsQG6YJjuujkypnnaY1bkcK+CrG9VYi/7aBheRb7/0ggp?=
 =?us-ascii?Q?V3ptivH4nX/NDmBOMcYpDXOF5di+zqYvT+QxYsIIbB7eV7O1RpCnTMmwQLTs?=
 =?us-ascii?Q?iWogk7ZEaNoMc5cG+UkM1X+5gsZiVWOtUJiqQHkIf+VxyxchkfzJH88GooKB?=
 =?us-ascii?Q?otA0vi09YnvqK84FPYQiL82/OlMjJ4KzleJl6EZsawbzQ28PkMW79/K6WG2I?=
 =?us-ascii?Q?/yJ1Al9sh6OYY+nqoUrwD4pG+Kc2dRylbZtFrkXT5kpMEgxkChoFy0ZeHWKh?=
 =?us-ascii?Q?+8hODGWRlXATkAlii6N37+GXqtVnO6H70W7Fcr1U5CIuGgUuqBtSYrYXmUbc?=
 =?us-ascii?Q?ejE32xJ5xBBB/Vmrj6O81voo7v3yt+vsvWFDe1olRUliT6z6q6gKwFwzTtLC?=
 =?us-ascii?Q?qmdx4uyFffrpL/ubNBUGHb5why3FfGjuNLD0lcvkNWzJINIWsoj3XcfMBZjd?=
 =?us-ascii?Q?6Ng0/KZVlF9sx6TBJPyTA7jQc/tCSueNwORVs6Q2f5WdehCAX/l1s4zBRNmr?=
 =?us-ascii?Q?VfOVyZvdyONRtqHTbj6ZFqs6O9KSLMFCaVgkCXlmk+jPkToT1JKVK5YF7XUe?=
 =?us-ascii?Q?mFweU9YxNl6vfSXL4Le3/3wuQEuEvNdEpYzqAGLFZX1C+fROaeQC4uhHlHm9?=
 =?us-ascii?Q?Uiibz8CramLS3hnH7NVhslrha+Ut3403fXxq9/HfylxBDdDQQBZvF3JcZK6j?=
 =?us-ascii?Q?2KtIYRT/aIAkvForhvZK9lowthdi42/ASF4VuMRn3Ly+QMgThWcfC0Bj12n4?=
 =?us-ascii?Q?yIi+dRU6MVBj5ZW4i+5y5v/JNHqwZ2l6X36pZI8jzoNghNGufjGFbOMuy1SM?=
 =?us-ascii?Q?nWoPZi5t3Tk4et5w/UaAhglUIhpKJwMqkiplGCNJt1Bp/6S+LoiuRQcZQHlM?=
 =?us-ascii?Q?yecXE4mmVToq7/GshqPYZt/4ZEAh4xA7osXdJzNZKvCtvoosUcRPuny6UeAy?=
 =?us-ascii?Q?61zI/Ly5noWrZ1fMyHekTwKxgFCksvt4nj3+TQEvLRoOKUKHQWahzkC3XAbd?=
 =?us-ascii?Q?ppVf5ZdtBXHr8Co1Ve3Y15LI4hYwbhHnHZ360+fz+eQk2t6vlXBOPeLpkuQv?=
 =?us-ascii?Q?ZtKTxNwrpkdXwSz5tcrxP3utP4munfx2bSFw7NRoblNCH/ebrEtimOa7YwIX?=
 =?us-ascii?Q?dSM6HgLOeh+HZ1nrTjwKCGQaGxjJhv5frl3fNgPKNrl4AXci27192+OFQuYO?=
 =?us-ascii?Q?Gl1e/V+eRHmNGCKA7P9s0Zs9xbtucSR02epOprQ2IhbRX+unfIHqOZiU65Qs?=
 =?us-ascii?Q?l30Xyh6iz52X2lphLcAXltWhBbLK3WmgZyN9XeDkM6T71y83fnjKbLN0yB1D?=
 =?us-ascii?Q?lZJ3oclcP26vRSyPtTS/3BPrBNXhVsDoAI+glOi5/h7kH5fFci40MnNiYMP5?=
 =?us-ascii?Q?COtoL3sXQ9JOnFUUTdkpedNO/lq4Ht4cMpJOXtTS9Th9V1w+OObvx7B8a0ly?=
 =?us-ascii?Q?HySoAXwkHSNaGhInwdC8kzmgTOZnZasR1wb/ABu13chdx+tl2oNdBFXv8KMd?=
 =?us-ascii?Q?YclDNfMwrf/pUtR7WoSDvUfXBrp8E1ayu1MaOG2Fo9hO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdPK51dgRl/nuuAZ+MgnTSxkZYOIn7Cakpfknw6EN/u0GuQB/3GI9ZgsTufa?=
 =?us-ascii?Q?WHJxWT1lV4dcn62Rjsukztw26UUuADkGZSyXGahiQMj8gHLc9VXYV8u31wuM?=
 =?us-ascii?Q?eGVRwOo7Tb4nVitbNExXC0tQM1zdpShJoGBUdog2BR1RV8HSTBL+cZrZNQKx?=
 =?us-ascii?Q?dvtuzKtWmxf3/XUOKqwmnHQE3yC5TRaxVqJgB1tlSXv/Qg4SggCaf9TR9vXX?=
 =?us-ascii?Q?rwsaQKkf6ehDTHL0VVPvEHKYBefFU+h8i7sfJN2qvtLBmjf06BPIYyH+Fcl7?=
 =?us-ascii?Q?h7T5ra6F1+idLTMDIKh69UnWvZW1uZqfpzrwfj1SsnZgCAerclSRGouwH/gK?=
 =?us-ascii?Q?AHioaShzfhTtq2QAemVrsu7KfcotABxRA1EZge3M3MMeYy/MRcQGgeTdtp8G?=
 =?us-ascii?Q?JKuPLh8SuQNfQfeexOBZUQZpmxbhskzZBu5jlHhypCLzC/otL8U5twRlHTwj?=
 =?us-ascii?Q?xvtrJoA2+icfqqpzqG8jHtTUZTra56XETTwcUnIGaXzjxfhRy1kjjjyXwqrk?=
 =?us-ascii?Q?UAdoNTCMsftuduEJlFGeFNiNDgYBbZjGRTKR6hu94TC3fANTuzejN3p1L4OS?=
 =?us-ascii?Q?LsAtqVcth1dq6AMN5hq0JQIB94qCawOyqtVMFFc/i7U1GpO68SoDkyhmVd6i?=
 =?us-ascii?Q?EFFg5zfj3Pg8uy1ZITgOJOx4CXsnMCBW3QsmDcC/g56c22tp238atTPJMgTR?=
 =?us-ascii?Q?wuaP/yntYLaKTc6x5xDB5Zcte/9FpOZSMwElK/a/aui5G2l2Z2sq44qyc87M?=
 =?us-ascii?Q?0lp+fUwMPX4P6amI/ZowZ8DsB/Oz/Vv89bUuqp0olvo0T5deUlVWXvvndCYq?=
 =?us-ascii?Q?OHDj08udIW9smJWy+cxyCpeUzXI+Artl6Q+/1Tdmr7L5ckprhLpAoupujxci?=
 =?us-ascii?Q?bp6mVJuwWUtznU6U+wWZBb+IBM/MbS817Ni+OC1ZjOxvhFgH+k6ewz1YHThE?=
 =?us-ascii?Q?iA+DXnaNzj6UZRifmmUANsfvNG/j+thWn19gwEgo/v9xXI1aAllFZKT26wDo?=
 =?us-ascii?Q?9+ArX1hx5gK4UdyziXMhMdJx9GgSD1MqvLM48tMxYPF39aBzoGXCSvlPlGQ5?=
 =?us-ascii?Q?aqwdTZBu0Yyi+jWxmsy+f0RLoOsBH5bP8oN5htJIVH9GTFDYmOjoE3toL/wd?=
 =?us-ascii?Q?z1oqS3bO9J6bRcey91BImdGFktQkmSKHGIx0+4AjjPrjx+y4ZkHS2DvHw9vG?=
 =?us-ascii?Q?zHEQL0yo5t9TxHaSNoEIbE7K+aldj5rev9h94mVrfIFGdI/jQBYdfq1p+LiZ?=
 =?us-ascii?Q?+asp7FAXoI+OqFYV2k/efztxEULMgIq4SQhp3NduPv0VXrhptUmZT2RUJZ/E?=
 =?us-ascii?Q?NzD7Rp3N/GkbF+pxwgKtKKT1rMTBzXfmV+YAJGm4rJCSKqRx7yvBOagZmbp4?=
 =?us-ascii?Q?09ZYwRs8oc9qYYfuT6R8RjiRBV3ns4Mf8gLmP9+IeT/x2pAv53tpiUrFpoIb?=
 =?us-ascii?Q?Lmd11vEasq6BHnj4qwIlRfG+qr55MjmMCKOVWUjJmdXQYF1MY3jkhYN0Dozy?=
 =?us-ascii?Q?FIg6JPGavHMg+58oV8zKI6Wfjp0+kICanaUBnxHXKKLuE53fkcGGrA+40hYr?=
 =?us-ascii?Q?zEBHOwMSO4K8N99o371srwnqgH4VoM8tvBG7y1AHxFr4iIczOarZHWz8Qjk1?=
 =?us-ascii?Q?UvMcYsIKjT3dFVrBCqUNqVKx1OslqCuUbicWB10eI1sKfsgmlNbcZez6a3M8?=
 =?us-ascii?Q?5EysgO+VV2gKkL5asLAw1UyM4In5wncez7Fn9WvkXYAXh3ZBmpAmVXYTNnNd?=
 =?us-ascii?Q?T4dfXysvdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44dc73b-76ac-499f-5821-08de5a254bbc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:36.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJX5h36ScJMAf16DshE3jzwQtD1KB5KwCLL/QLaFGFxnWiDq8+pvFV9uXlTCSrSQoDxv5KeNgx5p0v3WcFDmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 76e6043e1f91..eeb376193398 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
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
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1

