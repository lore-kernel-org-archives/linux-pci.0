Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795016617;
	b=AgCe8zDgBwHWmjTACsF5r2iUGMf1FBzYgzQfvz830viWhiXHhU7lPsgfzD13/s741kNu
	 CbX9SS5eoYtmKUFhGjoBfNMlXPXkePScuDsD4Qu6GFADyT5iV4GVEC8WBnDJl+8gp+HWU
	 7BZ9OJELKj7vySl1PerMifGMv312JfFxAB+SdWhGtFI/EfBJfwQtQaYHMyHlVWNi1NEFk
	 KyR8Kr1XYSc/Mm6sEHFvRr9kUbOrLwo2jZv56tIfErFNMhnQSXfB3HPuqdZsI7TK6ucUL
	 vAuT+EyIt0Of3W2kCxay73TKL6BRlqLWGFDn5D5tBlE9GigCOpX8XvBjw6xGOSOXz5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016617;
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
	bh=CAGWkVkLtYTrhtRX2eKxyMbgl4CJfBTKR0bVr/c5wfU=;
	b=AmxxUTRaUSZ4R2f2Yw0uA0oqyOAB2Tg0X3hwbeHZUgwCitsUpprmpiSlCv8ZGu2xaR/P
	 4RlF9GNUKPmHYsj5Tw9uq09JRlHYtRbin7j6/4FTO3RI0mMccxGKbMQ30wpjIGCB/Eh8r
	 /nIGdGiZBFNs4ADwfIMwxd/E+1sOYApw2HiJaeJ8duSdE6/eJSduJfN3emFkVtGxymL2B
	 u0VnN097bRc8wvLA5BHiXfsuKWm/kq7rtZWxAgJvtBjtRrUs5Hla31I+TrZovxuk0ILYS
	 S6taLTXwgGbuaUPKkvf34sbbJ9JocVcd7jlz4vO/eEDHS8+ZMLI9QjKXIWsmukl0cSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CJNZlSTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.33
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7D606A320;
	Wed, 18 Nov 2026 15:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF7D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CJNZlSTA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szmBatOTgIvl1awqXYAlar6kzNTr9lA3V8uK+oZsTjDhCiX8dSqBOqUQKYsqb0t7Q8d9uG/v/4fbFl1Ikb21ZRarwVGdiO7yGLf+/PeqNw1WhgsHe8cmPo5HiWqoKYjczwgeb+Tmq8cWxPbD+e1vq5yXs3sj5aKkvfIA19/OtMF/SNnKtuGjk2wBPCIzWLA/Lei8vZyhE1oVnpNiOz/Sp4npMxDP6/aX5evxrLoxB+EmYbpdsxeM1ERD/U+d/2G9MdKR3vjUqoC3kdS+yc9/tBEmmPBhtjKOCoh7Ue8lWlSS2OBmd5VaxdNjOX5XBQCK3/Skayb0xMt+/FYIKf2ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAGWkVkLtYTrhtRX2eKxyMbgl4CJfBTKR0bVr/c5wfU=;
 b=aZkSDeOiUBqdX4p1d4dsux4uLQmdlfOcb0x3oLiewdWZ4/6mN+yJDxbJauVkhbM7J4hreg7x+6K6S9PW8zGg3hKrDhhm8X9Qbt4voEnuNE1WTBXe3/RtTxEvT4ezWSnZfaNCKoRNAbjeEiy0ZJo9ESCuuihzijPPQuuHBZxyMCviGo9ifUnScUUiFfb8edtMifhj83BQd5vMr3NULyyedzFuDiCK9NOqGAMl++9+Z2RmQ3F+bbnWiKjQVm+ToxHrGIjqShP+fh8QZ7HWSbL1wnXmX+z9Z9ErHrXrCRtVtUBqk+DYz2Mr76pTlMeCyOIIx1ZGPF9nhZrzyTKUDMoBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAGWkVkLtYTrhtRX2eKxyMbgl4CJfBTKR0bVr/c5wfU=;
 b=CJNZlSTA3DvuDqYvgWrj6SwIcHi+9PjuZaWaXFURIahKUYVUa2mOTtLcdunPGKJTwcVWj7wBl5UAR2o89Wm7c+Z77la2ZGbHQpmnaeQnhh8560UgZP3h97ALuJpcY5aWeMVk3+LhSiVFnrJtYJ6nrtlPRmQo9kTjAZIx8XmXlmjK19PxGdOmNI73A+swKyzQrdl9Wxtv2zu5RnmmyURp4JP0MEBDNIgD9vvY+UBJHO8UpMGailkkhv8jsGPj27MfAFCoG46Z8umpqLz+HMmtkv9PKcBrh4aha+SBfk5T+tctxdDgxWV0WISngdhqi+SSiWpBijHLcF/BqfvvHQi+yg==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AM7PR04MB7144.eurprd04.prod.outlook.com
 (2603:10a6:20b:11b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:43:32 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:43:30 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v4 3/6] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v4 3/6] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdc41TJShMGQIS9UaCBuxXqhS1/rcycPEAgAGKZaA=
