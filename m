Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27D2853E9;
	Mon, 29 Jun 2026 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700369; cv=fail; b=knBA7KpL1bGmgzAwKQjbsVuSU/m/zJ5YmbibadA/u2/IgpGec2Do2bfInKIqKZdgdqsr28DMFgaMP4gEkjIuibA+lsuXT6hPb3LrJiTYgnOZ62sBjZcbGKmEHBs8YNgrC4os0hpOD9+UIqIraIy3KGnvzx1uXMCN+qxRa6FOqzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700369; c=relaxed/simple;
	bh=TprojJYHXXPDV0mB86/uqqrstOIr6C9t0QctMQoRRXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FDxlxYrnGyvrUQ4ywAJcY7e2Pa4HlivdYOkw+AO7zeFH90WKAYeM/oJRtek/iPSyxn+12vq9vFXLLjXuzB9XCW69z+9tXKnE6FBTX1+mG2UFe5Nd07eADTEMn4y25JabN5gc8HBYuG1/jEiLH2/UPCERxqbJ5MBs1tv7nBl6kK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VIareztw; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VIareztw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UStWyUaN9MKTLerQ1Ch4UBHclaLtmOK+iVDHJrNz1dAIfo4/whrEVndvCtmbxnTvIOQ9BzNVN4+6JA64pcAvAYn5LTkhn8ECdJ7PD8lx2CxyuBBQmsG4bYub5h7MeXEutVfAbWdLR63MeN83HipyD1FItC4xqJvoFfw6t1X5H+HnsWYGBgtydJf9f+xMsIJCNzbCG7CGgmNDFyyxNxtD9hn/7mEhqulcfUpIayIJnNx0jp0SBxD4fXZGFNkBzznoMgybSqQgVF5jimjmH81reiQuaoTScIkDLDuA+Vyw34TJs/qLNKes7Uhfn/MWq7Q5feLsxusr4LwZy4CVFmtIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELeBO0NwZQvfks56nsL/7T3zeJolVZD3hT9GU0yfWKI=;
 b=DKc7XnlIGM45SaSOuEhO0xAkTs2gicdWAI+ATLXTKgQsMcBeIyUKTzBtL9vreRwJqjLajbqTQeHOK63DclpBAA2A5/UGw5xy2SwpUKYV8Yezal294UwOQ9pWJqivo8s+oPsnq30ZFp9h2+b1mDsgKnxCMeg6esXcfPLjxUMGmZOHgsdqZMeBqthcTMM6ftuE4RU1okHfUDER8Ow1kYGZWk6MtO3Vy//Zwk+nHgjRIucg7Ml3uon+1/wqxrDJt1nFYgUDY0DbnB0Q8hfbZVtr6u3DPyOue3VyjtJx3MEqL5reiAzAuRxZlWnan24ML3MEyvNJ3fXdJ2jBeQZGhLz7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELeBO0NwZQvfks56nsL/7T3zeJolVZD3hT9GU0yfWKI=;
 b=VIareztwY5UthnXlkVWIB7PmaqEpTU1S5sPFTPWWTGbIuwmHLnKk8QEkDM71tKvTViO6z5bRefOfHh5U0mcyPdZKpbOv6fLWMaq16mvUdwljPQvlY533EX0zF2MWS/XVxYxisYFWGieHshVQsHGAR0O9ZoqNiEZIBPTXPm5qbnsGcewYt6VjuO9dCZjAJzc/6RLmDQonqq21A73msxDYW4oq663VNn6AVO7/eeuu5jHXtXW4pz6Z9RD9iSWpEGUIV1Y0D1HPLJI0TDj+O/M7a8eh58Q8Cl69PzdchzqdaGVIw/meOjCn2IitiDoTWmIf9DysjJ1A00xJK/qfDl5FyQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB10718.eurprd04.prod.outlook.com
 (2603:10a6:10:58f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:32:44 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Mon, 29 Jun 2026
 02:32:44 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@kernel.org" <brgl@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH V3 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Topic: [PATCH V3 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Index: AQHdBRPEGxRif1od90W3Fz7KbEtN4LZRPRkAgAOWQvA=
Date: Mon, 29 Jun 2026 02:32:44 +0000
Message-ID:
 <VI0PR04MB121148A574075BCED6AE1815092E82@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
 <20260626023126.2189931-2-sherry.sun@oss.nxp.com>
 <aj7VpvRQxhCyPVPg@SMW015318>
In-Reply-To: <aj7VpvRQxhCyPVPg@SMW015318>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DU4PR04MB10718:EE_
x-ms-office365-filtering-correlation-id: 0a95dae1-bf27-450e-0e35-08ded586b38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 PjCIUYmj52/4yLgex+eKnGe84B5wtULPfAYU1CrQKARvVmLl7TwjKWdEQVq/x5vBbuCuG570bW09rtY7in2FQUSO4+EpbDiVvx8xz9Gltc8n+07ZDe+vGMGTJv1P1rbbjOwHFeegtSXinXmjBAUGyPyjuEOdpiWUWUWt4yKF6B9QYC5q8+es20qJLKB3f52+fREza5AV1bTFtAUfI53+ai+ZHZUDSPkEf1kQZ0+iV2gCrjcLQyUNcwFToajWCGJ8lly1rTAUum2avrZKD10COmjaAiPHbnpr1hfbRKdq0jNsi1bHW9oKCuImlU/OoVM83XYy9e4YTHZ2wxBfsbTxblCi/6eM7nezUkrgOvOFivrlV6MlEE8kbOxCQ/PiAeWfykOpquKON5S0TFqKxygBeo73dlA+CsaFUgRbbrjaUjrGVe+Fz70rtix5ANuoXpzQp1fDqOYQinCpu9blmYglT0Cx27XP//pvIMKgXaEEtyo8lG3gZTi/YpcigZfrjFK+2Aqcq+R0mUVK2WRlfnEJlb7kdLJxr2XwtLwHj8+wNjlxYSP5zMIDwsQcxi5c+2dv1wvRGoBZC/uNs/DFhcRFkMtCS79abj8N0p0Xs94ONOlVXETJLggDijQGx7z/SlGvTlTB91n0GtS0W59DFI5sH9UNRCIBJWHof0ASw1NiToJrCjOA1VWN0KjQknEMPxxfsA0Ch8KCi5YlhE4VEwE7DHCfoWQwn8syo9GbY2xNfAE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EtouLwiaor09zfBkwYvZuje0A7JQnDtGrUwFk/gmbafRKfYXA6/+ZVenDoEl?=
 =?us-ascii?Q?F6BJderNENNXxNuMM24LY3YXiovA76LvxLRE6wDyjsURpZWiB3p1dsJPbdx7?=
 =?us-ascii?Q?yCym533OQD+N5JwgBGkuTdWcUW3/34e31zWVskHv7wH/gVQZjxuj+/NAJlUB?=
 =?us-ascii?Q?0zRZy11QeVRBdgof/FExsbA7GmOiY4EeMbq/eQTRg71Do8McMPME/qUBVADW?=
 =?us-ascii?Q?F4fHwjOOpEhuLCwshrEZ8zKr5X13NWxBj6SLFxtTt+XL0n/9Hs2vrocI8Mkx?=
 =?us-ascii?Q?9f3bMxhGBIVl6QFyhim3zaMzjZqMqHu5sfrgLL/IcyVFAPDmgS3nD6xN+1QI?=
 =?us-ascii?Q?cqpInzj/gmxlVVd7RDuE8gYVn+j9yRVeu7xMoxwPt4Lsd6IHLBjfSdhQLKUE?=
 =?us-ascii?Q?SEzhX+xYa4ZGiN67GWpoY49YIR8V8KN03P9AytEp0TbpBPLR1uF0aRsy9+/S?=
 =?us-ascii?Q?Rjd3Juxax+wHBnW5LUSrwjfxv5UWUhSs9wdSoUSqpSc4QT4CWdeuU4iM+XVh?=
 =?us-ascii?Q?3GVJzZ42sgPTsAexpYql5B2YjRQeZbMNqcN0gZeQwJ2cJq5KbCVP0Q6/hI65?=
 =?us-ascii?Q?wgV9HyF+ZsQTjTqfZR1cR2bhFndsvJNpaV1QronduxvzHJsOizNhgElhBSR3?=
 =?us-ascii?Q?ozR+3yav1cU5UldDDoQ34u5m6n53sACKNaMmNUdmMpAgftnrfO0Dxzfr1yhu?=
 =?us-ascii?Q?K2TaOSkN3IhfzLT6I8Q0aZsKA7i1ydZ+J8TJPSW1QMuezyreWAdeGCbhG44r?=
 =?us-ascii?Q?iyFKQTCIz0Qyt5D0sNdWGwwKxfPgiwfOHPtaj5clieVreKkYwIZgMP8GV8+g?=
 =?us-ascii?Q?bIGuC8kJVa+1zbYrabtmR0zcYG5mTiHY5dOBc5lR06bCBvrnuXEA4D5fjb2X?=
 =?us-ascii?Q?8/cFTOPk4amP9fu8qVmb4S2LmD/c4QZglNDYGZxIzEMrd87Oo1gfO37dv1an?=
 =?us-ascii?Q?Dq/PNNcdIL8vd+GgimQDrLSsFR20QXq6CmND1UtD5e+gbtAk3HC6ydlNF8l/?=
 =?us-ascii?Q?RlxNcMqvaZGfCCAekOnCvob9bNRBiAvJV+w5+K2urTVKe8RiNpXNVhiQE40Q?=
 =?us-ascii?Q?ut1t/ipXf+55IYWUr+mfZVqMFX0/NnhaeyUR48/j9DO1roNZcOQMUXv1YT5k?=
 =?us-ascii?Q?fVMG4VKK1wBhuJnU1LVBJhFt69ziw7j4A2stbG1MDd7zN3oL7DtxO/t1fwW7?=
 =?us-ascii?Q?+P1jdhnSJkQf4vmblOVxC/tvBgtd2QT5AEy7YSUFyJZISooZNXas3ecv8FU6?=
 =?us-ascii?Q?u7n45RRdvIqTly7ZYQcWQLhtRuqkrTdkGDPMw8r/jH5Y4TxUwJRalmvcA3tC?=
 =?us-ascii?Q?WN+FgM0eStJipE9N2E8tSNjhV+MxhKVbNLEg0ZZg7OUWYVaJR0CILNnrvqZH?=
 =?us-ascii?Q?fcJnvthfwJUwRJDICFYemOQ7k9W5F1flyI/tT8B7HKeAPx54FynqIc+y3dJP?=
 =?us-ascii?Q?/lMW03gdwo29Pl2+7nlnQJGVtnZXfCqwNSouy5WYJAiLf7OJVCR7GrkdcaIW?=
 =?us-ascii?Q?+rrbe7jI40E4GdDHeFpSftLOfZjRNe24XczUfHnTLA1/5fXP10j9MFRI4dc0?=
 =?us-ascii?Q?vla4Fx9b8nMKHYHJewPpm+iqBJGYNH1bUzSLrZr5ORpFdHa1c65fOvgxvAug?=
 =?us-ascii?Q?9fd1vdea+2VLC5sVNpLtFcpGoh0v0oSSZmdvQ01sG9LxGMaMzxcCqawd8w5M?=
 =?us-ascii?Q?Onl/io8c8DT9sW3S5uM/wbCUX2FnhPQxLj+9KhOzNGFnlXsU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a95dae1-bf27-450e-0e35-08ded586b38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 02:32:44.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbGj/FBcFY+PJmHesfuERt0q1XJRmTpIIWbll0hx07JIISX497KLjAyXPlSA7zTbP3iQ63jofMG6Ayhkhsu62Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10718

> Subject: Re: [PATCH V3 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
>=20
> On Fri, Jun 26, 2026 at 10:31:19AM +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > suspend to preserve wakeup capability of the devices and also not to
> > power on the devices in the init path.
>=20
> Need empty line here.

Ok, will fix.

>=20
> > This allows controller power-off to be skipped when some devices(e.g.
> > M.2 cards key E without auxiliary power) required to support PCIe L2
> > link state and wake-up mechanisms.
> >
> > Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is
> > only called once during probe, similar to other regulator_get calls.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 43
> > ++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 0fa716d1ed75..0685573fee71 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1382,16 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> *pp)
> >  		}
> >  	}
> >
> > -	ret =3D pci_pwrctrl_create_devices(dev);
> > -	if (ret) {
> > -		dev_err(dev, "failed to create pwrctrl devices\n");
> > -		goto err_reg_disable;
> > -	}
> > -
>=20
> Please two patch do that. one patch move pci_pwrctrl_create_devices() to
> probe
>=20
> one patch check skip_power_off.
>=20
> > -	ret =3D pci_pwrctrl_power_on_devices(dev);
> > -	if (ret) {
> > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > -		goto err_pwrctrl_destroy;
> > +	if (!pp->skip_pwrctrl_off) {
> > +		ret =3D pci_pwrctrl_power_on_devices(dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to power on pwrctrl devices\n");
> > +			goto err_reg_disable;
> > +		}
> >  	}
> >
> >  	ret =3D imx_pcie_clk_enable(imx_pcie); @@ -1460,10 +1456,8 @@
> static
> > int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  err_clk_disable:
> >  	imx_pcie_clk_disable(imx_pcie);
> >  err_pwrctrl_power_off:
> > -	pci_pwrctrl_power_off_devices(dev);
> > -err_pwrctrl_destroy:
> > -	if (ret !=3D -EPROBE_DEFER)
> > -		pci_pwrctrl_destroy_devices(dev);
> > +	if (!pp->skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(dev);
> >  err_reg_disable:
> >  	if (imx_pcie->vpcie)
> >  		regulator_disable(imx_pcie->vpcie);
> > @@ -1482,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp
> *pp)
> >  	}
> >  	imx_pcie_clk_disable(imx_pcie);
> >
> > -	pci_pwrctrl_power_off_devices(pci->dev);
> > +	if (!pci->pp.skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(pci->dev);
> >  	if (imx_pcie->vpcie)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> > @@ -1954,11 +1949,15 @@ static int imx_pcie_probe(struct
> platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret =3D pci_pwrctrl_create_devices(dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to create pwrctrl
> > +devices\n");
> > +
> >  	pci->use_parent_dt_ranges =3D true;
> >  	if (imx_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {
> >  		ret =3D imx_add_pcie_ep(imx_pcie, pdev);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto err_pwrctrl_destroy;
> >
> >  		/*
> >  		 * FIXME: Only single Device (EPF) is supported due to the
> @@
> > -1973,7 +1972,7 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  		pci->pp.use_atu_msg =3D true;
> >  		ret =3D dw_pcie_host_init(&pci->pp);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto err_pwrctrl_destroy;
> >
> >  		if (pci_msi_enabled()) {
> >  			u8 offset =3D dw_pcie_find_capability(pci,
> PCI_CAP_ID_MSI); @@
> > -1985,16 +1984,24 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  	}
> >
> >  	return 0;
> > +
> > +err_pwrctrl_destroy:
> > +	if (ret !=3D -EPROBE_DEFER)
> > +		pci_pwrctrl_destroy_devices(dev);
> > +	return ret;
>=20
> Mani said he will fix DEFER problem soon.

Yes, so for now I'll make a patch to move pci_pwrctrl_create_devices() into=
 the
probe() and temporarily add the err_pwrctrl_destroy error label until Mani =
fixes it.
Let me know if any other suggestions, thanks!

Best Regards
Sherry

>=20
> Frank
>=20
> >  }
> >
> >  static void imx_pcie_shutdown(struct platform_device *pdev)  {
> >  	struct imx_pcie *imx_pcie =3D platform_get_drvdata(pdev);
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> >
> >  	/* bring down link, so bootloader gets clean state in case of reboot =
*/
> >  	imx_pcie_assert_core_reset(imx_pcie);
> >  	imx_pcie_assert_perst(imx_pcie, true);
> > -	pci_pwrctrl_power_off_devices(&pdev->dev);
> > +	if (!pp->skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(&pdev->dev);
> >  	pci_pwrctrl_destroy_devices(&pdev->dev);
> >  }
> >
> > --
> > 2.50.1
> >
> >
