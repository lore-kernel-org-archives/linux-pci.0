Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94372A95E;
	Thu, 21 May 2026 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338441; cv=fail; b=Dd61LGTmjsZQfAXH+CefQ6XXtfhuK666v+GObJjms8Gxp+wQqWBFw2q6Alzm1cZoSBeIpcKyO2D1Lf5jGhadndxbP7pCTu9H/eGql/UYvYiqbHmBDZ+7ebPx2xCGQSwzHFSmECFhn3Xu922QZ/p/rALWHO2c2WqaRH9xbc5/nNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338441; c=relaxed/simple;
	bh=BpUqxZJNtavLrdNp7mRrJPW00uRmJhbdqeaMadu0jww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmHJzauSoebg6ljsLF+N7aDspxRPiqYJntl6N4CJq0IY6fjiZAcBp9Ot9nmFMWSnyYJqaWww0WE0qWtLtItKE6VvdqYFhgRBGSuYy4VPTVv2MNW7scWh+MjCqevn66R0lhSuSryIJOBVmmEjnpHRuDiayUji0KJF1zFzkPqdH7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LmYxvWQ5; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LmYxvWQ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS3ILBW9ZCk6VMzdjoLREeJOaHXzAKnZfO4UtDcFGdm/4os+/VATyxiwg9AQgrehsRSN+1tUsNjn6Kdlg09gCRBAwNqPzKYYlvwmOv0+LnlkCAn5egn1oVW+v3mCYMe1RaYmF+RJcYQhTK+8Jyp8gVbpACdMS4yqtnqjEpGNsb5fEK2O9/rJzg6s/3SuWCYpcpn1LC754XfAPvX9hPaxmS5JqFVRCf6/rVDkcyiVcioVtbOunAE/zqOdnWHYpotl1IOJ73TefX9vYVsqY2n3gp9vQ/ggOTEeT1+MYUwrFrmDai+TXZlWCbwMJ8+z0paCRKmec+zv06sD0A1bYb3RAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOozYLDWswYe1wY/gF4cOgu2D284yEH2sP0drm8bq8k=;
 b=jj+zw1T6y4hrmuJw1DkiRxSvt193o28Tf6MD3Ay5e/+7tDGMbhAN2JO5J1wIS6D1r3LG1CEHsm36adVFV/+FE4Ur0QjrlIUMF3yLL30I/BvCa6R9db+X9bB2EHbdwZGrpY/wT4pSVesZ3R826nmvaquRfYIA3U+mfaZkY8y9kehiTc3KeXRPgKwVBAA/f3nJwsd8upSxqCk9ZFyl2hi+iyrecYfq6AM3qQtB2MLOq2Iyit08qqDKll+u3hLDcVru/RExQdAFX6Ljf3hA7L++uyyFRA21MPcphq6mFu678MI7dAZyub6NjaW5IkF3Aea/th30Q3rZGx/zte6CRXcu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOozYLDWswYe1wY/gF4cOgu2D284yEH2sP0drm8bq8k=;
 b=LmYxvWQ52HrRsXwMADE+e04PH1S/EeVGG45PP3Y4Rz1HCAaaB8cpBqVgP9/9u2ro7inQ47xRJjo3kkSOIR2PKTY7S6qwfAKLAUNljJbDglqaG35dUKf450CdxeIYoZePN80HvvwwrOqcI/R5Q4xB4EeFYlWikrUnWhu2Xbut+F8YdQ63ahtoQRiX4gNfLmh0pBC94YF505ZoQRxHOu885WXCmquyaCJgiLbWAgCLw5rF1/9050yBB+n84/yINmtB5JMy1+wcfMjQoBUxKAwGaCbSNY+py1LWEvBgdbR651ScdOFQAYkWlgqwMmUbZifr0+Vr3yNh/f5jh7IXBO12Yw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM7PR04MB7032.eurprd04.prod.outlook.com
 (2603:10a6:20b:112::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 04:40:36 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 04:40:35 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update device
 trees
Thread-Topic: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
 device trees
Thread-Index: AQHc6DU2YdAUpw9yUEWcsc6vIequoLYX1cYAgAAPP2A=
Date: Thu, 21 May 2026 04:40:35 +0000
Message-ID:
 <VI0PR04MB12114B321EB4DFD68B7030F76920E2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
 <GV2PR04MB120194C8BDA9B49C79DCE72168C0E2@GV2PR04MB12019.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB120194C8BDA9B49C79DCE72168C0E2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AM7PR04MB7032:EE_
x-ms-office365-filtering-correlation-id: 3c6552f1-72e9-41a9-a3d4-08deb6f319bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|22082099003|56012099003|18002099003|38070700021|921020|4143699003|11063799006;
x-microsoft-antispam-message-info:
 jEUiuyzgh6dOnBJJyW30rw9OeuA7YChR511IMd6zvgDEB6nVX9Mp2Cw9VHc9azPoczKp5yQv0y0f3iovlPVD8jIMjAwxGt+KNMlF3utZDvdVTri8TXf0oJLQMHdzHjtPdcMv6jFrMVRggjXyRJRIpy0sPA+xvPzy0rZeTsY9EFMPo0NLgX6cE+UpiUkTiGm1jKRjQ9Q6qIXelLMVXm1weMdhJl3HyQU0zH0xpP33xc0J7wYcFR90wBwjade0LwDnyyPcqi7vcHjg6AUIKv4fhr6iCe+L/lpoj/LoLHkxAPwuPVa7WJSfdcVSPF7GX7wSNleUedcILkae7stqGZdqSuY58eXTG9Bzba073qppZPsF52+r987xX3CA7tS0mNZ8Vah0k6Z2/U6whDOC0mUVQ7y3ZK6zGlqfkDsrjhBHepeX6jwwAfPyIcj26f/TLD9XXGJhc0+tooU07w0T2Q8irnHZhKIwV2UeBkHdGrdKzUsuoa5+5OqrYWYCFhDW1to09BLc9twW+EyaEdCObK+j9RGTtTaM2f4wz8SsXRmWyXi0XgnDfwfzFUsiyvOJeU0Q5to9JLlCI/ydqZCsZpfGQbyTX7Ko9Mu6E9yS2xiiYE/MbjmfoBHEu1NAHKu6dFNzAocGtOH4RHHpROhByIUbYl3ppgx1dHpz+LDESlnHbSNPgYfEVaz8TqsbImoUrtmKKF3HJ7IcGJ7XK783zgtHXURNUQUV/IiJbKjp69DAwtlv8S+2YL9bGwfeYJ1L8/4XohnWGK2DeZKmyZvgUJQj+w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021)(921020)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tkcJq9o//pxuMxK/xMRPHT2YmX+PIyD70hTBISay31FIQkaaINHOfT/vRA7L?=
 =?us-ascii?Q?t5p03XQRvxi1FV96ZTmAQb3667hADp9OhIuRY0PNQDZ/u3pd2mnMEfkELCMD?=
 =?us-ascii?Q?oMRqce4Dye+9zmqDyTMtPqK5iZVrT7cO1vCdLs2vkTrgJrxaGVH1JQgZh41N?=
 =?us-ascii?Q?odz6Mfd0tDj7g6Utoew1vjgX1fm1YhuctVNpc1rXYc/1fMlkvD1l7LChhCIH?=
 =?us-ascii?Q?I/o38YgCVRI5voEZ9XDAFhFVfjl4zn9DkoRj80AFz14D/GghGcx6crMQ/MUG?=
 =?us-ascii?Q?BpppaBfmtW+FDQH3338wjcUvm4WqrdboN2ma8ChJP4fRwT9spHvJ27hkNSMf?=
 =?us-ascii?Q?1k9la6PXuRrsq1Kd/9eyk+qewNnmInNA8v1ZJwjcZVcC93bCME2fkOqK9htD?=
 =?us-ascii?Q?d+5zfhiFyuB0UGI+TuS5VzeQCmxS50O5tTZVYtfdo4+2SbfknR8TTl9HP8id?=
 =?us-ascii?Q?Qc5jDyuGeUowOpJ9w2mmNiFKXMipGoBOsZ1G0W6lLcZzUruvyQmS+xnugFhL?=
 =?us-ascii?Q?Maf0JPQuz5ebjb5y/cIKUxWGvXT47g0+L8/d1Psed1QHYbXLFlH74W3SWXwW?=
 =?us-ascii?Q?J7WSfL4z/UMd+uDlphe3EE/35JLa0AvgfLjb898yTwUcPgwxyIe9lWCOzbc1?=
 =?us-ascii?Q?WLiwls+Av3BcH6zv0jtZhaMeyTzltwCDhYJ/Ny2EJ36I9leRWDda3g80tEVc?=
 =?us-ascii?Q?bQFh9FOLmcAUYoTSlEsGvdWDhdtZ4p3bL//28dRZEvxnze/0t42/0nLqyaBo?=
 =?us-ascii?Q?rAvWq15i/wvME6WD4uYb3pKG0Y9ErpeED8LhfYuOxYZQfIsSzeGZAL/xxVUr?=
 =?us-ascii?Q?iRstVwH+vdS7iao3+iQ4fmE5vwuzJKFViDR/2ESSzvQmX7j4pZUM3M/Zc8Ur?=
 =?us-ascii?Q?gx4zTaYhuQrbtb9LeO/GXf5JNkLPQ45FPHkk7ONDRK6cY7Fz+VGg7DZJqQN8?=
 =?us-ascii?Q?DTqvkiDdAGNO++87m0tDz41QuHim/W7z7lSQyN9WoDvKJjwIMi2nEPTLnuha?=
 =?us-ascii?Q?5+BeKVqeUrQ9EZA/P8hGUNSb4CKzG+TSv/aJbtbWKyCUcGfJ+ubjoyBQ4Q3R?=
 =?us-ascii?Q?PWWYce5DvAe3UrRiU8zGLuN51H6RsdNP/l6O2erTLshostm4VcL8/cR4PfIw?=
 =?us-ascii?Q?a9N9tmnYmJJKkFUeh7BRO1RW9TXevxLeNPZdO7sI7wZPMLvX61zmLsykO0TH?=
 =?us-ascii?Q?fhwjaFc5bdqpZzQ32F/7OtA0z9s75aiIMpr5iy+ulXBZS8gP/QSmUP3ytAey?=
 =?us-ascii?Q?D3RuEJFKMiAQ+fouAJIwmkKeLQJT1mzzvae/uaSFmsiaskwvRLkBhOU0vRXy?=
 =?us-ascii?Q?OAZk1Hw8pHeQ/HPOiEwaUbdHv2Fpvw4+krQfjbyDZLjCGge/dsc/4nxNwo+B?=
 =?us-ascii?Q?De3fYgHB6wKlLN+x2nE/Jdmno0k5mhMbi3BbBVBcm7wGpI7ZwvHQIjW7IhOb?=
 =?us-ascii?Q?x6Af8OvZzsBDHwNPtOPdBzs298LQyni5cNZcoZ13v6oPQ5jUBjxfnrPWboCK?=
 =?us-ascii?Q?OjCp10IBagKPsjrXnDkVb7NQQ8NDE8WRMxLjbiJ08jEh4oFjt3hyz//6q3ww?=
 =?us-ascii?Q?2Iwr1mMOU4LqDfWrXor3AW7Qu3zrvfEPnzbvVGEFyBb5kcvf5OMRgpG96xvd?=
 =?us-ascii?Q?ftSb8Ukz3qgdMZt6NdqpRMSzo8ItIpb0M1dbt398/LMWtIuX9prylPhC2EPY?=
 =?us-ascii?Q?2aAtBLOwh4zrgYIa933z5lonqmjqleOWvxCJEZEhV+Kvzesh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6552f1-72e9-41a9-a3d4-08deb6f319bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 04:40:35.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdefoeJ2/WtUGl/ekAfo11JZcrextdfNY/yKKfvC4IfmgDQ4bqoGnLed3qAA29uoeGHvYnJFIlgd++KZ9SJgGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032


