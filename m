Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C237EFEE;
	Mon, 20 Apr 2026 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653950; cv=fail; b=i4OADpyzEQ6e3tYozTd/jv0MsApIEOBRGXnbndU2vEWgo80oCQiCz5SlRjD906z9uabWxgUpoUzcn5qq4FyPHGUQdZSMHWitLDDfmBaVsV6qG1Ay5mBxVih9WbsGr06aU6ED6A+73f7g9Dnz0jZHAqnG9SMW90QKxdRCOSNp26U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653950; c=relaxed/simple;
	bh=HgbxIGSaSBkgBUCArH+jcvekOdWpYOMAWv7x/V9asHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IjbFtjJp+OC2svbwenh/cGVUwfTBy/YdcpJkOKBpzTgs1TH1BuTONuA7iMNwS0aMwxKu5LUfT4w8maoiOC1SRBc1ntNzwy4aS6TxzWgAoa4h9LuN0yXNtNeS1AQBkWjkyONmZFNGCP8gpyy1aYZbxNYioxllPWXj7HpR2Fs6REk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLH8JESd; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLH8JESd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlYpoiArvz3ebiFFUOSvBvOhwbs1FWk9tCupSxWoFY3PQDEggmczMdpfvAHtVCX5Ko/NnwvIT78PNNkaruTZ1JIrdov2j+ALPkDtiEdyu372MgMsEMVcRP/qfbgdwhVIPqHJHRjX/M4cPNcktgdrSdw2x0MlC13iNbSq3QlnPDkjqN/57WSUSGc8zmkuI8uc32f8iugceFuJrmqjz/fQWEjiNqLZYqGFNEOe9vTJWV19JM6B9RwB/SpBvxE8AW8++gmUrK2a91GkgAHeTv2F/Tu8/gPLW2ejhyBHG4JvKH5to6LD+/KOlYeTCp4DTxNW31WnaOT8WlLfrb+rlyldDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GohfPZ7b0PneqV8zfrmIrWMre5KXUq79+06BLuYuq44=;
 b=GUJBT43Ip7T08q8YJLZlJ/z9bcZVZZjnoas8/wflTdb9pz7Fztrv8GEBXmqZvTMkIUO+zo9oGHu2CAlRey96alfxPaYvbgCkxBbSxMB8I9dRxxkDaEOQhYFJD/pBSwVzSo3ZUyXfjVFu12khGI+WgoyAnNfd06Nh3N10yujm59ehapr3+i+WCRB5g4yk+XSW+G+UQW3Cg4kzuRBwCX7GKXsN2mNHUconRpoQ7HXCvswG0Sv3gHbKHB78D/xZQyS+eSgKFIfaMF9wexeMR+W/Sf36t2bOa+RwK1x+pDsY60HcrLdVZPa88DPwqN8eJRfRB220PpFynhag3UrpHlgyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GohfPZ7b0PneqV8zfrmIrWMre5KXUq79+06BLuYuq44=;
 b=ZLH8JESd/2IioCqFkaBPT072w1Jh/2wuS5/8EogZyUIrQ0S2PUAYUfnfV7qHhscGgfGvv6/+lWcc6+JyaiDT4WSyDnUWjLsMmEp4FIjLI86wqggV8dQNJeua8zcZ8aSD9g9PpR7Z25oF1QGZ/OvOpZWYmLj3F2mtI0AOR47813hXnKfhwv3ujr5lDmEqb34knn/iaA6AX2vO7ynPc2yTPQPPx0dh2ky6N18ts3iXNVLmqrGqwvFu5YN3z0b1/p1viOJ0Ma5UWUb9xFFOb+DZ2IC4EzV+E+kHqUQ2RYyiz7lieR/E6BJqzgmk+boTVx8+dFXVkDwykEiWLCKzwMONPg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB7704.eurprd04.prod.outlook.com
 (2603:10a6:20b:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 02:59:05 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 02:59:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHczZH9Fw0NTzMvoUCb4PMSz4pIBbXiJv2AgABoHuCAAR4OgIADlH+Q
Date: Mon, 20 Apr 2026 02:59:04 +0000
Message-ID:
 <VI0PR04MB121145DB18C2B744856CA6138922F2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References:
 <VI0PR04MB1211449884AC3BC8E3711F1AB92202@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <20260417195533.GA92707@bhelgaas>
In-Reply-To: <20260417195533.GA92707@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: mani@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AS8PR04MB7704:EE_
x-ms-office365-filtering-correlation-id: d3705802-af13-4504-379a-08de9e88c886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 OGL6B8WakU+TuMH6L7CwHXM549Eyhj6+pfRuc+D9f+ppQJDipXEzwfp3308Y2yjPWmJEOI0zcTnyLVkXnFIa9TA02o+aG3R/eKkBMNV+0VRMfEjrnSxcCUz3Hrj5HCN5HxRB6sxZAnlCplVG8gvi3jL5aKZW0JU3TgUEN+2TpPZG0+HiTWmRjdRxKvaXwcDC+4E0C14ilMuRiJGbo6CENJnhiNHHOMqoawXDNvL+CyeN6nWb/ALuaFj3DYxp+M2t51xf/mar9SgepYoMojJpkkPMKzofVi1hp8pEdcjB7loGtcIyPtLqRyo2ThdGiHS/dMQ+SgZ2LfDpz7y/YiyeCp6PF5sOikC7S4UqUt519cvuiXTli9G2wKEFMHp5XM+iXZeC7rmWmbpKwa0FU9AlPXmftsSbp3aSCObsp3re+e1k0Ml8zue54qQnuwqPYXBDMoS4Z+YbfxERklLGXvdBWwGf8ia9RB3DHWZnlp5YzpjafWZxECUSLREiLD0YKMon1C/ovM2Pgz1kMiD32ZujaG15n6KAanBgcoB+H0bQqsXPZgdfTLNzAqIVz0T3lVqeFxCs/BSkoGX/4kqn2GQCQ6mxwCnXEI4NmoI6wknXZUyH4v96/+/lSrBEafPtkk1irgfWFLqNjyxC8wgPvi97tSbI4QlNjaeynDlGT4OKBjdQvyJv4JBK3GNMnyJg/qCFjw8gkAivfEoZeRvCZ1WjasTTnXM7k0XAlZ8KpBeTnleM19+w0ZTW8fTnMto+fbaFy9De4yl8MSxCWCM2WTjdwvVTVqcnulQpTYmFmJFT8Cc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nr9rVP+gw5A9YjuTLFcz6fbmjR14v4WXgxrwvEjKZshTs4RqIxlfUIIWC92J?=
 =?us-ascii?Q?3zP6TjHgtNKxCgNWu+r4x7lfwDbj9wxdbxiCPGsbaGbiPzfxM7nMCK7T0xrT?=
 =?us-ascii?Q?/3nSaeFfF52yas0uzzJlW4IOy+Pzq5g5ySRkQF9ZIGjpxF85/8ikGfYlmHlw?=
 =?us-ascii?Q?E1A3qVnMR0ILoGRB82Mhdl8/1rZy/8deouQ7tjfycRlLEE6HzCpXgvln/mld?=
 =?us-ascii?Q?97uzjtd+IxKaL8uFX2d4sLzqN1JD0inCus+xaXU3YGN1VR+5QxqvkchNdMn4?=
 =?us-ascii?Q?Bc8+3XYbA7sFUCWyhB34Na1c1fVyiQo+xLWDh5wWzuhLD1o7FXN1svSjmszo?=
 =?us-ascii?Q?aDzfi6nMkiWqJPlcw2Z9rcU+wFJY/ix5HghgF3Dt/Y9ZjA5RrJj6YRy50NxD?=
 =?us-ascii?Q?NQI9yKsJDhYDktXOf4EfPDkgE+VIGXGZa0F/UGSIS9vZKRHgeqYPFYUIxgjy?=
 =?us-ascii?Q?uGrw5NljBUd/x6Bco92byvkgtzdKxFOTmJVZNfk6Gp0sKRx7byNcnRVigwpL?=
 =?us-ascii?Q?q/HeSQ6T46641+w3hRDLQVrmQyWThmS1Fci+ZaauoXXqIRtJjJgeH1RLNU/K?=
 =?us-ascii?Q?EgE1+o2W+MSIiK18gLU1efcKYW7Sbtpof/uj7iiu8HwVyZxf+allnuBaQ5Wt?=
 =?us-ascii?Q?ZweeHHhOPsDG2/OHMIAKIAvNGd7A51+c0gaM4yu2dMlNS5YjgwnbSr07lnXQ?=
 =?us-ascii?Q?y/kojkh6HxeR+wvNoPfu20jYijUbAz67B80yZYxqzjP/kiIOx3kcjiXlFucS?=
 =?us-ascii?Q?mTu8kYXbVuu/x4MyQ2aN7vnGkWAcd8/7KGTC713eoUkmYDzdv1u8abNykf6X?=
 =?us-ascii?Q?+Y7aDFOXhdFzh62qVkwMMcMCCX/pDQ6Z9mh2KWPFxE6l5OYLeqpxlvwBCBvJ?=
 =?us-ascii?Q?bjh7jJr+vv5Ky4avJXwdv7YGrtkqeI/92WVG4tILlCNweNJoGUDWYDDwAQ5I?=
 =?us-ascii?Q?oUnCDVcksSN5a3G9CDyfJ1DZjkOfgZdXuApXRZB5bSn/M6jGiQTshktEthfX?=
 =?us-ascii?Q?ebWY7Y02hyXVoPR53QXGZTPRHy/duV6zFChzEsTAbjx5alXVAFvvPY2gobVi?=
 =?us-ascii?Q?Usja+C3PcDTvGH/AjIJu+abxLQKZaxTfiktyhulxLrT4dlKQTqgsLJOhveN8?=
 =?us-ascii?Q?iAqXOatxg+cO/+Hzd4cDcx67m8yfBP4EfLng+k9mZ0rR8SUIYAOMBA14BKqU?=
 =?us-ascii?Q?Fov/zVE2xOlE/xnkjld/63fJbY8w5tq+qqLO/HjanRbidbwgNwiT1pa3TQsC?=
 =?us-ascii?Q?pAjmdtzcglS5ujZ/uvonFySWDCfKZ2Ua8VXuvdIZU0bdlCb3svxDIR1Lpugb?=
 =?us-ascii?Q?fQkqqmdJYBb9wGbae6Ao92jpHERK18WNBcTeyKy69dJkSnv598X3oN0VWND/?=
 =?us-ascii?Q?2zbxbI8PqKmxPF713wWe+zGAtPXxmoV2rIfYi4m5ymWlJWdrFLyFs7BlPrup?=
 =?us-ascii?Q?vCdmgu2Jo3rHYS0mbUvrC6kLARF36yN5R4Dl4lTOV2IxLpAHUzsCGuZWnZCI?=
 =?us-ascii?Q?5/0Z+Yqb1NZs9vY1g5SrxvirSCNaAEaLRSp6zYJ+bjIHGZMSgEgTG1kx2BaQ?=
 =?us-ascii?Q?ZRYpl+5ErIENhaEKnF8zu+TcomlhaS6WVsZBL3D4VhbLinXnBH0JcTyUwT0h?=
 =?us-ascii?Q?p2DQmOiqoRZPDdtp68pq4QUYt+GUPWjV30C9E+Jgym5tHgdywH4QxRP1Kd4/?=
 =?us-ascii?Q?z+AIZLmaM5T3FSwJoh8rRhRGWUEVHYPjvYcAwWJrxIYmrUae?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3705802-af13-4504-379a-08de9e88c886
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 02:59:05.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCJxq8a4NEDvQvCOcC6xQRuFGwni1BxfNHuoR9WjZibwfldgE9ztYYwlqW93s8E4tvS+FeYdkg476ADYC2qf7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704


> On Fri, Apr 17, 2026 at 03:17:16AM +0000, Sherry Sun wrote:
> > > On Thu, Apr 16, 2026 at 07:14:12PM +0800, Sherry Sun wrote:
> > > > Introduce generic helper functions to parse Root Port device tree
> > > > nodes and extract common properties like reset GPIOs. This allows
> > > > multiple PCI host controller drivers to share the same parsing
> > > > logic.
> > > >
> > > > Define struct pci_host_port to hold common Root Port properties
> > > > (currently only reset GPIO descriptor) and add
> > > > pci_host_common_parse_ports() to parse Root Port nodes from device
> > > > tree.
> > >
> > > Are the Root Port and the RC the only possible places for 'reset'
> > > GPIO descriptions in DT?  I think PERST# routing is outside the PCIe
> > > spec, so it seems like a system could provide a PERST# GPIO routed
> > > to any Switch Upstream Port or Endpoint (I assume a PERST# connected
> > > to a switch would apply to both the upstream port and the downstream
> > > ports).
> >
> > Thanks for the feedback. You're right that PERST# routing could
> > theoretically be connected to any device in the hierarchy. However,
> > for this patch series, I've focused on the most common use case in
> > practice: use Root Port level PERST# instead of the legacy Root
> > Complex level PERST#.
> >
> > Root Port level PERST# - This is the primary target, where each Root
> > Port has individual control over devices connected to it.  RC level
> > PERST# - Legacy binding support, where a single GPIO controls all
> > ports.
> >
> > We can extend this framework later if real hardware emerges that needs
> > Switch or EP-level PERST# control. I can add a comment documenting
> > this limitation if needed.
> >
> > BTW, Mani and Rob had some great discussions in dt-schema about PERST#
> > and WAKE# sideband signals settings.
>=20
> > You can check here:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fdevicetree-org%2Fdt-
> schema%2Fissues%2F168&data=3D05%7C02%7Csher
> >
> ry.sun%40nxp.com%7Cd68515fdc0f842ac82d708de9cbb4b2e%7C686ea1d3bc
> 2b4c6f
> >
> a92cd99c5c301635%7C0%7C0%7C639120525411363026%7CUnknown%7CTW
> FpbGZsb3d8
> >
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTW
> >
> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DISzWCMSwqYBdw5w%2
> BDB5ERK51Dr
> > Tf2jzGtGh3wKNCMZ8%3D&reserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fdevicetree-org%2Fdt-
> schema%2Fpull%2F126&data=3D05%7C02%7Csherry
> > .sun%40nxp.com%7Cd68515fdc0f842ac82d708de9cbb4b2e%7C686ea1d3bc
> 2b4c6fa9
> >
> 2cd99c5c301635%7C0%7C0%7C639120525411380537%7CUnknown%7CTWFp
> bGZsb3d8ey
> >
> JFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFp
> >
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5cohkQIgl0CDlrOmD0dDIbj
> Q3%2BVg
> > VOhiOMDRQD1iwLM%3D&reserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fdevicetree-org%2Fdt-
> schema%2Fpull%2F170&data=3D05%7C02%7Csherry
> > .sun%40nxp.com%7Cd68515fdc0f842ac82d708de9cbb4b2e%7C686ea1d3bc
> 2b4c6fa9
> >
> 2cd99c5c301635%7C0%7C0%7C639120525411391138%7CUnknown%7CTWFp
> bGZsb3d8ey
> >
> JFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFp
> >
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DWtjyGdvt4s84HynGc3%2F0
> K3UfkZii
> > naNAW1ypEd%2B11RY%3D&reserved=3D0
>=20
> The upshot of all those conversations is that WAKE# and PERST# can be
> routed to arbitrary devices independent of the PCI topology.
>=20
> I think extending host-generic to look for 'reset' in Root Port nodes is =
the right
> thing.  My concern is more about where we store it.  This patch saves it =
in a
> new "pci_host_port" struct, but someday we'll want a place to save the
> PERST# GPIOs for several slots behind a switch.
> Then we'll have two different ways to save the same information.
>=20
> WAKE# signals might be more pertinent -- we definitely need to support
> multiple WAKE# signals below a single Root Port, and it seems like PERST#
> and WAKE# GPIOs should be saved the same place.
>=20
> I'm wondering if both should go in the pci_dev itself.  I guess the impli=
cation
> is that a pci_dev->reset GPIO would describe a PERST# connected to the
> device *below* the pci_dev, at least for Downstream Ports.

Hi Bjorn,
Ok, understand your concern, currently I've defined the struct pci_host_por=
t  to
store the common Root Port properties and added the list of 'ports' to stru=
ct
pci_host_bridge.
I will let @mani to comment and see if this is the appropriate place to sto=
re
these info, or if we should store them in struct pci_dev. Mani, can you ple=
ase help?

But for now, the motivation for this patch is that many PCI host controller=
 drivers
currently share the same requirement: extracting common Root Port propertie=
s like
reset GPIOs (at least currently in many drivers, perst is placed in the roo=
t port). We
introduce generic helper functions to parse the Root Port t device tree nod=
es and extract
these properties so that multiple PCI drivers can share the same parsing lo=
gic. I'm not
sure if we should take a step forward here anyway?

Best Regards
Sherry
>=20
> I don't know about WAKE# signals.  When it's in a connector, there's prob=
ably
> only a single possible WAKE# per Downstream Port.  But is it possible hav=
e
> multiple WAKE# signals from a multi-function device that's on the
> motherboard?  Saving the WAKE# GPIO in the Downstream Port wouldn't
> accommodate that case.
