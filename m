Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C873161A2;
	Wed,  2 Sep 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336260; cv=fail; b=usDhX5CqG2y1xcPcDi4g7EfSeVJZmDmGomEFCY1pjJFAxevlzvIKg676+pvmtcuEqBs18HZdPEoGwREu1bBeLnCL2oaik8bxOsZjUZWFFnrie0n3L4g8/N6AwnYgiGOWXg2PBK3Yr8cbSVKGAMGLWNQtdpUKHIXMHfC52ffvbXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336260; c=relaxed/simple;
	bh=yan31QHvJihkubQlUthsQSO25MHB+Mr+AV/xk81V0iw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9JkHL7oF3TPQfn7s7ZQAZ98XfgV6FToz6mZ7b1BPaT4yyMgAxU9DCRei+z+0gVQucvzwAE9PmPB+ZEuGr9kOUCUTCklPqfagIsLKH1VbGsZDW4csNC3iqlKmCnbQe4ndM1suzhJD+5QKCu31jAEwmCahIN4oL+uq+zuSBRG7Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n0nASsg7; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0nASsg7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKK/r4rvZeVDRwPjLQv64B7ayT9x9F0USkvT28+y3FBkUNjPBtLfmTC39i9qU7lkBpvZaQXKuEmTfCiNnfGUogiTWiyfqXayR2Mc02GJeLHT9JFPfJPV/bHiFa5d5BvDdn2mhtsQ4+OzKXcJ4iG3cY7m/o7F92nZYs8sv4jdp/IPnm9dp6beDoERadFecfU+15eD2XUi8Tunwu9cI3RfXFPDe0oaGyhyFODz1wuhMvhyh8PErkHc0CBPIjlg/55/Gg059gSzsd2ZRkVCMWzow9e9PtgsfwaSrQG6tEDaFdiHN1HGyr+WjtcchdlGXLE+8juI+5knpccMdvfkBRVwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIWT8NjT9D+AaSquZYEzdoAy7u3WlsN+G01rdybEXW8=;
 b=hJrg0w7SS88/Hso5TM8U2mV+ovQR++H//NsrhTonRJFlzBQ5a7klc58uo6oiV85uzcLoof5TL0G7fn5pqSydAzqNYeqNEEGAkbQ9PZWZFWJpv1hKcRxydPVQXxceYsfAIVi8BpxQj5hbjUlyM/czHSdurMyR8xNSJjmJ2xMxb0p6syHMVzpoE841xxhV3uQP/bBmMkGkDnAEISzqHPuza4erj6FJjNHSbde5s07DjLgnh9fjyCNmZo9MY6ZtzHLD1Xp1mvfdgsMhifK+EtZcb7mu3261ULcp9ltEdVEw2JE3Euv69WNEb/A4IgrwxRTNETdy8cqnhHAjTVtW2V+70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIWT8NjT9D+AaSquZYEzdoAy7u3WlsN+G01rdybEXW8=;
 b=n0nASsg7Z3kt8piLueMfTqxLoJ9V/xOdI87t1VMQ+U2l0gW9p8azRwkm5sFv/Oc+8EK6E+qTl/rZPi8xgzPSWirTlclotQi7TLHiHgzJRwns20h34Mj2Aebx7U09nKeDhS5tlR91ttucaJM3ivIpXua9JWqm6IlQok2xh21pYwQb8LtV0f+bTwDK5YiX41Ejw3pYyiyDCogMMCR5gBDhuVQE9T0bzr8kc+yZVzUCAEGiTFCHarrEIAqRvqsw2qpovT50+H14Wcb6ZmVAw9rWvP3NnYlvP7l54QS5KaSTU4RWxcanFjxnHKPx7Ne+wIJPD/n9UPLQoBjHWNHb2pNkVA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI0PR04MB602228.eurprd04.prod.outlook.com
 (2603:10a6:800:363::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:04:15 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:04:14 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	Zhijian Han <hanzhijian1991@gmail.com>
CC: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li
	<frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring
	<robh@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>
Subject: RE: [PATCH v4] PCI: imx6: fix resource leaks in probe error paths
Thread-Topic: [PATCH v4] PCI: imx6: fix resource leaks in probe error paths
Thread-Index: AQHdM9n70fwYf+Kx3kGly/dGwwi8S7a6+GgAgAABnEA=
Date: Wed, 2 Sep 2026 08:04:14 +0000
Message-ID:
 <GV2PR04MB12019F7317287AC3FCAD939F58CB72@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
 <kyuxfl6wmsytudadd2dazw7norz25mpsk6bjsfxsj2cpo7yj3h@eujfdbehavzm>
In-Reply-To: <kyuxfl6wmsytudadd2dazw7norz25mpsk6bjsfxsj2cpo7yj3h@eujfdbehavzm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VI0PR04MB602228:EE_
x-ms-office365-filtering-correlation-id: e0918223-ba3f-4db6-cc0a-08df08c8c7cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|7416014|1800799024|10067099003|4133799003|56012099006|11063799006|4143699003|18002099003|22082099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 DW/RNTYOB5V5UhqCYekDOWJ4E59iS3OnzK7DcUVGo66yY8/N4z1Pn6ylrpQLk2Pc8K6i6sS/81cqi4yb1rMW1XwZEbfiZSAiXbryK+w1P9NucLLfej+UT6dP7CF7wFiR7pl1iIQKCLQC+cO9kfhagykoih5WwNvwcRAOf18+eqxwTON14dXdkxYCLkvhGYq7+tMnOBJ4hkHsd7G7XdKjGPFPmMfH5JZxuDeeEWaJvb9azUL9hOs3G/wql6SeATVRb7qHGQHIfyIxZ+TLrhhC/EPro+J3gcljgTllELrLbMTIoq4jdwUKNL+FWB49XVOQ29l1hS/+YPnVlUgDbCvw9Yiz2WfkqwkmdxM4lO34vFhf7lyfZI1fuCxxcFI48X0oIIdQZDZTkFxocvD4uDeJfGWPu+cVmlWHMHbDEnrVbkx/2gtjay/MPluFtw9DjP3FIS67aXga8LXBfrTwTSJD3xqKKKGdK3t2P0h9WSuCL3HLvpLEJ3kWwBOXX19MKkedAPdf3u2SAS2w2JwqfYk3v1nDcxPdfxVG6iit7DWjNRlbTXWpgu01Hju2TzHsSw9+/RKZmb9+QB5KKxaAXWAt+SFEhXR0yYy4Q8G3BGNLPMyg/LAH3yWTIDtXKkDJEr42jZO8LEDeH7s1Yxc94W9XVbxMTGr0pXLP2dhf69pJdz2zlRB/XonkW3ZXqjLVqUtsFhgaEAf9qrTUQh+LNuV/eRA4nhF67Wp8btagIAk84UE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(7416014)(1800799024)(10067099003)(4133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?3QkhT4rCgmIeGK+6JPUAm4sKGW485PHorgvlv2UMcT0rZ3wDPeYUgG+wyl?=
 =?iso-8859-2?Q?luPyXH5NA3lxumgU6plzaIWqbZTg4PEg/TimxYS7HsLQIfUJBDncC5h+xa?=
 =?iso-8859-2?Q?5SuKK/jWrPRR3pFTF5AkRiZMjgu4SxsxbN1b6ESGAlN+6aSupU87IBRzc+?=
 =?iso-8859-2?Q?F2A0LYVUQUeTkVyk1Ljn7in2WPioSSObFMB989EwrZaWtpZJR7QJKrKvRo?=
 =?iso-8859-2?Q?rX97iBzWWq13yihXp2XQxmMKKEMnTcdF89w2rYa9MCN6hrWgrq24OWuQD6?=
 =?iso-8859-2?Q?dVZDHkaAUD1dV7TiwJE+yggjqaaa/msbKo596O8EFDet6Np9wk30nt9wxL?=
 =?iso-8859-2?Q?8RijImu9fAfrR8YNMFlkxsF+w5c89ImNILba7fASle52lIddc2tjx+iEiQ?=
 =?iso-8859-2?Q?KWl9S6YIHT6DwqN/9PvKOrn5apXIslfol4HxoPh2DYeywV817C1B4DDAeG?=
 =?iso-8859-2?Q?Q2ivNiAa3yv93kk9ZmvJAI6IW5LjDMAUgLaoITDijBBnzl4xtHgZlHfzum?=
 =?iso-8859-2?Q?cIZg2k89VHjFUQ4FHPT8CEBrQx66wi3wUybJ+79qivUpkA9zzqMMenxxCw?=
 =?iso-8859-2?Q?Hw88pMbZ58+AuLXXcImoVJy1OtVks6w/NkSPH6W6bqXrSfm1N/8cAQYpvR?=
 =?iso-8859-2?Q?MZPVHbAN0jZ6pCME+n1q1bLR+tmBWLaOtH2hB1NFwiTheU85UFtq3A/2zt?=
 =?iso-8859-2?Q?+wCofmEC82fQzWqldnims10BgjowunfOavg/400VZhD25IXtdGofUaLfdU?=
 =?iso-8859-2?Q?BIQkLOASEdiVGvjJjkF8fM3Y12cuoBbhCTLJpINjWghrmSF1m/MvtrMLTQ?=
 =?iso-8859-2?Q?BH9RofLXCofwOsBhP8WNNBPvCEzRQeeBiILp27gWu2Dyl0hR6bbLOAzpkp?=
 =?iso-8859-2?Q?8fK+8vAcrDKP0YHgQMVqgHRFsddoDslwHuotT2CWIDOXjKShsCM3QfxwRY?=
 =?iso-8859-2?Q?yiAVriCjEB1Q796drCwxd3av/JTrL8NbKysUVwbFxEFpWo9KalGcFYiVw3?=
 =?iso-8859-2?Q?FPa9uIYbTdzM/7f7l3q1/K/jZng8LmrjDqa3xG2BSCUvUaESFtfDVqpr/V?=
 =?iso-8859-2?Q?nBEk5jq3wTiUHHcyUyXcPfLOSusDM0qIj8xRN7JENaOd7qYYIvYS6G5eRe?=
 =?iso-8859-2?Q?Fg0sazlXec0HpIxxA7TFrgComOf6RO8fRnlBORpglFVUmZchKGs+fcvwEU?=
 =?iso-8859-2?Q?5KlL6nkzmzVGMtVtq1XYQiXJQXas19xJvep+fR/hwz+qWsblMY40TBaGfn?=
 =?iso-8859-2?Q?hk3OJWFyIKbEBQJg8ivmhwgkOBfi4gYHHK8+WPeUPsGkGeV9KaQZykQTfN?=
 =?iso-8859-2?Q?7zLZPw0KMEBMcrjgPuhJKtLQ+I59/fXiKSP7hPLxQVXHtjQrZFDc9J28E/?=
 =?iso-8859-2?Q?vPsIXSsujbriupcBBSdBU86W/eED1OXZ2IzEWti7xoL5qS0Cw+20+tGndE?=
 =?iso-8859-2?Q?JQfWewmc+bZdoT4TDV3Du1/6AfLnG+BcYsNHmbHm67/bSZvEChYoisfLMx?=
 =?iso-8859-2?Q?lIM7FFYI4nPQS6krYBFqIpxDahl5rA0WNZg5iLaUf/zKBMbvw2SJ46s4nF?=
 =?iso-8859-2?Q?bca7Z//MoS+0NBJL4vJmHBsCztGfkLaHHjXpZ8J0emRZfd0oZAcm00fz5i?=
 =?iso-8859-2?Q?p0l2fQRJQjQqsNRnRYbylSbPOMDbaLrOuKOZ574p7YoTeyZv+YU9GStptp?=
 =?iso-8859-2?Q?p0R2vvngJX3GdqaReJAXBdvwB8sfvfD7s/gJz8t7VfHeQDi3FPkuTAP+1r?=
 =?iso-8859-2?Q?1yeT0LC894RfH0zCRy8yfHEyU3AV9f8Co2rtpyg2h2kRnY?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0918223-ba3f-4db6-cc0a-08df08c8c7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 08:04:14.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qGoFsENAs+EAfK8QNIUz0p7f1OD8rUp2BvpAPSw6NPfrmZudr8lbmfC3g6EEVe2Vxf2pFVHF9qTsnIh9zVIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB602228


> -----Original Message-----
> From: Manivannan Sadhasivam <mani@kernel.org>
> Sent: Wednesday, September 2, 2026 3:53 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>;
> Zhijian Han <hanzhijian1991@gmail.com>
> Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzy=
sztof
> Wilczy=F1ski <kwilczynski@kernel.org>; Bjorn Helgaas <bhelgaas@google.com=
>;
> Frank Li <frank.li@nxp.com>; Sascha Hauer <s.hauer@pengutronix.de>; Rob
> Herring <robh@kernel.org>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; sashiko-bot@kernel.org
> Subject: Re: [PATCH v4] PCI: imx6: fix resource leaks in probe error path=
s
>=20
> On Mon, Aug 24, 2026 at 11:04:54PM +0800, Zhijian Han wrote:
> > imx_pcie_probe() leaks both pwrctrl devices and power domains on failur=
e:
> >
> > - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
> >   and adds device links to them, but nothing detaches the domains on
> >   probe failure or deferral, so they leak.
> >
> > - A failure of devm_pm_runtime_set_active_enabled() returns directly
> >   without destroying the pwrctrl devices.
> >
> > - A partial failure inside imx_pcie_attach_pd() leaks the power domains
> >   that were already attached.
> >
> > Add imx_pcie_detach_pd() to detach the power domains in reverse order
> > of acquisition and call it from the probe error paths.  Add
> > DL_FLAG_AUTOREMOVE_CONSUMER to the device links so the driver core
> > removes them automatically when probe fails, instead of tracking and
> > deleting them manually.
> >
> > Reported-by: sashiko-bot@kernel.org
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F20260822013640.182C01F000E9%40smtp.kernel.org%2
> F&d
> >
> ata=3D05%7C02%7Chongxing.zhu%40nxp.com%7C8285e77d3eaf45f25a0608df08
> c73e1
> >
> 2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6392393239841792
> 60%7CUn
> >
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
> CIsIlAiOi
> >
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dgcw
> b63Hn
> > dHcOrDQnwD37rUN%2F0EUDcnIZOOGrZ7Ylzio%3D&reserved=3D0
> > Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to
> > imx_pcie_probe()")
> > Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
>=20
> Frank, Richard, can I get your review for this patch?
Apologies for missing this earlier.
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
>=20
> - Mani
