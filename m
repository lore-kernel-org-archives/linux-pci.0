Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795020008;
	b=jzjh93O6PtM+8kU1Q9UE0SqIhv87EqQn0oiz0VIRcN1tRPRNuXeaWsRWT/KTLAX1VHIf
	 buxqKxWEAXKYfLhXONqt5ZXH1gLzYIF7PR2aTDVFWRRBBXKpHSaEAN9WrQXLbXehCgsv9
	 XQ624F4cOuy6xKBI84z9ylL/Ybz0OoQWls3eC6pBhN31+iqSJtbetBHXeQZLonTQunh9J
	 cbAtikIFHbBDnqcYhIrChANNBUwV3RvZu4C8jCirvuK6qSRpnapoxl6snT7jKf14HsIK2
	 X0ZJmaRBADIflSU47pDDU8Kbimknw6hJwpigqR0VVCgNR7nhzi6Qp5cIf2QEuhHaxWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020008;
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
	bh=BQ/sGL2X9/CUd61lkn5CQuzPYqVupOTSIvCkxbGK6xg=;
	b=Rdn79QR+HUmEASSkQd/LleGUvZ3YhMNLvS5fwFhTGny68YRJGihM147sNonZS2A0m3n5
	 Ok/GwPDp7hSmCO4dvdc21mTIL6sKHiRW2vMYiBjQNks24buZn/IU8Ph4CRtbIeArXOWar
	 Mnl+OxxR5gQvl5OwrKWRG3lm4STyuT69doao75Vbf23FWPjg02iyiRxumlitYHLtc70QU
	 HLkuBCTYdysEF6kDtQkKdv13VflBdkm5ooRq3Gq3bunTFHiPGN9T2BePQ7qJOs4Y4DKdO
	 S2mCNDyHv8NwqDLi25ZHQlVx9itbCyZNnEmV43OycdYef5BEr6BTgrmAdDAPlJrs7gA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lpe8rlgx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B9606A32F;
	Wed, 18 Nov 2026 16:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3B9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lpe8rlgx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIGcWnunP21xmb32WXpCCQ0CSTrUtqt+covPoUaTo7SmwLJShIHB1PX3ZEuaGM1qU5CPakBS9LutC+z3hdNPZJyCnhaYgAUiJaxNJ6RwMA5SJpmwksKQRTUc7LQNX/U3kCgJcdi46zc1AiNX5+lbVYaUn99eUtAMd0wQNZOlnpBRWja1QLcmQUhyVAIWpXQvYmgz1qaleky/gYzLylKoZF6KGxp7+JVyGW2IXdiKTeXZd15C9WNCsiTYXQWLJJQIQqoCug+Fuf++iCyuA41LWjg+DwuG1TcnsVKad2SiPUci5my1ulRBqMCW16N11KKLXepK14q7/+il5hjdfQt5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ/sGL2X9/CUd61lkn5CQuzPYqVupOTSIvCkxbGK6xg=;
 b=XXqp51Pk7Rspa2EZdOwAmREhRCkbiMvOKP+52AQv4ttVuG/LDy4ADGlkcb+f+eidDatbR8EhiQude0cMXNXrZ7ofEQ5TvLe702+VUv6n88wRbe16L+FfH8lqdY08a11ujzL3u84kht2kM8ojZQE0BdAOwh0OjujxzOnpnw2xYATsw5dn0YDnuDxcGT/t27NmiNvb7ycKwQdkgsOxsXLi47YfU+LkWdx6KtG1xrj2BpnC5dn70GmTfAgyNshN70Ac7tRomC1mAoaQXtPVry6VGjtn8EmmaRTmsqWmV94UOHBr6OoIwR5+ZprNDIvrkukc0lwoI+0IVprufCrxtzjRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ/sGL2X9/CUd61lkn5CQuzPYqVupOTSIvCkxbGK6xg=;
 b=lpe8rlgxqewLgbAk3RQ5KdWp0xG+Xo33mZX3hgTlXXIZICC2i5vDdqsvjsar5PyEVrwk5DHlJy6wc+IM5PeoRjnUmm2eV70FFXDzjG5E7qqu0lh/1mc+4HUbT9e/9aIHkI65LYZ0BL80QLfOtkSbMkWgwt7wb6DDr3ZJIZODkVT+P/57HVdS6S/Pgd85dgm8RlFp7Ofhi+HCH3R1hThRHX2HYOrdfuoWRDDbjH1Rl7E+fqvQUSb+9cKM2pqV3Z5aPTZoOjMEct06X3epUogT2gOdHW86KeWHfQlyJjg6BWTF9CKwGu5CQ3T8m2kVi7/fyiE5e59CW5T3mKqDF4UGXw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DB8PR04MB7004.eurprd04.prod.outlook.com
 (2603:10a6:10:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:40:03 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:40:03 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v4 5/6] arm64: dts: s32n79-rdb: enable NETC IEP18
