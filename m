Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AA3B6BE9;
	Wed, 11 Mar 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223394; cv=fail; b=t1UKPwcswCsj05QTo5x2Cj/JgQf7MAR8c1trfn4r/FWfucUVy+h+qU6DRnMglTUSUsP624XNJ4/HqpRfTd+rssiV+7Mkx8BgonqXAYW6LCPbJYS/pbEcUCubRGZw5r890T427lQ99eKok8PPVf7kx7JiBJnculOnlef5mGE8xRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223394; c=relaxed/simple;
	bh=+Qfu6VVs38YlZ/TSTM/dqlqpbIrVLndTLJNQAm7bR5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XES8m3LN9MK1BsdtzvVpOUPV3tbnZHOKjVQhzckVKDFPJMjnP6GAQziWfw0teU/Mz5b/UxbGYp6MFRNn/XJpeSR8xUFlKwXU5VZ9iZDfJhE02H1YeIZDVfP1IQnQ7L4bUpnkF9jcFZjm6r6x6Kz55pkX5audTi1UT8JtpJf2sDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hcz+TjaE; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hcz+TjaE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhA+avuQXMkF91U6SuLEOls/p3BeRVUVvy6mw9EnDnb7AivgUI2ePCvPHz6ht00Yh1rxjNNI+/F0h+egnD8SE2rm7q+IET4HYB2ivqp9/6gy5YybC4DkdL4xn4E+pto6MJeybO35VibP28fIXwRoOcesOEkRSzT435YSxKVybRDnFIK+u5L4CTaYfFpDErY+oOdFMqADFFAJ82BVMsQ2vWKDGqDv/BteAmCieNW6h61ZLRSk8yFiydkgOspxS3GQugzCGzPJFpx2R3zkVKDVCPFBrmLF48NU1ivndlLC/A2d6w/k/CT/47qH86OZqymsGEcCrcQVUd5cmLHp0d1FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnZNIWIW4gT5McnrjCEND2AtO1gcUI+SveDgwJ7DLI8=;
 b=ON7DXbEbfOeJOAgZFBQbdfVMFC4Wd31P/H9wa/txxidQ0IqhnGPqJ/5c2gaJEHF5AWwoIldt1nxhoRxcfifLEj4Et6X37KrendVyH97IwxpwW+gf/sJJB1BDFwlVwu7ZOAIvFoQwsyWWs9aGPyraHywPu1sY6nLTLXrXl3EMfonhynrJH9DP5zdFZtsv1/22hi0aVNxXBEbDGAToLEZiebmP+E0Huj/9UadMxlOMHpu0ayaB1sRYE05CCnbKghpDOc14pt6cp+P/b98JGHwleEpYgvxQNZYXjXUkNCNYuCtjQbC1cBThYauGTYodW6r5NluLyQTJHy2Qw0pnReR+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnZNIWIW4gT5McnrjCEND2AtO1gcUI+SveDgwJ7DLI8=;
 b=Hcz+TjaEFAfm3wONBOoWPiZYrHSe6cHRSSUfxrVjH/2qNkxwvfn4m8JLQqrOED5h5PdXcISNevRwaW2PErNqDkqBH3ARlbfocVlKOzvy/uEbAnZ5W31fjhrC4A75ZUjnmFjbhwcx4e5TEbNSpp3lZq3/rp6G7udV+v57WYD27NbNpZGeeWULKdaiZlkWj5sJIAmejEt/FbS5hS3UoPRwnwi2Hrbo8eAK1jaJYfu3nQjaVhktpmfV/YSnGXfY8iNd9pkt/9GqBc9z4Pd/j2YTyY86cYnwXYLbzRFhU/DOXMUP58jsvV+fOKA802rEuM4vgXHrRgbzNqdzV2GukEUcxQ==
