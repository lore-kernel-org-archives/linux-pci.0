Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD1245005;
	Mon, 27 Apr 2026 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259837; cv=fail; b=esB38XYPZ4P3lczOUg+HEL2s8NEvVAy/UwM1Py7LWnUcRr70Mk6gz9P3jiYjJ1NBqMVyn0i3PKnAo8vvuJIuEcHTJ3fKHq/rNcPSjRvvtkzJNO3TVtN5aeutURU8EN3txq56tDO52WQbRlaZ2HlBel+hV5UUUmqN4vHs5UyWRyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259837; c=relaxed/simple;
	bh=F0tbGOxG4SQ9zDJbi2bG+/A7T5AjyOsAZEiy1aApFS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/u8LLHAsC+eFUU88spxmnZtKDMhs3Q0/kvCtZ9b2p01qZ5/73KZ9U/o2TkTTJuz2cZ94rqQPi7PQ56oMftsP8Z52KBB1vA/ML7apFVfOy/NwsUA2rwuIsSdYml7btcBHVwuRoTRl1ZJ8AOVYBgFvABqRmtF/B7sayQIaEwTMnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4gH9sx2; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4gH9sx2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJeaPq6QN6ItWfpLEuTGGG18HxRc3pZy3fBRpQNt0YdW01S7w0QnhhUSjUfOwAdfQoJgn3MgDgQwthj4Q3ep9sXJvEIlrYfF8L2/uNIusZ4LmELJxnHYz6Kyg0rhoQG3c4uUyzV76yExor2jTnowlPSmkw9HGzosLPq7el+m3oNxgB2tXPra7DeLmGtwXZdQAl0ChPqOSzNM5yEmWrbDNIlZSlQ3Qk/9KnmSdql2uh5IUhl/8kvdThhCV5OmEwnI1Uk/TRyf60U3JGiBPklMqAMDnH08zq6YLsjPF9beyD5B+GDuVKBacv2htWSLYxVbeh77npADL/xlmTSHekTeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0o4us4qdziOlU/iQRqPNjFval1XMB7VJaS43Ap4XOs=;
 b=d1aJL3/ETpGQQy1IZIAHS/69ZMRqYeN2X/7eTr89sNqxTq4yt3sTJF+ZkrhPYIDhXFk5AN0mANR9aD5PUpFSDbuwmflrMch8r7Uoa6fVhuGiFqErpOQXt522XEhSg84tQ5aPvk/VQGya9C75Jxuq3fuF1i3UjMy/BkhmX1xG7QXKW6Fc+VviCWLNSuWY5PDQtsYqPVF4bpSzlbvhVOwEvDDjD9mYftcjE55C0UDh95Qjr4BOVW1eCcD9CXQynLSHl5Pexr3imkYflc0ChgUtt/n63nP2i4IU6MYR6Ki3j8QIIIR7ie1AAmVPK8GVmRskzBKy+RSlTVnf9kO5H6GzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0o4us4qdziOlU/iQRqPNjFval1XMB7VJaS43Ap4XOs=;
 b=R4gH9sx23XVuv47idxcGU6odpgBMQgDkvbwoCUnrKtq1jGNwIuXaMAwGnIr64snaeuRKzWmK/KdyY7H3XEiHxaV305zR4tkdrTFN9z4bp6troPqDrWJOm211CwjgG6xk/WrfsXtdk4eb+++fSGvXwzmfpqkjyLUnlyoZWboEHyjkzkvELnSk6GbDhIiTMEnU2ESakkiTfnP2y0Z1Qq3QIWEVvsAnthGaAGm23LsqKsjarVyd6LkxYdWd4iQqzVqK/wubOcNiSYrQHSTZJb1n7/YjeVw2zwjV8kY7al8QbDLZ/rqUFalVxt3yCeER80CH45ea98fQdEYHH6i/OV2G/g==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 03:17:12 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.021; Mon, 27 Apr 2026
 03:17:12 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Index: AQHc05XoRj3SxGaMXEyZa09FUjk/wbXucikAgAPE2rA=
Date: Mon, 27 Apr 2026 03:17:12 +0000
Message-ID:
 <AM0PR04MB522051DF5CA446158839C2BD8C362@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
 <20260424025735.1490772-2-hongxing.zhu@nxp.com>
 <20260424-sinless-unfiled-d1087a894da5@spud>
