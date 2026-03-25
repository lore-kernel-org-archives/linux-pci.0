Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255CF3B3887;
	Wed, 25 Mar 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436526; cv=fail; b=QoYwa4TOlo4aFaB3GvXsVk4BOe07oeuWT19XKBzZMXtN8Cs2b5rPxQUL1uKd/sO/RO5WKwjbCzBEjiudG3MA/0hIndUa4YFwOkdJpvmH2YVy+Chrg3fBaN/OMvVxjWBJaR9hxOpXhrN9+MjPAteqH95UmFhFfY3hFC+3rOL4Tew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436526; c=relaxed/simple;
	bh=+AmoF1XdUXTJeleE9Aq7sQkCUTiNspyi0UDWCgJeDN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f2fU0tzflBsL5Oj6epJmF4Mw8ujdXtFBvdEtXZbbaNncMoWM1hZjZFQ5O2WWcAR7Wowu5ZNZunLxWFTFgSjYGuLWr25oObSbr4VpxR4Yshp1rtxQC+sgfegFFWxzqf091OMxGCmDhLIPAxE7XMqy0Dqi1lRffQLM8HVDduE/LAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Az4mbn2l; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Az4mbn2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHP1FtgMnw72luWVoRtKt04nU7Fp7ettpOe6lcNxZOejS0/qYouhKA1TSmUIEQliYfM3tW+cJPG0uetnaD1tDZ5IHEKSMAQiDdQn4vOor9s4Hk/c3bqmkaO0EnOHvH8oeJlRb75zsQnvvP2Wzd5DoSIXBBbxT0lk1w7c6rvAjMKS8Mwv0TORrHthuhOy2ncndUKIr5y6EL+4QM1XlYFwJb5VSCTHcQvpv/VxunZkt0DxgR+WeL1AStZ45BHc3aOj9FF8gWCnGLMaJ2KoDOB4txMbf4x8751qp99nZD5xGkjUMRUXgKYvMEPZFDc6YJxCTDeE4dl46OovOcEKukIZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLYqVx2OujO/SH62Jn8GFi6bJNOQ7tsalujPJgFHOm0=;
 b=mYBe0rZXFOk2hY0I0MpEeV2nePUrcvyCSzSh7LDCEeZ2NwBikUhZqcOgoTACRop5XdBkeE8OQ5HRYJmNBbA0LOIAjS9JtX2/khsK4qSd79Cf/CsGxifzpUfeWN4vl9zzi/Lv4wjlKtKywUeggSp8foXeDvH6GDQSkHTeUgEDEdsD8Rix4ppgcEStmbia38xm4ND2TNe6jIqJGsgff1qMje6nzMFXOGYvvP4rfqyYCXy1q1klX7ulm+YlNjNeTxcvHyNEp432cLK7aKLUW4ipfZuM7u9//MFLrO6scElxconBpjAOHQAr3TZ/eeeYXsxUEs+/DVYkrN4QNk3RVCgzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLYqVx2OujO/SH62Jn8GFi6bJNOQ7tsalujPJgFHOm0=;
 b=Az4mbn2lfG5ULUg2v0y6wA0dHUgLvR1Kfy+6UZ0KG0IQZjKyANd/tIEx6NH5kmhsCpQCElMsodELRfACWhKQZtn1eiN5Wg4rSf6lmS/nNVXOg2F9E8/ij7B1LgpVzt19BwFzwlZ/GqDgJziUAwC901+0e/pZ0oJkFNxOdqCOh752yKASbKDllwf1IvCWFkGpBveqgKR8U8uDxZY+5GnitMKeFfWRq+LGMNFx0LH8kkLvbQ8kf+Tu8vKQfREDuI1aL+urlXtb1kKsRtq2Cs2ziFIdIvQXusSMVmaw2EIqF0hov4IQKuh6kGn1uxBR4ndNE0DBTN0MofAM1mEdZ58Mng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB10398.eurprd04.prod.outlook.com
 (2603:10a6:102:44d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:02:02 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:02:02 +0000
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
Subject: [PATCH 5/8] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
Date: Wed, 25 Mar 2026 19:00:55 +0800
Message-Id: <20260325110058.2854742-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 313953cd-8684-4706-ab05-08de8a5df155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|19092799006|376014|7416014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	huR/duGCND+LUiPhMLEvrLQhbJMB43nbBg/D8WruuxIZalCn8q1/vt7CX+gIzcOCqYwVq4XrH0pn5PzFk9z8z3PuRnRYq0HJ1dgUnn9doicclu7rSp2+rw8aniiO+T8aG+/8fpoVTZoK5kU0JQBpGms+Fle0kM7JX/CkL94DkCP32iHyCpHsf4vZrPFU54zdZ/3e8R23LSnTB4RKXA6ix1GJ5bw/CILO8TV+Vy8HMXSrQtWKC2rkX1NvhYxzHWDWgE+QXxaevtvEjpWG8FkMyLRu/UFHs8sa89NzG1M41uVnsIoDDkBsgKEDFMvGMdr8CWW1VRt/KmK7WOZKBrVNDEVSsVY1wrVkyn83Ckw1XbF4u9TgAFDUwmRseKbUE1OrxQ06arwsZIjKjrzoDFjyfx7YO7FXKi1fJs105S4L8r7Yaq8rs3ScGOWoe/DBU6LPkF6B/fyrjhmtUorWghrEvcx70Rg8CNhsVJBclMK1BKVIzc/ptImF+lpujso+yEWCTPhUPWkPRv0H30cAkc88M8OPhjuvXu/TDP2kasmmmrshNDZXEvHUD9UvqZFqekqY2DUyi5dFS+qd1YNzb/E8M5cd5Pm6KEvcTHVDRx4W2kzvPbYpgJiDWcyYpGSXJTbc5ZoO2LMeZ5HB/wNcoB5sTdx76btOorAuhrk08P+mZYvau4cpJxpUuV8glxfRSsuMoxW8olYtjNR+m/fKYknPQ8dsLvGMCKTSj8xhDMbjwGB3EmiuP/foLBTcUruQT30mdwnSklZAbYlFB1NlRLe1vCvhJjFQJNBS7OGS0aeTCFeOV25O4jTvsjbbiKaOHQ4z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TnM6zufOIor4DAaTos2UDrzjkue1vTea8nifLkOmkXx/QUKKvbJ2xY4q6I7B?=
 =?us-ascii?Q?CLB2qZU3QrZRQ7RlckDTbKx7nGqSC48D+f4mR/5F1FAzZsv8RDe2c5UpKdqV?=
 =?us-ascii?Q?Cfp3ENHVSbHdntRjLdh6XLOa9kLc9upxQ6QUCnhC6/40culHZrQ9N1tCAojm?=
 =?us-ascii?Q?6Ubr99/hxAahTkPfri0dqkYiL+xGBSC22wHmvh2kvczFbVrrFCuk1xHdQFcu?=
 =?us-ascii?Q?cycqlBCZPBwASU/R++8py6b3tsYuib84OsKpU8mi0GuNafCmXbZjJgOyzQj0?=
 =?us-ascii?Q?j0oPPjpKtqgs9++TtUddo92TLjYV0FXxL5peB9lvkfWkGdkcGs14zthBnk+0?=
 =?us-ascii?Q?gT4XXx/KcZWbhKOrzh5TIWVTe3ML866P9SM/HAqCFFdxpoQnSdjMLJGClXKE?=
 =?us-ascii?Q?BvpF7N1u59DaAWNCDoqB3Dg5xgyJmom0yszhPyPpjullaXlSceRInzr7vJ6a?=
 =?us-ascii?Q?b+4G0wHUTldKhILmVC7fGFpWbss1grfUB4e7FbU9+vTJtFnxkQDycygTv9H4?=
 =?us-ascii?Q?sREsjOcNp60YvzDDeOsphL5odvN3mDuk8OvIz+3lNe4g+k1aEuGXNgeUxwDI?=
 =?us-ascii?Q?vth1w/5OqIBX2S9j3u5d+nSN51hbq+J1GfaKJkiO3St2jnSZ/m296wq+tr4V?=
 =?us-ascii?Q?QuTOz1nyi9cyC8EPEP4IuZIzDceJShAUIABndJkYqn7rF3MkyzqiOrip33Vj?=
 =?us-ascii?Q?87bO/zFB19VGNJwmBnc0n9feMvM1ewtdjUIpECsL2WkRE5bcE8WqS6kDT4Oa?=
 =?us-ascii?Q?L0zd7P18tQXPEQ96KsFhOZJ60Frge6LjYyWXBIsopY/q/F3iSErbs7yFBcvY?=
 =?us-ascii?Q?jSNYMOd/UKZfTqR8gHqRz5+Ogxpzq7F6q4yQjUHHjCFN9KMQWQ4KvXvIE82F?=
 =?us-ascii?Q?FeHzF89MHfxYAR2erHyfV6h9gbyNB31WhyuafJaU36/LoJF2Q2lKbLgWSUKg?=
 =?us-ascii?Q?VkLAFBJpPFaC4Z+ScoC4eXxnKNnwVR6IhvLIfbEK4n7I4tQKZyrAGhKj4o4y?=
 =?us-ascii?Q?juMwM7izRnEknrrpk6ek7cBwRCBmNFrBY2Mmcl4YpoFIfCW1Xs/slvGPzyst?=
 =?us-ascii?Q?4knzkpyPDsvY2Sh0aL5Z1IdC6w7Cdc/nay/FWlPqXTU+abdBMpKvQV8LtWUO?=
 =?us-ascii?Q?oHoR0Es4Z/gf6JiuaLzWe5Im4vtNOuQd939fBJF3tdVtarOo0YTGK9vrRzN8?=
 =?us-ascii?Q?y1A9cH3EAQzdWhN/clhRvVpkrf/CAWcsBvDlQjGDM6VyxseiDLQT+AtBMipu?=
 =?us-ascii?Q?Ev/IdvnC6LgkwlQJR7lsqJw3WlCXHsIQQaV8Ki7bODEBoVB0WQoVmSp0NxwH?=
 =?us-ascii?Q?8Fy06gaPnVoX6ubuibczjjwirIo3WRJBoqTUQMyRkJQ/7t/L80f3HejVA27n?=
 =?us-ascii?Q?Jd+zolITnHvGT+8Ja5DOnilVVOZBFxoKyXFBg5X9PH1ze709RsrUAF/rID7B?=
 =?us-ascii?Q?fndvGrilMWz9u7V0PEiZ2uYMYk6YworXrR2lN93YeN+L4kPTT56aDfQxrU+U?=
 =?us-ascii?Q?MvPC2ZV9GOaUr0ZaYweXMvk4VuxrZWQcK5mnjgTSZGUWgpWP+gV54WTaIClE?=
 =?us-ascii?Q?Pm5S6IxHwCQMvr+2aasTNEvmGVO67/vLI9CFzs0+gBMhqWdwSYh9TS7/tHp0?=
 =?us-ascii?Q?FWanos/yqRHwt2W7cjeCGtek82OdOLnL5FxtS1k6sgIJnM12r6SSNoUVZ2Ze?=
 =?us-ascii?Q?ABrXhSy+JfHHzWjYyRl99x6VElWaysTloxYopd1yK1z3eysu0mgC2tdDFFAP?=
 =?us-ascii?Q?QzEMv8wZDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313953cd-8684-4706-ab05-08de8a5df155
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:02:01.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJPy4Fg366I2PX10eIhWS/Y/HCH/klxztZDaDX89jUhlQ8cceH1FMDC8+7HsrE9JFyKl38VS1SH03uo6XhlBtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller node to the Root Port child node to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 2c882e09ed4d..e2dad256cd4d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -771,8 +771,6 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -785,6 +783,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pwm1 {
-- 
2.37.1

