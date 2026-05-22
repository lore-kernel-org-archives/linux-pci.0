Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7A382F28;
	Fri, 22 May 2026 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429936; cv=fail; b=RY5wz0yBbknGqHws1V6f4ciCs1r2th+F/48mxkn8yLqz6OmJzEedyg3zCf6WiiY63yP8/tHuFWQMdYVay+g23cL9/cP+GJ9tjE8zQjDAh0kRPNEWi+3PvENxWdMH5rghiRlibFGrbAismA4R9Czbh1a5Uaxr5gTJ+ep80E5dJv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429936; c=relaxed/simple;
	bh=zD18MOrv7W2tdBjJt77PJrdPCXlx3zkUrXlu8dYD0aU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/VQ1bW/Khum7irmJjb2tcM3rNHCj2EDXDE7oC1gQYiljDxdBPoo5FF22TyeSIguP236lpQgrS2J0XTsb2d3O7rdGrsrGwvPyT8ONFqo2Owpv/G4UEQyOgNBKObumRy7Lx6MR7Tvel+Hz+Mf77AzSwYbxbjeUETBLTMsURcWOqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nWgZFUw6; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWgZFUw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFa+Pt02vWGze4Alyt3BBY3A72x0EeABTIxMIbz6+llBa+/qybNwrB/6BYAPtVQZkd5c6I43QBI/bRPanVQNT+Lt3ntT0EfSs/SjANHbBQ3yc/bn+ez46fHU6EU/gzfEfeVluUDTeiNFHRh6nroic/NesQM5VCjapkRnSZ7pGe99oUbYxh15+oHFd5k86pnEwKR5n29SHzkZapFJOqWC+OibBaIuIIo2HLC1nJFvrxmy7tkwMfokCjUhMAPYQ8zHtTI58vyj23k5aIViGW2vvi83M+huSt8rehWuDrVQyGFwbIxtIZpRAloeEwUe3o78iEfFQa+Ig0Hon4E4UmEoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKrdf7A8WpKRDpufdhbkk3K7qUS8K2CrRW8RyayHTLs=;
 b=IkXZYjqXYfee4e1mPLyV29/ccsVh2JWMYLXC7oTUN/SeAVfmWhcCGX6l0R2zWn35J7Xu6U+vSTCiU7+YtlwOyrFTvWxlPasWeKtobVLrGyNBHcZG8gjOTMhcGaxf0LQZiRnVHK5gEt6XwcHFtHM3udU0dBUtX1B9tk0bmRJSQUNOZjMu4jfCB8uS6d0jt7TE/X9whXOzmkEcPdPNBlMNC1J6pAo8fuGln7bTyXrptXxaMKIjK6bJsfs36cjF//+hJAtdHk8JF43SXoHdoTanNh/D0r8xUUrc1vFlUW0BvPWiTWyb6UNq3wCgLdu4kO/L5tScCXy/iPNmTYB3A63qEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKrdf7A8WpKRDpufdhbkk3K7qUS8K2CrRW8RyayHTLs=;
 b=nWgZFUw6pWaa1cA2/z+GEieu0Es3YuV41M61mk8bjSXccyvuz8H5O473lRnEnN9bdrDDml5RM+5pfrvGJjn5omrxA7QmU1Z8Hhq1jZmR7e5FoFFozzkoQHp1Yz5UTDQzindn5oewN+uNMb8i/Cfng9EmOPeouLbf05xdFRkpuDMXKVopSH7rUsHUKTqrVEBQ/oyKpto6uG64UpoxIIhn5VdjiSPavn7gIAHRM7r7gfpnvKqdMUE+842PjV+3+2SdjzFbehAt+cQ6riNk2t8U4tVxYzvq6qg7UOiHjsQgrVzbslu9MgcGxfnjCP3p0H1fak8xYy4+yqSjrnGuGvzXgg==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by PA4PR04MB7869.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:05:30 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:05:30 +0000
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
Subject: RE: [PATCH 2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the
 parsed result
Thread-Topic: [PATCH 2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the
 parsed result
Thread-Index: AQHc6ZzmKaqft7YR+ECuAdqXe4x1QbYZjidg
Date: Fri, 22 May 2026 06:05:30 +0000
Message-ID:
 <GV2PR04MB1201955B94C21CF013F1550168C0F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
 <20260522034344.1147775-3-sherry.sun@oss.nxp.com>
In-Reply-To: <20260522034344.1147775-3-sherry.sun@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|PA4PR04MB7869:EE_
x-ms-office365-filtering-correlation-id: 9eb3c1c3-462a-4018-8ae8-08deb7c820d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|4143699003|11063799006|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 S0vSwShEebcDxbEL7zqEk0dogIw7GkLhKsyeF+fQ8nkwcV7eD1/yPxoc642jmdGXB6ewvbw7cHvuO22smWY0jZDOM+/fqZjNlWnkpwjV9WJ6nVTlWHhmhq7oVy71JCRsFjRk/ru+/GbYI1bduWlJDkj0OB/Rzhu9ja8wMu0CGUvKQjbNjWfczZ1nZKrc9dc0YUHOX6ec2q8WvXnoQv1BPOI9e8h3R5xVGRJmv5LSO5ikd4BfCLsGQnUlRieW0ClnkyCn0hpJ9HTW0WZA9NKDtQAacYOxICmQY6xCnMdFBiaKmSnkGDu+Kchieh4fodIESEMu56hQBjUhNBu7ZeVswBPl3wqeNLcFhub3E6VerF4wuTlZHCA9viXHhg8RgEuUPOiypK3lvJmMx6IMdqHzlNWHdVFaAhb6KxrhwytFlGL7iFyFbUlQZ53JwZPjJQdcXFbV9RYMcTYl+GWNZwTYYOo67Z8Bi8UZ9FCmV6FG/UxboM3zSyDnVnEK22J0UJX5Hlh7Nc0y6HkUOmNo38KjVRHDeKuOHcE6PPWxgZDUteeL2wPxncqcFaJQMleRaHG0K2NTynGdCRx5yWVO/txqSUtGYPkDXkCIkeozyP8GNWsLSXrOLcIpf6nYONwl8ViIeob0JbXvXn2n+/XoDJ3gBtZh3tWYTstXzkFDQdUTUe3CcWfO/65S085cogQSOb2n9nph5N05GwMWewQ5o4k/uyQFn+ZEZF51SDV5ssgVPTHUjnMCsbM2GLxv5p0mKHjTL3cjEgClWbyOFJLa3FwUtQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RXXJ+LaJrv6l1ym8gLyikr+4Qeuo5cF7/034IqjNNTb90AtA075YqGfqCTXI?=
 =?us-ascii?Q?EsqY1Whkznsdd3/mXVOICq9qNRNhcI7AQfUNRUHvY3KK/KW/Bbb1MnnZ/ms+?=
 =?us-ascii?Q?XovzwTNa0fYlmZ554zTzNJsSBnxggX+mJAdmIb5g57g4C7mGBCMQuRHVPvWJ?=
 =?us-ascii?Q?vKFhmYBApAHvkIYrisXRH+j6McLY9Duy5xeY2yZU8KQZMIAOisR0g4+DB3iS?=
 =?us-ascii?Q?P/BZQFcOSZgufkSGXhQmiVxLy53vmvZqZZ39ymWrVI3b/eqRa7/uBFvCyz/x?=
 =?us-ascii?Q?vLrbrzikTW7x6o8AipsUg/PJxyOnBVRdXg+R4Z9nH6Q2LjBU/b4PrUQXQF5J?=
 =?us-ascii?Q?a4htaiQu1nct4cObDa/LAX/g9Gc/FfkJGWftpw/ibbP88BvBY8LnE90D9iDO?=
 =?us-ascii?Q?07PYFqlbhnaNE2hqfjuDUMqsgPE/rf6kGCLwljy9/URg0piXeevhx33rGdHl?=
 =?us-ascii?Q?1JqZIyx+aHvF5FuyEe15ZTUsc5XcnYyXj0P/Z9dw01TqV63hr70hNpZNs2uV?=
 =?us-ascii?Q?ZZwvij2uVx5tE6bG7qJMs41BlA6iV6QO19aH2MaE3i7UPRl1c7/vjkA7f864?=
 =?us-ascii?Q?XIJ/bcgMCVLWl3mE6g5fP74Da9UBk2hQTa4K3po4qAd3gyHPpFz8qe4++wUX?=
 =?us-ascii?Q?f/whdGL1HMGVBp/WatAHX+Z23YEy7mrus0TqgGw1/37300ilLlQpzJrAeHKZ?=
 =?us-ascii?Q?bUH0V+ep4YLOTUb3DCl2hGLVfUAxIyc5zbb2+uSNAEibNwtNj6r5fYKeUPkU?=
 =?us-ascii?Q?V+G8qoNbgPCJNis4TLeEqu0Macemss8P16J7sPxdmbvmXqemGzuQwZSboZKi?=
 =?us-ascii?Q?2EVBw8KtbcAwNoP/4Q/GewHnOJgkFlReiLxHzyqFABQYQ0r9ZA52FO4QDJMa?=
 =?us-ascii?Q?NZWGdf62z2LcxOOOKIKKyGJQMhQQWP7vFrz6DStl2TZgIJ7V+IzdeTav3KPC?=
 =?us-ascii?Q?9KtALD4D5sUC4suKRWDrbGdnhRvIBia3brzPI98TxFDoqnz6hvt+KWkTeXm2?=
 =?us-ascii?Q?XbfccGCoQKj1AHVuP46VtB278SBUc+qOv9gdjRewCrwO3lSFf0Ev0gxxMTrJ?=
 =?us-ascii?Q?5JxkSLDDmboxLk+2H3jDTFcs4I95TFeYgG2DvAjeypbts79FJRiTwaHaWiL6?=
 =?us-ascii?Q?pyzqXMISdCTWuATQoCLheidlsl4NPYnU1wL24Ju4oPhj7S5iimqP2lQ7N1S+?=
 =?us-ascii?Q?x4VHfz8o/l1hWm20Lu6b3Ihkl213h148998O/VY+2d2fzSqGmNqhMbZLSiRu?=
 =?us-ascii?Q?cDeUE5FOBmuuZY66Jf4lYE0awY/codFytetSO7wV83ujq+wdy0sJZ5bl/oil?=
 =?us-ascii?Q?PBlfbzV8/15ZJWQVaZndZORp7hPV19sBPFZgOKXQ8czDDT/6p3rmL8SxlSt3?=
 =?us-ascii?Q?iA6vLw4D4EJ7YGo5qpDZWwd9iGqKdp5xeJPCNU3fHvMosseyolZXw/UagUZT?=
 =?us-ascii?Q?07x+mdaWfzn9DMvYO3kWslrOvAlY99trH877p8LHCW4eExsGSsBUU6ncZ/17?=
 =?us-ascii?Q?MYN6cfs1s/u9CBVdnqTCFTQbwhtj0Mf0rbjV0LJCc/cLrr0/hzpoAk00Mzfz?=
 =?us-ascii?Q?S1vEbWn4ygzkeZRaHiAt6hNrBeeYliQQRiOp40GDVLGrprHVAp/kAjPXZsB8?=
 =?us-ascii?Q?nfP0KvpXOM57qq2A7g9Yxhpmt7703XdH2SRFjfSFogpXnqWVquCXgGDRZJlr?=
 =?us-ascii?Q?tkJZpyeS0YrIOxbUKoMq6I0Ra/UPJ64riExEThG4drYa9eQI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb3c1c3-462a-4018-8ae8-08deb7c820d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:05:30.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6ryOBw77UK4cZ8gpu4MAcyfd2MTTEim+FHQXipUUOnl2uO5kp5MGVUsZLyO4RRUn62FHHLhdzVFyVFs7ShBdw==
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
> Subject: [PATCH 2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the
> parsed result
>=20
> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Since pci_host_common_parse_port() doesn't return failure for "property n=
ot
> found"(-ENODEV), the caller should inspect the parsed result and decide w=
hether
One space should be placed before (-ENODEV).

> to fall back to the legacy binding.
> Add imx_pcie_perst_found() to inspect the parsed result.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index b137551871fc..34756f28fcc6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1287,6 +1287,18 @@ static void imx_pcie_assert_perst(struct imx_pcie
> *imx_pcie, bool assert)
>  	}
>  }
>=20
> +static bool imx_pcie_perst_found(struct pci_host_bridge *bridge) {
> +	struct pci_host_port *port;
> +
> +	list_for_each_entry(port, &bridge->ports, list) {
> +		if (!list_empty(&port->perst))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp); @@ -1299,15 +1311,12
> @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		/* Parse Root Port nodes if present */
>  		ret =3D pci_host_common_parse_ports(dev, bridge);
>  		if (ret) {
> -			if (ret !=3D -ENODEV) {
> -				dev_err(dev, "Failed to parse Root Port
> nodes: %d\n", ret);
> -				return ret;
> -			}
> +			dev_err(dev, "Failed to parse Root Port nodes: %d\n",
> ret);
> +			return ret;
> +		}
>=20
> -			/*
> -			 * Fall back to legacy binding for DT backwards
> -			 * compatibility
> -			 */
> +		/* Fallback to legacy binding for DT backwards compatibility. */
> +		if (!imx_pcie_perst_found(bridge)) {
>  			ret =3D imx_pcie_parse_legacy_binding(imx_pcie);
>  			if (ret)
>  				return ret;
> --
> 2.37.1

