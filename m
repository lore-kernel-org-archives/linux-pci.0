Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697078;
	b=pTQAP1GYbGZVsC9f5hs4n1FIEdW8SLmqSKba1iBivzYs8mSgEPO6Dud3sWwAz+JC234c
	 FI6R9n77NVDRkMckNPRUc+TVtfK7rpz89pHzSJH11Hr41m9ng5NE9PyP0To9NFkiyMKy1
	 ZWkyihqUCODNrr/wFFkB9DGavWSJCWpPhkB1IbeY6fde49320H3WqwXYPLptW0e7tjkyx
	 T6ucpOoHi++noraucxCpsgUr2jMD0GkQnwCZUD4ujfkzoenKTwCNSyQbMHX7kLKX9d4mV
	 rc9pPaegJ+07XF9OgtUFhPr06ZuYfSVXR9ifNk14jomj7FCGtD42xXFeCYwYx610OJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697078;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xAfmDLBH8j439OUr7bMn6jW5npXg6RTBQZiUDvnUfBc=;
	b=jwETCqBMV1lT0X3XbkASrCBDERnRjBuaP+0ZuWUASBWGs1qb80luJHWJ+KwFUHiFH+lH
	 n//EWfUy0iUawWtSwrEMYwJep1DkB/iWN6QAJ9CC53046DNX8kK05Jc+Z7YfyPoUaT5yd
	 HBYVRMFwO+puWZ7s2dhPNXslXB+ADbviKu7ujb14CBdnwSaZg6BmqCtzOMwt3quli53Pu
	 3zANT02qcOcXmnxJIuVII38ekkmWNbop+DYLZZTtPYEpSz1j/rNWakW3TNhUYZ8ycZvXZ
	 jEeH9IqvG8APxzXxkRdco7DxszA5esfEuo6rLIrRcF/tdaA4TsoDYFmo9bFlRjuDs1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FALrbfaQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.47
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAE606A324;
	Tue,  3 Nov 2026 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EAE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FALrbfaQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uixUyt1JbLoqEjVMzZTgCnl8E6Oec2UJYEYV706ZXRuiOKXLLhDLLp0jF4HsgY568ed6jPv78YdmpHZoc/We20+cCYWoqEJarjcUlbtOhJFVDwOcUob0Aey66h+cpRPCXbXLnlwfS8e9n8SQLsTMNrsyqF65SHp8Unypn64T1vOaNfy/wrt2HldKo3IPWLlgPkvGfamrozSVC1C4Wk3SFSKEPgJSquKi7v5yYSye5f7VJIWIsp53AOmOo27VbkoWDvtyGmO3MGs7fAAAIr8Ecj2VhpVR4sdppbYAO53uzrS+mLcyHtMZA1swOFpQ/zDikIyutX8+/R3lI2ox3K237g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAfmDLBH8j439OUr7bMn6jW5npXg6RTBQZiUDvnUfBc=;
 b=rmIwV5cw1iuj3UxteqxplLq9pBJlwha9knDq/ce6g2cdv6PEEavt2T8LGg+x0kttvX2wd5eZ+KfBIOgX4g1q5kYqZtinqZSjgg4DPiC2UfavO/0XLWubxpbsFFkbg/9fD1Pa9firjRi6uXf8Sf1RW8gFNf6oLshoKCWRHUjNci1YZLiso7506ZwPDbaKkfpmJuQBsj13JA521zPhjollsWhQlsNVMIM9ts2fIRwkbNmGz+upxhi5zstrTxaMQU515JZ/QNl/5EG+Bx0fVW1T9gMnFXeDJssItQk+onaxJ98KhV0LfnUZZ1Z7YtLdaiogNumYaIlobYRRduJHxxLa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAfmDLBH8j439OUr7bMn6jW5npXg6RTBQZiUDvnUfBc=;
 b=FALrbfaQiklxxNb8MiFZJzHduVZvXgRxHunA1kD+ZrRKG1gGgradFQGdOekdDH4CQnDQE9Rkc7wZ1Nk/vIGYB6iTHVAHeOeN1SPut1H1Pybz9ZJ/e8U6Bv9xQI7BG4vbCyxn9cQrsD0ssAmmhlzSpES8q5Xb+5IG6HfnMGgDBObey+76OhjfZvD7d9OzcKonUJvn0an7HOYZOsiZoT+DNfDMwsYzz7r4yS0QQkySPvGkn42VRJbLp5AGVqKDFgQTSyEDY9RXrxMBnHsgiUiERdqYBXgojFQjBJhqDfTaSTdiPr/DVtoqWpi6uBnjW9AQwMJY2w1QQJJOyMg2Fs6bTw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by VI0PR04MB10686.eurprd04.prod.outlook.com
 (2603:10a6:800:25d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:11:11 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 09:11:11 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Topic: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Index: AQHdXUZ3qz9gSfJEH0yvrNimvCsV2rccGbLA
Date: Tue, 3 Nov 2026 09:11:11 +0000
Message-ID:
 <GV2PR04MB1174015C406D353895C57476696692@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: =?utf-8?q?=3Cd7b51cb29758538a4c68a700dd8cd41b6e7e08b6=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
 <179213850452.434549.17833070545168867976@kernel.org>
In-Reply-To: <179213850452.434549.17833070545168867976@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|VI0PR04MB10686:EE_
x-ms-office365-filtering-correlation-id: 07d57d3f-c4a7-431b-cee3-08df398a678b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|38070700021|56012099006|11063799006|5023799004|261021121427099003|261102123227099003|261028144727099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info:
 GYMMAkDFMWBiXxgtCN4bIUIUvMfugrlU4baC3FgP8qXfk99YQxamdJzJ+XzzT3g04UtG/O1WROCQJKc3X3MNnYeVk86sr/LYSVkUAO69PoxKjB8HASAMQRfL97pA04BNcnVq4Ok7Z+ZD3RHQSCGQNbVdt3op49LKQiv+hf4Je9MgCV9OZmzrh01bUUHBbWHJGKZD2AsCphDxIdMi7SOvQ/vteVXF4n5FGvh9At+TEEJ7T/AHMtpcFfnmpjXhCBXNS7NhOa6mTjHh/V9BL0P+yEi+wSDpZ2tQDI55B3qUHzeR7XfqrAEuFLfjhvnLp4aNBleEsCxtSWVYJkI2WGc984TEI72/rbD0It5FqULhY+Uf2voAHLyKvXFcvNXPoR84occp7vVr+rkx95Saay7d5ABOF+76z27EXQqrqQrApkrbcpC4tg3Dsu9UIyXfFU5OsDP+VTmLlPkfxaekNy3IW5XnRRnnT/SwTpRsX3gWsRW5E/iepNP/ZipWy6oCXD9epNaJd/+jMyvu42u+XLTRDvU+9OM4esDGs3F+WRrnqnFrdAWMxoRqkFFFFCBb4aWjj7NhdV+2wAQfWLOqil/oKEvdjnaimHPwRu3TPCFL7BXRSTuUwRfVMffFrm0MUzeFcOHTRmBJvJ58gFWisZVshDdbyryaoMto1gEqzlx/0FgbWUJ6fWLqN/I0ueXmHjZgMfOd/ia03hf9wyh4vAz+0DPs0H2wkTmvo3xV4nA/B88=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(56012099006)(11063799006)(5023799004)(261021121427099003)(261102123227099003)(261028144727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JwzIQKiQU4WFjdXHi6dy6f0mIgDPcngKgHVZmWdH83WTZB/jT+VKuvzSuGIu?=
 =?us-ascii?Q?etxlsdO1QdDaXsgwY7KwwArUEJRU6/1qJRSrymxXo6mihk/vMIM9SSYIF+sa?=
 =?us-ascii?Q?Pwmo3mDOCDFwsUS0BVK+baoeaD4jRD+lfMlVYga0M7aS/E043AOd6BkJFqRa?=
 =?us-ascii?Q?szigg7Oo2/GZNK+sRl3V5aXU1RxyRM6mLrNeat1bjaJYhpp8NdddXoRXpOV2?=
 =?us-ascii?Q?aULnTFw7JqIX+ci3BBfBMmp67sHWBgebdsmDOnyrs6UuuDTXovhzdnMK+i7j?=
 =?us-ascii?Q?VItkZlWAlrnSQr45UpkvRxvbf89dm/PABWvf8I4ryKtYB5YHRcmKgmXWQtfP?=
 =?us-ascii?Q?HYUJu9kH4okxOSDx190PKmwLSF4GteMGWGPIbrZUVfxscIokj8E7nyaQeFbw?=
 =?us-ascii?Q?qFdla73E876pqOdH11z9XvIcR9d8exHOzCV6BhVESgJ4pCWICEAVdztLEyXN?=
 =?us-ascii?Q?xSNy5vv7c9MC9RGeDenMe3bQFV+waitKM7CruylxQhu/hwva3Z7zKXJS8Fmy?=
 =?us-ascii?Q?mezJnCFR1i0wSeoiBjmYFj8xyLZ37aPw3aThk+TFcy3eDCb36FbjEAeEkxyf?=
 =?us-ascii?Q?fhYi0SScY6DDrR2LzCAYtV+8W8OdItJ6f2phFzhA8rdaRHhjy/aFFz4B27ll?=
 =?us-ascii?Q?ga5KIr2PLj07oIAezo4Rvfvkm9HPY7bO31Kt7ASp6tvZH5pYkRFg40+dcUSS?=
 =?us-ascii?Q?6Z2KsEYUsJziXab21a7hJ+bUtaC+3NstDdJlkFfb1rYVrN7e84E/ScJg1rAv?=
 =?us-ascii?Q?aRxWcwH6WowjoToBFAtS5FSpCzcef89Go+bFwAwNOe3wKeCPO6nq86EaPmo6?=
 =?us-ascii?Q?0421M5ImX9spKbz7TAKQnHPSkqcMonq19cDHaDT4wrJDBOJJN6j1/GqKhB3B?=
 =?us-ascii?Q?8Cvgm97tI0PvCofWhYbO/2bTKOzbRgM01eMVzUekSTBHJdQ0tuDyDJSSDPdY?=
 =?us-ascii?Q?wCfdnupxZeOK7hdF/ERhKMhGetb1nOMPIYyHqujoXhvES6pUVSoQZpmQ4ZdD?=
 =?us-ascii?Q?9VNFWFYVJvZHKbqFKZrnFTDltzmM0bYbQP6ZGIyOp4O892V9M6cHNlLlV4A3?=
 =?us-ascii?Q?bsfxyXqr8QxkpgxUjs8//uBaple413/ZCqWg+SlHh6uPwpGjf+xmm6mkmgKC?=
 =?us-ascii?Q?YTSuZNPq5YIXPU/uMfyX4Ndbk5yyV8r0uAE57nGrz4IwfkU9NA79/C4oN7Zg?=
 =?us-ascii?Q?gVNu5WPQfEVu+auuTy/LBoYCw+H4uAeinbepKGGtuiOp1aFtppQFQcbypAul?=
 =?us-ascii?Q?e04lPzVFfRSNennERx+yW/5/IN9HK98xKjHLE3Bmrny4erUrV8EcJ6YBT15Q?=
 =?us-ascii?Q?egeY38fULKV3Bb7tKVAwHqabiO4CS1qouuUIVMRA3hycgYAUIYT6/njXsuT0?=
 =?us-ascii?Q?1CsU9X3+Jjp2nR+0WLT0sH9VEl+fOImAURfbUnILdfPnoNCVO2uQ367tsEY+?=
 =?us-ascii?Q?DV6+GVBvA8I4CO5G42KeteWjQqmkdTt8QY2iE5k3ClrQyPUNmbw5FE/7wW/z?=
 =?us-ascii?Q?qcdLsleJCdH6l18I4ltJDFh25EzhFLZ0Qr/zxqr/ph6r8ui1xcj3d69lahMW?=
 =?us-ascii?Q?LOphOG8gx+bLXF9/Un1tWoDSJ+dESfzPbIrldfrlN/2dp7Q00KG6pjqalENd?=
 =?us-ascii?Q?lVNgFgqENO5XPcwL6Xt4ctVAwW2ZQvttWQv8G5G/PbJbE7gG/8V52PhI9yle?=
 =?us-ascii?Q?1Qnqhn8/+dQaJngRn3B0fiSD/uzRpKLbcmw3jm2XlRr4Lu6L4ZUbaZp0QrYq?=
 =?us-ascii?Q?lD2sLr94+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d57d3f-c4a7-431b-cee3-08df398a678b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 09:11:11.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xsKxnroc+JnBJG99/Z8dfFxOjPVSjKX0fioZeweGpBVJzOXdEEvQPviRdHZqx+OIlOehMD+gSN989gbMuAwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10686

-----Original Message-----
From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
> Sent: Friday, October 16, 2026 11:15 AM
[...]
> Subject: Re: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support f=
or
> ENETCv4 Ports via a fixed-link node
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 3 * Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] Build break when CONFIG_OF_DYNAMIC=3Dn.
> - [Medium] enetc4_link_init() uses the OF_DYNAMIC flag alone to decide
>   that a pseudo-MAC port's node is 'an empty node created by the PCI...
> - [Medium] The pseudo-MAC fixed-link speed is the boot-time PCR[PSPEED]
>   rounded down to a phylink-supported value, and the existing link-up...
> - [Low] enetc4_add_ppm_fixed_link() can write 20000 or 25000 into the
>   synthesized node's fixed-link 'speed' property.
>=20
> --
>=20
> net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link nod=
e
>=20
> This commit lets ENETCv4 pseudo-MAC ports probe when they have no static
> DT description. At probe time it uses an of_changeset to add a
> fixed-link child node to the port's OF node, with the speed taken from
> PCR[PSPEED], so that phylink can pick it up. The changeset is reverted
> and destroyed on teardown and on the probe error path.
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index 71c971618388b..70e34ca6ddf8e 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>=20
> [ ... ]
>=20
> > @@ -946,23 +955,112 @@ static void enetc4_pci_remove(void *data)
>=20
> [ ... ]
>=20
> > +static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
> > +{
[...]
> > +	enetc4_get_pcr_speed(&priv->si->hw, &speed);
> > +	speed =3D enetc_phylink_match_pseudo_mac_speed(speed);
>=20
> [Severity: Medium]
> Does this rounding end up overwriting the boot-time PCR[PSPEED] value?
>=20
> enetc4_get_pcr_speed() decodes PSPEED as (pspeed + 1) * 10, so the
> result can be any multiple of 10 Mbps.
> enetc_phylink_match_pseudo_mac_speed()
> then rounds down to the first table entry that is <=3D that value, with n=
o
> warning. For example, 4000 becomes 2500 and 40000 becomes 25000.
>=20
> The rounded value goes into the fixed-link "speed" property. On link-up,
> phylink passes it to enetc4_pl_mac_link_up(), which has no pseudo-MAC
> check:
>=20
> enetc4_pl_mac_link_up()
>     enetc4_set_port_speed(priv, speed);
>=20
> priv->speed starts at 0, so the first call always does a read-modify-writ=
e
> of ENETC4_PCR with PCR_PSPEED_VAL(rounded speed).
>=20
> Suppose the switch owner programmed a PSPEED that is not in the table.
> Wouldn't the driver replace it with a lower rate? priv->speed is used by
> enetc_qos.c for the CBS port_transmit_rate. Wouldn't it also stop
> matching the real internal link?

No. First, the CBS use case does not apply to the ENETC v4 Pseudo-MAC case
(enetc_setup_tc_cbs is currently called for ENETC v1 only). Secondly,
priv->speed was always and remains a standard speed.

>=20
> This seems to conflict with the commit message statement that "the fixed
> link reflects the actual boot-time configuration". I could not confirm
> whether firmware actually programs rates outside the table.

This works as intended. The goal is to have a supported standard speed
pre-programmed into PCR[PSPEED] at probe time. If that's not the case,
for some reason, the PSPEED value will be rounded down to the closest
standard value, as observed by the bot. PCR[PSPEED] can be safely written
at runtime, before traffic. Maybe I can enhance the commit message a bit
to avoid this confusion.

>=20
> > +
> > +	ocs =3D kzalloc_obj(*ocs);
> > +	if (!ocs)
> > +		return -ENOMEM;
> > +
> > +	of_changeset_init(ocs);
>=20
> [Severity: Medium]
> Will this build when CONFIG_OF_DYNAMIC is not set?
>=20
> This function calls of_changeset_init(), of_changeset_create_node(),
> of_changeset_add_prop_u32(), of_changeset_add_prop_bool() and
> of_changeset_apply(). enetc4_put_ppm_fixed_link() also calls
> of_changeset_revert() and of_changeset_destroy(). All of these are
> declared in include/linux/of.h only under #ifdef CONFIG_OF_DYNAMIC.
>=20
> The #else branch only has stubs for the of_reconfig_* helpers.
> drivers/of/dynamic.c is also only built with OF_DYNAMIC=3Dy.
>=20
> config NXP_ENETC4 only depends on PTP_1588_CLOCK_OPTIONAL and
> PCI_MSI.
> OF_DYNAMIC is a hidden symbol that is only enabled when something
> selects it (OF_OVERLAY, PCI_DYNAMIC_OF_NODES, ...).
>=20
> With NXP_ENETC4=3Dy/m and OF_DYNAMIC=3Dn, wouldn't the build fail? I'd
> expect implicit declaration errors first, then undefined symbols at
> modpost or link time. That includes CONFIG_OF=3Dn builds through
> COMPILE_TEST.
>=20
> The commit message says:
>=20
>   This is intentionally not a hard Kconfig dependency, since the ENETC4
>   driver also serves regular ports described by static DT; when
>   PCI_DYNAMIC_OF_NODES is absent the PCI function has no of_node and the
>   pseudo-MAC probe path fails gracefully with a clear -ENODEV error.
>=20
> If nothing selects OF_DYNAMIC, the driver would not build at all, so it
> never gets to the -ENODEV path. Should NXP_ENETC4 select or depend on
> OF_DYNAMIC, or should these calls be guarded?

Will add this config dependency to the driver, as I already commented on th=
e
built error (found by the build bot) caused by this.

>=20
> > +
> > +	fixed_link =3D of_changeset_create_node(ocs, np, "fixed-link");
> > +	if (!fixed_link) {
> > +		err =3D -ENOMEM;
> > +		goto err_destroy;
> > +	}
> > +
> > +	err =3D of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
>=20
> [Severity: Low]
> This isn't a functional bug, but can this write a speed that the
> fixed-link binding doesn't allow?
>=20
> enetc_phylink_pseudo_mac_caps[] includes SPEED_25000 and SPEED_20000.
> For
> PSPEED >=3D 20 Gbps, enetc_phylink_match_pseudo_mac_speed() returns
> 20000
> or 25000.
>=20
> For the object form of fixed-link, the "speed" property in
> Documentation/devicetree/bindings/net/ethernet-controller.yaml only
> allows:
>=20
>   enum: [10, 100, 1000, 2500, 5000, 10000]
>=20
> The commit message says the node is added "exactly as if it had come
> from static DT". A static DT describing this port the same way would
> fail dtschema validation. phylink_parse_fixedlink() accepts these speeds
> at runtime, so nothing breaks.
>=20
> Should the binding be extended to 20000 and 25000, or should the driver
> avoid emitting them?
>=20

Ignoring this, this is not the first driver using higher ethernet speeds.

> [ ... ]
>=20
> >  static int enetc4_link_init(struct enetc_ndev_priv *priv,
> >  			    struct device_node *node)
> >  {
> > +	bool dynamic =3D node && of_node_check_flag(node, OF_DYNAMIC);
> >  	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> >  	struct device *dev =3D priv->dev;
> >  	int err;
> >
> > -	err =3D of_get_phy_mode(node, &pf->if_mode);
> > -	if (err) {
> > -		dev_err(dev, "Failed to get PHY mode\n");
> > -		return err;
> > +	/* Pseudo-MAC ENETCs are described by a runtime-synthesized fixed- li=
nk
> > +	 * node rather than static DT. This covers both a missing OF node and=
 a
> > +	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
> > +	 * by the PCI core and thus carries no fixed-link description.
> > +	 */
> > +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
> > +		pf->if_mode =3D PHY_INTERFACE_MODE_INTERNAL;
>=20
> [Severity: Medium]
> Can OF_DYNAMIC be relied on to mean the node has no link description?
>=20
> OF_DYNAMIC only records that a node was allocated at runtime.
> __of_node_dup() sets it on every runtime-created node. That includes
> nodes created by the overlay engine (add_changeset_node()-
> >__of_node_dup())
> and PCI-synthesized nodes that a later overlay fills in. The
> PCI-synthesized node is not empty either, since it has compatible and
> reg.
>=20
> Take an OF_DYNAMIC pseudo-MAC node that already has phy-mode and a
> fixed-link child. This path skips of_get_phy_mode() and forces
> PHY_INTERFACE_MODE_INTERNAL. enetc4_add_ppm_fixed_link() then adds
> a second child named "fixed-link" without checking for an existing one.
>=20
> __of_attach_node() inserts the new node at the head of the parent's
> child list:
>=20
> 	np->sibling =3D np->parent->child;
> 	np->parent->child =3D np;
>=20
> So phylink_parse_fixedlink()->fwnode_get_named_child_node(fwnode,
> "fixed-link") would find the synthesized node first. Wouldn't the
> overlay's speed, pause, asym-pause and link-gpios be silently ignored?
> The tree would also end up with two sibling nodes of the same name.
>=20
> Before this patch, such a node went through of_get_phy_mode() and its
> own fixed-link was used. Would a check based on the node's contents (no
> phy-mode, no phy-handle, and !of_phy_is_fixed_link()) match the intent
> in the comment better than the flag?
>=20
> I couldn't find in-tree code that applies such an overlay to an ENETC
> node today, so this may be theoretical for now.
>=20

This is theoretical indeed, the Pseudo-MAC ports will not have overlays
on top. It's either static DT node, or a clean PCI-synthetized node.
Any other configuration for Pseudo-MAC node (like the one implied
above) is not valid.

pw-bot: cr
