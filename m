Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42823254B0;
	Thu, 22 Jan 2026 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049095; cv=fail; b=LxiMrkD7GZiAgzYIawfcoZtkvcXc50+AuOdgaQNKG4kqdCa/pSXyrs8IN43f4pzN0jI3qb2yRNvyMeqUWXYYCvWpWAehk9XFL7+ASo+YEDznj6w6S1voWG+FZk0uHo8xECcypZ2UYA3Dv0op4em/GjikPgj6H0foJZT0RBGi2yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049095; c=relaxed/simple;
	bh=qjOj43QJiZuk8wCOX5TbsoL0ACMR1RS5Cke0+jxrg2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6c10A/pEznk1VJ5ewpbW0NTK+KFgN7No5vuiJlO3e556P5Q2XIL6k6kMxe3IYLr0z9sx+D8jqWPN3nyAX6O2s5vK/jseaZkNBb+Jyvtsf1cyWjPjfMn0Xx+KgluEBa4tD2GeSg+tDtJfFgKX9e0ehiKPnIlkRnUBIS51cUSWXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=COAHFkd/; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="COAHFkd/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqzgy2W93suTQx7Ma78IZ+4/xAB034x1kEAqMKDJEI2t9qvgovr0yUqB3FOsKolEjA6Ex5lm/jSSDL61vk0ZDCtI0JYuirTUfQq93SduH2H+Wu8qcJBNl9kMutezZZR17NpEMa53a96M7V8AlPW02TGJApPGq62RNtUO6fqs8bBe4IT8FuZBLRvT5XXbDvSW7BvhWE4BOTppQzAMHVeWfu2hC4l1ARsr3EsKfCbtA5exCyXUTjzNbx04HC2Y9wVqk8b5OcoEF8DA5Y9Rgzi4PP8wTP3jCKyGV4KhR2kz7GV99etXxCQkwCt+imlZ22cDuQn4jDVLypjPM5EH0GEI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIzNPk1zWI4Tr6TssY4Q8ypTEUMvQakkormrKBcoWcI=;
 b=uWqCswsB4B3Zuhd/PgvJ+1EAPXHYxy7aBXfrnpM4MHl77WfHnmsiR45K8mz31Sq3Q0oUaVsy7Grln6oFNxz0B1R+A/nenDg2vJn31ErXC7yqoR1WA7O4uRTLxze6RtStaS75LDuGToZZdJ0Hvv54k9Cix2navM8fYSrukWGDcqC6yivCNLt46iL/Nb6qz6BodDacfcAN1Hhan3Ktf3dlOPLa4SeWbK8f2XBSMEpx+9SNjm7QDEP6B/VaV9kagZrIBoflJ4H0FrLS3jClnm6tRAax/UBgZ7ZjoUODf4HnlI+oVxKTwT0/ddFnOFC9rR0aPdZXBZHZqYAh6dy1fUq57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIzNPk1zWI4Tr6TssY4Q8ypTEUMvQakkormrKBcoWcI=;
 b=COAHFkd/hMQhlTHrnGGvz0/qRbVjFMG8KCsj1GG3i1KcDL6QoWxErKRvvxCvKp3yKsK3bspd4ydAxx7E50K5+1GxXu8IrWfXh4E8Gau49TA8uUJRNq7UXjF81XKQFspzjP4r4Mg7/7gSNikaoJ8txUFwEf465EZxJR3pvnpfpjwPlGLTOb3qj0uovJsqlfuM+GXLFugTYTnEFqt9O+p8nJ9Sf2Kuad6L0P7J1Re7ctBdravRVqUk+8gRUVF+qKhEMqkAN/Zq5f9cK2u+k51TpIP3TfxGzKE2hvV/LmOsO3wZjn5FGpx3uE1ZKgTDMUXtYYdxwzggV/FHoT0WG0KQxA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 02:31:26 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 02:31:26 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Frank Li <frank.li@nxp.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in
 Root Port node
Thread-Topic: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO
 in Root Port node