Date: Wed, 18 Nov 2026 15:43:30 +0000
Message-ID:
 <GV2PR04MB11740A7E208FDFCD4A158BF41967A2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References:
 <d783ccebf4b38bfd1e2ede44c36682269a5bc68e.1794581338.git.claudiu.manoil@nxp.com>
 <179493091076.3136.7730860553084197808@kernel.org>
In-Reply-To: <179493091076.3136.7730860553084197808@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AM7PR04MB7144:EE_
x-ms-office365-filtering-correlation-id: c0680040-1546-4d9f-d693-08df458ab22b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|38070700021|10067099003|11063799006|56012099006|260925021911599003|260925022911599003|260925021311599003|4143699003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003|13003099007;
x-microsoft-antispam-message-info:
 o/r2IHBk8FSDxUQK3RPnWbb9831MwAtzyRWZ4enseisj7k0YmbmUPAa6Lc4i5b/nkOjvpyTPNT9/1scNya4XKnccKQ0+UF8fpwgtTsaa+N1klKNS82NoBZM9EYMcEAu5XaUFcJN8Pe71tme9+1TJ7g9dKqDTC+JvgVgrbx9Ivn8vgqPJTqvfkFtpnRVvdd+tDPhAzL02/K/Pb85Ery5zaBQ2gek14zX12svWSiGD6AcSOq8w8BF+dGRP45i+ktw4sfADudXJZ9Dpt3SR28bFlK/5MRKZF1cBdLAzpAgjvAZFA/WCKxem8kQw6TSj00SRk+d7tkN0UmNqWGOFF873jRxihlmFi8B1Ajq3fRNrLb+vJobZsZ08KCMlkO7Je2vwCtdcrhA/YSXdf6zB/R0A0uxQf4rSve4GQO1+V1s8sP/1gUSN4CE1nNc/iPbKlw3rM0jM7SN8MxbU1RXsSm/gtwJW5N3M5MT0h8Cg1qx7tjmDKvftWiz1b5I1lzUHvvAA3b1z6B0XAcpwA4hTVE4hgGwUmAYQIGaQof2CcoAULctWpFwMGe9RrIdQX6J+3czl0jXbfrtWLs26DMhKpNtIbIUvx9/YJa7Dp2SNtCiy2hTZlmSR6DM7XsdOpkmDGwMhR3bkFFzrv+VHYgvCcih3WrPyvUWxTJz0CdN2Bfgti9c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j7SfA7BhP4W1DrP/MGs5oT6d9anvqzp/49GOyA/3/RxnQlc370QKId51t9FI?=
 =?us-ascii?Q?sSu/BbGOA1wuMq/wyS7jJEiTk3N2p4rA3F4hd9CgsJyB1JopV3RsGs4ElE+7?=
 =?us-ascii?Q?tfnHStFLTJlcWlvROOLO9jkOehaL3TBEssUd+Pbof3a1zteZx71ijclNfkx7?=
 =?us-ascii?Q?FF6Q2ACO41rru5+96B6tla2ns9EGSNXSxOa304aRPWz8RquPQQJV/j/5Xdc8?=
 =?us-ascii?Q?giL8RW6LOeNYiYo9LiPT4VFVb0XKID3D8tvS1Hu9Bbza1Wk+84OaskjcyZg5?=
 =?us-ascii?Q?TIcYx4K+B9Ycx27ddINQi4PVLCnd/4QXDed+fYCZpwSmJbr0mEpgobRcWPJI?=
 =?us-ascii?Q?bn1HCMqjHU1WRsDgZA2eqLnrgr+8C3zlMvha+rXKQgHfaNv3W9S0YTB7sFR6?=
 =?us-ascii?Q?x7kUrZXOC+cEHU6kzTNHTfMZqkL4kvzMFGtepT/2hYXunuVcwKIt960s3yhR?=
 =?us-ascii?Q?myXZQ1onxnHfVoEp3uRWBLEvQQEttdFgALEaS6B2qxYObPbOvMkMxF7rGMb2?=
 =?us-ascii?Q?oRilTyEJ51Tn2AbI0udPts6GF5bxdpbg1SyZyMrWl3wB9g29GxX5itwEPDvw?=
 =?us-ascii?Q?6Cf53SiwlhxbWpMF1URg127LaoT19EUhHsDyYqaP7irjgWhlPvNFRS/lAW13?=
 =?us-ascii?Q?Yp+u0E63BREd4UkdJuSHfaiSXqjFIvdCIM/g0AcRn3dS0nMWCy3XKbXnKES5?=
 =?us-ascii?Q?VC+o2GVcTtkdFru+k25gvDlujrbT9IjdgltwSs2FWOm9Eil1njeQ/d6oTsvO?=
 =?us-ascii?Q?NrCRqaZhJryGYS7NGZejhk8nqzyvC3uztm8MPym5ketQ3snBLe2bNDdU1KWX?=
 =?us-ascii?Q?xo7Z8G9pOkvvco2xbY8Vnwsrz/9wQi39+elMJLQQWCerpc/m6n9VLW4+d6YY?=
 =?us-ascii?Q?suz29TByM+pAPs4AV/+BaFrY0z05b4pCnFEgqix70BvzwzQPDovbJnoSF1fX?=
 =?us-ascii?Q?Y5k62Hmjx9P/QktgMFdPbEUW1vfjjpqG2i+m7EZ9UE39qEkDKllOr0CQoiIi?=
 =?us-ascii?Q?3J3H3TvPqRxNqKA/sbAFB//f9NaD0eABoGBofzdYNmKuLYU4Tpbm0kx/4sng?=
 =?us-ascii?Q?yd4hexMLg8SbpwmZKlifPO2/2k/itKxGbZH0+stvtAnF+2e5xrV8XrFt1bcn?=
 =?us-ascii?Q?tsi/tNj+pyS7QDQj9l0Q+N9/vlbR07F2JqnAZAfg09PztllaenSazmrQWQV0?=
 =?us-ascii?Q?gIOa/8hzF+y58wJX1gC3n2dBLAoBKuWu5dDrFJlJ5GrwJfUTSAAsa8cC8r9/?=
 =?us-ascii?Q?k8mWY1cJMhTC4ttM7vtJhQ/EU/m9RdmfVhcyWDcvdgYkxyOqZkAvTeh8pTg+?=
 =?us-ascii?Q?DYYo4oWw+0bTnR3AuxidBpURdjDvCKfXeCIvrjKp43gOPddV6zpJWft9o+8N?=
 =?us-ascii?Q?+gcXJ4OUu3z8r0ECUDSjZIS7IOm18qfp7yoGHLA6kQjffqx9pF87ljoX4bVp?=
 =?us-ascii?Q?KR2Jw7lvJB8lFvZcUAKvn0zNixHyqOkbD2PqbDMmjUO6uYMXuGrTJGArXTk7?=
 =?us-ascii?Q?/FN/0indjBPAMpzpQ0v2+0WAMLv62ZPtGcVp5pGTwOk8OwzIzqDPsvCDVo8x?=
 =?us-ascii?Q?Y6unNblARBYSom1IEfXF7nVr+CfbpvOBgyF81/HMnBjddJFVliK6LmklfkfU?=
 =?us-ascii?Q?/8H39s3RCRuL2zpHg765uZouGhQqooeTWQwC2aNDz8+3Vu8Fyf02uOJ8sHWW?=
 =?us-ascii?Q?/1QI7TfA0Msda+MhT4J+EP2Li7thEWywPP924ZvjvHPzuwzexu8xCLUGA2mr?=
 =?us-ascii?Q?8Tz7PmdAig=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0680040-1546-4d9f-d693-08df458ab22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 15:43:30.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fm6TnD+lrh5YDRUt8wkKkJHDi/B8TlGWuCAB+6SWMuBqrhzcsJeDk5F3J2hPRvJbTGuXiyZ+hHtiIV0riKWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7144

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Tuesday, November 17, 2026 5:55 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; dl-S32 <S32@nxp.com>; bhelgaas@google.com;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org
> Subject: Re: [PATCH net-next v4 3/6] net: enetc: Enable probing of versio=
n 4.4
> devices
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 2 * Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] This patch adds ENETC_REV_4_4 entries to enetc_info[] so that
>   S32N79 PFs (0xe101/0xe110) and VFs (0xef00) now probe.
> - [Medium] When an ENETC v4 VF cannot get the IP minor revision from its
>   PF over the VSI-PSI mailbox, enetc_vf_get_revision()...
>=20
> --
>=20
> net: enetc: Enable probing of version 4.4 devices
>=20
> This commit adds driver data and platform info entries for the ENETC v4.4
> PF and VF devices on S32N79 SoCs. These run with a 500 MHz system clock.
> The PFs use the 0xe101 or 0xe110 device ID and the VFs use 0xef00.
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 855b2d3b87182..e3aa117d323d5 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -3840,6 +3840,20 @@ static const struct enetc_drvdata
> enetc4_vf_data =3D {
>=20
> [ ... ]
>=20
> > +static const struct enetc_drvdata enetc4_s32n79_vf_data =3D {
> > +	.sysclk_freq =3D ENETC_CLK_500M,
> > +	.tx_csum =3D true,
> > +	.max_frags =3D ENETC4_MAX_SKB_FRAGS,
> > +	.eth_ops =3D &enetc_vf_ethtool_ops,
> > +};
>=20
> [Severity: Medium]
> Can an S32N79 VF end up with the 333 MHz drvdata instead of this one?
>=20
> The VF gets its minor revision from the PF over the VSI-PSI mailbox. If
> that query fails, enetc_vf_get_revision() falls back to 4.1:

If the enetc_vf_get_revision() query fails we have bigger concerns than
the VF coalescing operating on a 333 MHz reference. There's no fix for this
fail, and it's outside the scope of this patch set.

>=20
> drivers/net/ethernet/freescale/enetc/enetc_vf.c:enetc_vf_get_revision() {
>     ...
> 	ip_mn =3D enetc_vf_get_ip_minor_revision(si);
> 	if (ip_mn >=3D 0) {
> 		si->revision =3D (si->pdev->revision << 8) | ip_mn;
> 		return;
> 	}
>=20
> 	si->revision =3D ENETC_REV_4_1;
>     ...
> }
>=20
> The query can fail in several ways:
>=20
> - -EIO when the mailbox is busy
> - -ETIMEDOUT after the 200 ms poll
> - an error status returned by the PSI
> - -ENOMEM from dma_alloc_coherent()
>=20
> S32N79 VFs use the same 0xef00 device ID. So in that case
> enetc_get_driver_data() matches {ENETC_REV_4_1, NXP_ENETC_VF_DEV_ID}
> and selects enetc4_vf_data, which uses ENETC_CLK_333M.
> enetc_vf_netdev_setup() then copies that value into priv->sysclk_freq.
>=20
> Before this patch every v4 platform ran at 333 MHz, so the fallback made =
no
> difference. On a 500 MHz platform, wouldn't enetc_usecs_to_cycles()
> program the default 600 us tx_ictt, the DIM rx_ictt and the set_coalesce =
values at
> roughly 0.67x the requested timeout?
>=20
> enetc_get_coalesce() converts back with the same clock. So ethtool -c wou=
ld
> still show the requested values while the hardware fires about 1.5x soone=
r.
>=20
> Should the fallback change now that v4 platforms don't all use the same
> clock frequency?
>=20
> > @@ -3870,6 +3884,18 @@ static const struct enetc_platform_info
> enetc_info[] =3D {
> >  	  .dev_id =3D NXP_ENETC_VF_DEV_ID,
> >  	  .data =3D &enetc4_vf_data,
> >  	},
> > +	{ .revision =3D ENETC_REV_4_4,
> > +	  .dev_id =3D NXP_ENETC_PPM_DEV_ID,
> > +	  .data =3D &enetc4_s32n79_ppm_data,
> > +	},
> > +	{ .revision =3D ENETC_REV_4_4,
> > +	  .dev_id =3D NXP_ENETC_PF_DEV_ID,
> > +	  .data =3D &enetc4_s32n79_ppm_data,
> > +	},
> > +	{ .revision =3D ENETC_REV_4_4,
> > +	  .dev_id =3D NXP_ENETC_VF_DEV_ID,
> > +	  .data =3D &enetc4_s32n79_vf_data,
> > +	},
>=20
> [Severity: Medium]
> Does enetc_get_phc_index_by_pdev() in enetc_ethtool.c also need an
> ENETC_REV_4_4 case? It has its own per-revision table for the timer devfn=
:
>=20

In short, no. PTP support for ENETC 4.4 is not available at this point.
The explanation is the same as replied here, for v2:
https://patchwork.kernel.org/project/netdevbpf/patch/537a977b10b3d76c30b1f8=
79f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com/#27330675

The VF for v4.4 does not support the existing timestamping scheme.
On platforms with NETC v4.4, CONFIG_PTP_NETC_V4_TIMER will not be 'enabled'
since the v4 timer is a separate device on a different bus that is not owne=
d by Linux,
on v4.4 SoCs. No need to modify ndo_hwtstamp_set() in this case, and it's o=
utside
the scope of this patch set anyway.

> drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:enetc_get_phc_index_=
b
> y_pdev() {
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
> enetc4_s32n79_vf_data uses enetc_vf_ethtool_ops, which provides
> enetc_get_ts_info(). SR-IOV VFs have no OF node, so enetc_get_phc_index()
> always takes the per-pdev path. For a v4.4 VF the call chain is:
>=20
> enetc_get_ts_info()
>   enetc_get_phc_index()
>     enetc_get_phc_index_by_pdev()
>       default: return -1
>=20
> enetc_get_ts_info() then jumps to timestamp_tx_sw. It reports no PHC and
> only SOF_TIMESTAMPING_TX_SOFTWARE.
>=20
> enetc_hwtstamp_set() and enetc_hwtstamp_get() still accept hardware
> timestamping configs, because they only check
> enetc_ptp_clock_is_enabled().
>=20
> Would ptp4l and similar tools then fail to find a PHC on S32N79 VFs?
>=20
> The v4.4 PF uses enetc4_ppm_ethtool_ops, which has no get_ts_info, so thi=
s
> seems to affect only the VFs.
>=20
> The code doesn't show whether a NETC timer is reachable on the VF's PCI
> bus on S32N79. If PTP is intentionally left unsupported on v4.4, could th=
e
> commit message say so?
>=20


https://patchwork.kernel.org/project/netdevbpf/patch/537a977b10b3d76c30b1f8=
79f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com/#27330675
