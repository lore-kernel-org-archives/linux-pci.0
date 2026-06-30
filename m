Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920128DC4;
	Tue, 30 Jun 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809045; cv=fail; b=cVrYzf8e+vsGtTljviJ5D+1sTAKWhWwYTkpBh4YFhpzrs6h93wFvHDr6dpLJ7cb+Bz+FSKrGliIWrQK7/0pAWxVlcP5O7286DdV1kXRKjpg+cUohIQlEdgSGyw1XMyK8k6L76bUzj9pzCI0MAW9RNHIrYalQcJxRkvwJa3UOY20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809045; c=relaxed/simple;
	bh=Ti6hKpGdQW9veoCcDha6F4ZhyE+vRkZf1l3giJfkv9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d40gdqjz6Cur0NuAcKE4bE44BDgARD8xjec/FaywymnZ9F3cTF+MgaFPmKrg5cQzx2Z9tVtA5Lxx/iMKnLG078AwkHDnkmDkWkQy2OPaHGvGuYqNVh3pR86KsWSiP7F7Y2r8npTE3m0oCt1mgrDdAUkSORZc1kQkcIOb2RUDVSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxlA/3pa; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxlA/3pa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX9FV4tBnCF3G8yYN3ssKlbjbU1tTvh+RfY0K7ntEhDaPr4n8inxPhQd5xxF98BsGJ3d9bIVZ69NWtg2yCaHcbH3LqYbivHdNIN9to8BuUETeT8A004VKxUemm2fd8IHD0OOB1cfYoM+sSGL72zKa+7kTLt3U8P2X3lvaQhwi6n0rvuYv/QymzT0hE05bRUuARPZ2H1fb5FNccM1wmY/Hl19NYra5xm0FY2IKpPEu6yRS6H5ZWtxxNuCM4CL9mt/Nj0aRmM1p5tvIyA/4HrTsDr4Rg9XI9eSqcNOl6yeMiM1qeXxK1SbqZ4FwPkVgmoX8dwEbN6cGh08k2pl7Y3KoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRKQS8/Fx2uVVqpGYRF40J06jLAmTHUi4bRmP3XHW+M=;
 b=DvbxpcAkr5okvkWBQ0XXl9QsPk8e3j5LSZCDt7m5D4ZXUCLuXCBL1979hWWYKRRn1QLTi7SCnFaU4+BpPh2j5ACgipgYhfihRKPb84SR2pfJgalWlGUEOZS0vN0bADdbNPJbrEdDTx7+naOzQIHahfzMG8eyNNjbMNBCWJ6Eh0i+RKlRbkaRPjzMAzO+ZvM/QN/2K5WWIYWUqiJ3URGX4JkvwgvOrEMsu+t63TU/NMFCeAPUdgllHN3n3df7A3faT6zAxdSvbA/trmkQ/7dwTHkdR4xzQvwBtc+18UGX4NBncbb/VM9eD8BmZ2MWONlk3EW0fop2juv3L2jWJpE2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRKQS8/Fx2uVVqpGYRF40J06jLAmTHUi4bRmP3XHW+M=;
 b=kxlA/3pawxsZOxRW/eTVNT+MlLsa4koEyT4OFHZkAIUdohO+mNXNmhKoQK0i2Ai78eMlgNSkzMa8Jq0wQBCEiiTjeMEoFyBaQuRYa4kXNQk4dy956RR1mUe+3ymGtCWXxVCofYeWm3db8gj4pBmTG7YeQzQ5/SQY09vHXcyddx88P15Wav6H0ZIIJCev/D/kicL1c5tRHSM6CYGIO5mxlsVejn95PzW++AHHBVdr7/xHu7/joznvFAHZvh6DD4/jpKF0IiBDExvml8wsEWGPgvR1/IHW0TJx+pGso+yur+sCWp+gg9TmTVpsMdQQUpO6j6+wbpYCHlXuaH4qLAVnzQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VE1PR04MB7263.eurprd04.prod.outlook.com
 (2603:10a6:800:1af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:44:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 08:44:00 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V4 7/7] arm64: dts: imx95: Move power supply properties to
 Root Port node
Thread-Topic: [PATCH V4 7/7] arm64: dts: imx95: Move power supply properties
 to Root Port node
Thread-Index: AQHdCFZ60lQv9beb0E+3/dbCJIY8NLZWoVeAgAAmhkA=
Date: Tue, 30 Jun 2026 08:44:00 +0000
Message-ID:
 <VI0PR04MB12114892687F49EA79DF376C092F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-8-sherry.sun@oss.nxp.com>
 <20260630062347.7FE471F000E9@smtp.kernel.org>
