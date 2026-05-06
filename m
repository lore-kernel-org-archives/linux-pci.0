Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDC3C465;
	Wed,  6 May 2026 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778040108; cv=fail; b=C68dPlteFBowo/UiT2jzTc+/HBR14lbx9IK6jjcImc2em/0UIm01Sg75oJrTLHvxtl62H7vZzmaCZpca+RcQnnYL1+748BK4WoT1pLTZXJz4zogbN4DMXR9NGD3iqfrRBaIBDZ3f4BDVysMG9NVrewi4N0H4FDYrkWXdk4c3JA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778040108; c=relaxed/simple;
	bh=D5c5IERPDGTfNM2MVkQZiYCcYcAS6Cdd17XJf/GBYUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8PUZzFSMoZFWsYLss+MxXyZWXq+bHbq48FS/kdophP+AlqPO474w1SjpmGsHMoCs0IAXgrP3ACKb/R69H7M8mrGlRA0VfkMz1J3vqoTSLaueowzt55P6IwIGfwPzPBQtonDCeipZei27kH2cFJFgitfAw/2pUYhTHrsjmnu+Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E3PKxuk3; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E3PKxuk3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnlkaoWohiBCnd68rYxpKnYNF8Bu4723v8MIdqdCutBMFBM4EOqarAFlXbgaI1c8rVf3A0KpCN05T67Vknzv90xhqCmgC1hTfuwZJDPNxiI41lIMvakArE9ZqSYUCRLcmzUaPjuj/qk7kLp3Rp19IRoRSBcPWs3dE1IOFgCSUIim7Qy2q/sm7fm1tvuf8BZ4d2rtlqUJguXWIYzs61G+ErilQCG8Ktd2KaFkGca0B6WvOoMxRd33biAJNDiUTxdLqcOM0wqcMF8Az5xJ9ssaJ1VjnC2kzV6pGKs4wdHMTpXYne5fpovWfFmYptc+iVxo28IPbpY5WQvieELhUwe+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpE3fKgBQvycb9ipwZXwEwW/ad8UFiS8Pui4xc5SO7I=;
 b=H45XpKLRpmVxawBeTFdIwmPiRIFcTtPHjQkqWuLZhRX14himYMqhvcyL3Px5skB/TWKmvVi7cGLGOQu5mD7hENjuQl/5qbvXgXvjU9OlU3TgPi9PaVz4WHwcZTeIaoe0IgIAf8akVTrLsUiEf+Ov//ZHaHTLXLfyR6oxhMVfhfiRGrw4aJ+iz4a3suanq12MSacROzljU2rUlLS0/fWJm7qWdd9rr4zo4PrKd1l4Y9/mkxXsXOLxRmaFJaSG3ZLnDRGflg56IYjJ2wQZsaCEcmXqrPy/05y+ndev70tSCvbi/fr6Pvu+4W//pLRqcHWxJ+c2ZO4B15YZ8lp0tD/Jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpE3fKgBQvycb9ipwZXwEwW/ad8UFiS8Pui4xc5SO7I=;
 b=E3PKxuk36Gro/npI2muxbADJ5K/tvd3S5XbHSKEjWE0webW9kqcJa2iV2dd0fxrxvx9cXsZJ72lI8Nz1T2P5s/iLJ2TpGazUxFvVDdM6YwWMayZjpiLI0jQMswgG4JenTLFZInHCB7BJ1LxcQS5JgDlVJM0Qs3i7HRdBxncknCBgnhKx6wTyvZ/5CqwGhw6R74Nwf2nYIVFx2RDl5FUSGNmgKNogFJSlUlU6d1x0jEX4qhYeV66Eh5DtorYk41W/fV+55g8gzb4KwlQ5keHEWM1sUxgBG3SRadFgMrRR/rvp5AeMNisvmVg7BE2wDFN2Jxqc5e42YK8WY17PPUGdTQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV2PR04MB11303.eurprd04.prod.outlook.com
 (2603:10a6:150:2a3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 04:01:42 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 04:01:42 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep supports
Thread-Topic: [PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep
 supports
Thread-Index: AQHcuzX7sgD34BfOKUm5YX4QZoB41LX+oJgAgAH2NnA=
Date: Wed, 6 May 2026 04:01:42 +0000
Message-ID:
 <GV2PR04MB120190D9CDCC17720D13088218C3F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
 <20260324023036.784466-4-hongxing.zhu@nxp.com>
 <afkNEjm73o8qoYRY@lizhi-Precision-Tower-5810>
In-Reply-To: <afkNEjm73o8qoYRY@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV2PR04MB11303:EE_
x-ms-office365-filtering-correlation-id: e2975494-2a99-4f4b-9acd-08deab242ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 CFQPGkSFKuy8gVQ23iUMZ6JGjk+ux765vw5H65CdUHPS96xI+zXPhXASClKXRbBXIVaBbCWCti7Z99bPa/UkBAgRa9NXH+gNHYbk+t94m8LRMG/8xijMYPvY9w1Y9au9Q+xdkmAW3ODmNDyrerxsTfY/3RGsozBcmcf6LNAfy/T3AJLsiRzCJsI6zpFmGF1VTUEYCwMqfoOeQtMwP8MZVydJJa81KZntPn51p0GOsPHGIP8u6/6/jFm57gc6TxdXqNE5GP9R/3E9iY6mkxpRFXQaX+Ra2DoMeDaquXnoTmOp2sHW42uiFe+Fh7SZc6CvGCyglaay5xHqzC/dWA8Pe09TPWLxO5Ue6Xc5vKNJjFZyp5NOlNuLSQilQCUR/8LPAPQ3uedpcvzCQ5197YCsGivv9MWm5M6X+cbjuxK06p0ol3XgZt+9LgiDQfwsP+Lne9diicH3cxIQMqeOrphWZBlhYmai/rcN/Oo3MoXSiz7ZTuA3D7rsvqt4O+IiofxOEVtqYF/MtkrViDPLqIONf0Zbkcd8EroM/8cLdhhkH2f4ili+y+ZsbS2Uzh7/id0WquWBHizvWjKc/Vj8pO7971qENGOVcbO6Hnkbi7qz2G61Iypgf3783JGkkksn6KgB132Dnt2Ek2/bHT30vaYy3VrFYSzTKRuGzBuGGR+GQUgyMh/fsM16KuC/4hI5OrP3IIG2h+iT5H0JP/YeEjcIYGU/6QGS0/Rdhy6GH2PA9U0VjwmHT133xoQ5tUT5IK34
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n10/Q0yT1vyfCuLA12bobKsKpQ+c/Y9V3cOMgnX54OdNqnalTiHEY3W9iUvG?=
 =?us-ascii?Q?DSTQycfrstJTOLgc1N1qQYD5P6xZjJsQ/swUCSNhwZTTsNE8rcLQV+YEyQUx?=
 =?us-ascii?Q?jRxHxcGGqhkX4XVou4LoQOgm8NLJ41yrMLmh1aRtABgQUyGpj4VwRh3mvuGO?=
 =?us-ascii?Q?MUHjX1IHFHEzJ8xj1ZtkHoq/DYzwdCP3iaM257TxikMPLWxLYn6/03+aPG4O?=
 =?us-ascii?Q?hzBSKRRVaRivR9YchOYVZCdOU9iEsYGKtuv81BDolM5x+SF9jiHV8zLJanYP?=
 =?us-ascii?Q?zFTJesogdj/jgxaeGK+fGMvPNffCO3KsJ64FiBoR4yvVoITkZNL+CVh6EuO4?=
 =?us-ascii?Q?S6VRRjXE9SFHobJ8VFbtGfFXYANB6u8LN9TL/VO/z/i1pIcFp+7aPTJ8GTLH?=
 =?us-ascii?Q?IDi+KLURlIguM185WzOC0fFU7i1JZXxIhfchgwuCz0aojTszHhvd/OU6XYlQ?=
 =?us-ascii?Q?CnJWE97xqMR7X1TKdyGAD3+5bykW41bV0z0WKX1k+a34L9crxEkSOtz1G/oY?=
 =?us-ascii?Q?I5SQPJ+QEijLaIgoMW5C9T1R9Hm/8QdH/FOz7p77J8dtfU4eVQCceWAKwOcc?=
 =?us-ascii?Q?8xo5pnDrG7xor7GUN1n1Cqst3EDmXQxN5WWiwLRxWQfvzPBGVgy63DWucL9z?=
 =?us-ascii?Q?9DFxLA91YP0Za2ZCSHJG9GD9UpnK/TYP590zy2ZLgp/rT4U7kndj/jBUvHhm?=
 =?us-ascii?Q?bWkeGN/NOPUByHyN/fWdXiak9kutaejjEvRgd2EQq4P+1KctkBSCsX9gcHBn?=
 =?us-ascii?Q?FP3j8zLSK1t0eDffyCBUkFQhB3zoy39BD9gwFjhlm7fF/v6fRHEZZj9e5OtU?=
 =?us-ascii?Q?vjFg7HjLA5Cq3isXojCQh/XZ9JtjkH7JHrp/EvuJ4utXYLdKt1EYCWbjtpLi?=
 =?us-ascii?Q?BaqMnA1/TZWUGwrI493Tq29MVF9qKHUAzD3MZx5t1KMZmSXwfUEnvyVmFTID?=
 =?us-ascii?Q?4WQr6Re06D2hwTtYJXdeIi//XNUHJagZ6tbNs8Lh7uFQdRtMdLRlhqbMsMUE?=
 =?us-ascii?Q?S5imV5mQXYDbIe1rnDF75ziwveN4UJry6GKiseu4XytFft6J4sSV4bJJtrpw?=
 =?us-ascii?Q?+raBRVCxgr+4Q06o6dL66VVZO05POC0OwPdMc6k7QFgRHUz0kNrkYf7RqX7S?=
 =?us-ascii?Q?7KeKZi60netuAmYkbY3ygEueTGTMWzZMpP7VKY7jdwUAjXuZ/HCbOQQ5qYxK?=
 =?us-ascii?Q?1YYyH1C/2ai0TocIqU+Y0k5yiygKqHLsQ+WbqNkW+ZCkuhOpt/S0LrO9y1uM?=
 =?us-ascii?Q?VAg6GCVV7/ClZg90vQ3a0wA4T+fcuUepzZXONnKUF18PpI7LDGjQ1C1deqBL?=
 =?us-ascii?Q?Zux/NEA+nQ7Z9GrrA8xWNU08pMuI12aoCJTIQKCrhf6+plz7Klf3LII3ReTx?=
 =?us-ascii?Q?+DgplbwPa5pX9i0pPKrsRswM5evSUIN7eMk1Kp0uzXrk+jVKshPOsI3vJ++X?=
 =?us-ascii?Q?007mxjJq+o3EonnY6pax6db6zQZ5RfZxUiyXkQNyke2cWbnkHATaG57wDemE?=
 =?us-ascii?Q?o5ub5Va3D2JEgIw9h1fantryBqbuf2nOUcycFnlCcJaR+36uNjf52FGJxRkl?=
 =?us-ascii?Q?Mhr+10hHF1dc7Cet4hbfPF6nikk28YnAmtXPvKI7GlsWi50p87NjmQ+6WwcW?=
 =?us-ascii?Q?sVDZH/rlCyVav1nNN1jM1IAF1ubzGOdNYQUnaPFHSkGAB8CenHovlsEYPKc9?=
 =?us-ascii?Q?POM2qESYAwaFaLIl9KzdVcBwDi1S8jsbqFJ3qfTCKnkN363c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2975494-2a99-4f4b-9acd-08deab242ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 04:01:42.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: km7FQgsfhOQzij34JCmc0guaeQF0OVk58f6jd0QoPmaXAYASewURK4q7jSo+mMitADfrmmWDYzKa9cvMj6+WAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11303

> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Tuesday, May 5, 2026 5:18 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> bhelgaas@google.com; l.stach@pengutronix.de; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org; lin=
ux-
> arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep sup=
ports
>=20
> On Tue, Mar 24, 2026 at 10:30:34AM +0800, Richard Zhu wrote:
> > Add pcie0 and pcie0-ep supports.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
>=20
> DTS part fail to apply, can you rebase to v7.1-rc1.
Hi Frank:
Okay,  would rebase to v7.1-rc1, and resend the dts part.
Would update the according changes later when the following two patch-set a=
re
merged.
[1] [PATCH V14 00/12] pci-imx6: Add support for parsing the reset property =
in
new Root Port binding
[2] [PATCH V2 0/8] PCI: imx6: Integrate pwrctrl API and update device trees

Best Regards
Richard Zhu
>=20
> Frank
>=20
> >
