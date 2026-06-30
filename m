Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D32E7371;
	Tue, 30 Jun 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799529; cv=fail; b=ku4wpEd1PNIJqok8T8bjeb33/avjEJaAX0hBhyhc0N4hPM+dpfr+F6tsG+6/P2KsGIXlxy449m3s96pi4krsu5a+AbJ81zqPtsajmhbA0Q/kDOeuprY00M3a9t0dUlkycgSs4u2H2Imvlc0jlM7iH7wgVTA7KNReoCNMyDHCRNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799529; c=relaxed/simple;
	bh=BK0R2hP0hxFWbxIzHNNbosZvXOfzLxsX61t9s0xwfPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOR16VXkIl0utaUTJCbiB5QZixFwPNvOYHDmY7n0bR4HXyoAzTX39Xk3ewWkbO6+sl+jh5nlnF1k7zdd2CumK9SOqJ/cGuBgkarY3kkzhYnpozmg2g9vleYapHBZgrirD4YzamNQVxuvI4W7OlGANQ4eGb11ufgYVvyJLXXFwh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fLpI3wni; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fLpI3wni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLlbAME/nU6ATZW1wLL4zV0CFqJneoNA0n9B6VUBd3PojtCqniFIPqX0nc4C7Oz4lOBavDK4VUI7y8V6U/4cJCXhw1PVLVqTpar5tQw9FZRIynA0Vw835gY42FNFkhE5WFziG2dr5iKau0xtpV6Zs9a2UXmt47AyWBx3OxrNpbWGZnlDfdK7Ia13b1mG6jqOsZgLgW1j3kjvXbp/MUl7Ffg7wvubMtesLY1NZ5lvJcbwcdkDDkaQ3/zhImsyGbYTBzqmLZw/sl+KlyjRty8n+9nFTIFhNWk9hqwtMpp0oVERcQciQ7QLM3cwD1GZ+nYOw32xeWHThvyTy18TkLuUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmKzmYu5L4/ovbWG31N6rDik9VdEpQXb1Oxigz1/+2U=;
 b=AHE1xwqtWxHI3dKdowHmFF1LbCXtRsM5eSZQLazekS5aNO5EOLtdE/0+Lf6AiuqvPv12fjHBhITI/0MUV33ykwHlYHh+/fHz+FeQvZKD/3NlnyXLLuXNhuPCmRtgtlZpOf2X5v46O883JQCGO/lfqBfrQcuTCnC6EElc9kSDzs+fvL8wMdjqR/LJnisesorS6CVtmwrN68K0iI2IyjU45Gd1LbDNn8sdKPh0JxAKVIGY0uway67b8g/FMC+iBPGi6fZz7DVTxb+biVxfIeUZOXNLkXEq+h5WQLBWopvmaWiUUTpyAqvKEs0MFSZQi95z/c87zMwwUru6CmCHDjl0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmKzmYu5L4/ovbWG31N6rDik9VdEpQXb1Oxigz1/+2U=;
 b=fLpI3wni8mAK4cUrHacsl2jKa3NykwHKtHcITGFSsKPIUz75venHUDXFfex0WexjJNXociqd1ge6r6sdwloxA8NqZqisZG+1sYYg4iTYNr+Y4Tepyae434nUD18lvH8dQcjxdlXDJkRBENWoYFTJsRJvMWn1joZgjC3sAmXO+byre7qwzVRMyr5ApbyxoSlaSwfDj7c5FJlPfD7DjkjW/fBXpirw76zt+wWTWWle//Z+q4TJZdDN4+QUOiFxD5zPyZgHDaod6UkLn+JfSYIfexZIGLkd+teKLuwGUmIc2KCy2IGWmoDaibL2lydA4kRHcXI1QBgU/W6IuOY47U64OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:05:24 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:05:24 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V4 5/7] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
