Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6A2D879B;
	Tue, 10 Feb 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692958; cv=fail; b=TS0iySCrGC3JcPH1PeBNsspI7C7lE5w8vUihCvEgdEdL+qwj4ZtGEIGnItN0qM5h1H3rlY+ASCNdG9Y9b1EhfvQXUUxfr+INey3qk2BQWDyMm7DvfHDtC01RMlioZVRrT733gUSGGATgqO55GW9LNfY7ArDC98qw4WPs4xlBlC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692958; c=relaxed/simple;
	bh=4Gu95eLjTtwoQm72pxNMXAtA9xqs1u2+enTvZYETqgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlWTIUxvvYj3wX8qvUW2dw8laelC1VpVmYKDu1MFOi4viqoI5nh9+Wx+XdJNtGIewsb2KNHyizrinrJiL2vwk+WwYrij9OHDOmaMD+4zykPVqWMznuh/DljGYSsc+vxrmJ9oGULs4sjXDCViFrKOjC8ZS+EkcAQOF+O9e4L1/64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYpVOINl; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYpVOINl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONPvYb7faIjt6sX9ZHDY7I3vBJb8sL8OGbtqIWrTC18k8zSAUCrxdPvqR0fxGVaxGFCeHg709de1eH4CoezhiTZNPVxi1GeI5AaUGrBUFVQMon3mlxjCR/Qe/GJF1a4q6UQ7OTSwBRyKhZxkhLr30OuB1XqljJFUO52yRds/Uce2OVy2JiMNfMkF+qZj+mD1+VjJQib8iUwxqs5JI1T9LTiD8PRmq/fRi/Baa300n1zKWL8knPHuiHRUJEcj6UUhRA1R7Tw3mZTaeluXPk3JvoKVz9O1sfpPfRag4YgKIA+zGNPiYws9Plqwa2Aamg9N8OoNXpgNwuF5qPjMrJ5rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1qMIQgoLynV+lTH/zlrp9mD6A5yEC628WjfTUYabLY=;
 b=oU8FIJ3aIPa3R1wOro4pBGX0xRqassOQJuD6wApHq3g+ZxHdOAmcpXkg2gi8SW842Q2ijVHhHJE04126H04JXYS9heDi4cA2YQ3lAZcwy54ST9iVB2CLJw6YmYYLt8yZJ4XgZNUbN792YrdCJIgP5baqpqcJzSpkto6dUJ5c7nhyj9D0jnZxRIUUkIauvxRIwB/DxKQ1Y/keXywbErBUWLGSJa3DQlTp9ZKK/AA97OO6xPitRjeXztQ18Q4i1hoxx+sfX+Paa5apV0GQa2c2A0U6vIdV0ZxyJD1E6XxOSdpnuJXSbgNXwGoGqXqbznVcIbzXH18pK1OfGrqWardBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1qMIQgoLynV+lTH/zlrp9mD6A5yEC628WjfTUYabLY=;
 b=DYpVOINlb37yuzU8Cfq4vtc4pcmMiVbITvA0Fl2aele2IRcEWEph/afL/hwXdP+vr0GkOwgtBr6lt4xuNJePMSnz6FEk7lF+Kbvhvq0IrLbJhTM8vXhV8YGgTqfeuMFZ1HCRGufQqgciYv4vrteSbrmFgqa/kRZxxg0+tHsOspnhMpWU/SYB1nYA+IfNQWSQuAdmCIZeqFt71+lthH+ORVzlsTf5JW5fvUAuaKRFfVFatyM8Bhl+PL8LrMAxJAhkd04c1dnPufCl2IGhGNkj7lHUgmlrcLn+lYPry7QWQBifnyWoSTNCCuC1XvGLSrxPqSBFRJWVJEzUWTGokmd5Hw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI0PR04MB11938.eurprd04.prod.outlook.com
 (2603:10a6:800:307::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 03:09:12 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 03:09:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "will@kernel.org" <will@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 02/11] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V4 02/11] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHcmZ1wulbLKZisCU6/hNZuvGf+JrV6kISAgACpu9A=