> > -----Original Message-----
> > From: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
> > Sent: Wednesday, May 20, 2026 4:49 PM
> > To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> > <frank.li@nxp.com>; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; bhelgaas@google.com; Hongxing Zhu
> > <hongxing.zhu@nxp.com>; l.stach@pengutronix.de
> > Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Sherry Sun <sherry.sun@nxp.com>
> > Subject: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update
> > device trees
> >
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > This series integrates the PCI pwrctrl framework into the pci-imx6
> > driver and updates i.MX EVK board device trees to support it.
> >
> > Patches 2-8 update device trees for i.MX EVK boards which maintained
> > by NXP to move power supply properties from the PCIe controller node
> > to the Root Port child node, which is required for pwrctrl framework.
> > Affected boards:
> > - i.MX6Q/DL SABRESD
> > - i.MX6SX SDB
> > - i.MX8MM EVK
> > - i.MX8MP EVK
> > - i.MX8MQ EVK
> > - i.MX8DXL/QM/QXP EVK
> > - i.MX95 15x15/19x19 EVK
> >
> > The driver maintains legacy regulator handling for device trees that
> > haven't been updated yet. Both old and new device tree structures are
> supported.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Hi Sherry:
> Since the vpcie3v3aux is used to power up the WAKE#, it is always on in t=
his
> pwrctrl framework whatever the system is in suspend or not, right?
>=20

