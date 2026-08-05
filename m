Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B113AC0F5;
	Wed,  5 Aug 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895647; cv=fail; b=FkAgixPGzWO1tqonD9hXGOZ9l9zFfVpTYMKaYVoOOP8HkGtN+8PZ/HP0J2U2uUuJyNGVapy/2X5WeHDJa0ncCSnDqYcK0A0cfBdZBcd3myjFA1DxQepUnysn5YulsVnianWpvpMrSguqlQ3+miO6/2Zg8ixfeLGWM8zpK1OfKVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895647; c=relaxed/simple;
	bh=uclxwe2xQlFIBzjb5Ik6gcfWbipd4wNMHGS0xh41KZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rh3+Xr5ZRUUcXsXnD3Bwa8hwCxtmzAONKo+O9jmgbU8gLWVHOprI7BltCy2XCJcOczcyvGu6fc9MRewSoKwioVJZzzpgBqGu1FSJXQdvPwUbBvSbPOvcLdEKMU3K+5/Wykfzg7jHDZ//LJBHyF53fBTYwD6SOW0TM05EtFSf64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bHbSpQRp; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bHbSpQRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt7OO/Amqp8gspFkZFNSObl2qSBab7/dyvMOUm1T4AaLvfzCdbgA9zTsLCP612NiEM8H2KkGlfFxx7lXKsFILkuKONeTJ4ktLf/Uf3FoIxsyz3TmrPcPDjrKnouZwRg/ByFQPU1QxRDwmdL2/dyfpC1LCz0vtUrWL59+bAfOIWgXd0v8dK2WVgdhtOT+HPygbfG19Wc0YaU2oaX51uR2VWtxFWBqqSo90HQaygoFb4bG8BlY2VAVO3VE4iSn12Q+0gfJCk+AwxlspwT6/g3ot6lqGYHa3O0nW74sdElAqb3naJ0IYotMQq62wczgo3V3FVBQPWuP77xnNTk7zAgdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8DyK/ulKJwNN6aJvX6Mim9Twe4oXqSZwoNIsM/EOFo=;
 b=dGrZH4n60D7f/xn6dHwzreat6raBYkPMBzYHfrXCJ2BFVacdwVA6sLCygFR8BZrnEzgGQGTI27/81vU009O5PND7FuBCaY+9r+lcgovcQEJvtAJpRXcMulgRukyyArhSKgcFdHwtHLFIYtwBCXmWVRP+4gbSHQGgb4NB8IyNcCHWE5ptGw8iKNFVt25x9CiNZOTwVfw3LoDCDrkwDJz7PNsNrKdkiixG3fseFvAnjABwzxq1U0/Ew5v1eYLOhvVmFjHDu0peKhhYVqlTBU2jeIjTOswbRC75edSrgK0wEOIGZnCGcRAeLqDNN2kmslSoOOn5pc8Gzm28kKle5G9T8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8DyK/ulKJwNN6aJvX6Mim9Twe4oXqSZwoNIsM/EOFo=;
 b=bHbSpQRpHqcQNdnQCkRdJjYoMjLUZr5kaJUjEVjKD9Yw7EQDo6BrjzDW9uUCySa4y6/QNuAE2Tt2wc9Dr5pFU8+YRjiV/nnTbyzHYASOQzADZGwezj09SvYXFqO4UCLRkoEYbeYJqKM+yUUd9inxeOF94NmV1tYt+kwBSTNmDrwcmcsKlxfGC/iXTDWW/CbTSI8ei16kA9Mirja9z6jawKtGlAmhz0KK/AgKhrrqlA31sNrVx7gK5Il6P5AgkEugU2+Sx5HzHvDblWtd0rvayJ5a9AjlCaOWWnYwQx+ntbZQcNoYOMT7UOyZB4VQ/o7dwIg1g7e5tOnhh/SSrh7r2Q==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by MI9PR04MB149546.eurprd04.prod.outlook.com
 (2603:10a6:290:bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 02:07:22 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 02:07:22 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms with
 RC power loss
Thread-Topic: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Thread-Index:
 AQHdH6nG8t4d/+36IkayVsl6C+RRu7aFt+kQgABBO4CABoJRAIAA+yKwgADFdgCAAILrkA==
Date: Wed, 5 Aug 2026 02:07:22 +0000
Message-ID:
 <GV2PR04MB12019B910276AFAA820373C028CD32@GV2PR04MB12019.eurprd04.prod.outlook.com>
References:
 <GV2PR04MB12019D498722B4C8A94C2A1A28CD42@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260804181846.GA1846400@bhelgaas>
In-Reply-To: <20260804181846.GA1846400@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|MI9PR04MB149546:EE_
x-ms-office365-filtering-correlation-id: fa25a95c-6f42-4a55-73fb-08def296499e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|23010399003|4143699003|22082099003|18002099003|38070700021|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 f/UGbHU/v5DZc6sJwVn8xDk3SGfmHaES/wyj5X7g/utBatOOC6B2M6g5fOcBHwtNglotLfIoL0Rp04g+nHbVJIVsrgY5mlAoLQBkcZ3DgJ0ukMqjtlzHX9/aHibZBFrp08sOQ2UEvuHUx+ebpuxnoOnQWLLyzZI2htZDVfLK/FxebfeS/5XB8CuoUdS9VGp7xP/W6aJ1MILrWLKNcyFTROg8UBo+7HCPfIGpKKJo1MwF+liy5bBhpmElxV8Jsi8mavLvdUtEHIFqj7qzorSduoB7X//WfHOYXk+XhlcEkqSsNLQiKhhMWK7OeBXrMov3B+30NnWKQdHdKcU2qbIvc/T6XaBLtnEU+hqUzsbXLaRKKDomQQHYguUoVBznG1cSE0BbaFXdCwfCysiZIpCqiI+gvQitFAxoYb0UD920oo6smwlt6jeDHEv0FNet9DnOfkE8ODswPFCO6SAZpC5PfGLUImghsAqVUydkeGi7wCZdjnlvO1v0ZkWxrsbglRqlBI2ED8+Viq2cC2UV6pjTiEBocsJrPzIUZTXxN86s+yAAZXhfOZvv61JpQxuu/uwsFC0664ecZaZhKhKoB/RCU0n6dMceq7m0DzbWxQ75wS/XV8kspbcLmFt8CVoRxO5qNBBpSSH957BURWW1Ea9PQ0ewMHi3vpszHwuflcumABjAE97Acg63/CFU8AFJ4UsWaF0PgejobHRMvjyBUpWy014hJUebK5Q9p3+uKyYzLYI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(23010399003)(4143699003)(22082099003)(18002099003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dSpnHcHcwnOH3SNvSgWaXUaRhRxywP3XntFLWvxDQVfN8LIFKxEGfZjigAOR?=
 =?us-ascii?Q?ppA/GoNwCEVEWdg3fnxInX3LmsmR59X/VqnRovKeReOXKR5e2njnU2Hb1ooW?=
 =?us-ascii?Q?aRHsFz1IDbuGGZM6y6fgPgoz5nT/KY4xlglatj0GU0qbK/llx39fgoWd5rVl?=
 =?us-ascii?Q?MPk5v6LnyOIo/2AgR3s4JwbXs8RZUu/QexfFvdaq+0qKRaFXeth4O17sb5NS?=
 =?us-ascii?Q?xUYGt1+7C0ELbOM5TNnv/lkNwPILMtmf/DygEqovLGt9jqiICqa46Zw8hlGA?=
 =?us-ascii?Q?XZWpnKGlpAqKdmEr1YUWYSlebXtq5Mc3ySvVbfkklhEr6WwVaUks/fltKBqe?=
 =?us-ascii?Q?UMboXIdJg0qX8wjco9t0tgW3GQqH2XMsqx8RJZ/OgWvvo0kRC4REBGOCSk9O?=
 =?us-ascii?Q?FMuek/4ToF3dloR4v7lmcgKDAAnI/WOnHpKkKfSexn6PHKIGIUVP5ebrD61I?=
 =?us-ascii?Q?X99WPKUGZuXlmj8aj8m5cVRqR8BWkYKM0a0XtwGgCBloV4TuxtfrDouLJJhW?=
 =?us-ascii?Q?Z5XdovjkjyNDFIRlKJ+JEX7h0hR+DXkMnsCnfTg+BY6Ahq9O2N/mB7yGIA/F?=
 =?us-ascii?Q?jhdS9Fd9g1eEnrOrwiqJHzQXvf4tVDB/gGIIjjs9Vz42E2Inj8fcmRsjR4va?=
 =?us-ascii?Q?LvvTl9x+LWoQX2R2HJTVJdglSW08DBZcOxHL+mVnnIfbc9+iCdKqJqUMavED?=
 =?us-ascii?Q?nstXcT3M/MrLQs54mGNNWhmj+gopdDpS7I9lkxrM5Z9M+HWzBtpMjLo2uf0k?=
 =?us-ascii?Q?B/lNwV6M65KmekW21PTrzmbvTxA8pra0Ag/f9c9/dPkYomGnKZ7TtTejyTDe?=
 =?us-ascii?Q?bnPOLilAo3nvIlUviuTCse74JsgpjgPoEa6FZdfszYY8uiklAgw0q1ZmYhMT?=
 =?us-ascii?Q?9/qqn6WT39W8JKz56YrMpdUfbqoHmUpeCxvpmDo4/HFA3RI8kMWOkStDDUDy?=
 =?us-ascii?Q?LqmtZuCXCRXNfTG8uTP/yTr9Fpi/8fG3WVLmgB8BEVS3Zpg2MtGP1+yS3h+h?=
 =?us-ascii?Q?5sWplcBSAePRtrbhLGrcQHgBgwHrTqonHIHMXfWm/nhGKuOe4hhUPUB7sFtw?=
 =?us-ascii?Q?L/68z0cK0iSv4+uisCH32Mb8shQAyKtGTrpfSDCoOTPU3rdDp1EGWjCwW6vN?=
 =?us-ascii?Q?Am9eXR0f/M1RCibENgWR0n1BLJtJUJv3ys17SHn0L/YOuYYPoirT551ujeFN?=
 =?us-ascii?Q?CcNbryMHCPD/M8hgewsJDQeDl73T0oIdiIFXIcDRR3MVSsf/sU/dEv/RyXiV?=
 =?us-ascii?Q?dPxTik8l+M3VH8nCrLA9CQdvdJkZdgGfH5dkP4OJzVLPIu/JTfNnKBB1zGII?=
 =?us-ascii?Q?2qVzx1efkmul4VChuKnxC5YQe3nAIAEA9eULOd6kf2lR1jNJJ3UaG2QrnGwA?=
 =?us-ascii?Q?/Jk4RBPXHSiy7zlOE1Bv+1vtgEE5Q3oyMEZ1ephcT0kSRyCk+32ba83ZwCte?=
 =?us-ascii?Q?zZsza1txVpgLn1sU8R1Zek/jNl6vjNGjWLPe98Px99bfgwossTRMjnjMtofQ?=
 =?us-ascii?Q?6rOwIicZvEc2pxJGfzU4KwGfpk5YPdG/lNrLoRmSw6F48YN5svoozEJnUJ2P?=
 =?us-ascii?Q?AlKRxZF2pqpfxF+VHzAIg06bK3n33BxZzgr+LHRKWF9E9MeAjEoS7HJXJIkD?=
 =?us-ascii?Q?V+GiKhqnucHzs/YTogYEqJwvo7UZNH/SFVcJ8wrt7lhvW3S9olotWy9sjvJW?=
 =?us-ascii?Q?Y91gKyzAbOcBCh7g/TbgP2tZ9R2txGEo6q6IqxXHkWzpDk/XmnYiuQtekCac?=
 =?us-ascii?Q?4psxslG5vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa25a95c-6f42-4a55-73fb-08def296499e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 02:07:22.7307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J65q6j8lkkCRDXVYXQHED61L8+genoYPJU8FepHWLGbKt9jkll1KTizWWOghvbFG1dwZyymSS74K8zW/R98cVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB149546

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, August 5, 2026 2:19 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>; Frank Li <frank.li@nxp.com>;
> l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org; lin=
ux-
> arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms=
 with
> RC power loss
>=20
> On Tue, Aug 04, 2026 at 06:32:26AM +0000, Hongxing Zhu (OSS) wrote:
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > Sent: Monday, August 3, 2026 11:33 PM
> > ...
>=20
> > > On Thu, Jul 30, 2026 at 07:09:13AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jul 30, 2026 at 08:16:36AM +0000, Hongxing Zhu (OSS) wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: Thursday, July 30, 2026 6:30 AM
> > > > > ...
> > > >
> > > > > > On Fri, Jul 17, 2026 at 03:41:21PM +0800,
> > > > > > hongxing.zhu@oss.nxp.com
> > > wrote:
> > > > > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > >
> > > > > > > Some platforms like i.MX power off their PCIe RC controllers
> > > > > > > during system suspend, requiring full re-initialization on
> > > > > > > resume. These platforms need to enter
> > > > > > > L2 state to properly notify endpoints before power loss.
> > > > > > >
> > > > > > > According to PCIe base spec r7.0, sec 5.2, the system
> > > > > > > software should transition the device into D3Hot before
> > > > > > > broadcasting the PME_Turn_Off message to initiate L2 entry.
> > > > > > > However, some endpoint devices fail the D3cold capability
> > > > > > > check in pci_host_common_d3cold_possible(),
> > > > > > > which would normally prevent L2 entry.
> > > > > >
> > > > > > Wakeup devices that don't support PME from D3cold will fail
> > > > > > the D3cold capability check, but I don't think those are the
> > > > > > problem you're solving.
> > > > > >
> > > > > You're right.
> > > > >
> > > > > > This appears to handle devices that are not in D3hot, and
> > > > > > that's not a property of the endpoint; it's a property of its
> > > > > > driver.  Is the problem here that some driver didn't put its
> > > > > > device in D3hot?
> > > > > >
> > > > > I observed some endpoint devices failing the D3cold capability
> > > > > check, but I haven't identified the root cause.
> > > >
> > > > Seems like some instrumentation in
> > > > pci_host_common_d3cold_possible() could tell us which
> > > > devices/drivers are relevant.
> > > >
> > > > > > > For platforms where the RC loses power during suspend, L2
> > > > > > > entry is essential regardless of D3cold support, as the link
> > > > > > > will be lost anyway.  Add a suspend_poweroff flag to force
> > > > > > > L2 entry in such cases, and enable it for i.MX PCIe
> > > > > > > controllers.
> > > > > > >
> > > > > > > Note: This violates the spec requirement that devices be in
> > > > > > > D3Hot before PME_Turn_Off, but is necessary for proper
> > > > > > > operation on platforms with RC power loss during suspend.
> > > > > >
> > > > > > If the device isn't in D3hot, it may still be active, and I
> > > > > > think the PME_Turn_Off will abort any DMAs in progress, which
> > > > > > doesn't sound like proper operation of the endpoint.
> > > > >
> > > > > You're correct - this isn't ideal for endpoint operation.
> > > > > However, on i.MX platforms, the RC controller will lose power
> > > > > during system suspend regardless. Without sending PME_Turn_Off,
> > > > > endpoints would have no notification before the link abruptly
> > > > > goes down.
> > > >
> > > > The PME_Turn_Off is some notification, but I don't think the
> > > > endpoint can do DMA or MSI, so its driver won't be involved.  It
> > > > may be able to do things internally, e.g., write caches to an SSD
> > > > or transmit packets from its internal buffers.  But I think it
> > > > might still lose power in the middle of operations like that, so
> > > > it doesn't sound reliable.
> > > >
> > > > > This patch adds a flag to force L2 entry for such platforms,
> > > > > choosing to notify endpoints (even if not ideal) rather than
> > > > > having the link drop unexpectedly. I'm appreciated for
> > > > > suggestions if there's a better approach to handle this
> > > > > scenario.
> > > >
> > > > Mani recently added pci_suspend_retains_context(), and I think it
> > > > returns "true" on i.MX.  But if the RC is powered off and all the
> > > > devices need full re-initialization on resume, it sounds like it
> > > > *should* return "false".
> > >
> > > Right. pci_suspend_retains_context() was added just for that purpose
> > > of telling client drivers to prepare for context loss. So if this
> > > API returns 'false', then they should not hold the device in D0.
> >
> > Thanks for your comments.
> >
> > If I update dw_pcie_suspend_noirq() to use
> > pci_suspend_retains_context() to determine whether to proceed with
> > L2 entry and RC power down. The new logic would be changed as below:
>=20
> I'm not suggesting using pci_suspend_retains_context() in
> dw_pcie_suspend_noirq().  pci_suspend_retains_context() is for endpoint
> drivers.
>=20
> I think pci_suspend_retains_context() should return 'false' on any platfo=
rm
> where dw_pcie_suspend_noirq() is going to send PME_Turn_Off.
> Sending PME_Turn_Off means we intend to remove main power.  When main
> power is removed, devices will be in D3cold and they will not retain thei=
r
> internal context.
>=20
> If pci_suspend_retains_context() returns 'false' and
> pci_host_common_d3cold_possible() returns also returns 'false', it means =
some
> driver didn't put its device in D3hot when it should have.
>=20
> In that case, I think you should either fix that driver so it *does* put =
the device
> in D3hot (based on pci_suspend_retains_context()), or just accept that yo=
u can't
> power off the RC.
Understood, thanks for your explanation.

Best Regards
Richard Zhu
