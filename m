Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4B3C4168;
	Tue, 16 Jun 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578607; cv=fail; b=loqBBdI/U+elILU2dMe0hk9G6zFb/KLetoVKWKQ72HcAtVs3ykr6uMpsZqdAZ43rT15eXFefqm3o+WQLISIJs4aS9c5/VqxiEvx7xaHhbmu+RhMH7p2sJ+Q1+lHpo8RGnfU/YcTLFlgZSEG6VvfryKbfr1TJss8D+9SYwly8GGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578607; c=relaxed/simple;
	bh=fRIxuqjE6dnq1a2NkvHrNkJbXv6tSLl/P3OOf59nRVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=clc8gktap15Pc6m3sjR8EHGhKRG4CzVaQVpKBroEQjyGAiqU8rd5Pc3PC+ET/gJltUfDOeN2E4pRwZwcoGBTM1Kj22JeutHUePtc3P4sOFAY3KWo8h5JRyYj0VuXT5kaNuutov/tkJq/TTN/zPvQB3TXtGUf0rBU7eFlkQsu/7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bUb9l4+p; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bUb9l4+p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCasSN8S3e/8DnBEMRIjrGRaAO2fR6expeeCf2PkjMLUiqwyGhOD7LJniEg9ynDG8WM66/yEpQ2BLHRMgR60yerOqfr2F+HTgN/0yPYBANAXYED0O5H9x0ijVOWme8p8282xmVHhMlqy6ZaYZ5HzwUV9s1qQpBg7USuVQVKkVzWUQ3VNyPptSag+KYWGOYSJ2kPaY+Ec99dxSo2qLAhOfKSZdBu5L9PFdHhPI1kSwfewl0BaMy4X+mG2ES0jOqslNybsYcR4ZLDwFcFsnRIa8kxeLrEoUx7UtbKbeoD+DBem6r5WPbrVYIofl0Te4zkcM5aFOuRTxqFv2RKSk+rFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBqdVd4kPiajOizv+QcZ696ZF7kbG8q3exrC91H/D4o=;
 b=Naok61lQNCNppp0FhD7tmsqCJwISIBpu1bUuE7/EKBH+wGQ/Rm9xbJcGo7/I6TrI9q3X8Roia5nW8Md8cHUmw1tdzj6ms56F7RQu02uk9XzfOS2PM58vxhHVsg+kmSqNkd6A//Mpu2SCCwLpGOuKXXo3ohttfVS328ruQFHUdxaSp8Q7+gh1HcLAI4obClYaUUc0y3Juikcl6E9A5vqcVFzFwG1TWwT1TmlQWgM4t0EzRhfyTwislEvHBs3lZPc8fceNtYJLABtmJ9WHdqYbFRML/QknDyHBVulIdIpXLUzl3fCl+nVHeeOiCTCQVwEkllCZyWRJ2Da83DhK5Wg8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBqdVd4kPiajOizv+QcZ696ZF7kbG8q3exrC91H/D4o=;
 b=bUb9l4+plKYuWl8jrRtmnk6ekA3fStJNR9V3jObgcxwdf3yUE1cVHNu0ap3hShE+WwxxnskViGR/hlF0bzViD6wrXRZR5otFullQFu/f+KAS5qm2egSQG3hTTX11/zAzYxxW9N94r71Pjz6psrtWhGQOk2AFGitEgHRcwFNxfWeE3ZvzKiBrQwMv862LXQq/AYAdFjIx40LSZ0axtzbT9HMDzMGZ/C23G+V78h8/vVAt/zmHhLx2WMy7kwOCBQnsS4HttA04t3QbF96jKThbkLqenp1Hy0ClHe3c9a4Cq4Xd/SA83JFalyyDasxI8+Q9dNwiU+fi0KraW991i5slUg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV1PR04MB10394.eurprd04.prod.outlook.com
 (2603:10a6:150:1c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:56:41 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 02:56:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Rob Herring <robh@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/3] dt-bindings: imx6q-pcie: Add optional intr/aer/pme
 interrupts for i.MX95
Thread-Topic: [PATCH v6 1/3] dt-bindings: imx6q-pcie: Add optional
 intr/aer/pme interrupts for i.MX95
Thread-Index: AQHc8yFX+77RF38/LUes84hIwQhrpLY7FeAAgAVr5CA=
Date: Tue, 16 Jun 2026 02:56:41 +0000
Message-ID:
 <GV2PR04MB12019EF6D1B1697D7FE87105B8CE52@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
 <20260603062510.3767610-2-hongxing.zhu@oss.nxp.com>
 <20260612151348.GA1040341-robh@kernel.org>
