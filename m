Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7030C343;
	Fri, 27 Feb 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195747; cv=fail; b=FPXwjNiVAhDuwvjhnOL6N5PJvH42TV/fv4oYNmJ+OXnOVtbc7joG/U0hJasCw4t1gdIRTA6v3VaHfxAeKuIFdM8Glv8zKQXuHwN6as3oN/wlyRfz70DB2xm4gdtHYcMhaDGXr1KzdI4u5XBRcFV+DWvmWDIjX6ULIv6HJv4aK5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195747; c=relaxed/simple;
	bh=1MmE2jmRL7vcDi7a3d0msvjrVPwOyKez2dhOnC/bukc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsH2lIkspCM30mWFWGM+5MHo+U4fBPiwc45cb8BqLgKLFKjgya/xS76DxbqGSxC7htxu4b+yKnp1TZetvu5O2x3SVpenrCuBrPW2i2dC6dOx+fDpUWtyg0TA2rEGFHa1qzxFHkwnTKmxcbzpVBhqLG4AZDpIxG9Wjy+UbhXiT8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZStqM+V; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZStqM+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asyeDL06SqVSbEOfstVHmimuKo6KmCZWkLqk+TWxjgkvLX57rc6CzkJqMAkE8X2SogcdCfsdQD6nav39fcqK0eUVLN2eeEUCLcwnDbvWSxdDP5FZmCqeInoYO/cyXi5qnuAWrCJdVjOVw7sqvHIwkBN5fR27isT6WF/XQfpeTygP4NA0+0STgktUBLd9y2M5tgvgS6g0wBC3EVj2akqwjOt52W1ytCNJjO7QHPIopMduHFjuDrcdjVgYjpWeKACTV9WBt2g1jA6kwU6zUs81lo3OsFSxmE+kULqaDWC+6A0xQUJmi0JbI+VrjZnmLyf9NN4yotsn8kyhrd0/H1hJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MmE2jmRL7vcDi7a3d0msvjrVPwOyKez2dhOnC/bukc=;
 b=RpIJ2m1yygQtLbz18a/3ExXOEv39K4g8F9TKotHwk+vdqIYIUPv4GQInYNJvAZHciY0ZX89y2+eRp7nBGoXyu/5i6hZ4ONXQ4tsGSFD3HuEg0TqAPMftiElNDG+P9zAJp9uKh8+Dk5gemkAl3OyB7fFHcDv4sVhUu6xKcW7XGMlJekQ9umAlcsnHaR+MD0gillZqTNLL5n4LmTq3ilXMVou2T8Vl0a3YFmV0PvGyrwnoqQv4uXmc56rE3HIu81CKspGRjlO5H1l9zOHdJK49M48BtnKmzj4pejm+A7Cfo4PgB8sb88t989bBbZgHw6sBfDHC4xP1vM2XtibO8tvCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MmE2jmRL7vcDi7a3d0msvjrVPwOyKez2dhOnC/bukc=;
 b=RZStqM+VHK3NhgLrSYKG6t0Ip/I8UuRKGiGL+LHoIwH3PRRMACpkFyH4x+TzMFZ3r+cno1zz3QN+wL/GBMhZXiJal1/ami9md6Z9N3sRA2zAL939ix2QVb+TzVnJLdJyDmv81ncbeg/3ZW73JFNSD85OKVrt9WmjTx4OSGtEM1SxUFLKd2lVIuJ0CTckGur10s3aV/DnMlKx5nMnrnfhBxwzCmFQvcssIzLhR6qJ7ZiNlnWdR3PDkkHx1JIiTFk1sQ4AVG2Auu9GX7dIoM+z0/mKX+LSAzq/P7wComX1fJzG/nEjVwIlcfX7x8PbzFvsgGSYghqbe7BPnVkY7crEGg==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:35:43 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:35:43 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/9] PCI: tegra194: Calibrate P2U for endpoint mode
