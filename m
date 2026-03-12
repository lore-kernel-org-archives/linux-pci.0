Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9E1C5D44;
	Thu, 12 Mar 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307109; cv=fail; b=osg4ruzmu2DPU/S8XiKnbQzcfdPEhcXi0ZYQvPv2LMdHu6L7ObbNaWycuPfCQf2jLhdg7ql1vXbMqkf/6JO3x8BStypOwNKg+g0throlXfeW/fcGD510+057TSr2FwWhgct/9/ax0Np6X/r9IPWSJrX2GwPnAtkIAzFneOWdkvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307109; c=relaxed/simple;
	bh=igS98f4G9B7LSa/y/RpyIaHEhor3ZujsO3x1+rQ3TUQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2g1PLnHfcUkl2Bmu3JH5QIC6rOQBWBU9VMNvHQALXR643dc4nVLgM2pOXKOsbBdW6DRYTXszI8mQDanoDD2l2c+YzPs9ffvMn+nyLcO9iaZm4/qP4yIrflZpwuYRdNWGUMvlOaLWU58W+hacfR/Q+Pv9n7MCAPrt8apM+aVbV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iajWcZLw; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iajWcZLw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H25qrLOQwbUthzspiWAjrBl96+gN2jzp/jH2EEhtUGmet4K1S5tVZ7ceJwasVP77tBmpTToyK5XbUopdWwiCHc6lvdq7ux0rlxqP/QSSxhmhVI7icgdK7xMp2ywGSFLbWiGabNjQ/yrNVadnk94By2rw5jXxGqpAIwTBi495gSoU5EAf5mKZYLADKRcuPouxb/oVHLjo3hz97ij11//gOSiABnT6cdYSLTz/dM6iLfau1xPMVMQzrp8x6KITwn6i2GwinD+TUpKDn6iPR7MjTXjQ3JhV+r3zlmTuSCaxxapJpyyAuzg2y3Yw1/97n3z6s2PquSombbTXL90gfKH/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8ybzARtDLqEBHzfA1A0T2hs3btCq9Ycx69XFmASr4=;
 b=k6VxWvYkQkZjgXr/xRrNcufLQ7BZlQPUzsNmNa9IqGJhZeA5mt5jASm+2G1hUgCEKaZePCebRp4uksxh2pq2Qhf8Zd3VvWFkw+6URKpBZIAD1Zpu/LskmdUDwgRbg4FoznFiXxk8MjjX5l+1snwmC4eTuqGdESsrAWPDv3DVy+Brz38kk2oQXOhIUj35e5/ETLKVmB2KsuLntc0wWEs4ZTefzu8x88z3ZIk/rkKj7YrUOB2H1KT1MuytCU0AVt2xEmJ4QrfMJmVgmT7WVtsi6AmQorgzir+VZmc/Mx1DCXaT7yTkc8NqDawxBGEHDw5Cf8fDX/bN71reoo3TaPckOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8ybzARtDLqEBHzfA1A0T2hs3btCq9Ycx69XFmASr4=;
 b=iajWcZLwBZbkfGZw/pX4pIh2w3oE13IyEYp0SyflULlGr+wj3WBlpBix+3voL0M6rlhksEK69E8yQxkVc+2q4TC2G93o3lV/QRETrlHAup9ngB68E6KzlwlOdoP13gTu7SLi5V1N1h9/l/EKs+Ri4qjCJVO5MO2c89tv8pWMh2xL5udE013FNyMCy4Fd1mHjrugV2KxdmcfhlRn0kLN5d+cCWePDaYjiVB88rjoJ6QkP6Xnvj3TKgS9+76xNJswWgCWSCTCwheyqfKJEOXWB/CCZLoWfnp4JxukVp0YYbP1csPOPp2LAkm5mQjm0foBnY7nxERMNlxYsclXRN6VMOw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS1PR04MB9582.eurprd04.prod.outlook.com
 (2603:10a6:20b:471::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 09:18:22 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:18:23 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Hongxing Zhu
	<hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "bartosz.golaszewski@linaro.org"
	<bartosz.golaszewski@linaro.org>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
Thread-Index: AQHcsW7d48vBoCVWE0O6svvFjRVGRrWqnDDA
Date: Thu, 12 Mar 2026 09:18:23 +0000
Message-ID:
 <VI0PR04MB12114361EE728C74CEE500FED9244A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AS1PR04MB9582:EE_
x-ms-office365-filtering-correlation-id: 820a181c-be63-4c67-8773-08de80184fb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 AWWLgicox4/z3zHB3uNPEOYZHf/GUB77St3bkRCt4aOUX6P1ePv+c9QHEw8MJRkcswOYf8cojqyiTjud5LXYToY67K4PKfZy0PT8Meu3zqjFrv0RDe1lMasP/doLGw/D1M90YKqBUa0cHjFKSdvF3c63/zokdAIhzDJHFAZUwgfC6r+6LnzJHrwESGtchSKnIzfOLk41giRU0bCTFh1jhMx+aalycy5JVi6kRuh1DC35YpgfYTQErJrE7Qp42dSQFfD2rQg4cqL1OxMPnSSNUPlwqguyQ41gZgtd1TIFOR/Up43xY4OsSU1esqxt6c1HTQPuhOaTQs1xjOSr/8T6MBsZpIS4u+c3ZFKpjDXruOKA/l6l0rVbI2/EqYXQj1pipqD66beBpBWwysGWt2KVn+a8G6iGMXcKvVLkX1A1/99VtO6nO8htVr5fhGANqs5JsLEiRxddLjuI1oxCLoWmqHFcD8ilBbqvTe0KRpN1b8lZik6SlkvyZ7yRNT86vxng61OvPY3uSpX/jSo20ie1MBZYkH0xJyAYfHEeUDQWpRx7jgofTc874sndlGjMJ/xi/0bVr4TC/Anp3YztYlzLDYF0qUTMDtOEPjO8KaODkr4ZTKyER0jQVQgVta3wNFA3McunLU5RWWHaeUMNlR0BQvIV6gLoj7VKQgM8nvZlV3yFKNJb8Ocymq3Dv+mKesEZyTHUjG+p5HKf54wh05Ua8iwNy4Hj+TDTn4nWJkzgR06ogNyb7R9aZHhvN0ILNvo79c5Gv8lyFgncnViFHv8lhBhvXJVJ894EnWnaKLlJoUEEPHxSlimy84otWsNuC5i4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Ky/8JV2UpEjW3AVALECMEdD+gFlaiNu5JxPOjmCLj2a/Dmhlrx6R9iIA73?=
 =?iso-8859-2?Q?svT//xcrGUH8EMzPgNjg+FD7cJzD2z76dBvpJx65EF1QaOOUKvFzT5aK3F?=
 =?iso-8859-2?Q?ccESVs+ubhxYOr/gzTgr569pjmLIGVZ1ykPRATDDOVgKo60uqR5vwybIT7?=
 =?iso-8859-2?Q?jZAyr+mA87R2cVEN5w0murbCy1Y0wVSRQqwZZ5tEiusUK7I/jWYi3r0ch7?=
 =?iso-8859-2?Q?eBeL6fgFDnjYyBbG9KdejW9c27wcpTWPo9psW00noK2AKriqo60rQRS0F8?=
 =?iso-8859-2?Q?OcZuFCNmiKlDTC3s+A6TZgj/wCEjY9toRMkCyZEJQLf2RICQ6kSmhCEKAv?=
 =?iso-8859-2?Q?EoFoJcraJVXZEhh4UAgvWEby4Uidfo0UTl7xQc6Cga0yES24dD1Jk91tZd?=
 =?iso-8859-2?Q?Ab0XJ+tK59Y2MQkmw1/zkLh1Jlm3Dp0MgePtKT/KfTJ50ZYvm/2XPu8Y+e?=
 =?iso-8859-2?Q?Ph5EDrkFTy9HMqicsAP9rDwaLROi54ribOimHEZRcEbsrb3+hrphgAqB5e?=
 =?iso-8859-2?Q?GnLXrBBxKo4fA7ve5EauyALexEEaOf2zBr6IPDhZY1JWH7c6ny4TE+QczR?=
 =?iso-8859-2?Q?oeo6qNJTMv/K3ToIqiafnV8cwCuDMKNxDKDJzYOudT0icszEgxFwWtd1UO?=
 =?iso-8859-2?Q?YVZdPSRjgf90SPgXFkWKuCSp9FlghrCdrkMAyfp18696QrER65ZvaT7qOe?=
 =?iso-8859-2?Q?RYSXNEqXhNVnjWhSXYjLx//3x46+bTuPSbzFXYpd9jdLhZDIos3AMCmgnj?=
 =?iso-8859-2?Q?IxnORLBygf4inosWdi3mVOn1q3Exn3zv88Kofoq/uZ/X9j/My4EkG72qKz?=
 =?iso-8859-2?Q?olYX8BZ9TKcLl7J5pdDpSvmjHrLsTTRX2k+AUtzbOSwTNkp9Twx9Jw/J1J?=
 =?iso-8859-2?Q?AvObrgCRi1GLfJ/DM6x5Ovp4kh0HVtq4FBdgNkXTqooGgZWW0DXKCQUj/9?=
 =?iso-8859-2?Q?jFvtnzKuT5eqYFMSuscgiNj64AUkUhZU7mWWI2eFLp4+TCfmDM7iBuZGrH?=
 =?iso-8859-2?Q?PYz3idyXUjt5exW8WmT+FW7VKaEjp6MhhY4FzVSdfDijeL/EMOz3E9/N9S?=
 =?iso-8859-2?Q?+onqyyO4wfNzp7W3OMHov5tFqYdqgq4Fz5DTEvnfTZQqwOqOPs41co2H6/?=
 =?iso-8859-2?Q?wmVY/vuhxO2UPddnknCk48OL76Te2xXo1L9kujYzVkaJ5TEYeF/1CQqe3p?=
 =?iso-8859-2?Q?6mAc4E4VPs9eYgdpXgJE5+W9CE3aLKIcV8Y3rtJ8JfBM+T8UR2QkGHmxet?=
 =?iso-8859-2?Q?8Dv0t2hooXqRkO3m7H3a3eed+d5nOga7s+7Los4FDFsmWCifBkFmedN0PA?=
 =?iso-8859-2?Q?x5IKCOhq1TPT10GSbND/NmYeQjrDiV7YL/JCOiUhbmHdES/g3u63eChPLq?=
 =?iso-8859-2?Q?5uYcz949c8a20CnR526Fdhi9kZzDLYQ75i90y3Jd8hAjcdtrDnADy15uu3?=
 =?iso-8859-2?Q?ilHftBm7WWKnbGokuaM+0RBvYNogZCDlRjZ/stgLxOpgptjchC3wKlaiwb?=
 =?iso-8859-2?Q?F1eyDScOhhrwMLb4BOQy/1UD7XUIz+J1TmECAYq6a7wAZERPJwhBiJp0Vj?=
 =?iso-8859-2?Q?BLjvkd8BaIbjhhoCYCu28YpU3XaoLzCznzM8HWENsSoeW5/ptbRlT/Glqa?=
 =?iso-8859-2?Q?viFGtqrtOxrz8vXw0KT48R/wklGMrHeKwVYo/xGLVmE4AXnAXvVsrPk8mr?=
 =?iso-8859-2?Q?AecsaN/VNv/RNO0s0+7nToRKWKWj8Rk5wWZlqcndL4zNxL3qJLmG6X+Iaf?=
 =?iso-8859-2?Q?XwTSDugUNwK+TjXoe53PJqEN/6vmYZc2clvPHtkAx8q0iE?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820a181c-be63-4c67-8773-08de80184fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 09:18:23.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWahPEmjt2Khrhv9h033a2rEfTMuRY4F48SZoFSPr6SysreqgbpnGHCtSFjne8/17OOD6DDnd637evq4DM+4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9582

> Subject: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to undeprec=
ated
> reset-gpios
>=20
> GPIOs with "gpio" suffix were long time ago deprecated, thus "reset-gpios=
" should
> be used.  Linux kernel supports both, referenced schema snps,dw-pcie-
> common.yaml lists both as well and this schema uses
> unevaluatedProperties:false, thus change has no impact except code readab=
ility
> and removing deprecated patterns.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 12a01f7a5744..b9ba938c6239 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,11 +58,6 @@ properties:
>        - const: msi
>        - const: dma
>=20
> -  reset-gpio:
> -    description: Should specify the GPIO for controlling the PCI bus dev=
ice
> -      reset signal. It's not polarity aware and defaults to active-low r=
eset
> -      sequence (L=3Dreset state, H=3Doperation state) (optional required=
).
> -

Add Dmitry and Bartosz.

Hi Krzysztof,
Seems this property is still handled in gpiolib-of.c, see commit b8b80348c5=
7b
("gpiolib: of: add polarity quirk for Freescale PCIe controller").
Maybe need to change the quirk gpio_propname here too.


>    reset-gpio-active-high:
>      description: If present then the reset sequence using the GPIO
>        specified in the "reset-gpio" property is reversed (H=3Dreset stat=
e,

 Also change the "reset-gpio" to "reset-gpios" in this description.

Best Regards
Sherry
> --
> 2.51.0
>=20