In-Reply-To: <20260612151348.GA1040341-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV1PR04MB10394:EE_
x-ms-office365-filtering-correlation-id: 2b516bed-7409-46be-884a-08decb52e4be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|38070700021|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 xr6/CsbRna1AP/0ChltHE6kZhryO4Qz3mAX0irgRWQRqQwwEjLmVQfXNEV+Fvito3YAayci4tnfmzwThi6M7LDnctr6rk+9o8Qop35jUFEddv6sHGcbIb8ellxyQ6+4QAvooieRiltYKtEnXC96p+V6I5cwAEKrGROk5Np0fF6mwp7pEBj9M1knabwI2dtxl5tj2fZxgujdtOyy3lc8sFdp9RO4EgXuXZc4oSWceOuRzTfYTrO7dmUAESnTvnslDKu8IHU7d5s116Pag4mj2747z/WCXOczuQjR3Xu2stZE2uc64Ih1a5yGnY28ljfUfWVHDPBXAdk6cPwzdYZ52n7SIRztqsn3E2uZV+sqc7C8t9VjGEhNVfdRSv3x4vBWhWhsQ0AMpNHkX2f/1RfQ+WVj/Eh3iZ/r4U9QuDIS887vXH0JaKbVfgLedoGf0dw6Lp+c64KHx4dXfeKz0eqn+exLI1Ahz4xQChZSh+4PKj5jZx6ZbGSnq7cB9ICkSdyF37vZLf/aPwoRjeAiUru+R1zUiplr8P/BsPuVgfRwAMEFO31x37Efx6DcN1V5azCuN0HRsuG1sDQAQSLmqLOUoSLnvuHf/4NxIwntNacDxEq8oWivA2s/o2ITrc1C9EV41Xk87YusDRWsLMSLT+i5Ox8b3RPcMw8HUPDPeqJdcyoN/thp8S6jtoECwuupMbVTrP0MzSbF1vk0r+dlJlUyJdIU8RrfLJDADbOeZ6HNZo3KrgoeRpjiAZ9IIyTHG0ony
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(38070700021)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rXyuY3d3B6LBRUowc+YtwGafh5xeAl/CJAB+Yro6vTACQGgDAABFf32fyrOw?=
 =?us-ascii?Q?ga2QS+WETKssj5p3cZBKBvwyU8idPrcPn4e9TBMorkHGNUHDVA5raXK5Hrfb?=
 =?us-ascii?Q?LD9oqFeXs2a+BV+uRqg79l8wogExTCqAbzE9PptEHScG1Tp6ckAB1JxmyI8C?=
 =?us-ascii?Q?5+qJNoN+v/11oE+6z1BFYjWaFuBfgbi77oPRtibdgCC66pHO1YCkaZtTwF33?=
 =?us-ascii?Q?S9XmX+LmLWHJntZsF66SqLc7mRFe5iRGFDeRVDNy+gxTOtSokG9HRE32cAjo?=
 =?us-ascii?Q?gedljTPtf0MvMDOP9vv5hzyPz3UvyQHW4GBcdFweEt+64BdeNmnAI3i7kDqL?=
 =?us-ascii?Q?JEHIbskzEn6vJiurgBvD53hVfxGewRYBhd4E3ZsTuhuGQVPjTE6tAwPSPgJs?=
 =?us-ascii?Q?d8SN0fxIxgFxuq2vU9HWSq5FQZzD7WsZWCOKnKWOX5UEJ6ImArdqeG/rni0S?=
 =?us-ascii?Q?svGM6elyxuDRjBHHytw8aCxXq/2m1NJrEt5UzWWVL1DicRK8AZG56ro2Xvbq?=
 =?us-ascii?Q?A2GV6GHxTA9/UDJd8gsTMX2U5jjl9429Q3Ts51x8fRPn3UXiC9ksWCb5lcI1?=
 =?us-ascii?Q?mMqKuTPGV4EShMIcw44IiuY71x5Qy7PT4a1P/s3xUau9OfccmoRVIs9CK444?=
 =?us-ascii?Q?T8abjz25J65mPh0BJx2wyVAvPJBtTR7XxVlBjZ9fSP5Gya79wNmthCdNEPS4?=
 =?us-ascii?Q?eumSpvGHNnX1CRH/97c4f/9nLtydkAMHeLeltkztQ/6Qa7t89lrwl16uHeXY?=
 =?us-ascii?Q?McoPf+AMNg+gXlTKfPKMRdq5SSz1bFUg3icU585Fs0Cys/QjmyGTioUhZkjm?=
 =?us-ascii?Q?DcXxkTse3rRVfrtrudknpny5RAuNC+A1l9iCm9aNoZfjQEpVlBfkXjGqf6V9?=
 =?us-ascii?Q?s2eK+NGnJVjtIX+zf6iWh47LpjwYy6GzA1HK/UvHCuntCr1X5HbCcuP8vUEa?=
 =?us-ascii?Q?m6a1ETXBWGWvpNZHqu+F/jVqAj/ZR/E0/gVO59Gcup6ASTqOJh72gmCxDOww?=
 =?us-ascii?Q?wUP+gZ8dFZBRKNuJCD5Pp3h+ztwljPYyfsPmARS1Z7lHdlcHmoCezChlxY33?=
 =?us-ascii?Q?gMku37Eud4MTN9E5ADb9vNTJFs7VRSkjgEqQJEpPIqRsuSVCrYbj5rstD23M?=
 =?us-ascii?Q?M4vXPyu26qWwaiz75VvxIQPSRixfWtvWUQESlMDHtnifUr/EZZadcT677Bwl?=
 =?us-ascii?Q?193iH48BPs7vjYxZncbEW+DqNB6wwoz6q3LzXKwas9yDHL51P7W2AaMOrNmL?=
 =?us-ascii?Q?DVfuOrIILG/drGQYFCfMhzFLTjuPsJVbVj52basVBBzaWif3K6AptG9R6Atb?=
 =?us-ascii?Q?wXRFtjca68QHQcE0C89Tf4gaFfAQH92mUZNeonbi+gn19UOpAQYpB+bI9IzX?=
 =?us-ascii?Q?zF8p1TocdeXBain1n2ptI34xn6+FUyta32v+2oBUOEV/V01UCIgi+6HReZhI?=
 =?us-ascii?Q?6Q7LvS2zYGTfvZr7fhHqeEDgC9tzu12lJt2B0Vk/UR6rH3qmUcSxpXkQ1XF0?=
 =?us-ascii?Q?WSnaIKA//RoT0UXCLkAMpGXCaUklJr0VnR0ml8lvIq4B8meldjcKE3ywfa0t?=
 =?us-ascii?Q?RL979J0wcj/y3EsfPPcJ1m4AxvjWugafzWgmtzDmQTKNGVqgUV9LhjG34gNa?=
 =?us-ascii?Q?6ZxFzXFf1MEJ12aWu7pWwSYwXEGA7UT4BcFQ48gYrN2MqR6Cgiq9uPw9rLOA?=
 =?us-ascii?Q?zyaMkj2/mqTNyxvyB4gJAud05PXOJUL6/Qn8PpjTC/bUG6AX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b516bed-7409-46be-884a-08decb52e4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 02:56:41.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt7hKCknsGmoM/HHI9iKG3uvcOmY6LOFd2oz4qpvbtPe8E63IdXZl00GxdIS9ulEAsKNgINXV/A7kWyCFgYWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10394

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, June 12, 2026 11:14 PM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: krzk+dt@kernel.org; conor+dt@kernel.org; bhelgaas@google.com; Frank L=
i
> <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org; lin=
ux-
> arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; Hongxing Zhu
> <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v6 1/3] dt-bindings: imx6q-pcie: Add optional intr/ae=
r/pme
> interrupts for i.MX95
>=20
> On Wed, Jun 03, 2026 at 02:25:08PM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > The i.MX95 PCIe controller introduces three additional dedicated
> > hardware interrupt lines for specific events:
> > - intr: general controller events
> > - aer: Advanced Error Reporting events
> > - pme: Power Management Events
> >
> > These interrupts are optional on i.MX95. PCIe basic functionality
> > (enumeration, configuration, and data transfer) works correctly
> > without them, as the controller can operate using only the existing msi
> interrupt.
> >
> > Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm,
> > imx8mp, imx8mq, imx8q) do not have these three dedicated interrupt line=
s.
> >
> > Update the binding to allow up to 5 interrupts for i.MX95, while
> > restricting earlier variants to a maximum of 2 interrupts using
> > conditional constraints (if/then schema). This ensures the schema
> > accurately reflects the hardware capabilities of each SoC variant.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index e8b8131f5f23..9b5d4e59dfff 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -58,12 +58,18 @@ properties:
> >      items:
> >        - description: builtin MSI controller.
> >        - description: builtin DMA controller.
> > +      - description: PCIe event interrupt.
> > +      - description: builtin AER SPI standalone interrupt line.
> > +      - description: builtin PME SPI standalone interrupt line.
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
> >      deprecated: true
> > @@ -248,6 +254,29 @@ allOf:
> >              - const: pcie_aux
> >              - const: ref
> >              - const: extref  # Optional
> > +        interrupts:
> > +          maxItems: 5
> > +        interrupt-names:
> > +          maxItems: 5
>=20
> 5 is already the max.
Thank you for the review.
You're correct. These maxItems constraints are redundant and will be remove=
d
later.

Best Regards
Richard Zhu
>=20
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx6q-pcie
> > +            - fsl,imx6sx-pcie
> > +            - fsl,imx6qp-pcie
> > +            - fsl,imx7d-pcie
> > +            - fsl,imx8mm-pcie
> > +            - fsl,imx8mp-pcie
> > +            - fsl,imx8mq-pcie
> > +            - fsl,imx8q-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> > +        interrupt-names:
> > +          maxItems: 2
> >
> >  unevaluatedProperties: false
> >
> > --
> > 2.34.1
> >
