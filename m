Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF32D839C;
	Fri,  6 Mar 2026 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766554; cv=fail; b=p2rbVz2rNtI4Ds+VK8IPwlJy4Zrt5Ts7wcHdpFU01vV7ov7pWhCPdiISJ4SsIF8Qmb0rOqowd6ybLhqlxJG54EdA7f+UCwKaxsNKPAGibpsJJYQKpn4w90DoIeSnFDkat+LzsrSla3U5QwfDot9X9NOU2SgivTueT+rvyYWmHBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766554; c=relaxed/simple;
	bh=U+yOaR7fQS5ndpJkvMaWSuQxjwFnhFEc8KG4YubeOD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6IpMA/Ra04IEMBBE+O7zC2H0Iifp/1ZLg52zI10cptqQe54SFB42elLJ7HdLq2HCkKn+CJb+2kD9dX41EOZRjEzPX0F4ZpFKk7drnbBuH+lukRuJhAeF1cySk/vRd215pfdL46zoeSECssJ/R2F4DelPKbU18Ju/2r552UKNlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n0kPtLbC; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0kPtLbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0kU64UXrECZ7Wf1JdYpYRi/pUcFkGJjUtxXhrJ8a8TU+rXhTDaXIooPI1Fp4nHh50Si+U+K+zHgENDDsfotidDMIzBwNrveIsUEJGKJny/mhxKhyMaP0i8/3VoAZHRsqKOOUAlNsuRzL8L2nF/zsICl/utzP62PcFMYYNn764Z3tV+vnZKkqbPY6zC3GwSbO96ZpczBV+b+QBpLdcGPftWU4YvT+OfzZOg24Ppof0/+ZUhKPWzpBJUdN9QxgBu1HsS+tX5rSWipRTzK0XUJkorA1pZOaXuUWIfk1PT8tysPwVwCecMMPG3cWiaNEtF5ZNtfK+YO/Ifv/oBo4Xx/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+yOaR7fQS5ndpJkvMaWSuQxjwFnhFEc8KG4YubeOD0=;
 b=b8i+qPKtX72btekRnc1vkOrF5IC2LvZ9TEKN1zfRVrzN77swMw4+fhr4UXoen957PXao4j8JUeAw7op5IDb3gnvhuY+bfhEtZq3UAO21UTK9x5Lcpm7m/zCHDFy/5IvOojAjBjqRABCalE9iWfbjcCQcSV+18K98YMY60JGJ3FCbfclfDD77YkZLHiESFQr4zyhQdv0qAWfhxAAsSBlLIYhEYz3KDcxIjWecdrxWg33w1SreVo8wS1S97J59CZ2qR49GP8mdhweI/fVUxnbtF2YjH5tZCSWcFO+2eouamj8q6dH+fcMBxd2Q8KQ4QvIWPv2DWrgpz1so12b2ykZupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+yOaR7fQS5ndpJkvMaWSuQxjwFnhFEc8KG4YubeOD0=;
 b=n0kPtLbC4y82xFz3D48JlP8kQIKq58AuqKJHg8bNjx/IPzV7tEGYYn+S9rM9dnrxOe9Dyg9GyE1RXAovZAMO7CpFSQlgJo7Y2T0k/PSqF4780Jf+vbCjrJSNSy/vhxccE/KFrTobaD7Khoqbzi27gieATE65B9HaEe1VmKja3YKOvk9zFEIA6yciDy1ZLr/0jktCJaN/xLnAzh82omzjwRPC5wHjrdRVQ6IYHmawp/7BdslGuIdtM+mcJqdj1WjOticFetLUuoZ0wfMLsyN/5MIkOIfgSj6gs7YLr3rdJLk0lchzvPoxINwiEYx0eQaghOxZKJrf5mb2tK3Vru6C9A==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by AS1PR04MB9431.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Fri, 6 Mar
 2026 03:09:08 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:09:08 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, Frank Li <frank.li@nxp.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Thread-Topic: [PATCH V2] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Thread-Index: AQHcrQ6U0UY/EzM73k6OjxG9TnjRUrWg0eaA
