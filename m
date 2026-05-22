Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3793090C4;
	Fri, 22 May 2026 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417690; cv=fail; b=PcF/L1EQqMvEE+j8+iDKfUH4U8MZ8LSn25pL4zcjmintqqxg4897F8s5Nwmc2JlRh5dHVlvQo0cHWH9IeMkhhgywaaZk6RU4iF82csu1HnZ2FaMKjkcRyHS7BUsrQFoPgZBRKzqIUf6VdlYiDutnNBtR+E29CbwEJv4kSOCVeE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417690; c=relaxed/simple;
	bh=2S2jkXN68H3gKAUR1e1EixSAFwDTIGa+yTau/6qJhU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/b3AQHM32wwWE+JXlEHVZqYZXBl4IktBKrDwsgIsAIivhQatv4evffJo7KBZGR2be1hVuTrEH0dc+QQJjYCmUJgniSeKxz5BQGZ66XtRswnkyUeZJ08JO4Lox4a7G3puK/e1R0YJKwx0pkhHlHVliEYasQHPoSM2V0kdUQHLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ylv7Y6P4; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ylv7Y6P4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myswI/VAjxaxvfNNtjLgPEanBoCIbwlMFX/Fg5q3vmrSU5TVDUIKO4U56fz0OKbAZHtAu++09Sm5fmVswhGgPExgKhwHh/I1Z6A2Kc6XCbR225aZkBU1o9d8/xlkEK897iCW8Jbjm5b9+fXRnwhxk7HPiKMMrNowZ5Cc5GOdsfqGNC2E3afwjEOiLAZEgZf5SjwjD+rphMszsilCvCdC2DKA+vR5hEPp6t5wxCflBQHUH6E5OiBsKyhxzjLUe3tRC3z4DwPfyDwnPBgmckdYd/1pkJcFxgHcUOBlFej1dCl5im65qMrm//HacLX92FgSkoOEm8P9Z/CEvOoHjITSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmjkfwpdzafb38ROYmKpKN+LXamcb6hmOMFyL90HSJw=;
 b=f5xIvviRcSP3a4+0yOFmK8EyV4QmKBBhrFoQeypWyCzCailZxefFWH0CewNyTT6DaY3ST4ts+2ZIsgTDRYkGsMCGSfdTjEfXDYWzqWSqAIrsXgmtA+TXArrUAY1kGnBS26csuRNZSwIZTKTCsq+yNY9WeLBoOYGCrGb6cy7kmxRDMoUyYLaB4PGDfO406Rz5Wx7AttkA5x6M+6yw6l4SEsacl+wIYzwdC55bSXwd4xvqvw6RUTLO5rMJR7ZzXZyCiQ7Fz3Q3Fp7WOXc6Pybsu/ktKqnlyHHcVbAvenTrQ9seGYVTXMKdytcoGbDyojJnqVptI94eyZnjpRLWJkHdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmjkfwpdzafb38ROYmKpKN+LXamcb6hmOMFyL90HSJw=;
 b=Ylv7Y6P4+qwZHdr+u7xxI6efpHElSB109IkAz/RGBn4HNne6qVTeW9lzmOcUTCjiy2hdjQ0Hwe7ZH2va9iHRflRmcEF30/9wOTUHaLt/oWY/HFuQO9NcY7hyrgzY4Y8EjjG+giJSjlaGGYdIqG3oSqs7Jn3//gKyQzkbRoQGAvTM7b6OpuUPVgLkRSjKqin1OnotzWOMClWcP6pUVE9HLkNp3St1oU+hffDYpxQ/19+HZhOEhriiKkmeNYzDJNIQUy3j4vMCfc8A/xf3vqKkYqFipl8w9VGb8Nt7euDT1e7zqeM95gutQQUQ37dtW7Gft4XnXk2qDo5Rm7yfplwCbg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA6PR04MB11871.eurprd04.prod.outlook.com
 (2603:10a6:102:518::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 02:41:23 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 02:41:23 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Topic: [PATCH v5 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Index: AQHc6QSKk304yivb60Sq6eissATpprYYVd4AgAD5HOA=
Date: Fri, 22 May 2026 02:41:22 +0000
Message-ID:
 <GV2PR04MB12019D35A0E5244491CD7FA988C0F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260521093255.61585-4-hongxing.zhu@nxp.com>
 <20260521112122.F334C1F000E9@smtp.kernel.org>
In-Reply-To: <20260521112122.F334C1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA6PR04MB11871:EE_
x-ms-office365-filtering-correlation-id: f95a0f45-f5e6-4902-6857-08deb7ab9cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|18002099003|38070700021|56012099003|4143699003|22082099003|4133799003|6133799003|5023799004|11063799006;
x-microsoft-antispam-message-info:
 d6QSbwKFwcR191cmkDJpmN8SJGberh8FFkhDOojdJpRNhOBgOqlIK6AgAdds+7fJZUAc/q7W1NBkKv/C9AuJGj4dfyw9MtHLUz9FPpPPJ4vMh2HuQLttBGCq5SpismWvJnwj6LxjN4/B5dQmkq+sB0lC+jt75IyUhc2dm8Lu4ntziz3wgUcPjPU+3DhtHcWk+KzoEXDsnZfxQ1TF0qTHhuH1T1IaStBadyC/jvjlP35fNIBGBxAKNC35KvoTnlo0Paq8cFRfivZ/nGnEsxaUdt0b9rdH0JYm+yR8tLE7abgA9NLo8WDvXvC8V68QY/tK/iYIY5R3OhGgYlADSrXtZ0qiOT1A/ZLzqASXQr99xwGzKNlfQe9OnpWjsxlYVy3EifMomjrX4AQrk2NffVAmxImXqjWlNeToR6tsfc2dnRhwX4+uhBdN93DOqx9IwQDWjbLe9P4KJRoiXmTEKGPM6hw8FzQslXIvfJkwdQNVu3HpjcWX2dOz5Jfw43HGFh4bj+gOqsWLP1jEec+VZiv121vIO62SIw0rVjT5RmSgqJYYTqJNMNVpeFmd+6lWrZGqVPhhVtugTe61WJsxjiBkFatka3VlBoZqJz8OCzKOVjIqdSwsnXGpHjE6Kuk3JvTFbvzqTBdC9pn3ounUCY9OUHY/g++Cjq4wzjE+f8mjSWMfjE20a9wxhq/31gYmo9enReY/yG2mBk5Fx02lc9h4x0Apz2Bk9W+AAHu7k+PzZgUVf8vMtFQaeq3UjRepc6kt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(18002099003)(38070700021)(56012099003)(4143699003)(22082099003)(4133799003)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6NP83SGNIuXTsWrOeQ+N0qjqSxk6ij1RNB3P1cm0R1L79rvyQAd9ZBWGxxJE?=
 =?us-ascii?Q?XR+bqbcSRcXzJKGHuATV9i2pF7SeypIhsiEIsbSh3Gk8/SC1rpYeIXr7E/CL?=
 =?us-ascii?Q?zx8Xi7jWbHlAyjR/Z2A52MYt7/m9oX8Gw1FAwRjpBGma61+30s5p0aLnOwxb?=
 =?us-ascii?Q?AnTobC+f+cbC/fGW1OCAyQ8fqRpN/l7K0/b7e5AKCibYPEZT7DwPWvxhRLcQ?=
 =?us-ascii?Q?fL3517Hs91CgH3/JmOBK8cRiWzIlAncPEvXofku2o5mqHKRU+f0qQA775bx5?=
 =?us-ascii?Q?5uL0NN9ZkHLTEIIpkwekgb8uqVd6OOZlun+3LxGaBfFPib+Brf39sHqKNBEM?=
 =?us-ascii?Q?YbibGO9ewlQWYdfDjEpQY5USz4XuZKJFHGthqZ/k5iUF2sb7nR6FgxFpH+Il?=
 =?us-ascii?Q?EbTXl2xIygIcRULx76xuI9ZXkJi7iZhcu72zAkMd1NYnXDEyRKNMvT2Tq/d9?=
 =?us-ascii?Q?8MEUkueaeQOjfpsPmkuWa7tWP6gbthTkfMlImkRM2EWpX6hhD7IQ725yP24L?=
 =?us-ascii?Q?F6tca57dViQH3xgvSoIJrfKDuusNWiJIabuSpN/fLeBd3psqK6K5NjpDlhqu?=
 =?us-ascii?Q?csfyWXkK6sdx+JVa62sNc9iJ3v75auKW2LupZNLvPDhBXgF+gKnSGd4vUyOO?=
 =?us-ascii?Q?1Es3ecjYlAvUHRxTytQSMuHYuM3b6GAe8ubMi4LcKgWKRxddAaOfSPiZsuaP?=
 =?us-ascii?Q?IPuATFkgzHmvjVVJesnIKqp8OmBlqqAhdSqJrxKZoxKKLkm1Odb8ooXsLs9W?=
 =?us-ascii?Q?MZrQ7In0yAZ1m0e4bu3s7z1zuq3gePLlxrP4fLeoqqpk7NCGjCSceoxhDugE?=
 =?us-ascii?Q?yMmurFlrEaw+/cCFDJt/jZlYWcRmNkBK/hcqH7oBL+//+Nvs91m8O+ciyP4E?=
 =?us-ascii?Q?GOar55Cy1bDkJOqdAzf+MEzw8vqZXgnVEfW9uqJqSDAXlJSnhVuEPnd1RQjQ?=
 =?us-ascii?Q?8l9Buiw5/tjuzkLtemECbrbwQqCRW5QEtqxo4gg6F7TUBpH9f7xyjDIvOEXh?=
 =?us-ascii?Q?PDN7pT/SWT3DY9NeYUED2ATzGZxYhAjt6NTKAeedA7ZNdmsDXHLvcBK3dEw6?=
 =?us-ascii?Q?UV1jQv+uEchKVxET4FDMlyeX1+ICknBTkG9SKF5wuRxRmJhj5U26ICDUvTeQ?=
 =?us-ascii?Q?kJ9J6+5B9bt//cTyu3Pcn6JuRjEwfk0C+UZjpOk/NO7hu0Hs/qJ/KAyqoVr2?=
 =?us-ascii?Q?q/DSfFk0oatsH6+ijEFyFXHNwJd7lIFud0PdkGh4HhJL4ZylDnwLQW8v5sIV?=
 =?us-ascii?Q?0Z04qlR6LSOMFqkCkDqr7ZwWOlea1PoPMBFdiLIpUvq4EcHeRBfVUCXi88dx?=
 =?us-ascii?Q?Ihkm1/WwLUG/sF+mPJ1APLp1/XdjRrtNUqJ01a35HoYoc5AlQq5+k5iVeil2?=
 =?us-ascii?Q?3RYfHhn6rA+5DyymmuXaXQb7DpreKQ+/2sPDrr3l8WZa8r5Y712TU98Hfi2C?=
 =?us-ascii?Q?G9zGFY7doxdh91H+ehE+aVcVgP0p2s3+NNyUjvZbb1D+O60LX7AP63LAxL8k?=
 =?us-ascii?Q?HHfKpUs6HCPTtOix1F22dbPc1LGCNXu7eUGyg717YMLId0PnP5p6nNV14ab4?=
 =?us-ascii?Q?nvopk3dGb4JAYihgU8PhNLxNlBAAt1dVxr9i2l18kTHuGaEEh6f1rbw7yCCM?=
 =?us-ascii?Q?o6ZahfuSoqbD32CBkvnIN8E18MEqFi4S+T4WbchD1u7st0fCvHMlx9ASLo4n?=
 =?us-ascii?Q?j3eX5z1DNKfSFhTobyGUCL5Nn9YwVxdMJCEmBPYVq4XSdE8a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f95a0f45-f5e6-4902-6857-08deb7ab9cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 02:41:23.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eqi7hjA6q2sAsgLkEznhr04+E+TXhgVOHE47VG3T3AT1PgXuakT6GnIyHT4tQZNDEo+BRwONrA7PP28aiKVdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11871

> -----Original Message-----
> From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> Sent: Thursday, May 21, 2026 7:21 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: devicetree@vger.kernel.org; robh@kernel.org; Frank.Li@kernel.org; lin=
ux-
> pci@vger.kernel.org; conor+dt@kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH v5 3/3] PCI: imx6: Add root port reset to support lin=
k recovery
>=20
> Thank you for your contribution! Sashiko AI review found 7 potential issu=
e(s) to
> consider:
> - [High] The `lnk_intr` member is defined as `u32`, which wraps negative =
error
> codes from `platform_get_irq_byname` to large positive integers, breaking=
 driver
> probe.
> - [High] Read-modify-write (RMW) operations via `regmap_clear_bits` and
> `regmap_set_bits` unintentionally clear Write-1-to-Clear (W1C) status bit=
s.
> - [High] Iterating over the PCI bus device list without holding the `pci_=
bus_sem`
> read lock causes a race condition.
> - [High] The patch references `reset_root_port` and calls
> `pci_host_handle_link_down()`, neither of which exist in the mainline ker=
nel tree.
> - [High] Hardware LUT state is accessed in `imx_pcie_reset_root_port` wit=
hout
> acquiring the protective `imx_pcie->lock` mutex.
> - [Medium] The shared interrupt handler claims the interrupt without veri=
fying
> that its specific interrupt source is actually enabled, leading to spurio=
us wakeups.
> - [Low] Using `platform_get_irq_byname` instead of
> `platform_get_irq_byname_optional` for an optional interrupt will cause
> unnecessary kernel error logs.
> --
>=20
> commit c3df91626a3cc2df53cc4e1da0e0b1aeb4d5d8cd
> Author: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> PCI: imx6: Add root port reset to support link recovery
>=20
> The PCIe link can go down due to various unexpected circumstances. Add ro=
ot
> port reset support to enable link recovery for the i.MX PCIe controller w=
hen the
> optional "intr" interrupt is present.
>=20
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
>=20
> [ ... ]
>=20
> > @@ -158,6 +165,7 @@ struct imx_pcie {
> >  	bool			supports_clkreq;
> >  	bool			enable_ext_refclk;
> >  	struct regmap		*iomuxc_gpr;
> > +	u32			lnk_intr;
>=20
> [Severity: High]
> Will platform_get_irq_byname returning a negative error code (like -ENXIO=
) wrap
> to a large positive integer here, causing the later if (imx_pcie->lnk_int=
r > 0) check
> to pass and break driver probe on systems without the optional interrupt?=
 Should
> this be an int instead?
>=20
Good catch! will update it later.
> [ ... ]
>=20
> > @@ -1306,6 +1314,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> > *pp)
> >
> >  	imx_setup_phy_mpll(imx_pcie);
> >
> > +	/*
> > +	 * Callback invoked by PCI core when link down is detected and
> > +	 * recovery is needed.
> > +	 */
> > +	if (pp->bridge)
> > +		pp->bridge->reset_root_port =3D imx_pcie_reset_root_port;
>=20
> [Severity: High]
> Does struct pci_host_bridge have a reset_root_port member? It appears thi=
s
> patch relies on out-of-tree or unmerged prerequisites and will cause buil=
d
> failures.
No worries, the dependency had been specified.
>=20
> [ ... ]
>=20
> > @@ -1573,6 +1588,9 @@ static int imx_pcie_suspend_noirq(struct device
> *dev)
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >
> > +	if (imx_pcie->lnk_intr)
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
>=20
> [Severity: High]
> Does this read-modify-write operation accidentally clear Write-1-to-Clear=
 status
> bits?
>=20
> IMX95_LINK_INT_CTRL_STS contains W1C bits like
> IMX95_LINK_DOWN_INT_STS.
> When regmap_clear_bits reads the register, any pending W1C bits will be r=
ead as
> 1. Writing them back during the modify phase will inadvertently clear the=
 status
> bits without handling the interrupt.
>=20
Okay, would clear the W1C bit firstly, then do the regmap_clear_bits().
> [ ... ]
>=20
> > @@ -1632,6 +1653,85 @@ static const struct dev_pm_ops imx_pcie_pm_ops =
=3D
> {
> >  				  imx_pcie_resume_noirq)
> >  };
> >
> > +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv) {
> > +	struct imx_pcie *imx_pcie =3D priv;
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	u32 val;
> > +
> > +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> > +	if (val & IMX95_LINK_DOWN_INT_STS) {
>=20
> [Severity: Medium]
> Should this check verify that the interrupt is actually enabled?
>=20
> Since this is an IRQF_SHARED handler sharing a line with the PME driver, =
if the
> hardware status bit is asserted but IMX95_LINK_DOWN_INT_EN is masked, a
> subsequent interrupt triggered by the PME driver could cause this ISR to
> incorrectly claim the interrupt and return IRQ_WAKE_THREAD.
IRQ_WAKE_THREAD only be returned when IMX95_LINK_DOWN_INT_STS is asserted.
>=20
> [ ... ]
>=20
> > +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv) {
> > +	struct imx_pcie *imx_pcie =3D priv;
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> > +	struct pci_dev *port;
> > +
> > +	for_each_pci_bridge(port, pp->bridge->bus)
>=20
> [Severity: High]
> Is it safe to iterate over the PCI bus device list without holding the pc=
i_bus_sem
> read lock? Traversing the bus->devices list asynchronously risks list cor=
ruption and
> use-after-free vulnerabilities if PCI devices are concurrently hot-added =
or
> removed. Should pci_walk_bus() or
> down_read(&pci_bus_sem) be used here?
>=20
> > +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> > +			pci_host_handle_link_down(port);
>=20
> [Severity: High]
> Is pci_host_handle_link_down() available in the mainline kernel tree?
> This function appears to be undefined, which will cause a build failure.
>=20
No worries, the dependency had been specified.
> [ ... ]
>=20
> > +static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
> > +				    struct pci_dev *pdev)
> > +{
> > +	struct pci_bus *bus =3D bridge->bus;
> > +	struct dw_pcie_rp *pp =3D bus->sysdata;
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
> > +	int ret;
> > +
> > +	imx_pcie_msi_save_restore(imx_pcie, true);
> > +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> > +		imx_pcie_lut_save(imx_pcie);
>=20
> [Severity: High]
> Does this access the hardware LUT state without acquiring the protective
> imx_pcie->lock mutex?
>=20
> Since imx_pcie_reset_root_port can be invoked asynchronously from the lin=
k
> down interrupt handler, concurrent accesses to the LUT configuration from=
 other
> execution paths (which do use the lock) could lead to a race condition an=
d corrupt
> the hardware LUT configuration.
No worries, there are no race when do the lut save/restore.
>=20
> [ ... ]
>=20
> > @@ -1834,9 +1934,33 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  			val |=3D PCI_MSI_FLAGS_ENABLE;
> >  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> >  		}
> > +
> > +		/* Get link event irq if it is present */
> > +		imx_pcie->lnk_intr =3D platform_get_irq_byname(pdev, "intr");
>=20
> [Severity: Low]
> Since this interrupt is optional, should this use
> platform_get_irq_byname_optional() to avoid printing unnecessary error
> messages to the kernel log when it is absent?
Okay, would update it later.

Best Regards
Richard Zhu

>=20
> --
> Sashiko AI
> review * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fsa
> shiko.dev%2F%23%2Fpatchset%2F20260521093255.61585-1-
> hongxing.zhu%40nxp.com%3Fpart%3D3&data=3D05%7C02%7Chongxing.zhu%40nx
> p.com%7Ce831884f29d14575cb8408deb72b1830%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C639149592897765731%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUi0aRHNXO9FFLrgBoH
> ClFZFn6eYvAj1gwXiWD45uNlc%3D&reserved=3D0
