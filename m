Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998873148D3;
	Wed, 17 Jun 2026 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675352; cv=fail; b=ktGGzMIX8Nv0ff9+EKPWW1FmCBLARKS5EEj1M4Bo7WxF6yoJBr+pIjnbylgmS8NBoH846/W29qdf7ZaH7xNeIKZKs9E5Ao8bGoJ9pxQEMpdWzIeGlQZpVZdG+7YL6suHnsOBP494BiJcSF3F5FPtb85RSbHE5AOyI6r6EbJadC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675352; c=relaxed/simple;
	bh=+OwTB/3yBXENT4TBN8w33m44LA+CFz6xkydt5DTLTyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=porymfYaYW6v4uK0xzElZHXj73KnV0yTIWmxSpSORPKDmwokK8VM8tBb+hUeecejoxNOhGr0tQhjxT3HU2fz00WR5+mltrYU1FF+mCbyd4n52WEGjXLkqSaRCGo0ZLyWki9+qhWUw3TiTt+6NSpwYeVQyDBRAKkQY9/pfzjCW0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SvTdHfmZ; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SvTdHfmZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIqsIJCwajLpLNremz17qVn+ff0lZREXqJtTF9uw2cZZcff6mjFgWDpuK60gFXm5YD7SPY4OWREUXzaaoxLqaQInc3G3YHM+bAq7rxkZSIYqlNxVel8cktSm4NEcnjzbrpaasijBz8xPTjHULINVQaTCNaP7HOiUo2OE91rTCMdHeqUbotY/d0vWaAPzvDitriuoOx+OeS4ie2Oq5wDWv09uKAR/iidZmti1JO0dVXNafxTCrpBbzz//ChuplofOy4tzeoSaRmBIvlHDhw3nNkzSEOyzrG/qjanVr9B+a0IHRht2V1Um4QOHmN93H0MfvrgV6LhZnVwT33aBIDqugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auUGjMlC/M7KRzJG6HK2U8+v7HgPdmxR7iisf3Umhsc=;
 b=AIvUMEJXofsui2znbJbUXbnLV9PlSxLnm9eebqeT5MTTITXeefUpoD0HTEOHl/fyVA2Hu35N2aB2FOvSlTFBvVYek4eMrFkzidv4EWiuTopltaNa6yvqcEtHPbJ01Bsf30ASWxSMru5qp/xj3hahKuJ0ckt827frM96wiXJZrTGA+RZQ4nlk+dYfaFV6nf0r6gQsSa78GTxUQuoMnG3Mrfza15dWYHI9QChfiLkzRdiqh8hYqBgBcDT3b1SZw0F4159JC/2guFD1xFrDMmFxI45uKuH7XwQXj01rGS9nRB0rOtXo7BjgLbSxzxlU40o+iDRn3xxRNm9VD4NxG40fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auUGjMlC/M7KRzJG6HK2U8+v7HgPdmxR7iisf3Umhsc=;
 b=SvTdHfmZs+lGU5TTIWKfW0til0alWryF3qKAITtpTt9EL6MzUHI6kHajkex0FIAS2/z9dlA5LTuo1mUePuAwsDM6cPGmdFBDTxgzfi4eGXG52KxaQnf6r6w9OYH6qK+0UFHqMB/5qH2CZMGfhAalvbKA+U49KGkOaLOjEjSuXTfEIJ/ZNffIzw9E3aihrZVOZHEmNBzkaK2ZMvJU6s0QibrYgInBfy2xs0qtrXl7OUivqczsF1fwyVP5G7nG/oGon3MLcRkC6oVOwE1kvh0nEVbGzvblX13utpRFxFHXCl5pCW8seyuZL/58RQXOUnWM08MWRQNwCuhgF1kwh5pYdA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI1PR04MB7181.eurprd04.prod.outlook.com
 (2603:10a6:800:12a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 05:49:06 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 05:49:06 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Topic: [PATCH v6 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Index: AQHc8yFf59lYFYACoke3Q1pkVqOUfLYsaHkAgBSNLXA=
Date: Wed, 17 Jun 2026 05:49:06 +0000
Message-ID:
 <GV2PR04MB12019659EB0F174DEDD05E11D8CE42@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260603062510.3767610-4-hongxing.zhu@oss.nxp.com>
 <20260603070533.641461F00893@smtp.kernel.org>
In-Reply-To: <20260603070533.641461F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VI1PR04MB7181:EE_
x-ms-office365-filtering-correlation-id: e7ee2edf-2e62-4cba-c64a-08decc3424ce
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|19092799006|11063799006|5023799004|4143699003|4133799003|56012099006|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Hm8TmmKzb8kk5JPmzUfb3zb8LENOzyKnfrt0TJl4ejoYqkFFuenBMtiWyE6ddDjw/O7wsB5tOuAf7zK5QANuHEoQp3BT2vo2yZ9VmS+IpLI6Yw9dhRuL5XKHhS2Lqhp2xzPA8Dt4iTU2kCk/fYuFZbHYJNXXtF8YMKVi5gtlHBcS1bWcVxKFvY+bOxONAbYOqcIz5nyQxVgdlYwt+5k/MtSG3Moe7lFd82XS0Z1yj1D3JP9n9T6EHIBZoikbcHpUw1VeLrO/iKwaAEmx0/e7Bsc2anGrvyvH1ACVs4wk6+BR+rHDkeJH7D6BI1ixBCcnZjjUEuqVSCkLmdzbCdFjNdBOrnkLB4R7wL0cuec3DmuR20EgqXBXQUeUan5Em3EWUJ/FYIscJKCM4n8qyxuvWerwkeLY3EWLZVqpDLitmzTNFDSU8siFyMCvITV631tgTfmOeoicRwbx8zJFjZfKe8+xJNcKWz/NLSxXDoJ8b5y3IZ8RkuSm5bdOcorFKbQmDTLE+06dqVw6sb2OBwAshGANVxs7y3bYO1rX/381MAoGnFVrUpbHWemIt4hOf3CV0UhC4edcx+XAHYdfQqG06K4e2BP+IwinH/uFdiIgVvb/p/szBCXLKSoGDnrcAJlK+f9ayqd+wlsxConhKrvgx0KbBsIQWgtXeVBYNHNCSOPeQ9a/2igcEKxKQsizm6Fj04qzW9z9w9ekTl3bxfiMzntT2vpzAxHZkIoyym9QpFcePFuFPmRh8BGags5/E6Iu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(11063799006)(5023799004)(4143699003)(4133799003)(56012099006)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ONOTABumK3LIJ1r2LHB8oeeqst415T7t3sWR0OWhdpoJF1lNJ73jBRq6/JRE?=
 =?us-ascii?Q?W1/q2/iFg4R2OORsQhARUzLibtC7wCKW7rKzu4FJz0T+hBzs119mOiEh+XMm?=
 =?us-ascii?Q?e6LzkRDmXglBd01E1PHoU7+ZQynZ3nJUPiv3CmcmnbsGtQED7oYx2JP5G5tp?=
 =?us-ascii?Q?5BZxqYH7P2WC1IYozXhecmmbeTngPKWSYNKplwtVyEwEG+ixssy/B1F1wqRy?=
 =?us-ascii?Q?iEOWeL/POzz0fcob5Ue34+jQd6e+FtMnvzPxQP+AlOZaiT6wcjoqIzlv+I/U?=
 =?us-ascii?Q?z8GLQei2+j9K/w4TjJQ64Rw7urGbTbygzRd24hgJx3Cv0cqYUauoz+wnfM0y?=
 =?us-ascii?Q?qwz68t639XFRP3ceSXvzN7Z/A2RImbPFYA2ud7Xrofn/I7AMT1YcwTCm6aYU?=
 =?us-ascii?Q?apa0PiAK/b9Q2q/aZhvwSplAeFokogMMGAMb26X/VUwXqRZ5h4IWt8KLapDI?=
 =?us-ascii?Q?wUQf4VNcRhQR++LICsh8nw1s+DfrEjIwDk9iMtcofUQPDaGfCouH5cNeWnTL?=
 =?us-ascii?Q?pXGP8NV4g+eqf2Ep8G/PDAjvWdZq7Z3MsbrSNFQ0f+Y7QESRDMKd+pIDNo6M?=
 =?us-ascii?Q?gfSvEbPZE7OGKaO2M2XsOf60aZWfZlo9QO52NnOoM7KMAKHA75tzy/f66uuv?=
 =?us-ascii?Q?PVNRp1lbsXyvV5NIDaaGErB6y3WbGaWdWJyP7UAta/3rQQ5I4Qr4EG3xHyW7?=
 =?us-ascii?Q?RW2bvxJXXNH8HuxY7QDKVa4o8p5G8Q8mNdR5i2OQ/8CggAbNwECM/ekbq/MC?=
 =?us-ascii?Q?47wlmWyWb20auF0pPvc+Ippkg4xfdzljKe0RW0PUr/X8U4HTkLy1z7I7F5Dw?=
 =?us-ascii?Q?djLPWtQas5Qvwei5MsuB74Ca6DodQpNs3YghjSNCd4UNrZNfGjzZC7JA1WMy?=
 =?us-ascii?Q?laAz992dJ6E8QZoZ+01ycBPeD9nKe34H7+htmLcZCxnElViuPKUPGDNzVn1n?=
 =?us-ascii?Q?AEDUhFsC7kkCXPxPupqnxKTBKVPOIoUYVvCn7sYx4GkQ3eURsv3+hyLi53/w?=
 =?us-ascii?Q?39VaQEI+fds+0kpG1uRwQLcOM3NWV9X0lGrTJ28cB2hfuW9WORWIzDvFHfxy?=
 =?us-ascii?Q?Xdl9lytkz+bJnzfhyk2KLe+PItaFW9KBRW9AeZ91iHanwGXWqOhmU12YXEn0?=
 =?us-ascii?Q?L3nLPmx+tI2rSxcouyKsj/dbvaAlG4W++LohxcflM168vIsT9UoMoFynnM3w?=
 =?us-ascii?Q?Ag1vF/lhIMRT0VFLPmbi5whlrrSzVRmIn2TKUvx8PSunH9hwyitWxezR91WJ?=
 =?us-ascii?Q?ucajNgTbIGUQ4NKJ9I5zFIasntWAw/SVy2U7o+oNsRzL7g9WB2tpF0jmfhp6?=
 =?us-ascii?Q?9v/Q98iK3oJ+MT4ENT15TNnXnnKj6aFpaW3grEJr9V2ajihdScNxqnVCxzJS?=
 =?us-ascii?Q?kSBcbk3vEeJKp+7Y+T3bmS1HxMvxJhwpEX9dUAIGwjZt4/JvAm8345lj22i7?=
 =?us-ascii?Q?WVPHyBHkcqyBLo5WGa985lxe3YyI4E7b4uybBW8daNpqB98PzEOUjvhFM+Sd?=
 =?us-ascii?Q?p/fxn8Jk1YVFX7gjRUC7Bf8DG4nm/YRvVDbxwUe0wJVu09xUMOWDjcUa+J/8?=
 =?us-ascii?Q?TnmtZ/K3X8q95gHm7uGIouiSGZyvwWy/2H5e/M7A08LVEZ31TDGEJ51H0p+G?=
 =?us-ascii?Q?MI4cukBPYXHZf940Y0NcxN807/w1Z1ew/YXjbCQ5T2kDm71JprWU468FTkqM?=
 =?us-ascii?Q?SGrPY5yQR+wlWNvL9QHEhDq5neyOPdNHz3fED7sJPxOTrreB+gE9Tc2tOfwr?=
 =?us-ascii?Q?ff905InESw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ee2edf-2e62-4cba-c64a-08decc3424ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 05:49:06.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7arSuP3fUksMkiQjf8Wh5Wd7xhLnQgvki/MJDUDbOA+OFgsPt1t+zDuR6ouZ3eFkA4+MHSBjyGgxqkWvGlS7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

> -----Original Message-----
> From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
> Sent: Wednesday, June 3, 2026 3:06 PM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: devicetree@vger.kernel.org; imx@lists.linux.dev; robh@kernel.org;
> conor+dt@kernel.org; Frank.Li@kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v6 3/3] PCI: imx6: Add root port reset to support lin=
k recovery
>=20
> Thank you for your contribution! Sashiko AI review found 9 potential issu=
e(s) to
> consider:
> - [High] Read-modify-write operations on mixed RW/W1C register silently d=
rop
> interrupts.
> - [High] Shared interrupt handler checks status but fails to verify if th=
e interrupt is
> enabled.
> - [High] Ignored return value of `dw_pcie_wait_for_link()` hides downstre=
am link
> recovery failures.
> - [High] Lockless traversal of PCI bus devices in an asynchronous IRQ thr=
ead
> exposes the kernel to Use-After-Free and list corruption.
> - [High] Link down interrupt is not disabled during system shutdown, caus=
ing an
> AXI bus fault and system hang.
> - [High] Failed root port reset leaves the controller unclocked while sti=
ll active,
> causing a crash on subsequent PM suspend.
> - [High] Unprotected hardware indirect register access during root port r=
eset.
> - [Medium] Ignored negative error codes from
> `platform_get_irq_byname_optional()` break probe deferral.
> - [Low] Build failure due to undefined functions and struct members.
> --
>=20
> commit 5bee25b25210b0bc28349bc8474d10204a25cd72
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
> > index 773ab65b2afac..aa5c90be23df8 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
>=20
> [ ... ]
>=20
> > @@ -1394,6 +1401,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp
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
> [Severity: Low]
> Does the reset_root_port member actually exist in struct pci_host_bridge?
> This appears to cause a build failure since the struct member is undefine=
d.
>=20
[Richard] the `reset_root_port` member and `pci_host_handle_link_down()`
function is introduced in a prerequisite patch that will be merged before
 this one.=20
> [ ... ]
>=20
> > @@ -1661,6 +1675,9 @@ static int imx_pcie_suspend_noirq(struct device
> *dev)
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >
> > +	if (imx_pcie->lnk_intr > 0)
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
>=20
> [Severity: High]
> Since IMX95_LINK_INT_CTRL_STS mixes an RW enable bit and a write-1-to-cle=
ar
> status bit, will using regmap_clear_bits perform a read-modify-write cycl=
e that
> inadvertently clears pending status bits if they are latched during the r=
ead?
>=20
[Richard] This is acceptable in the suspend path. Even if a pending interru=
pt
status bit is inadvertently cleared during the regmap_clear_bits() operatio=
n,
the link would be down at the end of suspend_noirq(), and retrained during
 resume_noirq(). Same to the contents of link recovery.

> [ ... ]
>=20
> > +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv) {
> > +	struct imx_pcie *imx_pcie =3D priv;
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	u32 val;
> > +
> > +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> > +	if (val & IMX95_LINK_DOWN_INT_STS) {
>=20
> [Severity: High]
> Is it possible for this shared interrupt handler to be invoked while the =
interrupt is
> disabled, see the latched status bit, and erroneously return IRQ_WAKE_THR=
EAD?
>=20
> If a PME interrupt fires while the link down interrupt is intentionally d=
isabled, the
> ISR will still claim it. Would it be safer to check if IMX95_LINK_DOWN_IN=
T_EN is
> also set before proceeding?
[Richard]Good catch. I will add a check for IMX95_LINK_DOWN_INT_EN to ensur=
e
the handler only processes the interrupt when it is enabled. This makes
the code more robust against spurious shared interrupt events.

>=20
> > +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> > +		/* Clear link down interrupt status by writing 1b'1 to it */
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				IMX95_LINK_DOWN_INT_STS);
>=20
> [Severity: High]
> Similar to the regmap_clear_bits call above, could using regmap_set_bits =
here
> perform a read-modify-write cycle that inadvertently clears other pending=
 write-
> 1-to-clear bits in the same register?
>=20
[Richard] This is safe here. The status bit is cleared immediately after be=
ing
read in the ISR, so there are no other pending W1C bits in this register th=
at
could be inadvertently cleared by the read-modify-write operation.

> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
> > +
> > +		return IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv) {
> > +	struct imx_pcie *imx_pcie =3D priv;
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> > +	struct pci_dev *port;
> > +
> > +	for_each_pci_bridge(port, pp->bridge->bus)
>=20
> [Severity: High]
> Is it safe to iterate the bus list locklessly in this IRQ thread?
> Could concurrent modifications to the PCI bus list cause a use-after-free=
 since the
> pci_bus_sem is not held?
>=20
[Richard] The PCI bus structure is stable at this point because devices are
only added/removed during enumeration or hotplug events, both of which hold
the appropriate locks. The threaded IRQ handler does not race with these
operations, so lockless traversal is safe here.

> > +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> > +			pci_host_handle_link_down(port);
>=20
> [Severity: Low]
> Does the pci_host_handle_link_down function exist in the tree? This appea=
rs to
> be an undefined function call which will cause a build failure.
>=20
> > +
> > +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> > +			IMX95_LINK_DOWN_INT_EN);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
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
> The i.MX95 PCIe hardware uses an indirect access mechanism for LUTs. Sinc=
e this
> reset executes asynchronously in a threaded IRQ, should imx_pcie->lock be
> acquired before calling imx_pcie_lut_save to prevent concurrent operation=
s from
> clobbering the shared indirect address indices?
>=20
[Richard] The threaded IRQ handler is serialized by the kernel's IRQ subsys=
tem,
so concurrent invocations of the same handler are not possible. Additionall=
y,
no other code path accesses the LUT registers during link recovery, so ther=
e
is no race condition here.
> > +	imx_pcie_stop_link(pci);
> > +	imx_pcie_host_exit(pp);
> > +
> > +	ret =3D imx_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(pci->dev, "Failed to re-init PCIe\n");
> > +		return ret;
> > +	}
> > +	ret =3D dw_pcie_setup_rc(pp);
> > +	if (ret)
> > +		goto err_host_deinit;
> > +
> > +	imx_pcie_start_link(pci);
> > +	dw_pcie_wait_for_link(pci);
>=20
> [Severity: High]
> Should the return value of dw_pcie_wait_for_link be checked here?
> By ignoring it, the function might falsely report success to the PCI core=
 even if