Date: Tue, 10 Feb 2026 03:09:11 +0000
Message-ID:
 <VI0PR04MB12114013DF00830F8C9B2D9B89262A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
 <20260209082454.2097628-3-sherry.sun@nxp.com>
 <aYoMb89MeP44xV8N@lizhi-Precision-Tower-5810>
In-Reply-To: <aYoMb89MeP44xV8N@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI0PR04MB11938:EE_
x-ms-office365-filtering-correlation-id: 00bef1d1-9203-407c-a3f8-08de6851c3cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?643ANGM0GuKDC0l/eAbtnHneqvvxSd6OrseDeDjmZ/K3LfQiziQH6iTcN9+U?=
 =?us-ascii?Q?zs4K6qwyjMvNmRmj9L95YhkEMydNpLzH26q5ttvIiVAb6O8uxsMQroNv0Stc?=
 =?us-ascii?Q?P9pwFVefloCzlhXwbl4MbrA2YqiiS1qipbbLDLAdwdtr1atQlHCJ21ED9J4G?=
 =?us-ascii?Q?0DWjuJ9wHJR7+8M9ZvkejouwvEePIMDBeZcPrcPPKZW2X9Onbd0dUIFkrrgU?=
 =?us-ascii?Q?4jC2wVDQffmDwsG5E7s+rMIVSZD1772V4PNXMcu49Zu0aLEy+aNKBl2mvUIl?=
 =?us-ascii?Q?GMCrjj6XD3FaHHP2LEArS+SKGRJBfYDtYfQnvX/zz58J2+vwgunQ194XZHYh?=
 =?us-ascii?Q?SrqkD5dqvEQRrB2NB8xK9COrYP7Gaw6CGf2atYoZn8b4GnCBQODV55ThYV1k?=
 =?us-ascii?Q?Mlnq066IaiAvQai9ITS7TN8y8DXx1JINYSdSJT9NZ6tZ2PCt82E7hBMuEG1I?=
 =?us-ascii?Q?P+TKpLdrhHB45TKgA24WXwgS32kWRJwNRGH0wKqIBE4riMTS4c5tgWKtsO6b?=
 =?us-ascii?Q?LiYRNa6RbU+GmZqdgM6+7n/Gs6Zwldg/j7GhEUWzAxoOR3SJjMHQ/z7gqQEI?=
 =?us-ascii?Q?LHcGHLf5MAXdh2teUNKEKnk5KeDdbNDr3eo3WYG7aGj5A6BldKwYvdEyBoHl?=
 =?us-ascii?Q?YkNln5UBXwRV9Mq4suqviad+NfELAetGoGndACIUlQolzjxts0hCCuic422B?=
 =?us-ascii?Q?pdQB4jL1acu7f2MG5jmIBIIBTV6EDbal/RjZycvx9CxiV7AXSs93RlsZJCjg?=
 =?us-ascii?Q?q4iPyms6xrISZJ91E9tlJPvc5vys5KRW8iEWabgvWZreEYMbPd1G+RNIz7T4?=
 =?us-ascii?Q?D2yuxo4SkJ0pamzgwCBrby0SE887d6HDrn/pwlb9NPJIUKbQAUN/xIUfc6aP?=
 =?us-ascii?Q?Yq7FXDvplazD4QfUzJd3l8CGin3dtSAVDb+CBuCQUIcMl3QnzZU+UTB7Q3TB?=
 =?us-ascii?Q?hVTj8M4O+SuIXovKogAdgfno+5tWTBrvxaMr30jU1iRySG7QTeuJkYlklB/K?=
 =?us-ascii?Q?qBEcRucJ2Pv3/naDnN2whVOgKXS3YfMJjJMVr0U3GunPa5RjT029519VR29K?=
 =?us-ascii?Q?3VuUd1dnMVK9ZOtHFJcSK1A1zer9mZGGOvzPKx6HzEkvOCYuxIOJAOcmTwer?=
 =?us-ascii?Q?vSaZ3jpucMdkF/ujsuvNXbifkYHwBZhDw2jmE26Cd2AAOaz15mUj/wTyNOr1?=
 =?us-ascii?Q?1YLrhCieWYDRDhgrdObJ2D+v5tVK1ZrxaZCzANGgYlNOKaXCG8YEJD0jEpWV?=
 =?us-ascii?Q?VkPGkSgN1wtLBHe567MEBTtV2N9A6YS+w1Ao3VMdl3ZWV/psLDVxMyT/R2f4?=
 =?us-ascii?Q?sp3g8qREN9vT+GRT3n+fOuejI/QmYw5EURYdi/NKVVs6jE2RM4byL+gxiHqy?=
 =?us-ascii?Q?sbU+4WvAblWQz048D7w42gGn5/TyCrXj2nKis557y0NV2i5L+hk2z1x+dyJb?=
 =?us-ascii?Q?pchjqQGcu9pMePnwkDlhYg/MTymyjk8UlyFYvC1CwMB5/zcn4cBaXBjxPXNj?=
 =?us-ascii?Q?j/nBedTetb9O1NUjbZybj66EnUNTjaPaEtg/BC1EeuV62kQokSepHfL37Tjn?=
 =?us-ascii?Q?VH6wyzLtK4cS5agZMglj7BLph125TFiualuBOpzFD7qqiyhF6vQ2npGvxEvH?=
 =?us-ascii?Q?fNTDu8dMSvO9gVu/Fu5tUgY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MosjJ/03qUg6H0jMSfnQ++CQgEk/vpem8ZnCeVXoHhoFSg3P1tmJmheOIMvW?=
 =?us-ascii?Q?nnqCPMZvCTCPC4CIXDo9AjGjuDSbWK5zS60ytp9t3JVbRboPv9V0BdUghjEI?=
 =?us-ascii?Q?Qix3KJZqHRH83kTvHo+lcNDH7ChNLu8/Ea/qug5an59ZvY3WousFPKD0vPH/?=
 =?us-ascii?Q?KVQjm6B+kIcfQMfUhZK4DyzHx1zKJbbUXoBDT8t5Sq6ppyPvfls4eP/vpnNN?=
 =?us-ascii?Q?J4JvdELM24rVuhkmqoR7TdQyQ3qwfgGXRlXfA6sGTX9VdjPN/mvyZl7RAFIL?=
 =?us-ascii?Q?u3aHDUlSWVdEJMWGLAk/RZjTmo/dqlajsW4VC2kHPq8DBWAI09TpH5C3FpJT?=
 =?us-ascii?Q?fgDAnecCl4EwDYD64ZqVplM7IMzKBnXGxyVp4o0q7MZ8Rz0djtTbb9I3EP/C?=
 =?us-ascii?Q?aAZhev0h/Gfnh2IlDPoZLmQFzIGiIOH2Aw8Fvr1x2yd2Mr9BRTAlzjJvIOxH?=
 =?us-ascii?Q?X1NrDGF3SjfXyC4H9cXwyDN4vxRPwrUPRz3y0zvCmHkFs6pulLdaSfKE/jtK?=
 =?us-ascii?Q?obgX6OGX5qYPFY2CpBFj/uUvuUGjht5179ok16d7ZQRuaenew0RzoeAoQOB+?=
 =?us-ascii?Q?o+2VaYwGa2dMaUvXBM9Viblk6gGi2AgEe4zTMVGL8Y3wuoONmcPXb7XP7VM2?=
 =?us-ascii?Q?fh4nrzKpXaHv0cG/bN5PzO6K4AGc1OtXHhfDGGJK0CthxwGqsQekcRrpFX/K?=
 =?us-ascii?Q?mZJI9n6ybPFp+EkfhfqYR1u8FqB0V3euUlSmD3kF7AgKW2WliENPd+Aqb8Xp?=
 =?us-ascii?Q?Hul/KsISfjmNvSb7oPQtY2UTeE4VY4zL29q0BHZJ6GPaunhWbw3w8sl/Hmg7?=
 =?us-ascii?Q?ydEjH5CeNqX/jFGzAeWyY1TJ7Ac59rZg6y+hDtjgjvOj+cFf1X3xXu829TF0?=
 =?us-ascii?Q?igUtgrutn58rEYA8mF+5WZRL/V5BtNseXIQVUd6tI4ANoJKkM6Q56IDcpeAi?=
 =?us-ascii?Q?OxYFHAfavRT81JADQpfFyUSixYSc/fhSLWlbDXiVlZMwoKJ+4roAap/E2dgd?=
 =?us-ascii?Q?h9rFkIrKrtQkWj7p88ZiCzZAN9+cdqjfrKt4hEumFhZevyRwnTzybh/Divfn?=
 =?us-ascii?Q?WIh1dAETm3Q9tBdd+z+7zOmYOhoMeIJSJHHn4tx37zV8zPC6gl6/2zc7L9ob?=
 =?us-ascii?Q?HDHdlQy4ZuKAVabCsIiKUjEnk69+xphBWxGlDygg0n4bgIkDAgSFfk/gM0EX?=
 =?us-ascii?Q?DiaJy7HhA6EWSXuNKxD04mJtOJ17t3hL4WIyaIUf1PtMoKcz4OWAkY4I5lD8?=
 =?us-ascii?Q?W+hb8aQdRQ1Q4URFdsqCElwbYMS9hTocBE6gPokThd6oXKdTGcHsli3w28fC?=
 =?us-ascii?Q?KHCHD0+4nXx+T4mCFR4+DVJyeP1Zdw57cSsdnx1KUhuOomlLltXWxR5PBCat?=
 =?us-ascii?Q?dp/hs1faUQQQ785uUBc06YvPkFCDyDMwTCKqkI8qCqdKzuvWTcYl0urVJBQc?=
 =?us-ascii?Q?Jqcrib2Et/Vt+IQbG8y0dyCfqcWxxoT/wrn2krhnTpin77zpA6UyH775FNao?=
 =?us-ascii?Q?Ue3pEUgSWYzT5oq/bz024eoCEpcP/pecSqv99tHA1jy4PpwHi/iOFGEEv8pR?=
 =?us-ascii?Q?QFXHpULJaJDS4Tt4CChc4x1EujStgt3leRHuz+Tfbu/HKWVSvJQqjxyNJLX0?=
 =?us-ascii?Q?OgUYhWhwHmOrL11hK2fdrart1bWNqKhiOlbW1yTJTt3pwjY27D4UTNs3ONxR?=
 =?us-ascii?Q?Zt43GvO8QDVn7UEcuem3E3puijIwrnUJR2xjU4iZn3xtX0FD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bef1d1-9203-407c-a3f8-08de6851c3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 03:09:11.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESlzT0LxQ9nOCW/r5iNRHay98QvF3OjlzyXhto0R2iUHY8NJSf7Oo3LJ0VuoGwMg9784tXEbi/hG0FbLiqe/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11938

