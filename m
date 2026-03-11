Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889F29405;
	Wed, 11 Mar 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209185; cv=fail; b=cWYbt+mrxgdLp5fq7aWJMVjJfc7b52xYqpBlhSkon81Tw4v4yOCVXG90lJuRC1GDr1Bm2T8dPB+5Jl/oHv8vZb68LxtVgseMLKfxpYciqRlJ3arj5I07U9z4LijoNP+9VEXb4AdH1VTVlhsL57+NOFZdsnSpCjO2qFrTSYM9zNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209185; c=relaxed/simple;
	bh=l5bXC873AwBhlZGcWpLynTq7hIIyyP4S42AHYNnZIUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MP+eZsaDudGFXRHbNl4vfQONDxrDv9oUbIWbkJzfaY3Y8FZCp4DY2UJiaeYAZfulX2T78YZT3XuxweWJfc6yazbAgyxIbmmXBvNxGKIWnevdH4s/hGlQQF0q22UaYvFP7nLUx7Uqd+EJWDAuOSXwHrweR+D9bA3UNvUUeZprWtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MqrqlUC0; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MqrqlUC0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtEVcyxfrKnUQ3eOBZEwqEJbXtztFTNE/g5+T2FEP6ULVpSdnqD9lUpqDGQfo0miJMh/BRAytl5SJP+28MswSSGOyI4//QIcw6BwtTR6k81wj1jMIKGx96FCWC3n10t/rksJUaWqaXpEyjJzi6Cjpf4DLqMUzgf5Y1HWKfh0+Y2wBovm6M8RbONnlAuj2jjeDdkNVuUUxhXJ5Imz+pkdAebIJSkE/c2vTnXW5InO/3d3VA5urr6CVpL+/uE3h/JsVyfrXN02FGYmzXVWe31nQCs9VDmB85kpGtz+1RTJoWFJdEkbXNMhh/epvY/BwM4A7PMMlS/10GJG7L9j7wcKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWlDmrrCphfg79rf7xGxtgoqXZpJnZHPXpmup1eEHj8=;
 b=jaZMhPys6fbnGPU9xb8KXO3Jko8WKR+8wZR5jrV3t3RIGCBRf8PiRx2UGLc/1qMAcC0lJKS1prb7kNSUi86kjkerz9x09uoKFsrj4QZf5a8kmZSPrqFdIO43r0bx0aFAS4Uq9II/IMnHmh8BgYY4O1YvjQ0NmRG7GPEwvMZShE+R825bp0xvpjrlf7sE5hA5jy8T6nmfwmDzWLYi43quXPj+7nk/hguAZ99LZiCb4RZ0gm33yc/zJa3gxyzkqe1NgWXVQp7lYga93WHDGXNfODyRx042I3a+5Yg1xgTZAXONhBDyKGGFi03GOX6b6Y6oc2Nj/2E7nFkdoPTbAFJRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWlDmrrCphfg79rf7xGxtgoqXZpJnZHPXpmup1eEHj8=;
 b=MqrqlUC0VYi2mh4yBL3lIH5l9GAnwiLtsC07Y+to8pRiGPJPWxDKqUySj483hLZqDMfnlY8BVuienflUVOikS4OwihW2oMkjlVa7HSeyoaIvmcerN5RehrSrAp6CdX7eQOpKZOMKXZA6wOSxapYLEMTX6gS5UNvsAQUexZz4FOQSdCEboqDzbkDxim/exSw6pdPWAP4W0lROKWu5nKcmeIb8dziTYQV55B+swPu6BnyuW6chwK5BlraC9EZzDmRwdCD8ixz9CJy4nl7PxkQH83ftTlH2+oqSQ0qmZO0G0E9idLqV+gF4PNycBhlDbSxXwxieMfDusvR0JMx7yEZnnQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AMDPR04MB11620.eurprd04.prod.outlook.com
 (2603:10a6:20b:717::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:06:20 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.020; Wed, 11 Mar 2026
 06:06:20 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 00/13] pci-imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH V7 00/13] pci-imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHcsDCiSUQezRcS5k+mCscse2hcFbWoI10AgACzNJA=
Date: Wed, 11 Mar 2026 06:06:20 +0000
Message-ID:
 <VI0PR04MB12114CC9831943D024C50F5209247A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
 <20260310191244.GA764308@bhelgaas>