In-Reply-To: <20260630062347.7FE471F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VE1PR04MB7263:EE_
x-ms-office365-filtering-correlation-id: dd62fe0b-b785-4044-235e-08ded683bb35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|23010399003|6133799003|18002099003|4143699003|11063799006|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 Nu1OrIU0/6ZyYPEEDw4FSA4bC3FDhQNjKIjaEWOd0sRd4Urgua+90PrxsdpQlnn8dnyRPgrk0EHxiI6lffCCYrFCIeqNrDaV2rWQ8bc5Pjmbkg0AdzQoN4NiM2kGDVm6hSH2OQmme6RWRKiyOtkFX/jh3dkfE0U45ETsh5gBPsD3EfYHF8odKPwxKAcg3xFJjdE24eQWTd8RNBhJuVmTdfp0PyC5wmGNdf1goMM2wWxOwqMdLQr44RkJhSoRfXeawiPyc5ngMkfDVp5Fu5EuPoZp25FaAlcMwlgW9HRQcozc/imdWGEmgi/lH8YCMFCNR6aGa9K4CS4znffvPaZ+Qag1ABo0NM9NZBA/p6mYatJneIi+3Hra4lQzIAuGENGYQuwaQEt//O42voXxz46MmGxjjIvjv+d6xu52zNTLfcrRINWigSn40KTI9MJ6s5tIC9VG5pYNk6RkwmNj9Tmzc7PQvYg6HyBp1MzTcuiFN/kcOL8H8q+dIVVvsY7K3TZO7fA305KwermNaB89CfLBwRFG2FlRSSWbKjKCQCWyghhQiIzddpj5GD6tp//9M9Wxds0qq5obhKZJt34XJD8XU83GRdngFyVoMVe27p5ShGyu/dicvRtvPPUr6CqoVVqusfwjcn1S2iS74J352qCSBeKgKMbPfXKuTPktFLi+p1RlA/YsXf6oKZi/edl6p4RmuvmUzbB4KjMUpDN4pn5vkvbhF/l6XAQxTzREtBzJogw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(6133799003)(18002099003)(4143699003)(11063799006)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mt3tjmXGUpY1yA5iPj4I7J+48FmimfMAl9Fjyq0bkGm88kFIQEen0p6z8ynR?=
 =?us-ascii?Q?K0bBSbKPfNJvTClI5d3+aL5SiYFy1BdjNznv2S4EKwGh57KKylWDcp4hJDjJ?=
 =?us-ascii?Q?9Fkwv/A8lZ7lLVIGCpTkOYxcoj6Q7QeAGkPRYcq7l5pnumAU9Bw6tweP4nbO?=
 =?us-ascii?Q?DYJcNSVikw9SMKcUAZLyqnOHt6SOqEh7ttIbLUvpanCa0htf3K5MaAFsesyc?=
 =?us-ascii?Q?tiDEiQFm7CoBIC0VPw4QoQNb8uivDICEDUUDbGbIm67ryIjnlhLWqCdtui8E?=
 =?us-ascii?Q?VPhziPnTcWZbTd86NGtzghDo7NOqNmzSI09caXWQJ7VVEX+OsTnU6JDV/lya?=
 =?us-ascii?Q?PW7LdZu+RaELn4lurLMu9d78EswV47zecQjp5vhGDT0bmTXDFlXB7fQb4zly?=
 =?us-ascii?Q?lZ2Y3K02EbH2VNqg2QiJ1iBuxXXyjkuTk98yJQZC+25Y40KiWuYLNC5msYuX?=
 =?us-ascii?Q?aSrTUraybTHKAmDE3C2yA8zY3CQzTmaQiwZfAr4n7/NmLtMQODZ/jUYYJsmE?=
 =?us-ascii?Q?NJIaVMoaMonL9E8rbxa8U5T88E5e81mlP5HK8xu9/O9tLoBs+aqX320zOUL9?=
 =?us-ascii?Q?JDk5pLHVRBnDDvlBITdsjM6Tob8DsEQ9ikwxezS90BosP17kOUaN2pWY9Dqz?=
 =?us-ascii?Q?SyQA13GGOJ5qnkRj952Mbm1GKxuYg1UbCHoUHLbCbwAthpdczDwMq/6f0arP?=
 =?us-ascii?Q?yUcXoa0lAea80xOyDq/Yo5lHPd/kxg88MJffpBhd6iNt/wjRwjkf+8tWmTuE?=
 =?us-ascii?Q?2J8v4Wt4YAdBh/OejsSmQy++o3alDVB6BZJaHmH46bgnvsRgWAh+0wL9S4p/?=
 =?us-ascii?Q?ASacHO952aa/Sph10kxu7uCMOQc5ZFfdU171DK56zemNBC5Eua2NyRKjMbmK?=
 =?us-ascii?Q?IQnszf0Jf77ilXF9sgegffwzFzRXdmCBp6CcRat3ZkTElKQlgbvQxqAqBCts?=
 =?us-ascii?Q?pBXqvXglugRHGtS3531h3dAf93QhrSV4aYyjd8uGxHcyg2y2V/b7RZXyHXnT?=
 =?us-ascii?Q?V2l5db1HAPaeLpUlB6kuQ1UuvzL8qkWcHxspjbYjxS2cIqkd1NaRLVeqElAG?=
 =?us-ascii?Q?v4SXoERgLQuN0UqSrPDoClmPeuKJcK9pL99s0ORchkn93tX3Y+hWKCAdiLMk?=
 =?us-ascii?Q?RW9Mr9C181wn1hnzep64zyLXv67cdhzpCihfSrHFIafTaeTjyDeYhxlfAJlP?=
 =?us-ascii?Q?eJ4kurCHdIaPBXaQ9HUIOUgPaOckLB2AiAiknp6pkHoGi9WQYUq/poGXqGk+?=
 =?us-ascii?Q?R7oaVpBmemPZr7fc+bcCAxUWBTj7Ksy7eC6aH38LZr/eu17m2SzSITThWNCp?=
 =?us-ascii?Q?2VD4E0OBKQjAPL42+rH1MkbRbVJB8oAKpsDHI6ieRahV3OZ8ctwGEFGaKVuK?=
 =?us-ascii?Q?F6mCACb6rBW1GMyNNdr1jkjdlXPXczjuZjTKWxGxPZ/9fLwanDOM/Ik87jip?=
 =?us-ascii?Q?5LQOaVZaXXjzz7kO0CNf37lGqm5laA/w00gv2ATTG1/ZRZF0VwtyLlvs6RX0?=
 =?us-ascii?Q?INrtesKNwsbRqDcCbGqKui1vW9WqI2Dl17r/mPKGONajbkdIIbM0ORanXhFF?=
 =?us-ascii?Q?N1CYl+6GLejBPYxSJFkn6mQVbgT9nqqRO7+Q5fRlaUxbxnwnk7WH6yLUA4Da?=
 =?us-ascii?Q?XkwZ5zakbp5VouqECA6128yk+aD/XyYK0teL7MLZHIhNaqOp2n732++2dTVM?=
 =?us-ascii?Q?FceJ1ztUTfmLzjvayyQyxo5UfHYf4A8cjekPW4Uspy2yn0bJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd62fe0b-b785-4044-235e-08ded683bb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:44:00.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERSwt0lrJhMqZnG29stOXkvj6d2ENjvY48pLY4XBpBcmhbJ3i6CrK9sewIXpDHoFGSuLbQTWgU5GZELfNqCkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7263