> downstream link recovery fails, which could lead to unsupported request a=
borts
> when accessing downstream devices.
>=20
[Richard] The return value of dw_pcie_wait_for_link() is intentionally not
checked here. Link recovery is best-effort; even if the link does not come
back up immediately, the MSI and LUT state has been restored, and the syste=
m
remains stable. Subsequent link training attempts may succeed.
> > +
> > +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> > +		imx_pcie_lut_restore(imx_pcie);
> > +	imx_pcie_msi_save_restore(imx_pcie, false);
> > +
> > +	dev_dbg(pci->dev, "Root port reset completed\n");
> > +	return 0;
> > +
> > +err_host_deinit:
> > +	imx_pcie_host_exit(pp);
>=20
> [Severity: High]
> If the re-initialization fails and imx_pcie_host_exit disables the clocks=
, the device
> still remains bound. If the system later initiates a suspend, will
> imx_pcie_suspend_noirq execute unconditionally and trigger a fatal extern=
al
> abort by attempting to read from the unclocked DBI registers?
[Richard] You're right that this is a potential issue. If re-initialization
fails, the clocks are disabled but the device remains bound. Because that
host_deinit and host_init are already symmetrical, the host_deinit shouldn'=
t
be in the error exit path again. Would leave the clocks enabled on failure
 to maintain a safe state.

