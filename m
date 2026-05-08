Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE52857EE;
	Fri,  8 May 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210131; cv=fail; b=EN47pFTVg+BIZNmNEA/IoV/SFPA1dv25/vVGdgG8XupO90/vEwZtmys1632Cif1mldCwCO6AhMvT3Iz1bDDHAL4tpoxL5fqvpCNIw6w+FKqvy2AfVcXC+DYsAFgnyR1nqSbOhDcDNJLIfdeNL9jaEaEDUYEBnrLSkgL48vrgnTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210131; c=relaxed/simple;
	bh=L8f7hs7MMhePSZ5Wm0aAVRVwwGlrZvi7IpKh/2yIGYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUBrRbh5w9DbcoyZSfvbAt4gyfx1s8MO6LWqDOcQveeoit05DWxu9NZANVx/RJ5KFfbpYZj/1rID19pe8Y24Pesqj5Jc9YHCq0IqQEB4FBAXwOqWM1Lr9S4mDNZIHkYxrJavOl8KfQr/beozxyUPJ00s1HAnM5MyrQljdQ6JwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SEF47RKj; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SEF47RKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGPw0VPl+xaZxFNg+66K3bmgvSMvz+7ZLK1P64dVKR1Bp7L5Xil9gB9ntTZalq/aF4pCkJ+uTpiDfHiw/7UUXM0mPBCvTEyRsfZ0599Z0tW/U+4rgrE6wipfqRgK8JQPEYiwtOrspzPggJSRSdIDMl87BRV6NBCia5hCYXC8mod7Zyjx4iUHetMTUbx5b8xz060yuVF+fIoIrGZsNhDGiS1KGZT+HvnfMikDaFOBgJ++3OyZMbYcKyJlQffE9MLQ7hxjVvlcv3yxrm0rVa8RkBZNi1Jh1mD9Mpc1pLSJLizYnOOEqQphIIngIdz5LuvmbZ7HvNQp8DMTy/Hd1jZjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxJD6SvfyX9N7WZLGF2A6cPxW+7yWtWaSW2a5rlv6vA=;
 b=x+tXsop8Z1OdOJlmBNJdndI+knPG9rxbTHMZrSphms7fqoNexYungcOc2cSnu6xqISO3S6jropuo4tHePqyiNjhFc+7jbf2ZSJhu37kyCsrKly3MY5AyiU4SQYGlE/gByQ5LWmSWDup1DDV1fPScWK7kay9dimsyDQIKuejpycPngjhQZGYncKF8df9dWhzkO5PEhFV+GwW1GBvLMW34dGA5xTgnHtyZMf/at6Seguj4qa7CpMf90ytqAS3A/9TJ6vinmkLWoMp4aZ4iuzFQFWCY52pCC/VjqvIwFZsGfmJMZmZ/cekzqwsQxis+uRErN6X95taGnCG+xfZZuBniew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxJD6SvfyX9N7WZLGF2A6cPxW+7yWtWaSW2a5rlv6vA=;
 b=SEF47RKjiEReXdxr4u7ah2SAd60GqOLCAWPYuVPt8sjnG++GKEKb5FVdKdjNnDJrIzrtdoN0xsl3mZEcuCrNKKs72V1NaFtgc3dF5/+CCZVduLChEYPCQvgyIbNyUH6wZ7Fkro64vIBop3h7iWdY4EI8T3nf7qb5u8WvYfItPUZOPZ3aSV1nDyntoNX0M4sqs8iQ+UmrLVbjk96vKKZ20xhFMlxcYiCYZcrIcF7DWIwdxNz/X3JpIh1JZDQaAJ5Cav7eTu14U+dn1XtRfTpvcJ+21Psn7ccg3cyJkGbs2Qq5vS6BMBbAaFpbRBt2/3dCkVUvHBnIGfwHkQwVycIYHw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GVXPR04MB12159.eurprd04.prod.outlook.com
 (2603:10a6:150:312::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 03:15:26 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:15:26 +0000
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
Subject: RE: [PATCH V14 04/12] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Topic: [PATCH V14 04/12] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Thread-Index: AQHc0js7aIT+hy9P90+H2QH8i4xI1LYDjEzQ
Date: Fri, 8 May 2026 03:15:25 +0000
Message-ID:
 <GV2PR04MB12019C2DDD97275AFB0C5BA9E8C3D2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
 <20260422093549.407022-5-sherry.sun@nxp.com>
In-Reply-To: <20260422093549.407022-5-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GVXPR04MB12159:EE_
x-ms-office365-filtering-correlation-id: 302939dc-be3e-4d8d-04b7-08deacb00ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021|921020|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tJ50a8/NcLjwwvCADinBmjBmW/yTi4MQTe/Gg2Ew/78ikUULH0wg6z8/4Jn8J+sQ6UzAsj7uzfYwcCT8fp4+a7IiZE4njUyKHLp5DqNnJ84h/yEaWvpilCtOoVu8cqhwQj3TpjY6uQUgpzubn9k4IvPu8qBHSYl2l8dg07W4DGAx8Hw4+GHEVky4+v14uyEV5YjYpv3BI8k6ukFAZp9lZgFTV4HFg/gQazSpfzpu/k/4taV0pjUJSr7BiamN28D/nzp7IFJD8NfSTZ/LuUNYuzLSF6AzcFAzJkvNag/j0Z8kJptARIQtm/vqCtBvrXGJF4fh+IRslGIw8Ux6Wywj6OaMjUxDeGVZd5D/7aO5U4XI2elK9hwBL++VYTZpzj5pS9/9tCrHt7m1pf0ZRaAd8SRz2zsdMT5M7t4YZf84pO5CzTnqhCilmUBqSzwDbaImNVp8zQ4YKhJ7kSnFkaOatcnc9wPsx12YcJS2Yijx+tLqFEQxKIHijqvJyzcR4ZN9WYeqCgAhO3Kz389SH21qEongEsZZBZOm+YjImc9Q9LZOpPVOaMLvUvTYWLo3jtRHVbqKdtiTtyQbEq3ShIfkeyCSnWsEtJVcsXJBN1MVxGa+FGZME9JXOjZd2WB3Lj0kOqzgQrC6tW3xL2B/Y6OpvmPDGpqVrX5y/9b9LDSH0Zw3FGTrJHWiONv5mZDLXBJtSytEkBqkAiC9HyVPgdUpdkYT/CDLplwiYxC89f5UPgYGmFR1oVf03JpcNkWvoLgr4XoX4n1ftiGGbCg/Un8m/A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d1xRqqAM/940B8rnEpkUByIJ90Ld0Es6k2U7ORxGwCwt8XMxeMDKL/enf8Jz?=
 =?us-ascii?Q?lcxqX9PU8oK9Hn1C0P5rzfQPwZJTIVyRjci+39TgrhW0tZ6pIxyCxdb53qqW?=
 =?us-ascii?Q?MunoenK0/FEdXqtJJtPFkpu9tzahUXZlzFVXPaKw7AMZAcAPzdx0WYHnBamJ?=
 =?us-ascii?Q?I/0HcnQ5A3hLETo92dazfGDLwDbXb/5tR5urnFZjz6LaNGJE1ClnGKAyOSOS?=
 =?us-ascii?Q?5b+9xg0ToFz7KSuR2Md74OgMCN3+2A4z1V/arcmbMNBnSnxosVjntHiWMteR?=
 =?us-ascii?Q?e8Kz7dvFJjyzIk3pqhaF0iGuWJkGW0pgEC0NXddQCh/3MPOtYmOwhgtZxPT2?=
 =?us-ascii?Q?0ZhGr4SsbsLD5fM+tcU06WrKa/YTovYGXaJYbHlxwJzZHw3Gq9wzHHDYOLAG?=
 =?us-ascii?Q?WxbSeMZv5pqy5Bz4SwgQ5fxy2JwP5Z0VHerIlxjXjVpjXJADSUqwDWthqiWj?=
 =?us-ascii?Q?2REJGkbY5E86EvlqVJTKkRluc7uY416KrCxSCejhaOdDPj+73fmZ72V3wC7b?=
 =?us-ascii?Q?tmAg2LMG85y7Erjj0cEu5VHin+FrtBFYK1TGD108vZoNw0N/81t5bu8w5epK?=
 =?us-ascii?Q?as8Bfin3SUUjhVFSOH9SbyqECEFGQbRFE2b40hI9leI9XD6haphNkkobli+u?=
 =?us-ascii?Q?34H2A0+bo5sDdYUcrO4SOJzS88I9m/WRxMXn3G9gON3YY54tNM0pSmtTo/M9?=
 =?us-ascii?Q?KqSu8Vac4g6aU9lGfXfs6dZTA3Wi7cPja2z/Ry8S6rogeNUDhqwwxaXR48CN?=
 =?us-ascii?Q?kosaULF/94kQaGqYqcQy54zDz882LEL/69673xD6zZldm8P1dDy+Hm737xFO?=
 =?us-ascii?Q?NquUZkCqsrqHyvHDPh8C4xnF9o/xIeTtvLu/JqNFexxUgfTjZUe1kT46IUuB?=
 =?us-ascii?Q?YeiZTTmw7uYka8Q5aOJQMQGK4asvrRr1Lg4NPGUYudNHyKNF/ik1yaxrJyAA?=
 =?us-ascii?Q?+GMo9Jlujgt3xZPQM75hiWPLBrITq3tvNQ/1Ei3N7WEVy6/4jJq6wD+l2vnc?=
 =?us-ascii?Q?Idd5BwHx2ofK0noSnGhRes77To+4VcWhXas6VthsL9O3otFxGqlu/kLLvNvt?=
 =?us-ascii?Q?VkhQc6K8ulBJ9ubXRPyKEX6vCPQheIgwowxuJwxRMbsLFoC6o/uIpIdKr8jP?=
 =?us-ascii?Q?as0iEoZIKJy9G53jib/dO4tIsbH9hGIL8ZyOguDeqrSkkmJqRYbGVHwsxiaN?=
 =?us-ascii?Q?5EkrRPcS+SfCCKbkQXOroZPXcQFaAJxMSDS5Kx0JMTQCR4N/tY4Mh19fb9pN?=
 =?us-ascii?Q?2x5iKtw2vLGS7stJy0nbsWGeg8ArW6ACm7lvjD+Eb+oNpIuDSECAwgyCOitf?=
 =?us-ascii?Q?wFaKtu4I4DYPpd9YKeUbhoqZ2Ae9jGp3fG8jt63lXI4e4T2IR/B3KBwPNf5q?=
 =?us-ascii?Q?roYBzHwg42BSN5Tg4mso6z9dsHjZUYiTybWaNnAMdhqvg6lQYdZbkwkPO1QA?=
 =?us-ascii?Q?+xQ050iPhdCLY7F+T+mdCHaINIdc3lueU2O+KBZzz/Ij/zmG+kk/pDkk7N/F?=
 =?us-ascii?Q?cic30NrHHLqCatNk5rqd8ywQ0GR37DZvo4zrpR6XJeBOgSMgd52XxiMhl5UQ?=
 =?us-ascii?Q?kWShJNrE4ntG7675wQ+v9eeASdK5XqDXz05kKTHLI3p248CQgaaC1OgfJK1j?=
 =?us-ascii?Q?HisXG/4E2vVTuBXc2r1M1wk63lQGcyorkqoQTtOlKNV5ipJ8fjHyTXPGWTVs?=
 =?us-ascii?Q?sxfspM1pf/38vxRtQFfO0//c3hHtek6QOaXzAa2lZfsvKN83?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 302939dc-be3e-4d8d-04b7-08deacb00ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:15:25.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkIubbuHF0Atx0zrMrqpmtI5XP8BFxSyAFiDEiTotSbmAyvjDpcvW2ptDUrIL9TiU0e8OnfcM/WltOk6GufICQ==
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
> Subject: [PATCH V14 04/12] PCI: imx6: Add support for parsing the reset p=
roperty
> in new Root Port binding
>=20
> The current DT binding for pci-imx6 specifies the 'reset-gpios' property =
in the host
> bridge node. However, the PERST# signal logically belongs to individual R=
oot Ports
> rather than the host bridge itself. This becomes important when supportin=
g PCIe
> KeyE connector and PCI power control framework for pci-imx6 driver, which
> requires properties to be specified in Root Port nodes.
>=20
> Add support for parsing 'reset-gpios' from Root Port nodes and the PCIe b=
ridge
> nodes under the Root Port using the common helper
> pci_host_common_parse_ports(), and update the reset GPIO handling to use =
the
> parsed port list from bridge->ports. To maintain DT backwards compatibili=
ty,
> fallback to the legacy method of parsing the host bridge node if the rese=
t property
> is not present in the Root Port nodes.
>=20
> Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be in i=
nput
> mode, using gpiod_direction_output() instead of
> gpiod_set_value_cansleep() to ensure the reset GPIO is properly configure=
d as
> output before setting its value.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 83 ++++++++++++++++++++++-----
>  1 file changed, 70 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 735127ed1455..a2742620279a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>=20
>  #include "../../pci.h"
> +#include "../pci-host-common.h"
>  #include "pcie-designware.h"
>=20
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -152,7 +153,6 @@ struct imx_lut_data {
>=20
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
> -	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
>  	bool			supports_clkreq;
> @@ -1224,6 +1224,41 @@ static void imx_pcie_disable_device(struct
> pci_host_bridge *bridge,
>  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));  }
>=20
> +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie) {
> +	struct device *dev =3D pcie->pci->dev;
> +	struct pci_host_bridge *bridge =3D pcie->pci->pp.bridge;
> +	struct pci_host_port *port;
> +	struct pci_host_perst *perst;
> +	struct gpio_desc *reset;
> +
> +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	if (!reset)
> +		return 0;
> +
> +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	perst =3D devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
> +	if (!perst)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&port->perst);
> +	perst->desc =3D reset;
> +	INIT_LIST_HEAD(&perst->list);
> +	list_add_tail(&perst->list, &port->perst);
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &bridge->ports);
> +
> +	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
> +					&bridge->ports);
> +}
> +
>  static void imx_pcie_vpcie_aux_disable(void *data)  {
>  	struct regulator *vpcie_aux =3D data;
> @@ -1233,14 +1268,26 @@ static void imx_pcie_vpcie_aux_disable(void *data=
)
>=20
>  static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert=
)  {
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct pci_host_bridge *bridge =3D pci->pp.bridge;
> +	struct pci_host_perst *perst;
> +	struct pci_host_port *port;
> +
> +	if (!bridge || list_empty(&bridge->ports))
> +		return;
> +
>  	if (assert) {
> -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +		list_for_each_entry(port, &bridge->ports, list) {
> +			list_for_each_entry(perst, &port->perst, list)
> +				gpiod_direction_output(perst->desc, 1);
> +		}
>  	} else {
> -		if (imx_pcie->reset_gpiod) {
> -			msleep(PCIE_T_PVPERL_MS);
> -			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> -			msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +		mdelay(PCIE_T_PVPERL_MS);
> +		list_for_each_entry(port, &bridge->ports, list) {
> +			list_for_each_entry(perst, &port->perst, list)
> +				gpiod_direction_output(perst->desc, 0);
>  		}
> +		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
>  	}
>  }
>=20
> @@ -1249,8 +1296,25 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct device *dev =3D pci->dev;
>  	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
> +	struct pci_host_bridge *bridge =3D pp->bridge;
>  	int ret;
>=20
> +	if (bridge && list_empty(&bridge->ports)) {
> +		/* Parse Root Port nodes if present */
> +		ret =3D pci_host_common_parse_ports(dev, bridge);
> +		if (ret) {
> +			if (ret !=3D -ENODEV) {
> +				dev_err(dev, "Failed to parse Root Port
> nodes: %d\n", ret);
> +				return ret;
> +			}
> +
> +			/* Fallback to legacy binding for DT backwards
> compatibility */
> +			ret =3D imx_pcie_parse_legacy_binding(imx_pcie);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	imx_pcie_assert_perst(imx_pcie, true);
>=20
>  	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle=
 */
> @@ -1704,13 +1768,6 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
>  			return PTR_ERR(imx_pcie->phy_base);
>  	}
>=20
> -	/* Fetch GPIOs */
> -	imx_pcie->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> -	if (IS_ERR(imx_pcie->reset_gpiod))
> -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> -				     "unable to get reset gpio\n");
> -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> -
>  	/* Fetch clocks */
>  	imx_pcie->num_clks =3D devm_clk_bulk_get_all(dev, &imx_pcie->clks);
>  	if (imx_pcie->num_clks < 0)
> --
> 2.37.1