In-Reply-To: <20260424-sinless-unfiled-d1087a894da5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|PA1PR04MB10604:EE_
x-ms-office365-filtering-correlation-id: 2cd227b5-b80b-43af-eef7-08dea40b79b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 gCQfq/SztnGmtdYD1HQ/u2CgdoQY5g4bI+HG8KYjVdYrGq6EWMbkUAAQfmSNb+QGKy/7DGxUIQObdRqpTItJS9soP1KyG98IZ66F0B40/YLbAK3fQc+iP/1ctK30cXsZhRs5UJduiIdkp1/15R9ca+a+IkfmmfMQDAKHGcv6kMqtpLsxveVglMpdJaLh7rswwadTa1L1AHWIPx3gaMTx/dtG02BzvWXcvSATxLApxKT3Ur7GCH+kRc9ju8EqaoKtkgdnl5J6/m1mWd0CC5biwPunLTMP4zerX3uKUXe+EFueBnsietKMpCeGhrzbq3U4p8Zdwl0NAe0VXhyWSYyvU+kbzG69Vy0Uwhn9G+r/MM0xre1FeScRQuWNfxEtPys91yxCPmF+8BbadeE4zEXJthGZxGyN3A4KqjzLzf6OZp18pGQYwUdYf2fOaZ6/d8FbkY25RYKhuFgn1OEo5j0xpHvvjq/THTqRVYr5YEEomGx01olZ1JGL72HkzLNgCW+0bGV/ViSqJehskckpgD5pU5+Tvt8eQa4PcJ7mSwU87uMluhJR1GftxaRrpqRxZ3fmonJow404WI4yMN64eenLUh76HJsgiOQ8ysiyBYzqMu1tOxKyfJCTc4gzu/srg/ZHCk41UyIJsFxOAN8rvTXw0xGWnetmI504WVSJ3VGrePBdXG0w4M+GvXaRpozkA2qH+Ol2WRlIZtkdiZMN3CJi8XRCd66qCLDruJBv/bpL3vifFAX7XHli8demkD8Iqm9DLJG/S12wZyuyIQat1hty3AmnjjWw9FkR/sIeWx6XOO4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3vS6wm6NLi3AZJRLcSgGvFiXa4WqNvlnA6kfsjjANNMFjoYBumFRQDju0V3v?=
 =?us-ascii?Q?v/XYVMpWkiehNE8nefa5yqnOcYoSqdlj4VJNS4cEfcFs/ieM8cmrdd9s8q5i?=
 =?us-ascii?Q?jy3kifcviqUEm3UnKzIpRC5TvFVM5ilLUiS6fO/pwcODHsea19GDFoEeG3nC?=
 =?us-ascii?Q?izYH5ixYQYzdZahryZNcg40nKUe1TNzaEX8QbGHcIKXa4+SxJVeSnGn+4C0F?=
 =?us-ascii?Q?HwEAA8Plur7zF8+YYEV7BqiqRMUiBCBB/FelUKeEMkGNxEpVdjsYSJr4n2k5?=
 =?us-ascii?Q?S/+qRcDF0Q8azC7zBQk/tEV1nc7+B+L2u+Hswe/4J20Gu5kr0LlKqgugcksa?=
 =?us-ascii?Q?mR8Fp6LGi2ItatCajYNe9jGcvzUSgMiWFvlAJgxOix1Buyx5Sv1H/kj8jHeW?=
 =?us-ascii?Q?J0Df2kvzhnpYt2l6x5LSFMPO7MZeGyP2U8e33cSGwJLeyR8MgtT8KOaBbX/P?=
 =?us-ascii?Q?LYNeMKzeA6VPjFyeE6eHY1R2ZFtv4/nL05wiuduvmurRTQXXtp8oY881n/+O?=
 =?us-ascii?Q?Z0lBuCKV4+pl3cPrTfW82VENbpDHbsgAwcL6XT5XU9oAu7uZOHHsF3AfatvM?=
 =?us-ascii?Q?zlOYakw7YP6ByzMiAXYvz6qZDmmq0OW1NrrBujgwYE2DVBoEFQxwS9Ag5Ed+?=
 =?us-ascii?Q?Tt8hn+ey081fyrGNDmT+HmBhOht2X8l1cOXJwjLppx3l5/7qn4+1IS1tu11M?=
 =?us-ascii?Q?M86QKeIthJstRIxYQuAQ975KNB8MGlYVT6cpevi8myx7gyw9qNZnQYVXoL1o?=
 =?us-ascii?Q?1/EZ9HDiwOhuOsCVn03C61mWll5GntMr7xSRdvxKhSFT1og5ZYuzaVzl70k5?=
 =?us-ascii?Q?0w9ybBbR33BPD5mzreZy01n9QwfxfNVWMmb8+94o7dxh6oXrCHZ4DxeykS0T?=
 =?us-ascii?Q?HMk0GOtg3kuNJuBYDbfAxkt9gPgGAMHy+yoJBqak7anizAStpxEGdGVmWn+F?=
 =?us-ascii?Q?qiNiFhDwxQ3DWnhclNX+2N1VetbuLBIavn+e5uZVnMjzS5poHilL3jWtKZWy?=
 =?us-ascii?Q?l77eoVtNGx4FbSsQuZBLqTM1DVjYGWDXbVfsWLNtHV+kqW731W66tFD5Qrvr?=
 =?us-ascii?Q?wEvfi7zN2hFVD97//RP1LErtprwOMU3zP4ki8Hl0X00NeJWrBfbNjCOaL3nB?=
 =?us-ascii?Q?n5jWA+HWf7dnYLCwOr9CJeYo7Xw6FaBBKdZ/NGldQzotnRkdF6HUkkI29vuV?=
 =?us-ascii?Q?SOFxc54F5xlPBGzkI6A/1ijhQ8ebnJCB4U5ZJg9T/YYlFg7XDSRmFAXMuC2f?=
 =?us-ascii?Q?u1kOX9lwedcPJ16aLnST21LhryYroIVQ6NcaD8VUOLyUDNhY0x5KCHAsHjFN?=
 =?us-ascii?Q?ff+BizxmUSurHb+rmNAw6JP663d+QxQ62rs4QoVWIaDMhxNSe9NVrGNgPohM?=
 =?us-ascii?Q?rdV2WEmDbuf3VCKX9w66ZYKqjmw6MJlL8hdmYIUfuumBVSaGThtr0fF+eN38?=
 =?us-ascii?Q?R+4z6YKitxY6THdYwd3kjOKQZekwwONY+8QHp9wmRURrn8rgIkkZhGXNSxMT?=
 =?us-ascii?Q?PWbMrtE6MgDyHcWfcRMpBY2cyla6oJfPAcFpOlhvBSdYRlSixtwHbTpCbiST?=
 =?us-ascii?Q?/3eZqFaCjpGfySWG1Y23vlO0kwjTInrHUyDkEspLCmtzd6g8vGEXGJqpAAl2?=
 =?us-ascii?Q?8MMM3g0rqNO5LkzDxXsGNAlT8kOGxeW/GEL8vn8Y3fb9g2ntvrJqvDIAEujG?=
 =?us-ascii?Q?HpnVXcK2grfDJ8Z3NoztiKn1WwK+Rj4HUuPUmfrv82KwLEyF?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd227b5-b80b-43af-eef7-08dea40b79b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 03:17:12.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCu3WIopDucPUH6oZbFrV7C+pUqA588OKPlzoYK4VwGnq58ly3ai0eGxtIw6jbcoBgaXpna9XPqqqtlqHrzmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, April 25, 2026 1:06 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> bhelgaas@google.com; Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer a=