> Subject: Re: [PATCH V4 7/7] arm64: dts: imx95: Move power supply properti=
es
> to Root Port node
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [High] Removing legacy power supply properties from the PCIe controller
> nodes breaks backwards compatibility for older kernels booting with the
> updated Device Tree.
> --
>=20
> commit 332f451afbc5374b9f81acdbad51ee15f1b90088
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> arm64: dts: imx95: Move power supply properties to Root Port node
>=20
> This commit moves power supply properties from the PCIe controller nodes
> to the Root Port child nodes. This change is made to support the new PCI
> pwrctrl framework.
>=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > index 7d820a0f80b22..6aedcbbe915a5 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > @@ -555,8 +555,6 @@ &pcie0 {
> >  	pinctrl-names =3D "default";
> >  	/* This property is deprecated, use reset-gpios from the Root Port
> node. */
> >  	reset-gpio =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> > -	vpcie-supply =3D <&reg_m2_pwr>;
> > -	vpcie3v3aux-supply =3D <&reg_m2_pwr>;
>=20
> [Severity: High]
> Does removing these legacy power supply properties break backwards
> compatibility for older kernels booting with this updated Device Tree?
>=20
> Since older kernels lack the pwrctrl framework to handle the new Root Por=
t
> properties, they rely on finding vpcie-supply and vpcie3v3aux-supply in t=
he
> PCIe host node. Without them, the legacy pci-imx6 driver silently skips
> enabling the power regulators, and PCIe initialization will fail because =
the slot
> remains unpowered.
>=20
> The reset-gpio property was intentionally left to preserve backward
> compatibility, but removing the power supplies appears to defeat that eff=
ort.
> Keeping the legacy regulator properties (even if marked as
> deprecated) should be safe, as the kernel regulator framework uses refere=
nce
> counting and allows both the legacy driver and the new pwrctrl framework =
to
> concurrently enable the same regulator without conflict.

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
would break in many other ways beyond this single property.

The reset-gpio property was kept to avoid build break if pci patch and
dts patch are not merged together, this deprecated reset-gpio property
will be removed later.

Best Regards
Sherry
