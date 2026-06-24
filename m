Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22038AC97;
	Wed, 24 Jun 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284976; cv=fail; b=elR8zX/6ooN8adDWIMZNMqvWWmlPL0MtlmLpYX8oXURY6J3UcXXzwPiwvomEQ2GIWeqvN92+ovPW027/ZIo3cKxZs+oZbe13EfvmpUC+Xy2yJ77pVMM9Ld0G3cOkN/fISovZw3EHSaokfaoVxBn+iWTGn+brz15lhERh66zmVdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284976; c=relaxed/simple;
	bh=YwimGlHh6VffAmut3CajQEEifCVV0Ix12bDpTQCAF8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwJ33g9ma8fAJ1oTLG4uvBTJ70a0NSUkP5a8b0TdgLjjaTQsPcylSBObcKVf2ERYSVkLCbZ7qmQEh1NFI/6OQXDyefiX+kX0NhWvCT6p5J48V7Z0uTVBKkDK0Mpyqe4g+gPB9cMLXki67KoqkN2tzkp+mVOQtHXYcgBBf6vqgjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ViA/Zsx5; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ViA/Zsx5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiWyAgZYwLORlZop/teXA9rokhJ+pIDrp+pSz5vUmUl76kSxr9+CT1wodNmwYNZhltg48YGmd7Ai5oOo7CFwyaGlRKw4ioycyEDIlnr8uni+NO/mID3kO2RYG/hpj69KJ4esHP+HnOrpof3csXnNEaLd6YFWeDp0ys23jEt6kCFMvSIQFto5kqxQh91MEk8a6w6sfY8YaIewmwwfd3UoDiHu9BnCwBQVauQHDXR5S2dEhT1hjnzIh5cdqipWifr+J+VqPDIm5bCcUztSgzEnNitI41SvqNtUQXeuc6KuEbDO2vxl08HO3dkkaFVyP5ia6ikuOG0+OumAdj8OFe2Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=091zK+0NHxzE22BJxj614Psiy9MBhC29uU3DlRRzFy4=;
 b=D7R5B4xO8kgj4OrpvnOdcaxdUpjnCRrUFwTljsy5th8/KKirRWLmknM6K7EDcQXKlUuyVmSKdKpCskbhTMX4xoBBpoueta3bsp02gni29reL0FiIKoW62KjNFEFmvu7LY1IugM2gvjAJDEmjpDHNmYLq+xGLIoPXHGrljLhH7yRZxu938wMVHeqR6YNezN4L38beUVWCCEiT1ODe+UgWx0l1Ifed3GmIGhghhQZ5bgZjJeorYNhvQVPBOGpJTWquRkXNWHi5J9r30YATHi4VZfiAUPlu2ZJ7nCS8yVS3Tt4+lEasz1No0H49xAWXlDX/oPU9mRm+CQeWxFMlURGOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=091zK+0NHxzE22BJxj614Psiy9MBhC29uU3DlRRzFy4=;
 b=ViA/Zsx5L9OYKFy+sNMD6trcXKOEQEp2+/qQmqjwBomGafNZOZ+xy9Ot2UBNPcBRXo8Nz94QkoYxqkY22e3/dO5O57uO/4SHwYaYOtfITzUf6mBL3IuRzfMGmqe/N7IxycHlG8PURhtKSohJUoA3CjLySeKIBCe7XhWUcRDSYzytMU0LYr9A8VQzgLZ0+d+yRoFL/7V29g2knv+zV/VJNNtfIvGKtHMittIB14Ryq+D9v8dBYaRpDrMH3rOllV/WurUXMPq1Q71AE5OL9v79SrlJlgH8HdK8nsPsypJ6i8nXAIv2W3v5fgXYBcz3xu7xG1Dy6FQX+6Z3V6/jaUUdhw==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB11511.eurprd04.prod.outlook.com
 (2603:10a6:10:5df::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:09:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 07:09:27 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj
 Sanjay Kale <neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@kernel.org" <brgl@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Topic: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Thread-Index: AQHdAr0iuX6nZVWy60m8TZTUEemMGrZMNMoAgAEUz+A=
Date: Wed, 24 Jun 2026 07:09:26 +0000
Message-ID:
 <VI0PR04MB121147C305022511469FB603A92ED2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
 <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
 <ajqZBM6IkbDLiVu2@SMW015318>
In-Reply-To: <ajqZBM6IkbDLiVu2@SMW015318>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB9PR04MB11511:EE_
x-ms-office365-filtering-correlation-id: 37a7151e-716e-4a56-a6b4-08ded1bf8730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|23010399003|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 XJjkLvu79zUcXIeV6v3k1neyPb/tgb08cLAhzeehzQzSi0YRhqIGZENy04mBjCvIIFMp6Yk7uYs4DyVhEDmg8gTLyeXKt5nWZdHcB23Ygl5Fm1ZdyvjluzSNTtC09LJme5XWjDegkKxw2NUZ7eVVanz3h6tfr6OIbWbHBTFt9yFbNG4qwU2zruhFIFY2a4kpdM6SRViaHaaUnmeLbDXW8qXcB+67qXDoXCoufdyzKJPnKasmQYalimEOIYUvESCprT9LDHEzYTQH5fEcptClwlQdphW+yCcq/L2LVeU/3o2edUCubQoBdzFBppJdGKPQtzUWxzznRAIfeIvc/7xFZiPA6FVLz1cgFcLgTzVZBUKrvSgQ8TsE4CZh6AmEjhk38Ue4jqR11hRYr+/nVNb2t0ggnNXn8fjXGaWPwH5L3oPDcwJkktKdSbw3cecc0bTiBqBOwQBkeuh2YsYUIKDIxF7EtzFLlURrC2k3WAPibU92Kl9vOaAJsbhItisGbjvywPPk7sm++jmRWcWpspqBOTKbGImfEFPVkwA1qt9z/rqAAdmGWWMFpPW18vTscehjC28Emzu6iEqsTBxu1sWQMg5vmh2dP0Eah5Ql2+WyIDYu7Snwtc6HxDPCDQy1AGQs7xoL2NtfIjyxeu1KiITevEu+/he+6S4ndaY+faHbSbYTjj+7gk5FP6HXMkcBor6Tc8Ef4ZSvE2mHgLNBMSv8DQy2h4SpFJmk0o6+qtlYjTg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(23010399003)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CZ4jDlK01NeFJRgGiguwRxHarrhZFwxt3Br9w/+HQy9nr2DPcP0ZDsu9HoZd?=
 =?us-ascii?Q?zqe/L3mWow+G/RRfI8wmgP6QgVFCDxVeUCVZ8vGBc5jRT3ifOMNdgOLjMslo?=
 =?us-ascii?Q?ADJzNCdYXJI8rnehCNlU/3PqP6tbJ6EpPxa1pZymz4ipXnjPPxtLDZhMDXxH?=
 =?us-ascii?Q?bAgVLCKRZ4C3Vnd9vtAdAAY4HetejEh/RvrqL6NuLVsu+msvuqxtmUbk4a9T?=
 =?us-ascii?Q?pAuy0ad7Gnf8IVK/LYEf4dRBLxnk4Ix6COdgzfz7zzpKYCku+8fK2845w6rF?=
 =?us-ascii?Q?3ZjfjlokbJq0QQysDIEO4OpJRVIpDyA2HumLrbjzeU5HhcM3V1rqppSGbBdP?=
 =?us-ascii?Q?GEsuyjdAOEBBf0SZEmhoWq1x6vBDyyN8g4dUk0fAtlrrB6ER67wvBiVQ0MAy?=
 =?us-ascii?Q?0I9D/m3CBVmBHiY64hMEb2Sv6RzoRMvyPfMCBC+VvDYuRpl/CwM9pC3Nt2YU?=
 =?us-ascii?Q?Xpc/oKuGeoVKXpUSu276NyVD3eSensSPazhbmvY2xqKJOo3IpGtmtY5m0BBW?=
 =?us-ascii?Q?KXDRE3rNYHXIMODWS0B3KbIyBHlwLqp935z8r/Y9CqlpV5nMXe9j9+s7wpTF?=
 =?us-ascii?Q?HGoPai+BJQPt8bSZpY091E2X9ZfQ/MPoCtiFHYSdzZ94fWftQSfbhjKJTV+g?=
 =?us-ascii?Q?/tD4Fmek9dLIaALDrMXRZ7HF2kLSj+oTFhtfcrW+eI6RqsHhO311CedC0U63?=
 =?us-ascii?Q?5d3jD/lx1IDgwQ7M6absTXIF9K0+IH5oSupuyiIaYqsmqIK0l3CzjRwZWMex?=
 =?us-ascii?Q?Gq1rfEEsOXEprUqc+B4IXoiue8UzBByjkIVgIO/ts3GiVKLT4qoyasCJOauc?=
 =?us-ascii?Q?vBHPkFl1vkBkDqMiCpN2zvyhJn/XpYHQotwlSszxRG7Y43uDIwW+2dnjT1kA?=
 =?us-ascii?Q?GKnK0OGpZbpg62HWsnGORo6QiAEJAqKyqCj8EYGGFUQ3F0TiveMYGx7z3zRB?=
 =?us-ascii?Q?iWaw6jxKnTx/jBqOxtzRZLXydcaTs5g62aSs9Wr3ZBJYayJ+jnpgk3u4XBXl?=
 =?us-ascii?Q?1JqYeGPD9l+PfroTaZ0L8zGx2mbO6nOYMcilPZ6jT3v4VTgIOsvgw9ti4Mj+?=
 =?us-ascii?Q?9UQzZSLBwUngYYBVDFbuxn7iRpQGGdloXNbiSqkGOnholZs0MMXW1JKxhwow?=
 =?us-ascii?Q?4CdEyuM58QAAB5OnhePBlwTSwA4ZQxjlvXzX7BKEPXJx36Bd1cJHBFuXQ4/k?=
 =?us-ascii?Q?EHSVBnHIqGqJUS4hvrBuxElp07s0efLp7PjoEQ2kyM05MFTcL3ZdX4ciZsSH?=
 =?us-ascii?Q?fiVGOtPl2UADy5HtVT/JasAfBvjGfeqf17SP52cPByimZKfZy0bUJuRLoU0r?=
 =?us-ascii?Q?s2HXpp6+XhSj6+zVXtF5dN3FV0XubUqwXN/OxG12gUURuOS6asfCk5DbQUUE?=
 =?us-ascii?Q?UiIxaoTx4ipz2fFaBodZeEPVaFO2D+I+wqShWIUQ5bnxkJgC5Xvz+i/JmP/9?=
 =?us-ascii?Q?2I7MuHWFkntlnsotNgk1L2SOfK13qTBV80H/LMCFuS3ihyxrwausbsvUPIcz?=
 =?us-ascii?Q?C8Cy3C7zeT+PT6lVsps40LH7hQi1vywbu3M+EDP2ebvFUpVnFX3uHJrk9v/g?=
 =?us-ascii?Q?OZQ63iSClFe6up8tuKzU2JYSvqhlaa2vyZwGucSAr4ifK8s1Q2vun+r+fdBa?=
 =?us-ascii?Q?mcuv5zt7dfYdr57Kg+maDXFwVBp6biMZ7Jqpuo9mv1bCn1nOg4lr8ev8HLE7?=
 =?us-ascii?Q?dPdyBb54jzTvFWGxgPjPucxLXxWAHJSyzP0yQGPGnzcxs2t/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a7151e-716e-4a56-a6b4-08ded1bf8730
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 07:09:26.9710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8J0opJOmu7D4862mD5HJG3a1OseRvAiGaubFCZpbPUJAo0w+Tt7ZPlTB33zMQaucsGiyKkXnS0/3ujN6UXJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11511

> Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
>=20
> On Tue, Jun 23, 2026 at 11:07:28AM +0800, Sherry Sun (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > suspend to preserve wakeup capability of the devices and also not to
> > power on the devices in the init path.
> > This allows controller power-off to be skipped when some devices(e.g.
> > M.2 cards key E without auxiliary power) required to support PCIe L2
> > link state and wake-up mechanisms.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 36
> > +++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 0fa716d1ed75..ff5a9565dbbf 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1382,16 +1382,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> *pp)
> >  		}
> >  	}
> >
> > -	ret =3D pci_pwrctrl_create_devices(dev);
> > -	if (ret) {
> > -		dev_err(dev, "failed to create pwrctrl devices\n");
> > -		goto err_reg_disable;
> > +	if (!pci->suspended) {
> > +		ret =3D pci_pwrctrl_create_devices(dev);
>=20
> Is possible move pci_pwrctrl_create_devices() of pci_pwrctrl_create_devic=
es
>=20
> and call it direct at probe() function, like other regulator_get function=
.
>=20

Hi Frank,
That makes sense. However, if we move pci_pwrctrl_create_devices () to
probe(), we may need to add the following goto err_pwrctrl_destroy path
in imx_pcie_probe() to properly handle errors from
pci_pwrctrl_power_on_devices(), is that acceptable?

@@ -1960,11 +1949,15 @@ static int imx_pcie_probe(struct platform_device *p=
dev)
        if (ret)
                return ret;

+       ret =3D pci_pwrctrl_create_devices(dev);
+       if (ret)
+               return dev_err_probe(dev, ret, "failed to create pwrctrl de=
vices\n");
+
        pci->use_parent_dt_ranges =3D true;
        if (imx_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {
                ret =3D imx_add_pcie_ep(imx_pcie, pdev);
                if (ret < 0)
-                       return ret;
+                       goto err_pwrctrl_destroy;

                /*
                 * FIXME: Only single Device (EPF) is supported due to the
@@ -1979,7 +1972,7 @@ static int imx_pcie_probe(struct platform_device *pde=
v)
                pci->pp.use_atu_msg =3D true;
                ret =3D dw_pcie_host_init(&pci->pp);
                if (ret < 0)
-                       return ret;
+                       goto err_pwrctrl_destroy;

                if (pci_msi_enabled()) {
                        u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_=
ID_MSI);
@@ -1991,6 +1984,11 @@ static int imx_pcie_probe(struct platform_device *pd=
ev)
        }

        return 0;
+
+err_pwrctrl_destroy:
+       if (ret !=3D -EPROBE_DEFER)
+               pci_pwrctrl_destroy_devices(dev);
+       return ret;
 }

Best Regards
Sherry

>=20
> > +		if (ret) {
> > +			dev_err(dev, "failed to create pwrctrl devices\n");
> > +			goto err_reg_disable;
> > +		}
> >  	}
> >
> > -	ret =3D pci_pwrctrl_power_on_devices(dev);
> > -	if (ret) {
> > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > -		goto err_pwrctrl_destroy;
> > +	if (!pp->skip_pwrctrl_off) {
> > +		ret =3D pci_pwrctrl_power_on_devices(dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to power on pwrctrl devices\n");
> > +			goto err_pwrctrl_destroy;
> > +		}
> >  	}
> >
> >  	ret =3D imx_pcie_clk_enable(imx_pcie); @@ -1460,9 +1464,10 @@
> static
> > int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  err_clk_disable:
> >  	imx_pcie_clk_disable(imx_pcie);
> >  err_pwrctrl_power_off:
> > -	pci_pwrctrl_power_off_devices(dev);
> > +	if (!pp->skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(dev);
> >  err_pwrctrl_destroy:
> > -	if (ret !=3D -EPROBE_DEFER)
> > +	if (ret !=3D -EPROBE_DEFER && !pci->suspended)
> >  		pci_pwrctrl_destroy_devices(dev);
> >  err_reg_disable:
> >  	if (imx_pcie->vpcie)
> > @@ -1482,7 +1487,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp
> *pp)
> >  	}
> >  	imx_pcie_clk_disable(imx_pcie);
> >
> > -	pci_pwrctrl_power_off_devices(pci->dev);
> > +	if (!pci->pp.skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(pci->dev);
> >  	if (imx_pcie->vpcie)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> > @@ -1990,12 +1996,16 @@ static int imx_pcie_probe(struct
> > platform_device *pdev)  static void imx_pcie_shutdown(struct
> > platform_device *pdev)  {
> >  	struct imx_pcie *imx_pcie =3D platform_get_drvdata(pdev);
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> >
> >  	/* bring down link, so bootloader gets clean state in case of reboot =
*/
> >  	imx_pcie_assert_core_reset(imx_pcie);
> >  	imx_pcie_assert_perst(imx_pcie, true);
> > -	pci_pwrctrl_power_off_devices(&pdev->dev);
> > -	pci_pwrctrl_destroy_devices(&pdev->dev);
> > +	if (!pp->skip_pwrctrl_off)
> > +		pci_pwrctrl_power_off_devices(&pdev->dev);
> > +	if (!pci->suspended)
> > +		pci_pwrctrl_destroy_devices(&pdev->dev);
> >  }
> >
> >  static const struct imx_pcie_drvdata drvdata[] =3D {
> > --
> > 2.50.1
> >
> >
