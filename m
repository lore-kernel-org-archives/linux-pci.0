Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820F22424C;
	Fri, 22 May 2026 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430820; cv=fail; b=Ux7TertAr/b7x8bx0Dclvet3Wu4pe5DAMQTS0vHT8CTIj7zEhWpyYfbpwjPFAvJJK2RTtiseoFkAgshs9juXI11mqJ9ukUZWl5vZNrJHmVoPe5tlRI+jiwp8iy2gH6lHqTHdANfowSsB6pot5IdN5dAkzu9/3n57XYCgEu7+Z3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430820; c=relaxed/simple;
	bh=CQmn1R2u3aAxrdCCBdncEP9dUgseQDFc8k1SWTaYQCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHIxT+LybNbihK25K6JXE/fT1NGwRo/mFNTzbAwUib+mXsB8DMO/JWbPmI4Zzj/NzMaX2S1FjOegTHg0U8HC18JI9VLCow6O+Q8zalNxzqs1/8KKfoqPO5cpEQeMhsn1lieHDzBzO287xElDlxJOjc8JrQy1Mybe+HQsThFUIqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JZCd7uUY; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JZCd7uUY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWlidTHd8HxRIwb6s8UuE206oR8lpS6ge/CEufK9OTOtCET3B+M7MWz3R65Tp2pPG44s9QWJAImuJu9zD9SuvwSI1jZLUPu4aan1awp06teayPgqfOQ/yNofFa3QERA3wLfLcjxCxKnRplUp6NnvRn4tZEEufPpZXqHEtWT8TdQPZ46ooDyf7L141FNzy+1PWDcd43Z3GgiCAAsm9CMz6HP7h3XaVcEn3idT96x11G1AyeRV1TpVmkRma6u+WIF2s1/ZzD047BZ3kgS2Wu3X5eOQ1U6XUv8KifYVuIxTX8V7XXGxmfr97WcdZiBQo9wE1qYql6fw9HubteNfDzs5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B056KBGcE9K9/fpuK7+t1kWmjEXCoCXY3NBEeMIRYMA=;
 b=WtiTLHHSTWTaGYoHCjRi0LyezPQf0MkMoEdD08JdITkk935kvzJJcLozV7rMDZlnNFbDFFwPiZ/g1aDSMLk4Ji8QJT5pg8LE4RbfknfWt50BTNBxvmV8VXBiKBDq7AUli9i8hxTCZAlxcJ9RWUt2TBrBOHAXz7RrzMpXSRpNUGdsNDZDnZQ8SeW5E3h4QkHhx2Z/gUrxKueeNogtHdh/7fraKCLvjjSsp2d8Z2orDjlka1JlTPH9ztFPL/oSFCdnRR2HA7qs/eRycOPm/k6IQ2roEOnzmRKgoB3jTk8wPyiV6h+6AKEX9/K2VYy/lsPRJfVez+1GqsM+md6V55CnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B056KBGcE9K9/fpuK7+t1kWmjEXCoCXY3NBEeMIRYMA=;
 b=JZCd7uUYKKkKlYBuEVgI1k8w9VK/DhzOZXliANBrAbuWrwvg974Z1agWMZfhTeN8Qo7l979MMkin3vfmEeCpJln3vMNTpSiRIsB5c6Vs8uXVSGS1hT3IrPyiFvX2Zc1rGX/LBGw9L8wabElKuFBw/tt5awDrolwA2tfouzaaekuBSEAefq+kPlzBqQwTnvvejIEaenen7spU2ZJQgkmQzL1j2Cmhh3p00QocpN00Rr3LiMDo8RFLG5XYs1+I0QB2jFJfjmyzgZAP/2Q2kd3ZRAjgtYtiLha8B6WlFl0I+LflLQb2Mh8U3yN0f2riRAPo0IUBOvVb1cQ1U/9DCRO//Q==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7017.eurprd04.prod.outlook.com
 (2603:10a6:10:123::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:20:13 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:20:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>, "Sherry Sun (OSS)"
	<sherry.sun@oss.nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	Frank Li <frank.li@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "will@kernel.org"
	<will@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI: host-generic: Simplify return value handling in
 pci_host_common_parse_port(s)
Thread-Topic: [PATCH 1/2] PCI: host-generic: Simplify return value handling in
 pci_host_common_parse_port(s)
Thread-Index: AQHc6ZziwiBc7RW95U2VBXmZTuS/Y7YZjsWAgAADnRA=
Date: Fri, 22 May 2026 06:20:13 +0000
Message-ID:
 <VI0PR04MB12114097745A831189C23FE32920F2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260522034344.1147775-1-sherry.sun@oss.nxp.com>
 <20260522034344.1147775-2-sherry.sun@oss.nxp.com>
 <GV2PR04MB12019D8D1854A947AA7DDE1208C0F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB12019D8D1854A947AA7DDE1208C0F2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB8PR04MB7017:EE_
x-ms-office365-filtering-correlation-id: 75931fa1-bb24-4ef5-97f7-08deb7ca2f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|56012099003|18002099003|22082099003|38070700021|921020|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info:
 zz0mStAzFFQav36w83WbMEmE5wjdjJNvGCQb3J+vpL/VwUtItOAylJMlJoVzIOJo4QqLMg7AJDNvGkeYgn45UFCdnRrrWov4oijy1/1Nz2+A4ZT5sHbuf4V+iohFDCLFgNMICCzqE7OgpW4qjegO9hnm2GnNniLBvWkfDDq3oN/RZ8UBt5fGBSJyd/eiUBymTeW2I8zQjptKbdDAg4h4OXQ1epuYiOxEkOqhSYmestGGIMeyqGEV5yclr/82NeWUIY/zJ0SWGeHSPYEjmXmUegoUnxdpHhCgNAleSFUnIjYuAVcYZGfYGJUPqx9gNLGq6Z+uSZB51Pe/ANer6idt/rBscm3oygnQvp3zNUlxZvqbg55qONVDMt9kQncUGCChywWXqGoGyPPc0hBlqDcyPqBJEWs5/p+43ztxsVkIx7QtOlq3P9sQmU2NToKP0VgWnQMTPhVZZUuR18CSROpyTL25wHJPok9+2lY44DBHsnBvmBgFSTbw9Zxf0s3bdnPTUbftvwfF6Jw3bXIE9QIMa1vaPR3x42sz5XaxQ2AxrycS8uzayfddqDJgOKNYInZVsfZn8VBkIOZggtUHFJYBga8CisIyXfnQC7I9S+JldyrKdcfTt0HLlU/AwLLHK7pgTCOkui+YQpgTFcF461WdeVqcOqThA0W+cJUs5qrlSG4Le1o00E5cRd5OGGmoZyo/b+8z6fu2MwG6cS42HKMibajS0eAwshKhE8LnqptEAwHbveVm2I6+t9SgdXopDNhs8X3f7sOtMv9YRDtqpi+RKw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(56012099003)(18002099003)(22082099003)(38070700021)(921020)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fIE0qX/15jT/daG7u1y1mx/pTUmo2dhNCFip/dggggniajeLNiieoRkfAHUb?=
 =?us-ascii?Q?AJVm/sJBOFYYk4U8NGi6eMo2ircIVKJ59jHvjhmQ4oPjbbFr6jl25qseM62X?=
 =?us-ascii?Q?gHyQLxhXlpfggm4zTYUi41JylbjIQ0Nx4SkaHny4oD3QAdBoRnkqoJV3wHQ7?=
 =?us-ascii?Q?W18CNcUx3JL6qVnx5GtujvMkynBUim/E6bp91tp007iO/E/cZ/SMkIdIxTby?=
 =?us-ascii?Q?bEIehP08NOgrksTpZ2QNVDY70Y143Hdpy+oNCrE6ws5URpOKVF4XkNF+XRUZ?=
 =?us-ascii?Q?LJbParlfFKEkv6QsEBKhjeVBXg69D6+2DfQk0dz/04AusIIIbMg/57uooAok?=
 =?us-ascii?Q?0Ma+QNlZyjIPJiEo/MPksC3SsPVGppw4T6cG2NpDERB+dBEP99GbeHWwZyKl?=
 =?us-ascii?Q?PlkXacRT4O6lWVRxVkXhHrJkFPsS42gR+FkI1vtHXQf0UIV+HmtEOWunwpjw?=
 =?us-ascii?Q?sm4LO5j4cYFKDpk4YFifjuEUpbp8rVwsAeIhVTB2UG0aCMqEw/IXrO/0hn97?=
 =?us-ascii?Q?QqRJrNvlpkS74NEu2KuNa5mqUh89eiFrw79Uh5lSPnQqcx0KflR49t3iouIV?=
 =?us-ascii?Q?lNnJ8qEFDHKUeNp4Al8+iQeo3hzs3KkaGGjvfXLJPBlgOBojAhKgTrCcfyrE?=
 =?us-ascii?Q?AItnlk/bb7mrKqcObkCM8eaFrrXS0CEeVYuYrJq8FQOGEdF6Ih6Rz9rvbxzs?=
 =?us-ascii?Q?mmpaw075N7PssdNvKc2UtC0Ys+xQ3ujq3ZbhvKbTVoZdDerhIyeBwh0C3hLP?=
 =?us-ascii?Q?H8WOh0tjXtDri/8E4EPL9RKdiGaZBWl7FqlYDD6bHiXwyodjqvMGZK1/xgFv?=
 =?us-ascii?Q?bqyuYenp44EOTOurDBme/JJoHZVPn0vHzDwFq/CjqeDWEqLjjJXsD3X1Vc6e?=
 =?us-ascii?Q?LuZ3qKVT9jzkz3pQQuKoEnqvE4zq7B8gVL2Dq8xeoMmkpjG3yiuSf8V6O0Fu?=
 =?us-ascii?Q?iLfC4WD3vnY1kJG8/9jtrSeIoeIqpZD8w4LlVRW+8dLqPyIWgMNVL0xGmf4x?=
 =?us-ascii?Q?JJmWsqq8ZfGdXeOVVBkhwS57UK1haAFgyzKb04zl9SuXk1HeXX/IQRE4f8kY?=
 =?us-ascii?Q?DO5bxxaIfDS+Ri7EVc1Rh6AWV6I+dsZDO7WFQH8v14zlM/Dtl7xv1VkVCUC7?=
 =?us-ascii?Q?Kt1B3SyPl50rUlrxpW2e1+zEiWQ/bri05/ns+dSncsv6sKdABQBMKYldY8c8?=
 =?us-ascii?Q?Uc+J0aIvDF4FqWNzXqsVW2t9MaeeXCQwzJWXxqAZmQrk1iociqGVJzx9IihG?=
 =?us-ascii?Q?oTcoM+4NNrO81BbYLjmg8i4B3//9GWwzSOnfczHHHr1dET8/GqA70MqeGYHq?=
 =?us-ascii?Q?RVWgOY1pclHJfu1VDMVTF50fZ2aAN59Dn1hFY8JBQilm/rOn6VGo2VUiWYop?=
 =?us-ascii?Q?xI2P3Lgq/8tSkNb/Fx0TgYixwjtvbZMszLkc1zDIJ0oSAoPxp93aq4dmKn5+?=
 =?us-ascii?Q?PNuzW0L55iwYKvG7qwM6FFkIqyEhkXGsR7WK9mHvIqWzZgcFWmpHH8PGAUFJ?=
 =?us-ascii?Q?w0gpmSubntp7rpsd9d7D/WxCGDgmF/YjGh5tyED+1rJVHc2H0okBHKb8xIcj?=
 =?us-ascii?Q?7vKyRrFbtjCTHG5gQQ6qJ2Siza5U2uTikSlPkqRIj0bksyQthF7edQeAvBrY?=
 =?us-ascii?Q?416Fgt4ODVs4rytAjNcttyGBI2f9k7wIqX3xsqu6gEsPcSDNODHRosOjEheM?=
 =?us-ascii?Q?YeciEdSGkRmOHDh+oBAN4PnTzs0tUbNVg3qOru+kI5WHU+9x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75931fa1-bb24-4ef5-97f7-08deb7ca2f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:20:13.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BMgxtFsxNkpB1W782T9oLp5dpphPENQZON0Kib0d7hwJKUa6/8YPV5sXU82uSCEFumYB3PGqW/RwoYNLyQiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017

> > Subject: [PATCH 1/2] PCI: host-generic: Simplify return value handling
> > in
> > pci_host_common_parse_port(s)
> >
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > The pci_host_common_parse_port() shouldn't check the RC-level binding.
> > That's a policy decision that belongs to the caller, not this common he=
lper.
> >
> > Simplify pci_host_common_parse_port() to only parses properties from
> > the Root
> "to only parses"/s/"to only parse"
>=20
> > Port(and its children) without checking the RC node. Also change
> Missing space after "Port".
>=20
> > pci_host_common_parse_ports() to return 0 when no ports are found,
> > since it is not an error.
> >
> > So now both functions won't return failure for "property not found" or
> > "port not found", they purely returns 0 on success and a negative
> > error code on real
> returns/s/return

Thanks, will fix these issues.

Best Regards
Sherry Sun

>=20
> Best Regards
> Richard Zhu
>=20
> > failures.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/pci/controller/pci-host-common.c | 29
> > ++++--------------------
> >  1 file changed, 5 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-host-common.c
> > b/drivers/pci/controller/pci- host-common.c index
> > 67455caaf9e6..7ce5a939e3d9 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -108,8 +108,7 @@ static int pci_host_common_parse_perst(struct
> > device *dev,
> >   * dependencies and the driver may fail to operate if required resourc=
es
> >   * are missing.
> >   *
> > - * Return: 0 on success, -ENODEV if PERST# found in RC node (legacy
> > binding
> > - * should be used), Other negative error codes on failure.
> > + * Return: 0 on success, negative error codes on failure.
> >   */
> >  static int pci_host_common_parse_port(struct device *dev,
> >  				      struct pci_host_bridge *bridge, @@ -
> 128,22
> > +127,6 @@ static int pci_host_common_parse_port(struct device *dev,
> >  	if (ret)
> >  		return ret;
> >
> > -	/*
> > -	 * 1. PERST# found in RP or its child nodes - list is not empty,
> > -	 *    continue
> > -	 *
> > -	 * 2. PERST# not found in RP/children, but found in RC node -
> > -	 *    return -ENODEV to fallback legacy binding
> > -	 *
> > -	 * 3. PERST# not found anywhere - list is empty, continue (optional
> > -	 *    PERST#)
> > -	 */
> > -	if (list_empty(&port->perst)) {
> > -		if (of_property_present(dev->of_node, "reset-gpios") ||
> > -		    of_property_present(dev->of_node, "reset-gpio"))
> > -			return -ENODEV;
> > -	}
> > -
> >  	INIT_LIST_HEAD(&port->list);
> >  	list_add_tail(&port->list, &bridge->ports);
> >
> > @@ -158,13 +141,11 @@ static int pci_host_common_parse_port(struct
> > device *dev,
> >   * Iterate through child nodes of the host bridge and parse Root Port
> >   * properties (currently only reset GPIOs).
> >   *
> > - * Return: 0 on success, -ENODEV if no ports found or PERST# found in
> > RC
> > - * node (legacy binding should be used), Other negative error codes
> > on
> > - * failure.
> > + * Return: 0 on success, negative error codes on failure.
> >   */
> >  int pci_host_common_parse_ports(struct device *dev, struct
> > pci_host_bridge
> > *bridge)  {
> > -	int ret =3D -ENODEV;
> > +	int ret =3D 0;
> >
> >  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> >  		if (!of_node_is_type(of_port, "pci")) @@ -174,8 +155,8 @@
> int
> > pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge
> *brid
> >  			goto err_cleanup;
> >  	}
> >
> > -	if (ret)
> > -		return ret;
> > +	if (list_empty(&bridge->ports))
> > +		return 0;
> >
> >  	return devm_add_action_or_reset(dev,
> pci_host_common_delete_ports,
> >  					&bridge->ports);
> > --
> > 2.37.1

