Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470F44BCB1;
	Wed, 21 Jan 2026 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977873; cv=fail; b=ps3RYxwyEdS4FqEI43JgHuY536cZQOD8ULq4AHDen98SaUnP7+g2IYSN6qbwkZnjLIpre4zHfJjksPHmRDbyLNbHh4BxtP1qIi9fKVHNrAb/q/6YCARp3SSC/5zHXBPFUxBeDGudD2wGFemD+rIm4c83NjVfVKIKUXOuonYvOr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977873; c=relaxed/simple;
	bh=L6HFee2QPzU3AesoLVGLKR9U9W94NxaNNmJ8EP76DKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUCQQx/V0jTVY+6pWmsU1FULDlf/z3z23a+q+xHZGLCqUXStY8SjrB0CnC31p/yYo9u0ekYgtJY5P8tQtn0y7Vhx8eo6T5N7bIvCLdiOJiD/KwpfTwbuCwT0iMMHiD3H5u72pMtDUplUK71/8ck68eXEy5+sEW0Q6IL4Er6hJZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZS0vQt3S; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZS0vQt3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpMdN1O5xw9MOqfhTw97sI7+upAn9YE+RXz27wjWomJHyEGRaBLntDz9jxfTdCx7eQ+h7QnvTo9oR9Nd9p2k+myo4u+7WnweNHABfeyHEN/SviAVpc9pp2glzKFe4k2xyh6+H8SMK1SpkdvJ3yHHEDwmI0oM9HOEnuWbFVYeFlb/Re84g9C1eCrJi7A3JjLv16l9VFqoX0pEWKCq7J3Xn0eA1uLhaVW8MYVvpyZRVRt1O6vLXr1YF8/iAzdAOuhJpbHgLTTI06BI1IMgVOrR4I4LJ7wZpUqvlpwjMgiBuy9swTd97PkXLImyOYBjdlPeTQ9OtW5ybTxeuM+7Rke9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y42YAY9lzRIjfjlVmYI4+Aw52bdqoLdv78QjmWINcA4=;
 b=kN4HSWm5iOiRmeqJSzZKkMebzuCmpqorY5J0oPhK1TRuQ30KDJyi0mxOK3ggwoBpuAMczrt6XzuygPeH83m9mrQAWvcvnOAew6+JB3Zqhum+h2/heavw0VUdhdPpP7pBptVVI8YRbTwER+VLP8PsaGflhZk1vh6QZOAxMgiHDj4cdW5UVB8cHWSbxFpzQdcfIk0iID/qm5QhWNlO620Sz5AZ5nf4oNeyciFfJZnx0XTw0qLRlq9ux+mjw/4t3dQPVBaunI910kJO1RtrQXJw2eWf33H79acTyZg9UMARUogDdpA0L1dhaX8e7XsA2hjEZge2Akg4xY/re/qrQJoezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y42YAY9lzRIjfjlVmYI4+Aw52bdqoLdv78QjmWINcA4=;
 b=ZS0vQt3SKV6oiUP20W7c6ji4YtYoKM8NOxrS6pyQIt4/EYHpoDmj11x98uzLVkf56eF8XXly1Jb4z5+t29jEwAS7vYJIpTS+aSz7BLASOAG8MZ9sFA8BeuZWwku6hEnLuyK7grs2cpX5ZUAblcFhhtcY9SpJaG1yT3IVotpiz5kGzfDfAHSUFyHiDvE/doHfLEqE8a8ZlRgQ81AzAZSm1xaAfu4P9p0lkf742t0RYq+lw9ceH+vSPQf+GRLGcS3iVWCYD4Zwf1TRbSGZQryucSCiGX+M0qoLSr4Dz8wp8xSuINWyyP/kbmHD/h02BRSVa6UL5dbNbSGn8GOEBkmANQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI0PR04MB11723.eurprd04.prod.outlook.com
 (2603:10a6:800:2e6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 06:44:28 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:44:28 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
 PERST property to Root Port node
Thread-Topic: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
 PERST property to Root Port node
Thread-Index: AQHciSrsk7KYSAvHPkabL81JZV52QrVZrbSAgACrGHCAAO4vgIAA6NEA
Date: Wed, 21 Jan 2026 06:44:28 +0000
Message-ID:
 <VI0PR04MB121141E55886F33C8253447579296A@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-4-sherry.sun@nxp.com>
 <aW5aodaPdjYwAE1V@lizhi-Precision-Tower-5810>
 <VI0PR04MB1211450544DD02D44B4B901959289A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <aW+x9eA1I/nGdAL9@lizhi-Precision-Tower-5810>
In-Reply-To: <aW+x9eA1I/nGdAL9@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|VI0PR04MB11723:EE_
x-ms-office365-filtering-correlation-id: 5bdff40f-d567-4e0e-fe5d-08de58b88675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jEhoMnXd/dwzhZIXs0wJSsvCqChi9+hpQczwrAbCi1wPENRJtwofXt/4430a?=
 =?us-ascii?Q?5cogfWpD/sVNPtJQcBxv61UUOfJwD1xG3LhRhkSYDrwUEEFAWelX9djtG/yy?=
 =?us-ascii?Q?LdJmXCLc1F/A5hth8585Hu/el5Yl9BS3/QVx8ANbdgAfqI2SnasdxuXCxATH?=
 =?us-ascii?Q?Jtf04qbuCi9/VTJdypNFE6udgV6483Fg6yMaFKp0a2zzFJCbfW7Z9Z1nuUpP?=
 =?us-ascii?Q?1lCx8tqkw6ePX/CcBV9XGTAHIu6HEjz1rdi0bYjY2M9Dy8Qc5cZbleS2+Odp?=
 =?us-ascii?Q?FDZgtQa9LJzkxm8nC3dWPPKKDOwkHOq9dGo4QObhxsU66l5nL4WUXZjKExs4?=
 =?us-ascii?Q?eEdJXjVQJo2uXoqddcbRoyWsi8h5TpMDrFiDlFHusMadbTVSE6j+BwOMKQZJ?=
 =?us-ascii?Q?/Yn0GtWj1uaT66UN79rqTlfFniia6/tpE/4cKpIqBhfa9Yn6sK/wMz6qSoS6?=
 =?us-ascii?Q?XmaxVzROnyk0izC2MaepRUKBD+P0kuzDYVTWJU6CiAxo34p/9SISpZ6UDRJC?=
 =?us-ascii?Q?mo/cVRL9bm1IoF+d9edmJk7X5v4GFiuJofyxHuTknuZ+fY8+Ies8d6NOMQRg?=
 =?us-ascii?Q?Et21Up+QRfc1DNSD69UfMTSq9C0WnvbOGsIIPl5gDhtWHjzEvVTBaTP/jjlU?=
 =?us-ascii?Q?kSEreG8n60OwsA8woWpCPnz11WK04qxF46vdgLw11NOLtW+pzhr4QP+CQhgw?=
 =?us-ascii?Q?fGDGtbNbfARi6YnwvTEQloJPadxl9PnrrhrjlHKfLA4No6HG1zQ8kM9qlEeA?=
 =?us-ascii?Q?1OR4MVtdVBv/vI8Xy/O0FLyOTGPwhMS90p0yPY0KOlWKai+UUUSWfw78U3D9?=
 =?us-ascii?Q?mdGiC76dEWskuPOvNUpXTBYzPyrJWL43rjvSbN10zLypl0b9kzAuAhYNf5dM?=
 =?us-ascii?Q?TYZ2e19ym6bH+Ola9/DG96CxAXs/90Kt4KhPl2r6qeY7+bap0f/U7CLAutJb?=
 =?us-ascii?Q?7vxluz8DOrfJfxjBJyRW8q7Mc/2pbZYwfK8I2l3rL6C+U5iLt29e8lH6GF7z?=
 =?us-ascii?Q?5lBw8djF0k07WfCbwmVLo/mucoDO7Y0dfretKjf7PorseOAjLB/zF9Yo7do1?=
 =?us-ascii?Q?M2bs7tTrEBfCvFzG2gpZsbfdMRFkR5suioZvEjXXqx/NMv/4MFtzF6kJgxxq?=
 =?us-ascii?Q?mYfuP/kz+ZDMSJeJlJy39/iLtp0K/HiKRVBZg5JiM4/1OOzwnboZp1Q0DGZf?=
 =?us-ascii?Q?5a8KNAtXgjrcRQuEoc3V2zOkZ7GJrxsLDNb4cML2Xb/nCcmtfFTFGrfOH2Sw?=
 =?us-ascii?Q?xUrz35eo+APsOolVUQUJPzQ1BpGg7AiKjM9WTuAfIW0SGthMHik9PDRwgqNH?=
 =?us-ascii?Q?PNMJ3pYutH58b7GkdLoqgNbazHf7cedNjXnrYkxcGdtUbZkRgY0fVNluslH1?=
 =?us-ascii?Q?4fwjjKXpyO6oyZuydfNfjydNqkDGLQk8/0mGYFkFelCDWvGpM84tRUh9fAgy?=
 =?us-ascii?Q?wGPVl+NNuSAjF/ioQtf3BCePjC/GtFgzjLqb6WH96AtxCO9vRXpWZQvixflw?=
 =?us-ascii?Q?kc+4ZZASfJBrr1bUPJx3V527UCCmpYEEcBEx+rzIFK6W4nD56Rp51wgu4LZ/?=
 =?us-ascii?Q?XfufkOn9qh5XwC7ZVB3uDufb2qPV4qy12USNldqJe66W5l959cDN6rQdmMYG?=
 =?us-ascii?Q?CduyM+4dcEdXSMYPkUql30o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0RS4IUw0lm7BsKSSZBHNKKTkiJWu7Rrv2M2S8V3oAZCA+M6GM96RaqdmbghM?=
 =?us-ascii?Q?ntI7wQmr0Q7h0Rc/HxZ0EXrDjza9BNOMtWpVdp9DQ7h71umzGvhfCk5cJuGM?=
 =?us-ascii?Q?GUCOQqYNsQmOs7j4tVKa0a/5KB62vA15d0jH6myWK31chIL85qi8yCjWLGEf?=
 =?us-ascii?Q?cbaMTODpb+ZVJm0qgfm88GLq2bwnInMvIoj4b3L18d6JyMAWkRXog2Ya76Fh?=
 =?us-ascii?Q?iyj0En3yCFVtXLtgUjWehuX+jppSFBOmpf0fFRhYD5don5Up6GNrLGejTM/O?=
 =?us-ascii?Q?9MvEKoWHwLgFQ9iesNJaAkB7QfRGGlGaS9Q202Y1cIYsFdoQonMcmgWKzZr7?=
 =?us-ascii?Q?wtKg48KcEoNZmDArTDIcP+/4x+QWCvunz3vwou89pf5ODhsKTHaC0/IFqQJD?=
 =?us-ascii?Q?dDfi/t0X3+WiTWyOWS4ivKY/6qfY7dDp3pDDQA/I0MftgMUplY6te20SWZjc?=
 =?us-ascii?Q?IZ8WPyZxKGmI+ceVMLrybBDwJCZQnOkOMx5H+hItfLfXTKlWxV5zZqdoySt7?=
 =?us-ascii?Q?O/u9GontNRaruWVstn4No7hRD58yF38JDdEc6Gg8qRpDqeFw8UuhD5mIv0fa?=
 =?us-ascii?Q?5XFqpc92TJT137QwRhsdt0WCYUOFB/nZhVj1h3JHlE6wws9PM7a//xOn0LWz?=
 =?us-ascii?Q?MZQwqfmzNinf+uK9LBJq85xAP4lHmMKM5dIUVTD6O3YSPoyvl1l6vOYdg9pz?=
 =?us-ascii?Q?AYKLurumri253+h5KGW6GMLIMpFqh9yp/bTS+GgYBWd3q08keETPvaHKLd++?=
 =?us-ascii?Q?9kjEqXG1uToWwMuuRRivaee6gVPWPLDBrW8TIxX5YjPqpJvv3QQfoApB0X7E?=
 =?us-ascii?Q?sjEfwobofXtIQ1P+ji/kcYL4ALoC1Bx9xbsji+9QGz2ZBlXTfd2pZP2gP/yw?=
 =?us-ascii?Q?6ga2TO5l6d/wwjIm5RVCE5ilwlMmb722XYhkePhkGHaysQOApyotSIUALfEO?=
 =?us-ascii?Q?eakUtoNLDSWFDIIXUv5a3MvsQzcgiHzm26xfJLiHmKH3/qp4KSsaUuXDNP3V?=
 =?us-ascii?Q?kqWus6ZLcDFScCWEPCqP69bNpqNScVWyH/R7Fm/3eukdopzByOOOW8EyGZuS?=
 =?us-ascii?Q?2it3/EKa4cvL8/luC0rypHW5nMoGZO8XqCiwczg/NgRfPW7ybz4cXsPbuThM?=
 =?us-ascii?Q?xWk2q0+cF+K+9m2uUiBdIRWycwhHW/PPwSDXwHbqKZ/CsLIKd6iJXp6vJXpV?=
 =?us-ascii?Q?HFfiuZS6pzyoyYps0jjDAv6NTK6m2Z4Z3fA3KxHTHnHD/7r7gIyBAldl1V9X?=
 =?us-ascii?Q?BiZjkZkDFkOjT8l6cWqzvij7wfWlXFsdd5MxvXwsSjXkdp34ESLxc9nkenGV?=
 =?us-ascii?Q?4icls/Hv89fFlJXJcrmUQKTaiDWuv6OZNy+d+0ER2C2tXbFt/Pc7K/TprYF7?=
 =?us-ascii?Q?6fTdgWmdZkT6pNt8ypFwmRIGGPqaK+yEPpKpvR/sBrRIh4Jdp95pGbRcxymS?=
 =?us-ascii?Q?FbR4Yz5OSAFeIEdo4/Gu1dYaWX8oGg/ppHYAojymfg2Vs51JH17KnW/EmtCO?=
 =?us-ascii?Q?XTSTg+DMKRRU9EPZJVSJ2M/NPKBmXFmzezXxA6MW8IQ2M5JOBCI2rtsOqTzo?=
 =?us-ascii?Q?ppTuSfWO/l9AKmsdhW07BlNCPco6IrUycCfKCPLEQnm+8VsWs00agjJsWYDJ?=
 =?us-ascii?Q?ZOVCAGnYpNjfrQ9kOIg0DyyWohfbLkEfhWU0r+VT6+5ZX4HN3r0DO7P/rBeW?=
 =?us-ascii?Q?A63aeVOJidNNHkOd1+P2MK+YKVZqLtkFgSGF8NMMagUqerTm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdff40f-d567-4e0e-fe5d-08de58b88675
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:44:28.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AY2e0LYJ2O+4RxryuSQ+yzXRCFUU5GrSerjrVXRHYE9bRUDeBnUjSCD0znF2tFLAfzlkQSG2poJq8xNWANRYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11723



> Subject: Re: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
> PERST property to Root Port node
>=20
> On Tue, Jan 20, 2026 at 02:44:34AM +0000, Sherry Sun wrote:
> >
> > > Subject: Re: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and
> > > move PERST property to Root Port node
> > >
> > > On Mon, Jan 19, 2026 at 06:02:28PM +0800, Sherry Sun wrote:
> > > > Since describing the PCIe PERST# property under Host Bridge node
> > > > is now deprecated, it is recommended to add it to the Root Port
> > > > node, so creating the Root Port node and move the reset-gpios prope=
rty.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++++-
> > > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++++-
> > > >  3 files changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > index ba29720e3f72..c64c8cbd0038 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > @@ -754,11 +754,14 @@ lvds0_out: endpoint {  &pcie {
> > > >  	pinctrl-names =3D "default";
> > > >  	pinctrl-0 =3D <&pinctrl_pcie>;
> > > > -	reset-gpio =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> > >
> > > Generally, don't remove old property to keep back comaptiblity. You
> > > can add comments here if you want.
> >
> > Hi Frank,
> > Actually not remove, just move the property from host bridge node to
> > the Root Port node, if keep both reset-gpios property in dts, not sure
> > if it may confuse users because it's unclear which one is the valid con=
figuration.
>=20
> You can add comments here. Just in case this dts use by old kernel. At le=
ast keep
> some kernel release, then remove it later.
>=20
> Remove it at least need wait for pci part driver merged.

Hi Frank,
Ok, understand, will keep the old property for these dts files in V2.

Best Regards
Sherry

>=20
> Frank
> >
> > Best Regards
> > Sherry
> > >
> > > Frank
> > >
> > > >  	vpcie-supply =3D <&reg_pcie>;
> > > >  	status =3D "okay";
> > > >  };
> > > >
> > > > +&pcie_port0 {
> > > > +	reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>; };
> > > > +
> > > >  &pwm1 {
> > > >  	pinctrl-names =3D "default";
> > > >  	pinctrl-0 =3D <&pinctrl_pwm1>;
> > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > index 9793feee6394..c03deb2cdfab 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > > @@ -287,6 +287,17 @@ pcie: pcie@1ffc000 {
> > > >  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > > >  			clock-names =3D "pcie", "pcie_bus", "pcie_phy";
> > > >  			status =3D "disabled";
> > > > +
> > > > +			pcie_port0: pcie@0 {
> > > > +				compatible =3D "pciclass,0604";
> > > > +				device_type =3D "pci";
> > > > +				reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > > > +				bus-range =3D <0x01 0xff>;
> > > > +
> > > > +				#address-cells =3D <3>;
> > > > +				#size-cells =3D <2>;
> > > > +				ranges;
> > > > +			};
> > > >  		};
> > > >
> > > >  		aips1: bus@2000000 { /* AIPS1 */ diff --git
> > > > a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > index c5b220aeaefd..c35c24623d36 100644
> > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > > @@ -45,10 +45,13 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ
> > > 	0x000b1
> > > >  };
> > > >
> > > >  &pcie {
> > > > -	reset-gpio =3D <&max7310_c 5 GPIO_ACTIVE_LOW>;
> > > >  	status =3D "okay";
> > > >  };
> > > >
> > > > +&pcie_port0 {
> > > > +	reset-gpios =3D <&max7310_c 5 GPIO_ACTIVE_LOW>; };
> > > > +
> > > >  &sata {
> > > >  	status =3D "okay";
> > > >  };
> > > > --
> > > > 2.37.1
> > > >
