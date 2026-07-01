Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8143E0251;
	Wed,  1 Jul 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895483; cv=fail; b=j21waGnVqxmeii67Vb5Q8eOFav5kHev8ovI7yB4Cm0IXD+s9zuQkNLnTIH+r0JMfgDJjbjq1H+U3HxFp947v3NB0VInRFDgwKdB6VJWRJzDJhd0XZnm3OR91kkdNtiHlUZWAnh9XbhiF0jlsnvjgJPoi/NbSsnyyBMeXr31YceA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895483; c=relaxed/simple;
	bh=Whj0KV2CaoNkDaV8SxdpxOkdvhpQ83Bci/CX/Vffps8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dkc12QP9GBPyBSQ2u8RmZB12tcTrpoGlyZ8eMMewazSNn5bz26oN9yXJXVf4EtMQerBggTunMb4WPDeI2BnX2RaEnU0ID/nfnnYDwdZ0bY7kKQahpeVMoFFpSyO1T6FXl9J3GRCanIw3rEg1boZhaV6RimcNmtYKJHTBspz6FWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jGInEOP4; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGInEOP4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1VoyLKC4Vanr0zli9EpBCo2wikxHsSv0JkyoQ91pAh3JvvI2oqzAqwVnmAs1T+bWThIAModhWdtDRcVPbAaQsbRuF/fMCo0vjQ+k1ohjxuBuYyKjhe78Xx0pr74hjcqVW5Y9TkuPR7Mg+4gR09gB5kaJhkyPvlW8Ac8NMOsLEgvQHD7VhcLLYC6E8VLEBjMMdH3nd+7dA7lJgB8FHymEs5QY4uJ8UcI0dJ/LbSZYeUPIhMFBc/ZB7w8jIw/2SWNPWdnDGa8o4NkyO00jGDb7pxxi1l2ALfRVls/1vUNRSou4j7bGXroxlvA2o6mgOvatEWALm4vaLAPIqrvEBytKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP3Lyd8qHLC+Q4f0sz8uBaHGc/CaG8mCQH8g2HpciJQ=;
 b=WEYdqNdveZHBwtYNVgnf8k4blHTkQyEl0dB7ixrtfaet/1VsovaeSu+e7Kb6yIHZ3naCNA0jTzU1sExEf+RL9TIoUItkBtgJRePjk2nskM1cJAbXDTYDtUXJzi/lYwiQ19Ipc+ynuJJW3MZUqcpux7ATpny0HLXKa25V/SlVRKw9A2CW5hM9cApZyLZHcmQ9NkMI8pR64KPwLB3QmcLfn8Pf01Si5CRKC3E8gI04UK3jbIbddmjwDF1R/qZ7A5GKtLx4BMUilbxKpKaU1rgfCen2fStCG52Flk8E44UCjtBZ0EeIO2qe7c08KEx19hGuwMS3SRzKcJ2uSwhXRXWv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP3Lyd8qHLC+Q4f0sz8uBaHGc/CaG8mCQH8g2HpciJQ=;
 b=jGInEOP4OcyMs84r+R5FXvCMhtPkIgLpa+4lqbPOybeJD2l0rMgXqSPJABfutmYUIzsjXZ/BMnMFYMBaayeS9evg7kZaiMMal/MoUtv5Qt44i9eO1BTBRhBR5YEw99qMX1REDR7Gr+byXmcxoubWso4NQsF3CVucV/zLsCw0f6pCMgtNfG5g+0leNdmrsNoXgQjScnQSZgOgZqJmiDFUfBsruyj1GJyNxpcHxbCTagPBRAbaR2FViiDWI1wbTNI8db3TIyCvtaZnFQ0w1VczBYtKKeqH7Jk+1wYo8cCIZkRoBuJ15ppjXlYzaL+ZP4GBU+a1E1S3P1VAToQdTiwOyg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10411.eurprd04.prod.outlook.com
 (2603:10a6:102:424::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 08:44:38 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Wed, 1 Jul 2026
 08:44:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update device
 trees
Thread-Topic: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update
 device trees
Thread-Index: AQHdCFZXu2xR3R+bCkeMCGU2ARprDLZXOkcAgAAF34CAARiFQA==
Date: Wed, 1 Jul 2026 08:44:37 +0000
Message-ID:
 <VI0PR04MB12114CB5FBF0A02367B8B968292F62@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <178283343009.3269775.506226017892254973.b4-ty@b4>
 <akPmK--SgmTTAjFw@SMW015318>
In-Reply-To: <akPmK--SgmTTAjFw@SMW015318>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA2PR04MB10411:EE_
x-ms-office365-filtering-correlation-id: 406f1c90-e094-4d3a-0c68-08ded74cfc17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|19092799006|921020|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 U02+WKH+TPepaKwJ3mE5N6ug5CRuROopZy2jWUopVrDtnsh2BnUrjvBPUsWpTXCeNbGTcZ4U0yXDRu4UNcgvmo1AJAC31wpKDIcKUxsWUaTsGbvMZEI32c8mDuMyCwThojtodROhsKN/ic+jiE9LYmUTcEGqfAkt7hBv7dMsykjaF94aL/XIHIeDNz6ndm2iKXpGb9ifYjXmmh3uPF/b38eBPYgXdS277W9RUtskclymraG9kIu7568apliSPW+CdpFHGP4LZffi/6Xz0EolqOg3oS6tXfG6lWxoGaFRXBZSFJza/677k1IA7+MqacZcxHg2m7zaSMohDaJwaFo2XiSJKvD13NJYlaBWmz5oWRUnCVAD9vGoOlKuoC0lZeD7adjNWT+GW16rKr7ZZagljqPRssKpFB9weBYq5NmIZqALkF3NVchxjQXs7iuugR+YjNseh2NAnIaLxTLBdzWxnFMLL5XBrn5HJoBqRUxDQbavQiBEQ9iy7PXfhtMLTWhQ93omlOVHQ8aAQRr6oWpgWYmzqh0zozR19rURJuVpzoaPg6AIN+TXMVifx2SzOlXE8TiOEKMTCKOedOfJjIvizHX7hiiC/CteZ9va4LwhSeNQPPS0yNSlX8gPaBeKKTHS/oEup/itGJRXAi5bJz9IoZI9fr0jqFwydALFrV1TBkAXChIWXaXvl9iWQI+Xc+wMesy/BualQJGHo16+rXhTOr+dAcOF0CQOJF3l1lTYQGsiTWQtBQLJhS4eiJIQ4dds
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(19092799006)(921020)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V0rDG8JysVNFysp2Ju3u6v+HVAwvsL4VtuiVNUjMT3ICqr+L2t1F9F7l1SnU?=
 =?us-ascii?Q?DhD/Kt8vk4+8wI2Mt9gT8zytrZJzQXKhujF5NwOYT0oeOESG3k1ljyrbP164?=
 =?us-ascii?Q?fGrKAyCNoPmBv9Xu5k1dipD7h+eUax7SxfgjzeENnqURbes3wz/REASHPZ77?=
 =?us-ascii?Q?28+xwOGaMDmEEMjdhLeoUGn3W7chIEduGxeWLXNvNbOb3URA+P8L+V3t1hq6?=
 =?us-ascii?Q?4eZw+J083x9RGehpV3h/vfLi89Mo8tsLnxRb66grlZBPL42qW0ubIUm5Rvts?=
 =?us-ascii?Q?RV+B3BT1k2C/2YlNoCDt/1n/pIBYtkcCwVsJv+5A0mGO0mdPg0MvdC81+o3F?=
 =?us-ascii?Q?UYob0ngSaMJ66wwXtMnHqN+3idaqkxDLzdr9IMRrDYWCysNcGj2yDXuRz9o8?=
 =?us-ascii?Q?5vKrgZ/82II2kQkhOSXOJj/oaZL61qH7FzItOAO3tsgHfSEGw7m4AEMhRy7P?=
 =?us-ascii?Q?T7aWcLgeMzxQy+4upHRdlwYVFycqwdZGYjaeeMQDJkUE53MYFE0zWS5wKz4p?=
 =?us-ascii?Q?iHZDDcsWKzUNL6j15+hWd4A+dM6QDfrhiXF0GYmWqweky97DwNHZ0P1yeyiE?=
 =?us-ascii?Q?cnUHpyoSEwPbgN/lzKyYU1FFq5rnZVH3ivWbXfsq9efbB6kQ/jNxs0RbiFmE?=
 =?us-ascii?Q?3BkqOxNh7HOrzq0nC/hcIhi0ox5uDpJThd4rYbpvF+lwkYXI3guPpQYdRFNE?=
 =?us-ascii?Q?vV6hmtW9MVhMJm8wWEXiGP0eTzv4/IZAjT1SmfD6dp/CHTy9/4hRvT/KHbC7?=
 =?us-ascii?Q?sMLnvfpB0LXoCrtlFRcuAs7DmA4EdeqJCE3UGG8C5yTqehAMSNaJY6w+Gsrl?=
 =?us-ascii?Q?Y5aIgbta6ZTk0h5zUJZ7UVoZYt3eHfmiFrXu838ng6VLI/bDO77Pm26Y2Rpu?=
 =?us-ascii?Q?5UxsNG7Aw2aeQKvN0LA/Nz5Zs628ZIVnf4w0fkBmLfHSzNK+b2A/Iq3/daPa?=
 =?us-ascii?Q?VEtF12uFKvTbd87zpAmPI0ENL3zGVTvb34iDbElwHojYbd7TAGr2+JKL7Y3q?=
 =?us-ascii?Q?odoSYvF8TbSIviGY2Mw6clVUFBiJ9KSnCU4S13tt7KM8jlq7v/tIPgM24PUx?=
 =?us-ascii?Q?J56ZK/mLN9hyyas5QljFu8TRL5URT4e8yZa/d1AyTNWj4YC9AumDZSyLM8jG?=
 =?us-ascii?Q?GdwBSSXh5WhlCNSi6ccF99zwGkKx+x7p4qPdyZWVaOT6dT1erENqAIYGDdpa?=
 =?us-ascii?Q?6VbdgHzAVl9OL16UJSqxudxOR4eX6rCm0dR1JJN38Kxoahx12Be5QL24kW6R?=
 =?us-ascii?Q?m3NHAZBa7sfPGahFvoYhkqt4OFE8Um2T8cQZtl1r1eZxPVY71zPZsx9NoVj0?=
 =?us-ascii?Q?1EM8Dt1X1RrWuHLAXeTMiUt8bPurfy6vGsIeEiT+Z0ZbGM9XZ+PiPobKShsR?=
 =?us-ascii?Q?NJGEvxDWjTEkJjOe0l2iOTWJqeh516wOahhUkyYW6zQB2NfMFyKu09BptojP?=
 =?us-ascii?Q?41r7hGHYmCa1Fgfd1y+wIaWHg6gFRIsFTD4EwIjzFH5Eg610YOiGFA1Hvhnr?=
 =?us-ascii?Q?NI+mfjAOiIw81cHboUQ0iMlQ4c1TxIzS6bIwujeK/kbl3MaUBczal3YD2ECf?=
 =?us-ascii?Q?der0Ge1mQxx5SeBBLffbvTi9QSIYGxkURGhrjnB/cOI4/GxDIM0K8FTkLlY/?=
 =?us-ascii?Q?qrYhxD2tSlErLT/8DgO9Lksi0j38TYEFeOGbN4kP8rlHv5g6kssowpsygcgZ?=
 =?us-ascii?Q?iqBP/R7i4wT9w1YEST0/v61dn5RmPCCxWIaMRSZMD9TPPn7U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f1c90-e094-4d3a-0c68-08ded74cfc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 08:44:37.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya1jXJytaHidZgg80RadBIKgV9kCx3R4aS8f39X2oUNayOKssnKLiRqBTdAr1PhOI4ZzY7v2zqKP+ykOzD7zTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10411

> Subject: Re: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update d=
evice
> trees
>=20
> On Tue, Jun 30, 2026 at 11:31:10AM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> >
> > On Tue, 30 Jun 2026 14:07:03 +0800, Sherry Sun (OSS) wrote:
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > >
> > > This series integrates the PCI pwrctrl framework into the pci-imx6
> > > driver and updates i.MX EVK board device trees to support it.
> > >
> > > Patches 2-8 update device trees for i.MX EVK boards which maintained
> > > by NXP to move power supply properties from the PCIe controller node
> > > to the Root Port child node, which is required for pwrctrl framework.
> > > Affected boards:
> > > - i.MX6Q/DL SABRESD
> > > - i.MX6SX SDB
> > > - i.MX8MM EVK
> > > - i.MX8MP EVK
> > > - i.MX8MQ EVK
> > > - i.MX8DXL/QM/QXP EVK
> > > - i.MX95 15x15/19x19 EVK
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/7] arm: dts: imx6qdl-sabresd: Move power supply property to Root Por=
t
> node
> >       commit: b16fded592305f04ae40764f5fa91d5ac6f02a65
> > [2/7] arm: dts: imx6sx-sdb: Move power supply property to Root Port nod=
e
> >       commit: a1af6cf5a6ce526ea41d4686fa14580a48b2e768
> > [3/7] arm64: dts: imx8mm-evk: Move power supply property to Root Port
> node
> >       commit: b6a38d70bcbf0893ce5493f3daf0cb19e5102269
> > [4/7] arm64: dts: imx8mp-evk: Move power supply properties to Root Port
> node
> >       commit: fde093c386a64c820a704abaab9ffd9ec738cd4d
> > [5/7] arm64: dts: imx8mq-evk: Move power supply properties to Root Port
> node
> >       commit: 78610987333b0811a456f9a4782472fad00f4a19
> > [6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root
> Port node
> >       commit: 240950f3ad76761066ffe399f62670321c1be1f1
> > [7/7] arm64: dts: imx95: Move power supply properties to Root Port node
> >       commit: 6e53e8b854bc6f8330d07905b73e53ad02aff62b
>=20
> Sorry, I have to drop again because miss consider back compatible problem=
.
>=20
> All old platform, 1 - 6, need keep both under pcie and root port.
>=20
> iMX95, you can move under root becasue it is new platform, it should be f=
ine
> to break compatible since development phase.
>=20

Hi Frank,
Ok. Will keep the old vpcie-supply and vpcie3v3aux-supply in the parent PCI=
e
controller node for patch 1-6.

Best Regards
Sherry
