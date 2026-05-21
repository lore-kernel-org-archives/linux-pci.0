Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2C299959;
	Thu, 21 May 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334632; cv=fail; b=ELfE4ZFELDQaOfx9sQuPjMMVnbYJDXlvvzto8VUgVIZF5o48mGh7Bh5Z348KuVRmF/0+nA0Q0trB9nOqXfvJdVzGnLe+I2jLjn3OpRDsqrZOdDmsZW/3RmLfjGhuFXtopVrp5h/za1gfXoZE/HlAT/TSfvIk/9NBQoO50rbaBCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334632; c=relaxed/simple;
	bh=PQ+9rvMqQTkP7iMXq0ngV8PV4C5RF+kCVmZpp7V7+uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=burqqC6/wiwT1vA7cGcip1lhKWlNQMw2P9ruAJvKfnaeHwMJ+Dr9S5cKjBd9UgNyLRQtb1wamvAcs9wOZto2GZ87l6ydK4Y5h/ShkdH41X3hGmdzkepWhEV6RBV0+tElrM5e+QnJYoVG1+aRE3Osvyz8HNTmkg+HaLZLoKJQb7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ARZNy1tB; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ARZNy1tB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KziFWySbI7P/6eTf+tsuWa4ISwLTIxRc5DoD/UYWwtUtzm/wkAdZhmXpwL5NkiztI6zOsawSwo4S1tc0UCfrFzM3zpitjv7X/vAslR2+h8sn6M3U+a/4VYu497HctHfPiLvY/5+i8fN2CqXeMN3TMBd1wgDciT24Eiw1IFqQzbCnUE11nv7Y/j46zqsSzQJs2D6sAgXRYyx8W0ScYmYwLBiKYPjt/MU0zk9gNl3xyR46DBwq5Yg7s0ye1ND+JEWBkyULMaqPW5BdgZxGAPEsI3jDC0/Va9l4LVSm+BH+NBKJBJjR6jFv0HfE+0SS8qC3Me0wdYPi4rNSh2Rk77HSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naQO34UUyOAr6M+zWdJK0EE7IP/dorwJ9ipS3j6L+P4=;
 b=g7UGlBWXyZYLxOLvr8oNbkuC5+AaVi8M9rbeWZxN62dGVsBhwYLWg/44jCBHBJbANinydhpuOkVEM1qP3KeOAK1vuUDmILgJ7Q0GLtCjzclXj/KrGSGGcJ5WhHV3+a5Da8WX2XC7/KLF3bJUy0zolEmAuXc9OPs+bkzx9883JV8xJ7rrCjfzO171pwMuaPCFRSxMUGPz1BQwkwy6QsRoBACoHAG+mfTmQMIqc21H62ftm2MJxoJkVc8LO8OW3ow2BRlrOA5/tC2x5vwzWsbnDz+7TITxjojslYUZHOEc2d/8hcYczW6K69PktUCT/51WPm1W3QjhPR91CtGfIwBZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naQO34UUyOAr6M+zWdJK0EE7IP/dorwJ9ipS3j6L+P4=;
 b=ARZNy1tBCkaJ9ZgTavH85DDrt+v0N71KuEwak5OZJw3lIQttm8+3l3O1pABO/LL766tHYIA999nYAgDx17y9xBsdR8VIBk4AnQPbi50HDfAL/oTzqvdIxv26KtOwJvj8aAQLV03gFbl6hxbT74dCmvzkHnXsT1aq7K8acISo4f3wXyxXcxI9L/AyckN6/vq611ni92qTH913xohMue9cMQfccM7OM9dHGeOU26J7xtSlgJTfpTz/QXPlvvpef7MHekCqKpAbBJJXFk0FssKWpMbm/ZDeNBAF8GzHmJWbFkdEiS7vzbViA0YvPbTXQwLeYQbBibNfPW6x6/Pawovauw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PAXPR04MB8798.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 21 May
 2026 03:37:06 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 03:37:06 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sherry Sun <sherry.sun@nxp.com>
Subject: RE: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update device
 trees
Thread-Topic: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
 device trees
Thread-Index: AQHc6DU2+3vZVI47F0mq/ddImxZlOrYX1Nmw
Date: Thu, 21 May 2026 03:37:06 +0000
Message-ID:
 <GV2PR04MB120194C8BDA9B49C79DCE72168C0E2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PAXPR04MB8798:EE_