Hi Richard,
Currently the new pwrctrl framework doesn't support vpcie3v3aux, it handles=
 all
regulators with of_regulator_bulk_get_all() and regulator_bulk_enable/disab=
le().
The vpcie3v3aux now only works with pci-imx6 driver.

Best Regards
Sherry

> Best Regards
> Richard Zhu
> > ---
> > Changes in V3:
> > 1. Rebased on top of latest 7.1.0-rc4
> >
> > Changes in V2:
> > 1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
> >    device removal"), the pwrctrl drivers no longer power off devices
> >    during removal. Update pci-imx6 driver's shutdown callback in patch#=
1
> >    to explicitly call pci_pwrctrl_power_off_devices() before
> >    pci_pwrctrl_destroy_devices() to ensure devices are properly powered
> >    off.
> > ---
> >
> > Sherry Sun (8):
> >   PCI: imx6: Integrate new pwrctrl API for pci-imx6
> >   arm: dts: imx6qdl-sabresd: Move power supply property to Root Port
> >     node
> >   arm: dts: imx6sx-sdb: Move power supply property to Root Port node
> >   arm64: dts: imx8mm-evk: Move power supply property to Root Port node
> >   arm64: dts: imx8mp-evk: Move power supply properties to Root Port nod=
e
> >   arm64: dts: imx8mq-evk: Move power supply properties to Root Port nod=
e
> >   arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
> >     node
> >   arm64: dts: imx95: Move power supply properties to Root Port node
> >
> >  .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  2 +-
> >  arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  2 +-
> >  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  4 ++--
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  2 +-
> > arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  4 ++--
> > arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  4 ++--
> > arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
> > arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 ++--
> >  .../boot/dts/freescale/imx95-15x15-evk.dts    |  4 ++--
> >  .../boot/dts/freescale/imx95-19x19-evk.dts    |  8 +++----
> >  drivers/pci/controller/dwc/Kconfig            |  1 +
> >  drivers/pci/controller/dwc/pci-imx6.c         | 24 ++++++++++++++++++-
> >  12 files changed, 43 insertions(+), 20 deletions(-)
> >
> > --
> > 2.37.1

