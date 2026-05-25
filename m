Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877453D8132;
	Mon, 25 May 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697614; cv=fail; b=Vl3qxoKpIFuStmbgH/MyUF8t6+eFr1W5pOA2knKpQFqwx8GNqzRtdfuGEd+DP+pe9Usi84HmZxHX8zJFLCZkYMMjb6mw82WQuendsKhBrArQAcUVTtguPkQwWbhRE8EWk2KPML8J49JuVrOYatYlbcNcMm3a2567mBX1yC2IE0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697614; c=relaxed/simple;
	bh=Vr0U6A7OQ9VLz04ZNxiT7U+n8RB6hHk4fOlvFf7sF4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgJVVXbC/ECPceu1ahLFhRcH8B4v199LV9i/D2re0CB/NBg/+r/FjjyZeJJ2IeotbG0cta8qdbc94nmn+07SeS5otdHrZyhitSiSkJjjBybx37jjEXZdJMpbMcZ36SJRzPNomIhP7kEBHQjAKzVfzgrJUMjWKAFP47ZPzK0dmfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n8+8q4i1; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8+8q4i1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep/d4Vfms/C09ly5Sz8ixABV4Z5u9CgqL10Bgoj6E+1IOp6Dxq7GZhXEAq231SYd/bQGXY0MnJvMp+LyJL0CrYVDvG4w9Sac4UVE6iY+tNaVoyu66bfXkh78DDl25ScuPzIojVfaJBCRRn5ea2WGbJWGsubopUkUyVps+z5JCSbzneO5kz35UYfrbkxtWTaVjY1YQson+aGvP+WAHADG4pBU7AX++xTkZOF7rM1ejv5MGNZ8SBi4jTsYP410aykI+o4jdaYQr65PI7X2aumGWnvc0JB2pWR4xinrrYpG6QoV3sObslTV7WUxoWx0oby/DGSEN7hROK664+ZTtmtDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD8cHMwTTsDJudS9w+onYZ+IIJDdc4Gx2JkrJrLGW/s=;
 b=EMntHVDleWYet1NuXVa2uX18B5mS3OnV9lQ2QDZTp40NOyHmQ2bvYa5XHbn+AnZPjNgMJlBNJSjoNEqno0KoXS5wnOSXnX7CabF4dfgSz0FZf5aCc2pFlbSY9jd5yRq9ByNYGSdnKNfPjwrt75Ytc50Hmb8q7YvRZxTBxysdW269EzoULTc0LFi6FNBiM/ozQyUimNzTS1wa648ZJ3dQWuoKBz4dZcv7blSVlC3EZ9XEwv/iW4uNM/omcFIEIJe66s4Nob1YtLEKWtqmlmcB0aFcHHDYkhMlnOuURqjb1KYL0Za1EseVYiMK7wdyU3oTCYgGVq4q3F9bB9oSRySMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD8cHMwTTsDJudS9w+onYZ+IIJDdc4Gx2JkrJrLGW/s=;
 b=n8+8q4i1i+CYTh94q5IjWb6NE35n3T0zM+u7iwxonFDddyqunG/rHqDXBRB1zDl10tdttHtJeOGA7BP5Jia+GMjYNHc2tYDBPJIiofyfADDtOuhJxa3A+1hizcmyir8ko5uHZYGnw9ki0QSpcSksp0zuQGqVhxNZOvFEvZDHrvC+oKODgkgA4d2q+w8f+GySnW9Y0KPLIEoGFpwpBVj+kK0Nabwb1WC5qW8RAljoxDKsgL+8VNz0FpnFRhNQjNkSOewfjT/lflLSVfilkKUj2pxzwnNrW4EIeV21sh+HvRcqlH3taKQXUbrJPxZ5rfLuPGD4WSVjZ6ij5Mcl0QPNsA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV4PR04MB11330.eurprd04.prod.outlook.com
 (2603:10a6:150:29d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:26:48 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 08:26:48 +0000
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
Thread-Index: AQHc7BMOloflpNUHQEGIgUZmtHyR6LYeZ5rw
Date: Mon, 25 May 2026 08:26:48 +0000
Message-ID:
 <GV2PR04MB12019A85B10068D312D9386EA8C0A2@GV2PR04MB12019.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV4PR04MB11330:EE_
x-ms-office365-filtering-correlation-id: 917edb9a-eb25-4652-b076-08deba375d6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021|921020|18002099003|56012099003|22082099003|6133799003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 pi9DsELBgCWQ6Oe/I8V3+EL7qXxdiO/MQWQZhs/OhZpd3TC/dDgt5ETAzHoknWzT3ZMlrrkgjU2W3seCIVPxgosOPN5F59M8Go3bpDBJI8w8vg7tjXgNcf2JiPtcd7+iSAI635MyZjxZRwwf0r1XTAmI1gUg0rsUrLbRwGdgbTJ+56Jw3+pr8BotaVkvKCaDbtKSq6drdxtiWHJ9K8k+VZjOAvFhSuqo14uGxbe2Xu0imb2oSKuNygiolzalJ3admGnlnp9lloZD21XNvCB7zCtDLFfX5pWjR3IJ2DFa8d+slR9d08ewkL+uLTnIKDKMM79HIiHKrvQl2OCmulrmlnlXgBTtxRenHa5guc5d3rpqrwBBFJtdlLh+/uRTvISZWkVj4oKFti0AL5mwGX2UMqCdMpIFK5sT3/B8VPzRZ7WACPpwpgqjIz2BDWAMeunFt5gg7MQ/LjnWRQ8z/TW7Gux73mCRnFqSAfBcfCoqP7AhTtyLLB7CxG3333QWNuyFgicLKog/ILqAqrPYYJOXk4i2jveunBWixjY5nVVwDTURy6GqYFANS+NiIPNEG1WXqLV8+QdVTQ6b6HIvvvXXE3ITDcBuIik71HblObCyUKigUpb6At/HEo/VpiwPL7Bvw+c1CPOVUTZ6RwgC0LpXatThqlpGaT2U/00OffAZ1DHhjkEML+zqKJ0EZezmxaEfEbiK2p1Fjwg+xJTkgWTzW5NcQWskGD9CZCbuPRbn2dikq/i5Oujhq0YOve5aITUeEGJ1RDL3ttdG5QDAEjmPUg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021)(921020)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PjhKXX6xtBIhvr4f7VaQIjBKy8p3i6J47iSGEjEQhq4y1WXvu+fmywXOiNeE?=
 =?us-ascii?Q?TSFSTnIrI7ngzdziOqxsneBAL1JhAD+fGlRp5J0/eFRAJOwG+hidGlIIYDc0?=
 =?us-ascii?Q?tZlz6ogxFMZIgIgFUPGOlrzxCoQlpzoNhkkkWfbbayURzVX+TQnyAEVVki0C?=
 =?us-ascii?Q?ldWr7Y6W4UOj7VinBBtAMfB2gbavqfmDbe9/DWa/kcOyXv2M+i1JZpKmhd8k?=
 =?us-ascii?Q?xboiTMq5cfVQXTufBuw4d+hgoqm0OwZVgsQCU3AaMJpcwJiTVDLFTJavv9qd?=
 =?us-ascii?Q?ViQdES2YnuNcHN/Zk0rk22WboltqYBvjFQSgE0os7T5gqk2zt0zvMOZpPV+R?=
 =?us-ascii?Q?f5EuuKQaEgMHCa/QIkYZcNw7qNskB/tIPpicbXPMiROD4PF6qdj3bQpQOYXZ?=
 =?us-ascii?Q?QInUjU2Q47X3zV9Y/ctKpt3/fK67OFOQep6L47aQDRJ0CUlimHNsv7Y0vjMT?=
 =?us-ascii?Q?N3viLjYQAMzUhMR9heTOJT8SaN0GUW2g2ucH5WOIrWIeZ9uiBYjXkKOwDsnm?=
 =?us-ascii?Q?9G9fPeVHXLWd8RsyocYSJi2wfcHlhR7ByfWDYlG1JtB2dEWggg+ZUzpSJvvr?=
 =?us-ascii?Q?SOkPp7jET7DUm4cBuLcNmopcpdPl1UR5Ma/q4gEuO3MZda1qjQN2OglmsbIu?=
 =?us-ascii?Q?X7JLknWGLX47gLZI7Er75qdtMZK5aYpmls7tZjY8Pp0Bzl1K8U4BtAlASWIG?=
 =?us-ascii?Q?ruPdAMZDdvMWvkcqi26THmWnQYnyzHU2/iJQYwIiNDyG1wof8+ohw1CekYqi?=
 =?us-ascii?Q?KWajdKYj1wWfltAIKY4Bz8m47qWmdr3LGtQjpufOrhNz3RqbqttFdLClQy9E?=
 =?us-ascii?Q?ZmqEiRPMBxwx1I9v1i3l1YZEyeNZYALGnPHzLIl89R6oGs8IfvSMvbSB7iuo?=
 =?us-ascii?Q?pZ2KMRXm9QDp8UeVL7E4ngEbOe1FxszfgwG1wS3nHz+MwG2hUwli1ZlZeDY3?=
 =?us-ascii?Q?ae6V24AmR18TXpBfJqhs3rIHwgQPJwFlaAX5EJLaf3o6PlY7AVvyjY5hKg8K?=
 =?us-ascii?Q?IqGjkl9uD0M3z8bg3Mr9Gtb2rzJloNAd8fHje+d5YRbNkxc9yiN5qi3+UF8I?=
 =?us-ascii?Q?GYblGR+r8LKuXCtOeJd+OA4R7dOAqwPob1FR3N9kHjjfed8fQ/oLbqRwEDya?=
 =?us-ascii?Q?u8v06LW4O53e1U5W22nJrBEDPc4OaeakeeUL/mEApRIHMozwr0FOH1t6ogFu?=
 =?us-ascii?Q?yxl5IcQ3psj/qlRkom+DlZJZ8Y53RANPJ90ev1r2MXrLJxVOPGWvu43r8DwY?=
 =?us-ascii?Q?pj1X0cZWv0A0Ve4HIFlkzKwEcvp/lxCIGc6sULOZE1mmNunxoBGjdrva2YwR?=
 =?us-ascii?Q?fYz9Eh5Kzkbok2k0GhdEwgjjmQ+MmLSaOwugE89eJpvwZbC/1mg3Tbc0Moxk?=
 =?us-ascii?Q?KGdqh4knidUvGdrUl8G0FqMoRy8mZibtL4izPKTovL85JYVT7uCVx6BlrBEP?=
 =?us-ascii?Q?44l4+LXwlUT3xhov+AImxKOsfQjfM0udw+ozmRkNNrYFWPQf+rRJFAf1h4j3?=
 =?us-ascii?Q?wa9bQVOE6kI72Sjq6oqU/v84A+GoFL64GucGF23hDmMabyH9zpylMJI4dDCQ?=
 =?us-ascii?Q?9euvcSPp9Cj1JJFiYa7HgX7HnU8Z66ciNUGIjPFfN74jQwPfuj/P6ZQL8tzp?=
 =?us-ascii?Q?D6QjaRmiIaIKoBzC6SfoIOvEc6MXWDEARZhq8CWRz/RKkasdsGbDm7IZiHOk?=
 =?us-ascii?Q?SHicHSp68eP+H/+vlBM7/qcY0HIy6aZmpW2possz8rK9rp2S?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 917edb9a-eb25-4652-b076-08deba375d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 08:26:48.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahxBqoS2vNA4ocY9JU1OhFuBCG/5/iZ1xul17l50p4J7bLrX6AkPsZ9eOXIGNKQtd2XIm33+K6849xSALgOhCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11330


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

