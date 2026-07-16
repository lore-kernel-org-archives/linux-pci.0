Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13892175A7F;
	Thu, 16 Jul 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168151; cv=fail; b=WKWh9iB1KRqejz3lX6pMzmkbDIM4+FPtp54VLvUzo3lVwKxoEvSj9oTdhrei2kgFXX+9OeGUZiwuBgz4OrW8CcKIwYTRam2jym4MNFEFoeJPGAVa5PDZAU1mt1qVOi0/JROsrA7Iy/1ISm0E1j+8c+xmT+bUugEvBo5Q9JwpoFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168151; c=relaxed/simple;
	bh=3ncMuzQxatzHduFjQmDhgcbCCUmFrBqUZnjGpMG4rbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npRm1gkWw1AjfAzkYKT+9uV4KpnZtVHNEIlr+M3tldL8s1KlB8om7Ojipoa4szpOJEp1TyT4npNESSnSEg0NO1272b7RBzfNolLfJrijYP+u1rALXNcixxmLSorR0zW0zYZKCUoSmlMutv+d2bwzmwkrypdZ32LxXhY9O26m1uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ukj05jQV; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ukj05jQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knVhIw5YMYMxk4w7uO28tSeDU0AWLk8MvKANO3xfpacEbbMvo2ufTQyqMldpcIsR5pLlDiNOiKU50dwSmBOfaNjxnw5h9b1u2cVsL1o/sC0OqjVA4KhDq2brRlJjN6ZUv/GUi2PeIDv3To/dHXBdYK11y7qyGWBwIIyTTZeAUThYxuHydH8kwuUgrqpEBWckKVXGaY3d90PSO1EbhW/6w0MmpD31p7c/dEkq9AVT9MlgKwRTOZGcbPzbqVQZDxzOeMpg4TWJ8mfOZ3On95/eJZGdz9YlMhQIUKP8cYxHNvDsYKC2dw9EczrqLccu6TNF+QkmyqdRp1XvfqxONRUZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ncMuzQxatzHduFjQmDhgcbCCUmFrBqUZnjGpMG4rbc=;
 b=IRMeZG2sI5yx5UEAv3lt5RWUrFlPJBAlv0TrDJCel2DqOSseooRM9gIl3Db5Ilrrfh7IcHlZ3uXW7Fc6ITzrY5BOw2qmRLxLHBEcdEQO3rj+pqoFITRyTrxQRo6iGgcj7/xC+3WSN7WlFI+UtA9BLaTEe80AuYbdg5ILSGM/Mf6R/TxbHrBMKFfVeItuIb1yYV5/O2xET69bUyPs4f/Rmx22pCaJoeDh0QPOHT6mln96J8z1/cT7uIWgNzC5eyy6SWEFnEpSvMxUOEnvvMUS3UxpPUJzrXVCJpgm5cqjIhdHB5jiQzEJ/nRg7+W7LKiQmJOZuBHqiPFWOV2Zy5+EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ncMuzQxatzHduFjQmDhgcbCCUmFrBqUZnjGpMG4rbc=;
 b=ukj05jQVHeikvWWNyWuv8o+qqnzxOgWzKhz0COByO6s908AStQdw6JgDNmJMomRENEijr6mWaQYroo8N/Td/fjIyE3q3EhZIestp8OUJ6Vs8eiptBAplVdrP1i1Yp5Qv6AXBql/u+oToENOZopW0EK6jfRISHEdWkHc7SJxBkHMG9aF0J3gZofe6RzyObm0NQ0dHgvv4A8BxyQMlcV7nVVAkidFHxwtc46QbtBsXxtG0mrgmIMBCMDdW2KAv/m0qWWbNBuCv3OZRCTLQskQKmAbUmMcmI1qgV03PSar726xPrw+94QzHvqiwSBzBkC0bO+NxZ15zOzbsDo35eKAcGA==
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by AS8PR04MB7544.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:15:42 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 02:15:42 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Leonardo Costa
	<leoreis.costa@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "leonardo.costa@toradex.com"
	<leonardo.costa@toradex.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Sherry Sun <sherry.sun@nxp.com>, Manivannan
 Sadhasivam <mani@kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Thread-Topic: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Thread-Index: AQHdFLRQqewhn1aJKUO40yds8E4l57ZvZwwQ