Received: from GV2PR04MB12102.eurprd04.prod.outlook.com (2603:10a6:150:30c::7)
 by VI1PR04MB7167.eurprd04.prod.outlook.com (2603:10a6:800:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 10:03:02 +0000
Received: from GV2PR04MB12102.eurprd04.prod.outlook.com
 ([fe80::ba38:9cef:8457:c944]) by GV2PR04MB12102.eurprd04.prod.outlook.com
 ([fe80::ba38:9cef:8457:c944%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:03:01 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, Frank Li
	<frank.li@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V7 02/13] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHcsDCq7m53HNRMHk2x8UrCaDSWs7WoFx2AgADdkaA=
Date: Wed, 11 Mar 2026 10:03:01 +0000
Message-ID:
 <GV2PR04MB121020F9D89A4025C6C59535E9247A@GV2PR04MB12102.eurprd04.prod.outlook.com>
References: <20260310015426.365675-3-sherry.sun@nxp.com>
 <20260310182854.2226939-1-Frank.Li@nxp.com>
In-Reply-To: <20260310182854.2226939-1-Frank.Li@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12102:EE_|VI1PR04MB7167:EE_
x-ms-office365-filtering-correlation-id: cf8a813e-639f-44e0-e957-08de7f556146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 a2GG/qxc3dsNTCZkHekh/ud06lvDgintIyWsV3rhoCbE+25yCTsk48JSZ4hZFVaTsoThZQtw2AGwpKK3r7HMJ4d3GvVO9iB/ZhwJhzQBw4Gekl7/XgohoQoeL/aPsqBJcMdhoDhCRCoVVgkmoc0dDxsjuqEQZ569MZgJ6DV9bNLxvDreLfhPib6192/Piaa1kqUjrqh1sO8wMpLTCQlxtTeA2fxHrXmE/BAdPC9Dy48gkfLqzjvJydSH4Q3liuAEpy02oUwKTO5S/F7HBb9RJcDHKxe6mGSiOxGPF1eAWKN/GR+MWGbJZEYMEBxB2MF7HIuE4tluvkkj0c+IEkoH9dMzj3SIN9Ix5hJN2IkWhuCa02UyH8iGRnKaWGyezmniInFpAFsjN+M/LuxpThqnf2rGoG2I6SrOmvHCReQV0fPh/ERn0zECLM+CgXDin7pBwVPcLsdIzxBxmna/TBZp2Cq//42grMLOqp02r2T+pUS6UZLQ+RBmOAoJOMWkm+Uj5/ZGFR4/tJJDFcgBJum+U9yshToMt6IVx7O5obkqbGHKyi7vK/b7p+SYrahFAudk42KQxOChFvTyxvf2o91rnK4ArjzVjPD18JtxwvdtE2IugBEMH+ZjDVZdO/9xenKhzIu2oZiiCsmml0fZCsPrGAFysMkTlGuvOlxECQDj5K1a7LT/EdV1i1Ad8ItA4MLX3GfJAfCPlnHPiKb+yo7gOif4Q0q2vKa8HsGm2iRB2rwsT/iDIkUOsyDJPxioO1phf4lkTzXylFhq1vZkrE4i/QyLcPrugrP1JWEJ5UnIvBUCAKXuzz5Q6XQQmlgRQBX5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DkUplO7J7tuwUSxaEx/dyCraORsahzFRMmAv+coLhvjXmL3zaDBLm45ep2gQ?=
 =?us-ascii?Q?4+mtPaCZYPbmDyIFGgfKPpUTgRM9VxkEdYfyweTyKrJgSHw9w4gRtcEyxTFb?=
 =?us-ascii?Q?YU66tmA5PMncZZoaWUAGgqOSlIeKFWdPGpvyRGYrt6Awzt9N4jOcQDWYrGiK?=
 =?us-ascii?Q?cJys5Nu1kOhT96I9dAbAhkH5+IDOevRi/R8zeEc4QD9hJaVICLfS8yw592av?=
 =?us-ascii?Q?JDxq3CxWYLqTCrTzsSoxjfZFB518jsshVYAs+aO6kZt3kJqqTT9is5+ylitM?=
 =?us-ascii?Q?hnI3GDAgibs95OHgnfJP4ypitjupSCMaCLtU20lc6wOniwTb/niYkvoGZEbI?=
 =?us-ascii?Q?yO1Oh2ORVqmzZOCDcAIHvV+ACTLxojpuGpZyF03xQvPUXqtEyTl7cHXDHytG?=
 =?us-ascii?Q?PmlYFpev69T3jeRi1huVkoO9o0rhrcAcgANjvCfWP/Efjo3elN1/l/1ZwRwD?=
 =?us-ascii?Q?DYyQACHpoL3rN+Y6jSoIjFR0yCi0SgqbIH7SFzuo1eufbuP9C0hmh4Mle++H?=
 =?us-ascii?Q?hDPrNY1or2fV1TayPHVkQXQ6W8nwHYS4LA9xhdjB3ZEsjnyFUb2HC5+Ph835?=
 =?us-ascii?Q?cRgfT/GolX/E0KgT1WJvI9Dwa6S7Xbdxh0S3H5N2wX+VIvTEqZxcj28J6qp3?=
 =?us-ascii?Q?9U3W0mXLeDUSanD4Xuq9aBcMGBiEZMzGy/xCVzclSUu9rL4MII/ef7HZURXI?=
 =?us-ascii?Q?ugqRMbyA25bRtj8l+5ctavr9KXuco1povbcfk7mC92LxEOWdoML+wUVZEhlJ?=
 =?us-ascii?Q?ZKDLVRiAELVjUWhhtWtuR/7NtXX7FPk5Lktoz4HLByUzlJKNshO1bGJKom3D?=
 =?us-ascii?Q?GPDbSutlaviynrd9B0wl8ys8nF6nbpQBqcOPIaHnMegUrWA7r0sibOg0Pxeo?=
 =?us-ascii?Q?O8H79I/zrLthJmF3JNLCA8c29oWGk6xw5YjDNQkoewNnxkWYWdDfI4KZssfd?=
 =?us-ascii?Q?gQcbe/azcXexvi9Y3I7cYJABXyHtIb6sXzL1lKx1D0yJB3NF+EuLf7BhoHqG?=
 =?us-ascii?Q?lNE1sCg7NtJFgPQDcRyr1hJTeuH7Q9Bi4nkW8l43wW0PRvqlHamChz9zm+6t?=
 =?us-ascii?Q?A97vG+fXh4sPSXCTiTEs3z6GDJ7OdTfuirLuNfGNdmg+B2HEeWa+eeARMrg1?=
 =?us-ascii?Q?6ULtp+0aXOjV6XZsJZfmLWXPA/FtRGB/seHeBOn/Q1PT8c4ymySthYyUgu+q?=
 =?us-ascii?Q?0SWkPFqUftoWTjWzK686V452HLgC7l4on3vEzdstaqQmSnTwcZLQjMLELwrF?=
 =?us-ascii?Q?xvzZdlbLVe5EbvJOipIJbG9zzNuZ7qh/JcNjY2bzAqNJGEh6riEB1t9B4Tuc?=
 =?us-ascii?Q?x0WCaKVU/PZRKHNsZLcB0wrIB5NklQeK74kZzgBMhhsjK400OE8LhjGrtcYp?=
 =?us-ascii?Q?OGMcdUfI3FOk257Wn1XQS9R0I34UJyo/Xud0VNwkAo6zTRSqkfTVp4C6FTgy?=
 =?us-ascii?Q?4yx2SACXhtZTjA7UBwoEkiDz+0XLgNMQN/gSOUn9QSmI+Qnm673YuUkNw4vH?=
 =?us-ascii?Q?Z22g+QI3PG+Ba7/ZTN/K7WhG4UluPqGax7LlgGkpEAppv1XZoxjcKy9Hz5Ge?=
 =?us-ascii?Q?jc3Omjz9HgyekNnksWK4WoaWmMJjmXqL0zqpSieh1F+dDIEhjxWnHLRwODsG?=
 =?us-ascii?Q?wCABXIOFt4lNiAiXtLNRVwxUlRMuGAUEpBHQTiwR/meThyEwwrlFgC6G6JdR?=
 =?us-ascii?Q?67eRnjwCuApUS/vjNeFUs1q+EB668TU/7RMM31Pta8JhIUHN?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8a813e-639f-44e0-e957-08de7f556146
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 10:03:01.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjMfXm5eO42TqZyIQqYCBW2bLkDNt6Ni7d+g3+I79OrHOCKN1x9rAbAcmLDgTurEufz66CvmQZGPtnMvxZh6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167

> From: Frank Li (AI-BOT) <frank.li@nxp.com>
>=20
> > +int pci_host_common_parse_ports(struct device *dev, struct
> > +pci_host_bridge *bridge) {
> > +	int ret =3D -ENOENT;
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +		if (!of_node_is_type(of_port, "pci"))
> > +			continue;
> > +		ret =3D pci_host_common_parse_port(dev, bridge, of_port);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> AI: Returning -ENOENT when no ports are found may be unexpected by
> callers.
> Consider whether this should return 0 (success, zero ports parsed) or if =
callers
> must explicitly handle -ENOENT. Document the semantics clearly.
>=20

Returning -ENOENT when no ports are found is intentional and aligns with th=
e
design requirements for this use case. This pattern is common in the kernel=
 where
parsing functions return -ENOENT when expected nodes/properties are missing=
.

1. -ENOENT semantically means  "the expected entity was not found", which a=
ccurately
    reflects the situation when no Root Port nodes exist in the device tree=
.
2. The callers of this function need to distinguish between:
   - Success with ports found (return 0)
   - No ports found in DT (-ENOENT) - this may be a DT configuration issue,=
 for controllers
     where ports are optional, they can explicitly check for -ENOENT and tr=
eat it as non-fatal.
   - Actual parsing errors (other negative error codes like -ENOMEM, -EPROB=
E_DEFER)

> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > bccc7a4bdd79..9cc3f4ebb370 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct
> > device *dev)
> >
> >  	pci_free_resource_list(&bridge->windows);
> >  	pci_free_resource_list(&bridge->dma_ranges);
> > +	pci_free_resource_list(&bridge->ports);
>=20
> AI: pci_free_resource_list() expects struct resource_entry nodes. The por=
ts list
> contains struct pci_host_port nodes. This will corrupt memory or crash. U=
se
> list_for_each_entry_safe() with proper cleanup, or define a dedicated
> pci_free_host_ports() function.

Yes, thanks for catching this, pci_free_resource_list() expects struct reso=
urce_entry
nodes and cannot be used for struct pci_host_port nodes.=20
I will add back the cleanup function pci_host_common_delete_ports() in earl=
ier version=20
patchset to properly handles the ports list.=20

Best regards,
Sherry
