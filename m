Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5D2DF719;
	Tue, 11 Aug 2026 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409246; cv=fail; b=godCMoR6R6mFG9KTPPXKyXrK8aUgUnF18ZBN8UNumyyS1s4/lnbd3GhPD15aGYD/O1YFx6zFa5lG26rB+K5e4dHDdHKXMPUZTsAlRDfw5MK7Iz5GXJi/PtJeIyJYZmNgWYdmCEylqD8emZ29NZLYx8PNT0FYezkMNwc/M1nqs0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409246; c=relaxed/simple;
	bh=Z6fTnjtLqQwX5SnDDNO9G9bWED5F0Gvxr85U4GNsGhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZpSEZRIkFRQdAmA/PchBCwvLZYj2f4+MrfLtuu8YoKehVFp2eJ9T8C/VYBb8eysC4zcvpReLGVG5jSMx3keho66SSuwXZLimHNVMocpj6skAMT8GOgdpTPzETdRGb//Po3Ul+mFLBziihjczzBmmu5K/Y+ge0HsrE7Mx5afaJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PypQYrD2; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PypQYrD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxpMZpJvFhVDvOE20TSOsop/GjzSCW+0azUGhd5kHJSakB1NMrEE0fMoaF9OcsTqTVaXzsRGj7GgaFuxyj+gEC+1Eoquo3NQiFIRHs2K9JYYkhqdOFnUxoz7TdKKvG8uRTrXepOAnnjPspyLxWywEGULu5oMEBS6tRnBqaoZtoEKcANLDbbSsWID4wGNcYlwAt2KjHkt0PCmSK/oL9TZesfQ9GthywBpR5pq8yaWan88058mNIKboDUQ3hYEWLMxRjCSLh0dA0eFI1YJLzzSY4V0NDOzVW0m4R8J3CZ0EhspPh+9qasK0AgdoPInR4d6MmzolhdeQgY7+sPNOrjbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pODbT1gXys8QfoHWKyRgktINcxXT6fSDonbYg9Y1tsY=;
 b=oZ5ImiCF+4qkc+NQtcEIH79clYPRP+JsDKdstXvw2QI0YzGcJTgfFDj9TyUEatNy5mufpQKbBIUiSOk3DkUkQx/eMxf8jhuKpprN9wL8RJBV39BAShwY1cjjGDvLexsoYKdWhdn4qoyBDkuZIhVBV6cUNwWfqLx7ZPF2imEwt403Ns6iGGQyXIa2vLQtPxLN5/i9OfmGySZqsbUqocuqAJczlMQLq2LP6zOW4EJckLkyge+k3mWJW5CsWC1IH5hf5QcH9TB0IDNxES6UNvoJThXbUxGmpq3+kjaIwVogy3gu7M8YqF5FvdA+hKkndpZLa93OeKa0AdRTmt5+HXYkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pODbT1gXys8QfoHWKyRgktINcxXT6fSDonbYg9Y1tsY=;
 b=PypQYrD2pJFSn5kkz9y2NDwEvNCnJjE/zNn55nh9kfte1JsLs1aVb6xy7PFY8oEVknD61a2mUldJnGgg+eF6TXaOS3wWgMXZ420kqfxZwhUL9megvZCyE6i9Xu8mVn0Yrqx9KuHhhugCDY5SiR2LqmGGwWa77v/5X1V0sGDVUDbDZwfEQIRnsfUDD2fnQ7Jizc+rEUdQrn1PtdJsRds2kV5wdituW5YsqkKHfU2J1TF8ZmWasDIcKg1D9K5wd9+2CHfjzXkr0UPBdfNhIgkiPvnpCo0lCn71mWn6I5TNEqeyFL6f/4Jnr4p1RmKreTbbDLdN6CXlaUPHRz9b5zNUXQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA4PR04MB7680.eurprd04.prod.outlook.com
 (2603:10a6:102:f3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:47:19 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 00:47:18 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "leonardo.costa@toradex.com"
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
Thread-Index: AQHdFLRQqewhn1aJKUO40yds8E4l57ZvZwwQgAD7KwCAJ1/lgIAAYssg
Date: Tue, 11 Aug 2026 00:47:18 +0000
Message-ID:
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
In-Reply-To: <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA4PR04MB7680:EE_
x-ms-office365-filtering-correlation-id: 0c1c1fa5-5a8a-4b3a-4249-08def74218c4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006|38070700021|6133799003;
x-microsoft-antispam-message-info:
 7dXM3wRpYQpFNMo17IRhawyN5Sdu/aKW8xUYw6DQ2vgcBPDChQNth4NlyZY21ot+GB+pipb+JNwV11LuwZSK2PFTNSpvD1CjvYNNe48i2orEh1h5m3e+rydguIhRHSjt1mZUn3HZWcKiBwujBybyHrMPH0IfdJgLduIrCztslnCYi/C/GZ3w5AIw14FRz/9HbgqDm25Ic1r9e3IwE+1Fmpj5f+z2E8NQXny04pSOCHrOgFFLBa5RVcV3ctxWLj1fDyGHynfMvKCA9ufccZvSlnn2biFLLleWJbNj+NTcSajbcOIMHLZGXqBP4YtkL6jP3WCP1i4dkJgktbugviL8C8vPcAH4MK1+p+X4bJb8f4pjY/G1hwCs7Ai1YZ7UIr3QDh4Bba8o3jba8Ka+2X/qCN6KGyWG8OTrrKzdr+8fggIxWB8N1U9xMk3g+cv5Zz7Kz9Tb6KEMyzYRqW/DZXYelYAtFGHHAmhk9VTXYfW5mrWJx4VrfC/lmSWMpAgzUDXevY0lDdqHtKv40eN5jq+MsNm7HtZkAWl+zQxAVeqcHZnP6HTK3kr+5X8dFaYjEap6tt3nzrYTJD3gTJdKOm39YbwVD3tSVGmmrMq0CNZeAiOEh95b5B12WtNEPN262FfraIUPR8cJEG4A7g3FkSGodJ6FKeRy1skI/cwUHRQv5G5IV40yWhIDC6nYmtb7EtZJZ32cTk9VSD/GhJvb4wRR8VIz76WsOttd4aLYhMbknrc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v9tYQWnLetVjzULPf/8dDUmncCLKcy5DnuglnO+zaLmMekeKndtZSASOpNci?=
 =?us-ascii?Q?kOIcW9frm7eS2JGp9AammhU+rPqD8OUoYLZJPh/dN9pxh6fjnrDWzwIzwodv?=
 =?us-ascii?Q?zyl2nHwrKHhEQkJwGipkrfX9ROgF/FbbdTY0YJPH4ZRpjmHfEzGvxxorwQOJ?=
 =?us-ascii?Q?cU5q2s2stAnxbqo5noA1Ko+Pi9KiKe1ktfinJl4hT84eDcplJPSMSs+HUlf8?=
 =?us-ascii?Q?/vxuP+WaOKV0DuCN+eWnM/2ccjtf2OigIC2ln+n7F3tDZmOGOQh8Mpi/gbZ8?=
 =?us-ascii?Q?anegl7nQmdsv/B6ZIf2ftGw6P31MY2+5tKYO6PPeIH5jjy1siWc9GzU/tbxH?=
 =?us-ascii?Q?gHLiU0tesXseDMZ5lNwjzqTXK50mmOWfd33qOjj8BhOBPLeTSx70xAZd9U5N?=
 =?us-ascii?Q?BUlvhqOwAZh+Xyf/tVjcCKz8T8wG3VKwrcuu/KnvCrkbitBukHS2c0SfLP3c?=
 =?us-ascii?Q?OQ/zxSC2WfwfteO3Lw742ccDHaGJ8ZSkGTZKQuGkMOtrRsk2FJLhd+9D547r?=
 =?us-ascii?Q?TnDNH77oh9FBujXQVlClOsxjYmRwt0MgDTWEF7D+kcokx5HZaf4DIbHvEJe8?=
 =?us-ascii?Q?mmNsbet/hvB6jZG5QDwLI+H4aT0Ubni03HDzBtrfs+Ev5MSJd1A4RuQuJKYl?=
 =?us-ascii?Q?CjQSJsz/aoawWmmToRqyS9jnCzvpptnM6PCz/pU+5mmuUdoxIr3WTQyA6a2H?=
 =?us-ascii?Q?bv+mgk8VkW30MK3zCmv98eckxQf971cvOWG4sn24ekznMquu4mUamc7FauZ9?=
 =?us-ascii?Q?QE/9kal2GCIKJSC3iU3LBVIn9s2SVpPAPXjzbJYNCjn2LqQ+3JC3NBGbvJ9t?=
 =?us-ascii?Q?nxDNXCfFGfzKAJUYnb3D4vKQvsMBVSh1r3QnN8k4EbRl2ZB5rPWUHrmmS2lK?=
 =?us-ascii?Q?a7w+5+x5T4GkVyo53GdDxSZ9zvbiudNgd9u4rUSNqNtooSejQY3mq9Tn9nqZ?=
 =?us-ascii?Q?mlJ+tYipnG5CIVw7xUGAAKjdCiFNMKC5W93bdPSAqkRh8UcyPNyXeGnz9nNu?=
 =?us-ascii?Q?REf4bdlqNnxv+FHEXjiWtbiwUCptSSIV9biCL6NTRHk2S2gQmv8W7Cawiq3P?=
 =?us-ascii?Q?If9556+q1Y6ZpElszaLI17CqK+iN9laQikZrRfw1D2BdAmTgA98hr41swrZM?=
 =?us-ascii?Q?HuPNBt6Y4CMogsWjIR8GnIN47k8Hw0KBcJFbm6uMnYgLXDNXoCJJiHHH5umo?=
 =?us-ascii?Q?Idwh4Mc1t13D5e0giA7I0SFWxq8NMXbdLXSvVJ7jdw1v8jkmpDCPIuz7oUp0?=
 =?us-ascii?Q?hBz8u6htmBqauZDKFfEYoT3XPPTuf/g9RbRWkHXTeeiobl4hdnx7FkBZaRHV?=
 =?us-ascii?Q?X3iK9SKs5kU+aAB7hoCiwxf1jm9o1NFYN30JCXIBY4aRFeN/sP4oH7YY1F+T?=
 =?us-ascii?Q?ZkgbxX84fzx4404OI6aeuA/0L0y+ZqcdUSbkrH1m1mlnLtWWD3q1pqQ/DLhx?=
 =?us-ascii?Q?6fo+CvBYpRhly8CtZCF3IuNCjVEFsB810lgmHPyNBf7DC8TyVJlnVQZY85EH?=
 =?us-ascii?Q?9YiiCdOhqLORUIOyQARJQw09qI71Hdx6eiiPrBPGsUdYsauS4UCdTwQvxwtw?=
 =?us-ascii?Q?ZXzauGjvXXBnEm46DAUpdPa6pjB2tFKUUwZcAuuQqB9KAuOWn2rKleS3LUY+?=
 =?us-ascii?Q?wz1gCMV/2rEO9kpSNng/t3Da58VwLzLvduTNVO8ML7C/TNE9D8JGK1iU+E/5?=
 =?us-ascii?Q?/5OLZG2hCLpIoVzqG9Y7mUQ4fmr0ITK0ja5bLxo7Z8yCUlq9t8Ipol7HUlEQ?=
 =?us-ascii?Q?mOWbKY5HKw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1c1fa5-5a8a-4b3a-4249-08def74218c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 00:47:18.8252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fvi2hXNIA8erf/+VkOI9ecgXGR7Z7xzu8m+yrw1SxShRop7HqQoJgJvqkeY2TV66wwcTOqnK5R7dyilhDe8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680

> -----Original Message-----
> From: Leonardo Costa <leoreis.costa@gmail.com>
> Sent: Tuesday, August 11, 2026 2:26 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li <frank.li@nxp.com>;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> leonardo.costa@toradex.com; devicetree@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; regressions@lists.linux.dev; Sherry Sun
> <sherry.sun@nxp.com>; Manivannan Sadhasivam <mani@kernel.org>;
> Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org
> Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
>=20
> On Thu, Jul 16, 2026 at 02:09:19PM -0300, Leonardo Costa wrote:
> > On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> > > Hi Leonardo,
> > >
> > > Would you be able to test this patch on your affected boards? Your
> > > testing would help expedite the merge process and ensure the fix
> > > resolves the boot issue you're experiencing.
> > >
> > > Best Regards
> > > Richard Zhu
> >
> > Hi Richard,
> >
> > Sorry for taking long to respond, I was caught up with something. I
> > tested the patch and it solved the issue. I sent a Tested-by tag there.
> > Thanks for looking into this!
> >
> > Best Regards
> > Leonardo
>=20
> Hi Richard,
>=20
> That patch might have introduced/exposed a second regression where PCI
> devices are not linked properly during the initialization. Sorry for not =
catching
> this before, as I didn't have any device connected during the previous te=
st.
Hi Leonardo:
Sorry to hear about that.
I did test commit 7678e81498e2 with one Intel NIC (82574L) connected, and I=
've
double-checked today based on v7.2-rc7. The PCIe link can be set up properl=
y
on the i.MX6Q Sabresd board in my testing.

Here are the logs:
root@imx6qpdlsolox:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Conne=
ction
root@imx6qpdlsolox:~# uname -a
Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l G=
NU/Linux
root@imx6qpdlsolox:~# dmesg | grep pci
[    0.256138] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 range=
s:
[    0.256307] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff=
 -> 0x0000000000
[    0.256339] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff=
 -> 0x0001000000
[    0.256434] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 =3D=3D cpu=
 0x01f00000
[    0.458388] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 6=
4K, limit 4G
[    0.458492] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
[    0.555294] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
[    0.555783] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
...

The following endpoint devices also yielded the same results.
root@imx6qpdlsolox:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapte=
r (PCI-Express) (rev 01)
root@imx6qpdlsolox:~# uname -a
Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l G=
NU/Linux
...

root@imx6qpdlsolox:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (=
rev 04)
root@imx6qpdlsolox:~# uname -a
Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l G=
NU/Linux

Could you provide more details of your hardware setup (board, connected
devices, PERST# present or not)?
This may help us identify if there's a specific scenario that triggers the
regression you're experiencing.

Best Regards
Richard Zhu
>=20
> Link:
> https://lore.kernel.org/all/bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hp
> gwve6@n2m5uhlduw57/T/#u
