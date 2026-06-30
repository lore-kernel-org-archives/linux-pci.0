Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB21E5724;
	Tue, 30 Jun 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808172; cv=fail; b=hvwE4EjLCZrhvvA0KWxNQlOcZ9RMjxPQj7dijLX27sVWiDGArdtSnJpk/GP6ldkyG9jx5vsYm0u+YoVYLHDNYm2oHLTmBD922A+ng+tXgchLSMT/zg3ZhgnWqrSFEV4EVLZWkOszd/Ax3Z9PLZiV2QPMLidJ8h9lAGJnZiPB2ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808172; c=relaxed/simple;
	bh=eQwhYcC/P9W7Gol5VSICtS/GYT0pzpenKRTpsZs/KAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Au4FYtyYoizVTPdd56ntDaEWI4SPfsuWmoDXbtuF+bWX2hRp0U4s318JeWgS9L/qH6Sjn2EHHhX43yUXXso0yxpLDQT6zsdcphIuydGcCfIAJkgKSD30AhLCo4bzUtCYFD/SS+gv/EvL1pAAHwEpAzhyxQv6xj45vH8EsdadNnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mjMhBTyS; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mjMhBTyS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7DGkXioPearFhAaGdjAM380wrhMNLUA6TSBdg1b2LnmEi8/qFtvaboLkAhHzUhCn4uERRlow+Led+pgFhMv6MsOKAp6dY01bWBc11MUVXMrkzGMqBSnv7f8/m3xh7mKbbZyd5zy3OlG4ndJwEmKrIHDIzCrfweHiOUKcMpdAvh0eEgaTs8rSya+YwZcgSJdzQZxl+on8sf1ClVuDvZlr6bFA/9JFrXdcqwXco/lcq4/q1Uen5ACQMuN/da65zsI1Ho/X/0ec38E8Z5rI8U9otiKmsxfsmjB66d+T+xfWRZP+W131P5JGyUlr6bdpmgRwYsXXNkLTxQE1Pk1lN9xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0QWQjt1sjA6OjcqrMA02EYrWxn0rziRHhrH9lyBAp4=;
 b=en1N8dwSPSZC6/6keOf3GaexhJ2Ly3mhuLKw2y8GqNuTfgoWC4lwQ5ZrIT1v5cmQlhZ89BpiFBiUBXqQrjFVyJ2JLBea1v0bFZvMr4FIp8vipDXkYFGIObxN+L5FpjYtJxm+mGK3MGvGfmfBY3BVda4qt7xABVngTinUlnphzHuEXwBVK10Nd5FWk84iY0P4PgVKFLh/dbkMl+J/gQk0epPzPmtRv9jrBDDj2GD2BwWDdhdAIAxrXqKRqPWYcEw11laBY9Vj850gh47AzpH6huJwIBZ5UA8ROcNszMe4XOZWCB/+4TFPP8q29t3SuFojgF7ektTD3IewI/RqI2b8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0QWQjt1sjA6OjcqrMA02EYrWxn0rziRHhrH9lyBAp4=;
 b=mjMhBTySQBd80xMkxzyGZsDfqS1Ibb5Jd5cc7rHzbwGomH80VSskp/n9HI/pEVFwURgVzPd6N7ib6cQy4APNfCQ1f45ZankyEIUvc7Ct27SHxsP2lKE8NMHw8rb0sP0ovrPboXgyI3X3H8lrd1tCBNk6b1ktK3aAdTUdzOlfC+2ut+ZWaLO9hSV0Z5MNy/ggZig2iALVKmg7J9AiBg006a2s7wEM0rDuu2zsW1IfZvQpPY6/WFwYD/oQNvQULoCiOJIZQFW47RvTNDEVrhylkcQgEc7khFv5MsvV+zq+xl1kPmG7yk6U1uUvqU46tKXzn4mEERGy0kacHb3GNcPNbA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB7901.eurprd04.prod.outlook.com
 (2603:10a6:102:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:29:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 08:29:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>
Subject: RE: [PATCH V4 1/7] arm: dts: imx6qdl-sabresd: Move power supply
 property to Root Port node
Thread-Topic: [PATCH V4 1/7] arm: dts: imx6qdl-sabresd: Move power supply
 property to Root Port node
Thread-Index: AQHdCFZhui8f4Jaj1EKsTKDW3PGEYrZWomEAgAAaXsA=
Date: Tue, 30 Jun 2026 08:29:27 +0000
Message-ID:
 <VI0PR04MB121140E47C76871AA506A754E92F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-2-sherry.sun@oss.nxp.com>
 <20260630062731.3C7AA1F000E9@smtp.kernel.org>
In-Reply-To: <20260630062731.3C7AA1F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA4PR04MB7901:EE_
x-ms-office365-filtering-correlation-id: df773c80-5752-4bdb-3003-08ded681b2d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|38070700021|11063799006|18002099003|4143699003|3023799007|6133799003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 tigqwLTL03lnq3NYWVVuAm1gtI2MAaCNof48BYpMEIQGUHonj2kp/WOKkPXuOhtA19QStqOAcQr0qbaKglLwitntxL8mAzUdwH9GcJPpcy34j+XiCxa4icf9GmBnEDePVot+u4+dP7E3KFXOBVebJUCn/AgnzrpWPeKygFnNzzb0Xrd1M9yOcTvWqDPNg4+5nnM9BBmNMDoGkUeK652Ef0ULd98ud+jWhQHif3netjFI80gOtaQ9+qDSxRJQmPikTNW+YkMg7sWVIVACggwPmf5hg1hUoVVA17CbdQwURAYNIyOeYymUpXfXGZpha2LrW71LMhcCVFGBz2tgs6TU4RS3DvxZ32oJyPPncpYUQXZ29F7qBz7cN0gkuRSC6GsCBfhwDFPbyezNpb+8RaYodD+mbs0S79vtJu1DCu0ayV/9gx5w9+S19plOTAXOHTz9CxjSSf3V60hhTiV3uKKiIHZ7vx2Fr68FTVry/MjS1rssDv3LEj5p8eGiLQR5XdhN8+hQA13xbYwMjmpFT7wCssbXv8AfhPQ2KQVHApCHYTdVJRJDQLgMSYWjz24sh+jbqd3zgTM2qjAiuFmD8WtFLGp3ATtwFwPLB9AvPwdc1/6MibPFRdP2eI4B9DZfo3aQ0ReM5pTpIw7adxRMvh7gSbaRdWmCyTI+nEE+jjcb+gO7tYnHE15Mcw+qnNVdNwDkFebhYmGa3hWOqUkC5m72HOjNbmt5TZ7IVzNx7M56f2Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(38070700021)(11063799006)(18002099003)(4143699003)(3023799007)(6133799003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nTTz2jzJRcvHvjZcUPRV2Fgw0/0BWvYEs1HgKh7KemXga53qy15bUZx7PVtu?=
 =?us-ascii?Q?2yIj/siu7IxJlYTCWeHcsOy9yuPbu6T9HyJ3m8eUeDYUaS69RwlQkXr23y3N?=
 =?us-ascii?Q?RQkmHddO85yUPQ55QIasZFlnrugXaImMC/uCSL+COnwHbqCLAFXoK1TohWTb?=
 =?us-ascii?Q?YBv6rJ9zCOFo7R5xDLZIXFlEa2Kuv+bvBzqhEBhKEBzPsBMiAEyTn7k+owjN?=
 =?us-ascii?Q?Gm7U6ygMKfGmUcpEeoWTDXVQPp0FMGb9e9C7Y/pvwTkhJo9a36yJrhHmEpgC?=
 =?us-ascii?Q?JypnW3oNf3WrEYTjzakTUgM7aASOS/69B9SDk6nqDnKN4XW6G8fzL2SSw5qZ?=
 =?us-ascii?Q?fFxiIe8qBF6QmgDJ64SyKbEmBS8w1gncLQ9HkWfYaSVu/hCgrzhO32uTOX6X?=
 =?us-ascii?Q?BJwu52TJ9HOLrDIvEmNkZjccV7co+uWdRlpk8JVXbGYKyr1MA0dJXXcKZijg?=
 =?us-ascii?Q?tb/y3kBDaHoWSD0QZkdTsIq3JvMHpt8SlDKw8DfC7M/uWLBpbTx8fof5nG+9?=
 =?us-ascii?Q?Syj0mWX+kW1CFSGSywPxzzGPOQsE0b/w+x/mg5DCZZs/MJfDDP/zn94SVxaR?=
 =?us-ascii?Q?BUWRlMYimksDOVtdr5KTlq1cPFbf4jX5ngktFdAfCl7p09IyqtYgVcQnS7y2?=
 =?us-ascii?Q?kBUuJ2q3P5D5oxCDl0eTPQ1YvSZXEDCohW9MmXglRXgRA0eOxsmtw30xoWdg?=
 =?us-ascii?Q?g9wKimYhZ/3keH4ja5BOss6m9M2MojZoEawHVXez6pmLLT5gpHqT9Y3KhWyk?=
 =?us-ascii?Q?gDoj99geKIP8lf8z7LAAHxYLiU4tumC8BFzmFR8SgyNIn5fD38y1uC56fTwN?=
 =?us-ascii?Q?DbPjJ6iblUvDU7YJKSBGzLfXIQ1PMUzlE/5v27BfRVh08GNWNLK9byiFy2DE?=
 =?us-ascii?Q?eYZW8hSFN3254Gp9JbTfQaBPkoHczqCAOtdeHC6yFoBeF4/iOj0euFzvqm1O?=
 =?us-ascii?Q?aI24Oqe85u+1aijZ3QfVY0DbLi66l1zLg2v4p4NkKhl/3FZlrED1tk90HJS6?=
 =?us-ascii?Q?EnccDJF9CeOyqVBuudrsopkms6J/LyuY7oIT2Jydre7M1JOqxnijeUSoywQi?=
 =?us-ascii?Q?504qNtInRckk5rw7UAJkbvH76zP1Wcqr/PF3SM8wi+QYmziz8b4VfGG+oIPw?=
 =?us-ascii?Q?IgTIyC1Sn6gMvGV0Z3pIphvXN6SY8l92LVpdoFh7YqxpDp+8+PceO4KijBoD?=
 =?us-ascii?Q?gyjw/1eT9d+ZgiIJVVGP6XL6PmmqdXmaT7CU99eEvHNZ0sYe0jb0InVAfgrH?=
 =?us-ascii?Q?7lKSJB5mnz7F4PINNo6Tqq4VNvBna6YXXk871NvOg+vPvItwWxsBdyU+UKBS?=
 =?us-ascii?Q?0J9f0WPLxceuyeDCFKknQsaxWgTJNXQ7VTHwgrWG0C/uID0IXV4s3LMj/8Cx?=
 =?us-ascii?Q?7HFnyiNoeVBZScTs2KHTf9MFWMFlHZNE5fBFeJ8ZLtge+D5jhTQg1b4qJHrV?=
 =?us-ascii?Q?vLmlG1MpnGlj4al9mP2ObMrzZqgzx3pAuuE31CoU6aUZz0ewo9SJJCucvfrN?=
 =?us-ascii?Q?i6ZTsnKT9RHa/+TVYKeN2EpGa4Y46uoMM2gIosl+KnIodvJaRFNpcsFxTkyO?=
 =?us-ascii?Q?Imhu4Xcs9pwk3agHYJ4O9EZklnUw/zJCKvw7ksaOUq/TI8ItRVBAVL4iPne9?=
 =?us-ascii?Q?h6kWjt64iXHLZvszbwWDeqBudCmLRil0AmbqywmY3lMABv/VSFv/2G90lHqV?=
 =?us-ascii?Q?BxPm7cw7p0yGqiII1szBbex4d1bJQdQjIfmy0wI4kH3Iue7U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df773c80-5752-4bdb-3003-08ded681b2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:29:27.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/cFIdbrjalsv9eWRWFfEWpBoyD4Erz2FfpVXm/X7Rg06LtmlZkFB3Mg8Xf7aO03T1wCRaz8S1XhUfs8FpjrCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
> - [High] Removing the legacy `vpcie-supply` property breaks PCIe initiali=
zation
> on older kernels and non-pwrctrl environments.
> - [Medium] Adding `vpcie3v3-supply` to the Root Port node without
> documenting it in the binding schema causes a schema validation failure.
> --
>=20
> commit 1190644448a0f1a3780ae7b3d2a75e1606ab6017
> Author: Sherry Sun <sherry.sun@nxp.com>
> arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
>=20
> This commit moves the power supply property from the PCIe controller node
> to the Root Port child node. This change aims to support the new PCI pwrc=
trl
> framework.
>=20
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > index fe9046c03ddd6..c52b8897f9995 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > @@ -756,12 +756,12 @@ &pcie {
> >  	pinctrl-0 =3D <&pinctrl_pcie>;
> >  	/* This property is deprecated, use reset-gpios from the Root Port
> node. */
> >  	reset-gpio =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> > -	vpcie-supply =3D <&reg_pcie>;
>=20
> [Severity: High]
> Will removing the legacy vpcie-supply property break backward compatibili=
ty
> with older drivers?
>=20
> Older drivers, such as pci-imx6.c, looking for this property via
> devm_regulator_get_optional("vpcie") in the host bridge node will receive=
 an
> error code and silently skip enabling the PCIe regulator. Because the reg=
ulator
> lacks an always-on constraint, it will remain off, which can cause PCIe l=
ink
> failures on older kernels or when booting with the generic PCI power cont=
rol
> framework disabled.
>=20
> Device trees generally act as stable hardware descriptions. Can this prop=
erty
> be kept in the parent node while adding vpcie3v3-supply to the child node=
,
> since the regulator core can safely handle multiple consumers?
>=20

As documented in Documentation/devicetree/bindings/ABI.rst, "a stable
binding means that a newer kernel will not break on an older device
tree, but that doesn't mean the binding is frozen for all time." The
compatibility guarantee is one-directional: new kernels must support
old DTS files, but old kernels are not required to work with new DTS
files.

The driver already preserves the legacy fallback path for this:

    /* Legacy regulator handling for DT backward compatibility. */
    if (imx_pcie->vpcie) {
        ret =3D regulator_enable(imx_pcie->vpcie);
        ...
    }

So a new kernel running with an old DTS that still has vpcie-supply on
the controller node will continue to work correctly.

Users are not expected to pair a new DTS with an old kernel. Doing so
would break in many other ways beyond this single property.=20

> >  	status =3D "okay";
> >  };
> >
> >  &pcie_port0 {
> >  	reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> > +	vpcie3v3-supply =3D <&reg_pcie>;
>=20
> [Severity: Medium]
> Could adding vpcie3v3-supply here without documenting it in the binding
> schema cause a schema validation failure?
>=20
> The pcie@0 node definition in the fsl,imx6q-pcie.yaml binding schema uses
> "unevaluatedProperties: false", meaning all properties must be explicitly
> documented. Since vpcie3v3-supply is not documented in that file or in th=
e
> core PCI schemas, the schema validator will likely reject it.

vpcie3v3-supply is documented in dt-schema:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/=
pci-bus-common.yaml

Best Regards
Sherry
