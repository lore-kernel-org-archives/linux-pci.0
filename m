Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBD2F8E98;
	Fri, 31 Jul 2026 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464812; cv=fail; b=OLjIVjwXWWts4mpqQOnWGclw/F21Tp3UafuBixR8F0rYPWKjndW9CpdPDPoPjBTBYg22C3kJDPoVVhuvZTlPjS6IoK4cIhy8jPBL/82+AC8Ftg63gekPFvs0MFQ7NFnhVDnMFF9Tmd2K7YMHEgEDCCgkXADI5pJRQcqJ7Dd3P4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464812; c=relaxed/simple;
	bh=Hgl3for+LMtFsu57+xqLM9ZPWYG3Rm2ndMVVBQFf56o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg2iCzJspTgtvbbEmi7XAvcKHmbfNN5Oo7zTq1/lvjG48lkzlAmW8KUAmM11yKDLK3gC/acSrlUadrzMX/eByeOGLFWf1He5V8o0sX9Xdh0H+JLq0/5jCOUPhe61qtQgYMbj/gDp/4sfVj9GezjPqJEsbnI3eXQDRAE0y5zKGeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lE1E66Fz; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lE1E66Fz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izmKUQd1/qsU0JrNPxXVxvKHwj/wgGGLI7yOQzfdnJQD7ch70+IzGGqR3bze2yA46G9rih+ETIR9Hi+PEpyFy6kdem6H92N7FGJmpWFbwitThG0b2MJ3BYdUKi9zH/k3k3S7Y4wTZe9m/iUXpvq0EngB4slIqMYBjTLu+nOmow8g8aI10DcABFbLIhY/3cmLuzh69+HmGTSb5De/dxOlCLxMqMaTVA2Ip0/dtovVKdNF0bR8FDCaG0sSAGNuo3zVk5vfZwToOjEp1LCxdj1OJwAownAf2hnmR0Aqi/zZj9826aJ7Wpa3dPZ7rfJfl9Py36UxDrUmzEtWoEJwLerbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa4X1NcDye2+f+9aIXZYQvC7A0B7efnrHqIJAkgrbOg=;
 b=e3qwyX/hJ7coE5JKiUXwzt3ulq8rOZk04vxBokpKRY47nsQ3MvJt4eQJi9xeKarzsp9j4xtUe4T+3KM4zC4D/4lqU20dNHICQ0tBm7v82zmweYlOTcOOBGU+ejKlktbPdrL8BevDzXvczxUOsY2+qiU27yE719x2jy1TRkqPDhNSgcDWTfcwo3Cy8lHkjMzMt6eE2FKyGh6Bywum9S1TjG/HeZEUNegUp6lxXXEvvI9ZYMRARhySoAgD2h8GT30cTgBHaZXJTWFo7XNeupwCwL7PMZW0+XLP+cbfcpmB85BUCuhuxn6017Xl46DY3BYOFcrscx9HG1CQ+0OWvHm6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa4X1NcDye2+f+9aIXZYQvC7A0B7efnrHqIJAkgrbOg=;
 b=lE1E66FzvWJCASjrYKZOlDwE5jvuioDK6IXul5LIJ1UymszfY1d77GHrsana738CRzfOs7J1+jB+dT00oEatXJ8Jn+QYofai8g3ZTHl9BwEJmBrY53PJg7Zc/hvWq16ae2eJ3yHFuDI5Xgfskxz37Wtk0xt4l4r30CwxpLs1CsVxihFC0vGlbn5rDspUyj/q7FeUiR2yqIVUbSTyrqJF5fru2km8lRlHV9SugcDQEOVAKVbXXScckGGHxcDFltubhXHaKUoZCafu93hr5yF5BoQ/+VnqRbOdjAK42oZs57g+0fCln2MfM9heL3+WeOn2wOTtbNkYqNmuYUlVPy8Epw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AS8PR04MB8708.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 02:26:46 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 02:26:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Michal Gorlas <michal.gorlas@9elements.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Frank Li <frank.li@nxp.com>