Thread-Topic: [PATCH net-next v4 5/6] arm64: dts: s32n79-rdb: enable NETC
 IEP18
Thread-Index: AQHdc4ijIaPnwQPWxUab+PBDd0xAk7cycPyAgAGZbIA=
Date: Wed, 18 Nov 2026 16:40:03 +0000
Message-ID:
 <GV2PR04MB1174068076F15330D997525F1967A2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References:
 <6f1ea6caef6ca01c9a6384cd1024384d31848c53.1794581338.git.claudiu.manoil@nxp.com>
 <179493091171.3136.308017869378286942@kernel.org>
In-Reply-To: <179493091171.3136.308017869378286942@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DB8PR04MB7004:EE_
x-ms-office365-filtering-correlation-id: c234fcc2-3bb2-45df-f4da-08df45929847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|6133799003|22082099003|261009223027099003|18002099003|3023799007|11063799006|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 bzRpG6c2C0r/iKjIpTXLGc9CvpfFruUpq9ZJDmvVbumF8jwmd7MLz/WCppvOieUWnxeL3eCBJ9YyKhXR+fhqUBhIfcq/iXLqEl461HVujSb50XyVF1zJNQ4eCeO1hebGI5kH6pigs67hWDivsZaTHRVCCHTTOWiUBWl/kgWSZsAxiU+MurazYX5xtqXMeGi1e5vsN6Ikj6xKNJ13jS8hqkGWB4KUezSeNXlsUMba16DtqMcLCt1Y0VwXC77F0hGDzDyUKJ8Y7/pwv5VGiB2cJ5GHgDfhbrs6zaJ1ld148FBY6Uy38C4wvt6ijHVixMOY66BRkZk7j2SQqJKFtzCe02DjW5+17ch8A5DFIX1ineHG0w93qbyWwyKr4mkebMbOjlgG4XGwlH9eUtVb8ZkU7XWorj8bxW37Hjhiaj5FGxY+wpDuhyQH3fK/lmw+OKUsEalRg7UdXhbjGYcx1t64dK042dHwfT3KhBe6/d6Xeb/6UUlyLs1Yi/6gSuA/yBdNpZZpYCTraEVdqRxr6yNqz5r1YQumGq9e6BC99ICYMTrVfbMYzzx4eUNtVicsIG9OgwRHJ1fiZkKHzKjnZrs53q9TFCc12yEnUa8eQl62Skwjgph8UW0El0L9D4Dtp0uHiVG/Of6mgWc189p977TEPqqxoGR0TLBwD3c/FIIuN3OWVY4FVNcxpyxuISM47OM5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(6133799003)(22082099003)(261009223027099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rv8oScJ1FKEV5kGYdURaWCZNUdcBYNLSbbQQWkmSkfq8H/ZfWBMKnn8N0xnQ?=
 =?us-ascii?Q?NAHlYuxC/XIiLda8TQk8WpWkZpG/pjS1b90+4eEreDvQ3oHT37ZD0s2PC8+Y?=
 =?us-ascii?Q?PXU/5id8xiXc0r9IqjF83mDAmHr32ezvKIz2HJ09azM1/Y1XsC4NTAGFkjvp?=
 =?us-ascii?Q?7lGiCZXoGsoahzRBB4FUhcMCpJr1YjLagAGaFiKsMVGvUbgjNjUXboyydlB2?=
 =?us-ascii?Q?zB6+jcVIkwxj8Ajhsp+ckYx6w4f2tO8NxjN1U2NNaH4KvzgBqMmXE/GNPyjp?=
 =?us-ascii?Q?LEgK9FeNqE2Csi7XK1xyTcsxrNvsp41HundxaHSrmZNSoNRSuoDnQ9cqf3nQ?=
 =?us-ascii?Q?dMvrKEn6vxKtXnIJPVICX1kZv/wJdMTT0eEy/TrXT997wL13ngOlGnUwF8mU?=
 =?us-ascii?Q?S3dkhSjurjptrQBXJvSzN+d2I1xq3WqSQ5knjq293DChMoTie+s/Qc/b5Rtg?=
 =?us-ascii?Q?MuXRAkqhWCr/62zSL0R0z1vqIyRz+O9i+G3gTVsV0W3i/bWHxGVMCorcHQrX?=
 =?us-ascii?Q?3k6o45WJ1loENiLWMsShto1/50dcb0833ULJIp60j66LXd/TFB1/XlvUOz5F?=
 =?us-ascii?Q?XjuqRvCcaMG9UZRJTa6Ci/GhW79eBUXMm8YLNc+c/T1Zc7Yl50PHoIPOpkfw?=
 =?us-ascii?Q?YapUh//3MRAkjHbC08I6QBNC9Nmaq9mSFMOTHYzi/oTH6WhJD9Ut/vHXQfIm?=
 =?us-ascii?Q?5gEZlmVSo/IOyEeDmVjxyjYn2EnNij2SOnqAtQGIggwBHCetGwcVvib7pqh/?=
 =?us-ascii?Q?CucJ4uwWQYE7tlCeii0D9i79qA6lteSG3/5d5SYXK//fhCRMueZAUrBzm9BI?=
 =?us-ascii?Q?iMJjThz6mp6OaPaD1Bat4oYBMT37ckVTKXAqUAWBPDZL3jusdZLow4UVFmS2?=
 =?us-ascii?Q?0+bKNkf45UaLrMZ4dXs0i3OcjWEAkejZcCIwyHbK/tMrY8SRZbvJiclsIYA3?=
 =?us-ascii?Q?IfzkkOhg4WOMGn7B5ngaTwBeYb3vwPPAqYwd/GHQKt05kadtl2ZxiZvXK61V?=
 =?us-ascii?Q?AnYu42/UfLEak3Nxi8IyEz8D07mf/BcxMkHGEtmmJwjhlDT/P0iLfQAUie6C?=
 =?us-ascii?Q?T2Ccfr91+xfoe0qNOPWW0gJU9YU0kt6tvwzVCa/QdUgxhXQZY6Jzbyn1l1i9?=
 =?us-ascii?Q?60rFBdClLqoHn4CJA8q9Q8Rxslnss7MhmkM6mOJWNNgdPA7q+sh8tGxGmAa2?=
 =?us-ascii?Q?+73zUMmnzpBBmDr/e5xvKPeSsfNTMnzdjBqJAPk51Xpjo0wHpQEta46LOJYi?=
 =?us-ascii?Q?mOo+DTWd/ys1y/gsFri0dPqpPH3iGoiON4VlNs4V6JlZUshzSQJNAAp+se6W?=
 =?us-ascii?Q?wWKomi7buTfQqVsEuNqEnHcljzoQC8MuC2EkxNZbpzJ1KIyig+n7Vr/txA2X?=
 =?us-ascii?Q?0C9YkeB3loTQTGWWZZZ7Lc51RakMd0ci2P2KW/FrdRhw0hClqlsDXbg3PE1s?=
 =?us-ascii?Q?bHE7H+UAFG2zTO8IvIq1xocANN7gHYmWl3EQ4gs7bbzrozJv1jVE5OcFRnXE?=
 =?us-ascii?Q?RF/w98+OKm7Vmwkcp0Yz1GJ7t5GbeGUM7XkfIGFDVH9x3owHNb1JS6Cj1wRa?=
 =?us-ascii?Q?cZFTnP1ShL/v4/ywD0ZXPwf5No9X1TI/mVOJyZX/w0x4cFzP9vsL7QpvU9Mm?=
 =?us-ascii?Q?NVIbZaqTzXv3ji1Lb6lZZmlkvzGZERKo9e7Bh2hDvwOPfR94RqIWYk1rh+Fc?=
 =?us-ascii?Q?oURWXIX0tMg8JElvgnOm+qhPgTLsRKxnPS4SzAdy2O41qv3YGjPVwy5Tf9EK?=
 =?us-ascii?Q?Sp5sqVOGUQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c234fcc2-3bb2-45df-f4da-08df45929847
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:40:03.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/pS3P4reiWbkpwSyjJ9qOrxDEY8hAOKbPPLXsUEfM6zxQoaIQA+tRDpaUKGtWwvzCNb2htwDuXF7tAWwxMtow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Tuesday, November 17, 2026 5:55 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; dl-S32 <S32@nxp.com>; bhelgaas@google.com;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org
> Subject: Re: [PATCH net-next v4 5/6] arm64: dts: s32n79-rdb: enable NETC
> IEP18
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 2 * Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] This patch turns on `&netc_iep18` in
>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts so that, per the commit...
> - [Medium] Setting `&netc_iep18` to okay makes the ENETC v4 PPM PF and
>   VFs live DMA masters.
> - [Low] The new `&netc_iep18` override in
>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts is added after `&usdhc0`.
>=20
> --
>=20
> arm64: dts: s32n79-rdb: enable NETC IEP18
>=20
> This commit enables the NETC v4 ECAM bus #18 on the S32N79-RDB board.
> The
> goal is for the ENETC v4 Pseudo-MAC port (PPM) PF and VF instances to be
> probed.
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
>=20
[...]
> [Severity: Medium]
> The commit message says the bus is enabled "so that the ENETC v4 Pseudo-
> MAC port (PPM) PF and VF instances are probed". Does the PF actually prob=
e when
> the kernel is built from the in-tree arm64 defconfig?
>=20
> The netc_iep18 host bridge node in s32n79.dtsi has no child nodes, so the
> ENETC PF function does not get a static of_node. For a pseudo-MAC port,
> enetc4_link_init() in drivers/net/ethernet/freescale/enetc/enetc4_pf.c th=
en
> fails here:
>=20
> 	if (!node) {
> 		dev_err(dev, "Missing of_node for Pseudo-MAC port\n");
> 		return -ENODEV;
> 	}
>=20
> The only other way to get an of_node is of_pci_make_dev_node(). The last
> patch in the series, "PCI: Create OF node for NXP ENETC pseudo-MAC
> functions", adds it as a final fixup for 0xe101/0xe110:
>=20
> 	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101,
> of_pci_make_dev_node);
>=20