Date: Thu, 16 Jul 2026 02:15:42 +0000
Message-ID:
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
In-Reply-To: <20260715234736.GA288957@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12008:EE_|AS8PR04MB7544:EE_
x-ms-office365-filtering-correlation-id: ed65624e-0047-4c45-c0a5-08dee2e0233c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|6133799003|4133799003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|38070700021;
x-microsoft-antispam-message-info:
 hIY9nmmI5s9+DcScg1+JI5xkj5vOxxvvnwNWzoIGcdEF99QsF6NuA/OE7Mnr4qtC2+XWo/n+Zs0TVfVH6ZXnnIr6VinnkwtMQ6hOLRvNHwsjtHFHydN2zgGZcqf6c4utSc0sOdi/glEbz8L8LXN66ozMHKHubm/Ssd3Mr1ohf2Ag/m/L2zncBKVc95X1BE/UbQB/VP6KpYBsM/Uoec3eEJEIr0M8DJebMAERbdXDdAm1vwL+QVR52JPZY8Q5CSi4UZxooOn6y+dfdyhI8XK/1smoP6Hviil/Z2CnNXCqxd4RfELFK2mCid97igsbCbIqwVib7WT8ENP+awVnM+Ipsos5o1YBYIxP1ufOFEX8PguuF9H+yYH2RKBFv2FPcFKM7niVtJ2uTV0qJMfh6Oy2T7z/z2B6kimYXCb3OTSGbr4gSxpdHQ9k+58ReRaERESLknp5aW0kpBgbSykYgeGP+e3eqjMbNfxzz7WQcBoi0Ohmdh7DOMcCfTPsyXS+QsdWlTUq8ZYMe0/sjzLd5kNo0P00+wGYGNm+M7Xz9xWXNR/W2vNGYve0W+ZLttOU3RuEYBtSHEKBlj4X0G13coWVcjDHkKKmrE0gtoHXAbrklBN3UFtOD0knzLSRamFbATuy241EYzaNHj/gSkF+2XBUHo7Z1ETrrUg5ipw4ul/XJ6s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(6133799003)(4133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J8Om5iYTyg0Z35LSdPQemSrYfvNE+yEx++IAmJy5q1WIXe78Kb/CgWboxNhm?=
 =?us-ascii?Q?GdErS/eKxVtwsxc9qrAxvqjlKfGwyzBOiTJZ4GwtkDzoMPTITzNFWQnkWP5s?=
 =?us-ascii?Q?Miexu/yqo/VFAfeM2pFQXrBjBwMP5Wh8s4VGr7Hoiq5+tPDR42JhkUzqKghw?=
 =?us-ascii?Q?xFgJBh3lkVh+7X73Wr8fHydkEEemDj8uYZOlwRQUFRRRk3s7aDFlbUbAI9SC?=
 =?us-ascii?Q?a0A2rKnLh4VE2T5v/qRRVULXhaUU7iO4dtwHDtzVSf74t+uUUKV7SsSelOqf?=
 =?us-ascii?Q?Fx5Ey+LUTHL8QqyHLmAdmG0BP3fMG6jGMuNJH74bWGWbK0aQCuaDhUnlMZ6/?=
 =?us-ascii?Q?3c1tuCwdJzFSEgec2vDlGIXhIYJg4fhGJmLBfJfeFMeaqMf//TzhwjUmH817?=
 =?us-ascii?Q?WKelT4FapbI7bPOdGSN3w0qKg7jYMldnztS+47yQhZA3cn7AwYECzXWI5STv?=
 =?us-ascii?Q?3kwPyTErxCIYuw/tpgs2IxAhrRCycMx5onBpXSviushV5GyXbROO0mStjN8x?=
 =?us-ascii?Q?NxN4gAifFp7QzvT6X+UW+Q6gg15U6vQ9Q7RgBK0VlGSt6SKbpzfKfykeIUr9?=
 =?us-ascii?Q?yJE9QBJTSdLCM8XTvoKp1QdMw7X3F0ecssgAt+VU68vzAuEsCHORgltNmvYc?=
 =?us-ascii?Q?I9PFBD0HMFBZ/LjhGVDMu5NPWfqeCk/kDSLwLhIzNCe4gZWfjXxGkVe5XIz/?=
 =?us-ascii?Q?OUsaMKuVSvsiuSDKnb+mRX7YXhfuZ0E8kn6jP+qCg5cd9ylIIIiT+1VRWkuQ?=
 =?us-ascii?Q?FTN+ENVj9lXlK04m/AMTw2LYjxHNPeHYkp6wgXhdjMIie3qSR+If5vjSEzLJ?=
 =?us-ascii?Q?K6VoddhPwjEd+YZa3pXPc11saF9GCElmzXY96xEjcrLHTKagxcWabp/+ShdV?=
 =?us-ascii?Q?gbVcFISBzcyNqO5aWL/5FuxNYrstCckvcLs7w3ljXcqaSTiVHRQAptpEXpIl?=
 =?us-ascii?Q?GOwJ+ygoV+LA2PRHcJ/3B0clkeF2nyRRU7s4hmOcDJP4liF/sccsgkYfswm/?=
 =?us-ascii?Q?d961HjH46bGA7vGC5wor0RpwtRaZoJYTaclFHV8NjmcjAmLE/6S8FD2OtxDm?=
 =?us-ascii?Q?NSyl64QEfctuORgFfdBiA2/A23P0TkUK9gC/0iCkj17mtKCoXrYTacEZqIQd?=
 =?us-ascii?Q?ndTMomnAh5eoWwxddNdJIgXoGIqhkT43y4ob/FKayldSnFlLHOW6R5qfuU7n?=
 =?us-ascii?Q?axWUwc0+0QxFwjj5Ycu3Pt3noMhpA5TR/bFrIKjtAdtRJTmlrSeHK66NOY0Q?=
 =?us-ascii?Q?5W+eiq+iB+zukeJX/rre2AzSuUjwMzlCqMzTsfr1bdzE3kX410/pycKwuvM8?=
 =?us-ascii?Q?ub9Bs3fKeV7AgCpG8UdVTHcRVm+mL/ED2Ozn79CKpWDX4iUIub4BxYQa7ptg?=
 =?us-ascii?Q?131flawp4cEfIXBJhFKJiPXzAhLsGCKHuruLXuvXPIiiSvdD97s1cFgkVLqU?=
 =?us-ascii?Q?8RduhK9JllBfNmz5zkJc8dFtpzWELacGYIUvv9GSiwE1WXFCJ9wHD4/S15tF?=
 =?us-ascii?Q?yTh0WwrBQ8GRC0npYWSwNmWhslo3/SBpMquWiSfl/55AqCphD6O7zTsFkXpz?=
 =?us-ascii?Q?073r75zt5mg1OPtjdE3EY1Du1giDsZo5O7JwDf7x5nF8XxecOWdRd7GS2l67?=
 =?us-ascii?Q?iZ3XQMEqUTv8oLLkM2kWZhqA/lFOtumO/3Np6e9pkj+u9wC7xPaqi/iviVd7?=
 =?us-ascii?Q?K1WaaKILejl4ydzd7x3oQZhphUcDGRo0gJMFGnJOiQg13LD/4hU+dJyjtANR?=
 =?us-ascii?Q?8XHwrX6J9Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed65624e-0047-4c45-c0a5-08dee2e0233c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 02:15:42.4635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDlYTtQidFRpgaLrzTsjyHRiJ/plTLd9WwwGowY6VadkyHjzUo5NM6YXzO+SgEzFg2xCZy2dyzVgAOVlyLVvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 16, 2026 7:48 AM
> To: Leonardo Costa <leoreis.costa@gmail.com>
> Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> <frank.li@nxp.com>; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; leonardo.costa@toradex.com;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> regressions@lists.linux.dev; Sherry Sun <sherry.sun@nxp.com>; Manivannan
> Sadhasivam <mani@kernel.org>; Hongxing Zhu <hongxing.zhu@nxp.com>; linux-
> pci@vger.kernel.org
> Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
>
> [+cc Sherry, author of 610fa91d9863, Richard, Mani, linux-pci]
>
> On Mon, Jun 29, 2026 at 11:34:32AM -0300, Leonardo Costa wrote:
> > Hello,
> >
> > We are seeing a regression on Apalis iMX6 where the kernel doesn't
> > boot in the newest v7.2-rc1 (it was working before, in v7.1). The
> > device tree being used is the imx6q-apalis-eval.dtb. The kernel configu=
ration
> used is the one shown below:
> >
> >
> > https://gist/
> > .github.com%2Flcosta37%2F53efdb2fb6e6e0fc05437c7e53b47737&data=3D05%7
> C02
> > %7Chongxing.zhu%40nxp.com%7C3d58575d22384d61d15608dee2cb7471%7C
> 686ea1d
> >
> 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639197560620871110%7CUnknow
> n%7CTWF
> >
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi
> IsI
> >
> kFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DKtTOaEVJI3aq6Bt
> V7Js
> > Y7r%2F9B5LY%2F%2BVj3xEMk592ghk%3D&reserved=3D0
> >
> > The kernel logs stop almost immediately as the board starts to boot,
> > and I don't notice any difference in the logs that points to the cause.
> >
> > Is this known? We are seeing this behavior on all Apalis iMX6 modules,
> > though we don't see it on Colibri iMX6, so it is not SoC-specific.
>
> This regression is listed on
> https://linux-/
> regtracking.leemhuis.info%2Fregzbot%2Fmainline%2F&data=3D05%7C02%7Chongx
> ing.zhu%40nxp.com%7C3d58575d22384d61d15608dee2cb7471%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C639197560620886501%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DK%2FBs
> xg56w4Jv4Phf%2B7i4CePTQA1M45xNH%2BxcrjuA4r0%3D&reserved=3D0 as being
> caused by
> https://git.kernel/.
> org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit
> %2F%3Fh%3Dmaster%26id%3D610fa91d9863&data=3D05%7C02%7Chongxing.zhu
> %40nxp.com%7C3d58575d22384d61d15608dee2cb7471%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C639197560620895764%7CUnknown%7CTWF
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi
> IsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DZT0p2CaXc8EJ
> YM2mlEAJegvmDqObaa%2FFiZtbCvM3PHw%3D&reserved=3D0
> ("PCI: imx6: Assert PERST# before enabling regulators") but I can't find =
any bisect
> or other report that specifically points to 610fa91d9863.
>
> Can somebody confirm that reverting 610fa91d9863 fixes this regression, o=
r at
> least that 610fa91d9863^ works and 610fa91d9863 fails?
Sorry for this severe regression. I have posted a fix that has been tested =
on
my i.MX6Q SabreSD board:

https://lore.kernel.org/imx/20260708035928.580236-2-hongxing.zhu@oss.nxp.co=
m/

Hi Leonardo,

Would you be able to test this patch on your affected boards? Your testing
would help expedite the merge process and ensure the fix resolves the boot
issue you're experiencing.

Best Regards
Richard Zhu
>
> Bjorn
