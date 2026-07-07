Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7D2F12A5;
	Tue,  7 Jul 2026 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405905; cv=fail; b=SCeBUBA5ouRXkjk15GrVJ6GLRsKBotXxK1iXgLPlWXF7LNllw3ZD3reyMceKGqyFdpMjbyp0/NH2FAlTFsKfEFNG3lqAgKBKWUh9EHxw/X9YEp3YMIuZj4/3/jkK29W0BPhaUhO+195930vKGDV7MDeIiW743Jm8UZf6chDrNJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405905; c=relaxed/simple;
	bh=nNQ200gKRk42U6qFjyr9UFdwEQxw/PjW4Lif6Kz4ZVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEyAlhqy4xTkh7G2gS2uOd9a7jLQwlnz1LIHIce8RxwkPw/2b5WaNPJkWS49+Dg/mI6OL9dne31FbTgptLs4hpQxfb5QxFyhyxhLwa7mEkMWfokT1BxWM55k9m2+g5rpVzR8Co0MdGuxWlb3ecIeGBCdx/AtZiaSZvY0nYrRiU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BZWOX5c6; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BZWOX5c6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai0llvNccEdETU2J8p18a8exakY6cdGRocO9AaaulU3Pv/cVikdkwUv4MZW6leaTv5BpInIjJ5SNoIOgMRwhSC1GRktUW2Qil9bHAEyt3RnS2d8NDURrG0ZGjkTdT4zP1GUMZ0arcpBweWOqgbsnty2XKMAOKOxN6Uorq4YEKjYyvURuzc7+EfCtPdEMvVA2lawb0ZBe4trnwWN7ZdVYbAPag49H0qDeoNgjT0J9+xWkMSroV2xyeZE1C1lSRiJKLWI5NS7LMFlabhyIv5rFjWijEDyMwXsLxTLvfwZtPs2mYJddKPtRraHd0O7qiEhp/P95DKi6NITt8+VIRWfTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNQ200gKRk42U6qFjyr9UFdwEQxw/PjW4Lif6Kz4ZVA=;
 b=SVqEU+mGNQHa9g4n/QUZQYmCmoSMvnS5+LbxNYVjvL31BMjX1MLvgbftwh45fGC/6Q1VUmuFWkypwU9nqakxVZsVPYj52FS5eYcjKJN4a7jGc4px93nRTY4VuwaaQNgABqIiiG+HnoPcY5CsgzAR9Ik3WuI7Kym4SWDzHJ+z7aKwHM+sPfc+5iTWaa+vAg/Da4nOsavugyZURdY5MPNNgSycb3npn49viPC9CHW6qBOhKypp4lXoLX0s19TvKos6trMvFNBBBuXmOwn8IoH/GRw+01Ht9mInvY+zRHsoJzAlnK9XIf6dezO/pGCCsmRTKRe+vi4aciNyISps5e8dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNQ200gKRk42U6qFjyr9UFdwEQxw/PjW4Lif6Kz4ZVA=;
 b=BZWOX5c62wB8mHYAXiwWmKTq91f2PVx405AfJc3KwD6/Iftqti/89p7u6Q9Ueo/Ux/lHm+HmoUbgzvEF5UOOmlQjj+XBfx9IJ0gMZFiFe2DMO3WYf6WeA0nfRw+StZWDClGEwlDf+nnn60Rv9Zc4+C2gssi827CKfJNhkjC4OYEYtmMiz3KYSEkBv3q6P6cszOq4oTEsQ+95Cf7egUSd8eujYr7W2RSgkqs7kbeB9X2sQy2sIrAjQcsZLnXCqTa2be6VkYN85l+jwO8h5Ln/kCHwW3gWhSpED0Ie6gCLbvwukaekTFKmr8a2USYZAbxEa3E3R6ZBxm1xD6j6fWCNXA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AM0PR04MB11855.eurprd04.prod.outlook.com
 (2603:10a6:20b:6fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:31:40 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 06:31:39 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "smoch@web.de" <smoch@web.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Thread-Topic: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Thread-Index: AQHdDPQZ0wHas+96Pka7gtnungxJKbZhmCkAgAACatA=
Date: Tue, 7 Jul 2026 06:31:39 +0000
Message-ID:
 <GV2PR04MB120193893B395EC33845C717C8CF02@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
 <20260707062250.GA20259@francesco-nb>
In-Reply-To: <20260707062250.GA20259@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|AM0PR04MB11855:EE_
x-ms-office365-filtering-correlation-id: 29bb3213-a912-4ba0-6705-08dedbf1671a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|19092799006|376014|23010399003|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 dgVTWA6Q6hRIh5rPb7h/ctqSjcSB3kFRK0ceEtjDznjKOIi28ZQz1fbmD9BNzUFG8x39pzSqv7+5ForXt85+rHwwmrlo5/byf+D5/Ubg+xVwrcTBmcECq//U3OJGAo/U7zyfvuP+GfTtfwAsQSrCF5YoeM4vpiy2Wn3y59Vj3Uy4pHLzUTUXadSUKhzmNEourfw3T4IkPidOztUkBvqy/V3Y9v+Wt1izF1Ng4fLMAq1I4VoG6/iVp/coqutsIWRjqhbKgsWF/W5Sc78dAQK/Kzac7Fvx7ONX5fDuPYGF/s9OdvSAO217FJjo43pgqvSR9na/OaKVW8X8Oq9/fJ/G1FP9lKcsMXcTzrGrFLwVjhZ/lUUgelxLJHtpP6KFjXDJ0QpnwDb/u5PVjE8o5IsfetA25IfWRdKh0+r2zr/52hmepYk8J/acUyxQqbew4iVO/1yq8QRHvhfW9B7+o+lBnasa6jW4NHZIh6HdwNPaoKurzKQew+wx3WvBsyoQpVm57Lnb6elYUZZDdBK67k4nVXrfFT+olMRnZfMWw+b8IDmZehnRucMFWkpMBeG/2s0ex4Zes767I8uX6c8kX00BaswfUR07pkggOl+jD9FrPqbfb+X0p7POPnhk11wZF25vedB2nAdiNDP9GzU4BjwJFxTYW5JMUPVb8M3RzJl29adHLKrPDuGpiSVcy0K2xENsFnVK7dw8LN/1CY2Ngp5N5ahCZcfDFQrcsZmiAFHl2/A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eV2wNae43pbLxYZpMf5MwvrPYpG0Ct6dTjbzui5Sg+KPP7ApgdQ2DqKW36ES?=
 =?us-ascii?Q?w9FBYEbgLicrQR8Cp+UNj3kENLvAGrafk7c1Skpfdv4iGHI/PIYwDu1bdOF2?=
 =?us-ascii?Q?Yzp03oPNwQXURnWmnjySLweRHoe+8shG+oF9+V5tUqlSAFbqDoAIyOczuEOK?=
 =?us-ascii?Q?PDjibzSVtsz2wdlltPwTHQ+vV0yCdjivd1aLdQyzbabY8JH8tKgw9bhao5iV?=
 =?us-ascii?Q?TB//ORQmO44Jrf8iWAc18qHvmWXYkr+pdvEK0EkfZJpbNmNtDqMhrfA0G6rW?=
 =?us-ascii?Q?cA6QC//DOQGCXbbmf6fJusUGru3lsiomAEFDG6xRK761/39fSH/yAUVcf2+C?=
 =?us-ascii?Q?70XslzRikfBtv3dDPHudEEF5csKLukXAF+6hsGUo1FUwyrTl7DOjGfKw3Civ?=
 =?us-ascii?Q?5iKFEb9hVX8r5oo5rydjsgMUkvtoWUP3OQuUtWBTm3K+qegcAFlFaaQiCjRn?=
 =?us-ascii?Q?nh2UjEGRBpgvSrQBUgLbzWVFJ/nqigP4JqN0m1tiabs3HWsEUkNnA0/r2FJr?=
 =?us-ascii?Q?vnyke5heeBS7Kc4HPr52/dwdk1bhFJxqmL6nM9O4FYKWZVws7Qc0S+RrrfGX?=
 =?us-ascii?Q?qrOESfdfi4rsjfcKqzpRZOXuWtUwBSUjXD1GC4ywC4wfBokBpz8H+8ikbSWT?=
 =?us-ascii?Q?ppvYXcU6/dDw9ijBRFEoBOX4fNdATEEHznY/UqVojL7ElZTdh5t/kNJ/I3xZ?=
 =?us-ascii?Q?W1Z/dH2vsojyKQnjmYZXGEoGh6DvR5lg7PNIOfQFVLxx47xjFUx3SzwkxuIf?=
 =?us-ascii?Q?AVeE7bBzTPUBcNBUm6DrzrXnKHukXrdgmv9jqJVv0SKQFg8zvElfutPb+cer?=
 =?us-ascii?Q?uJWrwXv7AtBamfPFBvM+BjK83IOTANbXTU4ke+GBVYqUW/IY24QogWOv3DIt?=
 =?us-ascii?Q?JU7d7D5e5bq1bBpd0pyAVt4vVZnP1pG1NUefenuSAiiAzxLfOzGDfojH+V+3?=
 =?us-ascii?Q?We8xCoWjhnWfO54znUxiuRDW2f2CaxOLdXhn5v5uOY2Aqw13XxAFaee8S9aV?=
 =?us-ascii?Q?w2IUYpS9mwlVPfGXC+tdj4E/X/ms8RFcpy6PUci7z7xSs49OAbQJfkObwOlz?=
 =?us-ascii?Q?VN+UixZEFghenldELkH80uBFX8cQmZJjwtUNeTbGNACxdWAy84UUuxtz9QpG?=
 =?us-ascii?Q?QpsAV3wJNqCM9jKbdfJoKI3jkDzy32edF20CaDOx3C7zpksmK6LWUowMbVK8?=
 =?us-ascii?Q?Rc/y2WgGI30Hs4l/gXwxyo+Y1yt4V4F2Fb8Q4mzNO6jJmkhEjmki8EEMK5lY?=
 =?us-ascii?Q?cC/1Q1re8h+bXvmXbarIP+X6zJ3eD163hs6lIcTL/LUX6PnvGfsIAtCokoHb?=
 =?us-ascii?Q?WSBv//ZVfJzJabIPEC3FZxLy4IdrRnr9eOk1lMhKVSenpYUQINeevR4qFS49?=
 =?us-ascii?Q?fHwG6ULlICdQsEpCiF8deetbd0WNT53MQIYNB7ICF7+7uBbEEJ6zO9PU62op?=
 =?us-ascii?Q?dSjAAGKTiKwf3HkhmIyq3xdQrTUHFTplBTxeXGsp7CQBYBLAI7CejQH2kvax?=
 =?us-ascii?Q?1PxzP4nlOsE+Kjx6S9nWpOjZRziJRlAAGhA5N210sAMV2+23h527RzK+9UBS?=
 =?us-ascii?Q?t5kIYjGoSo+PrAl5OXKNIeA3RiPK8cGAJBKytKrKu5MkQZBXIvlGdbCEqzHZ?=
 =?us-ascii?Q?Jtn4M4YgCjS7kNQJsAYoUzEoJyQsNjXNyqV7wRAdx7pC2QN4uviYxsXYrKy3?=
 =?us-ascii?Q?lanS94Pl/qYE8yeYgo2lUJeeFo8pjAqEAnjRFcWH4C5nmapxsg70ycEitSAo?=
 =?us-ascii?Q?yUt1PTeBnQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bb3213-a912-4ba0-6705-08dedbf1671a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:31:39.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4h1/lGUcleL2YSsoHpMWcheXZXTyRnXGsY9wAcxEI8ufdc0LlG9IXg8rh8xs/LIuW/AmQtrdyMLyR94FMS0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11855

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Tuesday, July 7, 2026 2:23 PM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; smoch@web.de; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating =
PHY
> power and reference clock control
>=20
> [You don't often get email from francesco@dolcini.it. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Mon, Jul 06, 2026 at 11:06:29AM +0800, hongxing.zhu@oss.nxp.com
> wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
> > regulators") introduced a boot hang on i.MX6Q/DL variants by changing
> > the initialization sequence.
>=20
> Is this related to
>=20
> https://lore.kernel.org/all/20260629143439.361560-1-
> leoreis.costa@gmail.com/
>=20
> ?
Yes, it is like my test results.
Thanks for your reminder.

Best Regards
Richard Zhu
>=20
> Thanks,
> Francesco

