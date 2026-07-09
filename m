Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ABB3B14AD;
	Thu,  9 Jul 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583719; cv=fail; b=DoPuSce98E9gcooJTQ/Woau9lgp9O5EekjJMoLbCVw1SW2W/xoq0qRWIHYWs2gPpIa05gmW/ZHncbNBbTF5uBYDZBkApgKpikRbhqgvchump0GGZptNT6KIEyPMIsROUGXeKWWUWXam7dDi/Kct4+YzaqawXfNL8CULbrW0J/qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583719; c=relaxed/simple;
	bh=gux93A0zB1nTu6D/W72w+z6Lwbh75NliEIQgGg9EJrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeV1y93xHV3l9tFBQIb3ThEqPK5Hihq/UoaO0/ni9wNjvam0NbGWnUR3w3JD77fDP2QeS3Eg4qhSEkWw79hB/6oaYY4Uc8HhZOUJNSY1tXUDLzHhPeN1o5k231V1jIpEjOcpLc1htXUH3F950PatG1fTXvsAyqLEYCD6yych8uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dHZCBYWD; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dHZCBYWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6urlm243AV+GADxZCt4JWM+945z4UQ7u/dCjETjgL6UxZkWhSEkkQHkeaLlYIl4b4or8LIB9Y9grIsMc6ezppjsIWJT6Ld38xLO6fow0Ji3M3n0h2Ps3WlaThQMFyovEPRb4pFzl3tI4Gfru93KOIGulOwHtT4y3g1tS7GTAMOASW0uufydH9PmdV9BitMbdWkEJH2jRAHIupEXFqyvBF9MXMVO+MUkravMpRcvydB+4E59e9/bkzL0FDJlwhinG5SCA+2YlUO0dINK4k3O2++Q4Zd6tdXfoiZC0jHKT5pmYJfEZyotb395inaxwWIXlgii4pHzzGRx8upwUbBEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr+TbpddaUEYhF8w+Ay7WtsrWm7Agds9wt3ItWr38f4=;
 b=AMOGizkfHHTPme6G/z8w1Mycu8jQIv7saPNOngxuBENfe9CyanUczZEGZ5M8Fofajwe4GApzr8Slu8HN8AL1M0piT2NKIS6xuDsou39KsUkd9y26/4dKmkDsmL47fmxR5SlUKu906xoU4PVb4t0xdRR8k8ZmV9wi6Mwo/Ha4i1dIsWfePINnTVbksksfVSEp9FyL/M0oPVJnhfCoHQOWmK31+KuyqPE292zJsxepYcgmduOxs7RD4FpLVDM/ujrZryy3TzA+/74YVI4NixifbpV1KZNJt9EUvrEWgiSo/SyrKhHqPcZIqkLkORa8Txy8AWwrtyTTlqwY2FkiLrCByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr+TbpddaUEYhF8w+Ay7WtsrWm7Agds9wt3ItWr38f4=;
 b=dHZCBYWD7m5IX3Deh89hgnANMh/o97470lIocF0JcdFxt32FkYv5ylKAontk8dPlNp7lLZU+/QA3yzl8NM0WTuJXN41xBHAr8Qq6pUjFnau05i2g2ebN5dztEXgSTdgcfH/h2sN5kkQ2sU1DyN6BmnGrEujVTx6RFD6R5aeBkIhp5G9CWB1jETOCl7qhls1x5S3pLewiwUyEy+QH7YMBgPA/igae5nYyfQTCcnqpWmIXTOpsfn821LVh1//N83t8ZlExY2frskiLE7RTYEYSGmG/xoGKonwbzpCC5glrsJOOojBXX80iPV8reSRdAEYxDtSkAM3Ev/97NEiuuOKP+Q==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV1PR04MB9069.eurprd04.prod.outlook.com
 (2603:10a6:150:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 07:55:11 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:55:10 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Topic: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Index: AQHdDu0lWZKsvXgOekqX2395P3qkTrZk0prQ
Date: Thu, 9 Jul 2026 07:55:10 +0000
Message-ID:
 <GV2PR04MB1201927798A7D00F7900E97EC8CFE2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
 <ak5qZxsTsIWqe-ML@SMW015318>
In-Reply-To: <ak5qZxsTsIWqe-ML@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV1PR04MB9069:EE_
x-ms-office365-filtering-correlation-id: 8ff24684-eaf7-451c-9615-08dedd8f667f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 O6qz/Tifc9CcW1JDSPc8j1OYjySqxSYMxfq6JiHvKtVs/nVPGT+t0tvcGLJ2DWT26pazpJ/yCT8UTiEHlic+kxf/nJT5acN6fxdPKsZN+Wymg+A441sRZhSmMK3bSq9BdaH74u+nAy9IfLBjUcNMRGjn6lRvYcUiwb4HrywO27oAn/Lmkt4KgECL7rBxuNLzrkdF+LzKFQmJ9oyf8EBruCaKMpLUS0rbfBmXgqmmOt1h1gabj1m3PLA+MLJaWV4b6r4lFX0UZVDikFLqisDFRiIe0utGMtDTBIC84SnxSgYTZw0Em1hCmQ0K2Unla5ohqjaTBI0R2OFvf7LtnrrO298wo2CWbhovIMeZkWdUJa/ZjlrbwRx1mfrzXHVvqjaNJWVcj8ojHTnSi15W6jVq+475Wq0od7U99xiEB/OZ5f+z8khkaHSZ6YO3Q1mMevA86p+lfu+2wvwVhSxXT1N4IxeZ7AX5Pv6+bxnsV09xqRYUAaOr5JUj9nDRZ9rpoUp5sxM/2RS8ZsyFK27yjI9ADVax2C3pRvHYE1hL8Ja3wbatb/jOk5/kphJYnR+k5Jjqd/RP2JNJQldn9D1rk2rJgLm5qcyyLXkX72z7aSdxJmrBrXh1js2arHLA6lp6U9JWY54t6FSuHTs4PgyzGp+Vus7IU03M9qxHIkOwIaeUL+rINB+wxwyel5qdT3m+s4d4r7G20qUrlT//f4/F0eWM9bTAJw3BLO0N7YbS7354PK0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Qf+h1gqFZ0T5P6Y607x7WxR2rL8wpy7rigz6z4sv2qJVFEcqVDiQRrIudaa?=
 =?us-ascii?Q?YsZikIBOGeFl2qoPyrUEetfA5ly0xuyXJmHgpNJ2l6rt6/zwjGonbjEjbG0m?=
 =?us-ascii?Q?p1dsf50zIVzfEk4cAaxXxNqmPDG4lZJ7Zy3M0wpfUixKWfOAYze6qQGQArEX?=
 =?us-ascii?Q?0oqVrBvnqgU7eT3AOO9KXCEVEl91s84VjrJcdamvLK/qid9kScNV4vXBjirL?=
 =?us-ascii?Q?CCLDMaAhEC6YopeaBiICEGylDA4rTV7CHTnGvHksUMe+bYEIadJbNlnuJMsU?=
 =?us-ascii?Q?BHBBLeaRgyFAUjmLWqGFzS+//QbEjH4/y+KlE6uC/O5xMVuMVq0eiB3T6A1w?=
 =?us-ascii?Q?DQdUrdkAdlWa04pih8Qo9nPWVGbWQmDZZCLIpXsVFVteydMG5DBaLx5lkn7z?=
 =?us-ascii?Q?iTbPCXW5wz36frFWmyARpyYa+NLECBVitNJ9/UIsRdoP/VwizgNWOeMK+ARI?=
 =?us-ascii?Q?cQFomWHFU042g/h54f9Jvi8afTmgHVXJy+7Foba6HIcQAU9CZTCe9eYCwV3B?=
 =?us-ascii?Q?zmVFjn4NEA6ikCLjO5gM4r46xLFtNH62TybpNj6Iwurwi0M5NFlf0BFiEqLF?=
 =?us-ascii?Q?6El+bvwHKf8y8uziXoZKU+YQyxp/NM4FQIlGK4Dgp1L6QiHSUwwUYHQk7a0H?=
 =?us-ascii?Q?isW+Xm//mpB/ic11FeboX4gVm54lcVgkOkimUtUr4Ux/vMHk7ULoyVkAle/5?=
 =?us-ascii?Q?qFVtQAUshxozFUVZobTKqBb//gKrTpeNLilWgQom3gltIz5712HWY4Vg7TDa?=
 =?us-ascii?Q?Ge/bqShlj/LE03W6HCQyNg9xRiiwFTgpHs/eXWW6cev0qMsr1WCHZHAphUA2?=
 =?us-ascii?Q?rPGaraTx84YoFDc44+lwVo4eye5lsmvuMfYXU5MNSKW9WO2S40ambWlG5k0q?=
 =?us-ascii?Q?SJre6CclzcjtOSxQRb1HL+eoY+5CElcQAcC0rDOpEHXP2acfq9jpg3254A2v?=
 =?us-ascii?Q?o5aJTS7OWLOzv7tuMqt+H76Qo8+qDjiVYEvA/BJO/GnL2AGoAAHVCoqAzs8e?=
 =?us-ascii?Q?pcs2iPAfCOolLuyr7BX1ZYfAzsSY7K/PVE9So0gL2/4nt6RTD1d9F9hGKqTx?=
 =?us-ascii?Q?34MazdB5AMO/KYzS9bdLZPQYJ7GXeHCkS6grhZpeETZusZB+mVYQfAysTTG7?=
 =?us-ascii?Q?H1Pb4yQnVAQsvxs4vFr5hqFuTzInK/vOJ3uoRiocaoLQTV0XYconUe79n64m?=
 =?us-ascii?Q?N5g4OsO7nCc6WpuIydXtDEbJ9FkID3CCgW44MCCrxP8yREySvdJoHyXORntW?=
 =?us-ascii?Q?a05w588wiXwVEK8se170BI1fHl0uNYIgCJv+ZfJWMbom7FFIPglOmwuTjuP6?=
 =?us-ascii?Q?nvWTG6CVGh4uSIgeTCu/kXkVi2Jp7o+UE93HiHPq1LUk4mPyBbYDD+2lAmJn?=
 =?us-ascii?Q?1WkbqLhe50JmUPDQfpDab5iOtnNQMDyMsGFWWexU+0H1/+Ne1AN8fSMGMOP3?=
 =?us-ascii?Q?hGzu/P9kvMsEC0oM9t3SrD1lv14azo06p6XcefXCK9cXvq5JjgfBVEGH2erV?=
 =?us-ascii?Q?LhC7EbwyA3/F1Ya6l+eJQ9+8dNaJ1lgjOMJ0PNbnadML5qZlogQ305tM3A5e?=
 =?us-ascii?Q?DjEmRUTGe4I9D4aEAU03daHiegMXKVhDRizSZKl7rc2QObzMsFTG/Q+ZFwc4?=
 =?us-ascii?Q?n1XaD3OxT06zfDd1pNt+zoALGglBJTxYs7wS2mnhNnceLoegCpf2llaJXQaG?=
 =?us-ascii?Q?rl+7vf7pGu92laddWHpB68xNqFbtewSG5FlIjn0DAbpaEste/dLpMSVU8tgH?=
 =?us-ascii?Q?fg433bUvWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff24684-eaf7-451c-9615-08dedd8f667f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 07:55:10.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73h6KxNN2xYyumwMq+gcCYtyGCvdsWoGEAvxE954IlF2l+JHsYtzM+zFa3aNrezOzVQY0Lrxv4+em4AKFOlNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9069

> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Wednesday, July 8, 2026 11:19 PM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95
> Gen3 PCIe stability
>=20
> On Wed, Jul 08, 2026 at 11:59:28AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > the default MPLLB_BINDWIDTH value. This margin degradation worsens
> > across voltage and temperature (VT) variations and different test
> > matrices, potentially causing link stability issues.
> >
> > Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
> > improvement in bandwidth margins across all VT conditions and test
> > scenarios.
> >
> > Implement PHY register write helper function and configure:
> > - MPLLB_BW_OVRD_IN =3D 140 (0x8c) for improved bandwidth margin
> > - MPLLB_BW_OVRD_EN to enable the override
> >
> > This ensures robust PCIe Gen3 performance across all operating
> > conditions.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > Changes in v2:
> > Update the register name and bit definitions.
> > Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 53f3da6ab30d5..5f75aa09e0377 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -80,6 +80,15 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
>=20
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN		0x2005
>=20
> This one IMX95_PCIE_PHY_MPLLB_BW_IN to keep naming consistent
>=20
> write IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN ->
> IMX95_PCIE_PHY_MPLLB_OVRD_IN write IMX95_PCIE_PHY_MPLLB_BW ->
> IMX95_PCIE_PHY_MPLLB_BW_IN
>=20
> > +#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
>=20
> 0x8c only one special value.
>=20
> IMX95_PCIE_PHY_MPLLB_BW_XXX put special name for 0x8c, if no means, you
> can put 0x8c direct at
>=20
> imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> 0x8c)
>=20
> We need knows what's macro means, like it is offset of regiser or it is f=
ield in
> register easily.
How about add some comments as below?
+/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
 #define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN                0x400