Thread-Topic: [PATCH v6 2/9] PCI: tegra194: Calibrate P2U for endpoint mode
Thread-Index: AQHcpPS+8ni/0l/8ZEqhHhQXCkjHRbWWgUIA
Date: Fri, 27 Feb 2026 12:35:43 +0000
Message-ID: <4f06e9b1-cb58-4b73-a8c2-ed44bbda65f2@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-3-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-3-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 498d9915-d15c-43f6-a716-08de75fcb977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 UAo/DE4zxiqxsOubJejOXj3RxvK+9bu8qIOHPyVwbz9R1WxYHl+8lw2LF9kZrXZw4225XsI702AJ34RQv1QZwBEYEcE/6rwO32gF5YmP1EsJKIsEE4yEf+HJ+nILPxrR+IiuZSQpngtIMfqym5hhOB2TNykgcxQgcbJOsRgefcl9ob8v9QX9ZzdMwNbTPWhytkfAWys37Z/jpmo155vGgsx55aTYF0elaw2KsNVGSNr0hGntTL3wRjpR9g0hCY4Cd44TVHO6flVPwKFrIOXb8f8pWHo7AI4UmClTUUOLaX1J5LMg3kfv49RIVY5tLt4TA9r2r7AfHsBEn//TSnY3Bu1IdDope6NiZ+/DVJAncNTBx47EbPXwyj6RjB4zhBaj06l0feFLOngd2uXXevvstqM39xKuS+Eg1YzGsJmQ7wjy3cF4y9hHq1xIYrdDY/WpEtLAGyQGP335YCpKe8zi5JYaKza9QEI1gICMv2hWaTmFeTDeT6OWRfiHNmrW209EAi52TPLPcENOk0H/nSI4+Jzww4OIvUlaI83+68ZuCVXlk6HrzU7QbSADm9hJpXlXbzEEELWfQsLs/uUNWamkRzg7krLjW2DkbOrMRRjLfgDHdyiW6LQ1WXE2si+CzesOvnR6zfkKik0SdlOQtRL9VcRzNxC2A39doOSeFT9Z99I5fC+Ff12N5KHF7QB7frKtv/N+038dXo3b9xZkB51a6HCcOrubEoWRzhjb6/aZ5Vr1tOU2j38YmO4iHPlmk9IAsDhks4Y4eTzacSaeJt7BhnbKswzwiSYOAccEHroHPnlWWE5C7RJufSr0t5NGgn7R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0w0RldpZVIrbWVtYWtERTZzbmJQSVlOWXBLc0dyK1JKdkFveXFMbWVyMHl4?=
 =?utf-8?B?TlB1VjcyOEZRQ1ZoSGdWbG5uVEYyUDhIZm1WOXZwK3FBcWFJZGM2aVpYejFq?=
 =?utf-8?B?RXdocmFJdmN6OU04Y0RqdThGNVNwUDl0ZjFURnM1L1VRcHhoYVE4NmtLVmlm?=
 =?utf-8?B?WXlGV2lYd1N6K3ZESGhrOFhKSHd6MmRSL1RaV005N2RIdWpzMWpyUWZaNmJo?=
 =?utf-8?B?Q0VkSzNTbWRNWkhXR0VVMjlQRC93SUVFb0haVWRRenpiWGMzYmxSOGMvTE1s?=
 =?utf-8?B?U2lGWnlhOEpGd1YyK2xuR3JwZGhYMGtQeVZrdkdKUDB4aHQ2YW5BSmVmMzFz?=
 =?utf-8?B?QjNEakdkeFQxYVFkaUFvUFNMM0JuamJTRGJ0RGhWb1UyWWZDbFhYVUVjSlBr?=
 =?utf-8?B?WTcxR3NqbW9Ybi8vUW9zMEwwR1I1UTFTa2ZSdlorUVhleVdBOEJjL2lENG1s?=
 =?utf-8?B?ZXpaUi9XdFRZTXJLdW1zbWxBQWY4Uk9hM1I4aE9GcDF2cHU5NzFBbkxNeFZl?=
 =?utf-8?B?VGpkaFdRa2JtVkxSNUdOaWRDTzdmN2pVQzhkMm1manI2eGJVU0prYjZWeFgw?=
 =?utf-8?B?UjM2RDlRMkRyejNWUndERjdiaW9CZy9aZDg3MDV4MUpIOVAyS3FReG81SnZn?=
 =?utf-8?B?b0ROV0R4T20rRVFJeTBzSHZDam5MZzE1dzViTE1xVzBvT3pyM1Yrc0Q1Z0gv?=
 =?utf-8?B?bHZpQ1o4TFNFM1I1SnFiNXVGbW9sWHBrU2xEVmdVbTFhNlA3MlZZcFFVeXEr?=
 =?utf-8?B?QzBmSEJ4VnJZSU9sMzhHMVB1aE9jN1pGZ0xsd09RMGRTYUhhK2E3aFBnUktT?=
 =?utf-8?B?ejhKei9uTWgwTDRnUnkzZTdOeEZqOXRZdHN6aWRtL3IxbGljOUxKeEhmWGI4?=
 =?utf-8?B?TmhrMEpIUVFkQmgwWGZUZjk4YjBJNjZwMmh1OGtLN3VGQlVCaC92cVlsTGNp?=
 =?utf-8?B?b0YyUDlZVy96aWFsdWYrQk1ycGlkN2FsNlkxUFNwTmh2aWNiNUZaV2NWQUU5?=
 =?utf-8?B?R0V3NFpnY2pFcXE0aUZjaEpIUkExbXVTZzYvbDl4VHd2aStNVitybHVhZXBI?=
 =?utf-8?B?Mjd5SnE5K0RYaHRJS2t6azBEQ3B1MnN4eUI1Zzd6QWVJYmxBNk41VlBRekxN?=
 =?utf-8?B?ZmhlNm5NcUgxbVRTUTZNVlo2VHFKaWVoanhpTy9uY2d5OENFWDZrOHVHS2E0?=
 =?utf-8?B?cUZTdVZnMW9KNWkyK2MrelJYY21MUUhFWXFKTWFwRTVGUmNTZlpHSENndnJF?=
 =?utf-8?B?Slcvc3FKTjJFY2VVdnpLT0xhUGhkd0pPOWlQcTFMQW9TUWZJRjVoM1ZzMU5z?=
 =?utf-8?B?cXFyS1ROTFZjYjIwQ3ZiSDY2TUtNYlUrclI0cXcvcWRSOEZ1TTd0QzdzcFlN?=
 =?utf-8?B?cy85RUNzRENtcXdjTW05V1oxT25hWWtRTXc3THdnWllUZFZXcVpxQnZMRENT?=
 =?utf-8?B?MExkZkpPLy9yeUxNV0hnZEp3Rlhkdi8ybFdYK1RlS2UxK2M3dzBqMnBQZXhY?=
 =?utf-8?B?L0NsQzZhbVN4Yk42ZVVRdGtVRDhGd2J2M2RjM09lVU52Q3lrTXJPV2Y4RnJ2?=
 =?utf-8?B?ZFRvQTl2eklZdXFyd2QxQmRyTWtvdTZzYXhUUWVTV25Zb3M5aXFWOEhCOHZJ?=
 =?utf-8?B?aVFFWGxBS3RLL0JvdTRsVEZHdVhyRmRnVkJ0a3U2NkpBZTEyaElMYWNpOHNN?=
 =?utf-8?B?cnF5RzVUalh5NUZpMGdmUUkrUG44Y3dzTzNhV1Y2Tk0way9pNlZERGVBRTVv?=
 =?utf-8?B?UlV0MWcrT2JTZXZYeXRwblh6enhFd1Vrc2VJbVQrWDVsMWVRWEFVRDIwb25M?=
 =?utf-8?B?MmpsYzVxL2xUYjlhVWZLNUMwNWJBODdOSFF6T1QrZldreTNzQUlBellEYnZ4?=
 =?utf-8?B?bUVSa0dLT3d5MzZuMFVQeEpudUpLaGVobitaV1lnU1Z6WjkzRTVBc0t3Y2N4?=
 =?utf-8?B?bWZBc2lLaE9GT1hlOWo3aWpOUVlwSlF5YnAwQWNMdTR3RW9hVzB6NHpVTDFW?=
 =?utf-8?B?ellmVS95Skx5ZDlJdCt4ZHRFUmJEazV2d0dpV00yMnZkeUM3V3FUZlNFVHlO?=
 =?utf-8?B?K0JYOEtKaTNvZTFqUFZ3RFpoRWs4SzJhQnpaYUJya0JRNnlWZUhPVDFlUGFu?=
 =?utf-8?B?UStoaGxFUkpSQ1pjVytvUWxDd0wyTXYzUzYyejRLOG9XTUJ0aXp5YmYzdXc1?=
 =?utf-8?B?d3g3VExwL2ExaE52VTkxaGMyaFV4NXNVRlJwajhMalVUMTdGTVZmOFpYWG52?=
 =?utf-8?B?MUc4ZWhKMVB6VkhRdW92TGprcmRxNlFSbzJobXlqcDF1REc1eGNwcUNleGFF?=
 =?utf-8?B?eUZ0SzRrVDczSmI1bGF6SHFleXg1TGliWjVXVkFCMTdON1Z3NkxRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CE17A177E281447B7D5947650C618FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d9915-d15c-43f6-a716-08de75fcb977
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:35:43.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7qMzI7jjTAhqcHnFKN8J52gBDn7M/U3phFOgCDU3iCUIOgLAMg0ZWlp+KvBFltneAJQpDInnJScp7fZxaORBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBDYWxpYnJhdGUgUDJVIGZvciBl
bmRwb2ludCBjb250cm9sbGVyIHRvIHJlcXVlc3QgVVBIWSBQTEwgcmF0ZSBjaGFuZ2UgdG8NCj4g
R2VuMSBkdXJpbmcgaW5pdGlhbGl6YXRpb24uIFRoaXMgaGVscHMgdG8gcmVzZXQgc3RhbGUgUExM
IHN0YXRlIGZyb20gdGhlDQo+IHByZXZpb3VzIGJhZCBsaW5rIHN0YXRlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBNYW5pa2FudGEgTWFkZGlyZWRkeSA8bW1hZGRpcmVkZHlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+
IENoYW5nZXMgVjEgLT4gVjY6IE5vbmUNCj4gDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXRlZ3JhMTk0LmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
dGVncmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0K
PiBpbmRleCBmMDI2YWY3YzJjZTAuLjUxYmFkOTljZWMzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMTA1OCw2ICsxMDU4LDkgQEAg
c3RhdGljIGludCB0ZWdyYV9wY2llX2VuYWJsZV9waHkoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBj
aWUpDQo+ICAJCXJldCA9IHBoeV9wb3dlcl9vbihwY2llLT5waHlzW2ldKTsNCj4gIAkJaWYgKHJl
dCA8IDApDQo+ICAJCQlnb3RvIHBoeV9leGl0Ow0KPiArDQo+ICsJCWlmIChwY2llLT5vZl9kYXRh
LT5tb2RlID09IERXX1BDSUVfRVBfVFlQRSkNCj4gKwkJCXBoeV9jYWxpYnJhdGUocGNpZS0+cGh5
c1tpXSk7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQoNClJldmlld2VkLWJ5OiBWaWR5YSBT
YWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
