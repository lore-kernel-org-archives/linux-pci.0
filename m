Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795018278;
	b=W6+fg2VA8pPvs/eBXZnLHrglQkZS52ZKNU2wETVTECqvOSMXs55yCUC2DCM5eqaMFCMt
	 sESzgiGzLmHoBHXX5vEiSfxEQZ+ggBQ2wgts+1XvSTpzqfrHu6T2MZHwQvRfSIzLygv0D
	 ntj1m7l2oJ8TF8A0hSypJdQd9aqGNxKa+3PQOYNGGzvuSIiyvVG7RrIi74y4JKV1Q3nqL
	 dyfo2Ull8Lt0NTud8/PwCtXGmblY6NJl2Xy5SY99iWpiJrz+bdLUMWbZojHeextNXqRX5
	 G30SzeRbiTogZh//qHaHjMMcoapJEKkyDRHzGmVPL5Bftp18+KvprY6iJc3CvDNMYGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018278;
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
	bh=rhKlzL4vFco30izA1OTGlug+thO+th9SGboclzQBZK8=;
	b=2a4uVt1eF5603aJDZ/TbYNPuPHEkUm0XgMPXwJC5rFJXv2topZmVzTD8dsLIP3NYCsXl
	 Q3ArHTUrSClXdk2LBzXF/QzDU0kLXzM+A/2ye+omVSmlyZ4cEuUOvonXoR7/KcSakAIp7
	 MNmy4cebGBwG7dXngXr7AN+5xg+Cb8mnG510X7B/WS/qJwM3rU05v43rDMh6Qd0t0IEwT
	 Ts2iNadK20EhPgXTgcexMl0UQJCKg1BBVG7hVQmOcLUYmspYxMq3XVcAjULzYXp85Os+f
	 ZVwPnJaQ1qSULVJfvVAQ/l2NDBxH9u9iRuRY5nwhafnW3EBRHHn9+o9WTbEjhER7V0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MRKATT+T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.17
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264F606A325;
	Wed, 18 Nov 2026 16:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A264F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MRKATT+T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY7/4YmLaX44fgR+fjEycAE11wWttr5f6m9I2arMi5AsZNo4hKyB3TC1tQnefWjqF1WGr2vWQHLxUC8mZhclatJTqiq9oBWsgbOjTmZdyqmiYJUU4gCjGMw06OAbACMTjkgOLFJ0vkWpg0rbuR/OEFcMyThoKPPHpp1JSKXbdJKFVVa8OH9hmJTkLGwN67UsxfqE2ytMewLN3xlOGPaIW0tyu3KuVMgFyXARIgBqKSYyJvdrbdi88JWk3CAPRhYidK5wX9Qm3yjAePrlAxasvT9ylemeKSZYOqlQQ0SSI5ZyID1h7qX33ppwj59aEJkWWaoWPWjY//zMmqttfhN/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhKlzL4vFco30izA1OTGlug+thO+th9SGboclzQBZK8=;
 b=NWMWzjUkooA8Ji+4c4FaCS7wDrRmxco2A9qoXOl/jhixaVIypaAbZvgm6tpzfDmxfrO2+cWShavLvLO2NqoAi6mz9wTSjulJftN4P8I+MO/qpDy/oqoQwWpwdgBf/lOu9yV5Sf0K2I0Md5soi17rJEZGeWmLRxApk3g1U4Mn5OAcC9rSBZwu/oHK7Go8ox/La9hJTDdx0dBCVOp/VWTY+74KO5IRCvTPhcyDZD/602kcqd+9x2T3u5qvWyCV2P+8c4bmiNQz2BIXI98g/iEAPnfW75e2MQ9AD5gJIlhiDWBcDbg7yfd73xJPAUBIG/PqhddBWoMlRXkvj44tOtM0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhKlzL4vFco30izA1OTGlug+thO+th9SGboclzQBZK8=;
 b=MRKATT+TtSkrUhXaxI8aA8+G1f0B/jMuPbjVQc1AqCx5iQ5BmjrJcup2Oz47qK94arzYiowZJCakhKYszPNujHoybipw5+sPLrJWbDMehK9tIH0H1SZbLodf6L84fYEOzsC8+w1WW7DD5Ys4Lv11OICNMcXMn6xiXWwhYHV+YHvRnNYwegphHpakHFO1WBgKmOrP/VVd3kZKRzX5sVPx51r8zzdAYzUXwhRUYz0CAf+5qZABQP2R6QjO6ahXkfWCIoIILOsjaGKLj+Igd/OGFTFnSK+RqSLwJYTvpLsFpGGEt8l0KdigLx9yQ2fYPHEcVx+IWw2iz7SO/vAhMw3DcA==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by MRWPR04MB12146.eurprd04.prod.outlook.com
 (2603:10a6:501:97::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 16:11:14 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:11:14 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v4 1/6] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Topic: [PATCH net-next v4 1/6] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Index: AQHdc4nYhJFH1dmVTk6cQvCCjjel0rcycPeAgAGR4dA=
