Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C71DE8BB;
	Tue, 30 Jun 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808853; cv=fail; b=XSnQ7hess3Va+fqzOt2HhuEMlm1qq1rttUGZfNp9S4gdcqGjJm7rf5Az58D3K+oefi1/vdU69SgRe+KogWSp2PgYiGkZFB49DvJMaFyQnFE4AJ73QmflfMhkDW9ZGhgo+oju7Srd2iyeixX0ILG89nptGTLIC/kmut71A2Klkfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808853; c=relaxed/simple;
	bh=RsyX049cqzPnKIDgLwYrOq1IwurrKrDlfN0aJAmTh5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5foLqyjnWlxm9IH1yhTzZQpQDx0/h7Ucg4rPhpf5OcVtKVJ+R/fDcKs5GzeKCnuH7xt00quAhul8boH4z+rL+g8oUJLHcOrpnWhTvnaNrvI8bWabiYQ0l9T3wmQ4Z40rDMhi9xEkDuccTnb/n30QxFswlaRGkyMdszNywU0z3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CJMarw8f; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CJMarw8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoKPJd1lm/M+Tr4ip02XzQwRwS5R677eLexSEx27Qo+jFQK0R06IbROxd0a9EPW6yLmbD4PChSSur0nqHGFEPuY1+bXpqbgOMdwDEipbibQLnyw14jv6Qz6BVJhJzEOtCmWnZlga8/frPYDO8+HfVk3dEnAT2oAz4uzNjwQxKcIcbbehOVD0Va6VVz4/MBpaj5nKfrGigRoxBK9zN333x7JI/zoG3bCH4zY51BcJU1FC0gq340UsfXpzLYVzJD7MseWlmQs3YiCBIpEiqaPWDps53UuRIOInXBE2jbsEr5wKZCmfXDliV4wqS+rxyx3DlXQCKqnYaQ6XUxPbp2HomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8MDANuFCAS8+POGBM9ztQAR6PQADEgeVy5XjL44b10=;
 b=kczKQhbHRuoYMzOrD6xHZU2Qnza/0aWh5DRju3aOTuHgQO3OaVIbFcm97E0/kGnIpgHxmRu4Nhwj90Bzgu+QCqCTJrUlt+D6iKUr9F53x+EGaZrl0COJzDq+aHf1Svws3NLQlxaHuENOwjApvVNL7zsfg9LGMPBzBNRzOnxUnRV9Dr5VMYaJGeU/TN1JpIA8jnKi2u4/czKfXPQ772HtNKH2ILDkCyAvm7iqCUMAa0Zdpn/l9MDEQQ1ObzSxx6zNlbpw9zZ+5PhTPt1daKKbSiacFrB7qBky+gR9V3NK7Pg935SmGpwQBuTyJ3jKgfzd+TYVhqjv8FWm+y7GNXttlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8MDANuFCAS8+POGBM9ztQAR6PQADEgeVy5XjL44b10=;
 b=CJMarw8fJDSgX1zEs+99zN8qwnXPLJWGEG7G1WHAd+tNNVzpHK1XjJ2ntAZpffb83bGxK06gjPaM5T7O2whQsHPj9s/435WOv8a2OhcbiQAdEQMmjtNsbhy9Yl3VoLfV8PcsFtr9ZmMFwkcvwcSsgGNXNyEBk75ctclW4y3ekCzK9KmyGAnFoUeTnQ2vBejR/6ECpcPFqwyqPTb1+nzwb9X49jqWL7uefWc9AZb24TjeTF5+uViB2Vf1OZjWODU/KwjU8MRIcta3i1ZC5a9ZS3FUoRYaJED1Y/ERiitNdFlKECM0aBJHLs+tnsaJ1CYu9hwaetYmL4IOjx395IMhjg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI0PR04MB11892.eurprd04.prod.outlook.com
 (2603:10a6:800:305::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:40:47 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 08:40:47 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: RE: [PATCH V4 5/7] arm64: dts: imx8mq-evk: Move power supply
 properties to Root Port node
Thread-Topic: [PATCH V4 5/7] arm64: dts: imx8mq-evk: Move power supply
 properties to Root Port node
Thread-Index: AQHdCFZxWGLJyYQ0hEOgDCMMLg3dSLZWoIeAgAAmbJA=
Date: Tue, 30 Jun 2026 08:40:46 +0000
Message-ID:
 <VI0PR04MB12114CD1CB75348D227FD1B9192F72@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-6-sherry.sun@oss.nxp.com>
 <20260630062054.2027C1F000E9@smtp.kernel.org>
In-Reply-To: <20260630062054.2027C1F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI0PR04MB11892:EE_
x-ms-office365-filtering-correlation-id: cabb317b-6c54-495a-19f1-08ded68347fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|38070700021|22082099003|18002099003|4133799003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 FavwgWJLy0GVxuDBE3JkV6i0XotYpPDDWlYQ51HqegD0k9b+cZbiPvptjS7RUffPCxPSXLLDCL2aUGPxkeVbHMeX+Yb9IoVr/6Agj/ky++RYC5ykOsB67+mQcfoBXjmN8nBQ0yrRFiKzX5bGNja8CmBaFVn0uLUxC0Zve4W4fPHMsXTqs/9RGlHVMEXUKiIkD+ZvwqeBmNTkLA+cOQcFKXBcg5ee/omUpoKDbZdocBPCZgFKvi5Dvi8OIb1/wb1qgPgo+cFntlim/z0dpFrDwPeJaQMtWlETi9xmniVRyova1vgGirPwTvzsZZCtxbIFhv/Q75MkpUBKFEi/lmn8DKi5JVbmyPHriOoIoFq42Cau3WH2VxdXVnZm1nlydIDpOtV4i79j9Z7aa0xWGyTFz8tuDLyHSW4gGVk/tSRC73RD1BfSh+tsw2fJGq5ogAUxCtI/eVgFih3knqcRCpcbYFOt+ZclKPg2QRm/PYD6ZeZwlHnftqNTpVJOh0GVXFlQWewF7fYQwNbcqJ4FgmXcmYUjQ+6e67K32D2NoCa0BYWWloBBRe+Yx35nJ/hKgLOuQaPT9UYWxzRD877AREY5Nd4zfosdkf3HuE0Id1IQ64BLICgruqVM6tOWQr0P7oIEIry1iLWIG/mAWw1D9nNEJbw+Gqq7gnBgvHLh611h80Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(38070700021)(22082099003)(18002099003)(4133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aCptJRHVFX05C23SxDe4ueqjWNbqFh0InQQoZP7Fw7mogjhEr5fy6f0qNUso?=
 =?us-ascii?Q?lXS18OmcHF2YblOyEjpFysxuSANVXT0qqxIKPDjnnsLfGtFpfXP4g6x7dAOh?=
 =?us-ascii?Q?EVVI3y87mYHrnKcV2uouy5D9kKQk1mm9YUuWDR9ZztE0ZNE+jKZG52kNoi3e?=
 =?us-ascii?Q?B6nY8rplWWsLRWohaJLqOFoqWpvQSf1roGDmFK+e7lfnODvKk8aeH9tFW7yK?=
 =?us-ascii?Q?YblPerEMdsJI75yQfceZ6bsecNC8Fqa0L12LKAMaFJ8LKVRbRA7BMeGe2t3J?=
 =?us-ascii?Q?XJLxOah0dwMDrzqAJsQHNSi15ULDy1lIexMEPGf6gieO77dEzdb6r0T453iU?=
 =?us-ascii?Q?4uEmo0asO8EvG/FxytU5aKFGgnxPIYj7eKDjI9fUH8DQ1vkdPrgPDGY13z9Z?=
 =?us-ascii?Q?ZombZgc2hVkcwBeAbI/Td2HHK1rM0mbLgeVCrXS5ONcM3qnyu4HColDAYYHr?=
 =?us-ascii?Q?yWUkzZkcfBkItqRjBqaO7i0QgyspKanEb4hb2/Gqh0gm5CgAbfxvqKWbBaRw?=
 =?us-ascii?Q?qkstxvAEXr9kz6hFlfdSw7RHHE9qXK1bMs34qdyr3o/FTKLin6mC3rs47Wzi?=
 =?us-ascii?Q?LkL9DieDx3XnBJZx34Iu3YGHQApwhYcwqTZ6Jui0Hqe+FbRADbhjUaZS1wLC?=
 =?us-ascii?Q?HABgv48YWJQGGovxDqi1nOeu/XRML4ejQvSDFPNZbU9c9qywbKGqFYvbzUk5?=
 =?us-ascii?Q?yoFTmQjhGprmJhMNGiGEzBJVCP4Q18f3UAMBp57umBcB0cb3ezdB7SM70MIV?=
 =?us-ascii?Q?0Cu8MWMFgQ64CALrZ6/zmRi9T4VTJLjv8SmnSXqah+7BRFFH36FFZBrKFSvE?=
 =?us-ascii?Q?mMjyd1eG6hthcAVr30la1luScJk3yZ0gPXJixdTCuZa3AHxr5rahCX8DiEKq?=
 =?us-ascii?Q?gZzPLo9eeZF+haKWeLuxbBDqalAVniIE5escL+vEiWroV0WHFFidJahD/yzc?=
 =?us-ascii?Q?b5JU5CMe7o9B8ZFP+qwI82v6eKzLeiNUvFgQj7TCGWsm9meTRCBhkIDajcR0?=
 =?us-ascii?Q?168UQIfbzz+KSfQMc0ms2QcVjDwxAJkP2sHkDTjxGG7ANc/zQCZ41nGMRuLN?=
 =?us-ascii?Q?JndrtPd+Grx2o/wwR+y5F7/hiQSMb1MB1oNWnW7+Q0KBImEaE7iJSi72gJDS?=
 =?us-ascii?Q?pLZ1LVdsw1PdHcgB4gsA3F9HFyvmjqtzYubP2AxD70wa8ZC/PnvDkSBbKPh+?=
 =?us-ascii?Q?KpJKDRVSgaBNGsPjDKgBa0JEdV8eGkio/6wOkeR+ZkM6nJb1fTSgcOaQX3dm?=
 =?us-ascii?Q?6V03PPU1vVgTZGaNrLVirFVz0bL9fWmyTHKexOhuHcRHcTfj4eSxpUSe22hj?=
 =?us-ascii?Q?bUBcCqLeTtRikq13AU1Bqt5BfcwEHld/6KNNmGMzDHfCX9EQj2MGYpxZpHIL?=
 =?us-ascii?Q?elxz4ojUs3NUJ/hZfT8+XAKX0ZhRsN/Mh5kOL+BqGqYC3HL1XLnRyRQ99N2E?=
 =?us-ascii?Q?3IGV+8fxYzARdw1ZW/t+lKhjl5YLqFpsthAonNEbft+Zw4ZZc205uCx6hJqH?=
 =?us-ascii?Q?1y/Jnp0/51IGYBCqzehMj+pjjte3C1PzXWLQE/cD8dfrpI/9KECpV4IahXJY?=
 =?us-ascii?Q?wYEQr3tmO6FsNWuZVm6KQ4gbu1XHwWxUf4ECLzlvSO/GbDwnV+vApsqW4vW6?=
 =?us-ascii?Q?2VT6b72HIi0498iSKgd+xuFBolQOT0evWoqCktICMDHKGF5DhoSX+CwTIuPN?=
 =?us-ascii?Q?S+riVO+nbTe8Y6yMKfKxkTcOUOmyJHPif0YE25gqBQRG/ihl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cabb317b-6c54-495a-19f1-08ded68347fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:40:46.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEJcIXn7mLSEJ41ycF0FE+LayXp7qVyGP4FEV8FHsXrEJ3rOac++kBYnYCudfy8cXcmDaJnx01zTA6i1akBs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11892

> Subject: Re: [PATCH V4 5/7] arm64: dts: imx8mq-evk: Move power supply
> properties to Root Port node
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s)
> to consider:
>=20
> New issues:
> - [Critical] DT ABI breakage: Removing `vpcie-supply` and `vpcie3v3aux-
> supply` from the PCIe controller node breaks PCIe functionality on older
> kernels.
>=20
> Pre-existing issues:
> - [High] Resource and memory leak of regulators and `slot->supplies` arra=
y in
> `slot_pwrctrl_probe` error paths and driver teardown.
> --
>=20
> commit 331966289ddb574974fd80a80b3f1214ffc7055f
> Author: Sherry Sun <sherry.sun@nxp.com>
>=20
> arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
>=20
> This commit moves the vpcie-supply and vpcie3v3aux-supply properties from
> the PCIe controller node to the Root Port child node. The change is inten=
ded
> to support the new PCI pwrctrl framework.
>=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > index e7d87ea81b697..541f6d5e9cefb 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -403,8 +403,6 @@ &pcie1 {
> >  		 <&pcie0_refclk>,
> >  		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
> >  		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
> > -	vpcie-supply =3D <&reg_pcie1>;
> > -	vpcie3v3aux-supply =3D <&reg_pcie1>;
>=20
> [Severity: Critical]
> Does removing these properties break DT ABI compatibility for older kerne=
ls?
>=20
> If an older kernel lacks the new PCI pwrctrl framework, its pci-imx6.c dr=
iver
> will look for vpcie-supply and vpcie3v3aux-supply in the parent PCIe
> controller node.
>=20
> Without pci-pwrctrl to enable the child node's supplies, the regulators m=
ight
> never be turned on, causing PCIe devices to fail probing.

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

Best Regards
Sherry
>=20
> >  	vph-supply =3D <&vgen5_reg>;
> >  	supports-clkreq;
> >  	status =3D "okay";
> > @@ -422,6 +420,8 @@ &pcie1_ep {
> >
> >  &pcie1_port0 {
> >  	reset-gpios =3D <&gpio5 12 GPIO_ACTIVE_LOW>;
> > +	vpcie3v3-supply =3D <&reg_pcie1>;
> > +	vpcie3v3aux-supply =3D <&reg_pcie1>;
> >  };
>=20
> [ ... ]
>=20
> [Severity: High]
> This is a pre-existing issue, but while reviewing the PCI pwrctrl framewo=
rk that
> this DT change supports, I noticed a potential resource leak in the probi=
ng
> path.
>=20
> In drivers/pci/pwrctrl/generic.c:slot_pwrctrl_probe():
>=20
>         slot->clk =3D devm_clk_get_optional(dev, NULL);
>         if (IS_ERR(slot->clk))
>                 return dev_err_probe(dev, PTR_ERR(slot->clk),
>                                      "Failed to enable slot clock\n");
>=20
> If devm_clk_get_optional() fails (e.g., returns -EPROBE_DEFER), does this
> return path leak the slot->supplies array allocated by
> of_regulator_bulk_get_all(), as well as the regulator references?
>=20
> Since devm_add_action_or_reset() has not yet been registered at this poin=
t, it
> appears the cleanup is skipped entirely on this failure path.
>=20
> Additionally, looking at the driver teardown path:
>=20
> drivers/pci/pwrctrl/generic.c:devm_slot_pwrctrl_release() {
>         struct slot_pwrctrl *slot =3D data;
>=20
>         regulator_bulk_free(slot->num_supplies, slot->supplies); }
>=20
> Does regulator_bulk_free() actually free the dynamically allocated array =
itself,
> or does it only drop the regulator references, leaving the
> slot->supplies array memory permanently leaked on unbind?
>=20
> --
> Sashiko AI
> review * https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2
> Fsashiko.dev%2F%23%2Fpatchset%2F20260630060710.3294811-1-
> sherry.sun%40oss.nxp.com%3Fpart%3D5&data=3D05%7C02%7Csherry.sun%40
> nxp.com%7C5311d8c218154e8ffbe308ded66fc10f%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C639183972638984127%7CUnknown%7CTWFpb
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zM
> iIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7QYi3LVOLx
> ie4fyAVD9bNp2FqeXTE%2F%2FtGorcdG1mVaI%3D&reserved=3D0

