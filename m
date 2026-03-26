Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1338E130;
	Thu, 26 Mar 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513054; cv=fail; b=E6Ts3SetCIekwoIlIs1p01mqVqm9brNvOiZEF2FZQavcBpvci3LTqsvUsTvM+itXfzV38GLOcWEZdY/hL+gBEon+PAgxhxgJml1oxAApSSDRHKWq9EcW3dGC8mr8QS7AQdQQH5DS1wlqb/88tmbiB8d2Zh8Dzdy4e5qQXbHeBds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513054; c=relaxed/simple;
	bh=tO/MuIihZp9NO7wxGyzSmD+EbcUHj+9UM6fvlfMOso8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ag3h5lHKq6n1RIu+n6DtHb8YBoiSGx1K3jqHqhNaDL3zdjQ8fGVQOG4Ie4l2/ZejKuQ88hsuZG8NtZklYKf6WovuuNy8H214ksvjj0DMpuejYw6B7tbrxK9NIb1fJkRDXRbSXeOAl5si9peTDH/wfLtEeHhP0tpkxu9M+mTQDu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fxmQ8cv1; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fxmQ8cv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+2Cjc/J0ZsyN0xeXh/Y+faLG/Hzr5if70EUq0raWf+pwS4QHFrwyHYf0St8AOpUrOtyT4yUMoWephBZ63vxeAqZFBMTJGYAe3FCtmclzXHU89V9PTh46YmrY//uSdB5QSKsAG0xMc5a+j/zjNxMmvvtg+TCc6pmZm66xcGjW5T/p3VNLXgWNEuc0r+W16gpVnKUF7Q4SHDjP4UkPt6NnHldQYqpI2u7x3oneTOPNkCohwgQqL89k7xGwi+a8trHS+Lv7Rxn3cXNrNgz0dJja2hSmsRZRP2f27zcr4tqw0g928xgYYwcFfxI58w//VSAUi0wKnsMZ9RrGOQ0guqwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO/MuIihZp9NO7wxGyzSmD+EbcUHj+9UM6fvlfMOso8=;
 b=IpSg3sBxjZd7GoRaVEdLswK3zvKeV0oFH8qQXL1806ERadIHIlkFUgFAqqqOXopPFUAavqHAlQTAMLRRvUfBCRVRl0sDp2sD1Jpx4KnUctgnkX82yiwQlNRFuOX0rk5MfjIyz8Z8b/hVgVD4YYEOpMHqr8AWl7mDZxSwsE5SnHGDGCV6VM4bHZ03rIGK5i26u57Qmd26TKICoNEQzrxDqzZzCyUgPYaacGuu6UBGyxxrQfMCNaJMWbyYjGHK3S0MpkHbQLKRLV7eapWVWj2CSpdRZi6VnQtqDZQIY/e/U5AY9O1stt73N23ZtuIdLIes0ipG7bttF6dp6HkD550qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO/MuIihZp9NO7wxGyzSmD+EbcUHj+9UM6fvlfMOso8=;
 b=fxmQ8cv1y+m/TUxP0Vxyl05boik7gvf70SD4TEREemL5E1N4Ut9GUw8Zi/Yiu+voKdCl8vNRJWlqDGHDptf6MHEaXB7s7VaF3I0euUvkF8UE5HYoL6oT/+qOonpS/lT72qQ3Jen2ZLTL45oGZxt/aDKUeZ6NTrVqE8k21YJDqcpPlGJ38joTPGeLWWFTcgF6y1+EUyTf4WdGyNWvQymdo0mwPNzlsajbfxAOPTDqSz3XCEnSIFQlRJ7b54XCrA9gFIJ7M+AMB6RkDvE62aJIFrsuVFrmZpAOhHq9Tw889IaRhj3YiGlnd7qHGNjymFxp7WJIwyLFlJ9nhdB1OwUTTQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI0PR04MB12187.eurprd04.prod.outlook.com (2603:10a6:800:335::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:17:29 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:17:29 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Franz Schnyder <fra.schnyder@gmail.com>
CC: Franz Schnyder <franz.schnyder@toradex.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Francesco Dolcini <francesco@dolcini.it>,
	Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: Clear CLKREQ# override breaks functionality
Thread-Topic: Clear CLKREQ# override breaks functionality
Thread-Index: AQHcvPaW5M6/3a/UD0WxZ+IlTXMzwbXAdF3A
Date: Thu, 26 Mar 2026 08:17:29 +0000
Message-ID:
 <AS8PR04MB8833063C53B769C0ACB086958C56A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <jfefktil6ywvugvbxdplbvry6g5efka5g4bpr2dwhha2mtrkm5@6gkcmj2glvwo>
In-Reply-To: <jfefktil6ywvugvbxdplbvry6g5efka5g4bpr2dwhha2mtrkm5@6gkcmj2glvwo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|VI0PR04MB12187:EE_
x-ms-office365-filtering-correlation-id: 42aa0c9c-e669-4f01-fbad-08de8b101f27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 KuA+GecoLEcSlke+OvLQ1bWOWQ3IPIkCEcKMHPjnmTfGu3Md4NwMfzsztb6EBzSBE05l59+zusI2cDMCvQ4x9U+PpsacpeCKuRFbIoqIcBSAES4R1ex+thjm/FiY+MtDQICUo1A2ioRMwm0IlhElhZbX90zdL2CY7rU+kitQ6a7Jo3DfJWjF18BajQD5YDsKvVjseUu62+HrX2LmQpSl3+tmAS88kO5GjqDbjWFAkbq+xG1ziZptg9bLxjI5M6jVoc8K83Onj9zrImlUAkTX8nSPrSxftPGR6ARE+X/vfikYeHYbhYjgJ/Tk5Jh5oZSt+1tXkGm/OwEuzEKJIVMbMslZksTFpwrpse24eiZfTrK3jZFHL6Wol3kMmm74+xnXRUo9ek+pXE5gUD6eY+XlgSorAmjFEBFRJWw2yJNuDD87wpr7GY4H+1bea19elLQzkGylykf1GOxnICMUnSYdgUxS9TKmFWGH9fgxuHgIyUAc7jnQNfSPFb3Jvd3pVMBHuPwh4vi5wfUw3HscypnkJe91aAYSc3jHknH1VDUh+wjmCu1qQIKuk/givbeCVIVX1xBOgP7Uku96eWMKX8Lkmelcom//83dhopKl/9yK3aMt/0QSZdcMNlQCA5Bqj/faBqYXXb8LHeCNvdtKj2wLtU6fEh1TQpUbQBddS1S3dnDYFO36US/O9aZLWwhDkrvuGFyN7c43vtOUj//f701Owhu/ZRf9Dz7wMdcAmP/MMNqLyfbxP5U3gvw1ETC4cj1478XFpCKcnccXjxveCal9OOGFB9RMM7s3DXipeEYyLGw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VzlpR3pYTGprdHg3cE5UZStIL3BqZ01CZEMzbzdWYlE1clM0OUp0dURsNnRl?=
 =?gb2312?B?eHJxSTdEelJ4TDRzZS9EWXRCb044clJXcVk3U2NUV3VkQ3NWUjExSGNjSld5?=
 =?gb2312?B?ckV3ZER2V3hTVEV1OVk4VmlWbytkbVBjMnpsTUFCQ01aL2p1SmN4dk1OYnpI?=
 =?gb2312?B?ZXI4akh3QVhNT3NiQzdLUWhhYlBtQ000bHJyOEJuZXpNQ29QWFpwaGgvUFdt?=
 =?gb2312?B?K3VXSnBUdEQ3czVoOCtBVDhoQlBJMUhWaEpiQ1FoYmFaZWpiMklwT3RLY1Ir?=
 =?gb2312?B?bmNqQk9KSlludzJibms4SkgvYjIvV3VSY21JTFphaW5tWndRem9sNnIyVmVv?=
 =?gb2312?B?WXZHMGJVQ3BBVlpVZWJLWWh3ak9zRmdNRUs1TFB0dVExdUFUMFRkUnZnQkMy?=
 =?gb2312?B?aXlvSW1ZaUZLektpNVJSM2h1OVh4TlNibnZIN1BkZW8vQndrTk9XMndSc0Qx?=
 =?gb2312?B?Zk1KaGZwdUQ1amoxVFQ2TDZPbDlINFFxYURaN1N5ZmdmUmZKMUZYNHB5NHFk?=
 =?gb2312?B?RE9YUGNVTWw0cFZTbnR2cFNZaHdvSndueTkxY3hYY05TNXI1MVdMUDN0QnlS?=
 =?gb2312?B?MWR6Mmpac2VJZzNZZ2ZJQ2d4NkJiaW9zQlRQazIxM0dZSGNkVVY2RkdCSm9E?=
 =?gb2312?B?amhHR3FRZXVxd09nRm9VSlJITTkwQUY4ckFHUW83NzNCNWlMSm9EMmFVMlFl?=
 =?gb2312?B?OUVqSW9zaFkzdnB2clNzZ25WTFkvMmd1blFqK3V1bG9uNGtIamducnMwWUFD?=
 =?gb2312?B?NFYrSi9UZ2xaSjBoaWlXb3BoVDA0M00rUitvSmgzMnhVU1IyQ1lYeGFoajBK?=
 =?gb2312?B?SUtPK3NHdFBtN2RpR3BOa2kwc200VWhyY285dkNuMUZUMjBCT2FBS2Y3UEJX?=
 =?gb2312?B?Rjl3Q3pDNWtBa29IMnU2VXFuQjlVbHJORitVK2hiNGZvKzZTbFY5bjd6bmtL?=
 =?gb2312?B?UkRYZ0NxakU4VUxvUS9kazB6aTM1U0hDSkE2ZUhFdnZBSmNYbEtCZVFnMXhD?=
 =?gb2312?B?T2xtREFwSWh5YUluOXRQemRTVGdFdHQwS2grcWpkWjE0YnlKU0hTL05oUXBk?=
 =?gb2312?B?WGZRRFY4TE5vZE5naVcreElpNW5oQk9YMXd2NGpqOUx3S0JqelhrVFRDSTZP?=
 =?gb2312?B?OEF3Q2VCV0NPTHZEUnNLNStPV2NRdW0rb3djeTRjdnE4UHhUTW9oYkc5RG1v?=
 =?gb2312?B?aVI0S2xlcDdDczZ3WnNLTlpCN0RIYjRobVA3cis0WXBkQVdSeU1FTVNnaG9O?=
 =?gb2312?B?ZFEvekh5bGRHMEUxTmVRY2J2WHFZTUUwMStUbStibkp0RjhCU2E3cDdsWHdx?=
 =?gb2312?B?NnNpVW5sVFoxTHU4aW1BT0hKNWFBZVhBT0k4clJyejR5NTAvOWU0N1ZRKy9R?=
 =?gb2312?B?MDZrcnJyaURvTEc0NE53ZmRRTTlTWGpCL2xicHRjdEpQb2dRYXNKcVRvY3ZX?=
 =?gb2312?B?SWkwV05QZGF3aGRnbUZjTko1dDdONHMrWUYrc0F0dGwrRzgxcC8wUW1iR1BD?=
 =?gb2312?B?cDNobVdIbHI0NzBOSkxqVksrVkQveFlkU2JsRVZuQ1hud3BNWjJVWXlJbFRO?=
 =?gb2312?B?Ly9VNyswUEFGdmhHcHFlcU1zdHFUbnRCVmpoS2MvYjVZTHErNFdVQytERXpW?=
 =?gb2312?B?RDc4aEE5b0ovSStRVHlkOTJ3cm9GRDE0VFp6Mno4dGV5akF4eHZ2VlBlTVh0?=
 =?gb2312?B?MzJxZlFMbWtlYTN0VktuV3AwcSs5T1kxbFBRSFBKdFEzek9JOXhoTlZKYnVX?=
 =?gb2312?B?alYzVGxsVTFXekhUQVcvdmlIUE9PSmNzUzBNTkJJaEZaK0wxazVpb2dJZTRm?=
 =?gb2312?B?MHc2SmpQUzRaVW1LKzAyT2hsREh2aENkWkhYcndMSjNVeWlrUThpYndrWGQ5?=
 =?gb2312?B?Tnk0R0VVay9UdER1WVQ0aHVWa2pnSTJML0xpL1lTL2hYTU14NndLalZvOXNV?=
 =?gb2312?B?emNTbWg4eHJOYzhHY2VkcGh5TTRzSFgyWk1OTFlKSktwaDdOaDZlTmlzYWh4?=
 =?gb2312?B?OVZLOFk5MVE4UnBwVzRmYXB5cUJ3aWw0bTNBRmhOTEhlWkFNVk1kTFpBOVR1?=
 =?gb2312?B?dXdUZTNvNXBRVDl1R2Frc3hrOFJXaVJESGoxcW53L2V0Y002MEJKN1NValAr?=
 =?gb2312?B?TnhwQlQ0dWw0dEVybzlDL2JaaExJVzJ4WXVVK1IwTUt4NEJjQldEVlVRNkFz?=
 =?gb2312?B?bjhlKzdZNGNXRUkzSHpwYWxGQXMvT2RKMkgxTXdLTFNxTjdtdlJUeTVBZWV3?=
 =?gb2312?B?SVVSeDZRT3NTZnd0Z2phcXpjc0J2elVXQWhRUEVmQWxRL2c1b2UzeHl3Q3Yr?=
 =?gb2312?Q?vPtr34XsGEzUG0jGeg?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42aa0c9c-e669-4f01-fbad-08de8b101f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 08:17:29.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RaAO1eT6sWV+zqiSsuQhKmDXSa2yBB825MM1Ao3+96wGM/Fs48p1VhKs98q5Bu7QjpaB5y3ZcbNv4cUNDqsGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12187

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFueiBTY2hueWRlciA8ZnJh
LnNjaG55ZGVyQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNsTqM9TCMjbI1SAxNjowMA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW56IFNjaG55ZGVy
IDxmcmFuei5zY2hueWRlckB0b3JhZGV4LmNvbT47DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxp
bnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRnJhbmNlc2NvIERvbGNpbmkN
Cj4gPGZyYW5jZXNjb0Bkb2xjaW5pLml0PjsgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtl
cm5lbC5vcmc+OyBGcmFuaw0KPiBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogQ2xl
YXIgQ0xLUkVRIyBvdmVycmlkZSBicmVha3MgZnVuY3Rpb25hbGl0eQ0KPiANCj4gSGkgUmljaGFy
ZCwNCj4gDQo+IFdoaWxlIGludGVncmF0aW5nIHRoZSBgc3VwcG9ydHMtY2xrcmVxYCBEVCBwcm9w
ZXJ0eSBvbiBvdXIgaU1YOTUtYmFzZWQNCj4gU29NLCB3ZSBoYWQgZmFpbHVyZXMgaW4gb3VyIENJ
IG9uIG9uZSBvZiB0aGUgdHdvIE0uMiBQQ0llIHNsb3RzIG9uIG91cg0KPiBkZXZlbG9wbWVudCBi
b2FyZC4NCj4gVGhlIGZhaWxpbmcgc2xvdCB1c2VzIGEgY2FyZCB0aGF0IGRvZXMgbm90IGFkdmVy
dGlzZSBMMSBQTSBzdWJzdGF0ZXMuDQo+IFRoaXMgaXNzdWUgY29tZXMgZnJvbSBjb21taXQgYTE1
MmE5MGY1MzkwICgiUENJOiBpbXg2OiBDbGVhciBDTEtSRVEjDQo+IG92ZXJyaWRlIGlmICdzdXBw
b3J0cy1jbGtyZXEnIERUIHByb3BlcnR5IGlzIGF2YWlsYWJsZSIpLCB3aGljaCBjbGVhcnMgdGhl
DQo+IENMS1JFUSMgb3ZlcnJpZGUgYmFzZWQgb25seSBvbiB0aGUgRFQgcHJvcGVydHkuDQo+IA0K
PiBJdCBzZWVtcyB0aGF0IGNsZWFyaW5nIHRoZSBDTEtSRVEjIG92ZXJyaWRlIHNob3VsZCBoYXBw
ZW4gb25seSB3aGVuIHRoZQ0KPiBkcml2ZXIga25vd3MgdGhhdCB0aGUgZG93bnN0cmVhbSBkZXZp
Y2UgYWR2ZXJ0aXNlcyBMMSBQTSBTdWJzdGF0ZXMuDQo+IE90aGVyd2lzZSBDTEtSRVEjIHNob3Vs
ZCByZW1haW4gYXNzZXJ0ZWQgdG8ga2VlcCBjb21wYXRpYmlsaXR5IHdpdGggY2FyZHMNCj4gdGhh
dCBkbyBub3Qgc3VwcG9ydCBMMSBQTSBTdWJzdGF0ZXMuDQo+IA0KPiBUaG91Z2h0cz8NCkhpIEZy
YW56Og0KTm8sIENMS1JFUSMgaXMgbm90IGRlcGVuZGVudCBvbiBMMSBQTSBTdWJzdGF0ZXMgY2Fw
YWJpbGl0aWVzLg0KDQpBY2NvcmRpbmcgdG8gdGhlIFBDSSBFeHByZXNzIENhcmQgRWxlY3Ryb21l
Y2hhbmljYWwgU3BlY2lmaWNhdGlvbiByNi4wLA0KU2VjdGlvbiAyIChBdXhpbGlhcnkgU2lnbmFs
cyk6DQoNCiJDTEtSRVEjIChvcHRpb25hbCkgc2lnbmFsIGlzIGFuIG9wZW4gZHJhaW4sIGFjdGl2
ZSBsb3cgc2lnbmFsIHRoYXQgaXMgZHJpdmVuDQpsb3cgYnkgdGhlIGNhcmQgdG8gcmVxdWVzdCB0
aGF0IHRoZSBQQ0kgRXhwcmVzcyByZWZlcmVuY2UgY2xvY2sgYmUgYXZhaWxhYmxlDQooYWN0aXZl
IGNsb2NrIHN0YXRlKSB0byBhbGxvdyB0aGUgUENJIEV4cHJlc3MgaW50ZXJmYWNlIHRvIHNlbmQv
cmVjZWl2ZSBkYXRhLiINCg0KV2hlbiB0aGUgJ3N1cHBvcnRzLWNsa3JlcScgcHJvcGVydHkgaXMg
cHJlc2VudCwgaXQgaW5kaWNhdGVzIHRoYXQgdGhlIGVuZHBvaW50DQpkZXZpY2Ugc3VwcG9ydHMg
Q0xLUkVRIyBzaWduYWxpbmcgYW5kIHdpbGwgYWN0aXZlbHkgZHJpdmUgdGhlIHNpZ25hbCBsb3cg
d2hlbg0KaXQgbmVlZHMgdGhlIHJlZmVyZW5jZSBjbG9jay4NCg0KVGhlcmVmb3JlLCB0aGUgUkMg
KFJvb3QgQ29tcGxleCkgY29udHJvbGxlciBjYW4gc2FmZWx5IGNsZWFyIGFueSBDTEtSRVEjDQph
Y3RpdmUtbG93IG92ZXJyaWRlIHNldHRpbmdzLCBhbGxvd2luZyB0aGUgZW5kcG9pbnQgdG8gY29u
dHJvbCB0aGUgY2xvY2sNCnJlcXVlc3QgdGhyb3VnaCBwcm9wZXIgQ0xLUkVRIyBzaWduYWxpbmcu
DQoNCklmIHRoZSBlbmRwb2ludCBkZXZpY2VzIG9uIHlvdXIgcGxhdGZvcm0gY2FuJ3QgZHJpdmUg
dGhlIENMS1JFUSMgc2lnbmFsIHRvDQpsb3csIHJlbW92ZSAnc3VwcG9ydHMtY2xrcmVxJyBwcm9w
ZXJ0eSBmcm9tIHlvdXIgYm9hcmQncyBkZXZpY2UgdHJlZSBmaWxlLg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQo+IA0KPiBLaW5kIFJlZ2FyZHMNCj4gDQo+IEZyYW56DQo=
