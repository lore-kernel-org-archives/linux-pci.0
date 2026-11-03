Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793713837;
	b=u7CEF+2w4JwTfekvE8p5IDXz2EEvhstfyxbQ7WP42A+k5TH3EOu29zmngWukCFu942SA
	 b7TBoTQjOgA4SE4Cs6qb7IIuAlNOd+vA2xiivhe3XlK+e2YIpRYuYn54G85yX9KYPiREY
	 kD+untdw+ewFoqefPz4zX2QSEvrvbPlzSgUF4JdXbxOL89+6W83QJ4WRzWDBhzxZ1Xlxv
	 9FYtqM0mGDT2zofxDBd0gmLKp49kDvlCWlvh041e8eO1tRCrPj6a/WDo4ZWvN7dSZTBk3
	 Dv2vk1naNKszT2p8ayRnO181WNaHzV31YxcKaoxRQf5IR+hsZg6onA79OGrZq2H84Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713837;
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
	bh=iw7shbvkZhScOmV8hr1+s8eUmM46Jh+7tdR6dGhGs0U=;
	b=s40A0evrXvaOy5t6/9wthKXfFrfaPP1ZBflahomf8yo7QnmG4JNfq4GaXANnN42+LB1b
	 Qb+lDM74PaIINyGpMZnu7p+IyC473M0dqmx5b0bYJrYKiWCDWU0OwV+l+CLL2Q4xfiXvo
	 /DCNbwkiNhTJRRINWQXxraTtKepm1ytt4TPEfGniY0TJoDF9i4q6zT8+2uLJmYopec/YW
	 W4NeNhXptNLuMWwXXqOMS65Mujha8LwI4CevMkjFVUSNh9lTwMdozWt2tJFpkWfKSAuI2
	 ce4+9hFroogSe1bE/gpoMunQjiRf747NMMcewARK8tDd/Ejdrqk6YefD64zZ2sIHWzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ITKCYBkJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.14
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA19606A333;
	Tue,  3 Nov 2026 13:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA19606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ITKCYBkJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq6SbGjbrZevpAcS4Mw2WwEnI+zjd769aTBQgDWvVbbg5sCgRjh2b7bSYno/Uy8izcU2F589EdDkyogDX1uP/2CvYIyRrUvdRvgDa3vmUeBD3xLzRFM1TC54f0no/w4xdMHcsut/O6ETaPSSOsfrT8354Dz5WiBF4XDyvGYJDwRRwspseEcIDyI36/jMdjg5Ds4gbsBvZcO7jIWysWZxD05R7zirayeNjKnqGYgih9r9VCUcYPousf8Tg6mR6uYsBAoN1krr5Q59qGvTUJe2t3s2WGkLtxtC7RKP+aMGWyCRqG5KoSkFi5CQniWe7XLsKwrzxKv8a1xOMoc/rgA8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw7shbvkZhScOmV8hr1+s8eUmM46Jh+7tdR6dGhGs0U=;
 b=ToQXQMLeQnYN+duXWarSfVl8zy+TMbiUYMjVpBU/+h3kIHrMgke32bOGSqc1UDPZT4fCAt5sDe8E1PLZqSng8e3yXnzJA8zl89yDcOjXTG7NJwaEGtqBJFA24Q4TqnfSFGl0e9XdyFp7unjthsxzBT548D8P0uRQkzmrcX9yNplhzMuAuA8bJXRNQkxciSErYx81YiIgMyDfb/8fwTgwPVhvd8tTL0dfKOl+QogIsWRAHdPht4omEtDnAMLeBtRjJXzQA43cAW4IkQStmgAT1EfD8dBjH15ayOw5UGTiT2uFvh1IHUoFK/5RpSP7HAmIlqb+XDrn0vM8AjTNF6fAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw7shbvkZhScOmV8hr1+s8eUmM46Jh+7tdR6dGhGs0U=;
 b=ITKCYBkJ84R+I63VTtNnUQPFLqaT7dt0r6DC354E97jKe7CrgYJCtaiiuQ90dyqoyZbkRquOHSadYbA+Db1LxQJodh46qD3fKkHkzIouWaFx/hliE76WLPLRSFefTT32Jq3bbvsy0QPExBhHlUYukbCjgKnqsXQUe9UOoX+dOIkkK+9WV3mL/1dTfb8gOjWQTFXJhKvPOK1xzHQlBuLbAVQEqm3iZAJ1UwIn1qgII4v6IG4Ex1dBcBXyiER4bFQfF2S2/5lW0cnheLOGpMKEwPmoSP4TJ3wJD3rUpjU7PuXI4+MH5Te3TrC7BYiIPb1bFjX6uNYni4MyD346AdVQ7Q==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DUZPR04MB9966.eurprd04.prod.outlook.com
 (2603:10a6:10:4d9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:50:32 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 13:50:32 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v2 4/5] arm64: dts: s32n79-rdb: enable NETC IEP18
