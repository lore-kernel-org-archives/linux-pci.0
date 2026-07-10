Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621913F165C;
	Fri, 10 Jul 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676200; cv=fail; b=UwYoETa+D+VXZ5h0LX4Q1bE1VNwLxSz8gaLMJLFtq4IFCIfTgPjIw38u55Ic6ca1WMz/rEFbjTzuLJ6NG+3cXyI0n82y31k00FR75nXXVYLlh7dy1gzel3fd4b46x4EnugPvvwPsLv+wF5ZbwuRJcvB4ysrAJiZg+fpmeOtoCQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676200; c=relaxed/simple;
	bh=cgH7SZVNy7EuuW1je4WMVKXWZur88jfsB5NNPlFSBaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsRNAxsBpUMXJNotlShk7g8rDJSjpi8v1ysohtDxGREY+TKZqTh2Sp6rGlYY1XzchWWHEa+3IlUQdmOgGYY5W6qOH8QkBW1qbxdbsQSi71z0N1603hvs59BoaFtPLv33te7XhAOV/LIEB4AwtAL8Tw46IUaxAJ+fMs20D034j+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nbix4Gdg; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nbix4Gdg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c633a4cP4oPDTpya8OhBSfQJKxQTzqabPxC3mU4tp0P3nDcHpAKXlt999+JcBnnqlZgK6fwE3LX7Y9VL5AYr6S8Gbc4kLIM4LuOAv5oIDNzaOJ1IjUXvcCbeTSDczkXp194g5MjAvXS10H3L/Bj6ls/2fWdgexdxASPJSyBdi2N6nJ3HXCk/x7VSoXQ5MPKOpGMYemy8ktZFYDWd1MvL9olH3PEwMLJaEQLOWeG4T68dmhsyHUhZfdHAxhgQdBTsnjo2OO1Xzwymzi2RB7QXeTr7NWbUfSapUvDCMu5Z3ZxFV/n1/4lZzSt9gCljgd1JjJI7HJgGnDW4X2ePUUmJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed4FQzbr4K8JYdnm5mEQLDJ9MYPRFnt6TDhmb9OiYTE=;
 b=dxszXYELZfqGix27VHVjvhm0bA30BeIezUvMIdFUGvpkb9ct43iMRbUYE4SvQSDyzKoiMxLG3ZX9OGZ2J5/SVhmvDmmBR4Xzur6YfEdS6dCLhXmbkIhZJC3+AiqYVEEmyW/TlCyUFYPxbm+vk3FJn5alGfpgVhQm47xr0MmlOFoed230VDACgWzJHVxjXhw35GJ4DK2F0CIC2ytlqR47MeP1DCyzr0ksi9Rywu/aeL2ehNfeXuMLXcHO1Bh0kQC05d6fcTmUU6pAr6yd5TTKhiwkZPvqfuJshWz5FhkOV9Akw3Pf8sIIXC5qpywr6r9o+roO82nYd4V8WZwxzuu7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed4FQzbr4K8JYdnm5mEQLDJ9MYPRFnt6TDhmb9OiYTE=;
 b=nbix4GdgNWlKqvjZUzDD8aibxfa7RWGELZjqzUgwLtbfptAqSnBfyP/7h/mzS/UU7kIKSr+KNokdsn0BJ5Njp7Iv52kDUW7KKEGYKAkSdGS3tFsPNTLevwGzvGnXEAnz3YztRlgXNwYDcqjrr514dj5lmVvJMxrixPtrcTNfb9H1Z10JxAvH3kh2tRCWWMKH7YquExfp2inBjO0xLBAKQudfaZvvUynJ3d1eOPJUXheAF1uvcV3LrxSNT1PLtDR7FyXGH9vu0W9IF+xh4tomjgBR4a2vSgMcqbeJ3uxRPiLa5D6kGbEVLIDTud/88hP8MLpmry3sJuy2SofalxJ8NQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10422.eurprd04.prod.outlook.com
 (2603:10a6:102:417::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 09:36:31 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 09:36:31 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
Subject: RE: [PATCH V5 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Topic: [PATCH V5 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Index: AQHdD4uoyHnYTS/QOki32mrTeXWU4LZlA9iAgAF78eA=
Date: Fri, 10 Jul 2026 09:36:31 +0000
Message-ID:
 <VI0PR04MB1211416C8132C947807E26DFC92FD2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-4-sherry.sun@oss.nxp.com>
 <20260709105535.793EF1F000E9@smtp.kernel.org>
In-Reply-To: <20260709105535.793EF1F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|PA2PR04MB10422:EE_
x-ms-office365-filtering-correlation-id: c4a2bea4-5cdd-46bc-9472-08dede66b9a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|6133799003|38070700021|18002099003|22082099003|4133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 9COiiV+FEB1Cmhz0FSf9nimYRsjmf3Dm1rNvrkzmfbt4QtLh+R7M+g15otwyiV3L9JDwJ0fhFOqu5Y0NBRilYBLIPLamdy/amJQI7vggUwH9Rsx7mO7qHaTmu2AL1zBWwtUo+I5NvJOGdRrTJsSXkI4Px+EUxghO0ZsO6N1s5jpYgi1tDMmx49zaWeUycWAgqsgNaJwhP8SWxxSVQWShUnmkD5fcL2iOb7fkg+WlKtr5Tlu+0/gWmtCMDihokXP6f8UanZpBHbEz98IlTkpQR27+tVdZFWODEf60M+DZaS8pXWuElfbaIk9mos/z7OzXaUs9bHJWmpC/hUQ8Evi0YtZ6SDAaHJm+MSx0Gxu9+5xYF+6L+yAnl1Oxhd59SXy4gvmQf7fE3uwRTKmhMlAagJXlJvwOS2Ybz84DBXfW+H/dd/1mMOJuSNxkHHCvCYmaNE0x62MY9hFgdgLz6JH5rrHdPHQlWbHiIXfhZSN7xtt56OU0q1TYMwZM23ZdrJUwD2hJLBZEB/WEa+OSTpz9GMYZp2yzbc7p9YuQqa/aUEJYb+wz6W5VCv4/xiP02/slM8RmBfVT577J5wL1krj3V1x9QXPTBh+AkU6QUdiBUE8I61ctDdnyKXng8GJwfcxbGc8p2nkRa0sMZAtZ00XevACQ9ud3ju6KXK5l2ufXK6c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(38070700021)(18002099003)(22082099003)(4133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C30OjIqGi2QoLrWX5lBCQOXAQkxSYUFxSHkwf8oGLOD1+WkbjqzcgB+YUOtl?=
 =?us-ascii?Q?UYHSp8mEbaCy8n8U40apenVFkKBkC0G0VKjsK2m4/CW2MdgNOyJ1215DjvP7?=
 =?us-ascii?Q?9J9UXdluGyUfRA6ncL107K3/3cii/EVZJMfqXx4C6B6BTcvJWWzzy5K5YlL3?=
 =?us-ascii?Q?g+xBHPLNRXHHo+06kpmYndjdfUnZDhwubLWga5f9862+bGhDrP0/Zuo6wvO8?=
 =?us-ascii?Q?8SXGByeXjP1ZOMxpuEoHg/eJUxD8vHcKgX3RzqI9+acq3lErf22am5/iDNjV?=
 =?us-ascii?Q?cSs8+67qKe0I+4UcePHTw5tI4b7vmu1sLdCZxdMd5dfIG4VE5nqptcveGBkR?=
 =?us-ascii?Q?ofrFNyvKXjVIjQtlmzrLyRrMOBEr1uek2BRDoTJ/t78cxGe5Af1CYR2DVVL5?=
 =?us-ascii?Q?Rqh/V54q6/TL4j5iAAo8dMKFNFdwJd3b/iuGU0GqlacVcWpY8eNb2v6d59XU?=
 =?us-ascii?Q?c3RqKpemiYp+eaHHqDNPkBXfrFSklSY59B6ztOAKtyxKbazSC9VNpa/5AUMr?=
 =?us-ascii?Q?3vU8t9K2EzV3KkwBBrJjUkq1gi+kVTv70wwB7G7ENjBVK6PmUFdOaJIaUoVp?=
 =?us-ascii?Q?Cgxuxqf9Lqv/CZhb8X5+OwggpYQHEYNjS59OpFW+BwUQD9sJv84EDQWEMvaE?=
 =?us-ascii?Q?kqQqYfGckUUSVeTKhO5mfVYeEk9uIHAb3VUwU4lXJFPA4at9Fu3YJvK/lVWP?=
 =?us-ascii?Q?BxFp99+MD1lrao9ERhryDfJGL7FIAg/tv9GWqz+sXwUwPuYrXFXPMozz8Jjv?=
 =?us-ascii?Q?qJM4oD6RkTzXze8qtYByQ2ptvfM/VCDAiiRRjzKvpSoDzQKI8xtxtUwo6Res?=
 =?us-ascii?Q?g0ms4U1IgmbooR+Kx2B5S9AeSV/Dg1zHCsqvNbsDwhCRw41Envp+11Xovbpb?=
 =?us-ascii?Q?eGdfm8Bxa4J+QfotJG/kqxIvHWkDwyemzuCjItRXzLL7fqlkNuGWpMWW2s14?=
 =?us-ascii?Q?I9/WPzclXncGOeG82Dh1wVkTBYetps/KNd71oSidM0eVzucmhmX+7LKCvUQg?=
 =?us-ascii?Q?j+0ljffXI7L6YkUlAYzg6EcFVxZXEm9iqc1q4ItRc/XZt9d7aPZRCuoXaKFJ?=
 =?us-ascii?Q?RH34unt7z8SCPmBAitMtf2XZKH9SEJEIcYOEYyMoZtJyuWaUnTjQEalj2Bkg?=
 =?us-ascii?Q?C9qwNsgySDhNK1BcWhHdNrh6fSgFc8eoQBVZf5VZnaIGuF/degkVlj+Uzdzt?=
 =?us-ascii?Q?scUDUoGo2MoXoWuD7JvRZciRZQPLG9iM6OLnr3Rc9GKhhCwDIDA2sxG60cTJ?=
 =?us-ascii?Q?REt7oq01+X2+jyKcK40cGrQi3EwpSCe9+WqyJ2xKwla6EiXzGzNolyCFPRHY?=
 =?us-ascii?Q?yM44G7l+Un2rqjyA4AkTAQZ7mA3NOdPzK89EVaM4Sm++OITUE0UnjxfITm5I?=
 =?us-ascii?Q?etsE178xBS5CPjBt2gf8mS3/W3BknCoOjGo/EpISYp/7iyz6lVH5bSqXCBEe?=
 =?us-ascii?Q?ibHkZ1CAZ4PQMfyjGSreBkpZbJiqXbzVcgBMnlyUAkS0p6dfAQoBE9wRk4KV?=
 =?us-ascii?Q?NR/+fri5idkuZxMyRhL8X20w5gKrOAUyPCdA3E/uAQKlS2FnnWpGLvnavKHv?=
 =?us-ascii?Q?jZub1m+TVSV3gq+OTWuWhxzaXJlpmLACWeP7q933Ka3HYWfgTwyn+Ah7V6dL?=
 =?us-ascii?Q?nx8KcPB7MuqqkUxU0Mtopzea6p6b9i7iJ7iG6Z2ZfiyfOTYg2yY4VQSvQVnW?=
 =?us-ascii?Q?K/1t0+sMegfhNa8obp161GxXR4eKYUASwGT6OUzsp9BjsxLh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a2bea4-5cdd-46bc-9472-08dede66b9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 09:36:31.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUVcSueRSYMx3Lu1YQ4I8eztJRaSckroekIrWc9Xhv/Z7XWsuT0/ruvL2rBFt3HAzGSwnVIxyqFlei5Re7C9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

> Subject: Re: [PATCH V5 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth devic=
e
> support using pwrseq
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s)
> to consider:
> - [High] Calling `devm_pwrseq_get(&serdev->ctrl->dev)` in the child devic=
e's
> probe function binds the resource cleanup to the parent UART controller
> device, causing a permanent resource and memory leak on probe failures or
> driver unbind.
> --
>=20
> --- Patch [3]: [PATCH V5 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth dev=
ice
> support using pwrseq --- commit
> e33ed957970d3c81ac733b1991f81b42afce6a94
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
>=20
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support fo=
r
> getting the pwrseq device if the OF graph link is present.
>=20
> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c index 0bb300eef157c..68f84c324113d
> > 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
>=20
> [ ... ]
>=20
> > @@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct
> serdev_device *serdev)
> >  		return err;
> >  	}
> >
> > +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> > +		struct pwrseq_desc *pwrseq;
> > +
> > +		pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev, "uart");
>=20
> [Severity: High]
> The commit message notes that the devm cleanup is tied to the UART
> controller device and adds explicit pwrseq_power_off() calls to compensat=
e,
> but does this approach leak memory and pwrseq references during
> bind/unbind cycles?
>=20
> Because devm_pwrseq_get() is called with the parent device (&serdev->ctrl=
-
> >dev), each time nxp_serdev_probe() is executed, a new devres entry is
> allocated and attached to the parent's lifecycle.
>=20
> If the probe fails later, or if the driver is unbound and re-bound, the c=
hild
> device's devres list is cleaned up, but the parent's devres list retains =
the
> accumulated allocations.
>=20
> While pwrseq_power_off() balances the power state in the error and remove
> paths, the pwrseq descriptor itself is never released. Could this prevent=
 the
> power sequencer provider module from ever being unloaded due to the
> leaked references?

Yes, this is true issue, will fix in V6.

Best Regards
Sherry

>=20
> > +		if (IS_ERR(pwrseq))
> > +			return dev_err_probe(&serdev->dev,
> PTR_ERR(pwrseq),
> > +					     "failed to get pwrseq\n");
> > +
> > +		nxpdev->pwrseq =3D pwrseq;
> > +		err =3D pwrseq_power_on(pwrseq);
> > +		if (err)
> > +			return err;
> > +	}
> > +
>=20
> --
> Sashiko AI
> review * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2
> Fsashiko.dev%2F%23%2Fpatchset%2F20260709101555.3034853-1-
> sherry.sun%40oss.nxp.com%3Fpart%3D3&data=3D05%7C02%7Csherry.sun%40
> nxp.com%7C48b334e953744676329608deddaaa9c6%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C639191922250049941%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DG5jMhoI6
> dW0e5QpHqX%2FWNupCSiSPwAlkEa0Afo0tzpI%3D&reserved=3D0