Chicken and egg problem, both the PCI patch and the pci-host-ecam DT node
for IEP 18 (netc_iep18) are needed for probing. The decision was to keep th=
e
PCI patch as the last in the series.

> However, of_pci_make_dev_node() is only built with
> CONFIG_PCI_DYNAMIC_OF_NODES. Without it, drivers/pci/pci.h provides an
> empty inline stub.
>=20
> PCI_DYNAMIC_OF_NODES is a plain bool with no default, and NXP_ENETC4
> only
> selects OF_DYNAMIC. arch/arm64/configs/defconfig sets
> CONFIG_PCI_HOST_GENERIC=3Dy, CONFIG_NXP_ENETC4=3Dm and
> CONFIG_FSL_ENETC_VF=3Dm, but
> it does not set CONFIG_PCI_DYNAMIC_OF_NODES.
>=20
> So on a default arm64 build, won't the only device behind the newly enabl=
ed
> bus fail with -ENODEV? The PF creates the VFs through SR-IOV, so the VFs
> would not appear either. This is still the case at the end of the series.
>=20
> Would one of these work: giving the PF a static child node in DT, adding
> CONFIG_PCI_DYNAMIC_OF_NODES=3Dy to the arm64 defconfig, or having
> NXP_ENETC4 imply or select it?

