Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDD2D321B;
	Tue,  3 Feb 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083757; cv=fail; b=LZxxKuUf6bh0s1fpjSPIdjMSkg3NKAr111lw+PwrTYUr+tsjG9H1KmSr7kYjGYfUSod5za1B0x7UNx2in6pUQ7GJq5doENRQHCJsqKxbv0TBeAXAUqE+bhZO1YZj50br0aT29dav8zGKEON7lKMbUhC/ntSG3/WR1r7IeTp7aR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083757; c=relaxed/simple;
	bh=Yd2rYyVPnI/NtPSUEej2DU5oRYD3WYLyjDgR2A36ykM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcEka5cYp9U+LQGRtYzpzbumvPLBNei/JM+Cdpiv5XwFIspMMUJ5yYzXES6ofjZFlV6Vg57YM25AzZqChRGmDM3sIuNP1MvpOeAYOTX2iukHnWB0lQUtXTg8kdQlJxVGUI4/zKHj5h4jAqfp30vbszcAt2C7xer2rgbS9vcuXbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxX7/D61; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxX7/D61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovqP94YM78u6T+gFFleONQhBAoxABdN8bFa8Inm0HAPtNfedlAzmHMnFpSYJ1CIG8UuL/DzsAwGKdfXfVw8ufmcuLY1z65ZqpIiY6hQLaAG88PH2oDorQOheBOnxXYA5JMFc6uY2iKZ6JUBwOfehnVpWaLELqsUnQBdQSV+3XQ0mEdSI132teYoARXbFnXtu8rHaZWdIrItQxH5r3nDdUynniUuDA3xm8hGlZmKb/FPau09/ySXVLgJmgJ7z1TikzNHFjg6FhZ1tn23ddew+bEuYfyVDqpvZ1HxAKZqr0Q1avRz6c8g4/VUDumACifMZHFW4CbbG3z7gQoOh2F5qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gboInUYbdyhxKo27lO7q9QC8e/h2POTBxZYRuF7CkfI=;
 b=GEgO1dlwgWCAybYp/ljyqhiKFEENESXiccfizdHfAUgV8SYm6Moij/wBzj1By6Z8NiuO1gM14xbr1fYlLGXPN2rt4t2PNtvuxSju2xO02PfBO5FmsIo7l6Ab2HsqkOe6QPaOg7t/TaeA58QgztK841Ub9+VJo//SjySO0kLzcX/w0d1CaOOls8wAEfY4DPilmKDODjaPZGd980KDNV1u0c1546XN6VY5yfGj9rsvtxooEHlOfuNLVR2vEcn8LLlixDdFnSejHwvcbIAXH51vmZo+JFZV26iJKUcsrnwNBJiTUbQpSJwxKq+zl2PhS2c0Wi5nezyASjqVW+LBb1R1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gboInUYbdyhxKo27lO7q9QC8e/h2POTBxZYRuF7CkfI=;
 b=kxX7/D61ssCGMANNP/nT5D1CFd2CuasLVkksSsWwsQrP+xwKSgc8iozMblXL9nORNlBjBrpqXXxIGqmHAMDnttWxNZg6LMjTKYEBHH2qKQ68GtYJXVOPeUHIc8EU1i8UAjPja6mWWhGYn8zUms0VpwMJ1OZJUxPiOKKjgv0cmGnhDn1MsadQZI7PMJXhrLRCVupcfveWG9P9aSyFqLxt1NkYwcPY8zw3NGrXuXJStYmQcleaVkBvAHxaRfpOfq26Mj8yH/mZ7d9mTiB8bxpHlehFlExt5W1uJ+6OaY+RHj6gPHvC+HawHObT8rAg5yFqcTS1phtFTQAnUprbHFsS0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:53 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:53 +0000
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
Subject: [PATCH V3 06/10] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:10 +0800
Message-Id: <20260203015614.2957479-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3335894e-5406-4067-0e19-08de62c75d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RAvRH0ABxOX1TaPnPldzSKnSnZJUNxkI32Y4cKalPTGSrYGt1AjT4Xx1+LGl?=
 =?us-ascii?Q?a+y5ZCDuJeluEhXgsLWeGYWx8RpO22vtESnF1X6b4OPYQG7+2EN7odQhqvb6?=
 =?us-ascii?Q?Dp4j7s3UKma5t8CLF/k4p34DEC3+5CNftjfMnuS9Iaw4KZEorGT0zj9i+2nQ?=
 =?us-ascii?Q?5ei3lmKqChLHirLaYl0vX1PL3bUKJQGPaKxt/MvRbIX4X7gzGv2wZCU08cpe?=
 =?us-ascii?Q?BxdUQ2EJaEzXDK2iAmXBqSSqRIBqYw3QFAsSqs+Qk5NTA9ke0PlpjKdMomFm?=
 =?us-ascii?Q?Xa0cmaGxvLKUod60QKyOc9ReVDpJ4nDjrhemv3Dhqds8SRXzlPdT/zsxeFRn?=
 =?us-ascii?Q?NLUxbq6NtwUTkSJJ0IexRm+BP1yPW+0r8KG2DVVLHw7czy/+v8Z5asIXZA06?=
 =?us-ascii?Q?NwR8NtqhlB2/L0MIakIYGy9W1GUNrG6nXUWoPxojT1iS0nf0zXtgNetjA1xy?=
 =?us-ascii?Q?LqW3J07f1ZT/aCf4osagI4ztwrFqYitrZqdyG9/qdi5fSa6kLcDiuhV1sZhI?=
 =?us-ascii?Q?HxUwxv3UVbz8j/al4gtGeTBJIimQG1C9IahsxI3RZGTrxy9hVoNBfMsY/7Ny?=
 =?us-ascii?Q?HtbsjpsnCuU5xoGKVlnYwpJ38/JFrU8FTUSqIOj9wnkitgjXrZTIgBjkwyPR?=
 =?us-ascii?Q?zoE/eXoWcFjzecNxXk6rhVfSeQpd+5HiZLdbDn9ZI/O48mRI4hJyj+A0QdmG?=
 =?us-ascii?Q?ponRDzv5ULOW6ncXFSHpWgjQkGQHHdH2D1lW7X5JZUSilyS0OQg1LZIO1UlI?=
 =?us-ascii?Q?wv/slr3h2UUNAW3DgNQsULcOmuj1aA3auftIvWE5BY0/XoPObuuKDkxzXSwW?=
 =?us-ascii?Q?RS5ZoKJ4u1E5L1Jju9yVmNLPVkAkTwvI3hBv2CJv93yjw4Ao51ACuJzDqC3a?=
 =?us-ascii?Q?/TfZB+d6jX7FKdWHgWyLLA2gHWrRUg0Qq1VdPO9XPFJg5MPTOUzKrg2ymMRh?=
 =?us-ascii?Q?Sh9Oew46lXLgRDJ7lQfunWnja+91LgVCVUQ5aYsfAuoKVRZENjFunioIDfYv?=
 =?us-ascii?Q?joAox1X91WWChdCd90Zjsi5vHo7ICKjuLglYhO8mK2MKacne5i1OVhPMuv6d?=
 =?us-ascii?Q?cL7d/j3rzrqSutpOeqWo9owoWOqXiaexqrpgM9K8hLiRM1krdfIb6OelsHCj?=
 =?us-ascii?Q?rhjncmaGLrhn5dz0G2S78yCOaDd97SMNyupLFifhbfmBVJ0LLwufSqhWkMaE?=
 =?us-ascii?Q?PUTlT3bhvKmQjXm2554sDLQ8TebqUUtbJCEO1HewBlCge5+2u5ckNXNJZWi1?=
 =?us-ascii?Q?CqlzUMnTst2LIySVKPUjNuPdaM8MKJd43hsp5QJteqD688LH9LIX+ZR3XMFc?=
 =?us-ascii?Q?dnv1wb5UD+U6voCyJ2P8hMZ3uZ7pqjHFxKpe4q+zg58LbhaUr73P6LmyOe+R?=
 =?us-ascii?Q?GW1ONoysBw0Zhnp+xdo8AVZp0CAE6BcyhqaiS7armj7T1Gf7xGyZPDQUdk88?=
 =?us-ascii?Q?QeJ48TEsP4UGGde/0hjyHYY2J7p/CH9C54ThNvRZtJXKI8WFzfi8mqoW6+5v?=
 =?us-ascii?Q?9AzsL6j/yrSFJTX7Vv+967R5hOdqDAX9DC2YxwvN1WV9ojwMD3wMhmkhAc33?=
 =?us-ascii?Q?F1S5zqp0c49pmZpI6pw2+dTKi7gSrpjKt7B0BUZULzk+leY25V7w1hNAlSeC?=
 =?us-ascii?Q?7PsA+g7OxdDo5nok0tmofjJuBNhE2EL3C2fQvZ1EDmdb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YIUNnNk+fQF46rdcE5Idjcu16RAbxxpyZ68scV7bcdhRsKh9baRTzePFwovy?=
 =?us-ascii?Q?yLcfbBH1BGxcRLFpz46FiKdq1A06O8VKpp63aUHQfQ5OHQorwUGGUtkwSRd/?=
 =?us-ascii?Q?O7GkA0fOmMHomKcbnYHUX+9NWoZTyZXH1SBQk+3v7PlxGWaN44xCgR4wVXks?=
 =?us-ascii?Q?2569l7toYI9sNCyjMVIDVv9FWgPDLn4v4puUooTeI5pDN2yNA0RV54Upcc52?=
 =?us-ascii?Q?gqeH2RSvDU3pUl3coQD5TKMaeNU16jQvLnKUlyO0HyWATNPTtEF+kX8ekyS5?=
 =?us-ascii?Q?SQ1GA0ugSsgqQfZNxqeXZm7kucjkfohOqeNe8doqvRhygxpkjS+gLjoNki6A?=
 =?us-ascii?Q?E1Hjt144ANVx/ChtqRaTGInxAdS7Xux1r1zlm2bjPhspSjgGv5lUVAwN9lke?=
 =?us-ascii?Q?tmovhh5tkc9gQpSI739KNasQKaHEUjp42+rEiADW3Ohzom6VGoCbbJ5BCCyv?=
 =?us-ascii?Q?OCOuVm5usmqWzPWA/o2TX8xA9JI6TU5qmS5LerfiIE5/j4rVQHmXe6GkyhU8?=
 =?us-ascii?Q?9sLlNEAU0HT9hvGWSFsMSdrDojdTYnz67lstMdhJouJw2Z9683LrIvKIdgr5?=
 =?us-ascii?Q?8jdJObEI12yFxEb72jHQdhudTXtjdKzDprQjENHPXmmej4c9Vq0kHDfaER76?=
 =?us-ascii?Q?PjHJAeaW3OLo/SVQ2PQ2tKJEbO4GF8qrYJYlRkG8/4FQSNSDBhjfN3CxlJuB?=
 =?us-ascii?Q?bMNDPktIHBKo6kWUJ9YWXI3hPDtNMQ5robB11MtrMM9vgBZVQ2nLvQOsrxFR?=
 =?us-ascii?Q?x85ahvLMHsou3LMck8mYUP1ew43p/I7hC8VwExO6TkNuJz9E1kohEyaVpN5l?=
 =?us-ascii?Q?K+9D5Jz9GhM0Y4zzCoK6Jajh0GgEaqCGRYWhxgCHEZzekD0+46eHfjCy+0HD?=
 =?us-ascii?Q?hQgtRbGMXl416pXUTAqpYMVNeWMT6OYYA4vWXcO54kjfypsgrk597dyKV7wB?=
 =?us-ascii?Q?dmvBSA5JD5g5Bdd8SvyrTFM1VX4K7+AxC/F8ARh7NKc4OfnO9gFeuBHGn0IG?=
 =?us-ascii?Q?HDx8Nnigt5eb8R8FL4PGmmHVA0W4HeE4UxEbvjY2EmMujN5+mkCLRYR7Jn5D?=
 =?us-ascii?Q?CvIrnJpC3NjoxuE0I6XTm9BKyX098b6y0ePqTsa25p0FySGKELc2ascA82jN?=
 =?us-ascii?Q?tBw4kL5phfb0D1q5ZCPD00NRLa4CfUl0cn5QUjr8rGl2TAzJEXTQtZIsyYlr?=
 =?us-ascii?Q?tUys5i372lc+Kfjl/F3A6ezH//S5BAr2muDsknK28+/WMQCGdzHV8hKqrrQ5?=
 =?us-ascii?Q?asPByKKIoN42/8F/oXufipeA7kJrnFrCBd9lSujDCVTnQsAfxRrrEMQogGja?=
 =?us-ascii?Q?ImrntXJq067fKDVfhr0+jU7o4rnUqI6Sh/1E0AuKv2G5MWrleeAY+N/xW/9d?=
 =?us-ascii?Q?X2h4nVTCJxf7fLl9NW9/DzLIe5T0OiSvA8JCTHoxkUpgrVMUYQhJf/NJmgDR?=
 =?us-ascii?Q?qYRkvkF++IqfWH1UT4NFFjZXuEe05PtMFK3MPbkL/reVNF00gpSjjbSqsf2d?=
 =?us-ascii?Q?Ohw2yJNa0L5UrKrTG8AUnqfsBjaK18skP0YogaxlNnQw5cwkuIeoceP1BYZ1?=
 =?us-ascii?Q?ra+VO+068Oji5ITj3BgczmIeyScQ68qqzB39/kB6agl4kXdh2NT6hH0hdc+W?=
 =?us-ascii?Q?9wORmisBqySX/+M+yMQXASIcRCDxpR9CK5HTBmmO9GM+jto/jwSmSzwh3HkO?=
 =?us-ascii?Q?1vHVqn2TRhyq3M2YN/9iK6ESk3tIJBut/P48MEw2QqG+gjFs/pGAT9RqQa1R?=
 =?us-ascii?Q?6Nuw2FLp5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3335894e-5406-4067-0e19-08de62c75d05
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:53.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDy1AznGd8qJT8gt6LVquVePBVjnj8OcgC2AteDR/2E8eee74EQEBCMsXncLlJ8etsCmnh9Sipd6r+kTYsbf4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

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
index 6eab8a6001db..060860f24e7a 100644
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
index 9f49c0b386d3..1204cc4d3f37 100644
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