Thread-Index: AQHciSrkYtB9tLTqMki47vkTAR4KwbVc1tcAgACkYFA=
Date: Thu, 22 Jan 2026 02:31:26 +0000
Message-ID:
 <VI0PR04MB12114175B7AEB0045908223119297A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-2-sherry.sun@nxp.com>
 <20260121164002.GA3427694-robh@kernel.org>
In-Reply-To: <20260121164002.GA3427694-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AM7PR04MB6885:EE_
x-ms-office365-filtering-correlation-id: 89f71ce5-44fa-4dab-a529-08de595e577c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e3LFYvfv7Qaqr7HGNpylpczMwwSEU8RaFN6P/Q6DzwZv0IMnzT2hDChb38BH?=
 =?us-ascii?Q?C68HGhyzUvSpxSzfzc7GYQcWlVWnEZJI5w0VI+SGjDzskb+OZQbKg3ZH7P7E?=
 =?us-ascii?Q?00iyqiGCY6SsQ0aPW6dpsWiKjTR4sOU2ILd8rScIDrp2h7V89yChAfrmmGr4?=
 =?us-ascii?Q?NAOfYrMEw963z+h0hPs6aXLbxfFrwPrm+rsFUpLmM+eoFIKTSuOpYmfkYwlz?=
 =?us-ascii?Q?Z4Rx6oJc/nWz5OOi/MYsi/tM7QLDGWVTbJgceKC3XkF6XyrDH6lDkQqA4sL8?=
 =?us-ascii?Q?MNFeTjnsCMtaVfAtHltkEBhJWlOXqspLcpd+ep/TjWSEIKsdl/9xqxO0t2WZ?=
 =?us-ascii?Q?SVzIMWe30aPATFCFf0fIZWN8ac4SJXgM36aohSQEi5pbMCpaCDDIY6s3wvWM?=
 =?us-ascii?Q?6fF/jppnRU1g+mUSd26xQWoatRfBzCciZyEcgPdT2N8A9MaZEe3Ju9sSrAn0?=
 =?us-ascii?Q?Gqyb1CGDcKpjebnfrRsd0fhAOy7ioqLleVG282X0DV9EE6bpLlieYkP70Oay?=
 =?us-ascii?Q?P3gBmpjX4CEGeVdC2fMHcCcBKz1UyX4CEclkG9+J9nOeS6H4fNLESFAN8eWc?=
 =?us-ascii?Q?Nl71Ua9RmiUV+2aXlONSAQEhEwI0R4J2bOkgDCVViJUE5L23H79km722dbrM?=
 =?us-ascii?Q?sJP2uQIRtfTiKM6WuNxXoq4DT3xJVqWKDSa2z92/hp3XsPJjfR8+liZMxLxc?=
 =?us-ascii?Q?2uvGfJ26i7tJQQZneXb0IhmPBn9JtNd2j9YczOu8kLECSHioTrflbqf9KIEI?=
 =?us-ascii?Q?8+jXbxBCtfdkdpd8zvZFt/qc++BOMA6TJVeIslWGtXOsetSwbXoUcyImV7f1?=
 =?us-ascii?Q?mqScSf6KyDardnXwOkaI1Qg0WB5fL6WPWgv/posVjjrLmEI4qfdbjl88HBVA?=
 =?us-ascii?Q?JQhnXdEkCUzgpY+c/3PI0gxPIlPD2QqHUFMCXrzT7l3GWRdcQrdJz3i5TYhj?=
 =?us-ascii?Q?AclyFHr+RnFRUFKQ/LFyUcsTXfc7vZTzIMw+HyO0LHDVScmWnZe+Z/sak1bq?=
 =?us-ascii?Q?RG7psq8Gp3oqUhU3y1riuoZHzBbDup8kSJ8hYIdFsvhd5fud+onVTbZhynJv?=
 =?us-ascii?Q?N5qoU1STFkH9xLmcyzIeaMQT0lb3QbABjlFw25CSuEVhnoyql0pKYo+JdC9w?=
 =?us-ascii?Q?a7B4UTchkX2AgORW2twLsnENXA1TmcziBvinzh2I5hlqmolpzTDR5ncejCg+?=
 =?us-ascii?Q?L3jbjBBPtfr9R4FWoYMxK/M9ts/YyYpWGURcgquGbnH1L0FD/D7KqeHGJ6Gc?=
 =?us-ascii?Q?fJp/WQ2n2MPoAEOHT5CAU+mfWni14lmJ2hyjW34IYccJ+lmE68EZ70yzM0YR?=
 =?us-ascii?Q?i1TJm4sdG7Brf89jhMNssOzi/Ahfmeu9mmiQWbvFSE5/23gg7bNnPjb87RIT?=
 =?us-ascii?Q?/xAFVrnOVXiuwzTKcPysVLa9FDPwrna22YkuckD6LiaoEchSiOsptfSTNXDq?=
 =?us-ascii?Q?0dp0CvCRJ8Fle6bbmsjeEjH08puE11CxrsnhtruqLGPghIzQpZlty28YYTWL?=
 =?us-ascii?Q?46SRmiT1rmgJWtibHR4zaDBFv9qfE+A9Qo6GrfVhzwyXo7ztbKd5nDvINe4Z?=
 =?us-ascii?Q?jsoBls34jYeMuOlbE92BrUKjtyMo/nuzYj8pIEXV78NjCwBz7cqPt4sMlXsk?=
 =?us-ascii?Q?l9rvDuFDeVFjjMTw3ttEX6k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nh8xsZ81NgWb8mOq7fWBu2Q0ymbzMGvVNpyHU5+/5gkhsGGHHvd4oD3+ydx8?=
 =?us-ascii?Q?khgHstYrm/BJDZeJpqGGC+u01Ii1SX3qYU8tpLA3uEAvftzefKNHXbwOqimQ?=
 =?us-ascii?Q?p8d4t3uHAzGniNXC2Rg1RdiMiLPgjYKDLRPqDCmtgQvJO4utOhPDvGo1Dk5l?=
 =?us-ascii?Q?m9i0V+y0jXvQuc6p1Q1dJ+C9lfuYNhfZzF9rZX1q7ogulcMzgw8ayMj+DoAp?=
 =?us-ascii?Q?u3px+q6h6rF2N+eIbFlOaVTwDntfueGiFvmf0zA6rPAIKlwhAHZjh1RiAfvm?=
 =?us-ascii?Q?bZPmZW+rDg+jYkndswt8hpMtMFgIqAwt5K6+eAdzMF2ugp9rZwwZxUY8gTkZ?=
 =?us-ascii?Q?OSNDW00+sSOgOIXM6R/bH83rokVzkpID0dGLibukNP57UCWMXYYnfSqMEhuY?=
 =?us-ascii?Q?/99pbp0CBQ2SFc/7YXMDKbEwQspuM8vHbEfl3Mt4yafpYOyNvCQMng5Z5AT3?=
 =?us-ascii?Q?FlWHgon1MnQEdc8Z7oMsPZPpl2U1c+9w4uhDb6ydGKoR0hGlUsouGiHvmDot?=
 =?us-ascii?Q?H5FSPEAJfG5T2dVMuKs0kq1rPQ+hAjaot+V05XBodes3zi1fNgG4Xuyi5Hey?=
 =?us-ascii?Q?K+GpMozbfpd2Aj/RDCfmAxMf0IJkXaGAu6I7YDShvzQeRJXCI1YLGlj4x3uc?=
 =?us-ascii?Q?+q4n9154VnnaBF0fqu7f5Sv4PzrYF5jHs1B/CKTqxDkPBwCyxBnImBLmxz3i?=
 =?us-ascii?Q?B5h1I2b2eVc0t1bkqL5XZC0TPG5Dzg8AxHOycm4LYPXeqg7sqx9PGr+/iHVB?=
 =?us-ascii?Q?P4XgWfpyLYCPYySh7dV9+20T81kWlsMPfWBJgFYHI1B6F/ybt+aj2qgmGYF5?=
 =?us-ascii?Q?ybgOLhVKP0m+2l+W7dVVXsrnUsLOat0gNfoq187Imru6QI9ZIeC9bl8cwqJ9?=
 =?us-ascii?Q?fxv9/lKSc05LwDDYPUuczGWFq2OtqQ8PBh0jvJG/PYw+tRF8Ki3wiyrkiIsM?=
 =?us-ascii?Q?9jlZecdUyK2YRIvWR2v6t480dbXhnh+MYCrS2R1e0JzvotWTqFbrrrvnotYx?=
 =?us-ascii?Q?UsStDBaVA6DyFnjueHaL4cqRF0exgbowCpXFgRvMTOgm/0/qNDDXaMIz7wyV?=
 =?us-ascii?Q?gjq300Hu1Inf/xxVqFNv1FFvAVhDljCmMxDhVUqsSRQi3gWPheG1gbp12mbM?=
 =?us-ascii?Q?1CsFkQbPX1oAyqMzn4dEPLonjqLL8DyIj1Uf5mkVTC9t/CQezWcDU59gAZha?=
 =?us-ascii?Q?F0LM6SgW65UzWuj5JLJS+fHoTy6THlwAvoImaapVvTEpK3FhvsKJmWF49buG?=
 =?us-ascii?Q?RWInu5itKj3SWjnutDmI6AYkpKodnmot7USYFgWYk2vOIbKGmqHReF3mbpFR?=
 =?us-ascii?Q?Sa3E4cbwOAptQ4b2c9lvBiLKPZvaFRglBRvdyR3EHECkacJ4NAJZ7Efzkudm?=
 =?us-ascii?Q?Pyk0TG5cwk3BtMIzVdMrvF+qHTRUDqQe22E1Hx1RQoiFFV876x3Uw2peX4lD?=
 =?us-ascii?Q?6bHks9vFDKNmqPTbVbSvnL6Qb1F4kiY0GT67rCuC4CULwXVEFABPGRFUHomx?=
 =?us-ascii?Q?mxKq4Z868Fc6goL2uIa5FBCDBaasKfmB0I2LkoI0qj+Cc5km6pfJf29HvdfN?=
 =?us-ascii?Q?uWpzRuZTqhsTemkdeLFasYV17vFiNWzKZV6LXxHV518M9xXQHC+PGQCFs6tx?=
 =?us-ascii?Q?abVWb0jstv8LaXWepFNujiIYuawAvsh+mcVG5uTiAGsaMAKgABO0KmiiNGzS?=
 =?us-ascii?Q?yGLmeQ2bBmIRncvojdaHkAbzqwU6GK5yKIDyq+/OuyGIIr8X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f71ce5-44fa-4dab-a529-08de595e577c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 02:31:26.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEA2P5EnOACBkxZcdHGo2q2O+HZUNnpDVZR+Ow7MbXbZ6EEx/wI0cKOTodOLNUcZMimkGxZ8A3qYYjU1WwVBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885