>=20
> > +
> > +	return ret;
> > +}
> > +
>=20
> [ ... ]
>=20
> > @@ -1919,9 +2018,33 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  			val |=3D PCI_MSI_FLAGS_ENABLE;
> >  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> >  		}
> > +
> > +		/* Get link event irq if it is present */
> > +		imx_pcie->lnk_intr =3D platform_get_irq_byname_optional(pdev,
> "intr");
> > +		if (imx_pcie->lnk_intr > 0) {
>=20
> [Severity: Medium]
> If the interrupt controller is not yet ready, the platform irq function r=
eturns -
> EPROBE_DEFER. Does checking strictly for > 0 cause the driver to silently=
 ignore
> this error code and fail to defer the probe, permanently disabling the li=
nk recovery
> functionality?
>=20
> [ ... ]
[Richard] Good point. I will update the code to explicitly handle -EPROBE_D=
EFER:=20
imx_pcie->lnk_intr =3D platform_get_irq_byname_optional(pdev, "intr");
if (imx_pcie->lnk_intr =3D=3D -EPROBE_DEFER)
    return -EPROBE_DEFER;
if (imx_pcie->lnk_intr > 0) {
    /* setup interrupt handler */
}

>=20
> > +err_host_deinit:
> > +	dw_pcie_host_deinit(&pci->pp);
> > +
> > +	return ret;
> >  }
> >
> >  static void imx_pcie_shutdown(struct platform_device *pdev)
>=20
> [Severity: High]
> The patch enables the link down interrupt during probe, but looking at
> imx_pcie_shutdown(), it does not disable it before asserting core reset.
> Does asserting the core reset drop the link and trigger the interrupt?
> If so, this could wake the threaded handler to access DBI registers while=
 the core
> is in reset, causing a synchronous external abort.
>=20
[Richard] Agreed. I will add code to disable the link down interrupt in
imx_pcie_shutdown() before asserting core reset

Best Regards
Richard Zhu

> --
> Sashiko AI
> review * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fsa
> shiko.dev%2F%23%2Fpatchset%2F20260603062510.3767610-1-
> hongxing.zhu%40oss.nxp.com%3Fpart%3D3&data=3D05%7C02%7Chongxing.zhu%4
> 0nxp.com%7C134330e3333a44f1683508dec13f9e4a%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C639160676183298029%7CUnknown%7CTWFpbGZ
> sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DT12KsupOJBTSoTXb
> rB0CAYhsJrCThSsXkEpdoqsB1GY%3D&reserved=3D0