x-ms-office365-filtering-correlation-id: 2578e9f8-812a-4624-bb3c-08deb6ea3b1e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700021|921020|56012099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 DKOSgxxxEnVJ9sZmx1LL7Rkxkm5GM7A8ZxM5CvYIhf/pj1MYLUBmTVpOxf/F0rkF+1V6Ueh3ttLS9ps7NrXQADFfxxKk9fZLbOKW9OU3K5Y9EU0TibEUK3RneTfQ0V5S9EcyY/L5GHOQdIYjYLrLM+puH8a2SgzpsSW0+2hwv9hWhKvsitucBTjJqvAEDs5cy2B3xc13q98IqZumIJS2Uj8L0MhUGQAxiU7ckmIDKPpt5Ja8fUpVIZ7KFZsRhs3ZVq5sWgJ7sjryvLI/NxwZHJ0wbGvuEZntpzP7d9izuQvz74b7ed+RhYC8kFiOTc85MOarC2lJcf9KhXEsbaSyNy5L4khG6uf1oo7OKqoITuDy7mnE9+kJumsuBJYe6oBgJsfd/ozVk3CUXwrNBk5fRHkIkdZlnpZ6fgThuaw0qYk2Q/0oaqoMKnW98BwaF43x1hF+Z29KiDwEezUXYZ+hkHZJWWg0w56W1KPvEG8A4oFF+sHD82QqC5T9ZGh2yc8WEWiZYJo26vrq9GIgO5daqhe5se7C3bje2LsFmi9+wKH7n4un3inzLZbtc+i3c/ALmaRiuVRPsemP9N+v15N8rLA6c8vXpxt5crC66etQ/zbTN0B5wiPzFaPp7m5CTZJm/3ETfdZruySJ9XCHdjtq/3HvpbKIcrUWhUU1Kv9VnmNHZeOBFLE/Ztwkr/MT0miLSHwC3vYuPi9WPTPW+BY46sY8PtLXvG0WBgBduc0J4rH9fAm94HiPg7vIGkYAMPm+mhdHYpxeag81Oo4AtYXkfA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?faPQ+EZN36h7bKxdHhXrgYjiHq6I05yrrSgz685mH09Zb6USSacpO1SwcQao?=
 =?us-ascii?Q?p/SPL4I48q/IGxWABeNlC8HRdzQvpYmP/GqykK5/Lp0qdFWmy2jDTcd3fLEx?=
 =?us-ascii?Q?ZB5YZBVL9LcItkjIVd80WHxI0Rs/Z85fCOJ/58OP5mOeMjCDyzeppAGOCSRq?=
 =?us-ascii?Q?9/cvJ1ao411V2mYKiPnVkIG+ufLdsJyy1Bg88oyyc7aQMmBZD/Up6rSVio5O?=
 =?us-ascii?Q?Bd3RKzHDfAj5OPmJrciKfgqIBvnhzP6aSzJ4OoKCKCp8gMsUV2d9xvQKGHjT?=
 =?us-ascii?Q?/f1UrPDiwDmts+zLGB5++kfuxyY1/QiBDaEK6ZDMrHJGiDHAG89ANDWMSsz2?=
 =?us-ascii?Q?9veAwnmveClXU8bRzg4FRrs8ibkOL6ayDzuIEf1AB+H1wXo3KAnDRonGhTQZ?=
 =?us-ascii?Q?V1TdJGeHrbpUb6PvB5ZzMueU+UjYSipMlv9v2PkTQB0yayWf5UwjMJ+gZB5M?=
 =?us-ascii?Q?WWxU3oIQyZlL0nnCVj7mwW3LNUkmph0/rIUZ3ECGw/+DgL4fTv7VNeXSUPdA?=
 =?us-ascii?Q?RsBHHzMdwPmqfgb3t8897l7lvSAcFe5msBXqbYNi+0NlUyh+FgARGRp23lpY?=
 =?us-ascii?Q?w/JD99RCYdej4R1zWCJFw6saLUGa0PSIlkoYWISkQcduElmjZYyyzDCW6clz?=
 =?us-ascii?Q?n5ji+E/hR+AdDlEC450zhROr/7qeMSqG5eH2f6UFDrrtEwUUqAXcBN8WmSjs?=
 =?us-ascii?Q?ATrpHMDuFOdKmdZjoLbFz0Gqu+2ioS8v7bp7op42FOeGQvS4LUT4FQteHxZb?=
 =?us-ascii?Q?15Sp/TzGkNLnOZws/3uy0HgGOpJ5Fpj9DIVAgLcwfkvj4CIWB6mMfY46TpcI?=
 =?us-ascii?Q?bW7zbcLDjcj7kMdgAFHME9FP5ORD630u67QPK8HePw4qdPMe//Dc4FJvrHXI?=
 =?us-ascii?Q?1j/E38mu8dTwcTiHVty3V1IqE6xUBpTVocFZLmqApNWzSfqjWGvzyvD+lB0U?=
 =?us-ascii?Q?asBG425nzuqlpYu5Cuqk2S4ei3sNeF9LFcPZ59YJat3uC2GLHgoZxnomiyeJ?=
 =?us-ascii?Q?2EzIjEWHETdEPqFik3KciwUiM56wE08qkGVP1iEL8tTKhn3i2bdawMOVmtE2?=
 =?us-ascii?Q?tMbcYUwnZNtq4+32o4KjMwaH0OL3yfY+4n2s67uPkwtSByD7txsC7UTL6JBv?=
 =?us-ascii?Q?vPWCSpLX7iPy6FsZ+8Yqkv5irtS4smxjbHnFFagKaN6RU18JIkbs/mJxpaxc?=
 =?us-ascii?Q?S1cBVnhtdRYAuhb3HRfUzf989a61hWINhmzli8WGedzbzO1tRi2z1ItJd9D8?=
 =?us-ascii?Q?IKVQ9EYYvuW6BtvB6EgHrc7Js2Svwwh3d6cf96mnVAeXPCDoHiYT9h+rwJnU?=
 =?us-ascii?Q?N9GtAZ5j8Ao32LEWjE/qswAMXrA0FkwcwfWiUb5UzhWRlLyl3A8yKO7cfIwI?=
 =?us-ascii?Q?iz/VUo7kmk2m6aPyoXtjP0iFa8DxXhxvTyA5TzTUF1e+G41gAGHHQiv0R9rR?=
 =?us-ascii?Q?0IMsYfSG4DIhlk4EK/tK+AZR7oIrXrIwlVJvm92qLdVkvn2NNQ8lsdJACZX/?=
 =?us-ascii?Q?BnuMIwiU2SSCvY23DtZjX6mZyon3OxEnprewjphYPm5+pSI3nicQJ0ED6HET?=
 =?us-ascii?Q?UEaSFU/+Cylm+LTQsL4TN1SHP5Xr9uSmilfbQWi6rhHWRC66zXjZTk9YRkzJ?=
 =?us-ascii?Q?S8fU0lKvuXAZiQXNNiQ4nH8CfuCdQB05jFhoJfOm4xDLS1akthAWBj7MH6eY?=
 =?us-ascii?Q?gJ/fUlLuoSsNcxX0PjTjg7tVlUlIdzjgQ64Tv8dXT/D+b+1vgCCbTo6PF4Rp?=
 =?us-ascii?Q?jIFyGA2tmw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2578e9f8-812a-4624-bb3c-08deb6ea3b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 03:37:06.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB41cO6SR86S/buOcBuqQdTiH9eakwwELEfTZw/DpVrm1h0Wpv7AJ0EWCcSvvXyS6YRxzNc8ZEN11PfWvsN50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8798

