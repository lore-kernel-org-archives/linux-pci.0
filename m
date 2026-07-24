Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FA26738B
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872414; cv=fail; b=E+dX++Kex3d8bqu86hjL0QOPDBaZiPizv5bSDMSTc8x/MMO1afdosPVFkrEQzEU9vNXIl0+QDFgQhLbSpU5bCSMtH1jLLq1nv0Jhdvd7TkxQ92qebggdndfomCN/8MhxvBycXXoQenp0V1hkNxHRMHMUEg6u2Y+jBDOV0JB0WDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872414; c=relaxed/simple;
	bh=tXA2wOM7gOcE/m9XohdXAbk+oS2Oi29P3aiEBEBsD3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWaONR4QC0FhZA0QOTv50QjgD3czvd8zjDBynKDoPp4gBxkA1sAwyAhj9W1lzgYvdP6c2cVbO/dDgxv3rvxs9sqqCRJmlbE7CJmDkPqFJIsRjtXeMk/KCwfqZzti/+57bxjI5GjkSZpcCJ16rTksYBmSRhoAcccjNeFfIz+icWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdlOUqZE; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdlOUqZE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efmyg/kDML1L5jOuPPFxmJUqcZiyuOoawdY4A6H3gaaDzqbzWN+R+MaLf3OHRkooUGqRwANrDYynUdegePPl3SkBrKUKg4Q4G+Z0PKEs4P7pcPYw95ITf6oAjtd+ahhCihs74K5w0K9fnXvpCVPfFqFPmqQRjBpHcrdH801POjdswbmIDca+8ZCWdeKCJFkKrz92c2M7OFGWi+m9T2cu8dqs1jgJlrxP+T2qIS6KUV4g3o6W6+fggi3uVwnoaTk/6eD6OocVKGbrCXWz+JFQHjbPu8jLTM7CG8DDL/XqOc0noYv4wvZ7uo682KKDn4zBP3HpGnwYFU+FAgzy0qdPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJR465BW38i0et97xOdywhGgOEM2QgSFsySKu8ltTPw=;
 b=l0KO3mbE0i5yFPAjpy5c5ctlykHXFdqP/xUj7c9nGzrcsnIo7NTpV/f+rT8C3T/A7KVMpr5YyxnNhdERAUwIvPEq0r7pTz6RdGiUCxvo8RgfG430oRXb50WPgJFFpw+070U966X5EZN0BivYwiywEjzBaiy00FhUZc3HEe2Cpp6P/4E0dvpJ3Y90i4DxQC0LG2gvvqfR3ioIjseHLyH8cSeBffsJ3HH/SEquyWOA+qQjy4RyoKlIBhIj44GiVao/cVqwQzYnS7fOqSJlfNknwaOlueQeMslY51XjbDYNlan4m6No0dPkND7v4WrPvP/ibYD4c7VY1Wcm5DdKya8GlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJR465BW38i0et97xOdywhGgOEM2QgSFsySKu8ltTPw=;
 b=WdlOUqZEsyOgGaE6YdGPFvUIqSbF3IJ4MvfCXhf+q8ULbaeMGfAoGqoD4IydQo3nwHVN7DFMLmxT8vrAlUtv6c8qfRPWJktqL3akqaqZdTke1Ng/vXixLvlpecgaN+7psSLNes/DIw3dbhg2rhYDaINBl7D1oBli2BffG7QhIojO0DzC9rX1cGEr/0VnONcNp577KjbV/zs41an7JsGXRLaGa329My51RGBS2z0o1w8bm/aETKKOFPB7THrn8wUls43sxH5s9wUD5gW0+PjOSw4Cj9qGikyIRqHN/x+JriR7IvLORByZO2FuvcAfQjqD+tC3zmUmGoZDAQzRwKRVAw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 05:53:29 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 05:53:29 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Frank Li <frank.li@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Thread-Topic: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
Thread-Index: AQHdGAiCOS1Dv99svEq6/bYedmdjW7Z2GFCggAAOq4CABeOqEA==
Date: Fri, 24 Jul 2026 05:53:29 +0000
Message-ID:
 <GV2PR04MB120197D555F17DCC9B0441EB88CCF2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260720052742.GA6753@francesco-nb>
 <GV2PR04MB1201926DADEFA97128E7C8CA68CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260720093831.GC52182@francesco-nb>
