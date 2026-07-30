Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4E31960B;
	Thu, 30 Jul 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399406; cv=fail; b=nfBj/mAZzY7Kc10kz0EoEckCPR+a8GzCdOjPnvjFmABBd4vkZXpo03+I49T8S8oNFBjQ74Xo1E1AADwY5gGJap6hQ1kf3U1rsJGFYFjtw8UR23JMMqERHfx3bgU/mjjB23F5ut6MsWHmZSZv3OxV5mMIWdX+BZeNipCNrQ0fd2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399406; c=relaxed/simple;
	bh=PXOjg3BOQTveymnvlQ6E0yx6ogThqsNoQ37/mVt3XHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wrh7Z+TEJvPnBv87KJgOjRQNoSWpg6Fxmgs2Mdq0z+LnwTPO7OFbp6oLri8wAC+Lqp+kYrS1WYI7dxiLqArunGckrrN5q8QH7ctXPmfhfgr+wKffDyud4+SutbjAqd8ht+ASlStgL/eYQjzWmjT11PylRu9ro2Sg7jqs9vJJhKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=raeiEPma; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="raeiEPma"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0styMdm9PoPyzWOa1r4EhIeu8p+q22zmjR8kXjZqYcxyGmmt7y62g+agbz+N9RGZZyYHtW6qN9EH23z9Dw62y4tX34Qte8GdbiL0F/4RuEOPGv/QoPd2AoSBEHjxo3v7aUhYPsMedIxaDUpVQUW0CTay5bbSIhEMTsYLZib1qYtmy5gTzuiWzIN2op3eP8Kjpel2UA2Xph0eN0jfwjGJ80NRDupEHobqXbmUCZhQsQ/0aaM0rWtxi+M3+EDb8h7Zt56+hNFm3HutPcnVI/8R2AngZzb/uYpMutVd49HR+LS2MC27qFbeuoSl9UhGo73m9OdU/WRZskHrPJWT83QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAcjBe82Ke7CVi17ZsTQFBiwepjYmc7ZuAWAiqCmkRY=;
 b=EuKUbOTz+Cb7EFhVgBgpKxZ6qIFmNWol46Ay9DBpCnsDoVLTdk5E2V3CsF+Y9F0wRVzqN/N1gRfobGofZW3sNB/pypYrJN/Swx5jIk7zAG3iaNj+Hc74Q+P/yUZKlbNmQ+Uu4lLQMNCIuhdhf3/ZWYeM+FEN1n+74zwHxzqSnmdtvh5eksEOehNPvVNFc+zW0W5y2GGoaB2hqKlgNwalkH+7UamWthjMO+EZ/W/rGfHMX2UN2Crm5CYP4FxW4XPWO46hILkt8yVuDBudaVrZLjHGcarWzSKsO7MaNJ91jt3ieNu4PQp5SErb72n8mRc4srmA8KbP11WX3T7hrTTF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAcjBe82Ke7CVi17ZsTQFBiwepjYmc7ZuAWAiqCmkRY=;
 b=raeiEPmaJjykZBt6lRTefm/i/SA7GkWMnJhohsYu1eGe9S0iHvE21Bdb4ryxrBaaZvRAqro1HUC5FzNjYPx/gtrD9ktCKhPIRiG449lM4IV+SCU587nrc4mfOMFdN61P4z8f4Ub9mxDYYM2w9yjCusuz9+RR1nrCfJEo6W2B2IPopTGZjRZ1Fq5Ug8ek7wIjpcAPMRpjRskqikhce3LPlt6P1i8YVX1wbQmEnpMlN2nPxr3T6G14G//8ngnSbh+J02+edQ+Mbr8fQoWpDg7jQ13CooGoE0WOaxwXBvz99stRVT6kkRQWRu2xpR62/l2VG+amk/Fz6WiIuZkR/C+hUA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by GV2PR04MB11633.eurprd04.prod.outlook.com
 (2603:10a6:150:2b0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 08:16:37 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:16:36 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
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
Thread-Index: AQHdH6nG8t4d/+36IkayVsl6C+RRu7aFt+kQ
Date: Thu, 30 Jul 2026 08:16:36 +0000
Message-ID:
 <GV2PR04MB12019096F2A9E8337F2A1BF9F8CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
 <20260729222946.GA1466768@bhelgaas>
In-Reply-To: <20260729222946.GA1466768@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|GV2PR04MB11633:EE_
x-ms-office365-filtering-correlation-id: b66b200c-974b-4f15-5f58-08deee12dff9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|19092799006|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|10067099003|4143699003|5023799004|11063799006;
x-microsoft-antispam-message-info:
 +IMDEX5+xglp+LiHzRxA11zPW+IhuSbncjlzVSk1etfOw/HMtSjhIlMOndxZROMXiSfMwSPgY9h4ot3SDEcnEJBF0OGaC/igxOpo4aaokQwtY2LeS5VHC9j/urKri2WNrDkukUG0F3747q0w8HqfGoOzV0TPbYXS1aILnflr5yWSg4Ha1LduS1OmI9PEPkGSekvKutM+3PF26NoWXtosFzzli3WRnC/K12J+Gtb16ePdMfHdvJV6gjXVrFNK93Y9+x7FOKHpoCqbIqMO/K4bMGdFV5Y69WvxPZ8e11fMnr8qmifXjykxNFqkJUhp+IOtSyXF3dOrVBn6lgg23ufW2KyqU9geV4Mdv0noPy0AyJpW6sK9k5D9nAB/Y4qJzrvMadjgklyEmDgMDtDeXHSo2qwdV1GL7WQud93az390WM4CpepK03W2mJGi6jPsqwR9SNlVV87AptKYOIbhuYjzC/tqkhXwmuYIY56KQUhSBBThmJ6C/vBu+QIJ1D9A9yTQNZWC+RxAy5dxAmgz2uFQegr9tLBu1D8DJuNT2ndpcddsriGg008RJiDX3tyriJKiJ0l/bpDxbpudVVtLr82tbLoF66ioLUK8oC5SbrM05xLUM6zOdgjxCRW63XuRxbZ1Hxaa4FXMaOiisD3mDAixButoRk3L7SE7vkmsET1nXJD9zEtTy/1xG9lEzM/V8f2YRhO0mYw/6JPcuVQik6PEIpYDB+r1N15OxAr9CgCO+jk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(19092799006)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DXbOHTWujId8l40MOqxbaTf07jMQnSpUw9W391SlY2652ZhDEZxcD+aJ16MG?=
 =?us-ascii?Q?Hy5c0xIZFhYKD65HMibmIp/J/ECEwmai3+ciOG4pFe0FkTv1sEKiI5Pzc4+g?=
 =?us-ascii?Q?xjiRcHJJIEKCdym6KAczA4ibALX7EzFpaVoLSn22D6blvMN5Ooc0M79hp6k6?=
 =?us-ascii?Q?y9ZsbNJCJwblMRiKLpjXaTAymBjgch360EQ7ZahJujfYwQfgV+HYBrlq1zrN?=
 =?us-ascii?Q?rOpUy2OU3g4RJDvVmmfC26KE6cBfunsnXM+qjZ1tHT5jV0388tbMJy8t10xU?=
 =?us-ascii?Q?uzd2RXukqNhtkpnp6D3V8e1/0dL/RYQ83LUW/+8VDY9BaQoYSePO9il17cSg?=
 =?us-ascii?Q?6k9Lym9mcrve6OlY3uKlJSO5YAgoehlVm4CBOOCKtHO1w2+B81yDgBAURZBX?=
 =?us-ascii?Q?R1Y8VRB3Heccsj5xnH2mIUEZuJtI+InmVxFH0pC2VmjgQvDYkXHGANuFJu3b?=
 =?us-ascii?Q?FegYpxI01hwCNtqS0NqY9pWHTyKPMcFHsVBclq4x1rWWs4ZqzrdYEqAXnMny?=
 =?us-ascii?Q?SZSe/qHyJXfX54w/XNVChberL9y8fRo9kJTY63yMNg7ZhsW9SeJMzTZEIooH?=
 =?us-ascii?Q?6pRFPQlQLTjuZ+swdPgMdcW1SKCuL1Zl1e4F9j3+sFOafVndicz2W1vEav1F?=
 =?us-ascii?Q?mQmPNMGFJP2Wdf0nTgwIz38ToB1XAJcFZj7GSREn2oBwXM8kUgWeazutp2VV?=
 =?us-ascii?Q?p15eWZIF8ASJ35IQuCyzmy13riTUaSUAToyUQRUjGH0aC7t1lzYuNn+XbD29?=
 =?us-ascii?Q?HcDhSh+81+MPnM6dnH7QWw55hEdswW0jHzq+Guhje/uaCtzm5hq6L/RfRcvf?=
 =?us-ascii?Q?65qjfURhMFUq+8gel3P2CGXBr0Mp397dB7qJ9aj73chGowrSpCN8M5o5yhMh?=
 =?us-ascii?Q?mrKmoADUxjazTShdH2KscyzoyfE4s3jRRUWWC4W6EaETDtjbAxh8qQoqRQbu?=
 =?us-ascii?Q?9fXdJw0UQWwurnLsRrfToUlsIL7JsUICB3nh2S8bS7L2PdJwuob10kP5PF30?=
 =?us-ascii?Q?nCrrFrpfuj3ug8cVBKxt6DjEgR9D0BdOyTzjPNykoEvJSqq5RP5bJbqaQBjk?=
 =?us-ascii?Q?RaGIx7C0jLnGDGLm8csVQFHQpyBpkRzNjQLtaRaOeFzFbNrbCQ9p+mPtdMJ2?=
 =?us-ascii?Q?Kro2m+lt5/RVGu6savUTyfR4/Blb3HigVfEXI5ot4Dh2YebcKRvMOBrUjrvy?=
 =?us-ascii?Q?if9MsLrhh5BlTHkTg3JXDsJ1IZrskH9rB3FSmR7A8fA4PDAGGScwNzo6brCh?=
 =?us-ascii?Q?/DsH8jJ/o0BjPGHQQwt+xDiqiIEOI326DW0sWmVsT9PNTyulLerzq6khGIkC?=
 =?us-ascii?Q?hDLmziNnYWHlNKRuMIAYkzZVFQXF8MVP/4ukca4BcJow7R/bxhyc+noNWFen?=
 =?us-ascii?Q?sswkEbyOws3zz4nLVrTgoQxLpLMYV6qVxKyGbxMQk5epPyR6qE97liRSnh97?=
 =?us-ascii?Q?zquZ/HyK/8YY3Bqhly/4C6XDCGrAGxN4xkrjlkGMkU1SfoN4HUXcLD3rnnzn?=
 =?us-ascii?Q?981I86mmx3VhRk8HC2zaBn23obscBJilXYu9c1I4LR443eB9MOZ2l0mKCcg4?=
 =?us-ascii?Q?+lbogJ0bs739geq/r0P682qWfhwEpQG6+Htruz5aBH1ofMvTlNAUj+d0QiR2?=
 =?us-ascii?Q?csHbwLZVR8Rum0sDXlPJJEde2gQQ4SUeaqrNTp+GaG4AZvlahioJjOl1LYBw?=
 =?us-ascii?Q?AdN/mTntujZPajq3/PA324GsOlQxOBAkrPypxKl02ADyGW1vgy06vZVIxynk?=
 =?us-ascii?Q?ARuCvDMdPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b66b200c-974b-4f15-5f58-08deee12dff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:16:36.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzC4IyKYUUvR1qYQF+CYlrK9vwzw/eoZthO6FoH2zYmwKFSGNy+tRXxwKzvdUanFY7nJrJHZn5tNtxU2xULi1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11633

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 30, 2026 6:30 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms=
 with
> RC power loss
>=20
> On Fri, Jul 17, 2026 at 03:41:21PM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Some platforms like i.MX power off their PCIe RC controllers during
> > system suspend, requiring full re-initialization on resume. These
> > platforms need to enter L2 state to properly notify endpoints before
> > power loss.
> >
> > According to PCIe base spec r7.0, sec 5.2, the system software should
> > transition the device into D3Hot before broadcasting the PME_Turn_Off
> > message to initiate L2 entry. However, some endpoint devices fail the
> > D3cold capability check in pci_host_common_d3cold_possible(), which
> > would normally prevent L2 entry.
>=20
> Wakeup devices that don't support PME from D3cold will fail the D3cold ca=
pability
> check, but I don't think those are the problem you're solving.
>=20
You're right.

> This appears to handle devices that are not in D3hot, and that's not a pr=
operty of
> the endpoint; it's a property of its driver.  Is the problem here that so=
me driver
> didn't put its device in D3hot?
>=20
I observed some endpoint devices failing the D3cold capability check, but I
haven't identified the root cause.

> > For platforms where the RC loses power during suspend, L2 entry is
> > essential regardless of D3cold support, as the link will be lost anyway=
.
> > Add a suspend_poweroff flag to force L2 entry in such cases, and
> > enable it for i.MX PCIe controllers.
> >
> > Note: This violates the spec requirement that devices be in D3Hot
> > before PME_Turn_Off, but is necessary for proper operation on
> > platforms with RC power loss during suspend.
>=20
> If the device isn't in D3hot, it may still be active, and I think the PME=
_Turn_Off
> will abort any DMAs in progress, which doesn't sound like proper operatio=
n of the
> endpoint.
You're correct - this isn't ideal for endpoint operation. However, on i.MX
platforms, the RC controller will lose power during system suspend
regardless. Without sending PME_Turn_Off, endpoints would have no notificat=
ion
before the link abruptly goes down.

This patch adds a flag to force L2 entry for such platforms, choosing to
notify endpoints (even if not ideal) rather than having the link drop
unexpectedly. I'm appreciated for suggestions if there's a better approach =
to
handle this scenario.

Thanks a lot.
Best Regards
Richard Zhu
>=20
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> > Changes in v2:
> > - Rename the new added flag.
> > - Update commit description and comments.
> >
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c             | 11 +++++++++++
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++++++
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132a..5a43bf396521b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1957,6 +1957,17 @@ static int imx_pcie_probe(struct platform_device
> *pdev)
> >  		 */
> >  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
> >  	} else {
> > +		/*
> > +		 * i.MX RC is powered off during suspend, requiring L2 entry
> > +		 * to notify endpoints before power loss. Some endpoints fail
> > +		 * the D3cold capability check, which would normally prevent
> > +		 * L2 entry. Force L2 entry anyway since the link will be lost
> > +		 * when RC powers off.
> > +		 *
> > +		 * Note: Per PCIe spec r7.0 sec 5.2, devices should be in D3Hot
> > +		 * before PME_Turn_Off. This may not be guaranteed here.
> > +		 */
> > +		pci->pp.suspend_poweroff =3D true;
> >  		if (imx_check_flag(imx_pcie,
> IMX_PCIE_FLAG_SKIP_L23_READY))
> >  			pci->pp.skip_l23_ready =3D true;
> >  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> diff
> > --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 06722259d2e37..95a31d65e1ca9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1222,14 +1222,20 @@ static int dw_pcie_pme_turn_off(struct dw_pcie
> > *pci)
> >
> >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)  {
> > -	bool pme_capable =3D false;
> > +	bool d3cold, pme_capable =3D false;
> >  	int ret =3D 0;
> >  	u32 val;
> >
> >  	if (!dw_pcie_link_up(pci))
> >  		goto stop_link;
> >
> > -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> > +	d3cold =3D pci_host_common_d3cold_possible(pci->pp.bridge,
> &pme_capable);
> > +	/*
> > +	 * Enter L2 if D3cold is possible, or if the platform loses RC power
> > +	 * during suspend (in which case L2 entry is required to notify
> > +	 * endpoints before power loss, regardless of D3cold support).
> > +	 */
> > +	if (!d3cold && !pci->pp.suspend_poweroff)
> >  		return 0;
> >
> >  	if (pci->pp.ops->pme_turn_off) {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index de4b245b1758c..3ce7d30d9a4d5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -471,6 +471,14 @@ struct dw_pcie_rp {
> >  	bool			native_ecam;
> >  	bool                    skip_l23_ready;
> >  	bool			skip_pwrctrl_off;
> > +	/*
> > +	 * suspend_poweroff: Force L2 entry during suspend even when D3cold
> > +	 * capability check fails. Used on platforms where RC loses power
> > +	 * during suspend and must notify endpoints via L2 entry before
> > +	 * power loss. May not meet PCIe spec requirement for devices to be
> > +	 * in D3Hot before PME_Turn_Off.
> > +	 */
> > +	bool                    suspend_poweroff;
> >  };
> >
> >  struct dw_pcie_ep_ops {
> > --
> > 2.34.1
> >