> On Mon, Jan 19, 2026 at 06:02:26PM +0800, Sherry Sun wrote:
> > Update the fsl,imx6q-pcie.yaml to include the reset-gpios property in
> > the Root Port node.
> >
> > There is already 'reset-gpios' property defined for PERST# in
> > pci-bus-common.yaml, so use that property instead of 'reset-gpio' in
> > this file, for backward compatibility, do not remove the existing
> > property in the bridge node, but mark them as 'deprecated' instead.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index 12a01f7a5744..74156b42e7a2 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -59,9 +59,12 @@ properties:
> >        - const: dma
> >
> >    reset-gpio:
> > +    deprecated: true
> >      description: Should specify the GPIO for controlling the PCI bus d=
evice
> >        reset signal. It's not polarity aware and defaults to active-low=
 reset
> >        sequence (L=3Dreset state, H=3Doperation state) (optional requir=
ed).
> > +      This property is deprecated, instead of referencing this propert=
y from
> the
> > +      host bridge node, use the reset-gpios property from the root por=
t
> node.
> >
> >    reset-gpio-active-high:
>=20
> Probably this needs to be deprecated too?

Hi Rob,
Yes, I will also mark this property as deprecated in V2, thanks!

Best Regards
Sherry

>=20
> >      description: If present then the reset sequence using the GPIO