CONFIG_PCI_DYNAMIC_OF_NODES is not a hard Kconfig dependency
because only the newly introduced S32N79 chip makes use of this feature
currently. This is intentional. So, this config will be enabled for S32N79
platforms only, for now.

Provided same reply for v2:
https://lore.kernel.org/all/GV2PR04MB117408067A4647C476FAD617596692@GV2PR04=
MB11740.eurprd04.prod.outlook.com/

>=20
> [Severity: Medium]
> With this bus enabled, the PPM PF and VFs become live DMA masters. The
> netc_iep18 node in s32n79.dtsi has:
>=20
> 	iommu-map =3D <0x0 &smmu 0xc0000 0x100>;
> 	msi-map =3D <0x0 &its 0xc0000 0x100>;
> 	dma-coherent;
>=20
> The smmu node it points to is disabled at the SoC level:
>=20
> 	smmu: iommu@4fc00000 {
> 		compatible =3D "arm,smmu-v3";
> 		...
> 		status =3D "disabled";
>=20
> No board DTS under arch/arm64/boot/dts/freescale/ enables it.
> of_iommu_xlate() in drivers/iommu/of_iommu.c then ignores the mapping
> without
> any message:
>=20
> 	if (!of_device_is_available(iommu_spec->np))
> 		return -ENODEV;
>=20
> As a result, the PF and VFs fall back to dma-direct and use raw physical
> addresses for the BD rings and buffers.
>=20
> The SoC dtsi commit in this series says "DMA is translated by the SMMUv3
> (iommu-map)". That does not seem to hold on this board.
>=20
> Doesn't DMA now depend entirely on the SMMU state left by boot firmware?
> Suppose firmware left the SMMU enabled with its own stream table, or set =
it
> to abort unmatched streams. NETC DMA would then fault or be blocked, even
> though the netdev probes.
>=20
> The dma-coherent property makes Linux skip cache maintenance. That too
> relies on stream attributes configured outside of Linux.
>=20
> Should &smmu be enabled along with this bus? Alternatively, could the
> firmware requirement be documented (SMMU in bypass with coherent
> attributes for StreamIDs 0xc0000 and up) and the dtsi commit message=20
> corrected?

As already explained for v2, enabling SMMU is outside the scope of this pat=
ch set:
https://lore.kernel.org/all/GV2PR04MB11740BC1C66529A8E2B672CF096692@GV2PR04=
MB11740.eurprd04.prod.outlook.com/

ENETC sits behind SMMU, however the SMMU node is not ready to be enabled ye=
t,
and this is not in the scope of current patch set.=20
SMMU on S32N79 needs some support patches (SoC level workarounds) before
enabling it, since SMMU is a system wide config that affects other devices =
too.
ENETC4 is functional with the SMMU node disabled, and I checked it with tra=
ffic tests.
