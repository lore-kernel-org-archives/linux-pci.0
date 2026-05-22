Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AA35E921;
	Fri, 22 May 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429938; cv=fail; b=Dx6AiBOclQbIdcF90ThcFYzb6iInbcQnp62co1Ti4sH2gWXshtb5BpVAl3UfORDjZLNMyQf2Nrt9tZRgtuMbVKGAiZP3DX/HccblKFVmHphyC9M/11ut2oLfeDFNioLhMwz8oGV+TBJplZjzcyPtvSVk3rPp/wPdYBpYPq12TRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429938; c=relaxed/simple;
	bh=IU7rSx3HN39Bv2O7T7b1YqRj6NErzqHIDyrxokGl3oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUjnzqwhW1PgXn1Og9vjlc3l8jczDUHmSJ8yUVPtu7GuSb0BMHFu+JSKWh55/GPcy3dnm82xNNQgZUwbMyui06M8U9MX8Ha0PukoGaXYkfTjFw6bgm6593CaWQgxTxdAjqFoJqEr4hWpolReOuAWrv6IIAu8RmpWQm9K/RiBSEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FYl5v0O2; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYl5v0O2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flDPTt+5utGvr3zJZ6Wchjr/dYn+QoDhz+qilCJXE2ANtqxczEw3pP8YBOAen7vwlYjtCsGzmZeWLXKi2BLOumEQ4EN3HcdHBkx0TNgCzGGDY8jGdH0RGI7KnrBzyw88LzRqD849MFWHEz2FkOltScZDOCiQBVxzcwNhUyi5Uelo9Pdf8e873js0kxKBuCl6+f/Rz9cx0+/zWNfgDWtY1V0GMEA8rJEaE5LHXs9IpHW7GxwN/VoO+NnfE9K/Jg1J3jVuNGKcMuvqr7/NpAHHgvOVq/p66qHk76oNkk+DOZh/DUGRkHumm0s+6j1zIoVryY/pYIuozNNSeQAmxHodJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+juSAet/Zwlon3qomR9kDsNmMTQ2teZfhWRi9YSPSjQ=;
 b=bbQqH1fyEMyF0irm6wIEXFk9jrk98lTcUGFa5yUz5medkqOrf88560l73xjHrg4W7f0qS1j6pZ07IP78lpI+uoeTU5EhyQr18NZYThLDgZelIReSXFCFOlruAp0/abKxJ1Z4WrGNcBQkJ4BJqLqUFHIqRzSdA0KOTvsAPw3tQOGbUNJDyVfSPr4dti04r0UtETzIJK/9fXEm19Re6S/r/EIy5Doda5vxoWQQj79m1RPfuFkO5MFv1AnKq63YzhuQRI5P2vRS2IBSnPby7seX3CqvEziHRBpDYWtlN+5QEgaO0VdXP1U2vfJ+mAxmhx70tcuPqV4WpjFhqpyyn7XGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+juSAet/Zwlon3qomR9kDsNmMTQ2teZfhWRi9YSPSjQ=;
 b=FYl5v0O2NV60QjOgeJWuQlJFjsYAixH95RjgSvG0YnwSst4FIac3lgocmCBcutw5MCWoE6ww3c03jIgqFdBFbcsgllJsVXa8haT4wa9wHa3woSb2ZfWUARbJM7ARrag3Iyvc86sRBiH+fSpiLq/KwAqBif6EnbInsHJ901CUPJJeJM5GS4bfx0ITHAqtg/I2S0W4kayll7SJmrjmey1RYTCWDUBZjYdVOiIPUxjaR7Yaqcawo/d9pDCl463qPewyqlVPdeHq7mBlBQqL2gvcNd++xviQ62+cnPJBOoZImqfR/M+3TscIxCdVyZrqo5XNFV0zxgrpnkrjLLvFBXUu0g==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA4PR04MB7869.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:05:34 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:05:34 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"will@kernel.org" <will@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sherry Sun <sherry.sun@nxp.com>
