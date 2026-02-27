Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C021772A;
	Fri, 27 Feb 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195815; cv=fail; b=CxUFZlAKhf4KLgK9Ag2NYy6yrgEXNOA3ETerHbUAFRuGvf15ne0YECtIUYrsb2ffnZHD4EKqQKZlMrgoFvgTs/R5IBtgURsaIo/0hQboIq2Zr26iN0t1MN8uu3kkeENYcTUJgS8KahHdW/Noq4phN8C3jf0fU32W/4NJ6JIjE/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195815; c=relaxed/simple;
	bh=E/g4uH8XSUXBR274BexcmNjTqLb1nVm7KRo1rqVyAjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajC5gPqrjqgmgemz7uHNjPxVRUehjsO9rZks4e6l4XvlTLgYvSlECfP7Y00k72M0Zgu9+xLEETG/5o/MiVkXZdFBXFxSAUA3FbOc4WNzKC5oAELpPZjdryIgJIH803UOFLoWocoCe3mHDQuvrEGAASFTjKQgtTHQ0AA0KIewVfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=btREOVi8; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="btREOVi8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIfHjc3e7LtObKglb1YE2hGEXNQK5eYy11RueRKicE+xyoUdUdzc1m13GEjpBIMP3eQgYebf1v+L9NMSEapsJgkoGW3wewrAS5FsBX0Uqtq/1/yWMp3dreOE3kLNbYfXe64q2jcivtBuX88m4moC5AE1pUIN7UXk7svoG7hK6j1gtcGcNZpuIh+JW+lbrgetkPhMf+2q3Hka22G1hqvDdoGm9oxekUVUPMjV3RkvTNc79Dp0DjFPXcPwQA++jJLkctUoKqRg4Y7TP+5Prr5ncosQc5KrU8kgR5DpNk4461gTo242n2EmiRIVfxErXCcrPPzh0LnJSDzoZPdzyjPpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/g4uH8XSUXBR274BexcmNjTqLb1nVm7KRo1rqVyAjY=;
 b=YTzmI7zXxXSiHXNA/P5Z5tOiLrDF3ipOorJjKeJWU1z0Dxg5ZtYIk9qRlJM+IKcRNMhamBRgY6Zs75f5C4HHM91rzYzIeeUACLwbviMMmQ0BGGN2pgOovibvSjYfX8lavH59q+fhCQC6C1LFfPqwtmfj9m6jYyi/rbeHZdLFrGsmPoF9JBwfEd2ZL4Ft/cSubaxsc8tBT4wn2hJkVNQGZ4QXzyhulphYzloMLKlR1VFJiecp3H0XF0pWaEBi/jahmHfmLEP8Pd7PziF2QmtUlra9c6lms/iOZ2XyzEqsDzszxIhHKyDweRo71nZtyM5gGkKTTwsX4Th2FxWad+GBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/g4uH8XSUXBR274BexcmNjTqLb1nVm7KRo1rqVyAjY=;
 b=btREOVi8ilW6yjCEUpATJ23TT3Z8M57czZXRQaE3JaUuAxSzyzeBvucFdiuWF4KlgArHrg0+YOtzjUyIV3L95/W2dfbWbwPQmcHuHQgwqSR8w0pgWFn/cV0y3qimO9o17dY2075acrKJmwxiDlF8xfOfiE0RCK8ZA5U2XetciiF7iXb8V9m6zfoyqjUszF6XWewHNHKPLj59SfOQgB0PTl4/aJWMh1pmFqqqE6rfs4iV/H15dSVD4m5/I3yRVmvVWwZE1NIA+Tzgis8ICJ13lBtSL9NQVGq809Xqvvwh12nydNF5+oaSpiXail5GS8F4jbwZo9i1TKzVuA5rvHY8XQ==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:36:50 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:36:50 +0000
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
Subject: Re: [PATCH v6 8/9] PCI: tegra194: Add core monitor clock support
Thread-Topic: [PATCH v6 8/9] PCI: tegra194: Add core monitor clock support
Thread-Index: AQHcpPTaijBNwDZI8ECPEUdBUYtYEbWWgZMA
Date: Fri, 27 Feb 2026 12:36:50 +0000
Message-ID: <c521b8f1-2fd1-4895-b5c4-abb0e598cc24@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-9-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-9-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 482e8b11-00f1-4d2c-6261-08de75fce14d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 BTtCcN779OZF9DXxI59aAvMXTSRTmDeCeOIjjexNt9JR7jKCvahFrCVf3rc6scC4jviKHu+xUJSGiNEGhCnQ7npI0qL8NR8KxEE/iS30xy8Kgt/HIxJZet54dUU+2Kz+DAoxDBrHNy2VJ7VnMZRij+7piSzyu+/cCFICaL5JEpHqIVwv0pod9kSdra5BOTOjfE11oLYVOOJsUm/1IIZehLI2FwKb5ENCIt6olxT+/QrFp92HqtwbMEwDDmull+qkLzKX0aXanK/uOBFjEgNg7jd+ebdUSGdN12iLZRGg4uKQ/89oKx79VcDf3y4xIDyYh3H3uuw6qNYTetEk1rRItRelhpbAxvAvwTkNHOceZn2rl0IC7P/n9CJWN+T2xIJAgD+ZgRVY2ZqxHwmYdutPDU5caLRCe/2m0oy/f37piAxV5EH3/0m/IHbQUAjoZUt27YH6rmG/XfzhSotiwuXqANcdi+KM6xq2RFiKNh9NqesNqefePXoHOUxmMq7fRnFjwveMKKVsHP6AcctXeaQw8xLqg9e84RyWw+11cnxYNxgYjBe/WJvbvHhWvwRqCm71nQ6uhGcZack6tJLBKCluUH/gcC0Z2cEzRprFihXpSMLzg0cqTpAZs3PS7d86wVs04gnorHpR3FhoCYJc+YM5VFkKSc6xeWVEpmAXkN3BuO++T3AVzag4aDFq6U70Y3dIBfvFB3+zzjYx/KwfRMKA3v3kzCSG2ZANDEPZxKWAFwrA/ee2eQYf9aSNLOxMi56TUnJh0Lod6xEcfrLVF/USa4WXdk7ZdaB8RFjZarRQD2EN52fcB2MN4U3o7v8Du6fy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVROUUhvb2NjUklCVUhTNjRYdGJXWDBjMzBLc29kL0N6MkN5UFNQa3oxR3RI?=
 =?utf-8?B?R0t2M3ZJendaL210VEJHVUl4TklQbW5FcDVYVEg2eTVJTDVMeG1aOXJCMGph?=
 =?utf-8?B?S1U4aFFwWTFZdCtBT1ViOFc0VnFqa1pEQkkvc1Eyb0k5clJmV21WeUlUQkRm?=
 =?utf-8?B?TUhDdG8xN0tobVZ2NitiaWpvL2p4RFhxaXhlN1VFWW9BT21DR3ZXdmZhc25W?=
 =?utf-8?B?OCtpcVF1azlLUHh1aUt0V1pmVk03Z0dwOFdocTFpczdBZmpFbUppalVyUTVY?=
 =?utf-8?B?cU1lczlYS0ltd3E5SEZHVjJVMUJUNHZ6NVBvODRNa1U5cEVwOENFUStMaUJV?=
 =?utf-8?B?ZURtK25PUmUxdE1aNWprbEV1NzdJODBZY3ZRU2J3UWlhSWc0bWtrRmVDL25a?=
 =?utf-8?B?L0xMVCtLeTJ5MUl1OFdYaGl1aVlsZHdNUUZsNjk5Z0xIVmhzcXJmamlJRlIw?=
 =?utf-8?B?U1E2K3RXQUhQV3B5a1FBTDVqOXRDRjRsNEJGb21FTGd0S2lwTmhpREhPeXZW?=
 =?utf-8?B?Tnh3VzY4dzdhbjFBVEU1REFhOWRGVTQwSDNOdTRlVS90UzVISncyTUJMM2NW?=
 =?utf-8?B?dkdyUWJNVVRDTVZaV2o5L21QaGhlSDUrRFZ6RU4vM0pONSs1UmFwZ2dHb1lH?=
 =?utf-8?B?Qk5DR3hnVDgxRVEyWEF4dUl4Qm1zYllELzVueitwSUxnU1RvR3NWTjF4OERy?=
 =?utf-8?B?SWFjWFFrR3g2VDlaUlJZSVpIVlNsUU90R08raGYrWm1NRjRuWkhSZEpQTm1i?=
 =?utf-8?B?OXBJV21WdFhNc0Q4RnJwYmdMTmZKWHhBK3M0d2g2RFV3UGpXSER6OXhrMHIv?=
 =?utf-8?B?WThaQnF3SE9VUUVRcDdOaG1ueFhnbXBCSWpXUXpBM2QyckFWdllvdXkrSzgx?=
 =?utf-8?B?RXBzVlhwQ3NVQVQ3a0MxMmxCWEJ1TXFHMVJwL09HakZKVUNjN01GdVNhT0VF?=
 =?utf-8?B?RVZkZnNlTW5wQUt5am9iUjNvUEhFbk9xMjYvNVhWdUN4WitWWGNkV1NTeWI5?=
 =?utf-8?B?eUQ3bUZPSUZiNXY0c0F2Mk16YkIyTW5zMHpZWjN3ZVVlQlNVNnJGR1N0UFJX?=
 =?utf-8?B?MnJ3R1dremlRQmVaUE9pZU5ScU9SVHAxZ2JQWVJETDhMRGRMQ0MwQTJ3Ulpx?=
 =?utf-8?B?VWxRWkxLYnNTb2JCVGJQM2tWc21tTmREd3RwOUlFSmgweU5UeWpLcnhLZmZF?=
 =?utf-8?B?ZnBjUUpBd2RCK3cxVEo1UXhqZ09WYVlEQlpNVmdQWXRjNmtVdFJGUmpGRmNV?=
 =?utf-8?B?MEpsSlpDQWR2aGpjcWtCMFJMUjFBR0g2c3lTRzdZUW95OXJyeS8xUVp1S2g3?=
 =?utf-8?B?MkNrWEtvU2xPUXF6OWZwallmc0hlTkVTVTRINFlDdVg1bHp5MFVqcUlXcXhK?=
 =?utf-8?B?U1FBZDZKK0V6cCtiN21RbTdoQy9vWFpmQzNzRGpuVG00UEVnQnZ6MmttWjlK?=
 =?utf-8?B?QmowbTk2N1kyeUZ6U1A5Y1BCY3RqOXpnZDJsTHJJTHd4MUFia0pZWCt1M2dS?=
 =?utf-8?B?eHdyVDVVd0RYZXNoNGd4Q2h4MTNmZ3dXWTlZMndsaXRHNkFMSVc4Wi85RUs4?=
 =?utf-8?B?cVVBZnRsRitxdk5BK1J3RUR2QUhEQ3luaUpvdEpIZ2dDZDl3OUJjeXg5UURq?=
 =?utf-8?B?NGRaNFpXb3UrSXRvbGtFai8raUgzVjBIVmJVWDB1SW04OC9qYWJlbGhFaklj?=
 =?utf-8?B?MzhWbk1JWDNtUEh5WWt0VlA4ZFhnV0lJOG9HbExhSFRHbFVydFJWalpneUdD?=
 =?utf-8?B?c09WVVZYTVZiSmlTN2U3S0RvWTFkM2o3b2xoS0tiRE94eFZmSWh2akQyd1pU?=
 =?utf-8?B?bjNoOGF3RXM4aUdzSWo0Mmh4UVJLb3dlSXZVUXpkLzdSZjM2TmptTWc3WlBl?=
 =?utf-8?B?UTFZVHVpa2s2R2pQdHJPQ0RtUlJVUjc4bEtqb2J2TXhUVG5pekR2QTlJOFl4?=
 =?utf-8?B?aEtQMGcrV1dQVXhBTEpyc0RaQll4OFZJMFczM3J1MC9sTG51bkxvZ3pXSXFh?=
 =?utf-8?B?dnFBY3diazZVV2F2VEdDcW1LZFFvSEF5YWJ6ZnJLdWdtWE1VRWZoRkYrUWhJ?=
 =?utf-8?B?dTYwWVI2MlRLZVNkUVNVUmdObXVncWtzT3U0bS84dVJhczNBTXZ5SW5DUGJV?=
 =?utf-8?B?NGpERTR0ZTZLbkt4ZDlmVmEyUEowTGwxVlBjNzl5eFJ1YnRsZmFIb0FkcHdZ?=
 =?utf-8?B?SnFScXIzVElqNno2eDc1Zlh3dzJ5K2QvWTdHbk9QWGJtUU91OFlIVmRUcjlh?=
 =?utf-8?B?SytjL3FEa01VdjBldWM1ZHoxUlNDNStQV2Q2WUdPVVhHQ3d4cDNDaXZwNVpj?=
 =?utf-8?B?TmQ1c2w1akpHRFR1NUMzMlBtYWwwSG52c3ZQQzBDM3p0QU9FNWNGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54DF62A9C9CCFD46BFE7D7A4B1D149E0@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 482e8b11-00f1-4d2c-6261-08de75fce14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:50.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRTwIok9w2845ncQgOcq8BUg8WsKItgyLGJYP6sQut049m5NTBSSFopB7jt3WnbZhC39YvWFQmkIvCF8ti/MGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBUZWdyYSBzdXBwb3J0cyBQQ0ll
