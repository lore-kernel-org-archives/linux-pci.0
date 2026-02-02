Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC98329A9FA;
	Mon,  2 Feb 2026 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018316; cv=fail; b=AuCact5S/KkMJ6UZAX0x5Cskxq40a5GyGjwC+kxwtsnBdLeVPsquhM6YYq9gIMV8Nvj/92Kp7QXV3eB3YEw/KR3p/SibGqfKL8+aDMT8Efj8ULQWJP4TrIVILfdaoeu8D5xOSf+aDcjTA8DU5aaQ8Vq1X0RRaoQ3/uuo6syyFJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018316; c=relaxed/simple;
	bh=ZUHXCMlIipE5Hd8yXrGZTj7lvKJdZqezb4NXOPVHhow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nr+imcFGSnXua9NBTExR2BBDfVo1AOK65Gge4uYzAX7rIgvAbWXa42Bt0tH18HxafsrToMhNJV6zbFtMw2ZxGbSt5Dd6H6i3j4O3cDEFdd+1U0twJsGZkPki+6cbIe8yewclFUAg+U4ChKZTOXi2Z+/xdNm2y60JHO+FVJr08fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Djn9Vwn0; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Djn9Vwn0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut5sAgKJmWER6Q9Eum+ipCVoZxacq92fXFaYBLq6WacjxJplNhZ4Tt+cGfGK3POd41oklvHkRjt5YlVqhkaD610BT89/hrnxmxstaDLOHIoZdCOekK3zNKvliSCs8NSR/Y3pG/6p+Wldor1lvAFQlIFYQIipMmoMG58ObmY4bnnX5AhLmCzGDjEDh0tZJm0g48IntmrFFxKoFyfMT8DmdfBm61+EFHH3svxXt3uasna8oRC0N7KEugqzn46H0aSB5sox/ZDlGzorbsDra1v7oPUbrFJFykvDyPOsU3lXBXIyWfcc7/VPr5gUF1KPLxUzr9CqCxczZCtRL3/VEZK7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbd9S74lRkGgooW/GBhFRYKx3JI+LUFeBQqhs8fPcRI=;
 b=qpEgAsaXDm6UAqkgZ3dtkRn889eEZBmevSKyywEJWcXqhqwXtIfGYZGgo31+HVQfX6An8Rvc40LqaTqb6Dc4EOxwwRmuLeo606Z5bS29YZo8Fj3nseiSRdc/slXHr4OnT99ZARyTa4Q2aNGoZ+M4jdD/RIMzgG+jyvkckdFODhmKnE+OkUBJPINjzXeXeY8xMRaDGyQpPemqGdZhu/0ob1RqlM+RdlZ4fc5iVtOIAi/0NndQ/snOc6JXOQ1DEcQNRKdo9QhgaGR0ugr8fTtkZ9VV8YstjhkOCkE19IpuQHkXEcMrd9sc8CAQJNA9Y85oI4ypOUHUGJ4tNEsaI7c85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbd9S74lRkGgooW/GBhFRYKx3JI+LUFeBQqhs8fPcRI=;
 b=Djn9Vwn0oNHSPwzxyirmCnT5c2glt+QVaAsra30Pplaa5CSR9doFGLuPGJj0KsoGw8grASBW4BG589OcOp8/H3FNlVjHEL0lF6qAhiMs8nxpH0V8uWiSoQ5taQGKf3HOzxRMMHCOIiC+NZcpzcHnkNyIqiqrFxhhqZt8lCE6dw/K8pG/VtWhIQhRpm9ttgsCUCdm9C3L/12F+9vdiyQSuspS8Y4WBKC3B6gng7B5NZWVxnSaYTJxfJ+y8aybcon+iyBDMsLHXjmZf1znxGWlOgZpiT9gIZbT8cbjyKLHLSOycDsb3nMxN3cYM2qQgIFnmWQg9ruRu71OkgbZnQDqdg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6971.eurprd04.prod.outlook.com
 (2603:10a6:10:113::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:45:09 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:45:09 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH V2 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHcjA4l/asrGAfQJEeRX1bbxYXoobVpp+KAgAVvc3A=
Date: Mon, 2 Feb 2026 07:45:09 +0000
Message-ID:
 <VI0PR04MB121140B62C5DE29F7D29A56EC929AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
 <20260123021445.3782170-3-sherry.sun@nxp.com>
 <aXvGkSHbUE3qmxMK@lizhi-Precision-Tower-5810>
In-Reply-To: <aXvGkSHbUE3qmxMK@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB8PR04MB6971:EE_
x-ms-office365-filtering-correlation-id: 7a07e53d-8363-4c47-6e63-08de622efda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iEcXXziyIfgP878P7eZ0j+/Q+kVhr+LK+tJqU7SGbuu9wDV2q7HhcmYFaO7a?=
 =?us-ascii?Q?x9eLP6HLyue2WCrd+37xenhq+nq9TEr7FRxxrtyyYAzuYS8vBmE3cvJLSs4a?=
 =?us-ascii?Q?FuMTNYSR4+w7JVt3d7HelwL4cF++L4l8BOh4jWilUaSZPaLXz8ybQg1hzANs?=
 =?us-ascii?Q?1FXv8asJFJSguZ/0UnCRW67SqN6B0PD6LuWYt5r4Felf7NRZtlsIIPaUl4MD?=
 =?us-ascii?Q?+edyLKFsS6gLODgGBV4IhEn41W3JJ21bTz7vIlA52WN0lp//W6RTc9/uNrwR?=
 =?us-ascii?Q?tblEJtZv1PazynbKAN1trRPy+gls5ICSmWNqMnPdPc9FSsRNh4ptuRtNeZ86?=
 =?us-ascii?Q?kg9H1cU0u7jiO6RM1Vr5kTTxdsin+A0A69ydivWYZP5W2Mr9M5gcrkYPk/E/?=
 =?us-ascii?Q?NeysvjI8NNZ1vHMktzTVHTXBb1Mxlzweg+8BJxQxV9r9qK6QOnGp6Vg8IhLG?=
 =?us-ascii?Q?yr6KfPFywR+2xXPgaZBxLzA9u0vIx+/tNV69g6jz0R5+nGnbIphXUt028j5R?=
 =?us-ascii?Q?40ERLgoAnQJIBNcMnALSTa2HZpT8VgZu2FkSsd1m2o6IXiY+wYnWBmE4XZnP?=
 =?us-ascii?Q?bkbApgx3RcFOu/aN+lg3u8KUGfpL+pMgUA1G4eju3gu5eF+gpPe3kQX/GCKM?=
 =?us-ascii?Q?ue6Cg70/lLQs3E87UWXhX2YJXnjZ4W12v+/w6ffe+dDJuGpwoykex1IyiI09?=
 =?us-ascii?Q?n1ahwHKST/wEavFGbI59Y5yRhGjIsVfveVUhA0SfjyoshVhysdZsfLslvgDj?=
 =?us-ascii?Q?Uh+HGkh36fLn3Wqn3hslRiie54vUytzNRYnjTWVQr7Qz0PAfQ/H2AoNNfRcB?=
 =?us-ascii?Q?lxVd716wFEa4b5I+ygyllA3q58CnI4SoidmlaoDg3OSxE0qYT1ygcmFEJaYW?=
 =?us-ascii?Q?N3GdkguLnhLWmmjKFHcCk5E7xJhTD4BO03C7pLhLAGEeeIkffROcjYql0X3P?=
 =?us-ascii?Q?jAwI1+YKWer0kYboL7qoDL42naLZ6rs+TTOl2SfXNaBtjxLVkHhzChS69Mvw?=
 =?us-ascii?Q?wsNwEip9F8VU8x9RYQh+t4avWbxGfi5pTAO9ECGLLQ1Sk1pCIMdou0P3le68?=
 =?us-ascii?Q?mWX7bRwKXTkRljCH59rZzhTd2+KA/zu5usu+SDyAtXmxpOZzt2wl+NmQ3QQv?=
 =?us-ascii?Q?nlA2KAac4MCVqK/u8Zh5NLCgYGYF91XzuK4ad0A+d8F/0MyIQKPlolVFghIB?=
 =?us-ascii?Q?UE+BvW32l1HstTfHxk/+BSMaJlo1XCtkqbfX0P+MuQbzjtms5P/6uqpx345n?=
 =?us-ascii?Q?8hKvTXnhj25n53vlq5CpsV9jJD0AZJeQUuA+8U9ALCjFpVDNrWdXIfKxu4ud?=
 =?us-ascii?Q?wE5OKfgBYV/RkxC2vCQ00H8AAJPOI3I8GVPaKB5w2abxJJl/TeOZJDb6npE2?=
 =?us-ascii?Q?BeDGtgHVDCaUI0CASnCNFjwmFD3yZeQL9ijXXd4RXMn4eEjJFCFOlk7AHsww?=
 =?us-ascii?Q?xdL9c7T22SvzPCQ53jj7FzmVsqoCjlnQKmrrtKyJ1tcR6Dg9ViWCtwF5YM+j?=
 =?us-ascii?Q?WbjQYisYkgxk+j+cs5cmDU6UyYnSINHOMpb+4KouflXSE5afxQg8beVKG48K?=
 =?us-ascii?Q?dQpZPLWt7EZuOqlqtpEUYfjXaLC/Sy68RO63G8cYPePy4Rw7LR8oDg6bMp0j?=
 =?us-ascii?Q?liVDM1fRV0BtNtrdqlwR8jg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzpBgXZb9NZYwcd/akA4O6et4la9qSk/IW+2OMdo3m/tJE3LpMsxxXzT+cws?=
 =?us-ascii?Q?kXgwOp/Od3yD2crj+7ahszKaFvIv7XDCB1HKeJSc43BvVpL/EeGYunYOSvzl?=
 =?us-ascii?Q?my0KxTWY9lWC9KAmvMiPgN5GlGUKVZgd/JefwTaHOmvM6OM+YqnYk9QUjCz0?=
 =?us-ascii?Q?j8OMYOvnwMVKdW6fOWwzHa4BPUwYIChtDx4pxq9ZqHMN5YcmGWjmFlypgCiG?=
 =?us-ascii?Q?Ukl38D11vJqEY+YI+85SgGESigbhzlQt8DymJ9P3D/jSEi/YfO+1fS0vLWu/?=
 =?us-ascii?Q?iJ74j71GD6Om/hlJL0bYBy2wJdealK+9XMWFQKvYj42q0wCmGNaCO3N/DpcC?=
 =?us-ascii?Q?pGa3+Uy7unJWlMewCz4zMgcVtQLbSKyV6KGkIld1V0LDBfpTa5oea1rALvxe?=
 =?us-ascii?Q?GKdeKZPaO/EEY3nccW6OkGDrUd4A/reVKiD6agztpElzsi+0GTWn3Kcq9iLC?=
 =?us-ascii?Q?eR8qfVTjVLxiHJIicJSWFEy3tqAGJv3BJSAKf1luC+lXvZbYpTASKFCsXX6S?=
 =?us-ascii?Q?2k83dpJj+9rDe+PueF9xeHQoEw1m3QsAcRQKGNMrGQLc3uP/u/ShJprcvekI?=
 =?us-ascii?Q?UWt4hfDaYNT0A/1Gia1cacu61FE1hRgb/PLp6rflXiB62gDJnulbjJr84VNr?=
 =?us-ascii?Q?YHf/uDBnB12ngYC4j7v54MzikuWjFopEP/kKVuaPWVEm+pkKbeYGCyENvYEv?=
 =?us-ascii?Q?NkiZxg7kWsXh2hf3Rhms71cm3FOSrvopjECa88eqs1k5v+rYNHyNuOe5BAwe?=
 =?us-ascii?Q?qIo/iQj3VRcz4ENTNBVH/XACd8RB9vtM3MUeyt4cFICLY/RMazhhfW4RGh9Z?=
 =?us-ascii?Q?OaKpgW4lqep2EzGyQdaezUFETQwvqLtdmEg26a+JWHtHH/rWmxnGrK51M7tC?=
 =?us-ascii?Q?9MPwbo/G9h9EJhku6gdwgMRr8A1/uR0FbJy7UWd6p6nMvoYk6bRDmb1zJR3C?=
 =?us-ascii?Q?J0Ovltg8v9LUZfdtD+e9C8z3cHGItp8/m4XlRjfePWa2mYGhLttQn/x7YaE6?=
 =?us-ascii?Q?YzxHfZuzrLE/6CgI0mCDvYJXmKcg7qD+sfEeojgyqS8ZJPnQkduWNIn8Icmp?=
 =?us-ascii?Q?Q7dhwYntTFn3d7zqV8GIeXF1uvq6H8RvVgbIHu6WjHI90+MZWwQgOCqj+skL?=
 =?us-ascii?Q?SeFjg5oSmuVYuSTTjqn5SkDXG7SGnkMIWatzxxaPl+S/yS+BT5OrdGsMGlE8?=
 =?us-ascii?Q?2Ba3SeAk4sJ5p89AOlQGS0VTnw/2AEYB/WAZ5oCead73C44e1OPVtK/+6iur?=
 =?us-ascii?Q?zvxm+hTv5F4NThqpd/SQgE5FVTbxduDRbOT0Igo8TbVWnFU/eZJWcjndYqfB?=
 =?us-ascii?Q?I2Gz2Oo2BOpaf/GARm8D3UT+KyFCbD6oOu3WS2ATonb6gzS9cc2IDzCJLk4C?=
 =?us-ascii?Q?fUTZvz8F5tUkx9ijd21CQzbumwYLXfboBXM2Sc/DYgeQ9Jwv2IZai4v6zssW?=
 =?us-ascii?Q?CHMgC5mp8EA0MY7zJGENy/jXUm/+Lgn8957VYsX98mrlMozbHkRAGJnrgEiu?=
 =?us-ascii?Q?sWzqpj45F1DCtVjRSV2iHSJUKB5Aa0wJYHDe6o35WshwNKN2MuDCrQ04ZMLj?=
 =?us-ascii?Q?v9t6f2KjLrP4+CCJlgNx18kHG6EdBhCDtEUEOZmBOSn7g+ivsmLo/Y8cZosK?=
 =?us-ascii?Q?r2Kw6Kwom++SkYpqqvSki7SFU8NnD6lqya13VfX7JjyOg0RylxMdxBBmb5YQ?=
 =?us-ascii?Q?LfLGhGYqwn2HURU3F0P3DyRWpemjdZWM4IO845TsAAg8ofWK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a07e53d-8363-4c47-6e63-08de622efda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 07:45:09.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5tgRxmrVOYoDa9Fwx3GkfEjVxNtK174P89e6jkdbFh5l6f66fKrCL0AAGp7lDUkVBw6p4GqfLEMFljvT4R8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971

> Subject: Re: [PATCH V2 02/10] PCI: imx6: Add support for parsing the rese=
t
> property in new Root Port binding
>=20
> On Fri, Jan 23, 2026 at 10:14:37AM +0800, Sherry Sun wrote:
> > DT binding allows specifying 'reset' property in both host bridge and
> > Root Port nodes, but specifying in the host bridge node is marked as
> > deprecated. So add support for parsing the new binding that uses
> > 'reset-gpios' property for PERST#.
>=20
> Need descript why need this change, such as support m.2 key M/E, power
> sequence.

Hi Frank,
Sure, will add more related info in the commit message, thanks!

Best Regards
Sherry
>=20
> Frank
>=20
> >
> > To maintain DT backwards compatibility, fallback to the legacy method
> > of parsing the host bridge node if the reset property is not present
> > in the Root Port node.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 123
> > +++++++++++++++++++++++---
> >  1 file changed, 109 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 1d8677d7de04..4b3377a48b17 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -147,10 +147,15 @@ struct imx_lut_data {
> >  	u32 data2;
> >  };
> >
> > +struct imx_pcie_port {
> > +	struct list_head	list;
> > +	struct gpio_desc	*reset;
> > +};
> > +
> >  struct imx_pcie {
> >  	struct dw_pcie		*pci;
> > -	struct gpio_desc	*reset_gpiod;
> >  	struct clk_bulk_data	*clks;
> > +	struct list_head	ports;
> >  	int			num_clks;
> >  	bool			supports_clkreq;
> >  	bool			enable_ext_refclk;
> > @@ -896,29 +901,35 @@ static int imx95_pcie_core_reset(struct imx_pcie
> > *imx_pcie, bool assert)
> >
> >  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)  {
> > +	struct imx_pcie_port *port;
> > +
> >  	reset_control_assert(imx_pcie->pciephy_reset);
> >
> >  	if (imx_pcie->drvdata->core_reset)
> >  		imx_pcie->drvdata->core_reset(imx_pcie, true);
> >
> >  	/* Some boards don't have PCIe reset GPIO. */
> > -	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> > +	list_for_each_entry(port, &imx_pcie->ports, list)
> > +		gpiod_set_value_cansleep(port->reset, 1);
> >  }
> >
> >  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)  {
> > +	struct imx_pcie_port *port;
> > +
> >  	reset_control_deassert(imx_pcie->pciephy_reset);
> >
> >  	if (imx_pcie->drvdata->core_reset)
> >  		imx_pcie->drvdata->core_reset(imx_pcie, false);
> >
> >  	/* Some boards don't have PCIe reset GPIO. */
> > -	if (imx_pcie->reset_gpiod) {
> > -		msleep(100);
> > -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> > -		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1)
> */
> > -		msleep(100);
> > -	}
> > +	list_for_each_entry(port, &imx_pcie->ports, list)
> > +		if (port->reset) {
> > +			msleep(100);
> > +			gpiod_set_value_cansleep(port->reset, 0);
> > +			/* Wait for 100ms after PERST# deassertion (PCIe
> r5.0, 6.6.1) */
> > +			msleep(100);
> > +		}
> >
> >  	return 0;
> >  }
> > @@ -1638,6 +1649,76 @@ static const struct dev_pm_ops
> imx_pcie_pm_ops =3D {
> >  				  imx_pcie_resume_noirq)
> >  };
> >
> > +static void imx_pcie_delete_ports(void *data) {
> > +	struct imx_pcie *pcie =3D data;
> > +	struct imx_pcie_port *port, *tmp;
> > +
> > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > +		list_del(&port->list);
> > +}
> > +
> > +static int imx_pcie_parse_port(struct imx_pcie *pcie, struct
> > +device_node *node) {
> > +	struct device *dev =3D pcie->pci->dev;
> > +	struct imx_pcie_port *port;
> > +	struct gpio_desc *reset;
> > +
> > +	reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > +				      "reset", GPIOD_OUT_HIGH, "PCIe reset");
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +
> > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	port->reset =3D reset;
> > +	INIT_LIST_HEAD(&port->list);
> > +	list_add_tail(&port->list, &pcie->ports);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_pcie_parse_ports(struct imx_pcie *pcie) {
> > +	struct device *dev =3D pcie->pci->dev;
> > +	int ret =3D -ENOENT;
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +		if (!of_node_is_type(of_port, "pci"))
> > +			continue;
> > +		ret =3D imx_pcie_parse_port(pcie, of_port);
> > +		if (ret) {
> > +			imx_pcie_delete_ports(pcie);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie) {
> > +	struct device *dev =3D pcie->pci->dev;
> > +	struct imx_pcie_port *port;
> > +	struct gpio_desc *reset;
> > +
> > +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset))
> > +		return PTR_ERR(reset);
> > +
> > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	port->reset =3D reset;
> > +	INIT_LIST_HEAD(&port->list);
> > +	list_add_tail(&port->list, &pcie->ports);
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx_pcie_probe(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> > @@ -1656,6 +1737,8 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  	if (!pci)
> >  		return -ENOMEM;
> >
> > +	INIT_LIST_HEAD(&imx_pcie->ports);
> > +
> >  	pci->dev =3D dev;
> >  	pci->ops =3D &dw_pcie_ops;
> >
> > @@ -1684,12 +1767,24 @@ static int imx_pcie_probe(struct
> platform_device *pdev)
> >  			return PTR_ERR(imx_pcie->phy_base);
> >  	}
> >
> > -	/* Fetch GPIOs */
> > -	imx_pcie->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> > -	if (IS_ERR(imx_pcie->reset_gpiod))
> > -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> > -				     "unable to get reset gpio\n");
> > -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> > +	ret =3D imx_pcie_parse_ports(imx_pcie);
> > +	if (ret) {
> > +		if (ret !=3D -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed to parse Root
> Port: %d\n",
> > +ret);
> > +
> > +		/*
> > +		 * In the case of properties not populated in Root Port node,
> > +		 * fallback to the legacy method of parsing the Host Bridge
> > +		 * node. This is to maintain DT backwards compatibility.
> > +		 */
> > +		ret =3D imx_pcie_parse_legacy_binding(imx_pcie);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Unable to get reset
> gpio: %d\n", ret);
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(dev, imx_pcie_delete_ports,
> imx_pcie);
> > +	if (ret)
> > +		return ret;
> >
> >  	/* Fetch clocks */
> >  	imx_pcie->num_clks =3D devm_clk_bulk_get_all(dev, &imx_pcie->clks);
> > --
> > 2.37.1
> >
