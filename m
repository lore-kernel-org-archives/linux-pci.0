Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C646B5;
	Mon,  3 Aug 2026 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785725690; cv=fail; b=UnXhcigecY6sHU5wDRsmZWxYT/U6FrTryZxDL9WrMsN7PyZtO4FD3A207yT+3PqSzLWCAtsfNSzJ3X1XXl41eIrmVjOYhGHvB+8Tk3+LQLYRz5WhX8MX3fYON2S7bwC4RPDumxstpafokuXqbbHB6S9OBYBt7Tr7DAo1lYxUBtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785725690; c=relaxed/simple;
	bh=L+PYrdcNXIaVgQkh7aGA9Rok+rkn/uqvRlhCbmolIiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DiEYHQJSsFkRGEFalreFUFVjJejFoY2q+FoE2YVctnepZCW2vr7lFARNmBYWMUpQOhCnWFoCkgOWlV68CewV1qMABv6eu6hI+FSgyvMRvPwkkPmXKrDBOF/KyFI+vWaVb1ly8Ic8V0m3AtbX83qXylcFxRKIE3BDGX6sJYzw2/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hWeL3p8+; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hWeL3p8+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDCcgN3PjiMOCYuoIesgRVpbFPgQtzf/WI3b14zFwKhlHXGLoGH8KUJX1/Mpa2hnA+kgh8UcaR7CrMtUL2f//sMRyA9MkicqIFQqoblFsiF7kU2g7tL44KQ4oUEynxPdC+ecnpKJbtQiDeM3oX1CrSlhPC74AQ0HgtjroRlJo5urPE3R89Ib5EDD3cZlOG5y9Liq1BkuecKwO4BqtrLoifDhwkXXCbGeg8vT0ajrnV8Uzv9wKQHVko7KK0yFSKOes5r8hb8fNFhbuTFqmU82Yki9rToyYYIdPKNxnh7qcGXhX91nQewb1E/+WhN3PPusrp01WLoi5/qJwTDuH0Iv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciXyw7YzekjTIfAwQ0Bupr/xgs21WxSa1wfpPzmMo0c=;
 b=NG6UaOwADFzgkPq1Lg4Hk8+ah0pVs3hlLIryPrhoy3yOw+XhsDzCwPMmA8RIKQKEorFgPSPBPWePNpVae8OOpbjprvWEP004nqz61gq1yH2NpYufNqfNFsref7l6/Lxl567ZRXHdI2Wx88Xoq6Yk2FqKdMbV9GVaoyP5hsbqR9/ZtmmxxEi8Vx24h9nnRZb1uGQBsZ9RJw4bY61T6iTo/VYudU0TmKID2CTwBg/sbvx82s8UkRIT6iz2QfqqqBvzw4SMtqHaqPnzdujtMjnqgp7f55T1HfBVrvfMGvTwLonM9+/7tJPIIWGrE0SJlNxD7DES1cC2+NsCMMLjEpelqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciXyw7YzekjTIfAwQ0Bupr/xgs21WxSa1wfpPzmMo0c=;
 b=hWeL3p8+x+CrHhDsa/kdXK7kUL+niG+Jf120bVOxZuwwETwqCEmIkW25ZPpBa3xlQSZowm/8lA9QOFwpTJgils8jiy95T00eMR+onTqP9GXZjmrsggNYfjeaVi9ZC+If4rVeFZCALAzkvCuddYrAX6FfHWbHF3iiBoKj9mRrLtv3SDjDXvsR9Kc1dWDEwbtxt0MKGz8L9IEr2fbNMf0hZhdDhB5fzRZPRZAk8Udhjjb4KEtRm9M17JBHIBt0WU2Qq3kDlmsFl1LZvm6iW/mP3T+nq261aINhxF++LsM4baSb8EVCS6J8puvqradqxYnu3Pv+Zs4nEb2vzPdkc7VD5w==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DBBPR04MB7818.eurprd04.prod.outlook.com
 (2603:10a6:10:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 02:54:41 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 02:54:41 +0000
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
Subject: RE: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Topic: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Thread-Index: AQHdIJj9kXekoOZ9KkmAiMY17p4A7LaHyuoAgAPapYA=
Date: Mon, 3 Aug 2026 02:54:41 +0000
Message-ID:
 <GV2PR04MB1201947B1F1499D12C2532F3F8CD52@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260731030546.850457-1-hongxing.zhu@oss.nxp.com>
 <20260731160258.GA1571469@bhelgaas>
In-Reply-To: <20260731160258.GA1571469@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DBBPR04MB7818:EE_
x-ms-office365-filtering-correlation-id: 5eb6cfbd-0add-4106-9bbf-08def10a90ee
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|18002099003|22082099003|38070700021|3023799007|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 yISM8Dz13cTt4SoFKaLPcortBjo2IGIgG4pu/qn5e5V+sxilTrJ82GiaGmSPO0bKZc3Wrh5GU0finZDJ7cCzhjZin+Z+V9G0xpj1HpvuUKqZEbJshdLtUFUacreAtajmUItoTx3+9aNH6ljn6KMgTq5jVQ4MGaAtHv5qZ8oCwA6HqaQuK5pV+mod5bC0CtxC03fQJ8U4Qcdr3ZpxRsdmHF5R5t7kPL3OLNYc1tCY3f8aNXmt7IiklNk8Mqw/ie36IaOI6S09HtPEq10hUDo7sJaDU6rgxPOifZuQmgiHKk7lokQgPR+V+/DjYhzR/KkAJh3BrPmZb7FGlywYavqtUc/Kh4XqxHkHVi2s6zs1V9M4Jw0YyGwTvG+905ViY7T34rl7ColYjR8uf735BysyTZ5QkppIkoZiiKRa5Z6K6bT7KdKPvic9Uwb6aIFyovacWoOGzD4x652YFxyEUGJ28pWFCwrt7hwrUcSoMehgsXprFhAq3kAjEunFUEs7Bfd3ZCqthKXzdfadFta9Bqs8zgENpDG5HicYTXMb43g+zMZZbBFsUt+i9a/ffHv3T10o8V+tNq4BBYKUyQbLxz3lml0RtBS0MgkXtOj2/dTdMu8iSa1Ur+IwFbTMbd4dHB7P9EfNCQ/YgmQDZrk3WtqrgSDP9vT7J0ayCOvwUDUi7HSy+sin1UlyDTCtRcctnPH0l/hwehrvegtlfDfEcgoS22IS+086RsAEsYjhxo3OdAY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bn8zuzj9QUVt/+rYmDme+n1t+h9oPqWbFDwYxpgXBFfJv0xFqbAYgIL/SNZM?=
 =?us-ascii?Q?jPsa6r0rSvIWVlAK3hz48IuKKUuJVPaDhGBc2f98uZ1L0U2dBoPHsI/NnQcV?=
 =?us-ascii?Q?01NB2pojsLyfzAeXAn6DruhG+RMa7O6oInNFy0KU0qsqaai2fIwes0pXzo3E?=
 =?us-ascii?Q?NitElNWM9kzE+3DULXXD8gr+O0aiiXqOFGHY2b+VE5rQicdX3slxgTJjE7Oh?=
 =?us-ascii?Q?NRm6kPeFoAoPSF3uYAs8Z6Q5L7jBVPErQqlERlhCfxuwKd4j1Qa2fNZGdZq/?=
 =?us-ascii?Q?4LYeEHDggBRJyVd8Enp+pxXPPB8Dre33cJc6xwPygt8NOlgSXXgvqooNJs8i?=
 =?us-ascii?Q?5AYKtzUFEYsWg98zws48o6vKRiNCPTWLY/zmaE0uKJJhyhy+1UPdNv+JN7Mi?=
 =?us-ascii?Q?aJhhRsaxyP6sB07Q4ftUEAnVDlVA7CU+l4lrFWu0bgDLpGS/kRq6K89t0UWF?=
 =?us-ascii?Q?lzvHTpTTexlXEvYDvE1HKZM2WsWsrvr2UvP71ZTaaS7xczqBHJQBebFH22cv?=
 =?us-ascii?Q?KdOVxzHVvtwOO2p2f4xYqBARmERY52pcACGy5d6w+7c6TlZc/WO+wMyWBsaS?=
 =?us-ascii?Q?QsVMbvoIMadaaszJFw/A+6lOyjSV/4LwIYRhvNpMuKs+AD9oRnSKnWwYfcWm?=
 =?us-ascii?Q?OMbaNYvSMFRii18+26ngpzzwucLk4r0une3pjaQe02gTLkCXAVCA7eR7KsCm?=
 =?us-ascii?Q?C8yyvLbm+OiaDdNkTlrqVIYG/yRAU61A/hfQPbKL7YpwisTy8BLsT+Ogb0qh?=
 =?us-ascii?Q?AdkpAZn/eoNBrewZdrvAj0y4aXqTV9fSGKka1WM63DHmN8ulLhYaIM26be5Y?=
 =?us-ascii?Q?HB0/tv5DiguOiys+SaBolcFf665yLd7C5+9JKjHECgnDiiNSQMX8sUAH+nQ7?=
 =?us-ascii?Q?7GEf57gqF5/znO9HHXsC+LEbgz7pT0SocmB1xwyFzyOlVu/2StIJqlMspBbp?=
 =?us-ascii?Q?B2VIkMdZ1+ejR2KUSKf4O/7CTbV6SrnfZQi3P8ZhBEJ7XgH/c2Pyf8wc4xdW?=
 =?us-ascii?Q?rnBBA2HCSvuTrUSXBFo1D07HjZ5ECJwIB2vnEjkZQMnhUWbAR6Y4W6cDEs9A?=
 =?us-ascii?Q?AqaIIbY2k64vopC4QavhYxTXc6Y6z9y2UWPsJjZ3WAdTDXSf7nSLctmMAXsc?=
 =?us-ascii?Q?l0aqrm9/1BvM959PJylqHPHRiZ/1q3OkiAjnaA8GeMvQIwMYcSWwtsfJTVFp?=
 =?us-ascii?Q?wGtjAfCmfd7m5f9/vzKjPCk+2Xb7EtfLC3MXbmEftuIK0ZZBuEO4OyXqM8nQ?=
 =?us-ascii?Q?PbHIe07tttJCPniwy2fvv6NJ4mmxP+aE1sAlcLYsQa3URw6fNk83HicM11L9?=
 =?us-ascii?Q?lyX3muMKEJRn0wVy+Jn3uMDnWvD2Y7dp88j/9zhYhTpybe0wZYC/zTq3VwVg?=
 =?us-ascii?Q?wJSZ29WvzfhEs8rGuMxmIYzU+hbI6shpwMLJFzXlDRRiiJAShrfWAjJhVMGE?=
 =?us-ascii?Q?VEJEn5kpyDnnPVpmqUn6UNuJwaWMiVnzRGnLhEHD+hoItGk7P+1Cuy+6KXt4?=
 =?us-ascii?Q?/Sh9KI8yraaW5Rx+MT8jlHkPP8A9EcSsCX9bhUwhRODVIYtAttIqOGqgpFVB?=
 =?us-ascii?Q?kJgfUqGTN061fu5roerAwQ/CpAa3tVa8Vjik70NecZfOlT/lH53Lle4vSb+x?=
 =?us-ascii?Q?WEitNoctK9j+fOLjCA1EMHBp1ZWQahZqroX5n7jQm0BuOfo1diEJ6i2jYBnH?=
 =?us-ascii?Q?etCBr/6nZMN7M8KL2u1WPXxEyZAuHLn48ZajY8oWW79CAGirRIxWf13cDlAy?=
 =?us-ascii?Q?2w4Re1TwxA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb6cfbd-0add-4106-9bbf-08def10a90ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:54:41.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzV/1inzS7DvKavjXc7+8jt0P9I4SdqQu6JFiOW/C3gkwYoyYfclT3PQjHFMVw2lZ61XEeOMfArXkqFeA8GyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, August 1, 2026 12:03 AM
> To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: Re: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95
> Gen3 PCIe stability
>=20
> On Fri, Jul 31, 2026 at 11:05:46AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > the default MPLLB_BANDWIDTH value (120). This margin degradation
> > worsens across voltage and temperature (VT) variations and different
> > test matrices, potentially causing link stability issues.
> >
> > Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> > improvement in bandwidth margins across all VT conditions and test
> > scenarios.
> >
> > Implement PHY register write helper function and configure:
> > - MPLLB_BW_OVRD_IN =3D 140 (0x8c) for improved bandwidth margin
> > - MPLLB_BW_OVRD_EN to enable the override
> >
> > This ensures robust PCIe Gen3 performance across all operating
> > conditions.
>=20
> Thanks for including the previous and new MPLLB_BANDWIDTH values.
>=20
> I'm fine with the patch, but I think "bandwidth marginality" is awkward w=
ording
> because "marginality" doesn't seem to be commonly used in this context.  =
Maybe
> something like:
>=20
>   We observed poor bandwidth margins during ...  The margins worsened
>   across ...
Understood. I'm totally fine with these updates.
Thanks for your kind review.

Best Regards
Richard Zhu

