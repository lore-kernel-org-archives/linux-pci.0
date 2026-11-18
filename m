Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795045366;
	b=aPF65gnrzmec+xVwDdmi4AovIVYvSAy4mGXFoU1wNpiYZATTjrfZKD83/I1wqQwX8Uzf
	 XL1hxhl44/I81k08NR6moLW+7hSGnGf8qb3+PLkxb0toygOrX2ktEzwLP/QtAbnV2WmVn
	 Zt73+XMQPNAmTBXvfLmj93mMOg7zcXaLzSjMEERMfdFJw8sZ0LaclKztL3p45dpLUEf/E
	 pmc95g7CH+QzzhclOruc5MjSMkaEJrxm0xLn6VpBjn7JRq1V8nIy2GZcQzzrwhyE4qqfV
	 FWcZEmlqov3FrCCLHBXL/xNXfq0Z3rkb9p4Lv3a/7oN739z/1cwDucUEA2mEPnFrvOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045366;
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
	bh=3qkUC4yMtTty7thHJCQp9F8e+5bYFttokNaJjNG8fW4=;
	b=0mYX0+Y2MjzaBEmpqWxesWD2kewiu5gyYJMmC5FyMhI+a9Ir2TF2gMj4G6ekJ4UgwktI
	 CTOoS8j+fPCemWBWx/ubmysmy0LHO56uLUCiG9XeB7vJoqBtDO3vfJ2XqHinZCDELSxcF
	 CsoA+8unZ/JQK7dxPOHU4WJcZyYxLY2Zun2irCt4+YRb8RLJonq7Ji3vyZvp8fF072K79
	 cpLrDeZJcB9Uc/EZzA8ravaThperfgenWKIvCiB6Czud9zGZvLEzUtWbM7iGdyin+fv0r
	 4JH8d1Maq7oIhyXSNwwu7UvSLb8wAJtpaIatWS06xq5Jzp7YRl3CIqQ6FqaZiU77FlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dVqF5J4Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED1606A335;
	Wed, 18 Nov 2026 23:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3ED1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dVqF5J4Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdkpyToOq9EmH77b2QQiB+EYZcn9g/tr5qCMhuy113RVjCki/W4w0+LGeati2qR1Cy6OQA1Pz1/LF/UhPs9SIHlBxEGpPqtpRF7lsotaI4sXw2CZGZqPE0k0suHpLOl6iss12qIfkCTg54gA3FRo6Jfh0HBtxL7Cx6llw7hHqKwFnoXMnFntjsPOF5J6p2uoVs2hU2g0pkPaNC7MfX00NBwblqayIQglHXILmFuD+aVNLmibbOLwnX6H0Dfhrjn4aukOcpKRqGDPufb45YT+N4k7/tWEFwPH4ok6Mm6UjT+TOd8hsdCT4zCtBdFaHIFtc5Uyspg8R2YOHarUYXrb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qkUC4yMtTty7thHJCQp9F8e+5bYFttokNaJjNG8fW4=;
 b=vdXc1jTjymIauD7FwMQw2bWemzpM/qHEJcyk2GlD33Y2pEB+xdpA56ytTakNTwos7IudTwVVitBDg0E7QSiCk9wXENwoPE8EVqnROj3cW6sHpfaw32A7oS2h6m+wtpYswWs969UuxrsFwaREWSJi4sjnFpFqaV3tPK/4HKpHyqPgSoXydEBXyOByujSa6NVtpDNmwXDpYwvF1hNrc2ZJpu2/qLkxy/8aM2FRSr/S+2EoAVkgEBz2X8EdaUyBGbCyCdu2sP4pZTaBHxfBCVhXbmCe4U/ig5RjgU9Z32Vx8DXBQbitsOg0sfnqjPQEOwXtUM0HloKqe2Viic8byDkRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qkUC4yMtTty7thHJCQp9F8e+5bYFttokNaJjNG8fW4=;
 b=dVqF5J4QUl4JfxZKTLLa5pbln/EQIFqV8eIGj3bwUgfLizUsHBxj1DXzFboxoEhiTc+qv/BcJBIkgmdXuiHyo6FLgPLkgeQdqRlrh/MMdtBvgmi1vE48hXfWj49bqjtQD5DF05+8BdhKLjqn774qk6WPSKguG/3usb8SWFK905lVJ+vNWSVgTbdfUhT4be1BcXHrGyGF0//hDqcHjF8HyMxiMBoNfAyIm5ar2OqIJuhEROvTPuF3Tf/YU+qAlnljRr/a+jfwi1fAaMPBmaAC3kQMg6ylBZvqTtnArOPt0qboHwfi/RjVp4VR7WNl2znahLM2cqfeWgT7QmesiVrSdg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA1PR04MB10360.eurprd04.prod.outlook.com
 (2603:10a6:102:44c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:42:42 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 23:42:42 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Stefan Ghetu <stefan.ghetu@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jason Liu
	<jason.hui.liu@nxp.com>
Subject: RE: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code on
 ARA240 device
Thread-Topic: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code
 on ARA240 device
Thread-Index: AQHdd0Qo6jFaCx03AEijWPceLGdksrc0fCyw
Date: Wed, 18 Nov 2026 23:42:42 +0000
Message-ID:
 <GV2PR04MB12019747B5A1B5A674846F4848C7A2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20261118100406.600995-1-stefan.ghetu@nxp.com>
In-Reply-To: <20261118100406.600995-1-stefan.ghetu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA1PR04MB10360:EE_
x-ms-office365-filtering-correlation-id: 2fec5cef-45c3-4dec-0940-08df45cda36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|261026140227099003|261022105027099003|38070700021|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261021121427099003|261102123227099003|261009223027099003|261022075727099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6RaV5gWN6o8iUWktpH2BffXrbcCbMO93lDNngaRnZEFWhsLWPgiAPp7KlPwavQOkI2H0ID+I5t0Bw8pRgnShYsqPAXjff3rq0OrIfyXmC2+RzRy022jPx/LgEkd2rJReIs7TzpEeyaXhGcAcvRH+uZodD8/0akkxyBcffvYd1Qj1DA0+FTik9IE+II3bM0P6VsXqqc3wCsDPJpp/Z1A1r/Z5xFPYfLc8GJaXxHnwmz6LRNdSNbagMskHGaWnY80vqfEdzuqB1EIfmNhvYk7A91QZzL5aGd3xwZ0piOY4lZh++/A6wsnOavfAXi1gI8ryfd+zSRS7+y9AqnL1LKFvhfMcvSgYxLQdaYrMAVQCG6TG/sIILd73xoehwXq7sRUTHcTpKkPPaSmlvqzt3kkSgKOFw1uZodI9CJo8YxdnXre1xWg0n/xd1LjhmClXDhiHv+u4XNDB+sQMEdme983JYqmAqj9mRjj2XqsXP5nL0bbATIC2fc+boKQZwFPHp9Lg6V0P6x0y36d0S9qYoZ34nQRHyX5fC8086N3/0khojL7r+9TkTWgSTj6EA5TpoHl6QslhFmvHh1nTZihsMeJq3wLJ+ajNh/kb+IgDeGPgUGnXI7a5HgtvqOdepVrOYMz09aZ+YLs02kdSSUe2yA8Oe51yIQnK07gMYG0V1qKV0MjLiTl7SLO/PBc7FkxV/YHrsreHUnSR2KPy/1BkHlQfzd/PQTMVVDHYtUFst8w6E5s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(261026140227099003)(261022105027099003)(38070700021)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261102123227099003)(261009223027099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YkDUGfmBN8HZ2ld39FKVP8q7OOnvnRgM+nq9+MonYMvpQZjIX/Grr91bGTkJ?=
 =?us-ascii?Q?7iPEyAUDpNypGioALXEp+x7YicH0JgiDVhRx0m9OccOBV3Sz92we0GqmBfpE?=
 =?us-ascii?Q?acanQKG6wajttuWuATcWct1m7DxQSSydYnLj9fX0FulAp+XGKgTN82825lSD?=
 =?us-ascii?Q?iL3JOUblaBfD2xKE0on1UXFhCu//Tu+As/vnPoCeEp+PKr463CQPoUEE9UFI?=
 =?us-ascii?Q?NuSr3OUogQ8RDB9WSwiVjiYZPI4SIaNwYBJzNshvcUtBZ3UFPAdXJUC29wnk?=
 =?us-ascii?Q?284apMoDfjJZiYlpDKwz+N4hWzR63Rc+Oxi3LUXX+N+hGZbLHqv0WSw27Iw9?=
 =?us-ascii?Q?2B8bm19NVp0ckom7IXNyc/0YrJGDHC9gpMKxdH+yZgz4DrkoC2FwaKNfWo/w?=
 =?us-ascii?Q?bfT5od2fBDYEualfWwabQ5hIZl3ip2sibFQdojIpBdWWr5adS7CycIkLe7li?=
 =?us-ascii?Q?yLGFudw8Ub3NLYQTnETXEXFYI6M/lAdSsGDOVe9YUUNCcG+PFgp5J6vvoNht?=
 =?us-ascii?Q?36AW61VmwGuxUcm0JyCE+zjp7yfSCOV69VCt4xYKxWbzLJaSai2DZI2+5eSj?=
 =?us-ascii?Q?stZUbc6ShF0S2OvqDn2u2OaGBDZ17IwsOBgjWsKxWbVK1eQchOhhHWbyqY7k?=
 =?us-ascii?Q?i1XxO9EXg29C9pEoz3qmTNl3hCR3eg0WcQo5oJS/XRZ2wOCbf/2JTfVZKNON?=
 =?us-ascii?Q?s/1APzoqy2tGy7dszbfxCLEgGXiMUaYnEFjperTysnOJd3GcYG44LSZHBNjd?=
 =?us-ascii?Q?xgWwWhR1McgK/WVkTI0gH9PlqMWwbIuQn32qkppa8dYtDq0JqkdG9IcFbe2J?=
 =?us-ascii?Q?/+YNhjyJIf5CPfVVkGcg5oUuaWVfrbUfpE9M6I6RYahjpo3wepOWM+al1RVe?=
 =?us-ascii?Q?DdBrZFbQo6w2YAWN+Lnpu4oc3IuHGeekKNZ3nbT1U6qlxtBeEYBBmcYtG8sM?=
 =?us-ascii?Q?OBO1ze4cggCtKY5xTHLmy6Q0LO6LaFF2+LgkppWPLopuC/xH49ANU0r8ZeZ9?=
 =?us-ascii?Q?Bwd6mSGOU9kY/0r4qcHrP03MFHZI1bQNFaLAT2w93uLImmRNfpfgZfpm63cj?=
 =?us-ascii?Q?wV5ZOGoiYJYQ2yoVc3k12CL4crmBp+8Zu/IpSanPk2PZgKqzIvZGprLb6+rh?=
 =?us-ascii?Q?tI1BItZBkt6ie9DPH/BylwGV4z+pusaW5B6ggj0wsdD9uKEcCzYbqDAPvdN2?=
 =?us-ascii?Q?t0VTQKacyZH7cQrxoJIOniGEvDPZWyJ45gORUFvKFm+coZk+EWQoNDYbY4QN?=
 =?us-ascii?Q?fyev2Hq3VweA8J+oq3RZ0mNrLc2bRxpKC35wS8q6GQrjyomPFEyGHXP6CKL6?=
 =?us-ascii?Q?zZ9XeZEumKZLR7JlsBOScn1OcOcy7zJIW2puI919KEmBGM/xnmjh1EqaPTe8?=
 =?us-ascii?Q?eS3/OrO4kwPQ+83unAPKqh41aMFBqQlM8lQaH6JoleNGxzPpGAReg2pghzai?=
 =?us-ascii?Q?SoZRJtCa0TuUeggIdijDFpc6nY4sOEbzCDhqXdypw6XcMAPlziX8fDqOdkbX?=
 =?us-ascii?Q?zY3GHeXCazXnehI572n0Wsn5cQ4EXRPN8UuMdNvFAv6V45hiVS+X8RPKDdpM?=
 =?us-ascii?Q?fSE5QoHIYDjkyz0l7ZHzwN1goLNlRWhZmAblfwZU2rVnzgYAemkcCHgC+TBN?=
 =?us-ascii?Q?w9iw9k+3nocqZL2cd0yKNBv3SU5IUkSDvQZiFucadNFYIdEgTWVNDAp60XXX?=
 =?us-ascii?Q?NWKhOYVL1VCOjhgDiRHXebI0xD5bjy+LkyIeW4kG/gefjkvc?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fec5cef-45c3-4dec-0940-08df45cda36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 23:42:42.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPkQ07fXy75AY48z3E/Sl83tDhOvMk8huuOQE9uwPXOlJpG1L6sx432TT7DBDs1fJbtrrFt3FFNAzlkeBBg9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10360

> -----Original Message-----
> From: Stefan Ghetu <stefan.ghetu@nxp.com>
> Sent: Wednesday, November 18, 2026 6:04 PM
> To: linux-pci@vger.kernel.org
> Cc: bhelgaas@google.com; linux-kernel@vger.kernel.org; Hongxing Zhu
> <hongxing.zhu@nxp.com>; Jason Liu <jason.hui.liu@nxp.com>; Stefan Ghetu
> <stefan.ghetu@nxp.com>
> Subject: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code o=
n
> ARA240 device
Hi Stefan:
Please reformat the header of this patch.
- Get rid of "LF-xxxxx". You can't send the original patch directly.
- Describe the exact root cause why this quirk is mandatory needed.
Make sure it's aligned with the requirements of community before sending ne=
xt
version.

Best Regards
Richard Zhu
>=20
> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> The ARA240 PCIe endpoint device (1e58:0002) reports an incorrect, byte-
> swapped class code of 0x000012 instead of 0x120000 (Processing
> Accelerator). This causes the device to appear as an unclassified device =
(class
> 0x00) rather than a processing accelerator (class 0x12).
>=20
> On ARM platforms, the kernel may refuse to assign BARs to unclassified
> devices, preventing the ARA240 from functioning properly. The device cann=
ot
> be initialized and remains unusable.
>=20
> Add a PCI quirk to force the correct class code during early device
> enumeration, allowing proper resource assignment and device operation.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> 3d92b99a49238..fc95d87d4af0a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -559,6 +559,18 @@ static void quirk_citrine(struct pci_dev *dev)  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,
> 	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
>=20
> +/*
> + * The ARA240 device reports a byte-swapped class code (0x000012)
> +instead of
> + * the correct value (0x120000 - Processing Accelerator). This causes
> +resource
> + * assignment issues on ARM platforms. Apply a quirk to force the
> +correct
> + * class code.
> + */
> +static void quirk_ara240_class_code(struct pci_dev *dev) {
> +	dev->class =3D 0x120000;
> +}
> +DECLARE_PCI_FIXUP_HEADER(0x1e58, 0x0002, quirk_ara240_class_code);
> +
>  /*
>   * This chip can cause bus lockups if config addresses above 0x600
>   * are read or written.
> --
> 2.53.0