Thread-Topic: [PATCH net-next v2 4/5] arm64: dts: s32n79-rdb: enable NETC
 IEP18
Thread-Index: AQHdXUZ4YWp+3nR8Rk6cLo9WgJZrt7ccd2Xw
Date: Tue, 3 Nov 2026 13:50:32 +0000
Message-ID:
 <GV2PR04MB11740BC1C66529A8E2B672CF096692@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: =?utf-8?q?=3C7c22b051b08887aad6b6a73462028298902ff3e7=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
 <179213850647.434549.7104910739428265199@kernel.org>
In-Reply-To: <179213850647.434549.7104910739428265199@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DUZPR04MB9966:EE_
x-ms-office365-filtering-correlation-id: 15481594-1be4-472e-c583-08df39b16de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|3023799007|10067099003|18002099003|22082099003|56012099006|38070700021|11063799006|261022105027099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info:
 OCJFUcqkC1+fUVf+r/ixLU8OeFU4DU68iv7jOniymvsNzTBHZxsYmsRYpbtHcRB3bAkmLu1Bm8Km8UxQ4M23EMkvLPRQYx2Kx5D/3b2r1QHOAvwOxXMKnA3d0iXqnnP9Gvwv2ADMqYMOL8g0nD98TxtsJP6Md/7x8Y8MM4SDnQ7Loca38frBjOGeOTV6Z8cQOVnsKLv/7u4i2TqpGLUwyMajKFjaJxIuS5BZtntP40f31IhCvuye7wqJyFjOa57Vg9sFwCouon3mm5xb95JBquyOxsfUKfJw2wlx3kip6Nb/UYlQAe2WqmM9qn/3Q2iqM3DtqeJuJe3AN2qAb/NjLHSYss++SMJ16XVcmufB+eco2XuvzNdM/bdaBjNpX9utMSQ/vcfAtUTWmC1EjAGU2HwSZFyvL2jY9FXbBapBTfkCTZ4mHsI5/uYBHM9Vx2me6QSAJzCxV8p899TqcPqWm9g7S1AZMS7atSe/ZCf8szsDnME1yEP2RBO/ld7euoVG4a0Oixz3ZE1wwlsFQW8Z7EOJe027Vv+pY1XQAOeZKMBu2L/HMKiJGnhVwXC5gLw7SScupNatjE4fZ3HKvIHHUlatQ1RTjLJLlZ2oJVnHvMITyrjbvXWORK2YlEB3+FgflOFP9eFhb9uq3bZmTvIa4yN5ULsgsnILaaQp4odeR0GyFEcqNaHJTyXTD4FjhOkHlyZQAgvUm7N+4ns52g/cheAIfURcwQf0XbuUCQpKDME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hxaJoxV+sm/PL8h/q09+e557dmJ2j7fTEBPmDBIIjkvf9I2ODYlYq4Mi5n8+?=
 =?us-ascii?Q?ayJxnoKMiefhP56nnHcdzUWGsb52FE/CnOI+dz5DpClh+W9f1Pi8PLmYIaRP?=
 =?us-ascii?Q?UJqHWw4PI0aHujHaMun5tqmc/Ytd5e500K0ypV8bz7mmw6k2fyEscU/3ErHv?=
 =?us-ascii?Q?Hbsv0jd5VsoWzypajKA2EkoU7p1Tnp7hGdWMZLts/rwHxRNzHs234pHVkxzk?=
 =?us-ascii?Q?d3TRugDHnZstpeUFjpmdShVl6omvWSDbMXZ5D0G4VPEr0QD/PH3dWKabNkGZ?=
 =?us-ascii?Q?jWlgzw0ev0CcXkVqMeIlc9BZwFKHPGCammsgQx3T9FC8/7aCsBaYBZIruW+C?=
 =?us-ascii?Q?Z0/DH6uSVG1wsRQ8V/9LMKtASbMZtjR72Jht+sbrjpqsLLqu1M1WBktmulET?=
 =?us-ascii?Q?fmJJrKuGJ6X3f3l32MM7k/gU+GSJ1bpLDBi89+9HZcQbKzY84yGbP+TfakXg?=
 =?us-ascii?Q?WK+Zq/2OfKRVTOxuh8Uwuwsljrp2PezPNTeTSM96jjSUHLgZvEyXo9zKO1Qk?=
 =?us-ascii?Q?zT3jK2I3iQsAxcUe+0zvaXoKreHxwOjRBLeX6Y59z49co7OzuZ8q0AlznnCk?=
 =?us-ascii?Q?tl3p4FV5+8ptUaNWxW6/h2qIxEujVKjLlw5U88QhRwSt5EJT/7K7ImFvj0x/?=
 =?us-ascii?Q?gSDkg4LLtnICVw4/+c2DvpDrLMAFsgHK5FdV7usJeCnR6YkPIdRf8cq8RDuy?=
 =?us-ascii?Q?qhW6925sIQNI4DlMni4gIu8389jgS+1Y4mZb2T68ZVtr/+GvbC432rv9heeH?=
 =?us-ascii?Q?qT+Oc2OOqEjwmb3S5R97n4T21oP9cJjNv9S6C8SkU79JsLH4fsaUbNRlG0zN?=
 =?us-ascii?Q?n3/wyjnOK2PznEPcSwjJ+YlZHiB3h4fdUfQ0H4HACfb6g4SjxUu+secRp8En?=
 =?us-ascii?Q?/zX3zk3xUVxDJt3LBEOvyCinJi4ek7yI6XkrNG7gKKA7/yg+uMWsHbC0MpmL?=
 =?us-ascii?Q?TjX/TnAR+gP4YBiitvA3zCbB6BXpPgmxOgI4wV66WbqomLQorfMg2wetTHVs?=
 =?us-ascii?Q?B7B/OzqF7IjS8qZ3FLUsz3q2QRZpZhk2aIVedG+UaAhbMb8b7IkKGy0hp25v?=
 =?us-ascii?Q?ABQDdF1I7Oe8BmO5cA66gOa5HjJ5+o296X2UqFolV34gors+DPmeatYCCxXG?=
 =?us-ascii?Q?O3y61i6uS7SDHYdkx2oOaSDcPFIzMf4gm1PGOhWNUz8vjGLXLUPkhhUTguxy?=
 =?us-ascii?Q?AFOhPsUpxGBkxtvfg4iZoMTJ2u6ZdIMW6CpyTmALL753cwSnhjWPoXZNA5yJ?=
 =?us-ascii?Q?v7Mf4Nrvgc1POWK1AkdLx4WziZ71cF2o9LT7SBi6PBIrpAwt2OFqE+iWPAMS?=
 =?us-ascii?Q?yLyZWbVO3eW0dhO0qj68ha15OBH6+Mk6ydjrYDZwEKRrP5D2Oua9H8uWdJbu?=
 =?us-ascii?Q?63Mt8943lXxN8tMv9Y1grT+cLZ3+bfVPfw5bUUGG5KS6I45m6MM3OcK6+9Aj?=
 =?us-ascii?Q?Qj+6SCkj9GibltYrrVnpAuVwqA298nlYa2q5v9/9pSIZLm5s+DdHsEPI3N0V?=
 =?us-ascii?Q?kZIzHWcq8LkhuPOIPz2qy44eVuh8z45jpF8u4m494WEXdGYYA9JyQWZCQFgX?=
 =?us-ascii?Q?QHKrlp0BcvVniLzjz7NHg/y/tmkwfDqF/noMyekU9XBnfzeDudOzaCgtg8l5?=
 =?us-ascii?Q?cMB6eTnpvxc7F+IsDCpDuruqtZ2In7TIZcUWw3l7LPNy467Yew7gZ31+Uukx?=
 =?us-ascii?Q?fx0ebpoGEYJfZzWY2QocL+qXcDJK37EqFypoZulzXD5QpLV8tsunn5/5ZWp8?=
 =?us-ascii?Q?yAE8Moau+w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15481594-1be4-472e-c583-08df39b16de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 13:50:32.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/QMl8B8YOhG8IpsEYaXSU2j2R+9D53e9k4IpfVngKuwYj8y8m1MlQiZhwX16juJKmlmD/0ru3AXX/kTlOK4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9966

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Friday, October 16, 2026 11:15 AM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; dl-S32 <S32@nxp.com>; linux-
> kernel@vger.kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org;
> kuba@kernel.org
> Subject: Re: [PATCH net-next v2 4/5] arm64: dts: s32n79-rdb: enable NETC =
IEP18
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
> - [Medium] s32n79-rdb.dts enables &netc_iep18 but leaves &smmu disabled,
>   even though the bus node says `iommu-map =3D <0x0 &smmu 0xc0000 0x100>`=
.
> - [Low] At this commit, enabling &netc_iep18 in s32n79-rdb.dts does not
>   get the PPM PF to probe.
> - [Low] The &netc_iep18 override is appended after &usdhc0 in
>   s32n79-rdb.dts.
>=20
> --
>=20
> arm64: dts: s32n79-rdb: enable NETC IEP18
>=20
> This patch enables the NETC v4 ECAM bus #18 (netc_iep18) on the S32N79-RD=
B
> board. The goal is to get the ENETC v4 Pseudo-MAC port (PPM) PF and VF
> instances probed.
>=20
> > diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> > index 1feccd61258ef..897ba24ac03ae 100644
> > --- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
> > @@ -68,3 +68,7 @@ &usdhc0 {
> >  	no-sdio;
> >  	status =3D "okay";
> >  };
> > +
> > +&netc_iep18 {
> > +	status =3D "okay";
> > +};
>=20
> [Severity: Medium]
> Should &smmu also be enabled for this board? The netc_iep18 node in
> s32n79.dtsi has:
>=20
> 	iommu-map =3D <0x0 &smmu 0xc0000 0x100>;
>=20
> The SMMU node is disabled at SoC level, and s32n79-rdb.dts does not
> override it:
>=20
> 	smmu: iommu@4fc00000 {
> 		...
> 		#iommu-cells =3D <1>;
> 		dma-coherent;
> 		status =3D "disabled";
> 	};
>=20
> DMA setup for the ENETC PF/VFs on this bus goes through
> of_dma_configure_id()->of_iommu_configure()->of_map_iommu_id()->
> of_iommu_xlate(). of_iommu_xlate() rejects the disabled node:
>=20
> 	if (!of_device_is_available(iommu_spec->np))
> 		return -ENODEV;
>=20
> of_dma_configure_id() then falls back to direct DMA and only logs a
> dev_dbg() message:
>=20
> 	/* Take all other IOMMU errors to mean we'll just carry on without it */
> 	dev_dbg(dev, "device is%sbehind an iommu\n",
> 		!ret ? " " : " not ");
>=20
> 	arch_setup_dma_ops(dev, coherent);
>=20
> Does this leave every NETC function, including the SR-IOV VFs, doing
> untranslated DMA with no iommu_group? If so, the VFs cannot be assigned
> through VFIO. Whether DMA works at all would then depend on whether
> firmware left the SMMU in bypass or abort mode.
>=20
> This also seems to contradict the earlier dtsi commit "arm64: dts: s32n79=
:
> add NETC IEP18 ECAM node for ENETC PPM ports", which says:
>=20
>   DMA is translated by the SMMUv3 (iommu-map)
>=20
> The last commit in the series does not change this.
>=20

There is no contradiction, ENETC sits behind SMMU, however the SMMU node
is not ready to be enabled yet, and this is not in the scope of current pat=
ch set.=20
SMMU on S32N79 needs some support patches (SoC level workarounds) before
enabling it, since SMMU is a system wide config that affects other devices =
too.
ENETC4 is functional with the SMMU node disabled, and I can confirm it with
traffic tests.
