Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C91F3B85;
	Fri,  8 May 2026 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210135; cv=fail; b=aGoZi4meny9wjFIW+93UmTTlicX29ck4U4s9J8THPYmYDt0BnyKUITucKsxGEuBlRW7oZ/A0pzAhxUPsuM/gn2opv6z0pT8t6j1YIMFrODUV95bHFHzqACMwLry6Qmg2Z8p9D0koPv8rhx6qSWQ734R4HxFcE4Chxt7mGCxQpuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210135; c=relaxed/simple;
	bh=P7NlC0/+l1NA8MTjLJ2u3aQnQ6y4Kf96u4qmTTnD0jE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agHcQT2HdLcmjw0gizzVuBy8q9IEE1/l6XA8l2DusV25QViEZbrNgaRms4O1AFwaunvtIm12PGUuVePJdHnUQ0ns7+OcZRWmxpYOmg66Z/sCmEGMjSGjuIyeQJRi3WD2bysL9eZSKYWvSJJK94y/tD5DWul5dWMHFWdBY+eCaiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i9rEZfKI; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9rEZfKI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnNczUpqZkxPt1YnAf7gVRCr+pG0KUbHd7wped0MX7ZmlCGwt8lUh/7pMgEzSK2hZQZrHjefn1gV+VhYufoeHLKbZWLDUXmhM7EXUDJ7OWh28kuBfhaxNAckMAohBbYYFUOjTIa98liTXIttgG+5KOstqagS1diia26Kq1aKms/y6ygiU0eTGyoRohAvduQnL6J3XmGBAlSU8KwzQaif6AOtwSElqeJBCtViSpvESmiOpvVXlrjAm5IBI6o1fp/2v1ZSbUtLEvwgGrL12oJNAcQTWjv89VtRf+Vri7F/4QllJBhIaXRvoae9GfLF5frVoBtlYNESZ4cuT639o1NqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLZSBMMRGW1Fp45yvmeMIZBNKK0bzr1EIL9mug0MwcE=;
 b=r1IMaHtnexq8tw40ur78hWOIQtCnd870pKHMr2WPF8uOfLfsxMTMuJPraYlZnppuCzdSSjekCDZodU5+xwEw4xYc9fhlLVju5Fy1I3w3fIdpzuxDBMltRpChByEfBzF7c17r1avO1sMPRj9gYjSSKLTiwlhtWT8te0RPol4Mu3i8tx+FMxrRWSGn3fuSBMo/LgXxaRYqfUSaEtiVtVciORMWINUf16uIQTVP0Epl6D/hpXeIb8KY39EFvygV1fCFSa6sYZd1/hUC/Nf5OOKQIo1gHXABNkGcrtpwzze5WGQ1nQ9vKFZJX0NG0QE25TLtb6yjiWCUo94e78xJUN2fzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLZSBMMRGW1Fp45yvmeMIZBNKK0bzr1EIL9mug0MwcE=;
 b=i9rEZfKITSPc2uyMucyGo+juOEx7GoEYtavTXKmpyy0XDakdRclJHUmS5NBjBgHZ2u6vOciwAQ82O9c4L+vTLpCoFC/uzzKoOlyIC7RfN+sw+uNr+f58SSvZZIqkYRaoeyT/eTIeNyMNGPNbxqSyM7/gD57bcHYM6dYZwzbhrITnqjmy3w9f5arS2oYv494sy72KqRvd8Lit7PIdUZy3MHhOUKmC8tASGdsrqIwPYZQuX3ecrdEcLw11G2Iavphx1QJzM7GoC1hmIyR/bWKvcxErBPFIod5ZEr6hbq9Nhgsjb0hRzJriD7eOvy/5Ovwc/LEdjCKhdNosdF0EquHD+Q==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GVXPR04MB12159.eurprd04.prod.outlook.com
 (2603:10a6:150:312::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 03:15:30 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:15:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
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
Subject: RE: [PATCH V14 03/12] PCI: imx6: Assert PERST# before enabling
 regulators
Thread-Topic: [PATCH V14 03/12] PCI: imx6: Assert PERST# before enabling
 regulators
Thread-Index: AQHc0js3bM4lCNbwaEa3e/8C/uPFM7YDhZfw
Date: Fri, 8 May 2026 03:15:30 +0000
Message-ID:
 <GV2PR04MB12019D9313DBF77F8265147948C3D2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
 <20260422093549.407022-4-sherry.sun@nxp.com>
In-Reply-To: <20260422093549.407022-4-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GVXPR04MB12159:EE_
x-ms-office365-filtering-correlation-id: 25b7ced0-56cd-4604-7fb0-08deacb00f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 jYeVCxnKSomcUtN5ccyLNUlBf8ZCHeaGrZdZwuStZcDoKXtx7CdBpNVpwCzQSnBKs5nJZ3rsvEkNTNNPvjCULw+aoDWMHx5lrn0cMgwMdQ/+oL6PH+BdfkE1EnPO1VsMVBhAZ5gcOBcoZTXoMgbM73DX6JSpkEc0RT9P30pzUW+a+nHIDTr+4g8qPHYuQIFBr1Nwqrmi3dZqvm1/Lm5bYpRUkzUoEAIgF0T92wYJqRZWtBKr48AmbEeZ7fz4514gSIl0G0xxwbEudEieopQBaYqdJXE54zt2UGL9My/SGrWiL/KXX4cpzEl4mGrPbEzQPnOG+X+YDHJeJtvyuul8zytSuI6I7ZIp3KAfiOPjgPYIOjnw7PQRlsXZoUaKmQJKUNgdo6d8z4bII7+52YARtUjWHTwt9inTSHYYMDqRVyRpOmI07RfPmHb86ER18rB8Z/chsL9JxowNIXZA86RA2z9+19ZBI5gyEVkvjvpcV67CEh3mqMpWHqB5OnQAXZbwGW/RGmybI019isytypLxZGu8E47oTMWrDo2KFJmkNAL0V6OYmdafrJz7KCJWwBR18aQHWJRIIrsNRY5SthdaSvvLpdqZhQ/yv4DO4L3D78u6gt5kmB7iqJ7Jgx2Kx8CwQpNLse1Fz9GmJssKmS7LnlyZOnFwKMdZOHC90f/dt5MUmYPwRAkrMsrIM+TA7vo8PFwnclzGMOojdJj70v46baiMDb0GQO//2YBdzszN1RXHeJMiEhoOWfSmCVoLPuDcEF1H748INWzMXpuicWCkDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Q5uFlDuYZbaGKqX0XjOaIeOQxtXo+APBdDTKnbuhVI6TaOfyF+ZtLjVAnns?=
 =?us-ascii?Q?xQnXpsymVsDORRXmAT3NR7LkamB7NsQOla362BCCY1R+efBBxL4fCg9sn1nE?=
 =?us-ascii?Q?rkvI4oxwuXrLLDtgB+3RZTwacwvDNc/gVhnm1mQcUT4rWVOGUU20yQ774/yd?=
 =?us-ascii?Q?kCxXyvZxVbCQgHpzaOptOtlbcAtXZuTrKDcWYrghgDHIea+cEm2WGPFTnirm?=
 =?us-ascii?Q?Ip2O2Ep5wwKNymiGDhRwodU2CcnrbzfXsZKusdvtmZVkTdC11IGcIz+0rytW?=
 =?us-ascii?Q?DuEUDgLnnKmgvKpGD5p5wo9L9pERIyNH1tCn0dyjOBS79EwuGqo4lrNEuKwq?=
 =?us-ascii?Q?2bhTatH0PvirxhD2/hQpUJcOJmm2dJdF+92giZLat6RULBPKaTmqlqIcjbPO?=
 =?us-ascii?Q?31C4jE+HHc1KcCdq0rZP0AqEuDGG+UVYJNWjBh0QZxgccRDgIi9bNIoHek3A?=
 =?us-ascii?Q?XxmsdvzvkvEcl2FFS5da/muDYYZSfXH41Umy1fMgSGL7ESxYo/LteM6hPl+5?=
 =?us-ascii?Q?2gHpnhzUXeDh36O6QQD1hjYxt5sYHfxpnudWNME0oNqTKu3ZvGNKM3HkDiHB?=
 =?us-ascii?Q?q0x94Xmi53NO6GiK+ODwSuHe04rOS5JNj/dA1ENrYDIMYi/wYoPRYoFfzJPp?=
 =?us-ascii?Q?zP98Sd2RG/3Q8EJTo+nU9H6e1vqsMXqnTJBtA398oDcMFzQQI+AgtcEc5b2s?=
 =?us-ascii?Q?1NrXTTvlJ3sa9myUm75exJigkT57PhyeZ1YRQElQwJhhb4nP/RZk1j9xa0Y7?=
 =?us-ascii?Q?6jNHmid26SMsmRguzyfXPKlpKLjeUAbgHnQDtIBi3WKcIa7VWjjs/fvMdrv3?=
 =?us-ascii?Q?jhM4q7QzZKo4Yxnmj8xJandcPXVx+psDPuVuc5L1IsG7H4n3EPgPLncNTe2T?=
 =?us-ascii?Q?UAIve3TDFzXEJRCRP7twc9KSCdsPU846P3FFUgkbxuJu74RTZnt1x4chsUV0?=
 =?us-ascii?Q?W0n+8P3IZT34ItdoS1aWHjs+UpX65Xx2hhi0ZjjuorPUsKpF6ejXFVFoR1JL?=
 =?us-ascii?Q?DuFO+eWc2miRty4jz3KH4wPQdnW4icxAC1whQRPXlkeWgm0k98BUpSzLUfMX?=
 =?us-ascii?Q?2Ey4q+BrvVkX51jU8pryC3/9Gtb761Pk1uolQFTfbVCtAuYTwgwIUYCNOSHJ?=
 =?us-ascii?Q?6DNlGDw0/fBIWrZA6LJV9kcQLkPAMdMNNU/AosP5iIBWhPnXy2zxly84/0AA?=
 =?us-ascii?Q?uVMyvQD2kz21rq7+4XqhxkmKISC2aZTESbUctGy9Zk1+X67H2TMS+kYwUN18?=
 =?us-ascii?Q?4YVDCg49MVTQopKggvaJ2FeVIcmdhGDjRSKKNzIRi/NKH3RPTlbThOccV3ra?=
 =?us-ascii?Q?zEbkxA0uWIKzd9yKfZyuMHToM1peyYtQuTcvLMonPn3QZbzxc6AWpEbTTb6G?=
 =?us-ascii?Q?8W0/tU+50oX5+uoo6NoiUEEtIbU06LzgiW2UCK9uXO5NmCxjg2XBA9eNR3Nm?=
 =?us-ascii?Q?rBG0hRYi7gOOE+R1k2K3y7wZAdoz3HsNoF7kjW+qEKvihR9+v5tX76WJzr6L?=
 =?us-ascii?Q?Tf9K8ILK8evjTcxjJ4+YCO3QXWgjv9DXOl96TDqNJBIox/bjXmBdI98uNZn2?=
 =?us-ascii?Q?tJRGQ64+hHkwmWXU8j28pVkW6Kjbwk82nM0GcXqisaO2CJ/WMfCQ92LD/1so?=
 =?us-ascii?Q?e7GA0+B+E0sZ+5OTdcaIQDPkoS9htwb/+aOJklVqCMrZlbDnmA1zMIG1+j5r?=
 =?us-ascii?Q?p+DvGbjvI3nFZ/3HTC3qXIPvvS6pHcQYYTAqySNXzRfVlGY1?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7ced0-56cd-4604-7fb0-08deacb00f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:15:30.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prs72QqNFUyG72O7NI1VvFCFuPTFd1I1w5L1+QH0dztkri1IYUvuCtIGokWmsCVg7NHizXfRA/+KT9JkSWSpRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12159

> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Wednesday, April 22, 2026 5:36 PM
> To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> <frank.li@nxp.com>; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; lpieralisi@kernel.org; kwilczynski@kernel.org;
> mani@kernel.org; bhelgaas@google.com; Hongxing Zhu
> <hongxing.zhu@nxp.com>; l.stach@pengutronix.de
> Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH V14 03/12] PCI: imx6: Assert PERST# before enabling regul=
ators
>=20
> The PCIe endpoint may start responding or driving signals as soon as its =
supply is
> enabled, even before the reference clock is stable.
> Asserting PERST# before enabling the regulator ensures that the endpoint =
remains
> in reset throughout the entire power-up sequence, until both power and re=
fclk
> are known to be stable and link initialization can safely begin.
>=20
> Currently, the driver enables the vpcie3v3aux regulator in
> imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(), which=
 may
