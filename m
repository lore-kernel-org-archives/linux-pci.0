Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14440D577;
	Tue, 30 Jun 2026 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808459; cv=fail; b=W8Wtl6gskfbv5tVPFnuC32A82ES6QhhBM+tVhijapD6d7lfR/c0t2W+6K9hIObNbQNsB32lt2oBa2NqzNWXB22QzAEI0FhlTV+2AK0Hw0nwWMUtA/r8mTBRtkTy9w9OABQEBBk6dZJcWMQ1Qx2Qvri+IB14QsmlowENcHD1aAeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808459; c=relaxed/simple;
	bh=m9Thodahux1U/41sPjrKFTtoI1hfG3sjk6tfVD0TV7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVTkBTFcnkLcMold+HfqnqPFZPjjCZqKTpzl4MLRY3Y+IKtN4XJiu5cCPgzNB7IJaHM6KveJGHnygQ3djKC/ZIyVES446LFDTo+NXsAhN45bazmp7eTVvCsULaN2yivclK0BseG4UnIUZ5Zfdaid+taB2pySM94UTGGIqq0zxOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAOhZlKt; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAOhZlKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaAZU9Z7uiSV5GKYoN9PAWxTnTfQcKdu5mc3m1r2kuOmW/2t3bMxasR0y+8XXumjiQrehYPcx8gMqbJ5SAtps3hbz4OUE4PmYeQ9KgZYmwnPxDHdkvvulEq+r7G4tIMJHsW09CS0xkqYWTiC+If81IN/g5SYQY52qzRKu6wCPZRS8V7imNBQAeLmJYzdoh5FNDadpRU/7JyLYPskubaP7NpNH5fICvdTaxIuYIrHwfw2x1koBtaKOd1UXBI1B4BAnlR4CK7WCfhkIGL//3DC7bS7Ivw59d/3sZ1Q+zaLx9YPj5h/WCqMmUxpstQ3boeXEUYtcVBT5j/zQGYtBaOu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9jAFz+E3xicJfy29Rwfbn+24mWlhK7pRjj0TDuSh9s=;
 b=g5OL59mcblQVw2+CI0XFiyOSfLZxB1FDIPSF3D5j6wyB3D0pI+MAGzpo8d7/tzYDGtm4lms2MUc+Bd8DxjuvnNA9izZQO/GUbOQzEVauqPxY/Iago5bsg6RyGO8UyGkqmRSGEKYBbCouP2hOs5jUKVpSvSdHk3UTpd0h0DeQezGbSCbXL7ebZThr4CPrfrFBIxwM/w9U+qbisiuC64VOFpltB8VTCNbKOLK/5cKwA7K84/rht0ya/5O7db8v0kPHObAzMuqm4WZC8o+JHc3MdIEMu5foD3FJKWrpKdUdvUeknPtL09ZSSWxtFGaVqKNoN14AIgl7BMaWOUSfurwWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9jAFz+E3xicJfy29Rwfbn+24mWlhK7pRjj0TDuSh9s=;
 b=CAOhZlKtngjhNb+dxwKlqrid0K6FM4MTrGyAkwqXJPgk+8dKHk2hNtfLSPKG8Gi9+kHxBfnN0SDu8v3TXxOQPJk4M/HQWjs3weof+fzggU1WYfpieFe4Ev7Rap7Obai1xLy894WEmPyu29ee+ymiwiqfeJ2+gilOT1BW59yk4zggBCUE8w8Ue6IcMPS50UzlEkop9eRw4qBx0DALq+h4K1yESC8yXVffrlFEZA1zChw/yLAsmjh6moSJLjPbHh/e0zhTTrYRzFGeDdbX2LnsagUKga0xTKxsBAYZfFrMoPp0CtRKv2w9FyRvZ3thmy2RJXvC7WiWWUQqZyzJ6CPs1A==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11769.eurprd04.prod.outlook.com
 (2603:10a6:10:627::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:34:13 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 08:34:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: RE: [PATCH V4 4/7] arm64: dts: imx8mp-evk: Move power supply
 properties to Root Port node
Thread-Topic: [PATCH V4 4/7] arm64: dts: imx8mp-evk: Move power supply
 properties to Root Port node
Thread-Index: AQHdCFZuCjlChkP6t0erd6DaMXaQxbZWoCOAgAAklwA=
Date: Tue, 30 Jun 2026 08:34:13 +0000
Message-ID:
 <VI0PR04MB1211468A5EABB1F0F2EAE2A4892F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-5-sherry.sun@oss.nxp.com>
 <20260630061930.07B141F000E9@smtp.kernel.org>
In-Reply-To: <20260630061930.07B141F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DU4PR04MB11769:EE_
x-ms-office365-filtering-correlation-id: 6422f5b7-00ce-4419-fc6e-08ded6825da1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|38070700021|4143699003|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 Wtz1PsgbT7zX0kGnR1G0NfpJIFb1M7foB+L3YyFIio/G6+lqh2UlHGS+2/ypFg//YCaQUtW5t3ZK3nzLzrtmnc9oVDalf2RcYOZeq7XI3Txhs5QGojQisUfguxDLOr+dYQndove+Urk/1w6aB0qm9TObymf2907+Ze2M0l2i3WoiehD4s0tugkqydO4WS+cVzg7AymdStLvtfz+GWiLadjnbst36aiw2vYO6DyTBLrGrnihDVIkqOCYRNqTnOL/C9VP3rovGvTj6zpfN1oJgFtfQH4hlrjSTuVt+CIWWyUSyvl7J5C3Cn/TkgK7L2LBShujeiT5EyckOz2ZXLrYd5lMXR3C6EBqVPMLUAS7kfgeBS6k/eu98Huc/KammVToryw3lphsSHumOfiN6vx4h8jSwA+QUUnG6UQOdYvXYYIOg1yoMmkcszoe1ap1GBTOX8V9tCXltMom5cuw2yC85sbDJw4K22UZFACmkST+/EjrSFUSiUFvXePO+rgflXOrQ59p6MTlBoFPD08MqhhaiIv/RuhU/qlxs1WgUs4GAXdQHizjxfhqhrLu2ehzN0a5T+oLfk+l1EeoCUpd6upderefh1mLQVG8/PIpAGZA8A8A8R79juBbiHYtnRk0ZX4iZVne0r8DwWHZr4pAT+DCbzi5gZ20+Q+lrxX2o4fZaaffPZwo7wIGMuoCbZtMx26eNKuic3bwrVCoK5ZA+i61prhac4YmpGqqUUc0t+50ZMf0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(38070700021)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GGjhrfF64p2w0CuOewBVloo1givMOgKL52RZ8tvka6gjnoZ6rBDdXhUbiLQq?=
 =?us-ascii?Q?NCzrq0oCqsp/vzxRDh+TZ6qZFrkJgFg2sLEUO5QQu0/wG1Q7shJ7ecaenknB?=
 =?us-ascii?Q?3F0Ct2FHffkjtPMCZiEALQHqds9IN2g5wwjb+LkxYOioIKzqBRyK7KB2mO7m?=
 =?us-ascii?Q?mJL7a3Ylm0WXvaFrFTF3/fiXmi+C9ep7RlvoWEh6xM569HtgZa8qXJJ+14vA?=
 =?us-ascii?Q?Kbe4Bs9+CHZ2WCA6al4PvJkuyXzfhVQHAV1xS6sralrnNxMMnxPtZ6YIM/Pi?=
 =?us-ascii?Q?xOdmkFlOjNu8VIsqioPF3XGagPZNPvayxI9iAQB//Io6UaeMJfLDtL4keXvt?=
 =?us-ascii?Q?MgLdsWtnvSyHAamjGuvsxq8XRtyCAvbets524XOQRyd5ZPlqYgDNPdDBGAmQ?=
 =?us-ascii?Q?UPLFj/9k71sK5cgjHqNkqy+eU4/rjE5XPugXCOL7nktofSp9ZAD4cpSufRqq?=
 =?us-ascii?Q?cEghnJ9uadYboEsDfVKN67hZZoYxZVrTFu3LmdL0nGcpfT3jUBx+ImniUbuX?=
 =?us-ascii?Q?A/vCotpp9q+p6X07FfYUux/wWhtgJDs8rTdd6QdsB48MIsVRsuouNE3jf3/y?=
 =?us-ascii?Q?bv1gyfLZJ8Yql3MmadR0oQo4W2tq09CXXxtcs2tCmPzxs5BB89C3Eox3rM+o?=
 =?us-ascii?Q?2jlDf1o87/VCuAqALDTvozOD0kXC3+78s7dhUw1ofInFlH5qMabqhZjFe7LM?=
 =?us-ascii?Q?fQtKcHy0bziL6y0czGbKAtVQk5sdYWG00yhdiEcWr/t08qgd2awqKWN+3GMC?=
 =?us-ascii?Q?ZcG6gcJufwp9ExluA1OFDiBZ1PBlPtDaYw9c80E37Ldlh9OmFhv2/j83dBuq?=
 =?us-ascii?Q?KuF0jRRQoruZDk1TyJrcF5CFBfZXtC1bAJ6rp98uuPfcRN5XRpqIn6Q08gG6?=
 =?us-ascii?Q?+0GG3v3vpyiTc/lc8oUM9Qei9i2/kR7ozwDf9xFfiDH+8g6jEMBjGpWfVhfp?=
 =?us-ascii?Q?h2zx948GLKyVi87EXcOGUBuct8clt8tDUnR+FU5mYtkDV+VNwjwxateQrapH?=
 =?us-ascii?Q?x9sEEesvUiwHKOHINeWWLxFH9iCfJ4nduWfqpXtwFvuipDdlEaCwlkAfryc4?=
 =?us-ascii?Q?p4/TGOwgM12kwbbykAR0NtSzx7JB8Jir5XuymjI6PQtjeQTuSrwDMMktLytg?=
 =?us-ascii?Q?XAdyl6DI5IFBoQZwItQKjxGfnNtcane2dR/6t/NnktRs3Pncn5GGJz+QX1ph?=
 =?us-ascii?Q?eM2ehJ9QSGVOdIDIUOXx66tsZEzz5CXmda6LliDci5lKx/sYkYZL/668qLKB?=
 =?us-ascii?Q?s6QtAl/bEo0ESvrc1HZuwbJom41Y/4EJK/5MELzIjrJG3prVzIFHN+Y0AJmD?=
 =?us-ascii?Q?eFxJGIM9yaW9KtMB20kwP4EGZDBdtSB8oYV68nw9wNYr/yK0qxNtiAFWexLT?=
 =?us-ascii?Q?/F2Nbp2HSPGamN7Z00lLqzQOIa7RPtH87X+GBONS7Vz42gtcTvWTDprlt5z5?=
 =?us-ascii?Q?vd2xPLWYFrBI2ij+PBYePL+xpl8pTLOSKvZYQ64+Amh8zXOoUBKaUbazBelj?=
 =?us-ascii?Q?25B3b9TMMDu4V2G1uR1UAgVIr0oEjIxYXifhkhRX4H5JqCqhejPnqnI+2Pc1?=
 =?us-ascii?Q?Ery2LP6qOqqvn4DziMW/7VHSPEltPewT3xj0oRJjHDHr7Ff7XJ93uIMXWNoP?=
 =?us-ascii?Q?Z1MIaeAib9Jp98xc3/WJaxjfOjRm43iqlTjf8JFW12ticXE1NwmNTxO7PUVn?=
 =?us-ascii?Q?+Cz2NispcYsZ5oLsZ5B2gImooi2ujsqR7rObHCoO0FNYB3Tp?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6422f5b7-00ce-4419-fc6e-08ded6825da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:34:13.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRfBYqcKCU4aGJNOd96/w7N5xp7ZQ1W6SFE8KoZqFi3PbNrPRtsaoEG1KHszJre/QDSx+2ESeVMxyKQKpIBWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11769

> Subject: Re: [PATCH V4 4/7] arm64: dts: imx8mp-evk: Move power supply
> properties to Root Port node
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [Critical] Removing power supply properties from the PCIe host controll=
er
> node breaks backward compatibility with older kernels.
> --
>=20
> commit d2930da890ce2314f11817b05c9728d18176f34c
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
>=20
> This commit moves the power supply properties from the PCIe controller
> node to the Root Port child node to support the new PCI pwrctrl framework=
.
>=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -772,8 +772,6 @@ &pcie0 {
> >  	pinctrl-0 =3D <&pinctrl_pcie0>;
> >  	/* This property is deprecated, use reset-gpios from the Root Port
> node. */
> >  	reset-gpio =3D <&gpio2 7 GPIO_ACTIVE_LOW>;
> > -	vpcie-supply =3D <&reg_pcie0>;
> > -	vpcie3v3aux-supply =3D <&reg_pcie0>;
>=20
> [Severity: Critical]
> Does removing these power supply properties from the host controller node
> break backward compatibility with older kernels?
>=20
> Older kernels (prior to the introduction of the new PCI pwrctrl framework=
)
> rely on the pci-imx6.c host controller driver to parse the vpcie and
> vpcie3v3aux regulators directly from the host controller node (&pcie0).
>=20
> If these are removed, older kernels booting with this new device tree wil=
l
> silently fail to enable these regulators because
> devm_regulator_get_optional() safely ignores -ENODEV. As a result, the PC=
Ie
> slot will remain unpowered and endpoint enumeration will fail.
>=20
> To maintain ABI stability, should these properties remain in the host con=
troller
> node as deprecated properties, just as the reset-gpio property was retain=
ed
> above?

As documented in Documentation/devicetree/bindings/ABI.rst, "a stable
binding means that a newer kernel will not break on an older device
tree, but that doesn't mean the binding is frozen for all time." The
compatibility guarantee is one-directional: new kernels must support
old DTS files, but old kernels are not required to work with new DTS
files.

The driver already preserves the legacy fallback path for this:

    /* Legacy regulator handling for DT backward compatibility. */
    if (imx_pcie->vpcie) {
        ret =3D regulator_enable(imx_pcie->vpcie);
        ...
    }

So a new kernel running with an old DTS that still has vpcie-supply on
the controller node will continue to work correctly.

Users are not expected to pair a new DTS with an old kernel. Doing so
would break in many other ways beyond this single property.=20

The reset-gpio property was kept to avoid build break if pci patch and
dts patch are not merged together, will remove this deprecated reset-gpio
property later.

Best Regards
Sherry

