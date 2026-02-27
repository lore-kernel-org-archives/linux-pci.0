Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6D3806DD;
	Fri, 27 Feb 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195772; cv=fail; b=rTBJ+jGq1+ft86oN2UAG7AaVZXk4e7HyAUO32LqaDnNFWRXNvheEA/aIFu0nasfwkTnVq0AIcb4P4BW4IuKvHG8xwbW29ktP2VYxnM7oB0xt4dzxWHdINGW5+wH5mjhY6AuNiKjF0PCXmtOhRSFsO5kDnbhmTljDo7iumqBRjck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195772; c=relaxed/simple;
	bh=kevwzn8JWQl3xLvohQT8Gi3l6UrFmuRgVbnzbrfvz2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gs+skUKOXXEv4FCKw2w5BM7L7IG2iaiYgInvkS+4ACS37HJqz2rPhd+oJVgcj4+cAyW5Ta3uO60uHR88w1C58h/YqMN6pO0xcbnqKe6ObRDToMJWa4A6pB9hzmfiN9wuZuGCT8Qs9d9D8XrKbhlSSNJxvov7gWOnOS0ALO3EPRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJiI3erM; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJiI3erM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3K3zQZN0hYe/3uplWfgrbZgU6tHWrcM3gOkakxxGjgxK+9QEBRjva+iqrpQ7jfxMRV9YGcFojzAinBBdnNw2SwCv6aDmhVBTruSsDt3uzMgx6fnCwa1tofoTrp/bpFY4eU5KNTEueupiey5TlyWLDP3QniugF+dBd/6v2i9hxNfW/1CAo7Xpbcda1f89rFgbnOuxUWjA6KD22yZnbyTFfwFN8wnWNfGyXIpJXhyInRNzvNsCF4YBefZIOFE9HpZSWqk+9amN6Cw3pAtKgOy3W7XskiRyE3YGGRUXe3toZFbt9BnPbtUvWy0YipPKe2UFIPyNk4vV23AL8a2AvoVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kevwzn8JWQl3xLvohQT8Gi3l6UrFmuRgVbnzbrfvz2Q=;
 b=tRbfAVvJL/dPbsJuO3yTa9EwTJex4iP0zxaJSw4JdcjVaf0GHIitPyy12PmYAhU2iGhksnhQI5LX9CfJvOjAYJoRo4ijWsqNJVKljZwUCEUmqqUiOMgFT/tEADoX4IEFTFYNCyL76cMCmsFnHV1eItu0Qxd3UHuLXp+hdXrveVXM2jgljzqQmQyhagm20Nr7CVnA4kMtLxCr3qFMLIzvHEIWE1Ptme1q2MVUYB1Z0YUH4xLMFwMOMsck88J76Mc8ZhUnHpspZgsNcZLXG4puuoegy4HoOjfvAtaZO8kTJp5vedet+BUOQMhQiv5TNIPW5c06AXhx9mdN6qoGpeIAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kevwzn8JWQl3xLvohQT8Gi3l6UrFmuRgVbnzbrfvz2Q=;
 b=RJiI3erMgeirMYDIvXOZ5oqy5CZKAGXFbwj23ksQtkE9WGoyS4r00porc53n3Qo4i9S+wiFaRzrUqgScmR9XMRWLqxacXcU+jHTeFnaTHaWJcj8XEaiu/XNPRXMhzFz/IQXHQpirCSwedx4fiE6LgnfN1XKjSItKYAkCmVgr5iF0+KQdMSnQO0Ln+FoZfSLa16dv/HMVadB9qFenQyB1xpW08xjy/BIWqnF/Mfx3ujVWUr2SXGmIMhcw+MZxbv7EUVKrPePn5f8YpsCjRql4hmtW8RyezqCBjrIsb/5l0M966yI0QOtGC1IfHf63BN3u8+uAhCGIfws3xmr3PcduGQ==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:36:05 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:36:05 +0000
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
Subject: Re: [PATCH v6 4/9] PCI: tegra194: Enable DMA interrupt
Thread-Topic: [PATCH v6 4/9] PCI: tegra194: Enable DMA interrupt
Thread-Index: AQHcpPTKZEl3qgZih0y1y//OeD2B1bWWgVwA
Date: Fri, 27 Feb 2026 12:36:05 +0000
Message-ID: <f369ddf0-ed66-452c-a811-3a3bb96b18d2@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-5-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-5-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 444c4f1a-1d7f-4921-35da-08de75fcc677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 frZtbZiiPwNM/4ZomJFf2Nirox+0u0kXICt15ASnmpTYS/mYHv9sf38FIoI8xM7JCaYGfYYcD49dWkwZ8EQ8iBJmiOIltX6HMyTcryhCf2sDz7IeVH9/hPZzRCr3a5jHSgTkqPUbS8sqnKQ3O7UxKcHrZjhFpeeRj/nFUCUI6CP/IIVuyt+PYPWefz8cx9WeQfX9SigJHoiYlXrsy7RhkeF9K4NgjADcJGgXzd1JrhXSnlLwUC5d9Yh14wpdN5eQCImtOicGGBm4pWKoEUAW9XN14HFgDOor9hsyaszNHLtnnEur96/SEMm8yvDmGiVphCmjbLD49slihnvjrazCxNPF7z49iSQ3TBHn3WhWf1dVkBMcqxBKtOWkN0/zHvevC+81KhsOm2ZzV4EL4N8ak8WQ5s7aDeiz9gujSCTy0R9LLGxlOi6KBeuHUmxsgNyO0WIUx2keOby3u4AUmtOh+JP/xTwzlb1LstaLRKBe4Rlj9Vhv13X6v5R+WPLyTs2SPlofxMM1WlbbJe6JDw7IqHUczS6EBLpGSjjb0j8E2ZH02VV7KS6xKFzxfyvFPbF+OeIbo4ekoAQYRQoNP1t2ZYtZB6vmsa94bZ2RK0G3RpFDfYUlytQozNC9frmqD6InWz8GHYGxQdwb93XTo0JNUjzEUJyAPXW3adxYhrEEueu6J8qz/iRS1ztQQQtVosfMmThmnPrgbg+h/GaroTg4h1X5vxLCufpAAlznhF2D5bvJzqio+TbyQ0zK0tLxLYV1bvUUam8ctrPctobcjlSeNXsSIO2iNWRaWeQGIKC8J7GkQ+Xt0cwo0d3vZ3XO4nKb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnhJbmpCemZ4c3d4VUhLMHZxenFPbldjRkhBbTMyY3NUMjd6dkhhTVBFMllv?=
 =?utf-8?B?NW5NbzdpdE5NbUl5TzFEdGJIRVByYXd6b1QvQzVzM3JoWkJ2Z2xaZCs5K05S?=
 =?utf-8?B?Mkt2akNrRTZ2Ym5tSVB0cmtuZk1QNk8rUDBBOHFDTXpZMncyVUhZOHNtblJO?=
 =?utf-8?B?aUM3Vm1vUU9JOEhCV09ZV1FTSG53b3A2RmRvKyt0QlFqQ0VnVkNlWnlyUmJ4?=
 =?utf-8?B?OVpWSWd3bVFxanBzR01jSnZidkZLSkhoUW00R2JkTFc5SVE3ZDNBUVZzTkVz?=
 =?utf-8?B?cEZjckdRanRZM2kySmpOc212ZkN3YUdnS3U5SG9NZUVVM0lNOVlHRTVCOStn?=
 =?utf-8?B?UCtJL0ltcExyMW55OWRkSTJWVVpVU202NExTWW51SnJ6R0MvRW0wZmE3eFdH?=
 =?utf-8?B?YVRqVVFoQk15RGU3NmNac1ZuV2NMTHdabGZaVlRXYWNvT1g1eWlzbXR1TGNh?=
 =?utf-8?B?R1VwSXkxcEcvaVZWaytxNk9NMTJpSW1UOW5MSmlyUHBvRlVWNG5jRmdTS0FL?=
 =?utf-8?B?MVlZWXdlUVk4bUhGMXNySnM1Ny9WbWV6N3ZDKzdKUzlQWlZYcU5qSktZVGNw?=
 =?utf-8?B?TmZpc3cwWHBnbE40WTBqbWVhMlhQWHVZQXhZdTB6NWJLZUdBOTd1YU1oZEZi?=
 =?utf-8?B?MUUycnhTT0N0TllhRVh4S0R1cVc0RXprN0lJdklDa0NCT25OL0ZHVSt2ZXNW?=
 =?utf-8?B?citmeEx1MjA4a0VkUEM2WW5NYmdPVythbDNpaDF6TDRiaEdmay93d2dRZEhI?=
 =?utf-8?B?SVBBMXJPaExDRHhUM2lnTTVTdytBOTVEVVpMQWtkeElpWUR6UFI2UmVhc1dE?=
 =?utf-8?B?blVIUjhlZlVxVkNZY25JYjJVNEZZUEdMNHN3SWxCODJRZnFPcktnTW1XK1FW?=
 =?utf-8?B?N1ZZbWlJMFh2ajJpS21MZDA4YnFBS0lNM1BFT0FjeWtmanZzNDBLZDFBRkkx?=
 =?utf-8?B?LzZhL3VQc2lpZG95bGc3UmVpM1VzWi8yZ1hoTC9saG5wNGxBbXp0Uy84dnp5?=
 =?utf-8?B?b25vS3BSWVJQei9NaEEwUDBJelhCWm0xMUxOYVZzNDcycm1paUJob3BOK0ND?=
 =?utf-8?B?di9Hc1dzcTRheUV4a0hnTUthWHk0VC9TRTg3VFNoUzlvMHJFY0NlVEg0ZUFG?=
 =?utf-8?B?SExQb0RiYngxOEw3QTBZeGZFSnh6NnphdW9DOWlFQXVPSHBtWElKWC9ZOW1k?=
 =?utf-8?B?VS9MVFNDMkZ2RVBkRmplcWZtejVKL21BYTJHNk1XaW9TRDN1TUxtd3ZnK29E?=
 =?utf-8?B?V2RYL0kyaEdWQ1dQdHpOQm10R0pzbm1yN1pHWjlLdmFMUjN4cTg3ak9JUjVO?=
 =?utf-8?B?R0lFYXhOd0ZTTjJSa3hjWkJId0RLekRqa2h6SjMvVHRmZmpRWlpOMSsyeFFN?=
 =?utf-8?B?dFJqQTVBUHI5aitxelVWUDNBNTIyMW9yODV3Vzh6OS9jZm1jMStkQURFK3FO?=
 =?utf-8?B?Q3pzSldTdnozTmd3OWFQVzU4eFI1ODdGVU1tVmo3cy9GOXEwUUNCR2NkVzYy?=
 =?utf-8?B?QmhLcFVrNHQyWU9OVlJGeHdsM294MGVzUlhCT1NtY21oRFAxZDhwRWlBcXU5?=
 =?utf-8?B?b1RhVHdwYmo4dFh4cGFuNVNSOVFjWHRsTWVaaWs2ODhBOVBXQkNPTUlENzh0?=
 =?utf-8?B?aEZvNUl0TlVVYlpJaXdveHdxVEVKYmJ2SlBGcGF0WjR4WHRFanMzUG4yMUZ3?=
 =?utf-8?B?eFkrQ1QycFV4QTVZMWoyZWtiOVhZckdja0RiT2V3Y0lQR2JmYWJ2eEsvN0N2?=
 =?utf-8?B?RU1UblVNQzNEcUdHZWMra1FVcnNxb0ZHQnZ1Zi9EeEx6Mk05WEZMTkN1cGdY?=
 =?utf-8?B?UjJHYzhKRVRDWnRZSk95VTczRVUzSndmbFdtdExXOHdjejhuenk5aWhSM012?=
 =?utf-8?B?aHJMZFNtVHg1aFhsTVlHaVR3TngxanV3YTNXdmRJR3k4dFJNNkJGMVRGQW5i?=
 =?utf-8?B?aUJlQVZJemxDZUVpbGh0QjdGODNreWQ2WnlnUWtaY1F4VkZCUTlYVklPQTlr?=
 =?utf-8?B?SEhLdjY5NmUyMHoreFRaT05VRTBVQ2hyUGZXNUZWaTI1bU1nQytTOWlYZ3JC?=
 =?utf-8?B?TlFMT1hVQlA3emtZNnNxTW16bzJXeFcxVjE0emtaQzRybkZSVzhrdC9MNnhp?=
 =?utf-8?B?bGY5ODR2bWY4MUU4aldKZHpXeDduRGUxU09BOE55eHBFNzFzTjdMTVB3Vk9v?=
 =?utf-8?B?TFNjN2pWOFl6V1pFMkZrKzZuSFdGci9XeGdoYnpuWEFlRlJWbngweHJwT1N3?=
 =?utf-8?B?R2ZVYXZnd3drTC8wWjQ0RCszQllWbTBzcXEwblI3bzFJZU12L3ZMZUVOVHhi?=
 =?utf-8?B?ZnR6TmJCdU5jcGxCSDRXYXVGVXNUVUxna20rLzBuTUYyL3VNdnNHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70937FB19D677D478CB487DAD38ECB93@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 444c4f1a-1d7f-4921-35da-08de75fcc677
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:05.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inR2gmwRrOV57GycIvytReUhYYbSK4Lz3v/cCNvaO1AH9zDlb2xDSDP+vvSxmBj9eI+/ghcL6IOwDyPxINwn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBFbmFibGUgRE1BIGludGVycnVw
dCB0byBzdXBwb3J0IFRlZ3JhIFBDSWUgRE1BIGluIGJvdGggUm9vdCBwb3J0IGFuZA0KPiBFbmRw
b2ludCBtb2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZp
ZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRpcmVkZHkgPG1tYWRkaXJl
ZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2OiBOb25lDQo+IA0KPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwgMTQgKysrKysrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IGluZGV4IGFlZWM1ZjhiOTg0
Mi4uMTEwZjJhZGI3NGQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLXRlZ3JhMTk0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS10ZWdyYTE5NC5jDQo+IEBAIC05MSw2ICs5MSw3IEBADQo+ICAjZGVmaW5lIEFQUExfSU5UUl9F
Tl9MMV84XzAJCQkweDQ0DQo+ICAjZGVmaW5lIEFQUExfSU5UUl9FTl9MMV84X0JXX01HVF9JTlRf
RU4JCUJJVCgyKQ0KPiAgI2RlZmluZSBBUFBMX0lOVFJfRU5fTDFfOF9BVVRPX0JXX0lOVF9FTglC
SVQoMykNCj4gKyNkZWZpbmUgQVBQTF9JTlRSX0VOX0wxXzhfRURNQV9JTlRfRU4JCUJJVCg2KQ0K
PiAgI2RlZmluZSBBUFBMX0lOVFJfRU5fTDFfOF9JTlRYX0VOCQlCSVQoMTEpDQo+ICAjZGVmaW5l
IEFQUExfSU5UUl9FTl9MMV84X0FFUl9JTlRfRU4JCUJJVCgxNSkNCj4gIA0KPiBAQCAtNTQ3LDYg
KzU0OCwxMyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGVncmFfcGNpZV9lcF9oYXJkX2lycShpbnQg
aXJxLCB2b2lkICphcmcpDQo+ICAJCXNwdXJpb3VzID0gMDsNCj4gIAl9DQo+ICANCj4gKwlpZiAo
c3RhdHVzX2wwICYgQVBQTF9JTlRSX1NUQVRVU19MMF9JTlRfSU5UKSB7DQo+ICsJCXN0YXR1c19s
MSA9IGFwcGxfcmVhZGwocGNpZSwgQVBQTF9JTlRSX1NUQVRVU19MMV84XzApOw0KPiArCQkvKiBJ
bnRlcnJ1cHQgaXMgaGFuZGxlZCBieSBkbWEgZHJpdmVyLCBkb24ndCB0cmVhdCBpdCBhcyBzcHVy
aW91cyAqLw0KPiArCQlpZiAoc3RhdHVzX2wxICYgQVBQTF9JTlRSX1NUQVRVU19MMV84XzBfRURN
QV9JTlRfTUFTSykNCj4gKwkJCXNwdXJpb3VzID0gMDsNCj4gKwl9DQo+ICsNCj4gIAlpZiAoc3B1
cmlvdXMpIHsNCj4gIAkJZGV2X3dhcm4ocGNpZS0+ZGV2LCAiUmFuZG9tIGludGVycnVwdCAoU1RB
VFVTID0gMHglMDhYKVxuIiwNCj4gIAkJCSBzdGF0dXNfbDApOw0KPiBAQCAtNzY2LDYgKzc3NCw3
IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX3BjaWVfZW5hYmxlX2ludHhfaW50ZXJydXB0cyhzdHJ1Y3Qg
ZHdfcGNpZV9ycCAqcHApDQo+ICAJdmFsIHw9IEFQUExfSU5UUl9FTl9MMV84X0lOVFhfRU47DQo+
ICAJdmFsIHw9IEFQUExfSU5UUl9FTl9MMV84X0FVVE9fQldfSU5UX0VOOw0KPiAgCXZhbCB8PSBB
UFBMX0lOVFJfRU5fTDFfOF9CV19NR1RfSU5UX0VOOw0KPiArCXZhbCB8PSBBUFBMX0lOVFJfRU5f
TDFfOF9FRE1BX0lOVF9FTjsNCj4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJRUFFUikpDQo+
ICAJCXZhbCB8PSBBUFBMX0lOVFJfRU5fTDFfOF9BRVJfSU5UX0VOOw0KPiAgCWFwcGxfd3JpdGVs
KHBjaWUsIHZhbCwgQVBQTF9JTlRSX0VOX0wxXzhfMCk7DQo+IEBAIC0xNzg5LDYgKzE3OTgsNyBA
QCBzdGF0aWMgdm9pZCBwZXhfZXBfZXZlbnRfcGV4X3JzdF9kZWFzc2VydChzdHJ1Y3QgdGVncmFf
cGNpZV9kdyAqcGNpZSkNCj4gIAl2YWwgfD0gQVBQTF9JTlRSX0VOX0wwXzBfU1lTX0lOVFJfRU47
DQo+ICAJdmFsIHw9IEFQUExfSU5UUl9FTl9MMF8wX0xJTktfU1RBVEVfSU5UX0VOOw0KPiAgCXZh
bCB8PSBBUFBMX0lOVFJfRU5fTDBfMF9QQ0lfQ01EX0VOX0lOVF9FTjsNCj4gKwl2YWwgfD0gQVBQ
TF9JTlRSX0VOX0wwXzBfSU5UX0lOVF9FTjsNCj4gIAlhcHBsX3dyaXRlbChwY2llLCB2YWwsIEFQ
UExfSU5UUl9FTl9MMF8wKTsNCj4gIA0KPiAgCXZhbCA9IGFwcGxfcmVhZGwocGNpZSwgQVBQTF9J
TlRSX0VOX0wxXzBfMCk7DQo+IEBAIC0xNzk2LDYgKzE4MDYsMTAgQEAgc3RhdGljIHZvaWQgcGV4
X2VwX2V2ZW50X3BleF9yc3RfZGVhc3NlcnQoc3RydWN0IHRlZ3JhX3BjaWVfZHcgKnBjaWUpDQo+
ICAJdmFsIHw9IEFQUExfSU5UUl9FTl9MMV8wXzBfUkRMSF9MSU5LX1VQX0lOVF9FTjsNCj4gIAlh
cHBsX3dyaXRlbChwY2llLCB2YWwsIEFQUExfSU5UUl9FTl9MMV8wXzApOw0KPiAgDQo+ICsJdmFs
ID0gYXBwbF9yZWFkbChwY2llLCBBUFBMX0lOVFJfRU5fTDFfOF8wKTsNCj4gKwl2YWwgfD0gQVBQ
TF9JTlRSX0VOX0wxXzhfRURNQV9JTlRfRU47DQo+ICsJYXBwbF93cml0ZWwocGNpZSwgdmFsLCBB
UFBMX0lOVFJfRU5fTDFfOF8wKTsNCj4gKw0KPiAgCS8qIDExMHVzIGZvciBib3RoIHNub29wIGFu
ZCBuby1zbm9vcCAqLw0KPiAgCXZhbCA9IDExMCB8ICgyIDw8IFBDSV9MVFJfU0NBTEVfU0hJRlQp
IHwgTFRSX01TR19SRVE7DQo+ICAJdmFsIHw9ICh2YWwgPDwgTFRSX01TVF9OT19TTk9PUF9TSElG
VCk7DQoNClJldmlld2VkLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo=
