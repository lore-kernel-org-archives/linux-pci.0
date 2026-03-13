Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E832E03E4;
	Fri, 13 Mar 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390607; cv=fail; b=KSOyJpFKshjF67JbNmwEs97xuSeRauSnbHcSI8qkxxQ4zOZoDwnj+xc7Jmg0BXj+f+ItuILbmeVgc1jtlFOfHMOByZKcE6KauEdjOMY4vLLltGdDcoverWVGceUY48bDMzEqpnzr2iSf+Z7Rko0gHKgQbX+uoxnjVTBnUNVxzMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390607; c=relaxed/simple;
	bh=7meKNOHQjeOe2C99v5akAepkKv1uoGyDGZMt+EDE9rQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mmeBgtkhlbJEs38z7dLEASy5bAbX9bh1k5WM9gnFj1IyeqselLS5P8FeCKErOmbe9TsuTjU1XN3EBXGZv7uo//D5J9Y7bwiyMModygh4H3Asc3bnsXU+9kAuZbG02Sosz8nKy7hJjNwWXY7mVRPsKG4lckwA9gLPXGGvIOiMJxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n5eZNe65; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n5eZNe65"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAdH7QLDSlook5/Kw5uxmYHnDf4v2J/9Ez++0eEKjHbEf364SalXIMT6+gGR3vzxWJjt9tuOcSHeTB16T7r5GxCLdbhS8CpwyWEGFgXWXdJcJwyzqwJElWtTNcpnC4+Y7OTiMC85Nf+6tRK2Ww2jcxevd8IuQfSLD72xj1rxVTKXMy9tiBBfGibUSAL056296/rFnSFUzaVgLiB3xX2g3UzGYE3AiNlJRsb+nm8wfS9amr5q1sI2OttL2fLMILK4rvLmT7B0t3p/8DQDb1vV6MN01jentMFSOUG6kyQrNMfSXJ66+di83PEIkRVWV2n9Jw4CmtI/HsfOSWqZATnYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMKW6du2uTW1hJG11G2XVHNPEulX3F2D6sncsCSQGTs=;
 b=nR2de7M5BX9Di9AL5gqAWQYshwqgDAweQwHd36cSSoxwvoglPic3mpthOaefi5kgEco9fXs2/sFK8OzOZl7H8rkBWfUrA/QQDQ+eQPHmr3/AnZG1eRTcDtHytJv3px7pC4dLoOUbqMqBuuFtSqh8HF0empXC6ZxqXhvPKhB5RSY73mfh+I5TqD+Wf8mzpCbiIRc4lVxJ1yeJDNTJCw74uyDAOwned3fP2o2FLnLuNsqNRExdPeXCb3Yp6k5ctNjOmlZm6+Mee20K8cYRXzdfH7Xoj/XOR0A84C0q00Sfem8sfhV7bcMC4bD4C7LIeL7u87oMKdlx1k6QFlusR43kKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMKW6du2uTW1hJG11G2XVHNPEulX3F2D6sncsCSQGTs=;
 b=n5eZNe65pqc3iXMz4WXUweCyCwSMKKVNNl3h9/wbGzdv8gB4rjbqhgPHggsz9LS1HCDtrrv+ga/gZbCHtkEqz+YyNOWY984hYqecU/lZd4GSgEe0omMxj0StRDncelzrCDZDP38J271QligjuxLDTim58KNOhX2vS3ZnO7Y2zFCsL5C1uW+ooB0ycqxTnVnQZA/+VGF7dhFGYc9o8Qn7YAjIXEmqZRA9D0buZ9AlUy/2eoiR5hsDYbv9rcgdcR8G8SDFQ0Ir0cKxnqGoaynmF4FXxbXxr/cdBo68aB8it9c4GzqSboVvumpbIgbkXylGhLDPT7+kqvC7ORjHqwSNoQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9329.eurprd04.prod.outlook.com
 (2603:10a6:10:36f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 08:29:57 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:30:00 +0000
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
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly
 deprecate reset-gpio
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly
 deprecate reset-gpio
Thread-Index: AQHcslAvPRd3NV8vsUK8f1lUXc6zS7WrvElAgABWzoCAAA7CoA==
Date: Fri, 13 Mar 2026 08:30:00 +0000
Message-ID:
 <VI0PR04MB1211419C790AE195AE73548DE9245A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260312184344.42337-3-krzysztof.kozlowski@oss.qualcomm.com>
 <VI0PR04MB1211433ABEE52392089255E639245A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <2d658e4c-6840-4218-af78-b01a09218410@oss.qualcomm.com>
In-Reply-To: <2d658e4c-6840-4218-af78-b01a09218410@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB9PR04MB9329:EE_
x-ms-office365-filtering-correlation-id: 18a2e9f2-eef2-42aa-2295-08de80dab7bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|921020|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 QMhlwT3Vlc2IGaKRKG298sUnfhN/U55sLZBIxOLzT6VmU/OwOo+y/6edLjtYCW0EEI0J2GRunySkTdghjjmkZfnMR0rhpOmkC4XWhTuBTxEvRQNvHiUiqNphL3KNrrZ+hrIqouTzqwythwCPtdx+XAhxfLZmXAMv/aVn0vamvocBKW0EMsjzAakuXj+2zHzJpAZlqVX1RGuexRdrmG/oAqWLY45p2PQ+t9bDpOCISaNs9ndMYwvovd9ZH4Vm3bT5LcRlNv3f3lfBmcPMbt3efspJqw6BzAKlmXhc2MOZ/P+XJnla8DDkM6n5fmuWTxJcLWnhnfLBhhCe0wqk0FvEFFEa7gYuI7OyHIldJvYgwdkZN1lzkxr2W+N0zv7tH+7l8Dq/yGGi2E0SU+Aqt7npfCJi7jwTy2fNHyDh69idajDxHvoMb7JLx7O2QeKVICeN/v0Doh6vpo9E4vCtPGUq9Tn4QLO9nl6SYuss0rJwwEO3birETafjN0O+ByMCrc6lkk1CPLk1V+C7NMxdvlBWgNRdeDH29mGadn+xm6RkFHhsQK4wMPAX/kIIyntL5ETKdZM0YHj53DB4UXUlLCHdCDBG/SD1odOUsHeqM4roiCIwECk5C+sqnX7vfTFDaZQ2+3jvK4oSiFz4L+m2unERKj+qRtuLD3eOu9ohpGViZvxDUGdf/I/s53P9jm8N2CzD3cm2K6QXs4q4PmssyEnDczH9PRTAqKojV50s4T7qujYYsEzIIpRm0M2KrwQDizi5ewi+74iB0l+ZGMvnWEK4kg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?XOYpxpC+eYGRs7bo6zSxDSPTEX21go3/jfy28236OSrJ6/SYyWW+U5MP4G?=
 =?iso-8859-2?Q?sazsqHKOAkiGkNixmnkRiGU+ByGynCHUqizWvOJFZvjnI+Ef4ckDXDjGAJ?=
 =?iso-8859-2?Q?cdWSZyZw0M9jg0jN80IcmUXCnLrP59w3tXewruTAIFIlkdqdjVawUiEh5S?=
 =?iso-8859-2?Q?V1XpoKQyFtwoUK+yA/yYNOEb1yYBZtOSlnKzZKiByhK7VhEFgpJtzWb+/J?=
 =?iso-8859-2?Q?d8b/6J9uxvBCHBDxWshL+SnJMJ3mgeoTzC2UMphgRaT/eJxM6mYzrwOCsy?=
 =?iso-8859-2?Q?kB/EySuE5c5b51npwQwgVhhXyAPAkcf0qXmVePWOBgjIEBbk0gOQYuNbIA?=
 =?iso-8859-2?Q?otwTg3WkJt6DRNfpcjFWpsUUrhK9CLHGt/D+hcNX4xIS2SdJgXwzHZNpov?=
 =?iso-8859-2?Q?guU9ONccGOiCRrxyqOC3+FLEIcZCNzRPXhPS4h26uI9smZKP7yhhFNsx7F?=
 =?iso-8859-2?Q?6LTptl0I9YKrT8kIDeMcRYuvOCRNu+rRXVK45/+GkEjWmsFnbVRinFRodQ?=
 =?iso-8859-2?Q?Yc5sHB4KjGTuvbB1rbIW5VKs+WLVJ5G+6zSQbrkEAyb2inKMAzJYqCrObY?=
 =?iso-8859-2?Q?JleALkvp36ptei3P1V3u512ISFizUnBy27eSFJm2n3K6U0EjPzdiiAsI2k?=
 =?iso-8859-2?Q?CNKBtiUM4vGk3jYahK0B/Z1KrMYe45zNM8Y9yLiZ7V661fJKOcPErBWm1s?=
 =?iso-8859-2?Q?LsKIbN/1vXt1MXo06jPb5g03a9Ay1JhDAsReYhqO/9ALB8kFnTZ6uWGPtC?=
 =?iso-8859-2?Q?V2G4IRxA8oP0OxHaZR8Mw0JLW1vD9fiHgAokgeGlCAafFcPsdTqufISZvC?=
 =?iso-8859-2?Q?P6+UpA38Mn5osagJ4DKBCchGwH0YHJCOA9Y2unu6ZP0qhu8BcLT0Hrl/m9?=
 =?iso-8859-2?Q?KctC34pbF0xhJc6sFDNV4xpnKIeifgtD0z717AUjQKr9VeO2bBF1CsOHge?=
 =?iso-8859-2?Q?14sr7t3EeaWlOf+34GEgQ7MoYkt6MVHlK4Z4N2eAEO33qET9PYFjdwgppX?=
 =?iso-8859-2?Q?cyITrmD5mnuT58pUYhWi/K1zwvxqcSMsmvdKpsnXwoFyCxaHJ0T6yqPTkj?=
 =?iso-8859-2?Q?klscf0HMz5+JHgZ+glQLzru6gBegc1h1CfzNlYYniUzHy2kfcuW6Jc8IXx?=
 =?iso-8859-2?Q?2DmhyTmmnQcpXa01iOilD8N33Nx2nCO6qfXSNOkl9tC26tbtpbYC+DV7qT?=
 =?iso-8859-2?Q?QQ6ixln+jGnUzUFejQVn5m929fuI5u3U3oFZOCD2ghUHP6qrD6ryBagNYP?=
 =?iso-8859-2?Q?ndLS+M54C5v+z1a17QFjjhzigTzxc5/gXEEVv+nAQ5GoBKtTLzz7IlUiqt?=
 =?iso-8859-2?Q?+Ybm5Qdgp68AoiLvAxVKoMIlON0bf+YfvuUV+V9EdtOUzXkahjpLfTgnqp?=
 =?iso-8859-2?Q?oCf7RrW5z/Yiu2RIyuTsw6DJStx5gI5lPFefeG2neJVbvLgef2C9rBeY2Z?=
 =?iso-8859-2?Q?RsSRZRSd4nO+CJGxrM5xYw4koTavhPizqavMIICVEMnkZUizY+gzsUKFWb?=
 =?iso-8859-2?Q?72e82BhVHTFTEDp6JMflvozuhoRmEn1TatQEWnMhGErQIvqO5MCssjcSTN?=
 =?iso-8859-2?Q?vpHsHCAkoi2U1hUaYYmj08EzAfz6IY4dsNjZmiDBvwUWgdQuQJh/g5hSrK?=
 =?iso-8859-2?Q?H6YwrymBohjeDo4vYhQfLuvtsPeOro83OFEOZRWXB6PJVlWDGLDxyACBvv?=
 =?iso-8859-2?Q?DkD70qQoExYayEjx/B26ZlF67xXb/5gMt6/1c0fG2XxVHePFW4l4x4zv8x?=
 =?iso-8859-2?Q?GzY6WuILivC0ZpXLTP51hU94MitXRwFABFqSi18hnxT9rw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a2e9f2-eef2-42aa-2295-08de80dab7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 08:30:00.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjet2NmsMJHUuEqUaW1S5vPz4MvHAc8dOShf/vM3GIvP9+h8OLX926RFvdaZfp9CJ+bTabsqwn0X+aVBo3LbMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329

> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly
> deprecate reset-gpio
>=20
> On 13/03/2026 03:27, Sherry Sun wrote:
> >> Subject: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly
> >> deprecate reset-gpio
> >>
> >> The binding references snps,dw-pcie-common.yaml which already
> >> deprecates "reset-gpio", however mentioning this property here lacks
> >> this mark thus code is confusing and suggests property is not deprecat=
ed.
> >>
> >> OTOH, the property cannot be removed from this schema, because it is
> >> an ABI implemented by Linux kernel in gpiolib-of.c in
> >> backwards-compatible map between compatibles, "reset-gpio" and "reset-
> gpio-active-high"
> >> properties.
> >>
> >> This creates code and binding which is not obvious to follow, so
> >> rewrite it and be more explicit about:
> >> 1. Deprecation of "reset-gpio",
> >> 2. Relation that "reset-gpio-active-high" is used only for that proper=
ty
> >>    and not proper "reset-gpios".
> >>
> >> Signed-off-by: Krzysztof Kozlowski
> >> <krzysztof.kozlowski@oss.qualcomm.com>
> >>
> >> ---
> >>
> >> Cc: Sherry Sun <sherry.sun@nxp.com>
> >>
> >> Changes in v2:
> >> 1. Rewrite the commit completely after Sherry Sun comments - keep the
> >>    property, but add "not" clause to forbid usavge of
> >>    "reset-gpio-active-high" and "reset-gpios".
> >> 2. Because of above not adding Richard's ack.
> >>
> >> v1:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
r
> >>
> e.ke%2F&data=3D05%7C02%7Csherry.sun%40nxp.com%7C6967142eb77047384
> 81e08d
> >>
> e80d303e5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6390898
> 4094660
> >>
> 3723%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwL
> jAuMDAw
> >>
> MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> &sda
> >> ta=3D4JQjEBcOsTdGVZZxRf2ov1IkD4DizXpsfNhMBZQVnIs%3D&reserved=3D0
> >> rnel.org%2Fr%2F20260311154955.145120-3-
> >>
> krzysztof.kozlowski%40oss.qualcomm.com&data=3D05%7C02%7Csherry.sun%4
> >>
> 0nxp.com%7Cc630bed6bc4f46715b4408de80675002%7C686ea1d3bc2b4c6fa
> >>
> 92cd99c5c301635%7C0%7C0%7C639089378371805072%7CUnknown%7CTWF
> >>
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> >>
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DA%2BiFa
> >> kDVdjPn0JJxUDlTDt1ej4iqnBivDktjwbcpFK4%3D&reserved=3D0
> >> ---
> >>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 8
> >> ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >> index 12a01f7a5744..12cd1b9f78d0 100644
> >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >> @@ -62,6 +62,9 @@ properties:
> >>      description: Should specify the GPIO for controlling the PCI bus =
device
> >>        reset signal. It's not polarity aware and defaults to active-lo=
w reset
> >>        sequence (L=3Dreset state, H=3Doperation state) (optional requi=
red).
> >> +      Deprecated, use reset-gpios which respects the polarity express=
ed in
> >> +      phandle argument.
> >> +    deprecated: true
> >>
> >>    reset-gpio-active-high:
> >>      description: If present then the reset sequence using the GPIO
> >
> > Hi Krzysztof,
> > This property also needs to be deprecated as Rob suggested in my
> > previous patch :)
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F20260121164002.GA3427694-
> robh%40kernel.org%2F&data
> >
> =3D05%7C02%7Csherry.sun%40nxp.com%7C6967142eb7704738481e08de80d3
> 03e5%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639089840946618268%7
> CUnknown
> > %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIl
> AiOiJXaW4
> >
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DduSx4R
> MO9WjKX
> > 0aUSEM49tQpEpUEc%2B7aVATwASdFSGE%3D&reserved=3D0
>=20
> Heh, why that patchset isn't merged already?

The V8 patch set is still under reviewing due to some pcie driver part chan=
ges ;)
https://lore.kernel.org/linux-devicetree/20260313020823.1592389-1-sherry.su=
n@nxp.com/

Best Regards
Sherry