IGNvcmUgY2xvY2sgbW9uaXRvcmluZyBmb3IgYW55IHJhdGUgY2hhbmdlcyB0aGF0IG1heSBiZQ0K
PiBoYXBwZW5pbmcgYmVjYXVzZSBvZiB0aGUgbGluayBzcGVlZCBjaGFuZ2VzLiBUaGlzIGlzIHVz
ZWZ1bCBpbiB0cmFja2luZw0KPiBhbnkgY2hhbmdlcyBpbiB0aGUgY29yZSBjbG9jayB0aGF0IGFy
ZSBub3QgaW5pdGlhdGVkIGJ5IHRoZSBzb2Z0d2FyZS4gVGhpcw0KPiBwYXRjaCBhZGRzIHN1cHBv
cnQgdG8gcGFyc2UgdGhlIG1vbml0b3IgY2xvY2sgaW5mbyBmcm9tIGRldmljZS10cmVlIGFuZA0K
PiBlbmFibGUgaXQgaWYgcHJlc2VudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNhZ2Fy
IDx2aWR5YXNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRpcmVk
ZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2OiBO
b25lDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwg
MTggKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVn
cmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBp
bmRleCA5NjU4MWZjZDg2OTMuLjgyZTllZjE3MmRlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiBAQCAtMjUzLDYgKzI1Myw3IEBAIHN0cnVj
dCB0ZWdyYV9wY2llX2R3IHsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKmF0dV9kbWFfcmVzOw0KPiAg
CXZvaWQgX19pb21lbSAqYXBwbF9iYXNlOw0KPiAgCXN0cnVjdCBjbGsgKmNvcmVfY2xrOw0KPiAr
CXN0cnVjdCBjbGsgKmNvcmVfY2xrX207DQo+ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wgKmNvcmVf
YXBiX3JzdDsNCj4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqY29yZV9yc3Q7DQo+ICAJc3RydWN0
IGR3X3BjaWUgcGNpOw0KPiBAQCAtOTQ5LDYgKzk1MCw4IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNp
ZV9kd19ob3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQ0KPiAgCX0NCj4gIA0KPiAgCWNs
a19zZXRfcmF0ZShwY2llLT5jb3JlX2NsaywgR0VONF9DT1JFX0NMS19GUkVRKTsNCj4gKwlpZiAo
Y2xrX3ByZXBhcmVfZW5hYmxlKHBjaWUtPmNvcmVfY2xrX20pKQ0KPiArCQlkZXZfZXJyKHBjaS0+
ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjb3JlIG1vbml0b3IgY2xvY2tcbiIpOw0KPiAgDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IEBAIC0xMDIxLDYgKzEwMjQsMTIgQEAgc3RhdGljIGludCB0ZWdy
YV9wY2llX2R3X3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gIAkJdmFsICY9IH5Q
Q0lfRExGX0VYQ0hBTkdFX0VOQUJMRTsNCj4gIAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgb2Zm
c2V0ICsgUENJX0RMRl9DQVAsIHZhbCk7DQo+ICANCj4gKwkJLyoNCj4gKwkJICogY29yZV9jbGtf
bSBpcyBlbmFibGVkIGFzIHBhcnQgb2YgaG9zdF9pbml0IGNhbGxiYWNrIGluDQo+ICsJCSAqIGR3
X3BjaWVfaG9zdF9pbml0KCkuIERpc2FibGUgdGhlIGNsb2NrIHNpbmNlIGJlbG93DQo+ICsJCSAq
IHRlZ3JhX3BjaWVfZHdfaG9zdF9pbml0KCkgd2lsbCBlbmFibGUgaXQgYWdhaW4uDQo+ICsJCSAq
Lw0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUocGNpZS0+Y29yZV9jbGtfbSk7DQo+ICAJCXRl
Z3JhX3BjaWVfZHdfaG9zdF9pbml0KHBwKTsNCj4gIAkJZHdfcGNpZV9zZXR1cF9yYyhwcCk7DQo+
ICANCj4gQEAgLTE2MTMsNiArMTYyMiw3IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX3BjaWVfZHdfcG1l
X3R1cm5vZmYoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+ICANCj4gIHN0YXRpYyB2b2lk
IHRlZ3JhX3BjaWVfZGVpbml0X2NvbnRyb2xsZXIoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUp
DQo+ICB7DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBjaWUtPmNvcmVfY2xrX20pOw0KPiAg
CWR3X3BjaWVfaG9zdF9kZWluaXQoJnBjaWUtPnBjaS5wcCk7DQo+ICAJdGVncmFfcGNpZV9kd19w
bWVfdHVybm9mZihwY2llKTsNCj4gIAl0ZWdyYV9wY2llX3VuY29uZmlnX2NvbnRyb2xsZXIocGNp
ZSk7DQo+IEBAIC0yMTYwLDYgKzIxNzAsMTMgQEAgc3RhdGljIGludCB0ZWdyYV9wY2llX2R3X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiBQVFJfRVJSKHBj
aWUtPmNvcmVfY2xrKTsNCj4gIAl9DQo+ICANCj4gKwlwY2llLT5jb3JlX2Nsa19tID0gZGV2bV9j
bGtfZ2V0X29wdGlvbmFsKGRldiwgImNvcmVfbSIpOw0KPiArCWlmIChJU19FUlIocGNpZS0+Y29y
ZV9jbGtfbSkpIHsNCj4gKwkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IG1vbml0b3IgY2xv
Y2s6ICVsZFxuIiwNCj4gKwkJCVBUUl9FUlIocGNpZS0+Y29yZV9jbGtfbSkpOw0KPiArCQlyZXR1
cm4gUFRSX0VSUihwY2llLT5jb3JlX2Nsa19tKTsNCj4gKwl9DQo+ICsNCj4gIAlwY2llLT5hcHBs
X3JlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0s
DQo+ICAJCQkJCQkgICAgICAiYXBwbCIpOw0KPiAgCWlmICghcGNpZS0+YXBwbF9yZXMpIHsNCj4g
QEAgLTIzNTYsNiArMjM3Myw3IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19zdXNwZW5kX25v
aXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlpZiAoIXBjaWUtPmxpbmtfc3RhdGUpDQo+ICAJ
CXJldHVybiAwOw0KPiAgDQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBjaWUtPmNvcmVfY2xr
X20pOw0KPiAgCXRlZ3JhX3BjaWVfZHdfcG1lX3R1cm5vZmYocGNpZSk7DQo+ICAJdGVncmFfcGNp
ZV91bmNvbmZpZ19jb250cm9sbGVyKHBjaWUpOw0KPiAgDQoNClJldmlld2VkLWJ5OiBWaWR5YSBT
YWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