Date: Wed, 18 Nov 2026 16:11:14 +0000
Message-ID:
 <GV2PR04MB117402979BA16A472F0C0B1A2967A2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References:
 <4f51bfd237fa584c7d9187d7b82f36e261853ea3.1794581338.git.claudiu.manoil@nxp.com>
 <179493090971.3136.9721533094333369940@kernel.org>
In-Reply-To: <179493090971.3136.9721533094333369940@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|MRWPR04MB12146:EE_
x-ms-office365-filtering-correlation-id: d8ac48a2-52da-40ab-bf5a-08df458e91bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|23010399003|261009223027099003|38070700021|10067099003|11063799006|261028144727099003|4143699003|261102123227099003|5023799004|56012099006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 eHNnIiWlkkHW/0Z1jV+jD2KmzqEvLPALS5wQwyRLwx6ko1NuI7RAeZ/7QYQJTKmZDKgXmAhwThjO8zzP7awMZ2LXc6M9sSBPh/HQyO4ALazKy7UkCVamU/KrrAwGZQCkFmkAw1A0W+kh/RPmjjyFPDvslcXtfKq2eDWJ04U+uZ7gO0tSh7srmPfYoXIvq2fkw5IMn4Sm+CPCwxcmts+VJOZMnfwkv8P51l9M0+pssPlaqVRpqmVgO+eugkIEiPNBrVCyMs94fQI4vZcd1VcmPP2Zf5p7J/uQFkloPp5lmDBweYMxYQv4LqQ4jAVPmR4PAsk2KH8jFzYvU0SyHIt0NFeaGoROUCGwHToeM3R7o0keqx/n1UVhNwwXZPDNuXnFm7pgze2UpZb56b34pNoCyLKeZRrc7ChInrRCIELpxYHqvLF7jVeD8hV2y5IzSD85QTINaz7n928Lb+z/E9lmBrA5qPSgtgCVhJ2mQZgxEDkQz9wsiptPx568CJsa6D1jzj/Xi3VhJeokP0P3sdqcJ2B/mG+tqjBU24szbeypEvVUfObZSj3hkysZlmpraPYUf5potFNJOnW2Jq22mH4XBWe4EyEYG06uhI4S2UwiaiUWUgOx2is/bOOIfUrcY54ctP7FnAKtLQGSURmRS5Y23WKwOdjyZ3IG7nuBm+a5jDw9tbYsvLo2ZNYzIYB+mrYS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(261009223027099003)(38070700021)(10067099003)(11063799006)(261028144727099003)(4143699003)(261102123227099003)(5023799004)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ujewZRmkUuzw4uVs8KFEnmBc892ig61iMmQBiO8IEetKkxH9eVwFkb4bsuL?=
 =?us-ascii?Q?fKTXTZF0qYhsjUMPINF1iMHu1OIVGmoZFhTEvowvtcjTiS8cxu+IiqiZNiQ5?=
 =?us-ascii?Q?pn5OQnBGOSeSD9lJkc/6Ripul/FwEY0DSipxvIsXxYYTnk+qBD8uSX5D44ZN?=
 =?us-ascii?Q?msQX8SPivBwGn3691mBQ7esUOIrYpw46TPo7sygcKB+gIesLfsxkqr0k6iVt?=
 =?us-ascii?Q?8sa9vg03SGxYlQxfuKW7eXudZMQNm0gmQAX9WK6IKBYtVlGkxv9IPCpOpFdw?=
 =?us-ascii?Q?j+d8lZVwMF63WlcIFL66+4G1eUlE9Trgnb4A0CzoQqcFngFebWLWPiLY8Chg?=
 =?us-ascii?Q?aV25XNF8n35Z9L/5HGD8D3VPfrftpc9AjrcrYSGTFp7OXeQ6c3XI+KmpHcZo?=
 =?us-ascii?Q?gD10m4ef+2X18YBtjASESyQY8C4T87S2HOaxNxmRJnKYnMvGyFqWC6rh6mit?=
 =?us-ascii?Q?NZTtYSyGs5ms3/nP1PU7lQ7qA1DrGtS4S7kwNbCeTjmeCLyjKMEUAXVTCg5c?=
 =?us-ascii?Q?41JsF9JyLSCBoKEJJaRi9td37lU6wQiaN8jQrYNrLz8fqtjOR93ELv2wua50?=
 =?us-ascii?Q?EZBYlWOjRoBKZiZWynyi40MXGSfUph2O+BUSfgcQ0kHRJCf6DVLB2+F510Yn?=
 =?us-ascii?Q?Cp921lhBTsh4wiYFdb1WYgYJJeJdhvfLPhcH/yzVpHbHce25GZXE7bcKlCsz?=
 =?us-ascii?Q?k6s/QCRbs2fYJHyE/vLmmk+F7XSxH7Ir4EFMsvWjRoBIasH5Fd+UX4Q1PTZa?=
 =?us-ascii?Q?QNbzfGevB7YQftBYIfm3g6c2mN7WHp4iNq8Fs3A8cD8KfcXVuBkq6pwge1YJ?=
 =?us-ascii?Q?iKvzSkzP6NPKomuYCpmLqbcUGFxHskmrqx0SXbKpnZX5yqMlkzpMYl7Q0Xxj?=
 =?us-ascii?Q?7GXS9KKe0GpoW1I/Il31kjCFX2WyhC/QqXtwPa9+GR/UH/U9o0jCyuyPVp80?=
 =?us-ascii?Q?LPfQUY3s5d2YvWGbOF8OSNYdstdOHsszkYSXeGVZWSCkUTH8Xo9LMECMGzm4?=
 =?us-ascii?Q?+5pJwpfiFwaqarGH9rPmO/PbISf9sg6bZYbdEXLPFLfL1bjBCrbsqDc6kwlX?=
 =?us-ascii?Q?Tjgx5l6bCZ8+k3CeYobmyxor0mfrJp8RzusiB2D+zOMlUi66wadHwRSzhAS1?=
 =?us-ascii?Q?xDpTHpA0rygBzEB0NMKV0+0UK3h/PjDiyQgtovghv9V/wZvYmrLkcg9vMtEj?=
 =?us-ascii?Q?k1DyOQak3WY2aSdINVLrg0AnU5HQtVPly2+ontniGq+MjAGp2Yl4ET2oj7Nl?=
 =?us-ascii?Q?JWiM14CVtsbz07IU5U21t/IDOjaZsmu6WY2UuUIBJbnwEcX6Jl46qZDBw3wv?=
 =?us-ascii?Q?iy4BcvVmoITSrW0g6rpO4WNoFWDTjI8pdenIEFfkqbEJ2O27V0CpNHdXpZm+?=
 =?us-ascii?Q?PlcQaMxKWJV4tSeZifNaomfS6ZVdnZ0R1SwpKz3qHc1CUdfeeEsa6Mk35mXL?=
 =?us-ascii?Q?KZsoUvBesrzVH0US6X2i4RDaAPPjjBphj4JvMhLz2Aye6DBKNPaq457gS5fL?=
 =?us-ascii?Q?BG1im4U3w2OFQh1gfF6ufBs6mcBUal4ToC1tjX4KerjFw2IcdPY+4NTJYuCg?=
 =?us-ascii?Q?oOEhiteUdxuhIyA45Hh9NJeZNF/RtHv5UqZTTujlF+DAtNiHFQMp04v1LAre?=
 =?us-ascii?Q?ZIn9NyGIYOIaTQwDtgkHSQ9tkTeDdVNSDcCAan/lpYuOMfHUfLVrCpE26tdD?=
 =?us-ascii?Q?J648x0/R5Imu822USRvzja7/eio0Lykwd/LJOYRKHTtLLczACJ+X8uh+32TA?=
 =?us-ascii?Q?mlBEO2WhmA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ac48a2-52da-40ab-bf5a-08df458e91bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:11:14.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eM6SeF8M/5Hq0DZv6BcmfeN3pn+FcWXR7ASJQwS6oSgrAc3G4np+CR4eGc47RRpA2Ah95e4C9H3wHs1lKw8/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12146

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Tuesday, November 17, 2026 5:55 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; dl-S32 <S32@nxp.com>; bhelgaas@google.com;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org
> Subject: Re: [PATCH net-next v4 1/6] net: enetc: Add pseudo-MAC support f=
or
> ENETCv4 Ports via a fixed-link node
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 1 * Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] In enetc4_link_init()
>   (drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1025-1047), the...
> - [Low] In drivers/net/ethernet/freescale/enetc/enetc4_pf.c,
>   enetc4_link_init() (lines 1035-1047) only builds the pseudo-MAC fixed-.=
..
> - [Low] enetc4_add_ppm_fixed_link()
>   (drivers/net/ethernet/freescale/enetc/enetc4_pf.c:996) writes a...
>=20
> --
>=20
> net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link nod=
e
>=20
> This lets ENETCv4 pseudo-MAC ports probe without a static DT "ethernet"
> node. At probe time an of_changeset adds a "fixed-link" child node whose
> speed is read from PCR[PSPEED]. The pseudo-MAC path runs when the port
> has
> no OF node or only an OF_DYNAMIC node, and the changeset is reverted on
> teardown and on the probe error unwind.
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index 71c971618388b..b7e7201e6a71a 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>=20