In-Reply-To: <20260310191244.GA764308@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AMDPR04MB11620:EE_
x-ms-office365-filtering-correlation-id: 8e70afeb-8e53-49b4-eb07-08de7f3450c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 KOUM+j2ek3utHpOBgPK5fQ1sqOvrPcvjGvmvPxBa0O23yPsFKSRNCOLfXe3WTBqQrNsIA9TES/7GpLJ4kowxdN5BFWLDpmlrzxdj5DGIusS0nADpFEWrycF/uNYAPWZXTKoEJ1gtsNF0pmRCajeljeMHRvmJ8LbOYiqlP5F7pv1P/3FlPO/YJ/ZZkOn6n2hxfHLtFgJ3F30AUehrAAHXUrTfST578LuKzx0RSQnHZqltSfvx88/3gUx7lN3Y2pzxqaX73wJKwasg7AkkLBLfGdY4aiqT+YfuikC2tRJHm5fQQUqK0c687MH53bpImDZhw5G/uIEnp1h5rY0oV7VKQBadspm7XYCgGdVNJSLtd90CN6/k9LiY4MbQJN5U/9+y4h4hX4j/fqq2hphDiWVZahC9YSrnEd4BScgzfz/p12iWjxwpV1/L1ulAFzI83Rgx9WjM67CxW7xfDXxHwL/AjMDsjLwyFz1FG63kkc/CNF1mi4bX1vfTBDy38wQe7WsVwe6PQMUEoLBhWnjAzlMl8PjYuCabnaepQhrNehwLOI9G1FaONSXb93O3bqMrTdmYjLjKkwy9jqbz0KvHBQebH8MdATWy6wUZv5BDQpRdIz2vn+IACtZoUttdDwPhhzruX21mbJu7Z+SMCTi9dputlPFE5ukjzLxdKm5MfOLRY2XACffHuLy3XHBOjDQTuLEOpfcFhk3bPc5CtCGUtgN59+52hv7ddbg5BxKmJaX/+i/Kbe46BMa++eQAy/vXp0FmOfaI8rEyg6L0povKG2l4kXavVFygcIN9zcydGemw8BM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P5Cof5ja/AlgUL7TSk1CwztCE6yR/AzAu+5dIPl++dXCkSWX1Q0KrHucbcMD?=
 =?us-ascii?Q?oFLrQMLgWoLjXgQmGOQwUdgGN0qAYSa5Mw+wLwrjOP8lq+hTKI/X0uFAjI5T?=
 =?us-ascii?Q?V5+CyZcqNLTvWIVS0YAFO1yNhBuVPXAUAUU4xmMZ3sv6tsrbcE1Bvx4wsByl?=
 =?us-ascii?Q?Ok3ni6IcLHf0F6i4NQB27j2ZaiYKcHBuOw5KDMnLBuwVQjWi1s3dsT17+teR?=
 =?us-ascii?Q?YZ8WY8IR+4hCaD6KbGTASRo2LHvjSOnW2yxGTHAUuiKlzaTcBKc/ZINWnCI8?=
 =?us-ascii?Q?q4p1pPDwfU7rZgO8jO7SSu6nt8Ue4wmAkOGBM8SClJc2lhk/a3yW82MH7FIf?=
 =?us-ascii?Q?dU0Yx8CoJ6vEx986qFn1MMvsXIREQWTAfe51G8K3vI4WAOo3nNdz0od8JwGf?=
 =?us-ascii?Q?dSxuiUHNMYqkPr+ouwukxoErrnreHkovDYLRj7CwMzLPCt/VW4sHm1cBJWf9?=
 =?us-ascii?Q?8smH5Zgh1sGQUi0+H13wJUQeaVXPE3n5tJrHOzdT8L48HqjdtJXcw4ncQnkl?=
 =?us-ascii?Q?1CPLpA6/oQqjcZPjPrv45mZuyzv5zd384g1nBDUwvtkej4V/qToTxa663LlB?=
 =?us-ascii?Q?eLFP7TqmK3opmTAmUTZN/yVM2Af8g8ywz4ZTcyTKSumDguNsP1CLdm3bjsRb?=
 =?us-ascii?Q?ItR9U8fNPli/l7VWsDUXApnHwnz7tcw5zKwbW4Mj7Kfh1fbrxJwJaWneMpRZ?=
 =?us-ascii?Q?XTMAqxmmSeL+2zlKEaOIMZWdDiKNsJvpNe4aZqyd/K/DaWAZ473Mdn2yJwfV?=
 =?us-ascii?Q?1UQQl2cEsP+RaEeI5khv5waRv0tnhqna7Oq8qVR2qJ8p6HCaL3iQgJlo2oFl?=
 =?us-ascii?Q?NV6VFkuZAiCdRf0wPs2H8mPMYKbPiWaFmL0ArvITY+KpAh8DU7dSp+oh9mqn?=
 =?us-ascii?Q?nbxj7xJm8hjcKgt53AEM0RLROTKCVV+IhF83kLVKsl4FDEhSCNYP5RL2huAY?=
 =?us-ascii?Q?DgyDAxG9ei2VsT/ht52N0YLRN3HUIlTKhcN06ijVgOGs7dNScihm8hZY2YFV?=
 =?us-ascii?Q?WeeNLaN0nB3y3Y1fNKOQszked3oTyC541RCnwyBQ6OsiOzoH/nrJmUow5LTE?=
 =?us-ascii?Q?/r/1e2yXyoBcW6pySRbtTDpSsFNaP6jp5v/v+Lhnz83+8oPh3bF8eVBrm/2h?=
 =?us-ascii?Q?nPaFDbcdd8WyUtbouDnP4CNglg5XEd0TBCzB8BiJfSLH342Y1A+5EQsRvpio?=
 =?us-ascii?Q?Yv2nUvbojylWH7KcPAwjgjWyXRvRHlhFcJnekaaATQZDKJ2q0B1+SeA26+Me?=
 =?us-ascii?Q?j7nm5vykQSe514b1qsABAD4t4Cj1nyqM2ru+7w4Kk/OyHSuexHrXtePD2XY0?=
 =?us-ascii?Q?D7jOqsV9ZbRAOZ8j6d/zUvDvzcepCeD6HyEiZczP8vb5PVDEyc4jSnXQ7o5l?=
 =?us-ascii?Q?MmMi2AeXmKXvmuWaI22yAg9+x9JZrvtaCLjAbUWZQstk5gzzBB0rRJ/Wg249?=
 =?us-ascii?Q?K5ahsNxjROjD9b8CDQWIHw0FBwvTfeuZCO3yvlESN7QdLI8YPGd49TrJAWMG?=
 =?us-ascii?Q?WV9rgjgmDadg/65ilmrCCg2MFus8OgsBM7wxa0vUkX4NgSuNLmTG6V0ho2Gr?=
 =?us-ascii?Q?dajEW1Mop0tHdycxMw/CWG+n1LsZ4z8jkwCwwTAgTyTsdOG7tNi3/EFqPZoC?=
 =?us-ascii?Q?OTY4CNCA6VUWQR2PqDYsoaG41A/d6I0pV/dbK09eUZNKr5FGpiWPy6V+kmzb?=
 =?us-ascii?Q?6b73Q6iwyL4R73dTHYwTGmbHgOGmyFqdWzFyOi9XPTW/8iai?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e70afeb-8e53-49b4-eb07-08de7f3450c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 06:06:20.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv5gXhRB9egTeKR6WyThFzdJnY7pZ4DZqf0p1sZctYjFzRN7dZ2ZoCaAhGZ3Y/maA4A91qLIXpylb/LvU++pvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11620


> On Tue, Mar 10, 2026 at 09:54:13AM +0800, Sherry Sun wrote:
> > This patch set adds support for parsing the reset property in new Root
> > Port binding in pci-imx6 driver, similar to the implementation in the
> > qcom pcie driver[1].
>=20
> What is this series based on?  It doesn't apply to v7.0-rc1
> (preferred) or pci/next.

Hi Bjorn,
It's actually based on v7.0-rc1, but I forgot to mention that the series de=
pends
on the following my two patches for the pci-imx6 driver. Really sorry for t=
he
inconvenience and, I'll add this information in the cover letter.
[PATCH V2] PCI: imx6: Change imx_pcie_deassert_core_reset() to return void =
https://lore.kernel.org/all/20260306021247.991976-1-sherry.sun@nxp.com/
[PATCH] PCI: imx6: Separate PERST# assertion from core reset functions http=
s://lore.kernel.org/all/20260306030456.1032815-1-sherry.sun@nxp.com/

Best Regards
Sherry
