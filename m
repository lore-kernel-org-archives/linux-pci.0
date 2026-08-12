Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB1364049;
	Wed, 12 Aug 2026 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502954; cv=fail; b=pjnkxbWVzzcswnvZT8ANHvnoZqtWomnD0H+3Z7nZLBMQhUMYZM6rOnoLWFb51ORjvew/cjnfE5pZvp4gbYCUerR8oGoMS2bfZSRbg7LSG4lUCgpDNbnJgE4qcTiAZEiy3cUrIwNld2jG96/gcTps2cXy+0BsEzTkjtK4dHHjZoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502954; c=relaxed/simple;
	bh=8x+PSbWbndKIigaBJqkeAOcX1qVhBu3H20NWFGTClWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HoY6W3BnZCcfvhnA/VeJ2DQvzHM4yd6Ot+sIJdn0ItUFfJc4RIaS4D6xOiTPkn/fxgkI9318jJLrd+VTYV0oo3nGYpQtvire4G2e0oMUwxYirJTU3VZEwbd66EXuV1LBZW+EhRAfuvCLkLejmYT/APIi0b9/ZnG7X4ksCwtPIkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUdvjTu9; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUdvjTu9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDi6YuUD1ibCZ0WFHtAHoLbtyGceNmd/ghnO9X+Da4VCwonLMQaHh5pBwqX4Nn/lu6b6nWOlUMYGha7mYu1Uib/K22wPJxNLiZet0vQX/Ze5aalhWPyZd058cERD/AcA3S4JxdnL0oHo7WLxv3afYs8l6vWCjOOuhtDl8kdm2NFlVSIuNjedydU8vejFL8VA+dY3kPxfIA94EXv1F46a82DcdV66h7d5fln19RVbYqc7RnO3/gGRAKmLxGlVHTNhbbGw25iVW0rHAC74uwxC5+gBYj38K3YOjsSB659lkoLjuHNVyqGuAmzS2q4jLQhdzFi+6c+MPzl4ur1hN94RRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODfdinlVxItEhRhh4thOGA2kc4+u4gtJF9GT+/cSdEI=;
 b=RTWCUGYF7PD62URvHN7vpzb8rsiuHfS8fmwSsu//KfilZhSqbgJnY8gZ2Fln4sZ5U88J7kx+F/He8/o2F3pJReek6ixyATEfB2Jz4bvPLKLVBj/8mdKQbAVkz6FTnGosVhjBieYKk6bxKu2wZUgDWpbvRudRzz+egOw67ZLjnoJTv4XWRMLw7zN4NsYZQfozKB4J7mR0k59czeGoO3svV/sWNPxXXU1WhL9bEGU4U5aOaMsRloWQbOM5A850L76Wzn9l8WpfklZ/lzyzUO8aMexqhKrzePNJdZqa9318Qun1fZMVYvTEUVgFDyU8meIJ/uCbzWxf/DimeQqTbycgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODfdinlVxItEhRhh4thOGA2kc4+u4gtJF9GT+/cSdEI=;
 b=AUdvjTu9Ixtc0K4Zxy+hr9QW1BtKpaSso99cwyQiC5846Ph4iR/DwwZONUJDfMGdVMUwqHunmeg8kK8LEtEQKbULFaYwlDIGIHenTl+O0WMyVEw9EUfDgtey4H1Pm+hGQffadFapEMjASVGXGrI3YZkowgiW3XeLU8FWhqF8OsB5NoCf1gNjMV5wpL+DTjNAko8XaB/0nkJKJZ7Blb4EODtdK7A59g7EEk/1z9RMYR8h+61BAAktZX/WFgoHQCTdU6JlbjUVjQciabgdKnhQfOTsgTpWYauhAnWiRKOp53OYu7pY5hMk1rBd739/XPtstdiWNDu6lhJlfdjJN0p0LQ==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PAXPR04MB8784.eurprd04.prod.outlook.com
 (2603:10a6:102:20f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 02:49:08 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 02:49:08 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rudi Heitbaum <rudi@heitbaum.com>, Lucas Stach <l.stach@pengutronix.de>,
	Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Thread-Topic: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
 needed for i.MX8MQ
Thread-Index: AQHdInKVgAgx4tMI9UOi2+V/pxTl57aZwjFw
Date: Wed, 12 Aug 2026 02:49:08 +0000
Message-ID:
 <GV2PR04MB12019D0F84B4357DF2403B2C68CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
In-Reply-To:
 <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PAXPR04MB8784:EE_
x-ms-office365-filtering-correlation-id: 63ad32f5-ee06-440a-9ab0-08def81c4822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|7416014|366016|1800799024|376014|38070700021|5023799004|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 FdgKTMCYu2ziYE3VjOrNdFmcWgbxOnnY2Arwd+k5AtvTM+ekD6WeUEC46lWj1SmaZsCQkbMO9YeQsfm7ZWhEFR5iTcPJXfdnY1PlQMYqwvEFIT/Ld3x7i4mMI4jd6l25LscEBen5EfwGdmoe4KjjruG2tJM1uObCYwcsDi7OS/uzc2bowSQZMFOS9pJk4hgCA9fyiAlh95DiT4nq9RyZvdXNSqJ4dXcq3yyOyf0Hc3+f2zE46cBttO5FwlAypvg0cipMzYE57c9tL4p3z5jFuHLpg7YE4DHI2DXf1UFkWdVR+BuKHSrFANBqmWlZQsFet5Ft7+ZmIfCQLMnZ9nP03QeqBbcTUYySkansgscr1vA0dobmujzb1O9xvZOsZZrS1cJxY/NR035BhRjRmXYQJ9POFcc4XWfZdVj3kJ+BtKDIhEwmq2y8A+Aj/o7up/NgEUNurTo1JHFXVUXlLoQBRWERaoyMmD7kUjTdrERkdYkzaK1JUu8yldzbFkGXiONre7i//C7OPPOYVMFfeJ3BEIp1Jq4Ak8yl2SOcGbnauBPEBr7joXD8hDm6yGpGoBRp9ZqFvvAfTP2/navYGylb94jI26YTm1LIBCtq1FUqZFrItuJcFU2jhSZyUq1bFp05Z7dkviHi9cu+OGxrI9oFNlxyK+ABteyKbhfIqHpcfys2b43OtJ5S+9CSiL6ACvHnPJK3JCmyW13iz094n2/ybdyaYVTRDryCZxO15mMStmY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(7416014)(366016)(1800799024)(376014)(38070700021)(5023799004)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?dgYw5lDsDW1AjqR2WRQMk7WYFnDkoke25d7I3ebamH1MRxTyoEQYF7gy6M?=
 =?iso-8859-2?Q?IK4OoNYhpPiDm1bxzVVuFh8L/18r22BduY6kF2o84hrSJxYgE0ii22m/Up?=
 =?iso-8859-2?Q?dvveKCyD7EFMJWWG4NxzclMeXDPIhYWQmC78o9UV/IF8Gvi/5RK0kRA6TL?=
 =?iso-8859-2?Q?ijT5PgVUCO6oCXKnxPisjY8FlYomudeiLfza583ahV68PJmRqUuFvvRICO?=
 =?iso-8859-2?Q?3P19IdU4JeSHz7vDkArx7kdVzJAJWmAJCx0o54kTMKFrUFGZmfrIC3LdOk?=
 =?iso-8859-2?Q?C7YdrePZEuzzrbJplh00z4vFWqD5A3ev+iEf9mCc/2mfpuaBHkdTrhS005?=
 =?iso-8859-2?Q?U7264iESj/EJ0M+n0HiYqHzMl7R5jLstUcn1j0GfmXBleh+Ih39MWyBjFA?=
 =?iso-8859-2?Q?OmgemJaknX70tTDh8gq43RYTjbVeAgfbSQWioMc52zar4lOuZ28NB8PDzq?=
 =?iso-8859-2?Q?Cwqih0tudtVHfFgERWNuiBY5KOHyN4wKomBJsxbRMrYH+/cjVo0znB2f1i?=
 =?iso-8859-2?Q?6D59XVDTw29SZs0KysRlqIXr0S23v47XJfFPCoZkQtXvSfqdBNG8jySBbZ?=
 =?iso-8859-2?Q?2CUOgTpYB/VnNx55k+BZSx2R2vBnYBTX6KalPyegsHB7olFf/B3iJbHrDX?=
 =?iso-8859-2?Q?0Wvri94o3N6PpxzZnpvtX/TvciQ6yulz5TMhZvA9DjcD+4LpvECNMYnS3O?=
 =?iso-8859-2?Q?SoZAoxzD7VjsASN3i6NTOmb5yK1D7fCrCHzPE4LFIlgaaRnlsrNGxWKiEf?=
 =?iso-8859-2?Q?7XmJp9N7+1WmF3mJKDSxHMjS+Nlec3vrBJQeUT24WFzFwG5LWeQijjt7NS?=
 =?iso-8859-2?Q?oI2QeIGewNlUen/AOkffXeZkt0CE4rdSP8ODUyCeDoGGCKMaLbqAF21MlH?=
 =?iso-8859-2?Q?uXBnPBeYpuEvJyrYzOEmfgPTn2r1KExtcNuzodJBrldJgPNwIpLtBwamdS?=
 =?iso-8859-2?Q?Zn3F3PVONA+E5WrqLd7NK/LRk2NcvU7eic+isvQpIgkP1beBFCpfLkc9VJ?=
 =?iso-8859-2?Q?tuc/6zgNAwmqmP9fR1iafCvbXsl0wOQ9S7TreZrAr/I0EgnGICUPrIETSv?=
 =?iso-8859-2?Q?KhfN1p6G0LyO97upDOiGsWushY6cyWFCII6s6XPiReMWIqlsg076VUPjGz?=
 =?iso-8859-2?Q?ZRsUcjrxfhdZ2bWXC1WGFgc4OF38Zj3hbtO0Mdq7R4xu/ElIVaaRTHB4A3?=
 =?iso-8859-2?Q?/CQd6gs+wXaCksZqH2WoiQQNeNlHEmph92OHZAhefIL5YoY89AkVQI4Njg?=
 =?iso-8859-2?Q?tQRuIc9+fAApM3pzruPwkN5bpNh3NG9GXxWydlLLxrh9Mck21MrpeawcCL?=
 =?iso-8859-2?Q?vSd8mgwb8jwx3rjALqFaYNZRURgJFUWihresOyOmRXt2muMCAoA0/LyEmS?=
 =?iso-8859-2?Q?hhCCC7+i0FE86AvzdyHSU0nM4u2WbG74YeVpAR5I/lNiVLvpkCHiAjYUqj?=
 =?iso-8859-2?Q?Sv/++pAVdn7rsZIqf0B215VBU5XzcxCWvohNTZ+h/V/F3PAMH5eaaFVgCZ?=
 =?iso-8859-2?Q?+ra7Ox1Jyb2t75EFzWn48mesnRthoyfiPppyB/yGC0ce2Wh/TPqsjFVutO?=
 =?iso-8859-2?Q?JzKUhc1+aPVg2UnxJHM06ddZkDm9eyPOm6TCuZ0guEbBjiPEc0xHU/lS07?=
 =?iso-8859-2?Q?/xqp/PFPuXhSH3h3Aa07Yib10jRKWWXN4+WfshqNCq9d42ZJ2Se3479k/B?=
 =?iso-8859-2?Q?NLLIK/6wj71+wLCjYjra17kmaTSxwRyxwfXspjJ4uR8LCSHvRJNH1HFcUU?=
 =?iso-8859-2?Q?pbJa4dZMdCpiegNQDnSjzgVBskavCGPZz+HRo0p0oUmUJG?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad32f5-ee06-440a-9ab0-08def81c4822
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 02:49:08.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wq/XAcf99VBVO71xMHemT4WbPN67WKg887uxnQIsoFwIPY1QhHkQO+HnFLaSwpKGivoo+Ll6FQu9CoFbudaqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8784

> -----Original Message-----
> From: Rudi Heitbaum <rudi@heitbaum.com>
> Sent: Sunday, August 2, 2026 7:32 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Frank Li <frank.li@nxp.com>; Sascha Hauer
> <s.hauer@pengutronix.de>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski
> <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>; Rob
> Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Fabio Estevam <festevam@gmail.com>; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev; lin=
ux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> rudi@heitbaum.com
> Subject: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when
> needed for i.MX8MQ
>=20
> i.MX8MQ has two PCIe REF_CLK sources: an off-chip oscillator and the
> internal PLL. The driver unconditionally selected the oscillator, which i=
s what
> the
>=20
> 	/* TODO: This code assumes external oscillator is being used */
>=20
> comment refers to. Boards wiring an oscillator to the pad describe it as =
the
> "pcie_bus" clock, but nothing in the driver looks that clock up by name, =
so it
> does not select anything.
>=20
> Reuse the generic enable_ext_refclk flag, set when an "extref" clock is
> supplied, to select between the two, as is already done for i.MX95 in com=
mit
> d8574ce57d76 ("PCI: imx6: Add external reference clock input mode
> support").
>=20
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Sorry for the late reply.

The code changes look good to me.

However, I'm concerned about backward compatibility. This patch changes the
default REF_CLK source from external oscillator to internal PLL when no
"extref" clock is specified, which could break existing i.MX8MQ boards.

If the dt-binding maintainers approve this ABI change.
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index dcdeba1856f7..5a350b458782 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -445,11 +445,16 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie=
,
> int addr, u16 data)
>=20
>  static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)  {
> -	/* TODO: This code assumes external oscillator is being used */
> +	bool ext =3D imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Select the off-chip oscillator as REF_CLK when an "extref" clock is
> +	 * supplied, otherwise fall back to the internal PLL.
> +	 */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			   imx_pcie_grp_offset(imx_pcie),
>  			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
> -			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
> +			   ext ? IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);
>  	/*
>  	 * Per the datasheet, the PCIE_VPH is suggested to be 1.8V.  If the
>  	 * PCIE_VPH is supplied by 3.3V, the VREG_BYPASS should be cleared
> --
> 2.53.0

