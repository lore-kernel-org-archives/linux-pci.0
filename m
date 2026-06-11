Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A6367B6A;
	Thu, 11 Jun 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163648; cv=fail; b=gNKSUbW9H3KGilHiy++QNu4Xi2RvpP1wP4bmtOfIDygpBEVbXl45py1GP8cXEKMfg6ggxFxrHtulRSEk9qo1qZeiLsTl/Azu6t128Ub4MH/Xmqws72CBsh2ePb4AJPNI6kaBsrKum7R2kGq7bG7oJfxqgRjzZzn9HkaKUX77x68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163648; c=relaxed/simple;
	bh=etRBDGRmD9ykJaBVT8g26O6RCgkwL7EaWryPdiYUEJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NX6ksoEZfmH+Zesu/2DgQLZ3EvKE+XMAd25vXHwAq1hnc3GM7giYThTXpHFqom+z3qvYzGtxKRhn7A+Udx8XCtxane0ksYJug91BAFklfsZRucQmB08aO9H/1ZGiCkUvCSVeiV6bnT1/TVNdlOqLqrroUfL46cA+zjQ5Pved8NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PvwKTwPC; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PvwKTwPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrX46ju/wJmg8JMBX+fPl9ZMTFA8ipGjj3xeA+RJ1j/qnndAuNX/9bwVLqr0BUGxQZLee8TngSeKJMFkFoQYb03i7dLn4YxRuNTV6kK35W9hDAny9lqcb04WSD1TL+pzvSIfqwukFAKASlBpwlYkxE96eAZ78M64Gn/D1YQqdgOiEkTwcYzn4ZM5zYi6R7ZH4ZM7b1OAFj0WahICSo0uD+Qt8q6kiazBDUrqL0kWOI9bkI0vmHSH/SWTRNMFe8ScYsUV/6q0Iz4pDAayKU0DZA8App/F5Kivj9LCJog91Na+zA+S74DiIJbUjzWj5VQvdR6bt45pzJ9UYLH9L0lfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+SCy6sdDa2GKaANRDUnqJL/3XOcl4afiM9hCEv6wsw=;
 b=lFPgboleoLNcmH+GSlAyFPksKDJ+MDtLxkr3uzth0Y6qNjA3NjvaamhA+rOr+ihYwyWDB3+MuIhqlBjgVdzEJex2KFwtjR9iBxwjjw/8s3wBdKvHlUxrsDUOOSyALs1BEdKGbIPz41EYAnCSs4flGR1faI06DgtNui5EeH2jUHK/VMZ3cQcHYQwrVhoc60f5TwPVsVkXLToeAtSwBlXIa4rbO/rJfrV+wcHodtN4K+WTzPSZkHwYSFzsqiRDPyF73hSEROVsxJYrdMBqjMpW+bVsf6BElbVSCGQ/r4Mbe3AFE6lf4eNva4mX2qy6fCDtgUfUNBJi+thauVTCnpRcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+SCy6sdDa2GKaANRDUnqJL/3XOcl4afiM9hCEv6wsw=;
 b=PvwKTwPCy9KNGckI7OH3rufyAVaxMstPzZ4VeI3LO+HOXwP1zN/P43vvpDpItNTgDgTH4Ul/DgtcqagbTdhfiCT4TSyd+kL8qr8iwcCstm0UtN8tNBwcy6d2ZinShAeeIyHe6U0uAw/nJyZVxYPXFRZ8EwFbK89efxvMZ1jyhfcgUdvWrVfX9GHcKuMl09V2+kJ7Yf5Ei2ul8ESexnLh85ovI+cP4LolzmVM4mWoYBCLsY6XbppBHxz5UbCYF4qiy1E7BFJeinuIgQwk99n/1zKGLCqRArOAq3yF1uzMolT9XLYWZv+qBtIt1zwvq90W9MrxybmKCwQ5D2sKDIKiKg==
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by DU4PR04MB10981.eurprd04.prod.outlook.com
 (2603:10a6:10:58d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 07:40:43 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 07:40:43 +0000
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
Subject: RE: [PATCH V2 1/2] PCI: host-generic: Simplify return value handling
 in pci_host_common_parse_port(s)
Thread-Topic: [PATCH V2 1/2] PCI: host-generic: Simplify return value handling
 in pci_host_common_parse_port(s)
Thread-Index: AQHc7BMOloflpNUHQEGIgUZmtHyR6LY5Er1g
Date: Thu, 11 Jun 2026 07:40:43 +0000
Message-ID:
 <VI0PR04MB12008455D815DE3506169595D8C1B2@VI0PR04MB12008.eurprd04.prod.outlook.com>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
 <20260525065443.2338629-2-sherry.sun@oss.nxp.com>
In-Reply-To: <20260525065443.2338629-2-sherry.sun@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12008:EE_|DU4PR04MB10981:EE_
x-ms-office365-filtering-correlation-id: 33fab03a-72f9-40f2-d658-08dec78cbe62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|23010399003|38070700021|6133799003|18002099003|22082099003|921020|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 hDPVYkaEiyrKAyztxV/pmoQsHqBk860ZLN0SSn42DtnVwf2HAM/tJ1ifB+FNrNuOX4wTPgLKXGoQF7ngXPI16irUmoMC5c31Va2NKJEYJKRiwQPsZ7odBiUcpy7swocwwrCS/GKM6o2prkzWRbaxN5ZvpCHxeSEHfYg3D+N5ks3Ryh/IfkcYshYePTJwyEvfkTqAWOktYsOWhDZQHiOwfFktFLpXJbG6LDKlIx1fGqhA8wW+kl5AsuhcglA0QpkLuYHKxePPNCSIM65ZOYY67p3WB0iw/84IOZtUkmvyztpz9c4s+44zpSWyFyd9McaTdygzA3c23Odjoj/KjscBVg3s4pFbTyX2D5I8ZJzomF4vGB7eaZT5ixC8SQHDEJio/eP04gRsGrV3cxwHKv8Yvi2zl5zufWz3YF7FkYQyx+YsIUU2UB4b7YbCwb1uyIEIEjSEwBMrjY1Fsak2dHsSzlhW/cG4Z+/xHUyO/WJNSWA1Dj1JeSgI7RlcXf2dcPTTEoz4Ea7LALbx52a6dLMvRAPZ/KzWrWdQdD2Zw5LJpTH5swDC45Df7cDd7m5MBJ+VLRgPpjR5WuLfZXMKfoPSKM6uBoCmKh2Sskyo+AQnJtw3889XjXkYexTh/zVpVyYQpvNWBZQGDzUdzUiw3ejxdvQuxmOj3G7Grn2gy43lyh3wX5HS90idR966LZ9+dTi32W9jTRC8XD7lG55VJSF+l8BAncLGIJJNpIWfnQFylEvgbbLdsHneo8rnmGRQ4cRJQpNhbdVkSLTC+66+mMCWUw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jDEZUhjW/S6A6uW19N7XLnVk+UPH9K0gEDMxZni39HPk2RQp44X7m0/bCVtD?=
 =?us-ascii?Q?0WvntV55o/IOJFPUA+0oCyB9cGdRR9G7pyYhLca/doK0FBZQIQUrLw/2ILWI?=
 =?us-ascii?Q?0piFcSzfaYgC5cXuLhIJJBRSpa3HJP+3fnAccvH4hXO60Jqp5I3z/NSrm9aw?=
 =?us-ascii?Q?84Gjs6wkAv21J8Rm/5VUXXbZrgVhzYXWMEJVJEdmbPMjRLTbv9/cFP5bae1N?=
 =?us-ascii?Q?hqzaTCswrhs7ecUEzxoNUxLQynYs5WsX5DESnuJ/+TYNQrgQpy/kDhhsEyvW?=
 =?us-ascii?Q?UEZrS8XV3Kc0uN6qW3Gq/nVygESH05Ih7ymTBuAaM+8VGzvrzv5LBx8hLKd9?=
 =?us-ascii?Q?TPumhDUStTMY/leOKqeUleXko1jFMI59USLjIkFz3vFR09/Dsc+3Dl6e3/HL?=
 =?us-ascii?Q?wkbIDRhenWGoV/RK5eNu7yHQnzsdTNzcZeSzC9LIvt8+4P1chQfJIS5K19RR?=
 =?us-ascii?Q?skYw7FaQoiEOqXSOhJSB9rAT3kI/EVZVM3+gz99/U0RHkMxqVy0Euswr5sv8?=
 =?us-ascii?Q?4HAERalGsAC6Yij6aa/af9BLpJlRYZ8S9MIe0gouxF0dbNnCNDmEMXuOoX0B?=
 =?us-ascii?Q?BfX5eXEU7Y7rpB4X98VrLkqgb/6yUxigiuynp44tyVxUH8zo+6fNOu6jaraU?=
 =?us-ascii?Q?qSdOy65xLUmSetrkOM8mI+6Yc2iOsYPdcwLUwO8p/QUTjTIOQH3qtUhch9WC?=
 =?us-ascii?Q?mtiFdDHygPigQusOudIdWg+DLbOIrh5jaEn4hdIgAKBy+/D19DRl1l9DxWFw?=
 =?us-ascii?Q?19zGksuvA/2WKfaNRJZxSxpUk7FqZM8cgKNcSKtrrtpmU+u0CcCs7G3H90N6?=
 =?us-ascii?Q?IjgjZLKplL4TUs1Deoxm8BvVNrfmmq8JyCOYumIlTAIZ9SK0GOKu2vV8dew0?=
 =?us-ascii?Q?fx0KQiwuAyDAiAA7tXPBVginnCDhJHsnERVytZR9dojMV25G9nJfChflzfiC?=
 =?us-ascii?Q?B8s7id2RC97mqSs3Zv+jBFMRDsS83rcwUNcKkC7wSHYh3k5GO4YVWuZ29hz9?=
 =?us-ascii?Q?+IVn4NB8ZT7xGKKjUVONQHY+0nAxriWhPqASuyX4bCSikal5OcyJEm2/d2CX?=
 =?us-ascii?Q?1DpMQwtEbYsQi+UU+insD0fBXShut/fdBbnhto1WWx/aXfhHUsJyygMTYRdv?=
 =?us-ascii?Q?aMPhtTv3g0Vei0p2ZRZhRrtRnayn3yxFmoUS0s6xP4zHRekmW8rRX9010Hsd?=
 =?us-ascii?Q?fyU1wNdi0dKJNeiLk/ylyHPvzOA6/f+2or16DA4VzCkQ5uBUaa8zvWURuMpS?=
 =?us-ascii?Q?l5ZC3d917jjIm7SUSq9a1qcIdAFvNG0a8UXReMkTXyEUXHput7/eKjRN7/IH?=
 =?us-ascii?Q?iMAXj29bCiSDofK2E5lyGfFOm+cDsWWQus+iI4J7qGO00Oze/z33Be63Hh3m?=
 =?us-ascii?Q?3svWitOcAm4vxpqFk9bsz0sQNK/IHx7uFlh4XOYS69C7TKpAz7bTWr6zk/Zc?=
 =?us-ascii?Q?RAx3TlXbbt/fnmquMCtvJbkxF8gLK7kALPXRhRhsDTqAo/wysI0wvfIWcK4p?=
 =?us-ascii?Q?H4Gat43TUPTDHkQDvAP+7OYOWbQ26ZipyMcDaYcyTXARMUU5EIrvw80UoXa8?=
 =?us-ascii?Q?ERbKa5gIOGILW2h8XcVddgOepNhVA8tqAACrZlyfdLfPTdCo3TiSF4BOf3aV?=
 =?us-ascii?Q?5Ra49/hxnGVDCpFlFkKBJydadxtf7W+N2aAX++b3bDhbRqan1Xlr9m2Pk6ER?=
 =?us-ascii?Q?+6v2ZEjX5P/KhFgjVSIpHj6fZtrqF44S2oE665eFsoU6X9S3?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fab03a-72f9-40f2-d658-08dec78cbe62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 07:40:43.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecSlLWo7oWJ46/vg7IxHJOzgQf17Xx+2Mswtjfq8XHmbEeIfUR/lalhc3WZyIwIDk1QY9EFu278bbxnWCLIpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

> -----Original Message-----
> From: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
> Sent: Monday, May 25, 2026 2:55 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de; Frank Li
> <frank.li@nxp.com>; bhelgaas@google.com; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> will@kernel.org
> Cc: imx@lists.linux.dev; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sherry Sun
> <sherry.sun@nxp.com>
> Subject: [PATCH V2 1/2] PCI: host-generic: Simplify return value handling=
 in
> pci_host_common_parse_port(s)
>=20
> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> The pci_host_common_parse_port() shouldn't check the RC-level binding.
> That's a policy decision that belongs to the caller, not this common help=
er.
>=20
> Simplify pci_host_common_parse_port() to only parse properties from the R=
oot
> Port (and its children) without checking the RC node. Also change
> pci_host_common_parse_ports() to return 0 when no ports are found, since =
it is
> not an error.
>=20
> So now both functions won't return failure for "property not found" or "p=
ort not
> found", they purely return 0 on success and a negative error code on real=
 failures.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu

> ---
>  drivers/pci/controller/pci-host-common.c | 29 ++++--------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-
> host-common.c
> index 2ce6f4b66133..c93de5a10758 100644
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

