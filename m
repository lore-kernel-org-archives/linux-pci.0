Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5438C2DE;
	Thu, 30 Jul 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395322; cv=fail; b=jGYcuaTwwIHSQ7M83DEaW/P473GYUeuy390/9DO0s2uNSYVHPh1SYmYPssiie4Ed56xi6DLuBZHy2zcKdE576782gSfTgOEAxWaXs8yRqyPMD9MbV707dl6aUibpy0W9Rprps53yDFUUbYZ9HMfDYdjs3PDPh6drWTBQXFS+igk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395322; c=relaxed/simple;
	bh=N24mOE4oTEzgeCTFAsKX6gBOHdpCYeszAxtZlYWxSi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGtI450Ly6Q+wol93OEPlhoguXyw023pCWa7hFVu4pzDls+QXXF/pI9EFxgTQzJueW8jh8pSnJb9RU5nlp0VbqY5WqzpVW9tYXdJac/XEeGjAerBRjYpEq9HV0HzxlOnXkSVIfDVW3RSLgpnWsAzvk5HDfBk/H3tJmIjb3CgVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xDbgn9dK; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xDbgn9dK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwvHDT015KXLU+sMOkiRDm7JYrib7uoIRpzgNItJbd5gdOZodSZTOtKfzxme1ifMv4t/2wfOPxn9DOg+GSzOuxSq++NI9sDyInLx3XNodDHz1FNNIehISUm8SdUzDqCmrRIkf62ZVhNAWLmxcEVBcDQQTU9rAhkMEjBMSoVm8LOEPaQJdfdu1NBgLJrUJi7gVIvnpTfiLVJtyBTKQi0hDI8mLItEJpFVPRzmeRVR1EPacT+4NKJTGTCE+x7LpAQrJyoquJsBJVpmVibhzYjZ2itUZhv+MA38P5Fz6E4uJZjaeEEbOszSRUfeF3yjKH9mDwyFGMyTn20zhzu0785EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghp6HnT6ehE6U14AgQPfao1L+DVjLPXFboZ2oYaLIy0=;
 b=nhpRyo817AnlY/3AfqzTGil3XKDtuAN4mUv/6UIQRFoXLu8omUtj3249gN2PVfgkqi6GhfUocspTxbYRCFY4d21MTSCsC9xclaziPguk1+Z4S4RPRK41YSaL28OYx4CetKaf2IiG2N5kUrQuCDEIpyt8WJli+4XLQEaxFwh8Vd86a4QPZKjBuiqmudH2RmJhoTgEQyyTcHZlI+jHOZyWvFp+XeRGXILje5Lj3pg2F8mT7Am1ksR6PS66Dvd2fE6XEhsxaipRjDCyvze8urcI9cgHR8Rl3LiogaJXr3NKJNVh9bHAUxtTx6RlId8mDqJuRNGeZ4bVCKZdNq5lJfZRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghp6HnT6ehE6U14AgQPfao1L+DVjLPXFboZ2oYaLIy0=;
 b=xDbgn9dKcVX1T21C2ZwnSia+oFDene9ro9/cc1DrOHHIxk/Tl+e+81G2I98bdqfYY14v0rl26hsbF2N14nKHsI38LrwQWROqWyBmelDQBy+PsZ4Fub5j/M37AH69hZClrY3HmZoWcJLqgl5WWrsO59x/4uPm4iYN1MhGyGou//WE0tB7Ja/hA+LfSgP0fZZIy8Q15JyQnLtHYXfy9XgXFoNGOyypv7lAboQ08p7F6HOQVl9kCc0r18hY1fannZptvHFVXxz6IILx5QzBFaQjOmw3NzFFXDNWGShawx8+xSuuqCgLo/s2ITi2NMsmzPnrbgcY8hKqwBSN6GqF3zFqkQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DU4PR04MB12326.eurprd04.prod.outlook.com
 (2603:10a6:10:632::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:08:35 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 07:08:35 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Hongxing Zhu (OSS)"
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
Subject: RE: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Topic: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Index: AQHdEznE8ZJEwBksLkioEzwtbW9MZLaEz/mAgADtzwA=
Date: Thu, 30 Jul 2026 07:08:35 +0000
Message-ID:
 <GV2PR04MB12019E9D17DCA17033C81373E8CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
 <20260729165635.GA1450437@bhelgaas>
In-Reply-To: <20260729165635.GA1450437@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DU4PR04MB12326:EE_
x-ms-office365-filtering-correlation-id: cb5f7d80-060a-4b9d-c71e-08deee095f32
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 xxM7TMG/5e5AfXsy/YxdIu6WWDWPlV9VM4i2M316gnrndSdKirtzuR7R+okpGHm9+yGSLcTGQcpXuPwBrJF5VkXVuchgyUPmQbdzj6uEukcFtA1PnqgBdaU5EUNHwubhisbIOcujuLyRzTdYbFYfFswy5vM7lt+IGJh0Ni+ZdVl/6EABijuTn2ecWsNm04KTLfaDJF6OLGuXs6HL8raiYyu875VKzTxof9gXyCQKdeKG9Xe3DC1MtPyUyEr9+MqH9ZTxJBKAJDk08POm+tTjXp6qr6Ki6fg/yqZB6tf0k43yByFVF0TOxfGpMAm0ghgpP3fwLh0nL5tp0xU5QNg0Yah2dMyDB10BF1kIsAU2iBSmZeHsVbOzfVwQ79bqkyZpeUrc9xqSzMfUPta+FERty5eVdtWgBSPxpnf2JacWO7VtmFhiF0kvIp51fPDZiK5bqnacV75GbkbFGuKlZb4qVclsruTuH1yw/tQ+RfZiIRHoGIRcSKTSNLPplRaPGeBVxOjMJ7mp5Wfnf6notYpil4IRPBPErYUFKzsZXRJZrLwL2XCv+LxWo9Ui5hBrMhJfbh9HpUczf1aNtT9GJkLS46Ii7aCeUdiyoXzuhmo3LjX6MIfiYxzNE/0u6q49QzwuOgt8kVrQT2emDg4Mrfpj5pJFvas98H87M3GEgBNfHGtkje2+glqFjjaa+f+N14fk16zTiWbjfWCAVNtrjGusJrIRFqo6vuDK56OKnmXjlP4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k66DrKCkA/VfhPJbDNSji3j0VZS8I8GuilNXYW6naHeRiIHFAPV77jxfjceG?=
 =?us-ascii?Q?i+9YOM5p+eXUxtT1RyHfMqrRMKIFXcOANxcwqvslLAsZw0/OSiP9yWFeaST/?=
 =?us-ascii?Q?y8mMCkHOx0o97T6L3wzfwkQ2H1iwn7X8wonJZgHdzmoAr0wfPX/5HgOqgsfJ?=
 =?us-ascii?Q?toVxTCIj7LzgVLJIrhYuiqdkDTJXOTkgyyA0Ep8cVqTvWBeu/AJ+vdrkDDeV?=
 =?us-ascii?Q?ADQNrUYEFNRzwYOX2q70/yhYatBd7OcIRY40ASPQMvgb9MSvz1pktiu2rnNQ?=
 =?us-ascii?Q?h3v+nJkgGbgJ3ktQFrN65GO/OgcByCUa+R7lwPACGrz0Ao8fU2x2hcJhtSho?=
 =?us-ascii?Q?+8TGcc4JIaA8kDf4Z7FhVVh/IlPvdUqASurN30Rj6CsHWgaOLDwusesRCo3F?=
 =?us-ascii?Q?DaRPS27VKBpsE+RHn2JuFoDuctVv67qINPaHla71Fnc4V2CqoQ38ciSx2Xxg?=
 =?us-ascii?Q?TzM/P8lqcXzdW3Nx7T2reXqH/VUdMw1BOnCKWy8aTUUDuCZap2StZQOQguPK?=
 =?us-ascii?Q?Y1KKPgDNeb4brLTU+bCUXGwljAzkewJHUvdCMpG1uD73XijgjEblMQlcokb2?=
 =?us-ascii?Q?kfJgxnXjp/T3Pgmqgq7ZfBmpsG9Zr94elsCmBKpg3WlCngHgYBSfABrCtNDb?=
 =?us-ascii?Q?870ScwtphBbI80BToAFc7lnACk+k+mSL8xQAfXjPSpm/PymgmOieHDxF0pgX?=
 =?us-ascii?Q?cCpVB2dGwVAtuYvi1qeeIJVth+ITCkLHxc8xEBo1sqF5Bb+5GwYxcjpqMz66?=
 =?us-ascii?Q?mLcT7VUgwKb8uvzJIvg+vtXTmyX8MxE7N+vE4poiPC3l/svrh403aRBTJbbu?=
 =?us-ascii?Q?dmLAZFpq6Z+cq2hrAuNNjGokoJJnfKrzhMN377EVJNfipMhqR1OvIvotrykF?=
 =?us-ascii?Q?FDx/uZ3rkOPSla058vg35ntxr7F6yViPpwfVDBu9mAjJSUiXsZ7caTCMynOp?=
 =?us-ascii?Q?yluxgCdBnOqUwl6iwRS9Lw4bxgsCOfhWxSxuQOnaUr2xlxjFRvRj2gI8Ed+H?=
 =?us-ascii?Q?ZvI3KM7rMh7uAxNk08l8GcVZddUxnaBHRna9xPnaBzwUVel5H2jmIsGLrynK?=
 =?us-ascii?Q?UyeeIyr6WuRn+kKFyW5BDpqKXcV9ydKBoVnQqPrp1VzVp9em3zC3gPcNHxnF?=
 =?us-ascii?Q?pPdLd/A5XVMWoCw210ZQYbgkhXkiHcK5gqqAW3pDfSLkxizsxW3hDjN8Nin+?=
 =?us-ascii?Q?ByHP9Nnf0fSL4H45CyYnRmMi+kUTpNsMiBSh0xYEPTilepi6/y1Oti8kmk//?=
 =?us-ascii?Q?TJcIjWv31XOKRm34OYKP6jD0G4vtJ0hSMRtr3huOXHDhtW8q1QLCPfnKlkfK?=
 =?us-ascii?Q?mHnlP18TCe84xBYWVd6KKIEBRxshxu8hHpNqFUA/G3KBz6Bcv9BqouOgED5X?=
 =?us-ascii?Q?EA4Txdmb/ombmHbswA0gX2JbmNsy4SYZ8erP0bq81JM5/wkNJj72UC7S1AGC?=
 =?us-ascii?Q?VjA9lEpgmEAHOE3+YBjPsNezUS9fy9Smbi/2mOqNSpgUT0oED8Ot9hVgTEJy?=
 =?us-ascii?Q?jEzeZ+JKUtoDodVrdFt732k2wcIgDC0kl6HSfHRs9N6Y0HmtA50tSGpX1QRq?=
 =?us-ascii?Q?tEL+LXWLxJdqEwRiSl+qeP+KglEU39ZVw5tkQaZL6DRDMGjiWHPBA/HAr2wY?=
 =?us-ascii?Q?4YfMoSb6HXH+b8M/QT+iELxuVlsh7sASBcl3wKCsS0L7E0VY9N8h23OGyfZU?=
 =?us-ascii?Q?bM9mxLGfy9y9nQHWCif3SSWcb6wKItqcXsfndYGb0aG53sr5slFTmlTpljlv?=
 =?us-ascii?Q?ntvVeuU83g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f7d80-060a-4b9d-c71e-08deee095f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:08:35.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RihetGVXMDIa3D5anRpP3CKNQxxJ3+eD9h3qvCdEHZU4patbsDAmNZ/UI+c+kdvAccmHkz4FFE0j5r8wF3iq5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12326

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 30, 2026 12:57 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95
> Gen3 PCIe stability
>=20
> On Tue, Jul 14, 2026 at 10:41:07AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > the default MPLLB_BANDWIDTH value. This margin degradation worsens
> > across voltage and temperature (VT) variations and different test
> > matrices, potentially causing link stability issues.
>=20
> What does "bandwidth marginality" mean?  And what does it mean to observe=
 it?
> I guess it must mean some measurable thing is close to being out of spec?
>=20
Yes, your assumption is correct.

The MPLLB_BW_OVRD_IN register provides an override value for MPLLB_BW (MPLL
Bandwidth) parameter in the i.MX95 PCIe PHY.

The default MPLLB_BW value is 120. During Gen3 PCIe testing, this default
value showed insufficient bandwidth margin, with further degradation observ=
ed
across voltage and temperature (VT) variations. Based on IC designer
recommendations, updating this value from 120 to 140 (0x8c) significantly
improves bandwidth margins across all VT conditions and test scenarios,
ensuring stable PCIe link operation.

> > Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> > improvement in bandwidth margins across all VT conditions and test
> > scenarios.
> >
> > Implement PHY register write helper function and configure:
> > - MPLLB_BW_OVRD_IN =3D 140 (0x8c) for improved bandwidth margin
> > - MPLLB_BW_OVRD_EN to enable the override
>=20
> AFAICT we don't know what MPLLB_BW_OVRD_IN was before, so we don't know
> whether this increases or decreases the value.  And we don't really even =
know
> what MPLLB_BW_OVRD_IN specifies.
>=20
This patch increases the MPLLB_BW value from its default of 120 to 140 as
recommended by the IC designers.

Best Regards
Richard Zhu
> > This ensures robust PCIe Gen3 performance across all operating
> > conditions.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > Changes in v3:
> > Regarding Frank's comments, refine naming consistency and clarity.
> >
> > Changes in v2:
> > Update the register name and bit definitions.
> > Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 53f3da6ab30d5..fadf14de10f7c 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -80,6 +80,17 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
> > +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> > +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> > +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> > +
> >  #define IMX95_PCIE_RST_CTRL			0x3010
> >  #define IMX95_PCIE_COLD_RST			BIT(0)
> >
> > @@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct
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
> > @@ -289,6 +310,11 @@ static int imx95_pcie_init_phy(struct imx_pcie
> *imx_pcie)
> >  			IMX95_PCIE_PHY_CR_PARA_SEL,
> >  			IMX95_PCIE_PHY_CR_PARA_SEL);
> >
> > +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
> > +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.34.1
> >