> Subject: Re: [PATCH V4 02/11] PCI: host-generic: Add common helpers for
> parsing Root Port properties
>=20
> On Mon, Feb 09, 2026 at 04:24:45PM +0800, Sherry Sun wrote:
> > Introduce generic helper functions to parse Root Port device tree
> > nodes and extract common properties like reset GPIOs. This allows
> > multiple PCI host controller drivers to share the same parsing logic.
> >
> > Define struct pci_host_port to hold common Root Port properties and
> > add
> > pci_host_common_parse_ports() to parse Root Port nodes from device
> > tree,
> > pci_host_common_delete_ports() to cleanup the port lists.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/pci-host-common.c | 75
> > ++++++++++++++++++++++++  drivers/pci/controller/pci-host-common.h |
> > 17 ++++++
> >  2 files changed, 92 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-host-common.c
> > b/drivers/pci/controller/pci-host-common.c
> > index c473e7c03bac..287e92df0092 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> > @@ -17,6 +18,80 @@
> >
> >  #include "pci-host-common.h"
> >
> > +/**
> > + * pci_host_common_delete_ports - Cleanup function for port list
> > + * @data: Pointer to the port list head  */ void
> > +pci_host_common_delete_ports(void *data) {
> > +	struct list_head *ports =3D data;
> > +	struct pci_host_port *port, *tmp;
> > +
> > +	list_for_each_entry_safe(port, tmp, ports, list)
> > +		list_del(&port->list);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
> > +
> > +/**
> > + * pci_host_common_parse_port - Parse a single Root Port node
> > + * @dev: Device pointer
> > + * @node: Device tree node of the Root Port
> > + * @ports: List head to add the parsed port to
> > + *
> > + * Returns: 0 on success, negative error code on failure  */ static
> > +int pci_host_common_parse_port(struct device *dev,
> > +				      struct device_node *node,
> > +				      struct list_head *ports)
> > +{
> > +	struct pci_host_port *port;
> > +	struct gpio_desc *reset;
> > +
> > +	reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > +				      "reset", GPIOD_OUT_HIGH, "PERST#");
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +
> > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	port->reset =3D reset;
> > +	INIT_LIST_HEAD(&port->list);
> > +	list_add_tail(&port->list, ports);
>=20
> Suppose need spin_lock for link list.

Hi Frank,
I think a spinlock is not necessary in this case for the following reasons:
1. The ports list is private to each device instance, not a globally shared=
 resource.
2. The list is built during the driver probe phase(pci_host_common_parse_po=
rts),
    which is serialized by the driver core. And the list cleanup
    (pci_host_common_delete_ports) is registered as a devm action and only
    called during device removal, which is also serialized by the driver co=
re. There
    should no concurrent access during list construction.
3. Once the ports list is populated during probe, it's not modified during =
runtime.
    There are no code paths that add/remove ports after initialization comp=
letes.
4. There's no scenario where multiple threads would simultaneously access o=
r
     modify this list during normal operation.
So at least currently seems spinlock would not provide any actual protectio=
n benefit.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pci_host_common_parse_ports - Parse Root Port nodes from device
> > +tree
> > + * @dev: Device pointer
> > + * @ports: List head to store parsed ports
> > + *
> > + * This function iterates through child nodes of the host bridge and
> > +parses
> > + * Root Port properties (currently only reset GPIO).
> > + *
> > + * Returns: 0 on success, -ENOENT if no ports found, other negative
> > +error codes
> > + * on failure
> > + */
> > +int pci_host_common_parse_ports(struct device *dev, struct list_head
> > +*ports) {
> > +	int ret =3D -ENOENT;
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +		if (!of_node_is_type(of_port, "pci"))
> > +			continue;
> > +		ret =3D pci_host_common_parse_port(dev, of_port, ports);
> > +		if (ret) {
> > +			pci_host_common_delete_ports(ports);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> > +
> >  static void gen_pci_unmap_cfg(void *ptr)  {
> >  	pci_ecam_free((struct pci_config_window *)ptr); diff --git
> > a/drivers/pci/controller/pci-host-common.h
> > b/drivers/pci/controller/pci-host-common.h
> > index b5075d4bd7eb..2c8df230886f 100644
> > --- a/drivers/pci/controller/pci-host-common.h
> > +++ b/drivers/pci/controller/pci-host-common.h
> > @@ -12,6 +12,23 @@
> >
> >  struct pci_ecam_ops;
> >
> > +/**
> > + * struct pci_host_port - Generic Root Port properties
> > + * @list: List node for linking multiple ports
> > + * @reset: GPIO descriptor for PERST# signal
> > + *
> > + * This structure contains common properties that can be parsed from
> > + * Root Port device tree nodes.
> > + */
> > +struct pci_host_port {
> > +	struct list_head	list;
> > +	struct gpio_desc	*reset;
> > +};
>=20
> I think it should be include/linux/pci.h
>=20
> struct pci_host_bridge {
> 	...
> 	struct list_head ports_header;
> }
>=20
> So all API should pass down struct pci_host_bridge *.

Ok, this sounds reasonable,  will try this in V5.

Best Regards
Sherry
>=20
> Frank
> > +
> > +void pci_host_common_delete_ports(void *data); int
> > +pci_host_common_parse_ports(struct device *dev,
> > +				struct list_head *ports);
> > +
> >  int pci_host_common_probe(struct platform_device *pdev);  int
> > pci_host_common_init(struct platform_device *pdev,
> >  			 struct pci_host_bridge *bridge,
> > --
> > 2.37.1
> >