Date: Tue, 30 Jun 2026 14:07:08 +0800
Message-ID: <20260630060710.3294811-6-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6036663f-4f74-4dd2-19c6-08ded66d9306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	usDdNh0d4xlI8TY5vPyLhDONWpSxjmQh5b90q88UOv8+/gdbin8W1SL0r5oUsDciaM09g6aI+tjyJTswxqxvJaWzGieAtL0iXPNSSdbr3ooAWItFkNv2d5Ox65yM2S5kVNonbmDuRWGokYQCOWtoEWDxTseicpq4B6hfQRvzg9QxYXLXbXvUI9LXvq49AbaLoQWK6EYEZxGqeQB4EYS/uuLgw0sj9ITYtfmU+riZICBtdHTNb5eD7lFaqm5biUDL27d9VOcR27cKX6xfavNPZqu5QSQY7BRVC/EVt/rDU3roUWqM2VSpqhdquK1/ogvprGzWSGpdF/VEsGpzDJyZDn0Ef3RVajjj5+0Usxy/RhIhBzVPCRUDTPfrutGpFY5MlHS86T9xBapLnxDJhmUyW2knVAMQ47t6yNSqrgba5c1MuE6P7vXjpml3uhWjFCQ+KfqqU1nzgP2ObhcLvbTLC2bT3OcIbU3yTmTYCFs61on9O2prLm0+T3SZQBt6mCLWtYztleZEaiBzq43RfqV/dEjybVDS7Osa/gst0fgxszejnPrNSWX08yFvSPpyZclOFFoDYrsPaZ9rxhTsPKhDi4u3q/BDqp1rpKbBMrgpcvTb0ZgpayrlttqTlCFj7VFF+Us7q76JvDOjjIcObtn02gVYMixKQ1zWpUVI7GodEKR06XcpA5nWhCfGSbhAelywrUCdhqytiEk79xkMFxgh/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R60Smemxs/IbUvt59L/sWhda7jmR+C4gl4wyOHHiC4dE/9tMj1kRIR08Q3Dl?=
 =?us-ascii?Q?l/CeUVU/T9ygz/81pG10ZsC9QPgF9KVfm3bmLBsrJv8YehGjN6lYBBThiPFC?=
 =?us-ascii?Q?YdHP1rUHSzxqXlFYK3hbvpSXBkoejT0u7a+JzF3m+gM0QkWyxUQWfm3Si53c?=
 =?us-ascii?Q?6FXOPTzer6HF/MAOJnlzo9l97/gMPHgwlThmkuNA+QvI8SrK9kGUvU95tU85?=
 =?us-ascii?Q?u/ZjgAFRyFORPgmjfpj1KUiE6zBvR73bW8ZWQQFdE4X0vrf5qeEENcFeZ0QT?=
 =?us-ascii?Q?dE4c0BthtvOwLpz1oEcUTcrL17b5bIL4LmX0eTt/5Lo7HE7wAKxJF6IaMCje?=
 =?us-ascii?Q?j6FI9tfIfhw1JWQvCd4OuvaraZGXHM/DpvBiFKF5Bi8PTKzPnEHYhanDUdNr?=
 =?us-ascii?Q?pNvOAhxMC44vFtGjonYhW59eQcCwcEnc7F1swF5xTOX4y/rEzksIlRRZMkiT?=
 =?us-ascii?Q?hCTh1XFTgHlqc/dPj8qeeqU4/SJIkNW2MsGMCAWPiYCMMhQVw63WVsq4dbBc?=
 =?us-ascii?Q?9qcsQ4fvnipBYdZ8MRgXnCGB8pmKlv2NxPdmzfuZKIZI3YRLtVh08qW1nT+o?=
 =?us-ascii?Q?j+oNgFZxxsKjfNTWRE88FruO8oon124H2PFg2rRr/QnFBvZ7HQEJYBimN8Wc?=
 =?us-ascii?Q?XOA/EjHbMh0VVeVc3c4ktnvYBu7QTOBXZ3JrcEeN/LjRDpxx4+aWWmBGlKv/?=
 =?us-ascii?Q?g3UyRkFJa4XjhW060AcNQ2Fc9Gbi/0q116EC+hQa7S01svZLpWD2XzfxOS58?=
 =?us-ascii?Q?U5KMgZA7kuWlWJlErdjwfLdlDk+snXXGQeb8u4TPZ6ilUVYbVhdkeBpPwSNa?=
 =?us-ascii?Q?5CXtf7XCksmEVs7LlYqvj8iZqud5Z8Pl3IzoygtN/3Yn+YcAobRMEcb9wUPX?=
 =?us-ascii?Q?HPaB+2OA51amLcqg6dGfGzB63u9DHwIxl8yqTLmwP7H9PTp/IU0hfJ6nr013?=
 =?us-ascii?Q?/NUCS/7c344k4ZKhPGt39TBtvQqKb1eAgDtP7wwPF5YIG7PpSOb0B7V29niP?=
 =?us-ascii?Q?AxJkIPf8Ay6MPOGME83bdwm3QC2vK3TIlRJXshBZ+OE4m4h+Yjovyed+5qgM?=
 =?us-ascii?Q?h/Hn7tjh9FPHc7XCfCK4jZ0wED11l3twM0adURjUA7t1bexrW8kuA/xc89GZ?=
 =?us-ascii?Q?WycOOkDZOl5D9uw77uMKtYjBkEMjKxRYHlH5Sb6evijQfuxyjZVrjVb6Lzkf?=
 =?us-ascii?Q?ClAezDRzAZcwvSd87wiVP1kmfO2MteocilxdzeH+wNWQ1mtfXzvFMg6lwl0N?=
 =?us-ascii?Q?KtYECtx7k0BGa6CcYLWCoIYSLo/1xHIx896VmhSTTSwrYOgLDb7zkzO3L7xS?=
 =?us-ascii?Q?c3A39slmTmQcu0s2lMr1k3s58ZjMPnnTzYuh666NBFH/J6SokIy400PNlxz3?=
 =?us-ascii?Q?lOF/TZ/Dxd+GRP/KBpJieck9RhOX58jvnswGpZ6NUTKu2TkkVqOu3f17JjLd?=
 =?us-ascii?Q?r/OQjivF0PrkIYf9E4wzrbrMGe8o32mN9niq1TA8l9cQe3GJNP9bI2yvYIlr?=
 =?us-ascii?Q?ewg3D8fTtIGpR96ZdODrwDrUTGSSjTl8K4MhVVzFOmVddkjZbgF0C44Az6wq?=
 =?us-ascii?Q?SEPmhkGjsU5zx3MbC25NNV4I3HaXATYA6vQMwm5qFr0A9R9UDuGfXzn0CRoC?=
 =?us-ascii?Q?ptxWhuAtAay990+njQwJfJhZKQy0i/fpsXbepBVNWLPuIYC3aSBz1rsLU3UR?=
 =?us-ascii?Q?MPF2GFeGyS77tjMHXmg8zx3p2nEcpxy5Kj1X91zbxlU9nOXyIwxLtbNmbZpq?=
 =?us-ascii?Q?LGFHlK6YNEBj+I0jNsbxKPzfm6e1GWzDcPoujteUoPjf7vKXHS3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6036663f-4f74-4dd2-19c6-08ded66d9306
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:05:24.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoCirJG2gSeJ6e6Yw2ICafM+YdcNfhBRUlG3Es/vlVuMZC4yjSlMntFtkS+2wXwcQ/JL0RB5bsylz6MIwj/E01zF83mosLgc2IRlWk94q/6uHRYzvSQXjaU6oAij8Z12
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply properties from the PCIe controller node to the
Root Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index b9b03416aa39..383a0976d457 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -403,8 +403,6 @@ &pcie1 {
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
 		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
-	vpcie-supply = <&reg_pcie1>;
-	vpcie3v3aux-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
 	supports-clkreq;
 	status = "okay";
@@ -422,6 +420,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie1>;
+	vpcie3v3aux-supply = <&reg_pcie1>;
 };
 
 &pgc_gpu {
-- 
2.50.1