In-Reply-To: <20260720093831.GC52182@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DBBPR04MB7883:EE_
x-ms-office365-filtering-correlation-id: b7f0f5db-ec26-4252-9325-08dee947e2ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|38070700021|10067099003|4143699003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 F/hMkr/c1sQbC4yXp6psubXj5apvpAz+AzS8KdypDiFv6pc5E8cq3UCGQu/noWdFsRUzo75oZK5pFVEXC+0Iq/Ihx+ijOSkVEMLo6cAzbJzd2lciqP0dd5Xxh3be10lLCBRBw6mWrhvAcVbaJEz0QbySy2nHsOIhNwa7b1h2rl9bIKGnIa4yTEqkGAwZeCUOZFOh7D++lrF7c43ovU3amWcaUsP7IdHzECOYRYpmKTzoY4O6Y7Es6p9+IU5DVZRJrq1PC1JX1uVx+Ltj/cgsA16fLneKoONtX9J0FJTGTdViWxxjZQd877eBfxBPC2PccIqmDL5nFzOBSUczQx9gqlTP7oURi/8RBg9yVg65nN+2tWBwRW1lRs/yA9P3Efre6ZY+IWoeYFqdnJoFQCE/bO2K6M3Fv5Oz5pUdqUZkWdmPxKVllr6AAk5bbpaCxde2ItTd8PSl7z9K1+tJeZ4DXQA9ElfeZcUb93oUIKfVu/raT+AxW1krBxHxc305IpmYasqI3xUazjCYLkQTaQzfGmRvuJuZoUI/ArpVd2DE1MZiIZQVOX6MYUSGkMYfBSyaQB9O4y1CZt1HFAbjuHDJA/PrAXzzJUd0rOxczw8rpvhAxUFSAcOgknCbQyy9ejdlyAw80Uuc6nrywkpHwQDdTRN6ZtmZOCsz9NG2GRYjtH/gOHbgQ9Jm8SVXyPs3vgJx965aagYONDcfLciiYBegpqhMc0mV6EpR33lWewQQsZg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WwFoB/WQwMioqqKF6mhVMqB1m7xsL5zeXD8s/wpfOV4f8CjesDsl0dNuTg7M?=
 =?us-ascii?Q?f4Lzq9UF4ex+/QBwooi+OAqdxKg3sg9sO7I6UZbrsG6kmvx7LX7hWk3kJUV8?=
 =?us-ascii?Q?OXma0m518tdKqB9jzWvbckyGOE1QerYQGr/+Tvv0Pfv5C+zoeyTLwcKkin+/?=
 =?us-ascii?Q?RARDNztnlK7YO4T0mhkONui13UytyM6QJiX5eKUbUhZX6vZFV+MhHNOUsZmc?=
 =?us-ascii?Q?IOrsu4KTzy5tSsB3xBztXvStYzsiVF05+7eIF+AjSi0K+ujRTR7NsK70YMcv?=
 =?us-ascii?Q?ih7NgwjrkQVoZhPA1PatZFeSfNka/aBPWUaX/KezTI0pahIUnsg0o54Dku7G?=
 =?us-ascii?Q?gATwloAyYYizS6L0T1/Mps6bCiYo5jlbCXXgm4lysTuw8LKuBcsWAFS94OyS?=
 =?us-ascii?Q?EasLEbMfBtdbzPpTDu4VGwTchs7BibQVSm/jQwqXYMqqzfgQfOcY+dZI5AV+?=
 =?us-ascii?Q?lOtMMfypXXEEIqT2h3CinAGbjA2Xg23pDXwqBd+BVhFxvaGHnqFqDGzopZ4q?=
 =?us-ascii?Q?07ZCZgw9hipyIS/xI4T0WisJWxMFWpf47cKuXDyszh+Xtqr9SDbu4mgId/9H?=
 =?us-ascii?Q?KjP/yUaFKRpsyWQ1nM6zUCiGPmJOOjb3s+iZWPEEo7ADe6hnbvGd1jRGF4Xl?=
 =?us-ascii?Q?RAM/dIRiqZHIuYF4Rw6On057YEAyDhwbTxJB76xDO9lK1OusUDCZg+/mZR1V?=
 =?us-ascii?Q?2SIIm/4e3JB7FyROEOeFmmT+kY56EtYBb1gDdaHiHhv8NJabjDr/n5GG7fWD?=
 =?us-ascii?Q?nuiv2onsYGwXOzBnM/9GhqQKCFFH+/GqkA0bIALDFwixdV9sq0uOQrHEaY7Y?=
 =?us-ascii?Q?qwdbGP0FKEwU5qA/oLzSKJtySKGA3MVUqByWCoQd2z1caEPumSP1/zrlHixl?=
 =?us-ascii?Q?7DvvIJ7b3MAzWLjAUMAr9pIc6VN4w+V5XvZW8+0CBx51FDQdieedpzuZaYhr?=
 =?us-ascii?Q?yr9FT9gQQC28Zz5Phblm+W9TkDUVOW8NbL5U3fFsiOlDp0KshH+97J61gs0E?=
 =?us-ascii?Q?YhSZ7hG+/dwArz3pMfOTOqO0iWKmXRF7AQ7ZkdhcMYGLdg6OMxFU9nKnHTPf?=
 =?us-ascii?Q?8tWtgPJraZJPRyuECBYoLAT5Qb7+N3TVaQnOtrLmVVRwghQkR9APL++XXq1R?=
 =?us-ascii?Q?fL1KbSlMlMdkGPslH0cG/q+tY6WMI5o//h7XYouPRBGcjnEdjEOoUFOD7r2Q?=
 =?us-ascii?Q?GkXdlI/q8X4egBSATDR+ZBgxl4hhS+0jseBe+77qYsstKw0yP/LBarVGPm/J?=
 =?us-ascii?Q?lcW6OokvkIyxPrWLvxUHIn3L9NX08bMWstB9OJcDfwPtlg791ZVXmCfwTfKo?=
 =?us-ascii?Q?XISVPJQgv/2JwGIQggtJavyrvTy0yuH6Mg30kEjMfeaEMVGA20w2maInB1MG?=
 =?us-ascii?Q?nOkndrJoE6+WeazMH6y0xudRxUa1D7Xx3yQGlbAUnZpyspkmXFIr121lxd6t?=
 =?us-ascii?Q?Av+1NTsP/ZwQG8BySrDNoHpglnqfnNgnl7weEb0FhpzzRhoMd8hL6ibA+gL5?=
 =?us-ascii?Q?qXuedATPEFjC7XlfgTQzFPkARpNLPeTZvWwme/Bn8qYwz3syJ9lyu3GJp59S?=
 =?us-ascii?Q?UNxebUi3vZoGyY5dxFgT8dSjFBbIcRxzQfN63RRwX7lLbmkK+b4pl3am4HR/?=
 =?us-ascii?Q?XASH8iJinmbtmnck1197cX5o8ngI0meT3J1tea71EUz3pdgHq00narI00st6?=
 =?us-ascii?Q?cINe8ORe30ymeCo/xWEnCMpivy571nGOFceIXHfg+d+aleeD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f0f5db-ec26-4252-9325-08dee947e2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 05:53:29.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zz82h86kqglBtCwoalliMuw1/XoXd9aTSuqqCQI6RlaPeTmu+Jn86bC4VX0CCw+yCxMN/gPKMATO/N19D/UZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7883

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, July 20, 2026 5:39 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Frank Li <frank.li@nxp.com>=
; linux-
> pci@vger.kernel.org; imx@lists.linux.dev; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com
> Subject: Re: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
>=20
> On Mon, Jul 20, 2026 at 09:16:27AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Monday, July 20, 2026 1:28 PM
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li
> > > <frank.li@nxp.com>; linux- pci@vger.kernel.org; imx@lists.linux.dev
> > > Cc: l.stach@pengutronix.de; lpieralisi@kernel.org;
> > > kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> > > bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > festevam@gmail.com; linux- pci@vger.kernel.org
> > > Subject: Non systematic PCIe error on resume on i.MX8QP on Linux 7.2
> > >
> > > Hello,
> > > our CI spotted this error on resume. It is not systematic, and it is
> > > possible that this is not a new issue from 7.2.
> > >
> > > Does it rings any bell?
> > >
> > > [  745.849237] imx8qm-hsio-phy 5f180000.phy: HSIO_PM_REQ_CORE_RST is
> > > set [  745.855800] phy phy-5f180000.phy.1: phy poweron failed -->
> > > -110
> > Based on the log, the PHY initialization is failing during resume.
> > I'll set up a platform on my end to see if I can reproduce this issue c=
onsistently.
>=20
> Thanks for the support, appreciated.
>=20
> > BTW, is this occurring on the i.MX8QM MEK board?
> The issue is on apalis-imx8 (you can find the DT in the usual place in th=
e linux
> kernel tree).
>=20
> > What's the frequency of occurrence in CI (failure rate)?
> The last batch was 3 failure in 10 executions, so 30%.
Hi Francesco:
I tried the stress PM tests on both i.MX8QM MEK and i.MX8QXP MEK boards.
Unfortunately, I can't reproduce this random problem.

Best Regards
Richard Zhu
>=20
> Francesco
>=20