[ ... ]

> [Severity: Medium]
> Is the OF_DYNAMIC flag enough to show that the node has no link
> description?
>=20
> __of_node_dup() sets OF_DYNAMIC, and DT overlays create their nodes with
> it in add_changeset_node(). An overlay can also be applied on top of the
> node from of_pci_make_dev_node() to add phy-mode or fixed-link.
>=20
> In either case, this branch:
>=20
> - skips of_get_phy_mode()
> - forces PHY_INTERFACE_MODE_INTERNAL
> - calls enetc4_add_ppm_fixed_link(), which calls
>   of_changeset_create_node(ocs, np, "fixed-link") without checking for an
>   existing fixed-link child
>=20
> __of_attach_node() puts the new node at the head of the child list:
>=20
>     np->sibling =3D np->parent->child;
>     np->parent->child =3D np;
>=20
> phylink_parse_fixedlink() looks the node up with
> fwnode_get_named_child_node(), so it would find the driver-synthesized
> fixed-link before the DT one.
>=20
> Would that leave two fixed-link children and replace the DT-provided spee=
d
> with the PCR[PSPEED] value?
>=20
> The commit message says:
>=20
>     The pseudo-MAC path is selected when the port has no OF node, or when=
 it
>     only has the empty PCI-synthesized node (OF_DYNAMIC), which carries n=
o
>     fixed-link description.
>=20
> Nothing in the code checks that, though. Would a check such as
> of_get_child_by_name(node, "fixed-link") or
> of_property_present(node, "phy-mode") make the code match the
> description?
>=20

Same point was made on v2, and the reply is the same [1].

This is a theoretical case, the Pseudo-MAC ports will not have overlays
on top. It's either static DT node (fully specified), or a clean PCI-synthe=
tized
node. Any other configuration for the Pseudo-MAC node (like the one implied
above) is not valid.

[1] https://lore.kernel.org/all/GV2PR04MB1174015C406D353895C57476696692@GV2=
PR04MB11740.eurprd04.prod.outlook.com/
