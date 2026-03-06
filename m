Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38C22652D;
	Fri,  6 Mar 2026 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762530; cv=fail; b=B21XruPP2p+AsHTmw8vA6+eJxaAsic2Jx1OfBFwx26Y6I15nCDZdZnsiRHMwgukdp+kP1DdSU3fDDMY++WTFKmg4yieBniUcaBj9JYZGQHQ24LQSewH9YrrObS7EQy2KJIGb0pLwzgepsst063il3frhi4A+cBCF+m1hRXzGFtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762530; c=relaxed/simple;
	bh=BjhoxbrROVQoaxDT/2O7+vHwRInuky2ZiyukwG9MKr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDcBdIQmf4T1pNCGcz82D9lo+Z1nwhrFXwDAmF7ALyNNCNedmvTANd7gNr5NiXXKn59sG4mf5J352iQnO7nBXwk6zsoszhGclCJbZepnLlea8ubjovT7gqmc/3KmZXHWCcLZJg7uTg58eZktpmm9J8iDGyEv4Euzrv1H2qOQU54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ccqNOkg2; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccqNOkg2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rgb/nkq3RxYdKmeh7+BJ+ND9hUPUmUXNxXO/8Imu7v9oIMnVSojHl/g2U4euG1u2h9ZHyWinkNRPisQEzclVoF+4bx34KWZzPnVGycUuxzTP5WE2AlE83FPi/duI4952gTMJy8jQvL4cIabM2Do3amF5bRepZfxck202jBRVETSnUtOcafRA2Rott5t8ow7v79lnwb/Y2Pj+ecM70Sy14vIi02gZB8qZQUt9KDA8ZXFx+lmYMDZzXKxPcLcJEMV/OHWjvAkn3i2/TtqhzzFLPMftEsQOKnZbFrhnvVgYtedjPHBBrVZ220DNtTEmZ6aSGfHnI+pUXcznfYxQxNfWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RmCSr7J/gmiy8vR6DeOmZfXC/AkTTOk9ja+W+iC0Ec=;
 b=M6bzzIM+JY+aCemS9pfVFlB6bKNLhTLYQOihQHApP1Gx6bv3oESCkOa6GOriH/8ABGp+2t/ROjhF0xG/yv12yWlf0Fs13CBM0EVjtDczt4ubgmJYnXx4Rw9u3bU7Ghw5eQMgok+BtFMYWpUFRgkkr1pZsyNzpZXQIvp7CIgbDXAO137jlV8daJXlgMMEk6jTWm4rKr9wRl+OgHHRormfpoKIlhEfRTY1RxsageDA6jj3Sx0oQD6j8HYPameoAvYl3qJV7MzyY/s+fYIOWM9RtAHNzrfDYc/IlQ6hwO9BcG9N44f8IF+jtbEfHhoqdpmopHQh3psvXjoKbhado6mLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RmCSr7J/gmiy8vR6DeOmZfXC/AkTTOk9ja+W+iC0Ec=;
 b=ccqNOkg2XYazHcK9W1Z2OhZLe48iGAnEnTJ8aSIg9lYeBUBYSlY08zPsxkd2BBsPSmBTc/kpS4jCT428fCQRKgqA9GZr8LbT1yVXqoqaHcLT7m/krJ77qnZvniJ424JCfEIF+f1/VYAsB2+z8pMhJbLyJ/8gQ0DWmKzBO4sqvlvvOalW3Aqt4Ou+Ag9UqZmmTgJqsDKC4NpVLJbS+Ig1jbkuFuIPdhJfDJTO86TWKVtPRUARSRNKs7OFrJFM/o/TruU6a3LiOkhc1OIYYMcv3CuWjbczA2wtUuNfRY/5ZOjSHDQkxOR/xjXp/SbSfTYOYEjVSZKUk+nIwCadVlr1AA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB9950.eurprd04.prod.outlook.com
 (2603:10a6:150:11a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 02:02:04 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:02:04 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Thread-Topic: [PATCH] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Thread-Index: AQHcrIXVtRQmJJhe8UWZZZvtH0HNibWgEW8AgACvsmA=
Date: Fri, 6 Mar 2026 02:02:04 +0000
Message-ID:
 <VI0PR04MB1211477BBE0270E8D1687D06B927AA@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260305095259.235049-1-sherry.sun@nxp.com>
 <aamh_jNadvXQMGs2@lizhi-Precision-Tower-5810>
In-Reply-To: <aamh_jNadvXQMGs2@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GVXPR04MB9950:EE_
x-ms-office365-filtering-correlation-id: 16dc8fd6-01e0-44f0-011d-08de7b245d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 nD1GGMrDg0PhpEvcc2DWZhciTvCeJYvxDOzqfFtw0Q1zf86x3vU5OjmTqTYu9jNatBmaidJRV5y/GIoagiQu/yCAEsdWXHjGRP+gnLFathMrA4Rl6kaYCSFPiSgVZQ4WxjzCkaesp60GHFcUZMDcmMHxm5JUUWNNbFIL/xymzENwTMP3TS19cjULHQQpI2e8EyzKVC/4tfjMvLqIYmWseuFod9fPsxPLVR+zoMDvPOuhYy3BJ2l89ue7zCuDa+QRXLIaIPUyUAqUCJkyZoJa6nfM72KIaijnENNRq3DilVoJiyJBQDZSw2+PBV/ecBUrOYvvAR8zhCaUMwXB4HtqiFMoLMUVtFKBRxr74/71ljqyR75ZW9FkTAly/DbAG1Kx7XlgVe8qqWL3M/wRY3Fp0/nT+33B+dnTs7hDX8q3dvDud6nX+T4Bmz+NYSBU9XEsRIugg1j4pu32tU3gLlBjZvWByM6aL9nw+ZYhLy6nqhvgq5TY+5aj5uRTBJOEq3q5+13YZhG++JQIQSqHM/0qOINJ1o/wg3SgZKd+p1YBOPEkRl4e3xHs6Z1kigfBUsGuqYW//qg1FRA0c6eNMMbipPFEOtiz0R0Ina9RE9LR/kS0azCRybzgUu+cobkLxK3/idmoF7smVrv3cw7pbo2B1ZjIleakhmCGK/ZN7yKSx2m9IcTk2eWzuIP0Xo27LVyExMy1YF4f75epPxE1eznBlSdgCZcjJ+Z434cm2WmyQHf1Zw/IIgPoVBb0b12O0ST73RmCivIy5aIm3UEgJZGKZBPKjXx8+O4Gdt8ompB4MYo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+yDOWt5DpEPW22DPrljf0H6ACFPFKXScBAnv93BMMYHdGERDh+M412l7Qn9n?=
 =?us-ascii?Q?Y2MA2KbkyS40yaAouH05Cma0ZWBZRcyNieTmLy5U7gMiTkwnDL2VTyHcjMLB?=
 =?us-ascii?Q?Q84OtvD2sfjJW8+YN6iiil4S0WjmZYStP5628EJzMQfzTqJtjPfzy8h+CtXp?=
 =?us-ascii?Q?ECq1pT7AsLpFobasdUq0NWUMdCeimh6ptnbiWJa4JDX0SmyHA8DAebDmo4pq?=
 =?us-ascii?Q?0/EZu2uhJ7V3G29IlNZEME0TKZqISNrCQ38xQsS45CdE72IXKSibl/2jPHQ1?=
 =?us-ascii?Q?A+N0gUDXO17tbx4BhSzZD1G7tdZilLzurp70GtLsTgmc9deMPIDlcLy8NT5W?=
 =?us-ascii?Q?RKS6nqjaSxKx7MxiLbqq6SN5vhOv8g98l2hyZL5Ir43OoHMZ7d48Iu5/CWeR?=
 =?us-ascii?Q?na2H7cSqFvIJ6pAWuWRF3IMZ75OxnP2BWFIIWxY9c4CifLI/MHfD2O10YWdy?=
 =?us-ascii?Q?t71KASCsAAoJiDpego66/2cleP/o8f83Dd1ho9CK2T0L6AIgKH2CHvZS1UY4?=
 =?us-ascii?Q?5N3lfJnSn4XL+/gvAxJzifRQjVEKXnGiSNF5+QC9IeRf9YrQveKGruSPqIsK?=
 =?us-ascii?Q?v3s1HmgWScrCPyEWzx0g9qsdz3mKwYu9KtRUy12/6q/5uWzaW0rL3J+KQEjb?=
 =?us-ascii?Q?LBglUQYI38vZWMbBJ8L7Sju2rWIiyqncr6riE+I7V6Z6hx56cQs/GxcBVAGS?=
 =?us-ascii?Q?4kukffNb4SMMGlCBr9nvRIZ8OHcNohu1vr6UhR3oy3OuhBKG8ix/rdxTieBh?=
 =?us-ascii?Q?hK58tDK7YymfRT+5V3f0q+2eDsUeAWX+0bgRPPdZst9N7cHKF1IWiu6sv8ij?=
 =?us-ascii?Q?wzO/H1pCNmS4m9yPvrrXaUgNg6LkjLK9dCYhkEvFWqdqnWQ8oPA+GoRFRG88?=
 =?us-ascii?Q?G5crFAVVwpxLTUGbgO5axFnXfwG415yV9Cx6E4KUGf5RzIPeurNpndGVK5vb?=
 =?us-ascii?Q?/3bfQ4J3IODl6BMRVy4Szu87zu+DUyaYoTTsgdOkSMI3QXb6298b/7cFYQWs?=
 =?us-ascii?Q?xtZoOjip3r1nDuK2XgovsDmsAHL52oqcmGk2gyXtnbQH/F6jsFTwEXyeq2qo?=
 =?us-ascii?Q?GZoPV0Btf6n6uCH7K6duXPx/xbdC8rPvsPoXs4nW4jaFm6XLV2KxOxuyOVTK?=
 =?us-ascii?Q?BvkEbq0DS3HKPyWn2f/4U+XAx+T5z+bJ/DFKtBsj/ySqXOag2R87GMxYLm/h?=
 =?us-ascii?Q?6z4US9XTpZhoHngnbMcIukeIn91E09zgUxeSQl9xvBlT9MnKYZku9KTFwq9Z?=
 =?us-ascii?Q?0bJXfxMl23I6By2Q8kif7uMc+p7Sp8lkmv3kZ5C88PYiSeJXonz257zbjjcB?=
 =?us-ascii?Q?T7UbFvk2lArJqpGjMJVdB4+HynGY4Y7ec6YcEGZH0hdqbCUc9XRbaTurTeOo?=
 =?us-ascii?Q?wbpEJ1wBNkWUU+nr8nGCfJvQWe1zqqT5skVymdWDLrEjNh7NK8+RNdnCGc4o?=
 =?us-ascii?Q?NJWdIBm2gxxAci1cb2Kc7UoYyQaxq6F1AmUX3QryMft0ByuIOkt8zKVd2kJl?=
 =?us-ascii?Q?qf15jUCeEF4X88jOnVBcNUicQahlVS0A/S+ygSC72f8B++Zy+m/EbM9xEG5O?=
 =?us-ascii?Q?ZPilE45Ilf+Yq4QG73UnbAqcStrOcVz8CStK+4zxKAd9y13lahW5vxwaimMJ?=
 =?us-ascii?Q?X8N9pSoEgIeyXV1L2Vkpos8i+21hzreJE2/AUwn0kksZtKLjWbjkGFqPW0hJ?=
 =?us-ascii?Q?W8N/YmQF5/lqC5Ejlxx0Ow8XMkOhfcTAkpq9QvpNckjYI8CF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dc8fd6-01e0-44f0-011d-08de7b245d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 02:02:04.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8Q4M3ze49Nmajk0gOZMLSJ7HWZ4P2skNRd7loLDTLiPi4975SoJJj/54oNibNzUBsUxs//UEDsTfhM+iBKXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950

> On Thu, Mar 05, 2026 at 05:52:59PM +0800, Sherry Sun wrote:
> > The function imx_pcie_deassert_core_reset() always returns 0 and the
> > return value is not used meaningfully by its callers.
> >
> > Change the return type from int to void to simplify the code and
> > remove unnecessary error handling paths. No functional change intended.
> >
> > Fixes: 835a345b18b0 ("PCI: imx6: Reformat suspend callback to keep
> > symmetric with resume")
>=20
> This don't impact user and it belongs code improvement. So needn't fix ta=
g
> here.
>=20
Hi Frank, ok, will remove the fix tag, thanks!

Best Regards
Sherry

> After remove fix tags
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 81a7093494c8..ba6e7c7ee625 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -906,7 +906,7 @@ static void imx_pcie_assert_core_reset(struct
> imx_pcie *imx_pcie)
> >  	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);  }
> >
> > -static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
> > +static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> >  	reset_control_deassert(imx_pcie->pciephy_reset);
> >
> > @@ -920,8 +920,6 @@ static int imx_pcie_deassert_core_reset(struct
> imx_pcie *imx_pcie)
> >  		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1)
> */
> >  		msleep(100);
> >  	}
> > -
> > -	return 0;
> >  }
> >
> >  static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
> > @@ -1292,11 +1290,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> *pp)
> >  	/* Make sure that PCIe LTSSM is cleared */
> >  	imx_pcie_ltssm_disable(dev);
> >
> > -	ret =3D imx_pcie_deassert_core_reset(imx_pcie);
> > -	if (ret < 0) {
> > -		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> > -		goto err_phy_off;
> > -	}
> > +	imx_pcie_deassert_core_reset(imx_pcie);
> >
> >  	if (imx_pcie->drvdata->wait_pll_lock) {
> >  		ret =3D imx_pcie->drvdata->wait_pll_lock(imx_pcie);
> > @@ -1613,9 +1607,7 @@ static int imx_pcie_resume_noirq(struct device
> *dev)
> >  		ret =3D imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> >  		if (ret)
> >  			return ret;
> > -		ret =3D imx_pcie_deassert_core_reset(imx_pcie);
> > -		if (ret)
> > -			return ret;
> > +		imx_pcie_deassert_core_reset(imx_pcie);
> >
> >  		/*
> >  		 * Using PCIE_TEST_PD seems to disable MSI and powers
> down the
> > --
> > 2.37.1
> >
