Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DD175A85;
	Thu, 12 Mar 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281061; cv=fail; b=rMjR33ceBQTCE/bf7FdLb66VU3pHuaTwcovuVnLik5WmyF8ysGeHq/hnrIPtPDBS9oMB6f8Q5sW6syykhZXa/CLMQuM/kxCxzn/J6qnAy7NQ22nWlDvv4xyh2eIxRLsgumrsaMuNt/3bu5aL+snmB/mpv8QyfrAmIXxw5z3kg+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281061; c=relaxed/simple;
	bh=7pScODa9MK1D2jzwS5hmXXdOsUwmVBgsPxWf/M02EwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ua1dmZr/+BQ1p0ge6Xw4TCSWAkoJ5rDTTYOoKp2aqQGThAhfZ//GCG4HaLnEDrtHupHjlXhBUmXgGu0QMn0VTBd0Xc0oiqM7X5ByuxvMxKatgK7hKv8TwpdLWUSCFNRR8H7Yh1r0dtAUj4D8JhKyp+VUXRa1tNwT4/PWOX2+lvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCi7vf8d; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCi7vf8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upNvhNiTbYvad6me7YndXUIUmn8YXKTG11Gk/+86A3UgoM0e5v2Cl8/64+4uPAsMlRnn9qh3K2swdEBQ1ycFlp6PffxL90nnoaBQeJbfQZLBc8f6bVhNaB1ulUyBAZuY4ABCRx4n4PZb+G4c5RilbNpAOXVS1h0IzQGk7r810tPtoxaKZuX8mkztXRWhKB+sTvBZcZVfbgieIH2246p0PK4V35rnf5qPCbitbMXfIICtcvMHL+6zi1CYo7Upulb7+/KF06cV4K8/UyiHAFDgfPeqgYaOXuSMMOuYPSvz4UFPT8xjmnI3R+lo4KkylZGiC02Y8zcl+wjgt1yDN6oNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUUPz6VOkjomjGV1G59gyNh4za1ZA9zlRGSZp4SL3PQ=;
 b=DvIWLHGeshKBNb6HPCNlvelZbXv14LGtJLA/PF0dK1O4SuyJA/qvKo/WAf89tHfUhi+o8kJKCCYTEMitxAtsAftteqUFko4Is562TIPHsKuiBl+/ZXbBxWsOzQZVvQ3WwnWIm5+W8ttzg4Cy9BWMzf5mnthTtgb8gmi8Y/nUbD2OTYy4Yb/TwJwwUwGh/QVDL8dodogSn2GZdLsAJqe/Q0N7qW6z4kS/2IDaSdtF1lWCuZZUCNZmMOQ4RvHjU5pwwrWK2AmZj2583xPE6sfbX/BCdrfp0XtgO9hCXxci4Qbrj7c6vC8oN9fJO7Utp446hWiNOvvgyfFECL6nWAaY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUUPz6VOkjomjGV1G59gyNh4za1ZA9zlRGSZp4SL3PQ=;
 b=HCi7vf8dhySMEPRdgkmuLXFgHMNqZiPaqF+3YpX7b568tUwdiljGudmLKxlu3IafrEWjXno+eUQ/OIc/QkoxZ8e+HPf9fuBg+e04Z5xkUEupFhHALlZBbZkaLvhGHIvRbDzG+70LkpT0pQGli0xwLeDynIOqyx2oDmRLr3TnIan9hwgEGxXJpMNidWUwvZkp+T2pvCuYKefTSih2Pdn2QWD8z8ivyNPCJnCMtk2vTy3yzEG0gXwH47NtnKIj+ED4Nx0t6RtoQ0yNzBftXoG6W/LSxiN6bbHyKzerYKxrQ377e+3Ca5MHhLzlsFUpqPxI3QwLeDfG+0tFYo4mVpuIPA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AMBPR04MB11763.eurprd04.prod.outlook.com
 (2603:10a6:20b:6f2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 02:04:13 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:04:15 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHcsDCq7m53HNRMHk2x8UrCaDSWs7WoFx2AgADdkaCAAIevAIAAAJRQ
Date: Thu, 12 Mar 2026 02:04:15 +0000
Message-ID:
 <VI0PR04MB12114D3D7D397365D69165AC89244A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260310015426.365675-3-sherry.sun@nxp.com>
 <20260310182854.2226939-1-Frank.Li@nxp.com>
 <GV2PR04MB121020F9D89A4025C6C59535E9247A@GV2PR04MB12102.eurprd04.prod.outlook.com>
 <abGOlFxj0yK53tRO@lizhi-Precision-Tower-5810>
In-Reply-To: <abGOlFxj0yK53tRO@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AMBPR04MB11763:EE_
x-ms-office365-filtering-correlation-id: 3fce478d-913d-4efe-dd3c-08de7fdba984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 adgMdPhTzbSZ4nT86MvqDt4C0m6MvHgY/qmlePf7bCp4qDAh0IatWPvbTWDipMUrBF9Vap/57el2XokfmFexuOnTu8G3glOq1BEMPEQKSRHuPadVvp2fZR7d3EbcZIFXoDjGWRPdPYRlqTt2wsqAEOR4Y4JWC3D0ipzwRYnZeCfXifq7Cx02e/oONTn1myXY1w72UrXkyqWsDuv2yklBVtp0HohimQ01b3nZryiKfALE7GCAeXVXMMVWaA8aLAQtOqs+0l6p1O1sa8atBueNdCuedb/d9fAO+4iYSGT/CHFNndxkIGQ7Xwq1j+8bBqkapkYbF5pjLufJ5VWoIgvHgIbw0nUX9IO+yAUXrtKrICyzl1k0HIGX2OC47WBzJeVNiKlYy4/PWjaXuI2rqBtG/iiTLKuzTripSWbFHXyBIdgYuDp8yTCsKFLiBU+MFP2flQLtKwbCQ5IPBWhcfaowFRb6MLh/+Y+gijgwsRludgWU3kJdWjBKvvaG3DpK1CXDFyYvIjl2Rxs281H/0bQ3n2FGWMUmL93TWYe7V6KIc51seUm/HOdFITiMB30aqq1w9zY79kbgkabds/AWAIefyOs/G4GvQ/DHkc0EGezz4TxYJ0/cfb7BOMuWUcsHlECNjze+UC/BElH4BeiBdYgbflC1aG+BrAYlYxqmTY+0IVO3GHPPI8hjjs1H0lpIPw7gJccEQnnPTpkx3RTwhWIq6t6RGHMXw2DtxNTeC35gXpVLH7M+ZnMX9TKY6uKevQEntfwE5t4OdvWtnPqoNUv3mE61fwZTMlBDw76aUUBREuw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7aT91/1cD0p9x7kpfwt2lID+sI+s47Vn1lZoJEp6DKc0OXnr0Fh8IkqMTKmf?=
 =?us-ascii?Q?Tlg6lQYADa+A1X7SrHYhmwQJZ6qQyPHmcsHSjm0g5lq1yfGwdgMv1EN/BhZT?=
 =?us-ascii?Q?iUSMJwOlv+h+5PN0ic8hF8nwZUd5NKfyqgz9qCsViMfUBByrTWkt8MiUkty6?=
 =?us-ascii?Q?lWvsQTL09Rvb+ncm/mMs3fUCMTbGQQI4SSNOQ/CXr0OzbtPKf1pkv7Q28b+Z?=
 =?us-ascii?Q?OF3jC29ZEzhfpY5S7tWM27KsNC2fqw5zIPh1PHZzjAkLvgYfeH9r7zMeyP3d?=
 =?us-ascii?Q?wDKCbrDKXlzPVRjFLh75m3obearkJUazWRWR9wsIOd+qgbWb30cccktPC18W?=
 =?us-ascii?Q?7i2kgsn5V9SlSB0AzHuXurqvxHHcf3PZETjGznhPZEPNkXavQdEvtuznx2A4?=
 =?us-ascii?Q?l2CF//NCFqLunu5qaHwZX5lbtgbcxQ8VfHbCBzJZpotvBWo81zo9/7s4yi1x?=
 =?us-ascii?Q?Ddrr5i1fLODVD/aP1rgCX0WOrx4e+F+8fm0qAeI8tTqgHC6UkWkju2ooUtn5?=
 =?us-ascii?Q?tgKKt8K493+buyg27OgsifER2gaBKn4ZAbTZYW1+q5NsCkYG7WoAP3kWBzue?=
 =?us-ascii?Q?hvnzrNq+Y+/jca6UxMjRuCgUwIuSXYeGFWPzIM+0Yig+PFF7MPtr/sJiMoh5?=
 =?us-ascii?Q?Os/J+F3oiAZ11ehSPgmt68UBU1m0qkuZbky6OvCTASJK6oJaW0LC5GAilnfi?=
 =?us-ascii?Q?hz2jRkw33sUI9+LvlD2HNXbhSxDLRJul8tPxPYeVqa58i1f4J0gTnjJw37RC?=
 =?us-ascii?Q?ahhxt3WsBded2yzxat9W1PGV0f7Dcj5FKhfFGxOPKbKGMCgfjT3/1wDj7dDq?=
 =?us-ascii?Q?pwwCurzSWXHIGtkvH+D7QY4tvBK8+rirtrnJldhz5VhDxJDL0kHJc5k0JHiJ?=
 =?us-ascii?Q?Sw4RHWI1i+viYifl+cmMrpaRDPQM9l1ry9ZNS7viqD9jP00J3+yUCjrXJrca?=
 =?us-ascii?Q?1pZEdx8H0bE/euHp0gBbLcX4KAbG9irSs9wg2wexppok30smEVq6z/ultIlW?=
 =?us-ascii?Q?V5cpKL0IxXdqpIt1NArJKpLuMEXJFpzW3UUzhNzqCO1P7n8oyIOLK6H7OUgA?=
 =?us-ascii?Q?xDSeZ+/GN1BskjOVcwBn78q8ZPhxQlQWJThhyy4EVI0UTQ4c8f6SUy/GhK4P?=
 =?us-ascii?Q?lzXRvhRdgRLYKk9h5sFEcVEMVah11GncppWTct6oh//ZuDrYtv/nKYFEfk6x?=
 =?us-ascii?Q?4jnp0f3ZQQGDt9kDpBfGon2ZgbzEgSZu2+YykXQA1lbNCuZvoscx5R8gOOy7?=
 =?us-ascii?Q?7yaGDlPZy/m1RZItvcEAmflVPaRY+BPDOgFEOpbFGFYsqVwpIk/t0U2pUZvH?=
 =?us-ascii?Q?Jr3cEUK8MhvaWwsQv9duBf4VZcxndjAG7SkeVaSKLJvj21EtDRvUlJcIbIAt?=
 =?us-ascii?Q?RyB78BWruSwhRNQEDZPsxSyYGa8zEfj1UDF8Zf6+TTkZKhVMit98vZaRtfJB?=
 =?us-ascii?Q?HIJcFvn4rekLXe3QcS5WIaiIc5EFIJb/5tdhG2tXXgctZVwC1gHlsixdWqX6?=
 =?us-ascii?Q?iDZcHI3Oz1+0bQ/RCAydVVqGIvMdNAL7pVO9UNUdHiF3EhcM7c8T/Bc4BFZ/?=
 =?us-ascii?Q?bfRUEtYC5dZyNR6Tq2R6DSrcskgd2lq4K5yWyIC7mSYyqmn8ZHI/V/mAA3tv?=
 =?us-ascii?Q?UMhhpNqY01MFV6Z1I3uagYFYrfpaLJUvMLb+qIeQ8Ty/0pghuKWboxqTNO/5?=
 =?us-ascii?Q?4DN/Eho8UrAw4QZMU2Swl56QCVaYHy0FKZyzepDM8i2WOFUL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fce478d-913d-4efe-dd3c-08de7fdba984
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:04:15.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HETy9W7h6NV6yGkkYRwJyGbRty3zLB5o+tekwitJGV7ezyB+U0dUyUyQIRSgob2Kgzyu30trS2SkxOU5/Wne6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11763

> Subject: Re: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
> parsing Root Port properties
>=20
> On Wed, Mar 11, 2026 at 10:03:01AM +0000, Sherry Sun wrote:
> > > From: Frank Li (AI-BOT) <frank.li@nxp.com>
> > >
> > > > +int pci_host_common_parse_ports(struct device *dev, struct
> > > > +pci_host_bridge *bridge) {
> > > > +	int ret =3D -ENOENT;
> > > > +
> > > > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > > > +		if (!of_node_is_type(of_port, "pci"))
> > > > +			continue;
> > > > +		ret =3D pci_host_common_parse_port(dev, bridge, of_port);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > >
> > > AI: Returning -ENOENT when no ports are found may be unexpected by
> > > callers.
> > > Consider whether this should return 0 (success, zero ports parsed)
> > > or if callers must explicitly handle -ENOENT. Document the semantics
> clearly.
> > >
> >
> > Returning -ENOENT when no ports are found is intentional and aligns
> > with the design requirements for this use case. This pattern is common
> > in the kernel where parsing functions return -ENOENT when expected
> nodes/properties are missing.
> >
> > 1. -ENOENT semantically means  "the expected entity was not found", whi=
ch
> accurately
> >     reflects the situation when no Root Port nodes exist in the device =
tree.
> > 2. The callers of this function need to distinguish between:
> >    - Success with ports found (return 0)
> >    - No ports found in DT (-ENOENT) - this may be a DT configuration is=
sue,
> for controllers
> >      where ports are optional, they can explicitly check for -ENOENT an=
d treat
> it as non-fatal.
> >    - Actual parsing errors (other negative error codes like -ENOMEM,
> > -EPROBE_DEFER)
>=20
> I think no ports under bridge should treat as 0. otherwise it may broken =
other
> platform, which dt have not added child node yet.
>=20

Hi Frank, no, it will not break the old platforms, the caller will explicit=
ly check for
-ENOENT and treat it as non-fatal for such optional properties. You can che=
ck my patch#3.
This is a common behavior in linux, for example, we also do the same check =
when
calling devm_regulator_get_optional() or devm_pm_opp_of_add_table().

@@ -581,6 +582,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)

        pp->bridge =3D bridge;

+       /* Parse Root Port nodes if present */
+       ret =3D pci_host_common_parse_ports(dev, bridge);
+       if (ret && ret !=3D -ENOENT) {
+               dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
+               return ret;
+       }

Best Regards
Sherry

> Frank
>=20
> >
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > > > bccc7a4bdd79..9cc3f4ebb370 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct
> > > > device *dev)
> > > >
> > > >  	pci_free_resource_list(&bridge->windows);
> > > >  	pci_free_resource_list(&bridge->dma_ranges);
> > > > +	pci_free_resource_list(&bridge->ports);
> > >
> > > AI: pci_free_resource_list() expects struct resource_entry nodes.
> > > The ports list contains struct pci_host_port nodes. This will
> > > corrupt memory or crash. Use
> > > list_for_each_entry_safe() with proper cleanup, or define a
> > > dedicated
> > > pci_free_host_ports() function.
> >
> > Yes, thanks for catching this, pci_free_resource_list() expects struct
> > resource_entry nodes and cannot be used for struct pci_host_port nodes.
> > I will add back the cleanup function pci_host_common_delete_ports() in
> > earlier version patchset to properly handles the ports list.
> >
> > Best regards,
> > Sherry