> -----Original Message-----
> From: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
> Sent: Wednesday, May 20, 2026 4:49 PM
> To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> <frank.li@nxp.com>; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; lpieralisi@kernel.org; kwilczynski@kernel.org;
> mani@kernel.org; bhelgaas@google.com; Hongxing Zhu
> <hongxing.zhu@nxp.com>; l.stach@pengutronix.de
> Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sherry Sun <sherry.sun@nxp.com>
> Subject: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update devic=
e trees
>=20
> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> This series integrates the PCI pwrctrl framework into the pci-imx6 driver=
 and
> updates i.MX EVK board device trees to support it.
>=20
> Patches 2-8 update device trees for i.MX EVK boards which maintained by N=
XP to
> move power supply properties from the PCIe controller node to the Root Po=
rt
> child node, which is required for pwrctrl framework.
> Affected boards:
> - i.MX6Q/DL SABRESD
> - i.MX6SX SDB
> - i.MX8MM EVK
> - i.MX8MP EVK
> - i.MX8MQ EVK
> - i.MX8DXL/QM/QXP EVK
> - i.MX95 15x15/19x19 EVK
>=20
> The driver maintains legacy regulator handling for device trees that have=
n't been
> updated yet. Both old and new device tree structures are supported.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Hi Sherry:
Since the vpcie3v3aux is used to power up the WAKE#, it is always on in thi=
s
pwrctrl framework whatever the system is in suspend or not, right?

Best Regards
Richard Zhu
> ---
> Changes in V3:
> 1. Rebased on top of latest 7.1.0-rc4
>=20
> Changes in V2:
> 1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
>    device removal"), the pwrctrl drivers no longer power off devices
>    during removal. Update pci-imx6 driver's shutdown callback in patch#1
>    to explicitly call pci_pwrctrl_power_off_devices() before
>    pci_pwrctrl_destroy_devices() to ensure devices are properly powered
>    off.
> ---
>=20
> Sherry Sun (8):
>   PCI: imx6: Integrate new pwrctrl API for pci-imx6
>   arm: dts: imx6qdl-sabresd: Move power supply property to Root Port
>     node
>   arm: dts: imx6sx-sdb: Move power supply property to Root Port node
>   arm64: dts: imx8mm-evk: Move power supply property to Root Port node
>   arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
>   arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
>   arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
>     node
>   arm64: dts: imx95: Move power supply properties to Root Port node
>=20
>  .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  2 +-
>  arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  4 ++--
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  2 +-
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  4 ++--
> arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  4 ++--
> arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 ++--
>  .../boot/dts/freescale/imx95-15x15-evk.dts    |  4 ++--
>  .../boot/dts/freescale/imx95-19x19-evk.dts    |  8 +++----
>  drivers/pci/controller/dwc/Kconfig            |  1 +
>  drivers/pci/controller/dwc/pci-imx6.c         | 24 ++++++++++++++++++-
>  12 files changed, 43 insertions(+), 20 deletions(-)
>=20
> --
> 2.37.1

