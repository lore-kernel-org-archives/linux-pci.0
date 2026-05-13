Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C162381B1F;
	Wed, 13 May 2026 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658070; cv=fail; b=eq/WCLpjGkRTA8SrvsxRropaQSg6SkZU7o1TPeAGy3UFMWPT/tXKQPVCrfapsEy+rQbFy+k7iba8WB6XmpD42T+3kJL9NJ3FrNEOVouDClot7HM5fWt2PeEmLqrwAfhPx1rYi/GnzIWGvXcmZbSrmPt9/vWgtJ1KKDPLX+PvRyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658070; c=relaxed/simple;
	bh=Jn+ImlXG5SG+/mUhLq9LGbkDezR+DZ5qsap8scn2sZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IajYpg24gjjfHVgQ8yFLiTxqecv9g85rmVZLoMUF8glITXim1J8FaF8DbTJliLZ6lIoQfQ6LLS0iro8WkBPHhKT3Y1m/tJRvEgVc7sMfZ0kRld4HY4v7645emUshQZsn/G+gB6McZER+zNl9TpAOJEyk3e0WOwVjRUvKwwBKzFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d0a/VbLn; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0a/VbLn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzR97DlqapMagHqljq22Z87cntNx4pgpdybNQCyTHL1vP7MM9ZPdVcpAbRH4xjEmseKru2A9aHI3Q1mETpYFOIWFvslfRa0B8+wBMAiGBZ/Cpn6sZ+OyQSR9q/AltoJn5UuvFKVMnwX2OceJiSSCEk4uQ2W82HxO2RSUk3ChNdNXTA5FEQPvV9gRfHfz0am7Ck6y7unin4itvJ870dtJR7vPJu+bb8l2tUXiOSVHhCT1LH3b6SabfUjYWjG+OTCAVuWNFKjx/xQucK4kQpULD5XE1ieJM1JaEYsghIZEwntAGkX64vP2QtKHBSM2Mg3arCBgO9/qP4F2/m2Z5MVAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYSV90c3jtZFkeXGxSsA0W+lKx20jPIgTPI2xn50mOM=;
 b=y+NFlE/E3Ofswf/Q3DHC5Y0yv+JLwBWCUNEhBGYIP+LtY+y4rm9aKxm0DzTdcG6i52GRlx04A8QiWr0jt0Y8Fw362C1++IozR5w6dYhxwhwKzSh3C8KaSickBTd/IvMjM1lgbtOwH3ONJm4AEbFQop5u6/v/biIdLlopGrz1P7k/g1SaomOf2k2oEd5HyDJM1sddeN5xZSLL2gdOJFslph847Mqs7vwH6WB/Jk4sUu1Yry+CBLL3W/Jmgoe/yW5sjRPy6ASgehJRhg7yfwy91GdN9O9chS+AGDVwmdF583/SDoe5ZYR1IomndZZ8EDZqJfBmSCbkEw0RYA1LrLUMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYSV90c3jtZFkeXGxSsA0W+lKx20jPIgTPI2xn50mOM=;
 b=d0a/VbLnCUMJwfUnyN6Uap1pwNk+UpCsbZpDYYQd67XLkjj4wnSxahsyWbL5SWthmpFqg+uKsUikQ6Fgt/uLz4gl0Tm/lIUoEUOPQI7JBlYgo6MJlEbUXIfUcSXPDQH4/aO0HawIm2oPiaguMJDQf+W7sGfq7zZvPVl6pMSKWWz+osErNd/o8fWfm5TSnlcYUtoTj3Zja3FwpIwR3QG/ZeGV+Epvjb9o8G1FV+EGMKepUup9v881zFx/8D0+iwA7FK/2JY1RWC9zwZlEMfxAAcsr27R022aZNAnozYNZ3wOIxDoyKqWOvG+icJEjobrUxCK6DTiWb6spjCmgA0jHWw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DB9PR04MB8188.eurprd04.prod.outlook.com
 (2603:10a6:10:25e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:41:04 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:41:03 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bough Chen <haibo.chen@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Topic: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
 recovery
Thread-Index: AQHc4oMVIgbvVMyynUOaCHErO4ihqLYLTTYAgABFQ9A=
Date: Wed, 13 May 2026 07:41:03 +0000
Message-ID:
 <GV2PR04MB120195F56EB13CA04B43014FC8C062@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
 <20260513025101.1498104-4-hongxing.zhu@nxp.com>
 <GV2PR04MB122726C1150FFA1D8B0125B3890062@GV2PR04MB12272.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB122726C1150FFA1D8B0125B3890062@GV2PR04MB12272.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DB9PR04MB8188:EE_
x-ms-office365-filtering-correlation-id: e4d89dbb-1448-4518-9307-08deb0c2fc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|921020|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 aVzK2ydZvedQva/80EAjIYubDUSDKEmVipLuxFP32rYnvsekr6DEx/Gde7iCDJLZcIF/0oObqA4WZHlvhRBDU5/AduFacxlN7QhPxzLdYlN8lxfAkalFxKZRp4PoFb/QKb1Dv6n4GjIh0zuYPe0qJFlYoTMZvEijb+kdmvVcC0yeCXuGE8pMxNHZ9ULStDmYLB4DV6fNq4Ro1esyLMOnmjyjNW5KLjZdKI/ecvMgczX8c2OI/2BtRuY+k1HzRMU/tcBgwMWh3U/UPcaliKEcorVreYbRpyGvPZ4blbw89/E3ef+rUOpsGzYJxsRUkE2iJFGjy4TAtqi9/4fna47EnNuh+Ax8pFTuVy0nsNroWyVqr1LB2KhjQfHycT5QoEtJbpZwtPSnUvyf7AksJqI1I0SfgetdDunLCPXTefRVVRiKPTW0On/PUFrEKRmr7IdkASotlWGeW49cL4l9PM/pOOV2X1Z4mu2vIgdijVES6rZ/cwOK7oFas9RPswXtPjn+Qecvrjcg7lmugX8UkB+nFlNnwNWLigmlbg8z68Wg1jYZABlQjNiax+MPfSZgTxS98541K95QO35A3U2YSS8x66dYl54ODQhBXrGJEz1vDK6S5lHJ1OrC0TVAVp8GYwztMuiehiWqR2JfEmGwQ0+9XhPr0GzW1UiGFNlULrnYwCCTMeYVzLC42grr2mfHsUWCu0KKvbw6BqxwUEJn6BUk3pH13/EXKyfWrbfV5IG3NXOboowBECm1fRqjNBfuIMLguie0U7c2QoCELUKlwhlwfA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?N2RPNmVlUGIya3lvcG9xdlZhNW1vNTNBM2JMa2UwbkZLU0o0VFBJTDRx?=
 =?iso-2022-jp?B?bU56QUxtUVJ4cjg0cWVYTXV5enFuOGhvS3BWWVZBWHRYMjJFQ1BoYlpK?=
 =?iso-2022-jp?B?ZFp3UHFaa3RxMlFpMVJvaHR4bkFVdnBhNTRaQnRja3VhdEZ1djJtSmJQ?=
 =?iso-2022-jp?B?RUpqODhYbHBSK3FaZ2ZPNzNtaUh6NnRDLysrMUFIZ2x4RzAzeU1oQUlR?=
 =?iso-2022-jp?B?dlBuSlh2ZUhzKzNPMnZ5WTI2bVgrNVo2eStFb1E3MXZXNEZPRG1GaWhy?=
 =?iso-2022-jp?B?TkpFWEJNMnhWVHhEaVBXM21kdlo5NlRaZ1ZwQ0kwL1o5V3oyQlljNkxs?=
 =?iso-2022-jp?B?Qkp2QnVWcHhTZS9lKzlRazYwSWV3Q0IwSEZWLzJBd2ExT2ZTZG1mbkV0?=
 =?iso-2022-jp?B?NHEwNHltZ1N0bkZnY2FsSDNLK0ZWQUtISS80WDBPQ3V5b2NmY1BIUXhv?=
 =?iso-2022-jp?B?QWJsZ0V3S1Y4Qm5kb3oyOVZNQ2NQa3RIcE4xSlFGTWRlWmlaRW1sYmZ1?=
 =?iso-2022-jp?B?cFlsVU85cWg1ZGhVZlFQMTV2c1JveGYxdFVHRUxLRUpCS204eHRES1Zi?=
 =?iso-2022-jp?B?YTYvVWZGUHY0V0V1L0N2SGMwejdibUl0aUVhSWVGWGF3aVdXQzR5d3Q1?=
 =?iso-2022-jp?B?VEliaFkvZFNpUFgzZ1J4THU4Z1lVbFQ5U0VzZHdFR3JBUk05NmtWVE1U?=
 =?iso-2022-jp?B?NXk2bWhBY3FjNUlpTmdqNTU1S1dEWlVKWk45U1d2cWRzUXBnRWRCMHky?=
 =?iso-2022-jp?B?aTZ5WE51V2pLcmNVbjRRS1hsSEwyZVo0NVB6dXRYS09EV2N1Nit4aVRr?=
 =?iso-2022-jp?B?RDlWZzVqZ05BcUQrYUpJOXVTRURzcHlTenNhcGQ3ZlFZcW1SVkVacVRD?=
 =?iso-2022-jp?B?TnVGd05pQlRyNnpvRXMvWU9vTnU1aFpuYjljM25nZDFxNWs2bFJJVlR5?=
 =?iso-2022-jp?B?SnpRbERmR3hUTlVDdkJQRlJhNUJlY21uOXNTd0RzRkZ6c0g1cC9uS2dR?=
 =?iso-2022-jp?B?ZVBTQjNCUUpkSzhjaHMzL2tHbS85d1hSZU45Q1N4NHlWMk54MnRNRTJT?=
 =?iso-2022-jp?B?bVBycU85c0Z5Mmtkc1lFUmVYaHU0b2RUV0FEaHZhdFAra29LK0pHUGlO?=
 =?iso-2022-jp?B?dWlwbzhTc2lvcEZXc1FUSm9vQ0pYZ21Xd24reEhHQXVmYUpFT3dtbWNN?=
 =?iso-2022-jp?B?TlJGRGNjZjYxdFQ4ZU4rczRxK2ZTVUQxUTVVNGw3YjAxVWtMV1RPRlRS?=
 =?iso-2022-jp?B?QWFHNlc0bGFnaTd4eUNoSjFXbDFQZk5OTWphTXlEakNGaGx5V3JVeW1k?=
 =?iso-2022-jp?B?OEJ2R3FnQXJvRFVwNitUem9YSnMrUm1TR0hzZDA5K3I0K3FncDJ2eElQ?=
 =?iso-2022-jp?B?NnpNSEo1aStKdzN4bWxlV1JaSXpzS01OKy8rQ3k4bEpzaGlKSi9Oblcy?=
 =?iso-2022-jp?B?NVdkclgyeGxvZ3ZGMHNCdWdIUGpSN1ZyK3BGOG5IckN3c3lmbENtZ0pq?=
 =?iso-2022-jp?B?MytZUnZadTBGM0oxNW92RG9zVkpMcWxvYllyZjc0bERlTldjOEhLd0Ru?=
 =?iso-2022-jp?B?Vy9jajlYd0ZGVUJTK1h0VmQyRUlPcTlVa0t3NUdMb3VVRG5leE9jcE9y?=
 =?iso-2022-jp?B?ejNRTnZmMWpaZnRKM3Iwb1NQQ3hEY2xNbVdsaEhEVGQ4aHc0Zis1bHd1?=
 =?iso-2022-jp?B?TGV2Y3ZSWTJlV2xaY2YwTXBZcVZtTGxOZ3NGM1lJSjIzMWY4Z2xGMitI?=
 =?iso-2022-jp?B?Z3ZKWFJyZlhhcFFQbTNHSXFRRWU4QTRmL1dVZDF5bnVVcjdQY0s1R0pw?=
 =?iso-2022-jp?B?cjRENHd2MlhKWTFpemVYTmRJQndRRStYS2pDNk5zc3dxUHF0YktIbjNR?=
 =?iso-2022-jp?B?VFRtRTZWK1JqSUFLa2JkNFRiVG05WnZTZndmR1FQR09RNGdIbUUzQUdq?=
 =?iso-2022-jp?B?bEV1bm9JM2ZHa1pkazZHcXdsRll6amNpcS94dnJXVGF1Um1RN2xvQWZu?=
 =?iso-2022-jp?B?Z0N0RUdZQ0xtZjN5djB5YWhpSit2WnFEUGNPZnJWM1huenU1Ym5OVTda?=
 =?iso-2022-jp?B?YlFuMThZby84cnFGc2NIMEh2WHVtM0hEM05iTE9FL0ZMTngxOFF2dXlN?=
 =?iso-2022-jp?B?c2c1NU13dkl1S04yTE5yNUx3MVhqWWI1RVNwQm1KVkFFWmVyRzhFWjU1?=
 =?iso-2022-jp?B?Qm9veTlNN1Jya2NNd0N5VnhLMjdseW1EeFh6VWtQKyt4WTl4VjRxWTJk?=
 =?iso-2022-jp?B?bk8rbmNDaUxFTSszNS9DUTZlcS9PRWRVTzV5bkF3T1UyZjF2eldIbVJT?=
 =?iso-2022-jp?B?OERoZlpvek15VW5nMDgvTHJHU3dyazU4OHJkQW1tZWNiRTlWS1VzTHFv?=
 =?iso-2022-jp?B?UDJlWjdzdkpuTldlK2lubUxxbEJHVCsxcGtGeWo2dWs2MDNOZS9aanpi?=
 =?iso-2022-jp?B?Q2M2WmJMTHBpakpCOGhpNmVMNG9RU0VoSjBaQ3FNMnFoWjNqdGVVbXdP?=
 =?iso-2022-jp?B?aXhUMTZr?=
Content-Type: text/plain; charset="iso-2022-jp"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d89dbb-1448-4518-9307-08deb0c2fc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 07:41:03.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbjmZwTYfXUSu/70B0joov441WtV2eTK3Y6LLEU4Da8eww3d7+VPaN+CWe7aSTrReSCRjmXbz/5Tc/iNdPAH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188


> -----Original Message-----
> From: Bough Chen <haibo.chen@nxp.com>
> Sent: Wednesday, May 13, 2026 11:32 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; bhelgaas@google.com; Frank Li
> <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> kwilczynski@kernel.org; mani@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org;
> Hongxing Zhu <hongxing.zhu@nxp.com>
> Subject: RE: [PATCH v4 3/3] PCI: imx6: Add root port reset to support lin=
k
> recovery
>=20
> > -----Original Message-----
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > Sent: 2026=1B$BG/=1B(B5=1B$B7n=1B(B13=1B$BF|=1B(B 10:51
> > To: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > bhelgaas@google.com; Frank Li <frank.li@nxp.com>;
> > l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: [PATCH v4 3/3] PCI: imx6: Add root port reset to support link
> > recovery
> >
> > The PCIe link can go down due to various unexpected circumstances. Add
> > root port reset support to enable link recovery for the i.MX PCIe
> > controller when the optional "intr" interrupt is present.
> >
> > Reset root port to uninitialize, initialize the PCIe controller, and
> > restart the PCIe link at end when a link down event happens.
> >
> > On i.MX95 platforms, link events and PME share the same interrupt line.
> > The link event interrupt cannot use a threaded-only IRQ handler
> > because the PME driver uses request_irq() with only the IRQF_SHARED
> > flag set, which requires a primary handler.
> >
> > To handle this shared interrupt scenario, register a primary interrupt
> > handler with IRQF_SHARED for link events and manipulate the link event
> > enable bits to ensure the shared interrupt source triggers only one han=
dler at a
> time.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 123
> > ++++++++++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 1034ac5c5f5c..79c92c77b85b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/pm_runtime.h>
> >
> >  #include "../../pci.h"
> > +#include "../pci-host-common.h"
> >  #include "pcie-designware.h"
> >
> >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > @@ -78,6 +79,10 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_LINK_INT_CTRL_STS			0x1040
> > +#define IMX95_LINK_DOWN_INT_STS			BIT(11)
> > +#define IMX95_LINK_DOWN_INT_EN			BIT(10)
> > +
> >  #define IMX95_PCIE_RST_CTRL			0x3010
> >  #define IMX95_PCIE_COLD_RST			BIT(0)
> >
> > @@ -125,6 +130,8 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_MAX_INSTANCES	2
> >
> >  struct imx_pcie;
> > +static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
> > +				    struct pci_dev *pdev);
> >
> >  struct imx_pcie_drvdata {
> >  	enum imx_pcie_variants variant;
> > @@ -158,6 +165,7 @@ struct imx_pcie {
> >  	bool			supports_clkreq;
> >  	bool			enable_ext_refclk;
> >  	struct regmap		*iomuxc_gpr;
> > +	u32			lnk_intr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> >  	struct reset_control	*pciephy_reset;
> > @@ -1301,6 +1309,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> > *pp)
> >
> >  	imx_setup_phy_mpll(imx_pcie);
> >
> > +	/*
> > +	 * Callback invoked by PCI core when link down is detected and
> > +	 * recovery is needed.
> > +	 */
> > +	if (pp->bridge)
> > +		pp->bridge->reset_root_port =3D imx_pcie_reset_root_port;
> > +
> >  	return 0;
> >
> >  err_phy_off:
> > @@ -1568,6 +1583,9 @@ static int imx_pcie_suspend_noirq(struct device
> > *dev)
> >  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
> >  		return 0;
> >
> > +	if (imx_pcie->lnk_intr)
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr,
> > IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
> >  	imx_pcie_msi_save_restore(imx_pcie, true);
> >  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> >  		imx_pcie_lut_save(imx_pcie);
> > @@ -1618,6 +1636,9 @@ static int imx_pcie_resume_noirq(struct device *d=
ev)
> >  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> >  		imx_pcie_lut_restore(imx_pcie);
> >  	imx_pcie_msi_save_restore(imx_pcie, false);
> > +	if (imx_pcie->lnk_intr)
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				IMX95_LINK_DOWN_INT_EN);
> >
> >  	return 0;
> >  }
> > @@ -1627,6 +1648,84 @@ static const struct dev_pm_ops imx_pcie_pm_ops
> > =3D {
> >  				  imx_pcie_resume_noirq)
> >  };
> >
> > +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv) {
> > +	struct imx_pcie *imx_pcie =3D priv;
> > +	struct dw_pcie *pci =3D imx_pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	u32 val;
> > +
> > +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> > +	if (val & IMX95_LINK_DOWN_INT_STS) {
> > +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr,
> > IMX95_LINK_INT_CTRL_STS,
> > +				  IMX95_LINK_DOWN_INT_EN);
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr,
> IMX95_LINK_INT_CTRL_STS,
> > +				IMX95_LINK_DOWN_INT_STS);
>=20
> Hi Richard
>=20
> Better to add comment here to point out that write the
> IMX95_LINK_DOWN_INT_STS means clear this bit, or mention this bit is W1C.
Okay, would add the comment later. Thanks.

Best Regards
Richard Zhu
>=20
> Regards
> Haibo Chen

