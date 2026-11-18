Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795020597;
	b=NKAtj9pbHQHnLDKB8mq49WtI7gqqdtt/6MDysEQrQU3rCOJVyNzheGup5PeCwdHuiOIj
	 OtgaVa3Wtah3gEAgozYzHysER6hOXxiWX/Jlpim6Va307K0cmUHbdseg8rNFdIh4VP5jE
	 i2tIOtAAYEBTqCQodPfLQs1PhxEj48742+cj2tI6m00022qh+QLLzZ+NqqxAGy/q8ZjKZ
	 9WWfBaDUfIHlO3Nnhesm4SQXlqyEdNZqrpbRhnVlNNx6pv74r1WG5R1ge+4UETrDagaFv
	 m1y5LzG7alcQxgCm7gtoAd/TIoCUokvAckRmmRBHj172oQs66u8oz2GJRktPK2XAXZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020597;
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
	bh=jHUl6FUSkft0rSAC9VeAIqHIT3NWJxeRdLBgncTeK+8=;
	b=pds9kWtqkksE6O11cRaYvN4LmXeIISZe9AZhdfHMI9KQofl3CnxYfLGerFcE2ZTPmGwD
	 mu8famg83TnPMazDiGtth+3WlT1GWFH0u2g0I4h5WA7Rnjm5JDANO0F4xa4s8BgSUCUIM
	 rGTog4KW/HQQRvRhdUjD7scQ8jzatcZD4t+YbZpddfM/6KfGOcisvc5W//dDpVTXGzILN
	 bOJOAitzOCEvjolGnfc5qbdgkkMcGP4oTcMbsYoFnMyvhpCQg8khh+Sjh2eYfOXCdqiQl
	 JOtT4KG+S6x3sZ2GaEGAJSJRHScPRG+AWETWPMSzD+giGjIuge8W8zrFtuUAKlrexPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ntairt51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.38
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F2606A320;
	Wed, 18 Nov 2026 16:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944F2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ntairt51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEYxCgzFrVKlIK/PGtNDQWRy9PkUSVuQGPIGRhyNNOOmELQEDtWpPy7yISgkOIJM1qUPWhTfRm/TK1KZqdHYo7K4vxg4rk5RDXzpqUO1sjn+7wGWL2NSYGsMswIIm4Jg7YeAqPEIi+R5RvMMK6AEbHCZYpjUVaW2RjYzrNc+g2Yrro2eKptf8Puzed1VVii4Pb6x1B/BKiW+JgZmRSdYgSjRYr4pw/RjhUwWlzXxQ8/w4DCaHvptgQOSXXGiYfGXXdAxINYoR8MhDzsn5wqqcnWmA3R/6VhSE9IRtiXBC9sXEISZbiOxOicQUr8L/IgX4+t1fSNaLD5blhUX6abh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHUl6FUSkft0rSAC9VeAIqHIT3NWJxeRdLBgncTeK+8=;
 b=wu+aYqPKSbCN8wOCIaTTIYmMldRA6LFfMMpp0FmOxK4NMq34SmAmBYZVVVMAlfGpBClI88PjVSWMAjHHO5uoCKPzyZRw84l+Clq9iYB/4lm7s4cy9FcLzuhbRYpSc8iT7Tjyf6z6MxrJPC3RB/veVnYoGg6K9X63BSE8m/AggJUPoBzrJjjJx2Uya6g8Cz3cS/FzWSP2u0kqiTvSjuri30ZqfxSrH+NtpDjlywz0WGGbSx4daicUTH2+EkGiNjD6Xs4fSlWV9i/fYmrGLs8ANHic7BB+sjm4+hVAkYbLFfyq0aZ88GH1K2sZ0tD7OZJeZar6fl9JpTntPaC+s+TMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHUl6FUSkft0rSAC9VeAIqHIT3NWJxeRdLBgncTeK+8=;
 b=ntairt51yOJMHSaYkdSmvCZT+Doyy4tphSb9gQlYl08Kq0+HhrRZpw5TL7QMr+qB8O0QBnyHuMgxwt4Ps28jkztHf8yrsHSt+v0oHAmPso6tlKYIQJGCuaAYkwdM7fC0tfsmPNouF/vTwd1cT3JzAjtxjGDHQfLko6AbKByUKJRvC30S3CVsBVKbSvAvu0JgGBQ6L4KytYd9XDCxtbJ6MlWWchPP1BEjkdWxMtTrPSpjX0sjlRMJTv+SAFpa8CPACHGUADOsmoox6azEoIUYRm2+bEn6jCpUGo5W3KXRBvbzP12uPlF41AXCxUwYy3NimEdyuDHMCrtfIMr5xeUn2Q==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by ZR6PR04MB344437.eurprd04.prod.outlook.com
 (2603:10a6:910:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:49:52 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:49:51 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Thread-Topic: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Thread-Index: AQHdc4l1W45hXljdaUi0k3W3Brgb6rcycPsAgAGgTiA=
Date: Wed, 18 Nov 2026 16:49:51 +0000
Message-ID:
 <GV2PR04MB117403B25990A8A4E558DB0B4967A2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References:
 <e256f380f2f1bc88752ee261101cc83ad84ebedd.1794581338.git.claudiu.manoil@nxp.com>
 <179493091275.3136.9482657927785539194@kernel.org>
In-Reply-To: <179493091275.3136.9482657927785539194@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|ZR6PR04MB344437:EE_
x-ms-office365-filtering-correlation-id: 1b604409-8520-407b-128c-08df4593f70c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|261009223027099003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006|261026140227099003|5023799004|261102123227099003|261022075727099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 7WBmA2uxn72xzldadXeEpiIa+K9JOxeHLYsYU3U5yjgCsZ4jwOIPu2CpVH1Tf2fqOEhfdPiIYMNqoLAlMlRRj7eR4Tvjdfk2U5xbKYzxh5AXboI4JiRv2cYfFqouI/PCuOU70UgXJOmJc9p4eYpqH5ngy3T5lBZPAS+9YQBAKSKwaz18uMXUXPG2iZ4SKZkeNcUoGXWS/9ZdIL+ULfOTV0VzKEuZIZL7zy2ps1Kp784LIu3p63Ob44RYlnvkZnwrHQCTbR57eh2qiYy6SsF1Gix1JEtjrnDOsmdMfVQxuGqGZ2kRPYEWFv/7NNMBbOUZ/7+0zTwgrLLgIgYAh+zExydpedCjqW1ujbXIiq+C6KPAOlUnfso9bMsNhyKon64bN5MJXcMNVzhh3RvlCAUVCLcMDi8nO045Z65iIwnlA2H1+AiOCqe//qEIke5jtM+b2eQkFqoPfN+I5vH0ojnKL91YxXbWCWuRXY9ypO7jJYOkxakIh9nEtd2xa2h31kGpAv1YD01Br5VHt0fIjKuoSmUoR5365SKpSx63sfjIMayTnVusnWxlWYS8aqlx3FPfX+uZqQbqU1PwPd6G4YmemUPfwtBdjuQKbllDHxJ0pANqIg7GvFznDThcLPYvL01RMhuaUb44Jv+Fah3WQdxGTs2HOpap+fAkBKiTe3oyo13HyCg50XaEkffjyDJGnhrq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(261009223027099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(5023799004)(261102123227099003)(261022075727099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BE2S1TW1RMnex7qIHaYjdtyLAt84itVjWejaHFkrohImbQQCjLVd86/wWBoq?=
 =?us-ascii?Q?sS9eDVMHKXHGvV6B+o8K+Cd6+p9z8ooIT8plmv25uDGnKhN/gMftHYcBBmz3?=
 =?us-ascii?Q?OhXZjxTOHNlPQJgpuaj7QIT2L99qNagQyN3YyCrQyoiRH7JN+cAJ9nV1JpVe?=
 =?us-ascii?Q?3/RTUjmW1DyU2lO5mIoXGvltYVAT4BvswkPUGYLSFULxAXFr3PvLsrsjBnmZ?=
 =?us-ascii?Q?WRd2COWp5/b3iNFcQ1sAwdEPJOrxebzVADBygpI+174ldz3t93WzML3OaTQo?=
 =?us-ascii?Q?Uaz+cMCPAeN1j6RuMwS5KDgUuLdjnMNGhpPIaFSd1Ws93XLSIndbsrR4ZKRN?=
 =?us-ascii?Q?uPBrHKKos+lnGpEc8iX9l51bJg4TDEJxIU0dJEQMLO/1yDJ86uCX53N1w07l?=
 =?us-ascii?Q?A/wd79PvyH2U01/ym7RieicJ/PIG7rH7HVw4bfD7pa4wcpbuPXbR4KVhTyCG?=
 =?us-ascii?Q?8tqeflSg8QlUD6M2eVITXryzUBx0nWmcVU1FObzrXnKwlyDnCFxZqlAlVKlY?=
 =?us-ascii?Q?M0oPtZnfszs6MMQ/aplZHHbs8OjHLPTOtHC9XRWrf/Iz/qk+znnKJCKUV60w?=
 =?us-ascii?Q?Wd6DRiVZGQpTQ8+7ls481D10nUS31qrZJDnZ5KudUmd6eb3lUh2APwmbgdvj?=
 =?us-ascii?Q?w4GkYoIBxaoB5iVA9LFDz+ToCzbtbYoqTWZ5kU99mEbnhq4aojJl+HRuF93/?=
 =?us-ascii?Q?ddbz4IPoroSAByLAm5d4SgMJYt2NLhpsMuZz7OJ06TRTbn9O3llPfosFMhm2?=
 =?us-ascii?Q?NrwGZ8mL0GZa515yOkU38jUtcq6Og+Po/uK8gxSrfCIGPYt2U9xA7s0VOsZB?=
 =?us-ascii?Q?iXroP3YvmMhMGnIuHNDEF3llowuBYIHuIfA5Hehhx20diJ7ypqSV04Ivzg//?=
 =?us-ascii?Q?SsTo2pUPki7nCcdK0/1QvQ4YzdPWJ++2oeQOjPP3x9kgUJWjl9o1/FjsZjcL?=
 =?us-ascii?Q?2bKCfDMGWyOnjlhqmEy4BaIrc8w3sTdMaceDly+cjWc5qRiM25jbrdRU5zK0?=
 =?us-ascii?Q?AudH8vHKQZiQK8YmbAGq1hd/V04uYikrGZvVgvbjNl+tvbgw4t7RWkBNBlNO?=
 =?us-ascii?Q?ZcEWGK5ulHBnrMCW7Hsz0IDiNRD0+AUXKm/rWUhLIxVVzbtBfABSN7uoMa3l?=
 =?us-ascii?Q?ECxsJLfBDTgbLEh3SE+hd8uWm+btIVlV0r/TaAvkfwGfNjH7RlE6KGi0BLXl?=
 =?us-ascii?Q?QxrTGmgOAGcDCFz+Q0WsKoJLRy3HhKixYc3prdlnuY+vnRyGJgb2BwJGB34k?=
 =?us-ascii?Q?IbPPQat/xjazY5MlY+ch1IyuyLfV2SyuGNFyRkk5xyEl44vXUzGmEp4wEj0a?=
 =?us-ascii?Q?Z0BdKahb83y/O371o5bwZ8fH0CjwaYhrsdO+iEbzwHc0OiBtFeEjfvnNZZxG?=
 =?us-ascii?Q?CHN0E6dVzUGWA//Bu52AY9kvvqGdpHK5PweMQK+INS1BrhgEdQqpdIAmk/CB?=
 =?us-ascii?Q?rtBY9ngWFFEtp89hZ7wo7Tc7sFmslD7hhdxfOBmrJCcFFS5GQF5044xm3OPs?=
 =?us-ascii?Q?Upovn8NVYqylCD6BsV/VwxlfjM3nzKQYyZrQF9qeI8lepKkluxJUm4XnkGuC?=
 =?us-ascii?Q?zHjUXomzo8Dw8GdpQoWxtxKdkllxK73QoKSYNh1yHz74EPldFnFoKJ4cZezY?=
 =?us-ascii?Q?UZ1EOs5gBi6YYZcQySKz2LgsWwyttZUQdgWHey15rlC6kXtB1kR8vDziv29G?=
 =?us-ascii?Q?gEZpT1wO1lLcL07I/4DMD90DrEKWmj84M0FWlftZ8rbG7qo8kwaLZ8eX3gpx?=
 =?us-ascii?Q?0418ClZuqg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b604409-8520-407b-128c-08df4593f70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 16:49:51.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5LOSoi3hPe5mlp776ecIU6TyDwN9yBS3Y1I0v677AzjUR3cJPvu96l8sulf+UJK4ZvenqoZxTTNXC9/OWGGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB344437

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Tuesday, November 17, 2026 5:55 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: netdev@vger.kernel.org; dl-S32 <S32@nxp.com>; bhelgaas@google.com;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org
> Subject: Re: [PATCH net-next v4 6/6] PCI: Create OF node for NXP ENETC
> pseudo-MAC functions
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 1 * Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The two new fixups for 0xe101 and 0xe110 in
>   drivers/pci/quirks.c only do something when...
> - [Low] The comment above the of_pci_make_dev_node() fixup block in
>   drivers/pci/quirks.c (lines 6553-6560) gives one reason for the...
>=20
> --
>=20
> PCI: Create OF node for NXP ENETC pseudo-MAC functions
>=20
> This commit registers of_pci_make_dev_node() as a final fixup for the NXP
> ENETC4 PCI device IDs 0xe101 and 0xe110. The new per-function OF node let=
s
> the ENETC4 driver attach a fixed-link child to pseudo-MAC ports that have
> no static DT node. The fixup only does anything when
> CONFIG_PCI_DYNAMIC_OF_NODES is enabled.
>=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 7f1f47ea2ee41..71f272d8a2965 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6563,6 +6563,8 @@
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220,
> of_pci_make_dev_node);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101,
> of_pci_make_dev_node);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110,
> of_pci_make_dev_node);
>=20
> [Severity: Medium]
> With the default arm64 config, will these fixups do anything on the
> S32N79 platform this series targets?
>=20
> If CONFIG_PCI_DYNAMIC_OF_NODES is not set, of_pci_make_dev_node() is
> an
> empty stub:
>=20
> drivers/pci/pci.h:
> #else
> static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
>=20
> PCI_DYNAMIC_OF_NODES is a user-visible bool, and nothing in the tree
> selects it. NXP_ENETC4 selects OF_DYNAMIC, so there is no build problem.
> However, it does not select or imply PCI_DYNAMIC_OF_NODES.
>=20
> arch/arm64/configs/defconfig sets CONFIG_ARCH_S32=3Dy and
> CONFIG_NXP_ENETC4=3Dm, but it does not set PCI_DYNAMIC_OF_NODES.
>=20
> The s32n79.dtsi change in this series adds netc_iep18 without child nodes
> for the PCI functions. So dev->of_node stays NULL for the pseudo-MAC PF,
> and enetc4_link_init() fails the probe:
>=20
> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:enetc4_link_init() {
>     ...
> 		if (!node) {
> 			dev_err(dev, "Missing of_node for Pseudo-MAC
> port\n");
> 			return -ENODEV;
> 		}
>     ...
> }
>=20
> This error message does not mention the missing config option.
>=20
> So with the default arm64 config, "arm64: dts: s32n79-rdb: enable NETC
> IEP18" does not get the PPM PF/VF instances probed, which is what it sets
> out to do.
>=20
> The commit messages say this dependency is intentional, because the
> driver also handles ports described by static DT. That is a reason not to
> add a hard "depends on". Would an "imply PCI_DYNAMIC_OF_NODES" on
> NXP_ENETC4, or a defconfig update, work instead? The Kconfig help text
> notes that turning the option on also creates OF nodes for all PCI
> bridges.

Same reply as here, for v2:
https://lore.kernel.org/all/GV2PR04MB117408067A4647C476FAD617596692@GV2PR04=
MB11740.eurprd04.prod.outlook.com/

CONFIG_PCI_DYNAMIC_OF_NODES is not a hard Kconfig dependency
because only the newly introduced S32N79 chip makes use of this feature
currently. This is intentional. So, this config will be enabled only for S3=
2N79
platforms, for now, separately.