CC: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
Thread-Topic: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
Thread-Index: AQHdFxhLkFkgP6Yi4ke6cFtd7G/5sbaEyYOAgAFCOoCAAOwCsA==
Date: Fri, 31 Jul 2026 02:26:46 +0000
Message-ID:
 <GV2PR04MB120190CB6FB05C023AC3246D58CC82@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
 <t2zu6bv4dqf5znpn5uypkoieltlrzlp4kskt6jwp46xgqajhjp@6g5kiwwn72a4>
 <DKBWBNP7VLCF.3FND2WKPV4NWU@9elements.com>
In-Reply-To: <DKBWBNP7VLCF.3FND2WKPV4NWU@9elements.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|AS8PR04MB8708:EE_
x-ms-office365-filtering-correlation-id: 794a1140-54d4-41fc-e7fc-08deeeab2b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|23010399003|366016|376014|38070700021|4133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 LmdHn6IxuH9FvcK2KL8tHXvZVMfFIwYmfHUVcFVlvM9GjIeVk1e1cT7kRuoBiqqIirkieNKvnxA1eHxQWeZvU+GEsp4MVHcxJSSJPxJoybiLlMF/i1GW0FRx8x64C3f8Alhgh98MstcgDMpEPxOV5jZf7qtHo+aOFAlpNqSb5td+9xz1FL9hb++E0vxD0uINztYPmHC68uYvIrxaok4O237MCvmU7D05YP3bcAao9+LrxlDmHlAh6RL5q3IEkF0cXMt78eoBpi9EvC8cznJQsfIF4NX/CimUEHTad3lcLO3SQxWzxTiM7wpkU1EewiFndM8Y8QzUXHjeiY0GMZWlpxbsiIeCe7kexOxHNSUBHDmXNX+3uDBIM1W32M6gCKjpR5MZbjyne8n8SI4mjknrXn6UH9ogzoVwrEhN3HnxgsROkfkOx+ZdqYAswEvoLXDQfYY9QNWDsmjGTQZ2duH4YieUww2Q9IqiWoN0JPZyCu4NtPTpEV1Ed51cGW+70ljKn2Y2qT6UblZwCGBTbPuHFIUGqljLQKvj4s4c+tIlWtpq8Zh6lk0sU8F9RW4M8la3aKdR5DNDGglGb+TxXeQ2Ryx2Pw1qHb26pKpY/vh3XvTrHYSLwF/xUAHCsB6r5Do5H8WcrG2/jBDIVzIM42CpmliW57LclkP7LmKz1/xoA/I33xGs2Fck59dxY0LV+IHmtOJ/0/trsnFaaIbAejumlsEFQLTDCXA5/2oWQXx5u9Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(23010399003)(366016)(376014)(38070700021)(4133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?eYz1UBm39wmv710m/yK9glnLaHM2/Cnop/wnxDVscnQjiKUwZPJ+qE5A0b?=
 =?iso-8859-2?Q?A17bqhohjMZI06uusQm+wi0qJBp/dCfXCfr+H6n90klip8OvOHeR+R/NV4?=
 =?iso-8859-2?Q?FWHwJXQV0wDmPCAFeTneDI7ZcQmzm4BN/1SrtbtE6LDXJqeBrUeEexTst+?=
 =?iso-8859-2?Q?Tsw8mdPfrCyWD0jngMUKindHaf7ckMy1CdliftRAEYDd3GCqmmp+N91Bmi?=
 =?iso-8859-2?Q?ra9i6OCg5X+JiwhDp/b3FMqA3nYylx4X8STyll3g4czGOUaqR1ZZ0R7GqY?=
 =?iso-8859-2?Q?J+ohvWALZB9BCOLsyLTlPZkcBsERo07UNwGyWqFvZIq2fCnAWC8toJ84V3?=
 =?iso-8859-2?Q?8j7zXE/+NC2MvCqba9SL8M5bFncHQcn+N6JA3w8sTevd0qh1YmGzKjUlXF?=
 =?iso-8859-2?Q?xLOmgWjiBBOoQ48SQ7ghTQW7mQpmQ/0OwbXIyo++dGt5GB0HvANRSp64rO?=
 =?iso-8859-2?Q?Wm0zv8Mi3c12V0f7K6Ak2hi24uxk8YkoQndtf+ggDTGlRBncXSi+04xjY2?=
 =?iso-8859-2?Q?KSUIVvWPurVF0nyT5tqzyErfGU70IxVxujy9o54vfwZ++w+ZjwI5ggwdcb?=
 =?iso-8859-2?Q?JGTm+FfsEy/bavirvYwO7R/5zQ4fdyMXzda2DLVLL2OlYYpDqS+BKChIV8?=
 =?iso-8859-2?Q?WEQ3WkIZrQMU1pP/P800l3mTmrgjmRCQURluvepgBtHjwxKMgAaB7/HQ/K?=
 =?iso-8859-2?Q?ZvcaxzggOMwy5sHQr5+laQXANIGThFydNEgGy4xkKJJns0QJzXQ6OmcuOP?=
 =?iso-8859-2?Q?EmyvrfsJo56CnV/nWnMEqfRtLjDcyBOIPxMtMIlY0ava3ujkI7snQFXpOH?=
 =?iso-8859-2?Q?7pLsekd8NCEWK+sI+ZS7FduIdF5xQacDol+9KnWwZDVNBMq+G+zmyFSkqd?=
 =?iso-8859-2?Q?Az6ShwmMv4P6QaRf9KTFCcbnl+HvvPKxhE1EY2NsMWX5WOSDVFuFdi2SCH?=
 =?iso-8859-2?Q?+I/PvKeQHQ5ZGspbJxQFJDuYc28ifTXALoQ3pUP5EGQh0XE1fvHb00AmIv?=
 =?iso-8859-2?Q?RR6VtmTX2pa42VfUHFy57FFdTg3RqPt1BHItaERWkpPOdQjXKOC9fvCOV1?=
 =?iso-8859-2?Q?xkxtacHDPoaKu09WuWKElxLMmNMauSAqknvnRo0y3PBM7ANoglJZjQSkY2?=
 =?iso-8859-2?Q?5QUECoEwdZGHIMcTL2pN5H2rBRvhk+TwYvq+YU4F8QAOxzZ8LUPTX9DrC+?=
 =?iso-8859-2?Q?KMq7LekqMJUCW8WZ9bWn6DltB8cI8C/FGzzGI6mzOrEYCy1rBHfVy539Gs?=
 =?iso-8859-2?Q?HAm3ikj7U/lsGacSmiYpiL9KXu54Sa7IoO/2qRpV6OvloikBAyxNpDdWML?=
 =?iso-8859-2?Q?XwSZDuMVD48vax1gnI6Yl5jc4r5QBcUH2dA0Kne7SJ8RLz0zdzzIw8OA2N?=
 =?iso-8859-2?Q?URheuWDp3DW3WmWYKrc/a0+uDf46RHmBp8r6ZNM2TvfMO3LkM4AZ4Uc1KW?=
 =?iso-8859-2?Q?X84q+Kp7OYLhQvrAbT6wt3rWh2T/gaCYhyNc8xiKoCjHsXNS340HSwypc8?=
 =?iso-8859-2?Q?4QRAznla1ILXsePMZ1LwQUzCHtRX/K9QXKxCNZWftU+ZiRqTxXrYyF1P68?=
 =?iso-8859-2?Q?Op9Q7OO4NN6ZCA2zaNj7gbJ33tRsm/17z6kLxTbrV6q8CzB6BLkr1HBeTX?=
 =?iso-8859-2?Q?VjdMk6VbCtJovCn1OgEDcHryhShrzcWCnMvwcU2iD213qmaqtmr+kXTzU9?=
 =?iso-8859-2?Q?xFwbkFfH0A1QZEoIDT4KV815s/mq72guDG1UFxZgG8c1Raf+4c/SVTEk4X?=
 =?iso-8859-2?Q?UKRgx3ePXFnZVwHv1blJWrtqCjk2ReJuAwtXYb6gDNVaKk?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 794a1140-54d4-41fc-e7fc-08deeeab2b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 02:26:46.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOl/wfAQ5V8ZzpIguFxMfazGx91Czbq6amM++5XyN4gPo5CaL7UNm32nAJd4vTavnOK+ddn9SN9zhfni7dmGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8708




Best Regards
Richard Zhu

> -----Original Message-----
> From: Michal Gorlas <michal.gorlas@9elements.com>
> Sent: Thursday, July 30, 2026 8:14 PM
> To: Manivannan Sadhasivam <mani@kernel.org>; Hongxing Zhu
> <hongxing.zhu@nxp.com>; Frank Li <frank.li@nxp.com>; Michal Gorlas
> <michal.gorlas@9elements.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Lorenzo Pieralisi
> <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>;=
 Rob
> Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linu=
x.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is suppor=
ted
>=20
> [You don't often get email from michal.gorlas@9elements.com. Learn why th=
is is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Wed Jul 29, 2026 at 7:01 PM CEST, Manivannan Sadhasivam wrote:
> > On Sun, Jul 19, 2026 at 02:47:54AM +0200, Michal Gorlas wrote:
> >> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> >> states for devicetree platforms"), ASPM states are force enabled on
> >> all devicetree platforms. This causes PCI devices on some iMX SoCs
> >> (for e.g. iMX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> >> though CLKREQ# is not supported (and consequently supports-clkreq is
> >> not set in pcie controller node of their DT), which causes the device
> >> to never wake up from L1.
> >>
> >> Hence, disable L1 capability in the LINKCAP register if
> >> supports-clkreq is not set in the DT explicitly.
> >>
> >> Note, the logic here is very similar to 613f3255a35a, only difference
> >> is that leaving L0s enabled does not cause issues (at least I never
> >> encountered them myself when testing on the device) as its not
> >> dependent on CLKREQ# being physically there.
> >> Since there is already a way of specifying its presence in the DT,
> >> the driver should be aware and disable L1.
> >>
> >> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states
> >> for devicetree platforms")
> >> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> >> b/drivers/pci/controller/dwc/pci-imx6.c
> >> index 98e1db751132..7471501fbf04 100644
> >> --- a/drivers/pci/controller/dwc/pci-imx6.c
> >> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> >> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pc=
ie
> *imx_pcie, bool assert)
> >>      }
> >>  }
> >>
> >> +static void imx_pcie_disable_l1(struct dw_pcie *pci) {
> >> +    u32 val;
> >> +    u8 offset;
> >> +
> >> +    offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +
> >> +    dw_pcie_dbi_ro_wr_en(pci);
> >> +
> >> +    val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> >> +    val &=3D ~PCI_EXP_LNKCAP_ASPM_L1;
> >> +    dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
> >> +
> >> +    dw_pcie_dbi_ro_wr_dis(pci);
> >> +}
> >> +
> >>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)  {
> >>      struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp); @@ -1442,6 +1458,=
9
> >> @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >>
> >>      imx_setup_phy_mpll(imx_pcie);
> >>
> >> +    if (!imx_pcie->supports_clkreq)
> >> +            imx_pcie_disable_l1(pci);
> >
> > Sashiko raised a valid issue here:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> > hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F20260719-l1-condition
> > al-imx-v1-1-
> a55a57915c68%409elements.com%2F%2327076171&data=3D05%7C02%7C
> >
> hongxing.zhu%40nxp.com%7Cd76ee1c9a654445357a808deee341bb5%7C686ea
> 1d3bc
> >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C639210104755924878%7CUnknown%
> 7CTWFpbG
> >
> Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk
> FO
> >
> IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DVV0FrH0p73aStM7N
> TFfSwS
> > C2zJywJ3qG3Hp9PcjLuq0%3D&reserved=3D0
> >
> > IMX_PCIE_FLAG_BROKEN_SUSPEND is only set for i.MX6Q, but none of its
> > DTs have 'supports-clkreq' property. So this patch will impact them
> > also and since they do not reinitialize the hardware fully in
> > resume(), ASPM settings will reset to hardware default.
>=20
> Right, for i.MX6Q, imx_pcie_disable_l1() could be called unconditionally =
in
> imx_pcie_resume_noirq() after the imx_check_flag(imx_pcie,
> IMX_PCIE_FLAG_BROKEN_SUSPEND) block, something like:
>=20
> @@ -1767,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev=
)
>                         return ret;
>                 imx_pcie_deassert_core_reset(imx_pcie);
>                 imx_pcie_assert_perst(imx_pcie, false);
> +               imx_pcie_disable_l1(imx_pcie->pci);
>=20
>                 /*
>                  * Using PCIE_TEST_PD seems to disable MSI and powers dow=
n the
>=20
> Though I do not have imx6q hw to test this, so it would be nice if NXP fo=
lks could
> give it a test.
With this change suggested by Sashiko.
Tested on i.MX6Q Sabresd board. The ASPM L1 capability in the LNKCAP of i.M=
X6Q
PCIe is disabled as expected.

Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Best,
> Michal