Subject: RE: [PATCH 1/2] PCI: host-generic: Simplify return value handling in
 pci_host_common_parse_port(s)
Thread-Topic: [PATCH 1/2] PCI: host-generic: Simplify return value handling in
 pci_host_common_parse_port(s)
Thread-Index: AQHc6Zzix299uPe6xkG4ICph0s6Dx7YZio0g
Date: Fri, 22 May 2026 06:05:33 +0000
Message-ID:
 <GV2PR04MB12019D8D1854A947AA7DDE1208C0F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
 <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
In-Reply-To: <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA4PR04MB7869:EE_
x-ms-office365-filtering-correlation-id: d4991da1-fc7c-49d3-5474-08deb7c822e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|4143699003|11063799006|6133799003|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 HYMEElXVaiVePqK3AOlTZh7xl2ZBgdHAOx7ynGS2tzdyKlMOQg6ccpU2nkV7mb2TvZ08rk3zO2YO2icrzS0wkbIqu0fngrip+EXA8+3wBsK/DLuF24vzdh3yP16S+ilY+XSBNP3dIlZUHc+FqixSmuhuEdQ3Z32Pf9xNZKaNT6tuwvOxHOdjQlxh0t6ArKKyfYP+jmHlVdV0kKTBhmSVPrD4LOPmAMK31C5/YDgC/MjLm0jxXQ2fud+gM6Xq+uR2Ri7+She40CMihz31iIQulx5pW98JW6D14As5B7pJ3oXwtmlXay0UcqmlOsUUL9JFZgHZCM2w42xG2QH/z2j6g7EE94INIYYYKgByh9VO6H3VFz3imVo9mPcubYuqUIPeuY/aGacojh/gjt4LA5eQ751dOxBM8LAsjV3iF8jeq9/Ywm81OBQaN2K8OtdKxGpdv/PqJfVHL9plz2bUr3El6ToHuBHlYbbmVolGBaQFeRL6HWckrX3V6rcqNft2PGyGgODZoJ+q8krluS3TivouAOewevBXuRtgfBZmP4TVjGxXH7WI7BzRl60bxmNhV5hQI5C1ncVNPy3wRevEz+urF1ibg6xZlqv32ZgdmQazLeO9jp9ds0WIAo57gPB+Hv/+mWdhzHn2GBgqMrNtnQt6gQCcUHkA0qPE9hukqD01lie9FHDBKnDD+l3NuBKvFx8F9lubk0WVKsRV2XKXLGhArxSuyZqtNVBcRfbuJBnu7lT0MI+AhAl/gsKCyzqONzHUFK7W/GBmZ0R5KH5EQa2SWg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OfzTN6V4sVB8wH2deZCYlL9E0/daNUrQ+FqO9F5B2yBlvWaVVH0L/c7iCuvZ?=
 =?us-ascii?Q?kqnR9KImOScQ6XWfYSyZhoFRdE257e3/WkzVtK5VJIenk7HfWYmD6iDN5yYR?=
 =?us-ascii?Q?NJqGIZZV/K1NOpHs8MyQ/csYLUcxETHOQGVlJMspSS1z7BIdlOoZTaW/tvyj?=
 =?us-ascii?Q?1yWhja0y1qV6pMh8dFDl5BLkRAgl1H6TZlOtqbkHjjANvOcJA1OI+J2NlBuX?=
 =?us-ascii?Q?sPWsi/CwnYM57eknv4THWw/EormG07eJ1iTiA2HzbwFW0/KY00BJn2aeVsrK?=
 =?us-ascii?Q?4BHpRrS6f+xxR906o1MVg00Jr4PX/mPgM8fyr2ArdLP8jWZyXTPKtWWw/J2p?=
 =?us-ascii?Q?uQeJRyC0MEYQRWZyW5B537tpR15vxXVhdcZx971uqxrb1qDPPQRzc0MIkb5K?=
 =?us-ascii?Q?SLxvT9AiBzFOx/oMkflj8fdyU8+glLhVwK0FutsMBkmXA2cwAbtwrrnFi6qJ?=
 =?us-ascii?Q?6/4kGoRQ/A4ej+skBeGS+ixpGCyHGpmAJ1ZxXn0ZVwKmfn7CQHMIPRYDDLu7?=
 =?us-ascii?Q?o20n0B+jmanqdsde5Fzk2oxojLskSrANVDfntOSMzMfwF3iV4R0jmdiwjgLV?=
 =?us-ascii?Q?a2Ipzf5hL7LKCpMhOQaTQcMuONBjDxRv6AU81TZafhWZcCNd7mJyCXbcp77j?=
 =?us-ascii?Q?b8RdqJ010lEdxM58osYuqqJD7hKWK2w2VTPtWxGJY32v/iCNT02raUShZusa?=
 =?us-ascii?Q?0AONccTYm8of4cnGjOqEjPhoiVsGxAacGYPWgvtdRLALbnHSiLJoHjXQM7gJ?=
 =?us-ascii?Q?dhvMVU1yCgE9jc8CIhGtD/ywrOiMgENnoADyqVg3CvS26s2dS/nlleQXsB0g?=
 =?us-ascii?Q?Z3EyQujZoJ1tIiXKj9n7U0oNJln108Gba3HUORXFz/hCX1bioPb40DE61za6?=
 =?us-ascii?Q?LtEVsKPhrjmZhBKyRhY7YXgPmPVy1Wz8prN1Olqyea/oh6PK0pmmnIoiGSns?=
 =?us-ascii?Q?ANgCOxewxU53LWQjnejTZbvSusyfYterVrtPTnkhjUHSPNVSDUK/HK7tAkSF?=
 =?us-ascii?Q?nRPRGAWpaIBL6BQYunWeP4gtlo6QGtWFtBkMIrfMLoykhxplCSX+QzsIb5TF?=
 =?us-ascii?Q?6/x+kHtJg/hVirHtdvxxADspyzZAKpSWjVaqO9O4tvjZzhkUSkr+6NUvYRYm?=
 =?us-ascii?Q?NYwotcwr/g02+jmtWlXik2JnYa8hSnwvC8Y5TEuUmFjvYseKQP37eF+u45Ht?=
 =?us-ascii?Q?LgcX7LeirTGdJg8y2W8a48i6cNVhqosygcPIdthIrH6EXeFmxI5XmVFFy1DB?=
 =?us-ascii?Q?QDU4gBeDe/ECUGItW2+8S5F9hZWKW3j/cUtxW/ePq7WsZWpblf8evAmY67Y+?=
 =?us-ascii?Q?A6ADS+VoH5UR78ku0rRV2yctFkMCu4t1Rx5mE114POyYSOb18HQtOc4kccPR?=
 =?us-ascii?Q?W2fXv3vYivQKiWQxU3qneNMlnRiFEof+xPyomIhcCzHE9IHoA424cRC1Amyb?=
 =?us-ascii?Q?JLi5Y2O9ZcUNxES1dWOgsE+4EvDHK2Lz5I82pfcXb3J4nA/8VKr8qdtdx/8R?=
 =?us-ascii?Q?r6G1Yq4TtcTI/Vqzs0WvgKi1Y4IcgVKIMZgNm9KZDkrpM5kqC8K1Cz2diiCa?=
 =?us-ascii?Q?CO7XCBzSxX1K882G5JTSpyL3EOMGQZiOfsNXB6+oEV4BH6nhQ9GqXT5wvPG2?=
 =?us-ascii?Q?OA6eIxCAEbB9b4ljCeZ3/yZKJmlw+7ahrOBEPw3xz7SznCsuIsbU7Os8LugT?=
 =?us-ascii?Q?0tmqfGizIihOlHFcSuca2AF0pDixfe8CMJzhnsRvuCtZ2Us+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4991da1-fc7c-49d3-5474-08deb7c822e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:05:33.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cF08DX1aLIf2xtYs1vGdRN52leRWmML7Zw3EzBC3bPoEUP0qm1WmbY+LoTzuqwGXJaSJ7Q1i6iUl3ypQRGLSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869

