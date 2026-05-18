Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE263E1D0B;
	Mon, 18 May 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093764; cv=fail; b=fcyXU5GiI3Vjq54uJ6icFxl0wNxD5JxbyBPFrXfJij1cM6Y0A6XknIdzMoaKqevJtmNT0jltXCqrifPbaz77pqYRL1LWHJDjQwHaP0Bt+zJuBMVwtuVjxFl3z2sW3f/FEt0se4INuorS4TYquISjUqC1D8TFYovGEyDe42PiM0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093764; c=relaxed/simple;
	bh=yl3ldlDU7wQ7r9Ow1QCmmtbBQaqpowIZhTI5yCKR8sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wbo1BD9zPfDFatY2dBbq8fy8zslO99jRko2Wp9CqTLDJEMbp8vDM5USPmUlAM/8eLhqWlBxaTazxw9YMccji7phtFTvoydKucKFxVoubmwYELgo+ZyF6iam66/Lfz4qMpd5PisfDnkDNlVq3YR5WnmJMhUhzXjUaX06F/le4ALc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OdpEfQyv; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdpEfQyv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qttYvNkrhVUrEjR38A2v429ocOph9uCjz++DfMIltezVRmbdzz/aWfkBMJxhRC4VVp3PXRI0Du7mOxdgwgj8/9o2pK7g4W9eXP5ZpaiRIWAlCtr9BytvplEPIqgZjWsZsmhpAHg10yDFskgQUlB+0qpQWpf2FmMin7OCkyuIHotgfdlfMlyaPYw7wHTD3w0YpQGt2R5xujWAsaAPTGuIioeW0w+53+oTCRw6hJHrSUR0slM386XemCGB7tR3vjgfPo9r1DJBi0HUJjQFvJ/z3jut+rUw+fPRK+ZRio9j808bG5k6xgv5xMVI9N+X3T+sS0fUwnCXcNuG7jHgNOZkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se49UU57phbmkJgjmZO35eDRlLDBBH2ZxwM8OzuGous=;
 b=KFIM8661x+y8DEOlWxHQaJZG3806Pk8DM7ozFUBW4Xg5UCDwLfiOhRHXSbphlpDG7lpzd4FmNeRcGaSw/AVS4o/dy6PlZQG3gL9W5SUzhw6mkBLSlC2mzeLccEddf05YKx2E6BZqZV9P+1a+RBi9PwARcT7G8kZDHMAMkARCdPBnrKdrAexC84aheeB3JeWXxjLp2lMryUsV7v1X3Yg6KoMyPKNpTYhn67OcEGDlVXzIFriUhP5RAjUeqDvjtBodSNGK4rD4oamqGPgt0dPZ6UWTf3yTSnAReh8EfIrERZnD5jmjVxyCYrPcPyHD5AQc4rPdPTxHHbRFQEwkybDy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se49UU57phbmkJgjmZO35eDRlLDBBH2ZxwM8OzuGous=;
 b=OdpEfQyvQDnel66ksEDoAJYCU0NEMhaKnA2k2CEeR1aEFpHXS3AzpNIE6jHaDEQMa3e1V8Z3Xo5lO4gYITyryLZzoFbdYlxI1+xF9bkjCPoy8m9rHJZmhktKoxseavSVhMpH3PDcKkhjtcfA24elKuTjKU2gzOTyL0Y3Vu8GORb7zccqz4TIeDBBBy4f4MLMyAO5vGD5EG3LT/CUm9/OewiOv3U6NTTNsJIodH77+n9QTux52+3608wygEVDCyM858e15CSfIKmUSr9Jc9qHohiZkQfpWja81Iq6lGxAFdHXMPZiC7jpguFcLzfA7W71PW2oajppViPltGWmXC86Kg==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB9450.eurprd04.prod.outlook.com
 (2603:10a6:10:369::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 08:42:38 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:42:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Hongxing Zhu
	<hongxing.zhu@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Topic: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Thread-Index: AQHc0jsxliV0xf54o0mI/gzBxIIshLYMsR4AgAbuO4A=
Date: Mon, 18 May 2026 08:42:38 +0000
Message-ID:
 <VI0PR04MB1211452312EB9BC6EF1ED2E0192032@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260422093549.407022-3-sherry.sun@nxp.com>
 <20260513224944.GA341451@bhelgaas>
In-Reply-To: <20260513224944.GA341451@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DB9PR04MB9450:EE_
x-ms-office365-filtering-correlation-id: f5098160-6264-43a8-da33-08deb4b96a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799003|22082099003|56012099003|18002099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 Cidq266q6PlNlWUGDmqZYpVkGGKq76gSEgvK9ITPnKdRR/Xzg7BpgxiRrnhUc5mpf5lHzrhIFA2u0d269J+mrnYQD7PQxgMfGykaYb+sChartgukqGx7AJCfVn7D6aOxneDTHXQ9MYTdRRXn0yrTcFTxITnPNsWYfnbTO7rNc7r8kk+cs/B7MMyhPZGZ/nAoi5YWTqJtbfCv4QCtJaak7OdoEhTJ24PLQrKkaqpeONr4nMBI6cq5KpYlqVr69YOy8bwoWPuR8FOkz3JlA/JpDgSt/NdPnN4XlYRGu2saH3B/h0VkVIslL22b10sCHxEqJNnYd4PAa82E8tsdPb38hq8LcluM8GkxUBk9TFFHP0XqBvm0XapwmPAHrx2gG2OPuSVJjBko+dTJwMSq364cZikWAKf+zzwYYzGh46dzCSGRcfSqicDU8wESzGUsK19uTnWpv0B6Fl5MZbTlmGpZ9j82gVY9MbMsxjb1eGHDcpYT2E+VYI66XU9VTNmpgQuAtDkJJPlgr9sqbJnpxEZb8oAkx2LcAb+cDyJtzcVEh3swvgp8w+ckPipNiZA0NZLxadMjkW8YYawef3OvRBf8GL8XlyEEV3DJ4qEqB8bajoKfN0CAd7ERbYzVdfkm5vQa5kCsZMCVNql5PcOHO+p7D+OYwXuNTh7aSJwKp5bCt5OGZ5lYSkcCKQoD7KCUG/wmP4/4yV6j8a4oUbVSbGYPXdVzfjr/ldlN/kdWPPZ4n4DJ98wxwunIR1pN7vPUubQK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(22082099003)(56012099003)(18002099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ncPHyt0N9sF7eScjLHeoHWHoXLo6jh+m+9RmRvCnpCD/5IlyTJqjhrIY/PUK?=
 =?us-ascii?Q?frxkQlueRTieD+L0FvUa7wFNUEDJaoSDXhRrVkeeZk0ohTpSAVvjepL0OPZM?=
 =?us-ascii?Q?AYRHsXxnWEY/dET7xqm0GJ0k5IpNj9wgrHmU+vwwN5aFvh2GZkQpZ/Kvp9nq?=
 =?us-ascii?Q?GBLUezN+tm1nfY9MuKakE/oaqUQXsthM+j78effZa6iF4lcrQnPYxQhy2L9f?=
 =?us-ascii?Q?MBYjOkiLKixiMV+Z4R0pKXAediougn/eDgTnUq7+exGEScin2xciA4HTPEfU?=
 =?us-ascii?Q?kXuGRfhXd6/fi5lOy7niomewhHeZMV8ycyTQIV7tAN8CMpff74qn3OAGN1W2?=
 =?us-ascii?Q?c2u3LHFKuH6Za0C874QQf9sKo2uvw4wBwNI8QQ8lhNFe9llNgha40H2Mae3g?=
 =?us-ascii?Q?jit3n7m/Y3ttwAs1oqlovI7DR3gHNDV0Aew64bKhe0DOAj1ESLzaUWSRZ44y?=
 =?us-ascii?Q?Lji+WtBf2DVHiDekP9wkvoE2QspKjo5wt3G6CvPhtrmMQ0eCNf6YedqIKu9G?=
 =?us-ascii?Q?pKVWNLSLFDhu/DKP2mi/vdjaz1QqM6FEcDY50fYcjWsPNpgruV0g0Fl2DuXj?=
 =?us-ascii?Q?2fVv2QP4OAQMXQ//v4RNogJsyGVqa172nG1dL2ReDStRNQ9wB8TcvCD23Aoy?=
 =?us-ascii?Q?uQipCQRfiqcmQ4lolnIxfo0d/AojBiBqK/fh8MhOsSLQEbLOsA3HLAu9LnOb?=
 =?us-ascii?Q?p72tDiPcB8IsBNzXsl8H94E13CFTL5bjeNOFI7C/13IAgK3vZW6j3pgfp7I1?=
 =?us-ascii?Q?fFKPYTFU2JDk8v6YYqAqhA0TuTi0LsvzfRlus2lN/E/l8mcHUSXTDRuAHEpL?=
 =?us-ascii?Q?j1BMHxXMF0zoDlQA6V+ECJQKLRr/f92l87t2Adb0g5iMZ8HNsVhjFMFANmPE?=
 =?us-ascii?Q?KMgXZ5h12aQ9ARHzuM+FOF5azRsUalRTfaiBdCnItKbEQZBg1yljHOjilscv?=
 =?us-ascii?Q?hJQviTsNGafKYgwNylwosqNQZsvQ81MuT0uR2bWdE3gTndFnjJVm7B/ubnSa?=
 =?us-ascii?Q?P94Z27Fv65R4l1ue8OK3hKGVowqnLOJGem7QpVkgHjgb/MMByNm40MA03QDJ?=
 =?us-ascii?Q?/6jcGnkSa+OAGobXe6pSaIN4al/Ju28hYFeDh/Te1nUtbji4qIn/rDgatwVs?=
 =?us-ascii?Q?4ZfPXsaahaIhEVhTsjrj3Z6jDw0KsuGI1WlYDufJDBoHjBi9YAJv4krLk0gZ?=
 =?us-ascii?Q?U5GnKW60EI+QOC3MbVPJnMhIB6zXY22K8DGsL7RB5ebtfVK5Lz260DVK0Ifi?=
 =?us-ascii?Q?BtsebBfelsogyCBQgHwoJHY6bu/6QtmPTtR92CWGyBW9nOW2ftEDboUGsNte?=
 =?us-ascii?Q?WvbK/qrZ3CxTcIlcLYs/+eHheCcTmZGc8TWWFsSsnvlJ8DMT+nHE0T5BxtfM?=
 =?us-ascii?Q?HPBG35ssweLwaeh3E0AljmHEw6OJCP0PbbYfhum7zAuUsK83DsniO7Uj8hTx?=
 =?us-ascii?Q?JFmX4omOiDIwayB5djfMRnkycYmLg7VlIWNoiML7dRamkHZfxjh4UYyPI/wN?=
 =?us-ascii?Q?oiYGX5ErVeQaLP65M+zjADLDi6xE01JrTU1DoW2wmu5/5bcP6dE5Po4h7pF9?=
 =?us-ascii?Q?ySwk92K5swAgBov99MsUUzcQQX1ula+ToypvqaaWexpvQUoO+Jcsb4DS4HDW?=
 =?us-ascii?Q?A8tNJVYArMyY8QXWK6TPDXfNF0/xNa8yH10pRSlXrDtpe3Pc8xoB2P6ibFGF?=
 =?us-ascii?Q?wABw85hEwiqltQgaPNo4w+KpGM/6nxe0jHddY69ou1ul79AN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5098160-6264-43a8-da33-08deb4b96a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 08:42:38.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SW+DrQZzwfvnsf3Nguka/esxfUqwaK0/aaYf8oyb0DT55Ur9jQzKRZR/HDTnZjw1Y+Y/ZwhsCbwTtAMz7f6MOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9450

> Subject: Re: [PATCH V14 02/12] PCI: host-generic: Add common helpers for
> parsing Root Port properties
>=20
> On Wed, Apr 22, 2026 at 05:35:39PM +0800, Sherry Sun wrote:
> > Introduce generic helper functions to parse Root Port device tree
> > nodes and extract common properties like reset GPIOs. This allows
> > multiple PCI host controller drivers to share the same parsing logic.
> >
> > Define struct pci_host_port to hold common Root Port properties
> > (currently only list of PERST# GPIO descriptors) and add
> > pci_host_common_parse_ports() to parse Root Port nodes from device
> tree.
> >
> > Also add the 'ports' list to struct pci_host_bridge for better
> > maintain parsed Root Port information.
> > ...
>=20
> > +static int pci_host_common_parse_port(struct device *dev,
> > +				      struct pci_host_bridge *bridge,
> > +				      struct device_node *node)
> > +{
> > +	struct pci_host_port *port;
> > +	int ret;
> > +
> > +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&port->perst);
> > +
> > +	ret =3D pci_host_common_parse_perst(dev, port, node);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * 1. PERST# found in RP or its child nodes - list is not empty, cont=
inue
> > +	 * 2. PERST# not found in RP/children, but found in RC node - return =
-
> ENODEV
> > +	 *    to fallback legacy binding
> > +	 * 3. PERST# not found anywhere - list is empty, continue (optional
> PERST#)
> > +	 */
> > +	if (list_empty(&port->perst)) {
> > +		if (of_property_present(dev->of_node, "reset-gpios") ||
> > +		    of_property_present(dev->of_node, "reset-gpio"))
> > +			return -ENODEV;
>=20
> This doesn't seem right to me.  The parser of per-Root Port properties sh=
ould
> not be responsible for deciding whether legacy methods are valid, i.e.,
> whether a property is in the Root Complex node.  I think it's up to the c=
aller
> to decide whether it needs to look elsewhere.
>=20
> I don't think this even needs to return a "success/failure" value because=
 there
> may be more properties in the future, and not all will be required.  This
> function can't tell which properties a specific driver requires and which=
 are
> optional.
>=20
> The caller can check whether we found what it needs and fall back to a le=
gacy
> method as needed.

Hi Bjorn,
The code here was suggested by Mani, https://lore.kernel.org/all/lnzprzrdwr=
a7pn7d6m3sbj5pvjy64blwpjl6i3lmlnfbyho63b@czpyhpgz5vum/.
I think your suggestion here is reasonable, the per-Root Port parser should=
n't
check the RC-level binding. That's a policy decision that belongs to the ca=
ller.

Hi Mani, if you also agree, I'll rework this so that:
1. pci_host_common_parse_port() only parses properties from the Root Port
    (and its children) without checking the RC node.
2. The function won't return failure for "property not found" - it will onl=
y return
     errors for real failures (e.g., -ENOMEM, GPIO acquisition errors).
3. The legacy fallback logic will be moved to the caller, which can inspect=
 the
     parsed result and decide whether to fall back to the legacy binding.

>=20
> > +	}
> > +
> > +	INIT_LIST_HEAD(&port->list);
> > +	list_add_tail(&port->list, &bridge->ports);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pci_host_common_parse_ports - Parse Root Port nodes from device
> > +tree
> > + * @dev: Device pointer
> > + * @bridge: PCI host bridge
> > + *
> > + * This function iterates through child nodes of the host bridge and
> > +parses
> > + * Root Port properties (currently only reset GPIOs).
> > + *
> > + * Returns: 0 on success, -ENODEV if no ports found or PERST# found
> > +in RC node
> > + * (legacy binding should be used), Other negative error codes on fail=
ure.
> > + */
> > +int pci_host_common_parse_ports(struct device *dev, struct
> > +pci_host_bridge *bridge) {
> > +	int ret =3D -ENODEV;
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +		if (!of_node_is_type(of_port, "pci"))
> > +			continue;
> > +		ret =3D pci_host_common_parse_port(dev, bridge, of_port);
> > +		if (ret)
> > +			goto err_cleanup;
> > +	}
>=20
> I think we should export pci_host_common_parse_port() itself and drop thi=
s
> so we deal with a single Root Port, and drivers that support multiple RPs
> should include their own loop similar to this.  That way the driver can d=
o
> several things at once in each iteration of that loop, e.g., get resource=
s, power
> up, configure, etc.
>=20
> I see that would require some rework of the devm_add_action_or_reset()
> cleanup.

Thanks for the suggestion, make sense.
I'll export pci_host_common_parse_port() to deal with a single Root Port
and drop pci_host_common_parse_ports().

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev,
> pci_host_common_delete_ports,
> > +					&bridge->ports);
> > +
> > +err_cleanup:
> > +	pci_host_common_delete_ports(&bridge->ports);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> > ...
>=20
> > + * struct pci_host_perst - PERST# GPIO descriptor
> > + * @list: List node for linking multiple PERST# GPIOs
> > + * @desc: GPIO descriptor for PERST# signal
> > + *
> > + * This structure holds a single PERST# GPIO descriptor.
> > + */
> > +struct pci_host_perst {
> > +	struct list_head	list;
> > +	struct gpio_desc	*desc;
> > +};
>=20
> How do we associate an element of this list with something?
>=20
> Based on the imx6 changes, I guess we don't; we don't even associate the
> pci_host_port with an RP.  We just assert/deassert PERST# for every RP at
> once, and we do it for every GPIO associated with each RP.
>=20
> There's no way to assert PERST# for a single RP.  I guess we don't need t=
hat?

You are right. In the current design, we assert/deassert PERST# for all GPI=
Os across
all Root Ports simultaneously - there is no per-RP independent PERST# contr=
ol.
And I think we don't need it for now, for most platforms, multiple RPs typi=
cally share
a single PERST# signal or require synchronized reset sequencing during init=
ialization.
I am not aware of a practical use case where independent per-RP PERST# cont=
rol is
required at the host controller driver level during probe/remove.

The per-port structure is a natural result of parsing per-RP DT nodes (each=
 Root Port
child node maps to one pci_host_port, with PERST# GPIOs collected from the =
RP and
its downstream nodes). Even if such a requirement does arise in the future,=
 since
the controller driver now owns the multi-RP loop, the driver that needs per=
-RP PERST#
control could associate each parsed port with its own per-RP context and op=
erate on
specific ports independently.

For the i.MX case (single Root Port), there's no need for per-RP PERST# con=
trol -- we
just assert/deassert all PERST# GPIOs at once.

>=20
> > +/**
> > + * struct pci_host_port - Generic Root Port properties
> > + * @list: List node for linking multiple ports
> > + * @perst: List of PERST# GPIO descriptors for this port and its
> > +children
> > + *
> > + * This structure contains common properties that can be parsed from
> > + * Root Port device tree nodes.
> > + */
> > +struct pci_host_port {
>=20
> "host_port" is not really a standard term.  And despite the comments abov=
e
> and below, I don't think the list is restricted to Root Ports because we =
traverse
> the whole hierarchy below the RP.

Ok. How about struct pci_root_port_info to better reflect its purpose, I ca=
n also
highlight in the struct comment that it holds common properties parsed from=
 a
Root Port device tree node and all PCIe bridge nodes under this Root Port (=
currently
only PERST# GPIOs). Or any other suggestions?

Best Regards
Sherry

>=20
> > +	struct list_head	list;
> > +	struct list_head	perst;
> > +};
>=20
> > +	struct list_head ports;		/* Root Port list (pci_host_port) */
