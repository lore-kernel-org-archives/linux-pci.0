Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699563;
	b=IJOuWkZ2dzsWSfC6CbFdp/x/4jBaqVkhsdTue1sMWol/oSy6syq+qt5/y06gZ3Midkcz
	 BQcMK3mKBtKbCOIoDwCXh6JsXHNWZyPSVjayxuDTu5xuODZS9tAvzv/EC+XgUn13zscS7
	 7G/eVw6iAnPQN1ivDzb2lovszehcXZR2RaukeAKC0S17YA4Z0RzfTt4h6y6G7HkQGjpHw
	 a1bUrRrtKcSooRA3N8TUWycprcxXL61slyyL2KXKS8X0b1Ev398VpnO8shVaLukqFaQZi
	 o2bxjLa7NpEcZMuwYMOk6N3vejdBs+FSHASAWVhJ/+917zYt5viO6UkwOfuUyQBPLbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699563;
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
	bh=elKybpXVzP5vTQMNyZY+WusUqOOkSqRMPovdMHdtn0s=;
	b=HdukBVAQNUV28bLrKyr6cyINe5NsLFVN6PqCGaj/c2pGT4dogP+msBhc8jx6sEoJxxE2
	 CjBiDH+qIDMknDnN2CoNX96TVKmfUdjfuSWQsfNgZGktwkm9J5d+S3YOFCJhnulqgr6zL
	 ay7mLOqXQ0+UTeI/yzNk1KXy7COdM/EW65Iufj9f0n3ceaQRlI9y2mHqXiyIkmhilLYhV
	 ZbmSzd0BrH4wmQaJ8pu/9ksOWeBzMua7n+i77RKsseyXagZMn5F3BegC80saOqiKa9tSV
	 PAgptqvsjoOaziDjs35xwyOL5SyMEEhzss1W0t89fIejbSgOhzwnqS92OX/jE8ENiGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b="S+KKMgc/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.45
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD72606A332;
	Tue,  3 Nov 2026 09:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD72606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=S+KKMgc/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqlUmn7diU8E11V3L9MzAk2dDel/F2oXJkOgUVSdHsKk+wK/WxM6oVdsSTMxDmyDo+YQWkgf1TqouZvIJ/M2f5rDaimso/8GhJmskqMcZiK/aia6Vxcs1EiD8GBqxbamaPIaydEIpPx3eaVGU/ISRZWYncV54B0qESvJtrLenETU9VtzXVJAs+zZDTnso67RSLQIB0JQdZ0qIt8Y2f8DjyLYiJmzNdsgNZXhlDF2LQYGfZ1tl4xRMFj2iajf5qCgIrytaFT5yKgqqfgJwsTwDspjaY9XPK1mhp3rFMWmn7njH4czjPEnTtCYYlXvyzFJJ5sBSZEUQtbbDFY0PFo2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elKybpXVzP5vTQMNyZY+WusUqOOkSqRMPovdMHdtn0s=;
 b=QPa791qKN06Hhi2dP/jC0bc+9Mko5kUc+E+DzyuXNBvmP/zxC06ibRPQhvcMjt6vw80iqjs7K0ZN2y7HyG1w8+bLA8SVQrMwl8mgpksILovczRm1jS3CLlgGbMQY9hCvuCUYQ4nvjGTAam4rpWCovHKtQQgQUVL5pV5/+XvnCgbmOCqVjR/QKAGhSvA5EU0kWA9upmcyZJGOQSj9f0TZzY9mUwNoEzODu51remgX0bCpCOkq2P5XH0p1psZwR9yuzynjmRNhvOA3qderw1yHMY6+8YTPJnU/8c3hKS/FPEoS4s3ZrweIBCh6Mr+eMT7Bu4Y7Kcz5WuQnYMf9/EfqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elKybpXVzP5vTQMNyZY+WusUqOOkSqRMPovdMHdtn0s=;
 b=S+KKMgc/vAp3p3WqmXritUwsEs2OUE20YC3frtkG1UUwvrJoXA9H+TYFq/5zzZQIkSCsJIaj/VCa82iTwSeTV+kl/qB9dn0pX4QicV8dHWwRaRBrQ/y56LrVXUK/anO9dfnGCUBQ6OmRP1qmAEGMHGfEOuZLRA3DTwIr8hwM/cMAUvr/OXjj/YH9AAO0ci7MS+i8eK4TUqBjjXGYp5JVaXnFd/Hy8emgLmCWM+J8eEat43jj9zBYAh7JqJ4T3JUkyWi41w10SfPvTHuneJ/QxV7xIa45OYAdIMEEorXa3hrqJ5qVdDSI5ByIqla71ZacmTx6m7DfhRz2cyt2tyCxCw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AMBPR04MB426921.eurprd04.prod.outlook.com
 (2603:10a6:20b:7df::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 09:52:39 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 09:52:39 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v2 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v2 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdXUZ31t76JkugyE68JTn8WXfc+LccM+4Q
Date: Tue, 3 Nov 2026 09:52:38 +0000
Message-ID:
 <GV2PR04MB1174095A46849BE79F5A303E596692@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: =?utf-8?q?=3C537a977b10b3d76c30b1f879f423bde4fd6f42f8=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
 <179213850547.434549.3270982004598435479@kernel.org>
In-Reply-To: <179213850547.434549.3270982004598435479@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AMBPR04MB426921:EE_
x-ms-office365-filtering-correlation-id: 00d761aa-f227-4744-01ef-08df39903230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|38070700021|56012099006|11063799006|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003;
x-microsoft-antispam-message-info:
 Vkg9YnqHShQEdWMCO83oTSY/qJENulkYa2Z9kxT8XCm/qe3Wt7BN7KC9pXjgL6VI9Z/3OcH1d1B4IdwHn9C9MlADd4yy59gtWVWr1oT+D+KAfLEQ8RhoTHyF5Fkm46q7WduklIjKX6mG03bb03KzUq8FfRqBwru+Kzj7dnotudcxrMxeB12jwn+Ron67L+OSXFGT7OmMQQyeSXIzpa6PQA4q1AjoYSlnOMK1fReTOhofIAk7EDkpV0Qvnwtf0DMSdH8BodS6Kuq7d0Ppcq18AqfrvRPD7DJz4qPCFh/aoq3sG8S15Ae+FIGKs5utc3p6r9kcxPbVCFK9EJrJbL81CZ03fvoDoaUe9/m+q9lR+Ne6XGENCrf8MRB9aiilNGhp/O7mVuFKMlYyjN0UQkwzasPcvh4ZQbUrpDMw7r3hdMDfwG0XuDmbWiDNa3+wRhzO0XU368W+vEgTZ5RjPVzl3RxWcHnLswqSqaMyFnI+4cZdS4/mgLgYI9zJ0osubU53DK5EXoWmQUdt9YomqDFa8yeGy/uni/eKF0sWTN3c7Y/109s7AffobhJWSYuwMokNDKJ67XdM/GfbIPfvNX8TKlq4Yz7UzTaM69yygW0162K19AfINam59zZsRRe45uBkYITpcI+g8y6/ffnQNq+zKkIWqhoXRWwtwBTsD0nLjK7UPfjlwz0ul+TiXPHStztFwXLxg8Q7njl3G2nWzuXWZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jgCwpvrV4Wsw9aDcIYxLcjxTs2whp6g7M6CVUhtqAX46AgrO+YqHi1wLl9uW?=
 =?us-ascii?Q?+4KkKsnMYgs9npqJG4b9hgh0niSEiav55W6+HgW3wkF5Ra6S1N+XoOYjRn9x?=
 =?us-ascii?Q?qpDpKF+UGMTMjmy37Ytv+lrNkMpFbEIXcldoKYylikEoZoch3FsyOSRokf9C?=
 =?us-ascii?Q?9tw9rZbJ7QK2agFihr7w60SJ6Ig23dXZ9A3XkR0U/3fRoAKCHIBeFnB5FBci?=
 =?us-ascii?Q?kOsGQI/mjXKdU1fpzXFGNzRxSa8FQdhFSubBQFhnhqWfNgGYkym6sQ3trs/P?=
 =?us-ascii?Q?omTw95Dm3GVgAMP06JlvWy1h3UYTpr/SRLwkj/YnbMzA79yIIje8WiKu6utv?=
 =?us-ascii?Q?rDDSo2eom5w9k0kgLQhHhQbZ3NFTley7Z0DN1wm/80mESTAjcVQierod+JNt?=
 =?us-ascii?Q?pCUVTEtTS6HGHHraMAvRqnVLtTn1Z6nLioBnYWxSjWWphcD87jRJJr4rWoo+?=
 =?us-ascii?Q?S400vfOi+o8mYbKjbvipBxLrxU1M6w1gQLDzFb151q9O9J4N3Bj5NtlFhtnl?=
 =?us-ascii?Q?nCrLYFsg+EyZZdAdRugZoaoXyhGa4rT+rG21X0v8Kfa0Q0db7aSaVIW1dg7q?=
 =?us-ascii?Q?cZDUeZsaw9mLtw9Py2KP2wH+rz+qlbFYC4VeOFwy08wSfMUXY6i2/T8F7pC6?=
 =?us-ascii?Q?3CJX6T+aADOLlrdZK/q/4oEzNAklZcJvJc8oNgtKa97u2o5Z9W3I7omjyjJt?=
 =?us-ascii?Q?FltFg4Ev755Vs4FunCcBVUoYrE777eUwsBVS7uGE7SeXDzJgiA7s4G1RGpgv?=
 =?us-ascii?Q?aADTlBVJpr2GMUJcczYcrbRIlfpkQkXQsb4pDQWxdWBIRkyd6dNg2d1VZNqO?=
 =?us-ascii?Q?uEYMsXEw238CTyO5q5kChHdiV7ER9Ouhpp93ctE+xuUmM8gs9XMJZwdssxi8?=
 =?us-ascii?Q?pdxh1I8Y5WhPZdGqH1cIRJ0JSVYh2/LnzagGpJLFo4S0fQYB5LTM8J4KQid3?=
 =?us-ascii?Q?0Z8a0ewvQCM+4PDSeHh7sMYnXP0h7tuNOvjsBFBjbdj3txqgCWpxeTGv1+Gb?=
 =?us-ascii?Q?RH++vJjWAhKsIwzfygY3Ml9SxRrTKiBg1BqCckFYt9bcPkqJ00U1iCBTX+nS?=
 =?us-ascii?Q?aAouSItIoCiLJp9ERAwJjxOlcN7KOu0gdmi2Hgzjg3jLEfE03x+QPLleJ29z?=
 =?us-ascii?Q?bDL2MTE2cAy+mZakUhz/jqD7smGNvkn+8YDdVaqh9Dedhodqse2kQ1EidySC?=
 =?us-ascii?Q?IRNUvLEqtXBAfsW+09v1FvalwVYpfcFBavcNtBDq6/ldFuk4uWj4Un1dEOKe?=
 =?us-ascii?Q?pPyuZrCzCgPpPMnFLGFpL/kCs8dI07easfuyJcsx49fKTyt5vLKzSVtSsVn6?=
 =?us-ascii?Q?caKD8iFThKsvPIhm8GFk34lsqz1iBhjC99NdSuPKrd7lytw5OAJgDYogo0CT?=
 =?us-ascii?Q?6dJgIByPCnRu9CxGuYeJ+Rm+vcQYn+1cGlmbRL2l4DEtBQnHJNdLGrMZyysg?=
 =?us-ascii?Q?HiPBsWEByEht50PdI/7AoB8a97KxVoa0OcLe4OPMIQKNhQuxYsbSwh2j78Mq?=
 =?us-ascii?Q?ntiVzfU16vzN2GSFxwC30knAvkl8POXv8GcNRRrLSUF4j2KNHAKwfy/EytYJ?=
 =?us-ascii?Q?mNAOJsQQfxQdO40bpekYz6dgwmXU8XtwoiD2dcYe5mr7AnQqAF2bDCIf+bZ0?=
 =?us-ascii?Q?CI0tsW42ZWAGq9C1qjxH87oNjD6Aym1D2y1O4zNz83Nv3OqszDbGp2wa0Yjd?=
 =?us-ascii?Q?bO04u7X31/2AlrMiSdyHoudHnnPSlXdnBx/WUusRzvVKbYmZeY6yhS+DF0qb?=
 =?us-ascii?Q?YBigthEj8g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d761aa-f227-4744-01ef-08df39903230
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 09:52:38.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUIIyk0ltQMMHMPJXCXtYt8IqOb6iTQqJqDHkynRKZGovyv97TMeviQkkgY1xkb4JWkG1nWHLUC0TwQlloYx9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB426921

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Friday, October 16, 2026 11:15 AM
[...]
> Subject: Re: [PATCH net-next v2 2/5] net: enetc: Enable probing of versio=
n 4.4
> devices
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 1 * Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The patch enables ENETC v4.4 (S32N79) by adding ENETC_REV_4_4
>   entries to enetc_info[], including { ENETC_REV_4_4,...
>=20
> --
>=20
> net: enetc: Enable probing of version 4.4 devices
>=20
> This commit adds the ENETC_REV_4_4 revision define. It also adds
> enetc_info[] entries for v4.4 devices, as found on S32N79 SoCs. Both PF
> device IDs (0xe101 and 0xe110) map to enetc4_ppm_data, and the 0xef00
> VF ID maps to enetc4_vf_data.
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index c6571b5cc8425..be7795d4e0c66 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -3862,6 +3862,18 @@ static const struct enetc_platform_info enetc_in=
fo[]
> =3D {
>=20
> [ ... ]
>=20
> > +	{ .revision =3D ENETC_REV_4_4,
> > +	  .dev_id =3D NXP_ENETC_VF_DEV_ID,
> > +	  .data =3D &enetc4_vf_data,
> > +	},
> >  };
>=20
> [Severity: Medium]
> With this entry, v4.4 VFs probe with enetc4_vf_data and get
> enetc_vf_ethtool_ops, which sets .get_ts_info =3D enetc_get_ts_info. Was =
the
> second revision-keyed table in enetc_get_phc_index_by_pdev() in
> enetc_ethtool.c meant to be updated as well? It only knows about the olde=
r
> revisions:
>=20
> drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:enetc_get_phc_index_=
by_
> pdev() {
>     ...
> 	switch (si->revision) {
> 	case ENETC_REV_1_0:
> 		devfn =3D PCI_DEVFN(0, 4);
> 		break;
> 	case ENETC_REV_4_1:
> 		devfn =3D PCI_DEVFN(24, 0);
> 		break;
> 	case ENETC_REV_4_3:
> 		devfn =3D PCI_DEVFN(0, 1);
> 		break;
> 	default:
> 		return -1;
> 	}
>     ...
> }
>=20
> On a v4.4 VF, enetc_vf_get_revision() computes si->revision as
> (pdev->revision << 8) | ip_mn, which gives 0x0404. VFs have no OF node,
> since the PCI fixup in this series only covers 0xe101/0xe110. So
> enetc_get_phc_index() always falls back to the by-pdev lookup:
>=20
> enetc_get_ts_info()
>   enetc_get_phc_index()
>     if (!np) return enetc_get_phc_index_by_pdev(si);
>       default: return -1;
>   goto timestamp_tx_sw;
>=20
> As a result, ethtool -T on a v4.4 VF reports only
> SOF_TIMESTAMPING_TX_SOFTWARE and no PHC, even with
> CONFIG_PTP_NETC_V4_TIMER
> enabled.
>=20
> enetc_hwtstamp_set() is gated only by enetc_ptp_clock_is_enabled():
>=20
> 	if (!enetc_ptp_clock_is_enabled(priv->si))
> 		return -EOPNOTSUPP;
>=20
> So it still enables ENETC_F_TX_TSTAMP / ENETC_F_RX_TSTAMP on the same VF.
> That leaves ethtool and the hwtstamp path disagreeing, and PTP userspace
> has no PHC to pair with the hardware timestamps.
>=20
> When REV_4_1 and REV_4_3 were enabled, each got a timer devfn in this
> switch. Does the S32N79 NETC timer sit on the same PCI bus as the ENETC
> functions?
>=20
> If it does, should a REV_4_4 case with the right devfn be added here? If
> it doesn't, should hardware timestamping be refused for v4.4 VFs, so that
> ndo_hwtstamp_set and get_ts_info report the same thing?
>=20

The VF for v4.4 does not support the existing timestamping scheme anyway.
So, on platforms with NETC v4.4, CONFIG_PTP_NETC_V4_TIMER will not be enabl=
ed
since the v4 timer is a separate device on a different bus that is not owne=
d by Linux,
on v4.4 SoCs. No need to modify ndo_hwtstamp_set() in this case, and it's o=
utside
the scope of this patch set anyway.