> -----Original Message-----
> From: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
> Sent: Friday, May 22, 2026 11:44 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de; Frank Li
> <frank.li@nxp.com>; bhelgaas@google.com; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> will@kernel.org
> Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sherry Sun
> <sherry.sun@nxp.com>
> Subject: [PATCH 1/2] PCI: host-generic: Simplify return value handling in
> pci_host_common_parse_port(s)
>=20
> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> The pci_host_common_parse_port() shouldn't check the RC-level binding.
> That's a policy decision that belongs to the caller, not this common help=
er.
>=20
> Simplify pci_host_common_parse_port() to only parses properties from the =
Root
"to only parses"/s/"to only parse"

> Port(and its children) without checking the RC node. Also change
Missing space after "Port".

> pci_host_common_parse_ports() to return 0 when no ports are found, since =
it is
> not an error.
>=20
> So now both functions won't return failure for "property not found" or "p=
ort not
> found", they purely returns 0 on success and a negative error code on rea=
l
returns/s/return

Best Regards
Richard Zhu

> failures.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 29 ++++--------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-
> host-common.c
> index 67455caaf9e6..7ce5a939e3d9 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -108,8 +108,7 @@ static int pci_host_common_parse_perst(struct device
> *dev,
>   * dependencies and the driver may fail to operate if required resources
>   * are missing.
>   *
> - * Return: 0 on success, -ENODEV if PERST# found in RC node (legacy bind=
ing
> - * should be used), Other negative error codes on failure.
> + * Return: 0 on success, negative error codes on failure.
>   */
>  static int pci_host_common_parse_port(struct device *dev,
>  				      struct pci_host_bridge *bridge, @@ -128,22
> +127,6 @@ static int pci_host_common_parse_port(struct device *dev,
>  	if (ret)
>  		return ret;
>=20
> -	/*
> -	 * 1. PERST# found in RP or its child nodes - list is not empty,
> -	 *    continue
> -	 *
> -	 * 2. PERST# not found in RP/children, but found in RC node -
> -	 *    return -ENODEV to fallback legacy binding
> -	 *
> -	 * 3. PERST# not found anywhere - list is empty, continue (optional
> -	 *    PERST#)
> -	 */
> -	if (list_empty(&port->perst)) {
> -		if (of_property_present(dev->of_node, "reset-gpios") ||
> -		    of_property_present(dev->of_node, "reset-gpio"))
> -			return -ENODEV;
> -	}
> -
>  	INIT_LIST_HEAD(&port->list);
>  	list_add_tail(&port->list, &bridge->ports);
>=20
> @@ -158,13 +141,11 @@ static int pci_host_common_parse_port(struct device
> *dev,
>   * Iterate through child nodes of the host bridge and parse Root Port
>   * properties (currently only reset GPIOs).
>   *
> - * Return: 0 on success, -ENODEV if no ports found or PERST# found in RC
> - * node (legacy binding should be used), Other negative error codes on
> - * failure.
> + * Return: 0 on success, negative error codes on failure.
>   */
>  int pci_host_common_parse_ports(struct device *dev, struct pci_host_brid=
ge
> *bridge)  {
> -	int ret =3D -ENODEV;
> +	int ret =3D 0;
>=20
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		if (!of_node_is_type(of_port, "pci")) @@ -174,8 +155,8 @@ int
> pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *b=
rid
>  			goto err_cleanup;
>  	}
>=20
> -	if (ret)
> -		return ret;
> +	if (list_empty(&bridge->ports))
> +		return 0;
>=20
>  	return devm_add_action_or_reset(dev, pci_host_common_delete_ports,
>  					&bridge->ports);
> --
> 2.37.1