nd pme
> interrupts
>=20
> On Fri, Apr 24, 2026 at 10:57:33AM +0800, Richard Zhu wrote:
> > Add optional 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q
> > PCIe binding to support PCIe event-based interrupts for general
> > controller events, Advanced Error Reporting, and Power Management
> > Events respectively.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
>=20
> This binding supports lots of devices. Do they all have these additional =
interrupts?
Currently, only i.MX95 PCIe has these dedicated SPI interrupts. The earlier
SoCs in this binding (i.MX6Q/6SX/7D/8MQ/8MM/8MP, etc.) do not expose these =
as
separate interrupt lines.

I can constrain these three interrupt entries to be valid only for the i.MX=
95
variant using conditional schemas. Would that be acceptable?

Best Regards
Richard Zhu
>=20
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 9d1349855b422..badc7fcbd556c 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -58,12 +58,18 @@ properties:
> >      items:
> >        - description: builtin MSI controller.
> >        - description: builtin DMA controller.
> > +      - description: PCIe event interrupt.
> > +      - description: builtin AER SPI standalone interrupter line.
> > +      - description: builtin PME SPI standalone interrupter line.
> >
> >    interrupt-names:
> >      minItems: 1
> >      items:
> >        - const: msi
> >        - const: dma
> > +      - const: intr
> > +      - const: aer
> > +      - const: pme
> >
> >    reset-gpio:
> >      description: Should specify the GPIO for controlling the PCI bus
> > device
> > --
> > 2.37.1
> >