-#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN                0x2005
-#define IMX95_PCIE_PHY_MPLLB_BW                        0x8c
+/* Register offset: Override value for mpllb_bandwidth[15:0] */
+#define IMX95_PCIE_PHY_MPLLB_BW_IN             0x2005
+#define IMX95_PCIE_PHY_MPLLB_BW_VAL            0x8c

 #define IMX95_PCIE_RST_CTRL                    0x3010
 #define IMX95_PCIE_COLD_RST                    BIT(0)
@@ -309,8 +311,8 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pci=
e)
                        IMX95_PCIE_PHY_CR_PARA_SEL,
                        IMX95_PCIE_PHY_CR_PARA_SEL);

-       imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
-                            IMX95_PCIE_PHY_MPLLB_BW);
+       imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
+                            IMX95_PCIE_PHY_MPLLB_BW_VAL);

Best Regards
Richard Zhu
>=20
> Frank
>=20
> > +
> >  #define IMX95_PCIE_RST_CTRL			0x3010
> >  #define IMX95_PCIE_COLD_RST			BIT(0)
> >
> > @@ -269,6 +278,16 @@ static int imx95_pcie_select_ref_clk_src(struct
> imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >
> > +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr,
> > +u16 data) {
> > +	udelay(200);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_EN,
> IMX95_PCIE_PHY_REG_EN);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA,
> data); }
> > +
> >  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)  {
> >  	/*
> > @@ -289,6 +308,11 @@ static int imx95_pcie_init_phy(struct imx_pcie
> *imx_pcie)
> >  			IMX95_PCIE_PHY_CR_PARA_SEL,
> >  			IMX95_PCIE_PHY_CR_PARA_SEL);
> >
> > +	imx95_pcie_phy_write(imx_pcie,
> IMX95_PCIE_PHY_MPLLB_OVRD_BW_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_BW);
> > +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.34.1
> >
> >