Date: Fri, 6 Mar 2026 03:09:08 +0000
Message-ID:
 <DU2PR04MB88401521580822759364A8B48C7AA@DU2PR04MB8840.eurprd04.prod.outlook.com>
References: <20260306021247.991976-1-sherry.sun@nxp.com>
In-Reply-To: <20260306021247.991976-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|AS1PR04MB9431:EE_
x-ms-office365-filtering-correlation-id: 8a4f7a67-e989-414f-c298-08de7b2dbbb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|921020|7053199007|38070700021;
x-microsoft-antispam-message-info:
 rP0PkliIm0urLXCvO3Dy1rqO7vTNrbsKdPgnd76LXjRH/HyZQSiD5Viw6tjZlVOmuaQec5m7D1XD74k1qqekJpq3d/BvwJlj9mO5xJRs+Bi+mOt3sGFCj04ddoeQ2aTe+GN5uMmibZEyns5mte3Qdu2kCYR76RNPNryHwKHanJkQG5vgvunzNYCx9upamRrQZvsZdW7aABMLfj9CujwoDoEc0ir3bGelLm2feFyPdftCubqTQXcL7Q3uSBsOMPU2QyXvKRkbYuj2z5MRwDiEBpNHlUIgJ9HnSZuc4HT4JFk6M2XEHx/ZY3hi7UPu0nmKw7cEBZ1RGpRSxXa0IQRMOp++NKM+pDSOQaNoZ8NALnUgBARvT4iAMKVnt9zoa7va1+CdzC8rhaJOEZhQlnW/5UUw3U9wP9ctVbuos2YvTkuDBo7M/+Eti1a92J/bhBanO/3IGJW8qbiE/n44ER2bSM1hyfEGPRdx4Nhc6sic+VzFJUDAH6nciF8Qvs5eXiGvh1/sTLR0kyjq+b2LgHr7Gjcx/4ZmfByhF7e4yT1Xk9G4SlqJxTGgr4by1z8snRLllVrPowawicXFmSIVo8x0qNVM4c9wRXFxa7SDgrv6cltHKyGBgbCzTq4kox04lWEbv60fb8AgMUdoDAxRTyLnbDS8DGzaPc+K+hFjScGVl62XLeTAA6Rq2Dhhar5Hf6at9Mei34bXRJR6dheU4ZpMXEqKwlGcOU5LxC1egLamadHcMDQJuz0qX1TgG5tHUimK/P6ziuDIVvdgeKlJGhnFpNXdq69gC2ZXhCsBoOtWFhjgY1AOwepyWLPsL3abnIvs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WkI5dUxUVkZWblZ3aXZUOHkxM0NPODk0aEFETnFLZUl6UFdsdUs4Nnd5ajFk?=
 =?gb2312?B?MXYzMEpHc1pvWVBGSVQvOFNQQUNZRmZPT2h6MUc5L0VlU0hQZHUxb20wRFRw?=
 =?gb2312?B?empsaStjb1BRN3JNWWdVdEFLM0dMWVZuQ3N1OGNnSm5wUUFCd1RTMUNhS2xz?=
 =?gb2312?B?eCs3UHg1YWhkRGxKNTRqM2lkSnpYK2MxRGdjaHgzZjJyaXcwY25nRUR3eXRL?=
 =?gb2312?B?SGxHNUpKNGxUdkxxUUt5NGF0bVVoQUJidFZVa2ZVeWJscWpLVkloTFhLUjli?=
 =?gb2312?B?ZDh4TlArWXpBRGJZQmhjejFKMERaZHU0S1pvWVB0aG4rbHErbDRac0NvUkN6?=
 =?gb2312?B?VTFwZ1NjdVNadFpxSzJPNmJMRk43M1VJQ0FNenlheWJ0VklTNUhPc1RSRlZo?=
 =?gb2312?B?Nyt0SVI1UDRmYUhEVnFvRjhyYUNLanIwU01STGJGMFVtUlFvd2tqN2FQbysr?=
 =?gb2312?B?bkJrMmdtSjR2cHo2Zm1FQXJ0OEJlUE0wdytOQ3oyQ3l2ZlNyTDJHSnJSVGJM?=
 =?gb2312?B?Q3RHRWNUZnFBZ1pXUldQalBJK0NjZW5oS2VPMWlhZlEreGE2OVd4WFVqVGpm?=
 =?gb2312?B?VGNNWW1hd2dMcXdZK3VFVGJxb1dXaUlaeXhuWTFjTjE5UkZOR1lOTUJ3MldU?=
 =?gb2312?B?UjdzR2dGby9jQVk4NjhQTnlhSU9ZNURrTHV3Nm5XTGNtdmx5MmliZXRlS254?=
 =?gb2312?B?YWMvbnZUVGZXY0xFd21ibkh0Y3BLYkZlYkgweitHSDBhd0t6eTJaZjJtaDgz?=
 =?gb2312?B?cDVSbGxaUmlzMW4wRUwzRWI2bkM4Qk50OEx5UVd1NDZ6Z3UrSUpnQkUzOXNi?=
 =?gb2312?B?QW9HcU1JYk9kN2FIcDloK0RlOXpIMFNKYzAwaDFJM05PTjZ1UERZc3FKK2Mr?=
 =?gb2312?B?RHppdlVqcnBHOTIvQXZFWDdsUTA4SC85OEljWmlYeFEwZzBJZHhYSDJkejNI?=
 =?gb2312?B?VStEclZxS1RMdHk4ajZGb3ROTE5CRUJlazVpZGQyWU5JbkpPL091UXIrT0dG?=
 =?gb2312?B?WmJuOW14RlRPSWpDOGtsRkZyU2hNT1ljVFpWcFNSbSt4eVExcmN2UFM3Rjhs?=
 =?gb2312?B?dnRVMTIzY1JVQzJnK3FSeHBQL2lEMXFBbWNLVDR0aTNPQzhlQnltRS8xSEll?=
 =?gb2312?B?c21EMHJseVZTdTgwZ1ZWUWwra3FRb2tNSUlGb1VXWkdNTWpwTEo4NW9XWW1v?=
 =?gb2312?B?b0dPVXhzTXFobStlT0ZTejFHMjA3Z3VWVzl6clZ3dk9ZZ0VabXFBei9Rc3g3?=
 =?gb2312?B?bEUyWjF0MDNUNWp3VnVVYlI4MHYyV0tjNy9OYzY3YXNJMjdnS21mZHZqZG4v?=
 =?gb2312?B?bUFLRkNTQjRFenlaNmJpQldUeXZ3TVVJaTVBQk51emRFYmV6UDZxVzJ1RVdy?=
 =?gb2312?B?alFaLzArUXJqamFuK3BJcU5kV3NZUjlDSEh3UlNSQnNEUnNqeGM1RmpFYVVR?=
 =?gb2312?B?b1ZKYmd3QmgwTGxZdjd6VFRxUTgrWXhlYStoUTdEUXFBZEl1ZytqdDZRREpr?=
 =?gb2312?B?L0tsc2FFTHpHTkxhM0pKS1pMS0FzcUFZYmtIaFpidGkrcVorWE5QeDg1elh3?=
 =?gb2312?B?dFB2TzFYTkwvdzV1U3UwdkhnZ1R4WkFwWXllc1R0NDR4SXNYTEhMNmRLZE9W?=
 =?gb2312?B?YnBrbVRlYS9RS2dhV25FTmZXQ3dTendBdGNROU1WeXhVY1dPMTNQUnEwdGpo?=
 =?gb2312?B?RGxFbXV5VzU4dnFBUnpCeXdYYkhmRnlZR0M4RmRHWHh4dWFzenBzT0piOGs2?=
 =?gb2312?B?VmJBL3lJTjRiZVZtNVM4SmxCMUZ6WnROSU9oZVU5YW9GSSt5RC81c2VZbFlu?=
 =?gb2312?B?Uytrajh3anppNW55c2FWTEhDaE5kZjdIRWY5aWhLY0hjY0U4ZTJYZlFSaGxQ?=
 =?gb2312?B?SVBneUpaSmcrajY0UmQ1ZUtadFRlcGk3UVVRdE5NQm12Nm1wWnl0OEFmRzVE?=
 =?gb2312?B?NzhmU1FDS3lmSVRObmpOOVhyMHBNaUtEVTNnbVpqSDhnYTdOZ1N0ZitWamht?=
 =?gb2312?B?ZDVHdGY4S2t1SlMrNmtuWXIyTnBtU25aTE9SRkdaQjlNVFQ2ZWRFUXpzcS9q?=
 =?gb2312?B?Q0hTNHhpTG1HeGFRalA5dnpOdXNqbHFhWFBlL3huMW9HRzZIQWZKVFBVVC9N?=
 =?gb2312?B?ZXR0ek9QQ1FrZHFnTkU1TnRoS2Fha2FJUVI4TE4vZ09VdmkvZDlUMGdGK2tL?=
 =?gb2312?B?NHo2TjNIR2lSTHczU3EyemVzZExkMkxjbU5DMEczSzZJU3NmZVdYQjcvWkZT?=
 =?gb2312?B?aTZWb2RPRCt3bWJGY3kwN0dJQStzN0VobkNIVEtXK0dJV0JzNG1MQWZJMUtq?=
 =?gb2312?Q?SgGls9DlQG1O5elcxw?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4f7a67-e989-414f-c298-08de7b2dbbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 03:09:08.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/PViKxSexMr7mKRo/12FhFrNa1EBY77eUdAj8iIq3b6bb2s795+/njeEsCpfTiGRt5RzEDukWHGfBW9KyI4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9431

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGVycnkgU3VuIDxzaGVycnku
c3VuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjbE6jPUwjbI1SAxMDoxMw0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IEZyYW5r
DQo+IExpIDxmcmFuay5saUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOw0KPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7
IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gQ2M6IGlteEBsaXN0cy5saW51eC5kZXY7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBWMl0gUENJOiBpbXg2OiBDaGFuZ2UgaW14X3BjaWVfZGVh
c3NlcnRfY29yZV9yZXNldCgpIHRvDQo+IHJldHVybiB2b2lkDQo+IA0KPiBUaGUgZnVuY3Rpb24g
aW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpIGFsd2F5cyByZXR1cm5zIDAgYW5kIHRoZQ0K
PiByZXR1cm4gdmFsdWUgaXMgbm90IHVzZWQgbWVhbmluZ2Z1bGx5IGJ5IGl0cyBjYWxsZXJzLg0K
PiANCj4gQ2hhbmdlIHRoZSByZXR1cm4gdHlwZSBmcm9tIGludCB0byB2b2lkIHRvIHNpbXBsaWZ5
IHRoZSBjb2RlIGFuZCByZW1vdmUNCj4gdW5uZWNlc3NhcnkgZXJyb3IgaGFuZGxpbmcgcGF0aHMu
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hl
cnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZy
YW5rLkxpQG54cC5jb20+DQpSZXZpZXdlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tDQo+IENoYW5nZXMg
aW4gVjI6DQo+IDEuIFJlbW92ZSB0aGUgRml4ZXMgdGFnLg0KPiAyLiBBZGQgUmV2aWV3ZWQtYnkg
dGFnLg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAx
NCArKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gaW5kZXggODFhNzA5MzQ5NGM4Li5iYTZlN2M3ZWU2MjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAtOTA2LDcgKzkwNiw3IEBAIHN0YXRpYyB2b2lk
IGlteF9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXhfcGNpZSAqaW14X3BjaWUp
DQo+ICAJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGlteF9wY2llLT5yZXNldF9ncGlvZCwgMSk7
ICB9DQo+IA0KPiAtc3RhdGljIGludCBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVj
dCBpbXhfcGNpZSAqaW14X3BjaWUpDQo+ICtzdGF0aWMgdm9pZCBpbXhfcGNpZV9kZWFzc2VydF9j
b3JlX3Jlc2V0KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpDQo+ICB7DQo+ICAJcmVzZXRfY29u
dHJvbF9kZWFzc2VydChpbXhfcGNpZS0+cGNpZXBoeV9yZXNldCk7DQo+IA0KPiBAQCAtOTIwLDgg
KzkyMCw2IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QN
Cj4gaW14X3BjaWUgKmlteF9wY2llKQ0KPiAgCQkvKiBXYWl0IGZvciAxMDBtcyBhZnRlciBQRVJT
VCMgZGVhc3NlcnRpb24gKFBDSWUgcjUuMCwgNi42LjEpICovDQo+ICAJCW1zbGVlcCgxMDApOw0K
PiAgCX0NCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQgaW14X3Bj
aWVfd2FpdF9mb3Jfc3BlZWRfY2hhbmdlKHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpIEBADQo+
IC0xMjkyLDExICsxMjkwLDcgQEAgc3RhdGljIGludCBpbXhfcGNpZV9ob3N0X2luaXQoc3RydWN0
IGR3X3BjaWVfcnAgKnBwKQ0KPiAgCS8qIE1ha2Ugc3VyZSB0aGF0IFBDSWUgTFRTU00gaXMgY2xl
YXJlZCAqLw0KPiAgCWlteF9wY2llX2x0c3NtX2Rpc2FibGUoZGV2KTsNCj4gDQo+IC0JcmV0ID0g
aW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChpbXhfcGNpZSk7DQo+IC0JaWYgKHJldCA8IDAp
IHsNCj4gLQkJZGV2X2VycihkZXYsICJwY2llIGRlYXNzZXJ0IGNvcmUgcmVzZXQgZmFpbGVkOiAl
ZFxuIiwgcmV0KTsNCj4gLQkJZ290byBlcnJfcGh5X29mZjsNCj4gLQl9DQo+ICsJaW14X3BjaWVf
ZGVhc3NlcnRfY29yZV9yZXNldChpbXhfcGNpZSk7DQo+IA0KPiAgCWlmIChpbXhfcGNpZS0+ZHJ2
ZGF0YS0+d2FpdF9wbGxfbG9jaykgew0KPiAgCQlyZXQgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+d2Fp
dF9wbGxfbG9jayhpbXhfcGNpZSk7DQo+IEBAIC0xNjEzLDkgKzE2MDcsNyBAQCBzdGF0aWMgaW50
IGlteF9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ICAJCXJldCA9
IGlteF9wY2llLT5kcnZkYXRhLT5lbmFibGVfcmVmX2NsayhpbXhfcGNpZSwgdHJ1ZSk7DQo+ICAJ
CWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQlyZXQgPSBpbXhfcGNpZV9kZWFzc2Vy
dF9jb3JlX3Jlc2V0KGlteF9wY2llKTsNCj4gLQkJaWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7
DQo+ICsJCWlteF9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14X3BjaWUpOw0KPiANCj4gIAkJ
LyoNCj4gIAkJICogVXNpbmcgUENJRV9URVNUX1BEIHNlZW1zIHRvIGRpc2FibGUgTVNJIGFuZCBw
b3dlcnMgZG93biB0aGUNCj4gLS0NCj4gMi4zNy4xDQoNCg==
