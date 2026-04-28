Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB1302140;
	Tue, 28 Apr 2026 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362971; cv=fail; b=L7uBtMxoVfVv/fDe1sO42vI3vfkgrBdiRX0gLNWc4ezC3I7+VQGjgOLbO6mJ8qusZHrv8Ty2I0N1Uzog9pV4CZPYR6c6o6BaNy9aPpyq7SdPUi3cCQjEl88BejQZCPEhMsQ12H/ncMYMcRE6KgZJscC298+zFpqqcrldmbGDtW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362971; c=relaxed/simple;
	bh=shS5VCPGBzWxLhccW0Ux1fITsiliJzCo3a3cBNs7yMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJ2aj4gmfNR7VZLM834f/rlaj3ENdN4AnUC5dXw9CFU5zP3BkiBa+IMi80pMSw0qHjxQzN6pIgTG+iX2g8ML54295PqHDGjH5NYICt1w+HyHmCwVo0XxPY+zdWMJhCXqKobQFnuVKSVeE1iMMKOxAPBHLA/YsQqA/QtDFVgS/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RGtVqFe7; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RGtVqFe7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTiwS24pchwpJ/pzRRje22qC16knCRk7Xx+W4IxKh5MZrwfGhAyqWwk9eeMwbLxV5lC0YUfy6pvItjHMWzh3HlwyuvdDBwvxEMkGmqt+rc2aI56MJIPlPJHWZZZIUaVL/wY3+l0wtjSJaP4cNCHOUXEtnzk7mNerrerm4Ip43V+mCe0Mq3myddv9ZtSbAFpNIrZ8hdb0KswUihnEx7TKbWFBRJlPUfhizF3HnbByRhsMZcUYEi8zE51gcTyJnwcXOovGQkNIEd74Vt/M1tLC73KPQT3csGRToUyNIGdLuRaUWEfTNqM8i03Sl16G5VPcvKQerSvhqELPpB5Jdp0dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXTcS/jZe1JkBFyteooj7f0uy56ljrY7hEa/sdht7To=;
 b=IlZ8TVkpywgoPcdi2ajYuhIJvqA/gBIvkyAIKhaKPeRoUnrri8dJk1c5G8UMQrhYgccQR/BTCSGWdJhAiR4yD3CrNu49xApRZ47O8N8IbziEQiKyrBeeJrpGydSwn9FVt6VcP73HN2qKnz2Bz/vERdYFr1COQPuAFMTm+R+0W1MbVv0gH81lJ7J0fCp7uyV/cnC0/gVBvZjlu/aos4xO1XVugR5gPZqlPN84bdJUvWCjqnqdueX/DgRosUTdCMRMTZLO23YP60eW6furnd10Rew56IZEHRIz4BF1r22zu2FbqX5Re+1Thpqw4dNNmzvrEnnhC3se5fxMZHnS3+JGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXTcS/jZe1JkBFyteooj7f0uy56ljrY7hEa/sdht7To=;
 b=RGtVqFe7sDrO9PweDdMAb2DIlWV0RYZvt3IgK8wHQM1Kom78kaUnRGZlax00Sa2ZYQ7epKLnMsyHmHT/r5VWYG0Y0wuSBYK0cI3nyJAd5l3eRovkJ6KP8JqOgIvqRoH/DbfugLDCdjPj5I2okC7CSz+V+2sAufi2B15Zbo9k67NZDLpJarENAquLj8L0zx479NEeJAo+sbVK8oLTnnq46GfsDdzTGkLX5WC5X0iWTPn+5aLimJ0YWnOUoMrcbkbLroBRsE8G59qIIikQPa7JlYiDjp5+BcRt04KAHFeciC9cEddUp+P4SIJ0pNEXYWK1tvxkscP4j+l6lTOc3xLswQ==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by AMBPR04MB11720.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:56:03 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:56:03 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Topic: [PATCH v2 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Thread-Index: AQHc1uOJ04gePwA0vEiTMqzJ9Yyb9rX0GWjg
Date: Tue, 28 Apr 2026 07:56:02 +0000
Message-ID:
 <AM0PR04MB522038569C83C5262E7866598C372@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
 <20260428075030.1626440-2-hongxing.zhu@nxp.com>
In-Reply-To: <20260428075030.1626440-2-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|AMBPR04MB11720:EE_
x-ms-office365-filtering-correlation-id: 048c741c-1bff-4bca-173d-08dea4fb982e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 56o4pxpG5z6UxTURj9394MoGlSupniCbBl4f1N06LE+DbzNe73sHSdAeVHDr5b55UuyVZ8jVminTw8kCCUid78i34pDoWTC53AKxaReRXPUV/Azkr21E+nwCynWGxmumwNzKvQFsWX/SyOwbrxgtTJWJwDNKmUBjPdFjstm8vd+rDsPnmWyfe/oHzSwk3JcUmsZ4yOuXQZKIgansSgZYqlGqFm0wDxgCATg8GwmxwyzOfvMsdecBhkhm0KB+lhbNG0z6tOb/vwPeAlNEXEGHa+hIHN6Idc4W01/vHh73HtTsPGSb+MbLWDloFHE+0khVBiJh6Lvv/kRj/3E4y00UwGkoVvq95moohBInJtUfvyTgR0IQbihBNx8+FlxuW0235W5fvxayKIMHwQZY5FebfSPkQztC5aNybdiaUmdBPktGmf7Hagi3tfr1tnbwtIAFhbG5w2Qhiyy/zLWKFb/6QueVlBaiQVANuJDOAjlO4EzjWqaa2VnMof4M/4erxv/zID3Vw4rlF0HFKr4fwWBMgJQxuPvSANh9/w6FGApzF7YlSKDNVR0I1ZUCcL8f0U9M1utHSQ2k6UhTL9DriHoOdbIidsAYfGuYA4YhgbHqK/qWIGhEV9OZq7fVonxaiU6qk4VanZGHgASNx22jpNSqaHjV3VCM/HAwYGkChWjXfBKC3BCB0rOm5N31qhoFOyoiT9KCV3DoEA5uhLv5a8aL0euekHGSHkanwPWYTHUJrkIJgqtlkP9Ofk0oJp2rDR1St3QGrohTLJOnMVUxoNv7nStMMDUEGjsx6Jzqhv6heLxNOo03DQwrjAt6zkA9Y2s3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H8uh/7Ef88RBSDAM2cSgFX0FVhTrc3xh9Jnn/zjTXzh0KfXn9Y4zlyWInWAk?=
 =?us-ascii?Q?lWxHVIdelxms+958JnoL9kCEiW+k5crif84iJ673NG07pyXueCzRs3V08xR2?=
 =?us-ascii?Q?sztIOuxg9O+8Etgd6IeGIQjkFMywcQ2h3pNTC5vCRTsMqoYV8fY2feaw2TLy?=
 =?us-ascii?Q?bBfoeqMHNx7crN6GRwM3FN2mwLd+flUIOLJWNEPQeYn7WeLvylaxPy3C7z9r?=
 =?us-ascii?Q?MzBpHw3XuaxbO/Zff6XC3j0io6i5/bK+/4X/QN9w/xNGjpCuK8uWA8ZpcjZi?=
 =?us-ascii?Q?5btg6nDVmYNllQ6kiieKT6v8wbipSKzNi4cy+zuPb7cbzJlPrIgPTKOsrLNN?=
 =?us-ascii?Q?thtv5XQkNh/2NdX/h/kSfuJZS3Bq7+cWu7TIzBw2neClGtjsMa/c82NLVT+H?=
 =?us-ascii?Q?E1vqyUGkNfQlI7IZ1MetUb70EaYj1lIm9yZ5w2QFxqBHyLSW9gqsnFHW6ijY?=
 =?us-ascii?Q?K4FA6Sf0FGQY2r3gM+AxXqj1IXExEfZApRxTgDO3iZ+SHt8auq8WkkDkxwmh?=
 =?us-ascii?Q?8HFDbWjGuGvcsjXEGlaR84sXxGw8L3HQRUKNzT5lJXM/Aswkc48wYPtIdnrq?=
 =?us-ascii?Q?NzBpNZG/FlJNVQ+3vUBY6sEjckWdBaNj+GzFAb38wHLt2VR7CCO4v/gic0kV?=
 =?us-ascii?Q?VWwYpBXA+fi2IQlRwlVmR7lZiH9Jjh2hH8Xa2ntFFF3MQXx3agolItCBHTO0?=
 =?us-ascii?Q?gwhruLchs1UKZheeJ2q0yFK6VgeIK0rDqpt8I27gF4NknJFjsMMkvHPCF4re?=
 =?us-ascii?Q?ORoqNZBBI9DCCtBMGMHdfNiegXagV+FvQOrPKwqd4yERErtmVUXDMLEt8nkU?=
 =?us-ascii?Q?GYeguoZV6rY8zFjrboDcWR0wzh8vtEkXSOsNZ4mY983SDHTkoKjDmPMqDhr+?=
 =?us-ascii?Q?/KVvvRdaw7UmJoHsGV0fZH/M/YCaphDLqPW8yg8WJT33r1m2J7RNbg7z+bJY?=
 =?us-ascii?Q?l4kNpAfhDAujMc0VaQVsNU2L3htcFKn/Cdf+pXQheK7WDH4lPmeqex2Qo00O?=
 =?us-ascii?Q?jn7/vQvCdZlF/UIwzWgCz6vYPRUPUkeDgrVmO5xUGrgpEG04zDGb32eBk4zZ?=
 =?us-ascii?Q?bUPUnKBL5taVsZVbORJsUA1fOK6VF3gR9LMq9xyqkYiqjOleU6DuaLG99W1J?=
 =?us-ascii?Q?ak6dGMPpl2+L9DcopRBAAuxx12pRK7Pd/4PiTfFNPt6/sQen2rIwk3wCAwbM?=
 =?us-ascii?Q?U7RDah1iwela0s8DsyUcbUqi7ER6osXEwX/Nf20Tm/bqJGMOaQbwoPFqJpF0?=
 =?us-ascii?Q?ERh7FFSpNHSRPv+XHwhtmsxjwAPbyLa3mair0zUsfJ3C6HPI24nBsx62TcgU?=
 =?us-ascii?Q?OTJ3/WSOfrLNpQFqu+nVxzwCmEXhYjzuVw7R6m4gfoIVLBFqyNDoh/OXfFTz?=
 =?us-ascii?Q?ycGsPBA3bg3kJGqYP+eH3ilNclNUunRb+vH5GLr/0yV9p+aL6y+Rlf1PJE3I?=
 =?us-ascii?Q?P5AWU2+FIJa3osV2m9HW/MtXr96zaErMZ8RSMrc6m0GEkj6jjJ974uA8FRSB?=
 =?us-ascii?Q?Vsytn7BlSDEM3gAx/+ARCpFJNcLy2yjmEPQBZhWiwxgQRtznBKSexl67vGio?=
 =?us-ascii?Q?agW7mdPV6EImk5Vuw8YDS2F/E6tvk0yNGFlaZ45VPVXVeLJtBCuOexEAnL0p?=
 =?us-ascii?Q?OpaIX5kp0QodCY6g8kLcEp1A/tPisLKtiSVYyTKG9g5P8oIvCtFd2UHGokYa?=
 =?us-ascii?Q?YSJIh0K26/P/1i1ugBupb3NLSAobixTEz1efbSErD6vaK+dF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c741c-1bff-4bca-173d-08dea4fb982e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 07:56:02.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wP/qAdAQm9WsBdV3plVAK3TOjMGcVJxi0IHOxnTM6JzoFvEx7Z+R9y6q5I5rPbEQSDm4Yes0YnNKdgdyH7BeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11720

Hi Frank:
I didn't include your "Reviewed-by: Frank Li Frank.Li@nxp.com" tag in the v=
2
patch-set because there were some changes made in v2. If you don't mind, I
would add your reviewed-by tag in the next version (v3) if you don't have
suggestions on the changes.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Hongxing Zhu <hongxing.zhu@nxp.com>
> Sent: Tuesday, April 28, 2026 3:50 PM
> To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> bhelgaas@google.com; Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: [PATCH v2 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and p=
me
> interrupts
>=20
> Add 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q PCIe binding=
 to support
> PCIe event-based interrupts for general controller events, Advanced Error
> Reporting, and Power Management Events respectively.
>=20
> These interrupts are optional for most variants but required for fsl,imx9=
5-pcie,
> which must specify all 5 interrupts (msi, dma, intr, aer, pme).
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..0913c3312ed26 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupter line.
> +      - description: builtin PME SPI standalone interrupter line.
>=20
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme
>=20
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus dev=
ice @@ -
> 231,6 +237,21 @@ allOf:
>              - const: ref
>              - const: extref  # Optional
>=20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx95-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5
> +          maxItems: 5
> +        interrupt-names:
> +          minItems: 5
> +          maxItems: 5
> +
>  unevaluatedProperties: false
>=20
>  examples:
> --
> 2.37.1

