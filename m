Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A120C00C;
	Fri, 12 Jun 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261536; cv=fail; b=BhhxH5n3nGHFillFLAY9zi3OZ8CuRLBsDgJqZqKP5OkkEokqQ6FTo2EBm9wpPenhMf5BFFRczqVd1zmo0HldYUuFw949+hnnPJIduRMbckLKimINDuCxpQ42aqUEZUTJwWFJDwgSqBZfKW7UGvY+yVEWXLGSimUv3ebYiN2OT6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261536; c=relaxed/simple;
	bh=ygsPodcePPgRdXj/NR0UVRCG6WGSHXOjCwxpcMQOHK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=toGvtfbplqX1evEw7Gx5O0dVf0Cz6auPK3AiY4+VNUG0hF0tGayWsW2nu8cb0WYGBaibbhuZ8gUZKfyA/1ilOKCpjb4tdq+LciWsAlQZvuwI2sfaa+Nf5QrJ3RHWugjDQxxh1CthdyFbQHWKwb1ty8vYsOpbaGIbY6+wm1QyxMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTaw9pkn; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTaw9pkn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXJvWqa9u+VBauwgtv63N/hzKzPpLgFqeV/dcRP6n1tl4TrqhFiiB59XcdFUKmQsHIO0Ekgc0+Q5uDRcUcqliN3tGVfXo3Pdr03VlIkpRAh0+1GquJlMRZCcmbIErvnrKzqLfJ59SZxGORvsIHcLt6Su5kBdJsxIo+RUCa8GdKrFwM+vCBVwgu+irALaPbWU/+PhNShzqzB2sPANbnRpA+BuYh4hzSCJc0BXqsb3CWXVDvuam06LnSIUnbbLGZH6rBolLJ7H11gHQNHZrzF6ToNYLnrrq4TubUPqKDYiL2al4t3sa5pAj62MTZ6RdiB0uE5grwdf7vzbIz4bBO8rQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygsPodcePPgRdXj/NR0UVRCG6WGSHXOjCwxpcMQOHK8=;
 b=vOAHr6zUnF9i5Q66o97ggc+GSn5U2XYMVWUxWNo490MRduKKL/gzq9cDi8+OcwYufpaJQpBC+LGMWl43Q2PP0tnf4ihNgfy62SroXTF6yzlWPVua3tO5HhZm/KGUzOspNOq1d6qc4JFeaGj/ruMuX2XqL5AHCrkMpy6a5lGSFaBT8cU3LFpa5sCdp+P0RTyZzeCq6AmOftyNnP1uwzx+zWh0C0lMIqb3o/vNMTafRgyFTO6d2BGzy4/rfybVWAtSNmsE69U1yyMJyFZsdmppQfqIySOLwVQiYk089GzV7vAiN77zDxo7qcHSMSuu5vfRg12LSdUVF9MyBu+q4EnpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygsPodcePPgRdXj/NR0UVRCG6WGSHXOjCwxpcMQOHK8=;
 b=CTaw9pknvZXAzAqZEp2R08gC4b8juRqEoxXf29jwRMlsi70NS9se0nPTNX5lGY3tv9mA4s3Jf6T1yK7zxkVSJUfeepIb7d5lO2KDCmIAjYwOt/IgQNOXE7OBPFBydYcE0/IFwHns52Nn5hXQkCIZuVjbyRS2Q+wq9nAhPygX9YBKTO4LXC+OZPMP7sze4NiofFNfpCJnvGg3jnYJIjWTnqSkN5JrTDDvtoOX365NTbfr6f3iI8S8om6n+8sFWfOoVyERVszMce7Z8DKQVU3D2UMnR6s+wYBMKKIxTum893lNzVD3xJUmvDUkxP+7SynqeMEYPANVQAOlJiWXdft9SA==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11850.eurprd04.prod.outlook.com
 (2603:10a6:150:2e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 10:52:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 10:52:10 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply
 support
Thread-Topic: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Thread-Index:
 AQHc98EqSHx96zAXkk2n7RCbK2H3mLY1lPEAgABAkQCAAaAD0IAAEgQAgAALARCAAAV2AIABGZewgAAwy4CAAd0iAA==
Date: Fri, 12 Jun 2026 10:52:10 +0000
Message-ID:
 <VI0PR04MB1211485955B552B1F2207680592182@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
 <VI0PR04MB12114DA25D08329D3DC2C3ADA921B2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <6ouch5ybqk7gws3yrvc2sylq67nioqva6klc7o7wcgbpobs2lu@ioscmsg6ufyx>
In-Reply-To: <6ouch5ybqk7gws3yrvc2sylq67nioqva6klc7o7wcgbpobs2lu@ioscmsg6ufyx>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|GV4PR04MB11850:EE_
x-ms-office365-filtering-correlation-id: 92c05a95-e622-4c0a-f145-08dec870a762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|23010399003|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 n+NqYUuI9qSUGUXSOlI77Thdhub0uXL1+B/zeFTSLYZYonAMmUjM+mEwheSGr25Oj3l1wwq0npipFCw1oGkT32PF8PCgVPWqQ0kFo/9hMJ1rYkyzkf5xVde75CYR4GWpb7u5tpMXlsHBr+iB8F3AZEAZpjUSUimLnEmcMrYk7fOcavG9ZbKLZWI0h6MP+9opm8rAdbh0UE8viMdxNtRiIQYpSpMQ+TQIIkWq5ikcS0svugpcgadMi/sGRyLC5s9lAWZQ/a/5kwWyQt4aGU8oZI2WwnW4R/4fEQrbsiNMG/ah4oldXAKMxpHFNic9pI+LXW5myyIbFegdNFB6XLz0rvj9ABLC7CuohmKGyV9uY0EBDiFmKZ0LMCacbUq60B95fn8ZvuQ13WcdSoqzqNIRmFPbDtERM00HmGEaVeQ0NT0jpUMW/GP7mwL2mqg0IZ4ftee6vm8t9A1VohMLTx/PrsVLGUd58eBJeMTY5RbDO3OdS9QYZEd2S9JBma4+xooyGXRMVtC13XQX06cUOL+jx6Zlk10VosA884kVhFiZYm6dXT1fwJa7P5VZO8wxToDYWfoo/+RDr5Q2XygmXayjlXBda2v+TSYMeJedrrl3p6yefLEmAyNYki9NN97EJguOxwZihoYPAlOaB+Ehk0FhKGiMpx9NmgaPC/fUYuavTb9QZYf3Hz7kCQolSwm5lEbnMdSAF6bhqhxtAj8VZUc4Tx1bnS3lqSyiwU4CWye0/OyfCNyeMluv/GlipTPfNLJ/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(23010399003)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2JKQ09ZMEFCRWJ5Y25DTWswcWp0NW00eXI0alpMYjFBQ0lPbFMzUHdIYTBL?=
 =?utf-8?B?cVZlbld2Z2RLMlQ4YVdoOXNuUW1xWHBqSWNvSXpQelh5VmRyOStXM05jd0hs?=
 =?utf-8?B?VDBHOXdVQkJIN0MwT0JzL2RaZnhtSFBlcDBGM1hrc1B1aCtmYWp6VzVkc1Nn?=
 =?utf-8?B?bFlTUU5mbkUyWE93QlA5NU9wYmlYeFphVnMrbjgwRkM1OVFYcEs0SlJWVjlQ?=
 =?utf-8?B?UCtseUJjYVBVdlNucGVncW1pMmFkZHVZYzhEMWlmRHFQZTNEdTdYMEJRRFRY?=
 =?utf-8?B?aVU0WHZRelVua1FzeFFHKzFVcFE2YW1VTVZZR090ekwvM2tVTmpiQlhqdFAx?=
 =?utf-8?B?WXlGRngvNmx2ZTN0ckt0b3BLaUs0dXhhTXMzeXRMOGNwNmJudjlQOWJXSTVj?=
 =?utf-8?B?cTRyVkg5VlA1M2RuUithbGV1MDVrRm5YRXZDWmlLK05XRG41QVVHa1M4c0pl?=
 =?utf-8?B?bVA3YTNqTkxNd0FzRE8yQU1CNHBVZDFVcEdUb1JWQjNDYWxZWkFFTGFhTmVI?=
 =?utf-8?B?S1BVR0QyRjNQTWZLdnQ2aytnM1RqeTQ3YzNic2dMT3J1QURYTk5FcGNIWmZw?=
 =?utf-8?B?RHVFNlArd3ZYUy85MVlpeW1IU2IwbTd5ZzBYN2UxSFZFQ0JDa2pIQk15RHJR?=
 =?utf-8?B?c0FsVmUrS3lWd2UxU2s2SGNnWjJFNHJLVkYzaE0ybDdhVEpxdEVZTUM0UjlQ?=
 =?utf-8?B?VWpkL2E1aDVZK21NV0FjR2FRejI5dlV4MXhjd2FnWnA4Wit4Rk5SR3FBVTR2?=
 =?utf-8?B?LzJwM2FCa3JZcFdPNTNkM0FtbXErSWtTQmZ1TUNiT21DSlQzWXJEMW9MUVJz?=
 =?utf-8?B?UlpVMzF0Zm1zRGhUZWtlVlZ0bGNUWDBPekI2d3FSbW5QWkNjZjM1ZGdHOGtE?=
 =?utf-8?B?elhtU3NKZkF1eldVbEsyVFpVdUNOUmtHQjRKcngxaVIrRVhMbFFZZWJab253?=
 =?utf-8?B?aThiRWp2R2JIWmM2Ri9RdDAxTk4rNzNqQVZzejgrV0tmMTdaRmR2Y1ZwTHhV?=
 =?utf-8?B?V0IvMHMrUHNzQ1RjOGtvNGdnOGxQVWg2VXBsa05jTDM4SEZITVl1eE9abGNR?=
 =?utf-8?B?c1FnUk13VEdDS2RXYitjUGdXVXg3SlZPdGgyQjZvRjdDckdOZ3FQWEVSWk5W?=
 =?utf-8?B?UU1TL0pZbkxSb3Z2bFg5a0VwZk1OYXRMcUFHMDIvTzJpdCs1MEVsQ05iVEFF?=
 =?utf-8?B?UFNKQlp5VGxWSUh6cmh1YXp0VThHNklRakFtL09mLy95WjArRWpJRkgwRWVT?=
 =?utf-8?B?TUQxRWdiU1NTRFZ1c3NTTG4zK0VySzFqS3Y5WFNrcXp0UmVhUkpvYzVwc2dl?=
 =?utf-8?B?cG5VbFNTWG42WEYyUitTeEMzV29mTDErQlB1eVFnU1FNbkVkNGlEaFF5ODls?=
 =?utf-8?B?dVZHWGpESVJSTXBydzBqRE9EVStIMGcxTFhFamNwejJ4MTlWRDNJTEd5Njdw?=
 =?utf-8?B?K3p1NEdQdHhjL1FpWlNscDE2d0xFa0gyMlJxM3J5Y3d0M3UyWm8vcTczNHZP?=
 =?utf-8?B?VnUwaWMzcnpBZW9uNi85ODFIMTFkOTVjRDVTakllV1cxemE4TWt0eTJqdFZY?=
 =?utf-8?B?RlJYd2ZqOElQQjQwRjdObEVwbEdNQ1dTNnd2SUVBUVQvVmJ0Z25tVEhNQzQx?=
 =?utf-8?B?RmUwdElYRnJWSFpPa21rMG9abXFjdzdVaHpjMzNBS1JoM0FIWHpJR3UwR256?=
 =?utf-8?B?UFp1TDNxeGhQcmFwbnJKUmlxbjMyUXczeHArY3ZJMzdaenk2NnoyNTlUeG5G?=
 =?utf-8?B?a2pMYXdEMnJvOG8xVWYzcytBSERmWVFFN211L1JLam40U2VSY21ha04xTm5W?=
 =?utf-8?B?YkpYWXZWMGJqaUFpdW0ya2N2Q0dWNlVQSDk1SjMyaVdDeHpGWHdYSlJRWkI0?=
 =?utf-8?B?amRuN25oVGprT2M2VEs3VnhJL0h4b3Nvb0JOSzliT0s1dXE4Q2NBWHFWa1Bq?=
 =?utf-8?B?cmlLeFNvcmNkUmhQSzhpVlZaZEFDRUZtN0x0NGcwN3lyeDhQYnhkNzVzckF0?=
 =?utf-8?B?M1lqSjIxakw3SGhWYktGRkE2MTMwWlduU1dHQld5ZGtSdC9KS3Q3VEp5MnRM?=
 =?utf-8?B?Q0tiOGduVEJYNHN2RzZScHB3RkhQbjdZd3FSTlBMZXVPZmZRTFQ3bTRwZ1oz?=
 =?utf-8?B?N1JoR0RZU2ZZdE81d1p6Zk1DV3RKS0t6bWtmTHUwMVBnYVRxTVFLM3cvdmQv?=
 =?utf-8?B?THo1WSt0WHZWMHFkdWtrdVVGQ2FDTTFqcW9tbGhHcURlVlF5MmhzbGN5RUVx?=
 =?utf-8?B?M3hnaVVPM2s2N1lmYWpJV0psN3E0Q3ozT0NSTk5MUENNM3lXQ1JtK1U4aUM5?=
 =?utf-8?Q?5THTT2ADiUQq58Qy5s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c05a95-e622-4c0a-f145-08dec870a762
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 10:52:10.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k12G+k3K0WPM+WaxS105JKvnmYsM27s4LpdzWIc9FIzTASmV8F9t6HWE+ZWdP//X7Cetz8VxzqZrFfN3REzKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11850

PiBPbiBUaHUsIEp1biAxMSwgMjAyNiBhdCAwMzo1OToyOEFNICswMDAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+ID4gT24gV2VkLCBKdW4gMTAsIDIwMjYgYXQgMTA6MTM6MDBBTSArMDAwMCwgU2hl
cnJ5IFN1biB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIEp1biAxMCwgMjAyNiBhdCAwODo0MDo1
NEFNICswMDAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEp1biAw
OSwgMjAyNiBhdCAwMzo0NDowOEFNICswMDAwLA0KPiA+ID4gPiA+ID4gPiBzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBUaGFuayB5b3UgZm9yIHlv
dXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxDQo+ID4gPiA+ID4gPiA+
ID4gcG90ZW50aWFsDQo+ID4gPiA+ID4gPiA+IGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiA+ID4g
PiA+ID4gPiA+IC0gW01lZGl1bV0gVGhlIGB2cGNpZTN2M2F1eC1zdXBwbHlgIHByb3BlcnR5IGRl
c2NyaWJlcyBhDQo+ID4gPiA+ID4gPiA+ID4gbm9uLWV4aXN0ZW50DQo+ID4gPiA+ID4gPiA+IGhh
cmR3YXJlIGZlYXR1cmUgb24gdGhlIE0uMiBLZXkgRSBjb25uZWN0b3IgdG8gd29yayBhcm91bmQg
YQ0KPiA+ID4gPiA+ID4gPiBzb2Z0d2FyZSBwb2xpY3kuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IEZlZWxzIHZhbGlkLiBEZXNjcmliZSB3aGljaCBwaW4gb24gTTIgY29ubmVjdG9yIGFy
ZSB5b3UNCj4gcmVwcmVzZW50aW5nLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFJlZmVyIHRvIFBDSSBFeHByZXNzIE0uMiBTcGVjaWZpY2F0aW9uIHI1LjEgc2VjMy4x
LjEgUG93ZXINCj4gPiA+ID4gPiA+IFNvdXJjZXMgYW5kIEdyb3VuZHMuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gUENJIEV4cHJlc3MgTS4yIFNvY2tldCAxIHV0aWxpemVzIGEgMy4zIFYgcG93
ZXIgc291cmNlLiBUaGUNCj4gPiA+ID4gPiA+IHZvbHRhZ2Ugc291cmNlLCAzLjMgViwgaXMgZXhw
ZWN0ZWQgdG8gYmUgYXZhaWxhYmxlIGR1cmluZyB0aGUNCj4gPiA+ID4gPiA+IHN5c3RlbeKAmXMg
c3RhbmQtYnkvc3VzcGVuZCBzdGF0ZSB0byBzdXBwb3J0IHdha2UgZXZlbnQNCj4gPiA+ID4gPiA+
IHByb2Nlc3Npbmcgb24gdGhlIGNvbW11bmljYXRpb25zIGNhcmQuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQnV0IHRoZSBjdXJyZW50IHZwY2llM3YzLXN1cHBseSBtYXkgYmUgZ2F0ZWQgb2Zm
IGR1cmluZyBzeXN0ZW0NCj4gPiA+IHN1c3BlbmQuDQo+ID4gPiA+ID4gPiBTbyBJICB0cmllZCB0
byBhZGQgdnBjaWUzdjNhdXgtc3VwcGx5IHRvIGxldCB0aGlzIDMuMyBWIHBvd2VyDQo+ID4gPiA+
ID4gPiBzb3VyY2UgYWx3YXlzIG9uIGZvciBQQ0llIE0uMiBLZXkgRSBjb25uZWN0b3IuIFRoYXQg
bWVhbnMNCj4gPiA+ID4gPiA+IHZwY2llM3YzYXV4LXN1cHBseSBhbmQgdnBjaWUzdjMtc3VwcGx5
IGFjdHVhbGx5IHJlZmVyIHRvIHRoZQ0KPiA+ID4gPiA+ID4gc2FtZSAzLjMgVg0KPiA+ID4gcG93
ZXIgc291cmNlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEBNYW5pLCBkbyB5b3UgdGhpbmsg
dGhpcyBpcyByZWFzb25hYmxlPyBPciBkbyB5b3UgaGF2ZSBhbnkNCj4gPiA+ID4gPiA+IG90aGVy
IGJldHRlciBzb2x1dGlvbnM/IFRoYW5rcyENCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBUaGVyZSBpcyBubyBWYXV4IGRlZmluZWQgaW4gdGhlIE0uMiBzcGVjLiBTbyB5b3UgY2Fu
bm90IGRlZmluZQ0KPiA+ID4gPiA+IHRoYXQgc3VwcGx5IGluIHRoZSBiaW5kaW5nLiBZb3UgY2Fu
IGRlZmluZSB0aGUgY3VzdG9tIFZhdXgNCj4gPiA+ID4gPiBzdXBwbHkgYXMgYSBmaXhlZCByZWd1
bGF0b3IgaW4gRFQgYW5kIG1hcmsgaXQgYWx3YXlzIG9uIHNvIHRoYXQNCj4gPiA+ID4gPiBpdCBp
cyBrZWVwcyBzdXBwbHlpbmcNCj4gPiA+IDMuM3YgdG8gdGhlIGNhcmQuDQo+ID4gPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gSGkgTWFuaSwgdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgYnV0IGFk
ZGluZyBhbiBhbHdheXMgb24NCj4gPiA+ID4gcmVndWxhdG9yIG1heSBjYXVzZSBib2FyZCBwb3dl
ciB3YXN0ZSwgY3VycmVudCBzb2x1dGlvbiBlbnN1cmVzDQo+ID4gPiA+IHRoZSAzLjN2IHJlZ3Vs
YXRvciBpcyBvbmx5IGVuYWJsZWQgd2hlbiBNLjIgY29ubmVjdG9yIG5lZWRzIHRvIHdvcmsgLg0K
PiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdoYXQgZG8geW91IG1lYW4gYnkgJ25lZWQgdG8gd29yayc/
IEZvciBnZXR0aW5nIHRoZSBNLjIgY2FyZCB0bw0KPiA+ID4gd29yaywgeW91IGFscmVhZHkgaGF2
ZSAzLjN2IHN1cHBseS4gSWYgeW91IHdhbnQgdGhlIGJvYXJkIHRvIGJlDQo+ID4gPiBhbHdheXMg
T04sIHRoZW4geW91IG5lZWQgdG8gc3VwcGx5IDMuM1ZhdXgsIHdoaWNoIHNob3VsZCBiZSBhbHdh
eXMgT04NCj4gdG9vLg0KPiA+ID4NCj4gPiA+IEJ1dCB3aG8gaXMgdHVybmluZyBvZmYgdnBjaWUz
djMtc3VwcGx5PyBNLjIgY29ubmVjdG9yIGRyaXZlciBvciB0aGUNCj4gPiA+IHBsYXRmb3JtPw0K
PiA+ID4NCj4gPg0KPiA+IEhpIE1hbmksDQo+ID4gSSdtIG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFu
ZCB5b3VyIHF1ZXN0aW9uIGNvcnJlY3RseSwgYWN0dWFsbHkgaXQncw0KPiA+IHRoZSBwbGF0Zm9y
bSBkcml2ZXIgdGhhdCBjYWxscyB0aGUgTS4yIGNvbm5lY3RvciBkcml2ZXIgdG8gdHVybiBvZmYg
dnBjaWUzdjMtDQo+IHN1cHBseS4NCj4gPiBUYWtlIGkuTVggcGNpIGRldmljZSBhcyBhbiBleGFt
cGxlLA0KPiA+IHBtX3N1c3BlbmQoKSAtPiBpbXhfcGNpZV9zdXNwZW5kX25vaXJxKCkgLT4gaW14
X3BjaWVfaG9zdF9leGl0KCkgLT4NCj4gPiBwY2lfcHdyY3RybF9wb3dlcl9vZmZfZGV2aWNlcygp
IC0+IHB3cnNlcV9wb3dlcl9vZmYoKSAtPg0KPiA+IHB3cnNlcV91bml0X2Rpc2FibGUoKSAtPiBw
d3JzZXFfcGNpZV9tMl92cmVnc19kaXNhYmxlKCkNCj4gPg0KPiA+IFRha2luZyBiYWNrIHRvIE0u
MiBTcGVjaWZpY2F0aW9uOg0KPiA+IFBDSSBFeHByZXNzIE0uMiBTb2NrZXQgMSB1dGlsaXplcyBh
IDMuMyBWIHBvd2VyIHNvdXJjZS4gVGhlIHZvbHRhZ2UNCj4gPiBzb3VyY2UsIDMuMyBWLCBpcyBl
eHBlY3RlZCB0byBiZSBhdmFpbGFibGUgZHVyaW5nIHRoZSBzeXN0ZW3igJlzDQo+ID4gc3RhbmQt
Ynkvc3VzcGVuZCBzdGF0ZSB0byBzdXBwb3J0IHdha2UgZXZlbnQgcHJvY2Vzc2luZyBvbiB0aGUN
Cj4gPiBjb21tdW5pY2F0aW9ucyBjYXJkLg0KPiA+DQo+ID4gUGVyIG15IHVuZGVyc3RhbmRpbmcg
b2YgdGhlIGFib3ZlLCB0aGUgTS4yIFNwZWMgYWN0dWFsbHkgc3VnZ2VzdCB0aGUNCj4gPiAzLjMg
ViBwb3dlciBzb3VyY2Ugc2hvdWxkIG5vdCBiZSB0dXJuZWQgb2ZmLg0KPiA+IFNob3VsZCB3ZSBz
aW1wbHkgZW5hYmxlIHRoZSAzLjMgViBwb3dlciBzb3VyY2UgaW4NCj4gPiBwd3JzZXFfcGNpZV9t
Ml9wcm9iZSgpIGFuZCByZW1vdmUgdGhlDQo+IHB3cnNlcV9wY2llX20yX3ZyZWdzX3VuaXRfZGF0
YT8NCj4gPg0KPiANCj4gSnVzdCBkb24ndCBjYWxsIHBjaV9wd3JjdHJsX3Bvd2VyX29mZl9kZXZp
Y2VzKCkgZnJvbSB0aGUgc3VzcGVuZCBwYXRoLg0KPiANCg0KSGkgTWFuaSwgZG8geW91IG1lYW4g
dXNlIGR3X3BjaWVfcnA6OnNraXBfcHdyY3RybF9vZmYgZmxhZyB0byBhdm9pZCBwb3dlcmluZw0K
b2ZmIGRldmljZXMgZHVyaW5nIHN1c3BlbmQgYW5kIGFsc28gbm90IHBvd2VyIG9uIHRoZSBkZXZp
Y2VzIGluIHRoZSBpbml0IHBhdGg/DQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
