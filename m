Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BE1DF26E;
	Mon, 13 Jul 2026 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915417; cv=fail; b=oHTLRUM+emuJqJs6zC4dq8AZ2g2z045Ks6YG/922vlG7Wd/gpK/BvXpUWyONQXST/AYCFcMTDwfQjnnYClHKl0SyDboqdJvV//8dLsrpc4jJ+xTLGUvcnrHVm88+E2tZgsDRw3VCKjK3Sh7g9TLB6qL6PqUT0u4XegACEE5Ip50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915417; c=relaxed/simple;
	bh=pRwhFfDDVfjMdi+22gJIIMVLx73AiEiq8bPrPkUFrow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqUpA27epTyP0h4J5Yrn2H5It3pysZ9OqUmKeZkZLQErGKGRh8Vtxo+mLF6OnL2K51SPVFDv/jlrfpu1CONdXBIFWV9NFrraEHj+Hh8jX6o7BYK3B+r4jZzRtmmR/CDP9ZRiG9ymtBKtqsgFuGLaK1ME0DGM3UKV0RWlDtNsaqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HiTrExDK; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HiTrExDK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+IqCTdGhlrDcx4FszaUpnJAUmwmot4k8KZ9v7p9bkEBDtSkgyS4YLDyWTjtxs7MC+5ejqkqvZjooG/AhzRKHhPTFkw58uZdUs4x1q9bNSArZecPHMU0bfFIT3tloDVXlpHdiykETC0fOv6ioxbE9N1j8D6z9BCSLP3cyYQPOOjkbOZLpG8gFDaLnRIwa0A5cdykluQqoq5uClHEOqpKb/kz49hnUPwvWb714ZMpFlBs1RUZa0O7QS/MC3pi7i0gxPHYcvi6zDLPBdHUylkv6VYtDy8xmQOrZxnM/MJrckTB941OKq+qIqvAL6EhtxaXRaZQS4f1NDTytHrOqCGgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNnRZ30fV1IEmSkfVm+rGwmiD3L/3KR/Fd8KmVQOxDc=;
 b=j7ViI7tHH84ID5pIHt5PQFAqDp2/cnIpSh8UeDcf54ZoO7YrWaVQpXD9oGt5XJHV15GAFn8IMeu3Dri3dcNa41ciOhYk9n0tZ6TXepc8Cv4b1hMugb7lX0pow3/d6cyr+uVGo9Olw55v7egaiZ4+2R4DXzqoQUUiDn0IfaoJvRlSoymPhpi86cBGSFgu8uE6bXKMIs9lOcc4/h7eqGmsLn6+7JyBvGYOsPlvoGJhQYFvncWnByTtdNF+Q/sxqQamLRtzPjTNwcA8JbreEfvVXR+H90Ka5hLMm9m1oWO0CxsBz28BEMmOPxlAcWK+2lK+cnH7d7W3/rIpIYRcttCDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNnRZ30fV1IEmSkfVm+rGwmiD3L/3KR/Fd8KmVQOxDc=;
 b=HiTrExDK7xx7qy+ovhUTzMF2Xu+GD5qhX05Jn74r5wNMif7Ztl4kv0Yd5VGfrm4KkDlBwbN89BEbtazyi01L0t/joxstLjiLj7KN2GYStCHaqmtTu7KC4YBsAJNhwBeT0GjhHwTRo2zqA2onc0vRM2+/nHdLHe/H7Lkum6eBivmp6K11we9YWvCJIaF+8gwp935JNl7YXBZvzeWzE7+ql/uFu61gHlosOSNr3gIXFoL1D1DqIQSnxalhJ6M5rMzMXtCBXysLhGIX7L0OgWo6AQ2531IBhk0ROPBpr+o0CAdU7zz1NBROGbBM6AWRwKLjq/jWsumXSA63gu9sFkA8WQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU2PR04MB9212.eurprd04.prod.outlook.com
 (2603:10a6:10:2fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 04:03:32 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 04:03:32 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>
Subject: RE: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Topic: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Thread-Index: AQHdEm/b8LfnBcjhvUCaiAiI6/01h7ZqvbcAgAAQYfA=
Date: Mon, 13 Jul 2026 04:03:31 +0000
Message-ID:
 <VI0PR04MB12114A2118BDD22D627F6E84192FA2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-4-sherry.sun@oss.nxp.com>
 <20260713024251.36B3D1F000E9@smtp.kernel.org>
In-Reply-To: <20260713024251.36B3D1F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DU2PR04MB9212:EE_
x-ms-office365-filtering-correlation-id: c12d9383-602d-48fe-16da-08dee093b426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|18002099003|22082099003|4143699003|4133799003|3023799007|38070700021|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 27QH9PgmIWblLdDbys4UXPchT6qHjDbHJpJSRYoqOtnWVKNQxKpwlmh5lMEuP12FzYwpB6QDoN5BAcvQJjnlPvfbAonJ1x1RdnGNJLCHhRHK1JJCGYbdv1DU9MXdU5dyQlLJAdx7YN20/VefiG4FO27tiK7OsN3tTo3O/CwoIdxFd/Sa9Wp0K4R2ESre5r9k46obcURrW/WCAZrLpJRZc6EHGHK0kO/wwwaN83SWCEqHvW2yvioS2mG55m4MEvb7YqZ22yaVpofEUzT5l35uuBpAZSMZNjrHx6dxYgJDnG6O2RAsQ3MQ4I7woGWObAU6XOf6F3+nL3GTJXHcQg3TmLMAhCkOvn4uggYE/woREySwcVmgQu+WU9eIZIysC5OyEVPIqCC3furT/S/j1ZuxT8hcCvDGhipevzsJSahcGWrGJmDVIOgS65OF7TGDAwCtdcxJGtYILDJMp5DUTVFT1n0w2WOntB7c3oYMRkVTL2mrDLyC6z2xGusslVwmy8ibsJOw8Zwn7oVdW22yrRLFarqa9kZsBCKP9fH7xL5wi6Oh4YBC1xPlbnP5Jh5dHM7NjVVY9cl3ylKG1+na/tfetecwrBEMdAwsGVz7hxb9EvM9VO8Jx06r+WxG4VVc22SYV6moj1cFCBWSTaOGcmkCr8O7Aclg+xubiOrT3tu6+O8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(18002099003)(22082099003)(4143699003)(4133799003)(3023799007)(38070700021)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cFk72hPZTehYuPfw/EcDDRvk/p6/8E3oEBB82D4bzziIUJl6ZzUyuai3Fgg4?=
 =?us-ascii?Q?NcRoHT6KOIx+dcqbUOjgwQumLngV0JLHJrJsfD+i1qgvT/tHR1xWc3LWt2MR?=
 =?us-ascii?Q?LHZMRrtvkIh+fnXAKFe4x5DdQbgo4a/oqezCbSFuz5L5UzgnsM82k3+M9HCp?=
 =?us-ascii?Q?jj+q6N1z77R6UgHo5oE/54UAh8KU9Q72U1D8c0gj/Bk/GZ/0EcVehj4Nb5rT?=
 =?us-ascii?Q?gCzhq9tepSghBoMqgGIvUqFdN9xgkNsEJ9oVNtKstn+OBTiptwB/PnKPy9e+?=
 =?us-ascii?Q?l55QVzQamkoF8k0WwGmWZ8KQ+mXl8XkngrMK/X/J1Pb33HE1dl7C9QMKWrLA?=
 =?us-ascii?Q?hXz1QecBLumvcQ5bxraScGLvrs7zmk0725q5xMKuULnut7mcGu1b+chnrvzp?=
 =?us-ascii?Q?Ewm+j3LRcWaFLjn6iNz7vrgCH2hW4RObpmEbHybyobsL5Qjva2N6UlLwkoVt?=
 =?us-ascii?Q?qhFRZOncX9CouVXZlw6Fd60jiR0o73Mqpf5gAyy3jYWEXxyOewTvLgX8piM1?=
 =?us-ascii?Q?EYIwYO5BiEDwhcUZSkmST5f0DrMyiHQKhGnw5SGzU2kxajQbbJU20ZGEoiF8?=
 =?us-ascii?Q?D7GtfRGwQStvKF/eeFU0naQq6646mGasHQjKIAYR8xWwWfUdjHLhwSii4tWv?=
 =?us-ascii?Q?bKsNJpc9mp5Ty/LEXz9G3wYhWZliMPsDg2AKFwZx+9Olyf+csqHQ5C2eeHiQ?=
 =?us-ascii?Q?+XFks8LVKfg0mzydFTXW3ZA5Dma3WRXWgMTJxDKsZ0xL+9vuLByW8kUJFh1+?=
 =?us-ascii?Q?jhiRBvaKLOwyofQVETwKj6OsfCQyicn9zmU9NpSRinzsS7a+AySOd3YUAp18?=
 =?us-ascii?Q?0jXqek+gmw2+KVG/WPSKcnaagXRE1PUaNz/tM1/om/+9kNNEx4zugqNa8M5u?=
 =?us-ascii?Q?WnFvLTbQYm1Uphp7uZvDba/senxpaUaUvITIkRFX4tnM9VLMIcEUgBhpaUSs?=
 =?us-ascii?Q?YUyj5QiRUIBOtrY/uUBxMFhYThJmR2ZCtT1gLuiOdkQDKRpaiIk2CAy5Gy1v?=
 =?us-ascii?Q?H/sHZsGgjDHY8lDXj5iSyXhVvXv3SAR0yOlT2DwjyxyUcoqe7H/huU9DIh+i?=
 =?us-ascii?Q?zxy0PFnPkgq6ofeoKV2qLCWPT7npPhlB45abBCq7XOI8xLGRi7Fb1RTOoxZi?=
 =?us-ascii?Q?OUGDxqeTvZR3/PKprSfzcss9sqeg2/DP76qzMZ+4MNPeZ/iWXkW8eGD/d3bH?=
 =?us-ascii?Q?r8XbBj2QjiuDpnZZreHKxWAunQPOmWMTm953yOxvZWORoJBhPwmImIkfB/oK?=
 =?us-ascii?Q?33fgWBanylkEweBUO9NE3eeDYDZNsJLVdvpFCNuU11lQOWUUna8jrfTvuIkv?=
 =?us-ascii?Q?jL2lkzE0GRmgO2WQmTtusWJDfsVzZkEAG2DLj6CjAAV8aqKrcBwG4aMNnkkZ?=
 =?us-ascii?Q?J8YPtlvA0dPft0TqvPOFUGHUhSjv3A/bMwrEpFBPYLDebdOu2N3NJ0+NW1yC?=
 =?us-ascii?Q?gS0M1YCCEXkPEMetR1YiEYuK3pKfKiK3WMCBz71Zkog5/6CoPPMfDw0Sz8bZ?=
 =?us-ascii?Q?ijJl3Gt/c+Tn6ehzvMikd49TyYe3dQwY/xuy6H/Eh3CUm44zRmpe85mKDdVT?=
 =?us-ascii?Q?ArimF4R9T/2mFHP1hlLoulkBpofRpMmshKkGkdzQqZw3VUx96KTOtzQO6UUn?=
 =?us-ascii?Q?ONBEKWvep+x8Fi431am5xstrZ01XKRYT7yK6Vc2hngAODt8DbaCEIRgvQDFy?=
 =?us-ascii?Q?q1D3YuKFwzfTCDdm/5jWjHdhZdZlIZT3P6Nil4RWIRG/wAtt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c12d9383-602d-48fe-16da-08dee093b426
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 04:03:31.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlqZ68rqIzb23JuLMYMY5JUXrX7dLrdYYS1EkOE/V5qmKLq6fkb5wsLw3xGTStvPWVTqIgs+bK8kCmltsNEjDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

> Subject: Re: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth devic=
e
> support using pwrseq
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [High] Brittle logic causing probe failure on valid hardware topologies=
.
>=20
> Pre-existing issues:
> - [High] Race condition exposing device before initializing synchronizati=
on
> primitives.
> - [High] Use-after-free and locking a destroyed mutex during device teard=
own.
> --
>=20
> --- Patch [3]: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth dev=
ice
> support using pwrseq --- commit
> 885432311fa71ac754d16037ae3e761e8192452c
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
>=20
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the uart pwrseq device. This commit adds
> support for getting the pwrseq device if the OF graph link is present.
>=20
> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c
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
> > +		pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
> > +		if (IS_ERR(pwrseq))
> > +			return dev_err_probe(&serdev->dev,
> PTR_ERR(pwrseq),
> > +					     "failed to get pwrseq\n");
>=20
> [Severity: High]
> If the parent UART node has an OF graph for other purposes, like audio
> routing or multiplexing, will this unconditionally fail the driver probe?
>=20
> When of_graph_is_present() returns true, pwrseq_get() might return an err=
or
> like -ENOENT if there is no power sequencer configured for the uart targe=
t.
>=20
> Could this logic be made less brittle to support valid hardware topologie=
s
> where the UART has an OF graph but no power sequencer?
>=20

This is not an issue, for btnxpuart specifically, the OF graph link on the =
UART
controller node is only ever present to describe a BT device attached via t=
he
M.2 Key E connector - that graph is the pwrseq link. There is currently no =
other
in-tree use of an OF graph on this controller node, so in every supported
topology, graph-present implies a pwrseq provider and pwrseq_get() matches.

A similar pattern can be found in drivers/pci/pwrctrl/generic.c, which also=
 gates
the pwrseq path on of_graph_is_present() + dev_err_probe().

Best Regards
Sherry

> > +
> > +		nxpdev->pwrseq =3D pwrseq;
> > +		err =3D pwrseq_power_on(pwrseq);
> > +		if (err)
> > +			goto err_pwrseq_put;
> > +	}
>=20
> [ ... ]
>=20
> > @@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct
> serdev_device *serdev)
> >  	if (bacmp(&ba, BDADDR_ANY))
> >  		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
> >
> > -	if (hci_register_dev(hdev) < 0) {
> > +	err =3D hci_register_dev(hdev);
> > +	if (err < 0) {
> >  		dev_err(&serdev->dev, "Can't register HCI device\n");
> >  		goto probe_fail;
> >  	}
> >
> > -	if (ps_setup(hdev))
> > +	if (ps_setup(hdev)) {
> > +		err =3D -ENODEV;
> >  		goto probe_fail_unregister;
> > +	}
>=20
> [Severity: High]
> This is a pre-existing issue, but does calling hci_register_dev() before
> ps_setup() create a race condition during initialization?
>=20
> When hci_register_dev() is called, it schedules the power_on work
> asynchronously, which opens the UART port via btnxpuart_open().
>=20
> Once the UART is open, incoming data triggers the receive path:
>=20
> btnxpuart_receive_buf()
>   ps_wakeup()
>=20
> ps_wakeup() attempts to lock psdata->ps_lock and schedule psdata->work.
>=20
> If ps_setup() has not yet completed its initialization of these structure=
s, could
> this result in operating on an uninitialized mutex or workqueue?
>=20
> >
> >  	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>=20
> [ ... ]
>=20
> > @@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct
> serdev_device *serdev)
> >  		}
> >  	}
> >
> >  	ps_cleanup(nxpdev);
> >  	hci_unregister_dev(hdev);
>=20
> [Severity: High]
> This is a pre-existing issue, but does calling ps_cleanup() before
> hci_unregister_dev() cause a use-after-free or a lock on a destroyed mute=
x?
>=20
> ps_cleanup() destroys psdata->ps_lock and cancels psdata->work.
>=20
> However, hci_unregister_dev() shuts down the device. During this shutdown
> process, the UART can still receive data or send commands.
>=20
> If data is received or sent, the paths btnxpuart_receive_buf() to
> ps_wakeup() or nxp_enqueue() will attempt to acquire the destroyed
> psdata->ps_lock.
>=20
> Should hci_unregister_dev() be called before cleaning up the synchronizat=
ion
> primitives?
>=20
> >  	reset_control_assert(nxpdev->pdn);
> > +	if (nxpdev->pwrseq)
> > +		pwrseq_put(nxpdev->pwrseq);
> >  	hci_free_dev(hdev);
> >  }
>=20
> --
> Sashiko AI
> review * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2
> Fsashiko.dev%2F%23%2Fpatchset%2F20260713023435.235765-1-
> sherry.sun%40oss.nxp.com%3Fpart%3D3&data=3D05%7C02%7Csherry.sun%40
> nxp.com%7C7fc8858da84f4a67665608dee088947e%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C639195074371576326%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dxmwpxx%
> 2B1ofNIS08LXCuIRyjRW8g6PHY4iVOYOz6d9fg%3D&reserved=3D0

