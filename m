Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736911714AA;
	Wed, 15 Jul 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079535; cv=fail; b=ip5MDAaC4aA0LinbF2QSNq4pCrb42LjZjnhDzdCPE9zSPj4o3I08CLWdCbpEPeU66Bun6lr6NrSXhgH1ljqQmc/gyukk5OIsk2w11yf+PpcKZhbN5hEMzQX6grN13Ox+UGnYzEdi01NUsLMbyRMde5rraZPZeoHPHpokGE+tIZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079535; c=relaxed/simple;
	bh=RBdPIEXMOyv8btyqQqgnFbv1Zywx97YLaaU1NmYlHtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QnAdEduEHxQbXp/t4rixCrbI1FJskPMbvDs5v5y09UwSn5f3Jf4ZWWKH6QTdGdfxtHLyvGIsy/F1WQU4JToYROkhM2S/BQw8gZSK2MIHR2GH8+rkGOraqDIA0kTKsMHe/RZ1d+EU4sQtfFNWO0RKoAYSzMfT/gnZ452eMYQldjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MRV+VO3F; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MRV+VO3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTzpAD9Q6/9DC6pwzhSvy5lQe1tFDN1ZdYSFFLUcj79WAYMD49Cqhfz/nW7PH/CtxGW3qyVTVFT36TiQncepeUURXVv8gt6lhO07QyRW3tYjqYJckEetiz1qz2r2h3UdpCzqkUwNxrVS1o+vuW3Qx0B07LNzwZMgfJ22G5vG30AaCYFV/rslQRklzXUYsQP3s8h+QtPisfR2MLRRefpoSPLfYyeyyHzX2gIMnv6nMyBpsEBnRu3Wrix8/EAjko50Kan6iIU2FTh40ubMqbrwu6PU0CKz/019qcqWvyR2qY+6pNNddcxBt7f71ObveD4e3Us3TXyb5TV1NK68xJnxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxyvcLwKtdazNqOvkLyv6ht9xfM1XCHujNvTJY/tIrg=;
 b=QQn72aaGLFnUaaKKFf76s3XbZRX4lTA4DXn/4Od3azCq/uWIX/8KIFBffBUNP4TwZNr3xS9Wte0cZOiMGSdOphzD2u+kBokBhlYbWE0YQTvpxauXeI+ogHFMDfiFtwCY4cb87fUNA50w+AxSyW3NMf6/drk1m2N+qy0eCqoHoMk2M0R8oyzYk3zsN2bee8AZLyElSyzDK23g2/9h/TiAFNWRJR0VJ4paO1VYrnkiCmo/dW8u0hj6AcXrM8ij8BSGWKl9dRsubLYMBIi9bcIITHTxiFYxXoZqCYmmeEGzYF/xsYRAmEVyps/f7ylgx93hiq74tB5fYT5Da3XCNmRX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxyvcLwKtdazNqOvkLyv6ht9xfM1XCHujNvTJY/tIrg=;
 b=MRV+VO3F3pLL/kSqBaceoYPnDD3DBbwnyFlq8IN+7wcgAc6rUlEWbY2bRQTIn+nbh26tj94VEHZ16CjY6Es+O7Gk2d6yz0ky6iJ2zt5J2ziAAV089WekXrtiLYhz/GcubPySb2wbZgHn3B+rtnW4cKGLxr6NSb5GcrKfT+G5QP6yKjBOKO2fo+ncLZGYaWJN7IrHLW9rwb50vsvg5m6/2BV8iotTtyVi9Zs1ML9K7siHtuYa79GT1vzTIIagd1XAmtliwx1xfkqW39K32fJbZQwBAViV1zkj5OTHgQqqHqZothUM+TCt492C1mVvy58XGMybePIX7crVuWYscqw81A==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DB8PR04MB7017.eurprd04.prod.outlook.com
 (2603:10a6:10:123::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 01:38:46 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:38:46 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Hongxing Zhu
	<hongxing.zhu@nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Thread-Topic: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Thread-Index: AQHdDo25W26RGvcpZ0Gq9kNHQoJzyLZtAdsAgADWRcA=
Date: Wed, 15 Jul 2026 01:38:46 +0000
Message-ID:
 <GV2PR04MB12019768BFE54BDA674B9C4B48CF82@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
 <20260714125126.GA84291@francesco-nb>
In-Reply-To: <20260714125126.GA84291@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DB8PR04MB7017:EE_
x-ms-office365-filtering-correlation-id: 6235696f-1b90-4d79-8c1e-08dee211cfc7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|7416014|376014|38070700021|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 uXMlXH+nHi2tnwfH7qGvH37ZMw68Ozj1LF8eMaqCTvuE+xQ1bJVn+nFToYOxfTYetmdZQZtjRszGihNWxILdkJQf3bFKooaQxbf+2xKa1bLOeuBcWxakBVERqiWmZTFVqBIXsIhZPcPrZqDPhicJ0y+Tj5lW+R+vY509WV5cEbLD6UIlwXAC0WGDF/lE3vhfOwpFJI6jyMrCRhANRYR/ZwJNzMGSNJTvUeHQQOYz8v50DS23GSSJ9ut9DDwm2KQoXD7eDuEVi1J5WcF1hsXRq11z6EXyjfQAIQhumizs/ybyZF1FqM3TXzoz9Ghvc43T+diVY5cG1EOxuurBanCsVh0WdW43e0XkKOtBOcS4l4zJ7E9aK59hJB5KbWZhelD61jxuBGLjn2E4f0irnT98VlEdEKwL++ejMguioSJsBGvJiRcQinkEtmTDGf6D6xkuQ18uBjNnc6A6KEZHLJn1rqlR8GoR/byx8hIEt2fy53XGfvTBN+Y0wNhdTs73cuNoaCE1yL0bFNSRgYFHd/M/wii0X7grQXli4iiXFf/mwAEN4G4+4VO1xb0WuxvSlBc4b/KM1q9fUUJeGyE7AJjoIdWI5CITWM3fBvdoZp7jCK1x4D5YrH4E/aRlXrlymkTvWbSJjBVOWPoSf2o9BgcqYC+bgPL0jSDj9rKkQkZE22kh1iFexQglY8NolJsoEBv8nQPDj4W8gtnEUOOHFDueHmjfk71jKRORPd0xGEV9Duc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(7416014)(376014)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+D09Bv2/HtvZIMf1BqZ7OxVRjE7bcLgn5cVnRrjdb3pw242kbI8BfPgEp5ej?=
 =?us-ascii?Q?UNKuV+DPhBbvdAl87qENVPRcXfOQVj5IT06oYy2aAQH6WBIIJegw1EE9HzgS?=
 =?us-ascii?Q?LlbLD7hrfsFEXW7fqGJ8Di+J6nYovXgb0392PQudpj010XQEIhhsjMu1hf+m?=
 =?us-ascii?Q?nDaKrr/zNID1cuQ1eHT7Jh52Vb1ch98joDwIbZRyfOradxm29g9AgWpOdSnB?=
 =?us-ascii?Q?n+/siPna5jsTqgf+GlfO7RQP0fgYgSf60rYSXFCx9JVTvEzQDUHodkIXoGkR?=
 =?us-ascii?Q?23u4ihBPFyGWsRkDBcs7lyQJQsnzJJ7ilJ9V75/Z5LbbFBRo4AyVjRBTlBor?=
 =?us-ascii?Q?0+3FeJGRjd35GGON7KbOwF740dRSrxVADRcLgpt1DIf/JFDfjtoaXay62rh7?=
 =?us-ascii?Q?vW9XXYz13drNYKJJUCXXxr7tqhoV7x30j8vkXHWCIGp06OEU8S/C8Bcs++n+?=
 =?us-ascii?Q?EWrYI/0zZhREa0o8toXMMY+xsabPRz7bZOMXhXZ99fbLelkIXmvF2tid1RxB?=
 =?us-ascii?Q?0cVRAx0Ayzc1C8Pee/ba445j39L38SylUqM9ht+/sOJGp57yo+7ryqkzq73q?=
 =?us-ascii?Q?phdZGskHvnJ3sToIt6XOZEixqSNgKChecvLTiM0OzjrH4nX6KP7+h7a3oQvT?=
 =?us-ascii?Q?MYIid1YJHSmBxGnG+wcx00RzkJ8bKCTKlLwsw9M+tk+gqnADezQy2UT+ZPPq?=
 =?us-ascii?Q?JEHItMXLTpV5lHdeHFDjkNFXlDlc073BlHYa1JpqsLU482CDHcCxQGhhbsAo?=
 =?us-ascii?Q?1Cx/+ucm99nn4XnnT/arlTZCcmzhR+TVERWNnLBfDTr9cTk+H7Y0SWhnal26?=
 =?us-ascii?Q?vrHnQosIaiO17gkMC2wMOhv7Rf4drPtPr+/MmpqD9fzLJptZ5Nko5MkLQbUm?=
 =?us-ascii?Q?QGqTkGAUoaO1KM2dZiqlQNxHfl8cfH2HtKT7Kq+xcvdljl1oKS8+3FGFLI5j?=
 =?us-ascii?Q?ASY5xb2jzYybTbFl/hSOqTEBn+OTYZmzPkct3Ne4+MjhbLekkbDO6jNVnmEQ?=
 =?us-ascii?Q?WCRwPnSWrK2vDlakni1uzOaqxfKMCF/K/KmYUFAO2W4okjRNFcYhtNErdkj/?=
 =?us-ascii?Q?h3k8vfToZ6Ns1DjH88j/RyUvYt32/C8jDfi+VMJjFXR6EjIaYPGD3fRGhN7l?=
 =?us-ascii?Q?DxqECZOMFhhYq9+Gcl/GFMioqRSfZbj0NP1gNa54eArVm426lE6dUzy9c3mg?=
 =?us-ascii?Q?ty4JtbygsrPyfCCXFnOP4riYQwZ4xuPf2DqlEFCd0r56GMycmh/uGgWna9ik?=
 =?us-ascii?Q?O7kKqKNWW3JPtAimeUg5xtAP8VO7W1vwvpeajsSo8iAXkJ+f5VrHbyQtjt9k?=
 =?us-ascii?Q?yfhRdVbYTNuLupoXxweK7olXmCPcCClgZ0TX4Jq48INl3J36WX/IvHlx8I2i?=
 =?us-ascii?Q?/CdRCsM+wEZU5gQ4sF8d73sVtNL7T02krOiMfxwBX/i1Msn/LbODAGWuDSEZ?=
 =?us-ascii?Q?t50dg5dDDwUmuGedQDKiZBUJUWYcRzV7y9wOISroFPbf67qkz8bTh3ZZf2Sg?=
 =?us-ascii?Q?8cN/13Gp+06SBnfdiXqq6l1HFtnHTJPYV3WlbX8IeRo3N0nwBf65LlAA6QuU?=
 =?us-ascii?Q?W5ZPYXm5+iK3cPalm1x9sc+RQqrBOMOInoxuBy6yP4FhfS5QOEUtSQ4FBCg4?=
 =?us-ascii?Q?oFhnGkBW9sSHhoZTZ905RfwwiIXm8EfI7bVwO+0+xWIvd9EjItJ44vxIi85r?=
 =?us-ascii?Q?eyHGzy6lAMhwtZL92KBXCbTBBmA+oMKG9zao7jE2kOBTjAvQiVpTNTyOf1b5?=
 =?us-ascii?Q?phQBEvpgrg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6235696f-1b90-4d79-8c1e-08dee211cfc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 01:38:46.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axS5R/t1VZR6zjmCrZPU8Efttwt1BvlkMaYeWC9Qa7bs4ahiocYT89XQajNL/bINErOzgUQAk4m1Ol/jRysYhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Tuesday, July 14, 2026 8:51 PM
> To: bhelgaas@google.com; Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>;
> linux-pci@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; regressions@lists.linux.dev
> Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating =
PHY
> power and reference clock control
>=20
> [You don't often get email from francesco@dolcini.it. Learn why this is i=
mportant
> at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hello,
>=20
> On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
> > regulators") introduced a boot hang on i.MX6Q/DL variants by changing
> > the initialization sequence.
> >
> > The issue stems from coupling PHY power (TEST_PD) and reference clock
> > (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> > managed together, the timing between PHY power-up and reference clock
> > enablement cannot be properly controlled, leading to initialization
> > failures.
> >
> > Fix this by separating the two concerns:
> >
> > - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
> >   logically belongs with reset operations. This ensures PHY power state
> >   is managed as part of the core reset sequence.
> >
> > - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
> >   shared PHY power management, avoiding code duplication.
> >
> > - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
> >   (REF_CLK_EN) control, simplifying its purpose.
> >
> > - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
> >   proper sequencing is now handled by the core_reset functions.
> >
> > This refactoring ensures PHY power is controlled during reset
> > operations, fixing the boot hang while improving code maintainability.
> >
> > Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
> > regulators")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> What's the plan with this? 610fa91d9863 ("PCI: imx6: Assert PERST# before
> enabling regulators") introduces a severe regression with boards not boot=
ing at
> all.
>=20
> As of now we are not able to test anything, and our CI is completely blin=
d on any
> other issue that linux 7.2 might have introduced.
>=20
> Is the plan to merge this, or to revert the commit? Any timeline?[]=20
Hi Francesco:
Sorry for this severe regression.

I prefer to merge this fix as soon as possible. Would you be able to test t=
his
patch on your affected boards? Your testing would help expedite the merge
process and ensure the fix resolves the boot issue you're experiencing.

Thank you for your assistance.

Best Regards
Richard Zhu
>=20
> Francesco
>=20

