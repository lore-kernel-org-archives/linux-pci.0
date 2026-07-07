Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751937FF5C;
	Tue,  7 Jul 2026 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393928; cv=fail; b=B8GgpW9fcJsVajUnsb77lAD4+E3nr1bhUb+TtWMEvqqPFhUXyFgbj70iTznuMoCh937woMU/DyWLuImcQsXB+PSVzzqdPLm+WFtqPK/FcajXVUsPGTqoxzYb+E+GVfhtwraY6N7AFltYWhfAeVmr0G0MTzbflUJ5Kk6af1X2zAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393928; c=relaxed/simple;
	bh=GuA9FZ1Dh0u9CCdAr9X28YbpRfaiKqOlvs1Cq6rhIkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5buenXcR77v8L3iraAzyHvUyAm4NX81x5cASF26Dh+C6UMGujJVIARZUqTN/Qvy9zaLrAgIodyRvyX2EQM0suL+zMnR6RgWmitk71EzF9Jbsd645nfnGhnPpxhSEtY50fAzfuYmoGk4tf/fuTp3IlG23H37TXziglZJi1ltYCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WGgkSC7Z; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WGgkSC7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJCpSH0e/7qfYECCLzbr85eK8BQA8/ZSwAgHHJhByNPGMIUWYVX8qx1KlrvbPDaJ6+x7jIN41b4p2wRm6GLDEqeYBcsLYgwQ97li0opEttMROYz+6UyA+BeJN/M+SPKuTUoOda7I3IVcoWt1RQ5fjsrpB5p+ll0sOW/yGufDS0EK+jhBDkoP+/Luqtg4GIT7yz4Cmpt2NaBrRI6+Inh6tt4e3D/vutxZjxJ4EFkVVq2bQr5wSQUjD/bCLvtMebWAtgj0MSH7H9PSFs3RsQrQzh5DGtfs70Nl6X6RuweCoUmcu99+LpcW5HNISfASRW6UCYgIbhcwWU2AO6VybPQ1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZntgreSIAj0+unFqFV1qUmRl2iZdd7VF/0DnNqcUNw=;
 b=vXxj31WxZTKF2MHY/1nruHaKHS7nktMBXBNuSmy15rrPkkoh6bIn4bwl/Wlt5z+SMU48gSISgBIDgBaXabAMVrFETsCWn4lee/xE3q2iaOwWPwWYZIU+WW90n7r2dxqqnTbHPG/GQVnejhQs6+BzD1wIBl5A70jW2oxfxh27O5KZeDjknETbNVTv/P5Qz5GyeeeFzmECdBlzrA2lAaemtQb46gFpCYDe1yLGg5xtJ9dwlM4lQMwWJlR5hZEWug3w2ddCE/ppwvYOGmZMUErthNqNuchRqJr/2wQ5FQBv4zJ211+Qz037UXngnZGjKsE+kCZFHa4gqBkPmi5bCH2byA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZntgreSIAj0+unFqFV1qUmRl2iZdd7VF/0DnNqcUNw=;
 b=WGgkSC7ZzufAVVYGG1TXi23BTb0TYKLaZcJy7CKoFi4jAXYDl1tF3vv/MG/THlgULlSHhEDiVsPhwt4uQBZkmzCb0PVK+hb/9tmznXKKtuzNRW1uh8CiTRUqFsETiMomj7SYsFJxCNNq1efq88KVocmgncvVbDpH1lmzCCWBMLLfuoHU0xcY5d8K+RRhBYvb9x7rkjQboJ9Y8qw50lg1Ovi4c4gShlDgUYpzjV529ax5mhMArvNhbYffjBZe7jXZ/i1nutLrFuj4KmarBZjEbHQcFGy8G0DlPLKW250O88IyhJRRzkiN3laJyarMveZIlIS4FBSQNSYf+kMndj6pDw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV1PR04MB9181.eurprd04.prod.outlook.com
 (2603:10a6:150:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 03:12:03 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 03:12:03 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3
 stability
Thread-Topic: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe
 Gen3 stability
Thread-Index: AQHdDRUbl5Igr3djM06998s3EL/7GbZgpuwAgAC7oYA=
Date: Tue, 7 Jul 2026 03:12:03 +0000
Message-ID:
 <GV2PR04MB120194A0E4462405B99DAFFB38CF02@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
 <akvRFHY_tW4KiguA@SMW015318>
In-Reply-To: <akvRFHY_tW4KiguA@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV1PR04MB9181:EE_
x-ms-office365-filtering-correlation-id: e3e5eb52-6aaa-496b-b5f1-08dedbd58488
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|18002099003|22082099003|3023799007|4143699003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info:
 c5mNqkwMRMmLZB5jK/9RnQ65X3Bzbv72tA9ptDmkQB7mBB+QCWUxs3D5pr4JLOjjB5w45iwHvAuL90IJ8hXLLNdp0V94C2fVAC1zZtAVmjs52vgq8itZseYnEExrlqCxwwDkE7qZuhLxReulFmFmzxnmL2kr9c53MV8HvpDRfiKWrIdQ1zopSqfIUAEgnbEluC+VVXT48NJF4hoVoafJDD0MToy13sJ66wBUbAlhrPDSIKiYLG8VNHTmNVgoWt66iz9OJaLsGRt11qc+LsQe0EW8YIZL0IU538XfSt5PKOgUWEyM/LV7VTBA1gtvbWf5nqS77IHz5DSECGVfIE9z2oYoruY8d2zeyXJ5dledppWGJW5NwJUJPyoH6GLxMcOcigkJFTPsAwZKpsIkhTCQ5plcfw3thHiCS3WBlanE9BCi9/0JJEZksWprPjx66ADDUZBBJ/GD2tiunAynNh54w8rgMJaZyzMP+ljEUy16zqmBEB/7JirZoxT5L2hBw0s4oIbRIX3tLugFNE7J9ygp1AXZFWs7H/2sgvEeX51i2Q5LKzUArCieST6HnFxIxhDdalFnJSz7UnWlvWT2ltvhHsU8FZ5/H3MzDEbkItRG8mTPuDvyhj/7mR2wEUpu5ZVJJb0Ls6EnMm5Auw0G5pc/kqymifn4S98aJFiOmpJqHjid7YfgpDff87mKbfyR5nnZnbKHJVFJfv2fgggXjWL+f05WAZu1lLxK0puFmIH68UA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(4143699003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MIQdJi4AYodRpz7JhfWnTTXLo7t7FlCdRZ5SFWRzQiL63OcGRMbkHNpZv0wK?=
 =?us-ascii?Q?bBdIs+xEpIWKTxgKi5VtTPvwwUYy55MGyReHjUOe+lncio453Nc2hYWGEIOp?=
 =?us-ascii?Q?9MHGICxfdNhR3B2VK/zVzlCfrdDtbpdf++PwDqliEvU7cr+qjnioLD5dRvQO?=
 =?us-ascii?Q?cyCXtXXGIGdk6ERrf+HnhuvSgPNJl9/olu/u3qns70uno3gkwT3am4WYteHg?=
 =?us-ascii?Q?ZlHT9EqcVIZEkDcYgP2oAlmqnnZXj4+WZwE94U4OZGC0+aFjeL93R58l0PFv?=
 =?us-ascii?Q?uIB6y6kXgNez2sqhtnnTssCvPc8Kn+jExpGTd3KKxviMjlsncBrCnH/klA/x?=
 =?us-ascii?Q?D01OTFsYymYwqE+Jey2oyB22vYzKbX82FtcyACDN/JbH+KehOn+Adm45ggQI?=
 =?us-ascii?Q?JVDiZ/9DC3C6AIUHEYLoIXZnkUpyoT/HY0b5wR8Oh2OopnFCf2l+8rl2SXTc?=
 =?us-ascii?Q?zWfWh2AjIA63y4cyB+rL8gd9a6kV3AFYe/Jy92/RKM4J2Ny3k9+6QaV//7l1?=
 =?us-ascii?Q?qxE9mjCjnjFS6YQlu0icZy5sG0+bCIFhOyg0/k9YWAJ8d/C+h34wm88Fsdul?=
 =?us-ascii?Q?HAzqy6K4PPduDZnT5oynJkkxYUrCs18Y2XeLKa8dNqrSduYMn/LsZr35Du20?=
 =?us-ascii?Q?L2EXQLdUicLLfZ1ppmZFIALSpV7FXJpevs0ANxsE7FXyU2I8JWEY2NzYoBLr?=
 =?us-ascii?Q?+5fz+DUL9T96vMY0j1WOY5GRzL1KAmVBJM6otM54RXgh/48Nn2lHfbPvHncc?=
 =?us-ascii?Q?oRZpVT5sw7xgJbTsOzcw+NKVxvrzrZw0xFAtYWDDP+taeuPwa+i62wIh8yNR?=
 =?us-ascii?Q?HL07iYb1GNi3IQl+hP42Tze7kpZCnj0PWeRSjInOxUUEVY35qQq8EYBopd+4?=
 =?us-ascii?Q?crUDFXklgWSeR8OC85xGS6TtvA1M7hokO1zj5OKxG2Jw45ZZnaudDatU0sov?=
 =?us-ascii?Q?Mh4HO/yP3wW5S7JfGrJYVaJ4MdbwD59KkFrjbCSK8nCKtDHESmAIxsHeo5FO?=
 =?us-ascii?Q?35ZO2QEWGEuzbci7Q70a++oKEyBiT3MKHWHNrg66+l6pjTCyWamN2pWAmqFq?=
 =?us-ascii?Q?9BaR/yuOn2f53B4hldhXRDRUs6tIXojEFI1vRmoPBqZ49GhJbui7OqsGzNoK?=
 =?us-ascii?Q?SEoVyqkUDWRC1bBkFOaFliK0dP8bVsrpX0amMrvNvqtS2vg8+amv4VpUhu0t?=
 =?us-ascii?Q?p2Gtiav0mvtFYAG95CdDWo925sibKkVOSyEwsMx+EbhN977gTPtxipf/OVUC?=
 =?us-ascii?Q?CSVeaVhhJXYvf7C+c6LkkZ2KNy9rrLXNZ3/Cxjyo+L2DtcSAgN+apzs94HsR?=
 =?us-ascii?Q?EXN1TgSdO//87dgEHpEtp/9jBd/IEnWEJGiezhf8UbAIHLMc93wVRdjglzpl?=
 =?us-ascii?Q?zGDZY6ENe33nIilmpV09jpyujhyEz0ZbsWPtX+gxtyM3qPT6l+2bATjirWeq?=
 =?us-ascii?Q?WGoc95amiVR4SMkDl/Rot7zA8x8+SKdLsYpgCER/ZyeEttgVGP2sISHB+sja?=
 =?us-ascii?Q?lF/Ft5UJTkTuuykTJzC4+YTxKR/0roiuS3ApKe5Jiai37dY5VJBHZHJM4Zc0?=
 =?us-ascii?Q?UXGVjJs5w7QApVVerbgMoNuWwxHcsqtiYoPSUO92JHlapV8M9Tm+11ZNkcfA?=
 =?us-ascii?Q?15u1gNhGOhAYusiSMsYWrAU5YblL7YvouDjQAh1jRXwnXB02fIie/R/rfvIE?=
 =?us-ascii?Q?kJC27+DPPX7rwveZdC0hK8SFKeQCusoW+RM47SDXNI2anHmBC5ueG7PzuoZb?=
 =?us-ascii?Q?+vIqTXCN8A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e5eb52-6aaa-496b-b5f1-08dedbd58488
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 03:12:03.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gn/+JzwRJhs+LTIUBdzxsKzLdmZnGhsEpCfkOnMMMDGa7QkxvudhQMuTCHKQMiiG8kMOGgSg0ZpzApMGoj3wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181

> -----Original Message-----
> From: Frank Li (OSS) <frank.li@oss.nxp.com>
> Sent: Tuesday, July 7, 2026 12:00 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe
> Gen3 stability
>=20
> On Mon, Jul 06, 2026 at 03:03:40PM +0800, hongxing.zhu@oss.nxp.com
> wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> subject:
> PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability
>=20
> >
> > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > the default MPLLB_BINDWIDTH value. This margin degradation worsens
> > across voltage and temperature (VT) variations and different test
> > matrices, potentially causing link stability issues.
> >
> > Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
> > improvement in bandwidth margins across all VT conditions and test
> > scenarios.
> >
> > Implement PHY register write helper function and configure:
> > - MPLLB_BW_OVRD_IN =3D 140 (0x8c) for improved bandwidth margin
> > - MPLLB_BW_OVRD_EN to enable the override
> >
> > This ensures robust PCIe Gen3 performance across all operating
> > conditions.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 31
> > +++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 6924a06bde305..023145b0dd2c7 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -80,6 +80,15 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > +#define IMX95_PCIE_PHY_REG_ADDR_MASK
> 	GENMASK(15, 0)
> > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > +#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN		0x400
>=20
> Not sure how spec descript it. but BW_OVRD_EN is bit of OVRD_IN register
>=20
> look like IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN is more clean to avoid
> confuse it is a bit of register BW_OVRD_IN.
>=20
> > +#define IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN		0x2005
> > +#define IMX95_PCIE_PHY_MPLLB_BW			0x8c
> > +
> >  #define IMX95_PCIE_RST_CTRL			0x3010
> >  #define IMX95_PCIE_COLD_RST			BIT(0)
> >
> > @@ -269,6 +278,20 @@ static int imx95_pcie_select_ref_clk_src(struct
> imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >
> > +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr,
> > +u16 data) {
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_SS_RW_REG_0,
> > +			   IMX95_PCIE_PHY_CR_PARA_SEL,
> > +			   IMX95_PCIE_PHY_CR_PARA_SEL);
> > +
> > +	fsleep(200);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_EN,
> IMX95_PCIE_PHY_REG_EN);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_PHY_REG_ADDR,
> > +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA,
> data); }
> > +
> >  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)  {
> >  	/*
> > @@ -284,10 +307,10 @@ static int imx95_pcie_init_phy(struct imx_pcie
> *imx_pcie)
> >  	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> >  			IMX95_PCIE_SYS_AUX_PWR_DET);
> >
> > -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > -			IMX95_PCIE_SS_RW_REG_0,
> > -			IMX95_PCIE_PHY_CR_PARA_SEL,
> > -			IMX95_PCIE_PHY_CR_PARA_SEL);
>=20
> why need remove this part?
>
It's a part of PHY RW routine.
Move it into imx95_pcie_phy_write() above.
I can discard this change if you want to keep it separate.

Best Regards
Richard Zhu
=20
> Frank
>=20
> > +	imx95_pcie_phy_write(imx_pcie,
> IMX95_PCIE_PHY_MPLLB_BW_OVRD_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_BW);
> > +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> > +			     IMX95_PCIE_PHY_MPLLB_BW_OVRD_EN);
> >
> >  	return 0;
> >  }
> > --
> > 2.34.1
> >
> >
