Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA71DE8BB;
	Tue, 30 Jun 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808698; cv=fail; b=p6ogOEslg9fLUq8zlpFAWKd0AsmJFT0zVB9XCKgxCyWIguF7R8LA4XVTcgYWRuqftGuwcKGhLrfIGskLz66RVm1cvzK5yVfrkBElYNK5XHhHwP0sEgyWHmUge6NGMmO8gQbjGaEisnOtSHKJ8y1Mej4stcllZ3Czdm9k+wRkHmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808698; c=relaxed/simple;
	bh=nkArP9h09Y/kuq/isXXrNMYh6xqPOpnNwvLoQhKDG0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HIETk3AeVP3/uCBdXazV1OoYFwrhon/PgjpCusSnFMuqYauN9kBHPGQtO9rBsvfTO6spj3dk8gE8jNGCjMtpihvRLHmWmXtRaQmndsIzB+5OydG5PnCAfhsEs1bZFD5MdIL9NEqN0KKwwb81FJWnQx1Tq/YPI5Ep4oe1oh0GMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gus5iD6W; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gus5iD6W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTFIO6kA8r2MmuRRlB5PCBHnJUGT0iSCZyIx6Z6iThYAyaBIZNHgMHvlc87CGtmfn55gm8sEcC+gabJaCOXCy0kQjMSaskBEU35z6Gb246ZPQ/en8mOyGTEZRmKqVIj/HTSFIOWZAr/ogw1oYXjwT4vIjm0WQjywly3mrNAwAd1nPIu1sPS1Nzxy4XMKiJf+HxfwbvGPUvESpTLzGAWhXHmpSYX1WoqO+fwHXvPpQ6W/zCwcn0qIYH1266Xllx8GgbyH1WyGesuI/vTBRwsOI2QkZInY33af1QhUIN65IVYcb226TP8QmAJT/rVVv5KWACV6FEvKoUfpkL3TikEXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFDOXWKqYtwHlQUVwk0Gm/0C/WBfS5VWShQ1/l9nCHU=;
 b=Qo5oHJ71xlj8ytwnCGFzNZJ+NLEwTixfrmGnsR9C13h7yicDyvd38c+O+z1GSTl76xm2ew2eF7KD3Soi+ohUCEK33bDMahTqa5cqnSs7uGbhSpyj31sm/e8e6XDHBtEeyssGHf2oqH36V29EtvpdwNNVkW0wFbpUmVRmSbpn4oZk3E4Aw/8q7F4o61lA73okKqEcl+TT3g3Z7lmBNC0zZV90fHCwB2MI71AsHncrj8ffU56Itb+ORs/8lbK4m4TfnuDofaQfbd36q7dyCq2rXCvNzT4/DVgSi/TDELA1t8c5co0KK9XLFQ9am1tNuPFa3ls23A9nFlpFYDEWUxzfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFDOXWKqYtwHlQUVwk0Gm/0C/WBfS5VWShQ1/l9nCHU=;
 b=gus5iD6WmyUu4EkVUAD/xTOkpGPBo2CdBm6GroU2YIzYmjbO1AMLx8V93kWlxll1LjQP0BGTxnwYkQdRfHoATDUKrYfppIOYVk11+w0Sz39vSSWokP3LV/+DQcgiAACbfZsdK4sfKaqtSUSJpEfn7CTsPHHUi9QAZOyhRJSjcKcXcjl10wnPMDrdgJqmukt4vOEgnqUXJCdPxv/PrmfMj5LGXrDPI/0BEVxo/mEubghI9lUlr9jELH2rho57V5bT7qxEHsaG/kdd+muNTtcOeBqlUtTClo85YH9W1l7Y4je3pYQGeKrRATrOvU6btoRKFSlwhztagiNuv3/8sojLwA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10581.eurprd04.prod.outlook.com
 (2603:10a6:150:20e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:38:13 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 08:38:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>
Subject: RE: [PATCH V4 6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply
 properties to Root Port node
Thread-Topic: [PATCH V4 6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply
 properties to Root Port node
Thread-Index: AQHdCFZ1N2DWivIzaEiwkxIWzKZ2Y7ZWoXAAgAAkbVA=
Date: Tue, 30 Jun 2026 08:38:13 +0000
Message-ID:
 <VI0PR04MB12114AF02BB653E6C3BEC9ADF92F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-7-sherry.sun@oss.nxp.com>
 <20260630062408.683A71F000E9@smtp.kernel.org>
In-Reply-To: <20260630062408.683A71F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV1PR04MB10581:EE_
x-ms-office365-filtering-correlation-id: b7c07d9c-29f5-442f-a62d-08ded682ec6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|19092799006|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 cRVFijn27+ObrqLPxcGvTdQAjp1dMewN4SJ0GkZtd6csi0AcTw7emIkKUCsEB+qZRNfhJjthU8tEwY92jy2gGoU55h1anZAkWrGtD1K3uxbnM1EILsvZVI129Efj/6XT45sG77R/Xi+qlAlUFs9cP6oVx+gZVr34JQpsPRmJI15zTv1LqKPsQv5+ri5YG8QGoY5pVZ5jK4RsqIlg0W7jCUhbuAN+6EPLljQnBpNnTQOs7AiZ8Y0hEYCRghk8N5fgN8Qcsjs5HLx35U8BvSFWAxBHH/PBHDwAqw29D5C7WBPiypEwUd0rZlHtuQzrYISAgY1Q6F0tqNG6TvNsPW9Eu1b1D2Z/h4p9J37W61hjVgVnVWocfz/ewitwzXLdrxV/ZYKAydzrBoT/bdNwLOGdnpIMJuCz/SSQ+m1wYiCu8Od0kxD9oVUOsR3ePpsfNQlKW29weE7kIwnW6H4ZAnLYwHqn4/6XUqWddo124Qu5zmYSqLQYkvSxy/dRFiWTSo0AwopKP4ZUYT1KHM8PthzCkdIhFuT28yT1Lou8GJwEpspaBD5P9+knttzX5fIsduJJVmSqh/k+J8WjC/b+mr0ZVvgOxu9YIe7KSZimyndMUPI1gkPEythQPpkpjG37izjouRd/viOlZC6L9xdebacFDEradPZJX3BponkJmfN8nbRfIpA9bm/dgQS0183rVEF9yw8kJqF2cN97r/UlMG7lg72pkaZ00jgZb5vmDrLVmbc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(19092799006)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GaNFPYQzCMLDZH37ESO6lnqkE8WMSUf3sZLpHctb5MP5G6UmK+PtRPrc0SCF?=
 =?us-ascii?Q?IMLORgWws0HIYfLF05lz/aa2xOqAFoz77AJt/sA6ZmVUqfoJLmkDr9feNVv8?=
 =?us-ascii?Q?y8tFz9qcUe6mOva7qZZuWpXEJe99+0AUt6U+H9BQ5ItM0vbYMf9HeQEnGwi4?=
 =?us-ascii?Q?S0Iexmb7Kqfc95VqYPIGFByss5FViPz13DsL3h+rY+fMMSDo4/xGnpxhjdyT?=
 =?us-ascii?Q?M8w48C6eX0u2iiLhfSA2n6QD/BMUPZXaH6Th7v5mB7VkMUQrN3ICMQNdvICo?=
 =?us-ascii?Q?EKZ/f35xN0tWMr2GlVlcKiDr8GVEFWrmnubsejM7LtFSxNrsct5h4hpwfgq0?=
 =?us-ascii?Q?w8i9EvzTHnRipmKIGyf+uncLgDrvD4gHew/emv+wQzHSJJhY0U6dv2QaqE9B?=
 =?us-ascii?Q?zhAl/kbMwLJPRldJ71+uDYPxaboyHPCx+LDYd9JytM8yLsMmBdTRai5lls8Y?=
 =?us-ascii?Q?iv7vl6dipjq19mzZ44z9f/tAc8aUu0lb0lRu0n/JGacZRiYKrGYsSbR5wwZ2?=
 =?us-ascii?Q?Y3WgMaBlIs1wu6R0u++shqC0wZTQwcv+gkyRVaWDEcmmf5BxbZQTvN+C8Jl/?=
 =?us-ascii?Q?2jG86XQ9WISK5+LjT1xyeiu810ibGqihJSyoFnfi3nx4n2KQ/zeZPJN65nkq?=
 =?us-ascii?Q?zLHPRlEL+koxR6U2HPnVXqc8U3oJpToZIN0aPMY8eYbivmPtq5azvIACtO1Q?=
 =?us-ascii?Q?mnlWkgKs3XHL1jeuAAHMt7AgoJz82Z+vaxj83ihOy9CpoTzgVW/DTFqmIAVJ?=
 =?us-ascii?Q?hJJyPBfN9SiaNSdeFJfS/a4mDggTviNYtf4i0Jy1uIPhbyRZJJMw3ShxiP8K?=
 =?us-ascii?Q?ldgH153uJWcRkAc+1/oKVB6jeaYkaAH9B5diEzxcSbD/LUbmziSIAco+HKl7?=
 =?us-ascii?Q?Y+X8ew8synWERDobITfNfHJmrRZa7dbEcdK6WkUjFHftxAgXwZQNKFE23u7S?=
 =?us-ascii?Q?C/WOfVjl7E9T+gW2v0EkPHkJnLYU84wJbDJn+7yjET1FICP+mSK01eaZuUmF?=
 =?us-ascii?Q?rcUc+ReWRmQxHQWWK/AVCBr+E5UXQrS8owVcccgk3I3s/5E6aMSHQk5UwTZ3?=
 =?us-ascii?Q?oUBhndwPiqFAK9YlJPZbzX1HJVu5B+3nzIesl6haqb2BU8En36p4pUndeyRF?=
 =?us-ascii?Q?Om2siX3Lehj2UOJLd/HdGPGRxEL9aS2h4xrTUG5aulPHUxopxnKq4QVDzVwP?=
 =?us-ascii?Q?OqIMK2niTEd16lfMEHpz/i11LZHwfLlOpLpspEcEzDMOj/YHyNKxiUn9t19l?=
 =?us-ascii?Q?H63h8qXCucxsw6+4sB1Ug8WaPvUcr0AKyGemKM3XLocenH3whxvjXTO2/KOU?=
 =?us-ascii?Q?n42B6EQTvK2Xasn7Ukt27ee0w6JF5MP9h14PIBnsp4qMNT/8nPEMYmANHJD0?=
 =?us-ascii?Q?SOUnCiCt/6zhojnDuGxSR6obmP8WrrTop+dS7dk8ohNy/RMFXgMPTt+S2FG2?=
 =?us-ascii?Q?gSd8vB/B0rt3OlNHFp/s0VuyAlIPnmhAgfuo+TU5IaqlMgyxqhjvBi6QLKju?=
 =?us-ascii?Q?93b7bNAe4iPRoac1Ip+FEj88C03Ze3phDur+kJjQg6zyuUx86FosUTBDVhPM?=
 =?us-ascii?Q?6AD433pUlg+dHWF/KRuGz/rWyjpoitvWvfbv8ZwdaOkR1boIfomCcoPZduH+?=
 =?us-ascii?Q?QPKBkN0Hoac9A4MTxpFZ/ZQfjE33FEpA7L5dX+1MEgS5DIxHKag4oeZ82o4C?=
 =?us-ascii?Q?saGOp42oXEjlUIdL7EesFP5pWD3znDrgT0l8osUgt+tfxfdu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c07d9c-29f5-442f-a62d-08ded682ec6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:38:13.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy1kRqF8wOVFmoa1k1quiLGhgks/zbcIQKDYIp0d2ALFqdbiUT/QL+z9ecknOZhb6NHM/1m5Zks2O7X8NRdV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10581

> Subject: Re: [PATCH V4 6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply
> properties to Root Port node
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
> - [High] Moving `vpcie3v3aux-supply` to the Root Port node delegates its
> lifecycle to the generic `pci-pwrctrl` framework, causing auxiliary power=
 to be
> disabled during system suspend, breaking Wake-on-PCIe.
> - [High] Removal of `vpcie-supply` and `vpcie3v3aux-supply` from the host
> node breaks Devicetree forward compatibility for older kernels.
> --
>=20
> commit 5e5016406a44aded0d05f19605180a501f38ea48
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
> node
>=20
> This commit moves the power supply properties from the PCIe controller
> nodes to the Root Port child nodes to support the new PCI pwrctrl
> framework.
>=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > index 78e8d41e67916..59d9fe687aaf0 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> > @@ -677,8 +677,6 @@ &pcie0 {
> >  	pinctrl-names =3D "default";
> >  	/* This property is deprecated, use reset-gpios from the Root Port
> node. */
> >  	reset-gpio =3D <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> > -	vpcie-supply =3D <&reg_pcieb>;
> > -	vpcie3v3aux-supply =3D <&reg_pcieb>;
>=20
> [Severity: High]
> Will removing these properties break Devicetree forward compatibility for
> older kernels?
>=20
> Older kernels lacking the new pci-pwrctrl framework rely on finding the v=
pcie-
> supply property in the host controller node to power the PCIe physical sl=
ots.
> Because these regulators are not marked regulator-always-on, older kernel=
s
> might fail to enable them, resulting in unpowered slots and complete devi=
ce
> enumeration failure.
>=20
> Could these properties be kept in the host node as deprecated fallbacks,
> similar to how reset-gpio is handled here? The kernel regulator framework
> uses reference counting, which should safely handle multiple driver
> consumers.

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

>=20
> >  	status =3D "okay";
> >  };
> >
> > @@ -692,6 +690,8 @@ &pcie0_ep {
> >
> >  &pcieb_port0 {
> >  	reset-gpios =3D <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> > +	vpcie3v3-supply =3D <&reg_pcieb>;
> > +	vpcie3v3aux-supply =3D <&reg_pcieb>;
>=20
> [Severity: High]
> Does moving vpcie3v3aux-supply to the Root Port node break Wake-on-PCIe
> during system suspend?
>=20
> By delegating the lifecycle to the generic pci-pwrctrl framework, the reg=
ulator
> might be turned off during suspend. Looking at the pci-imx6.c driver, dur=
ing
> system suspend dw_pcie_suspend_noirq() delegates to the host controller's
> deinit callback imx_pcie_host_exit().
>=20
> This unconditionally calls pci_pwrctrl_power_off_devices(pci->dev) withou=
t
> checking pci->pp.skip_pwrctrl_off, unlike other DWC drivers like pcie-qco=
m.
>=20
> If the pci-pwrctrl framework takes ownership and turns the regulator off,=
 it
> would violate the PCIe hardware requirement to maintain Vaux for Wake-on-
> PCIe (PME from D3cold). Can we ensure the auxiliary supply remains active
> during suspend events?

This has been handled in this patch: https://lore.kernel.org/all/2026062602=
3126.2189931-2-sherry.sun@oss.nxp.com/

Best Regards
Sherry