> cause PCIe endpoint undefined behavior during early power-up. However, th=
ere is
> no issue so far because PERST# is requested as GPIOD_OUT_HIGH in
> imx_pcie_probe(), which guarantees that PERST# is asserted before enablin=
g the
> vpcie3v3aux regulator.
>=20
> This is prepare for the upcoming changes that will parse the reset proper=
ty using
> the new Root Port binding, which will use GPIOD_ASIS when requesting the =
reset
> GPIO. With GPIOD_ASIS, the GPIO state is not guaranteed, so explicit sequ=
encing
> is required.
>=20
> Fix the power sequencing by:
> 1. Moving vpcie3v3aux regulator enable from probe to
>    imx_pcie_host_init(), where it can be properly sequenced with PERST#.
> 2. Moving imx_pcie_assert_perst() before regulator and clock enable to
>    ensure correct ordering.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 49 +++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index e35044cc5218..735127ed1455 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -168,6 +168,8 @@ struct imx_pcie {
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
>  	struct regulator	*vpcie;
> +	struct regulator	*vpcie_aux;
> +	bool			vpcie_aux_enabled;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>=20
> @@ -1222,6 +1224,13 @@ static void imx_pcie_disable_device(struct
> pci_host_bridge *bridge,
>  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));  }
>=20
> +static void imx_pcie_vpcie_aux_disable(void *data) {
> +	struct regulator *vpcie_aux =3D data;
> +
> +	regulator_disable(vpcie_aux);
> +}
> +
>  static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert=
)  {
>  	if (assert) {
> @@ -1242,6 +1251,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
>  	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
>  	int ret;
>=20
> +	imx_pcie_assert_perst(imx_pcie, true);
> +
> +	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle=
 */
> +	if (imx_pcie->vpcie_aux && !imx_pcie->vpcie_aux_enabled) {
> +		ret =3D regulator_enable(imx_pcie->vpcie_aux);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie_aux
> regulator: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		imx_pcie->vpcie_aux_enabled =3D true;
> +
> +		ret =3D devm_add_action_or_reset(dev,
> imx_pcie_vpcie_aux_disable,
> +					       imx_pcie->vpcie_aux);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (imx_pcie->vpcie) {
>  		ret =3D regulator_enable(imx_pcie->vpcie);
>  		if (ret) {
> @@ -1251,25 +1278,24 @@ static int imx_pcie_host_init(struct dw_pcie_rp *=
pp)
>  		}
>  	}
>=20
> +	ret =3D imx_pcie_clk_enable(imx_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> +		goto err_reg_disable;
> +	}
> +
>  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> {
>  		pp->bridge->enable_device =3D imx_pcie_enable_device;
>  		pp->bridge->disable_device =3D imx_pcie_disable_device;
>  	}
>=20
>  	imx_pcie_assert_core_reset(imx_pcie);
> -	imx_pcie_assert_perst(imx_pcie, true);
>=20
>  	if (imx_pcie->drvdata->init_phy)
>  		imx_pcie->drvdata->init_phy(imx_pcie);
>=20
>  	imx_pcie_configure_type(imx_pcie);
>=20
> -	ret =3D imx_pcie_clk_enable(imx_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> -	}
> -
>  	if (imx_pcie->phy) {
>  		ret =3D phy_init(imx_pcie->phy);
>  		if (ret) {
> @@ -1782,9 +1808,12 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci-
> >max_link_speed);
>  	imx_pcie->supports_clkreq =3D of_property_read_bool(node, "supports-
> clkreq");
>=20
> -	ret =3D devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
> -	if (ret < 0 && ret !=3D -ENODEV)
> -		return dev_err_probe(dev, ret, "failed to enable Vaux supply\n");
> +	imx_pcie->vpcie_aux =3D devm_regulator_get_optional(&pdev->dev,
> "vpcie3v3aux");
> +	if (IS_ERR(imx_pcie->vpcie_aux)) {
> +		if (PTR_ERR(imx_pcie->vpcie_aux) !=3D -ENODEV)
> +			return PTR_ERR(imx_pcie->vpcie_aux);
> +		imx_pcie->vpcie_aux =3D NULL;
> +	}
>=20
>  	imx_pcie->vpcie =3D devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
> --
> 2.37.1

