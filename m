Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058425C6F9;
	Fri, 27 Feb 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195547; cv=fail; b=R5I4N8HVsYCVfDEyoHMbo2ItJ748DCQj/tc0R/ILvHjGyQ1b1Wv7/5DmFHc7J6oEYUudWWp/pmQvaZh1vG0qugjOOW4+Yyx0W/BX3r+kVigITDButMkYzkUGdYtTG8QMQVI4osZweheK0bfU5suspTe3RN2hUefUZGFkGh7kRMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195547; c=relaxed/simple;
	bh=muQ7Tzm6MZp9ls/qPUPDNU4zqI8CHW7pYXWFEPrPFRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jy9DQE3LNL0FRTg+J3CE4pflLrTyIX9idXzH6OGrL/Gz879/8NIsDfTgFQ2OXeNaOCDckY/1jseVXZf/bA5kjfwgE7lDvZMtbOaLUgiGLBzJPkanGPdRDqHcJjrzsO0twhXM64WsOrXuS+OgGUQRfpMdkCDF2OCSCwQ1L/wRg5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R7ypRdlF; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7ypRdlF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG7i7IWfdSQ4D8W6O8ndOVcy8ARiofHgV4fZ9eSvq3JmQqq/9INbf6yvp1LqC5RL/Bpgm13AK8R++hkccV6QaAFKW93plqBhLJBc3ikgsKuUXTWD/WI4ZgPQg1qRdUZSXbxzg8NsOqbADpYvmKzAhAOqhy+PLUxdOPXrcjYm3Dy4u1nFjCto/ORMZ6H+AQYtmyyu/z09NtsJE3nSDDz8jjhOSxNW3mO4c3SqcuvFHmXui+0TUyzzx+0ISAfaAELYzk6e5pX+EOpv+n3CoLoumxKX6qXDlI8BfEroqLbs+na2ehGNw/ftfzZ8IgIBrt6jM7ikyilL8CI5OplPs/SkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muQ7Tzm6MZp9ls/qPUPDNU4zqI8CHW7pYXWFEPrPFRA=;
 b=W5UHk/iCXgNdWx1MUeUZnvA/RIkSHlZqkiOrTpsJyx/UMmVrU6Y8YW9AbuYhNw5KWnm2TdIdiD9I65sHZXhdDqvl45Un+//n0OFHnahr8APVG6M9cuOGSjtfrwhn5VkoHQJGKKV1vO+REcq0dbqTDjFNR4M6Yfkt4YixfIOp2a83NQG6dD0ZhPZysOuX9G8dHtA4tKgt6WZBQpVdH/X0ZYpppWm0Q2eaV5xAaCRnuQ/q8a2QCsTF1fxht+CQWFxD93qxxLaKqb94Kz96TOr8yX2CZOQPM+XU5JJQe77ZhvmAMV3d0+bwjakH5edlcmlTlRtlyOeTu1+MSeJcYPpfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muQ7Tzm6MZp9ls/qPUPDNU4zqI8CHW7pYXWFEPrPFRA=;
 b=R7ypRdlF/zaPTRcnz+KpVOXJ5GjUBBFjPQJ5Se8EGEAVo345Bh/d5dFUi1MF2rrRXUCCMEKUcCUhM76Z2qmHIe7lDtXwi+YeEbLYnDifZ3QVkPuy3iO2/Lp/wlsDG4nlKknqWlhEKhfszwemmqRKNbvk86ApouJiIDRVDcPFGcsscOTl3paUfJS2PxIZ/zKS9l1tXu438lYMeWFCyNJBvt3zy8ViwNnJAfKDjpu7GqJo0XAzyNQT/o2Ed4R4/maJYlpWys2XXKsw4bWZAQ0ALk01Ygbxe+FF7dyaXbgA0otHkzFvRQfbhFxz/Ouhw7WhqidmViHHdpXNEvm0kbHudA==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 12:32:22 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:32:22 +0000
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
Subject: Re: [PATCH v6 01/13] PCI: tegra194: Fix polling delay for L2 state
Thread-Topic: [PATCH v6 01/13] PCI: tegra194: Fix polling delay for L2 state
Thread-Index: AQHcpPQ1kQZ8a1kZLE2ChraW7+wsf7WWgFOA
Date: Fri, 27 Feb 2026 12:32:22 +0000
Message-ID: <7fb57b68-1d71-426c-87d2-f9407153621b@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-2-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-2-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: 1ecd3e37-ba91-441e-9bca-08de75fc4172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 +jjst/gqRvYlYzQmxZLT8a8afz1ZEPiAUFKh71PoAzA4uCOe62fprj1MqZ5fnudwrXmxO5egOIfhsPQJUKMWgk+TBTQYCCUDUy0WX72MGCat85LISaKcN8dHRmn01KHryWOH50tN5P+K/9cVyDw3sGD0fVHti6Md2J/iemvTIY1u2zkUtEqEf6RzApP8+Hl1YIS7BQ8qfU3Z9m3Wq+uHWBBAnVEILR6WjAZQNUdw1ZI2rDrM4dGDvmG86y3b3ZZqdsACATeq/bNgbv6RHMJibf3YI9sbfLVhWj4aOwL31qF9DkjtserrrAAdDPbnquk73rnLI3tHQkiWkeCLy7oKwV+R2PGfCbyu7XqFObP4WpCPKBKGcShg7hjZea7Hc58UqB5O4ORkc0fzCGGNnk9ZTTlYw7u3MXLSngfir3fA0oshp2ItzVridm0OL4IeeCMZnXDk64Mxt0Ptwn/dGUVcpi6NHxSZGj2zD3i5oU0wbDiBI5cWUfuFSYeZAzz0uk2b9xUUA6D8z8ZgOWwEk3nXmd0+tHoFc9G6FdANHcyJWL3itb9WsLXB02x4jSLD9oJ7f642lwNx/L3z8I+eMz9joStNvWHk9Z9RB5jYnbH2m0Jl4VV0HhXIc+E9qUjTQYwUByrEAj289I38JcsC3vW74SkrTTP7KvrvwjvTnBkkJGW2QmNupDzG9myt7fz8SUdQVbE1A2BTz7QImS3MxH+lA/xCRQBaUxhyjOXm67oHRyy881OQVy7yYNKqH5+fXx+ZGiP4BILxKDRtu6K8lGQfUOmI/qdTAzin+DI3pXNWWsLlb1njG4MjFgxxESer3dgK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFV2ejlod09SUTYzTVJoTzFGUXZ3ZFVmeU53VGlDRkxJMVh3NGdNRE8vV3p6?=
 =?utf-8?B?bVYyRlFTZEtGMVhBNWluWlZFRkhiUzFYdjNNTDl6MXorRHAvZ1MxYnBsek5M?=
 =?utf-8?B?NnhaTi9wUjVWNWxTOXpCTktxanFGTUlnVTRhZi84M212K1dFQzdZd3gvYXQ5?=
 =?utf-8?B?WVdxZVVSWWpNbVp5TkVrb21HYkUwWCs4WkJjb0ptd1hjOUhSV1lKMFVXUGhk?=
 =?utf-8?B?Y1BVUHJuRC9zNkVGcGxlZmJZN0lURENOWXM0NFRNRG85eE5qK0RrSXBUQXF5?=
 =?utf-8?B?MlZoZnQ3Q1k5c25Kc1p0YkgvY3U3Z1ZkRWVVUlk3Rm01QkZ2M0FSamFIQmw0?=
 =?utf-8?B?SjN1QmJ3RW8zWFlpQUtlbHRTNHkycEIvMEdNN1Zab0lkM3BGSG85K2ZZb2F4?=
 =?utf-8?B?WlpLMkRHQ3phWndXUmplYnBNNCtBY05BL2poZVZYSkliOW5LUkVLWmxndnVF?=
 =?utf-8?B?ZHNDSCtlaVZmY1M4SUkrQkE4YURBeTljMm52S0FLMXRCaDhHY2lSODRLRE1m?=
 =?utf-8?B?OUVGY3FmVUNqRndvZkJmWlBYMEprcFBrL1FjYS9sUmZOa3NLOHZQcHh6UUxv?=
 =?utf-8?B?VkNwVXZic2Z0WkN3RlIwcEp5djlMOXZaN1VzZWJ4cEJCWmdLZkluMkJNWlRK?=
 =?utf-8?B?dFNseG1XbEE2UjVnbWtKV0RqSEtaakU4d2JPQm81S1liMzN4RVRveE90VDhk?=
 =?utf-8?B?eHFXa0c5VTZyU1FUekJOT01adFp2THhUMUR6MFZUWGRWaFR3Z3FXbjl2dGdQ?=
 =?utf-8?B?aHVnZ2dBWWtzMWNXMXM2UEFLck1vTEYxeHkrQkl5SW9rVVArU2c5aTN0c050?=
 =?utf-8?B?SHdoT0pENlZFWm9OMkVOMmNuQXkrRXJzVHU2cXBsY1RFRi9KYUlYaG1VQ21m?=
 =?utf-8?B?NlZ1aTEzb1VuSWNuc2N3ZW9FNS84M0hIdGRPTlhqN3cxak9rRmZoNjJXdFd1?=
 =?utf-8?B?QWdkV3UyOVY5aVFOTFEyalQwM29QT2R2aGVQakQ3aGZTUE1BTUc4VGUvWlpr?=
 =?utf-8?B?eWhNT3FVb2RtV080WmR6TU5sTTBCWlpOYmpLNEV1cjFqS04zcmpvVjRnaUUx?=
 =?utf-8?B?dE1RNTNMZFRuTkpDaUJyZzRKUU1zVmNoa3krcWtsMllxbVUyQUw3ZllWMkps?=
 =?utf-8?B?YnlPMkJMVDJXdjdhYkVObnR0N29VYkl1RmZRdGxTTXY0bTkxNHJWTURyODVH?=
 =?utf-8?B?QnA4UVd1aVRwTkNyU1lIb2h2ZzFVeDhUcm5OcUo3L2Z4WnhxL01qdWFtZ3pB?=
 =?utf-8?B?WEtFK1B5R01aYXpQMW1uZ2d5N09weHR4dDlpZU85WkRpQmx6d1MyR3pha1Z1?=
 =?utf-8?B?YWtZaWZSaEtMOC9VUkNJVHFXdGJGMVd3OEIyQ3Y5WnRyYitMaDU2RzNSUGdu?=
 =?utf-8?B?RGNRalNSVzFCU1Y4VXprVGNuc1B5d09NcUJnK2d1d3Z6ZGN5TGVWaFloSmVw?=
 =?utf-8?B?RTR2TU91SmpNeGV1RzJmaGR5K25Fd2xMU245YXgwU2t3VVhPUi9HSWc2Ymgz?=
 =?utf-8?B?Lyt3bzBWQzNSN2RLY29hM3Y2NGhnV3pqWjVkZHhUTkNOVmdKalhTUFpEemhr?=
 =?utf-8?B?anJxUnBRR2xNbjUxSjRiRDBmcmRsdCt5NnNsTGRwaWV5WEZ2OUI2d1R5bXFk?=
 =?utf-8?B?dzAydm1mT1JsbkN4cDZsMEV6OWQrc2VkZlpKMUZ1V1I5Z2lRY0l3Tk9Ta1Nt?=
 =?utf-8?B?YVFCbDZPd2d5YUxaV1Zwb2QwSXJ1UFlJZE5oSmZmT25mcENGd3EwLzF2NDBG?=
 =?utf-8?B?U3BIbUNnaEp4akxFQzRveEZFRWFiTUFaS3kwVWYyQWJIdjJLVzNoenpFR3d2?=
 =?utf-8?B?SklKUXlNby9GMUNOUmlUa2hSVUhPdno2NElIc2ZmQi95ZGdKakVrMnF0c3FF?=
 =?utf-8?B?WlVXayt0SDRkOFpYN1BwOXJMMXRjTkpQZG80cjFyNkF0THpWcERua0Y4NE9I?=
 =?utf-8?B?Vkp3OW96WHl2Slc2WVQ3K2VhNUw5bXVTbHprU2E0VmhwdEZlUnZ1a2F3aU5r?=
 =?utf-8?B?TW5iUWFoeXdkODhHVit5U240WFdUUnlZU0tLRW9HOEc1U3pWOEdES0RFVmZx?=
 =?utf-8?B?S3ZSNnAybkdKRmduRlhta1ppSDJGSDdaaWF0aXhuNnB3dkpERm1PVnUvN0pn?=
 =?utf-8?B?aDVLMFUyRzBhWjVTNm9LL0FJWWV5d24wMUNOaEtSczlZeGh3K3RDeW9EeEJi?=
 =?utf-8?B?UVJKRnErendJSHdPaHkzQVVnOEljcy9YWG9CVEw4Z0RKN2FhUmZvMUJCNk1s?=
 =?utf-8?B?TGh2dlpGK0M0M1VlRlc5TGl0dFdvT1dvN2lNNzhkN2VRNVVwZDdUNE11Zzcy?=
 =?utf-8?B?MWxTT2xZaG5ETHFSZzlaeFpDT2tzLytCN3pqdlZIUGR0c2t6eHlWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40DCF59636ACEA499836C3E5C765E685@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecd3e37-ba91-441e-9bca-08de75fc4172
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:32:22.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /X4HqwHspVGca/ShKDx75fjndwjnQxS8awE/Sm9zYiZ/RXkscdzNk1elUPlXZ5uK5nLvleCGyrBG6igS08TO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBBcyBwZXIgUENJZSBzcGVjIHI2
LjAsIHNlYyA1LjMuMy4yLjEsIGFmdGVyIHNlbmRpbmcgUE1FX1R1cm5fT2ZmIG1lc3NhZ2UsDQo+
IFJvb3QgcG9ydCBzaG91bGQgd2FpdCBmb3IgMX4xMCBtc2VjIGZvciBQTUVfVE9fQWNrIG1lc3Nh
Z2UuIEN1cnJlbnRseSwNCj4gZHJpdmVyIGlzIHBvbGxpbmcgZm9yIDEwIG1zZWMgd2l0aCAxIHVz
ZWMgZGVsYXkgd2hpY2ggaXMgYWdncmVzc2l2ZS4NCj4gQ2hhbmdlIGl0IHRvIDEwIG1zZWMgcG9s
bGluZyB3aXRoIDEwMCB1c2VjIGRlbGF5LiBTaW5jZSB0aGlzIGZ1bmN0aW9uDQo+IGlzIHVzZWQg
aW4gbm9uLWF0b21pYyBjb250ZXh0IG9ubHksIHVzZSBub24tYXRvbWljIHBvbGwgZnVuY3Rpb24u
DQo+IA0KPiBGaXhlczogNTZlMTVhMjM4ZDkyICgiUENJOiB0ZWdyYTogQWRkIFRlZ3JhMTk0IFBD
SWUgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlh
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRpcmVkZHkgPG1tYWRkaXJlZGR5
QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2OiBOb25lDQo+IA0KPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIHwgOSArKysrKy0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IGluZGV4IDBkZGVl
ZjcwNzI2ZC4uOTZkMzg1NzFhN2U3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS10ZWdyYTE5NC5jDQo+IEBAIC0xOTgsNyArMTk4LDggQEANCj4gICNkZWZpbmUgQ0FQ
X1NQQ0lFX0NBUF9PRkZfVVNQX1RYX1BSRVNFVDBfTUFTSwlHRU5NQVNLKDExLCA4KQ0KPiAgI2Rl
ZmluZSBDQVBfU1BDSUVfQ0FQX09GRl9VU1BfVFhfUFJFU0VUMF9TSElGVAk4DQo+ICANCj4gLSNk
ZWZpbmUgUE1FX0FDS19USU1FT1VUIDEwMDAwDQo+ICsjZGVmaW5lIFBNRV9BQ0tfREVMQVkJCTEw
MCAgIC8qIDEwMCB1cyAqLw0KPiArI2RlZmluZSBQTUVfQUNLX1RJTUVPVVQJCTEwMDAwIC8qIDEw
IG1zICovDQo+ICANCj4gICNkZWZpbmUgTFRTU01fVElNRU9VVCA1MDAwMAkvKiA1MG1zICovDQo+
ICANCj4gQEAgLTE1NTMsOSArMTU1NCw5IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV90cnlfbGlu
a19sMihzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSkNCj4gIAl2YWwgfD0gQVBQTF9QTV9YTVRf
VFVSTk9GRl9TVEFURTsNCj4gIAlhcHBsX3dyaXRlbChwY2llLCB2YWwsIEFQUExfUkFETV9TVEFU
VVMpOw0KPiAgDQo+IC0JcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocGNpZS0+YXBw
bF9iYXNlICsgQVBQTF9ERUJVRywgdmFsLA0KPiAtCQkJCSB2YWwgJiBBUFBMX0RFQlVHX1BNX0xJ
TktTVF9JTl9MMl9MQVQsDQo+IC0JCQkJIDEsIFBNRV9BQ0tfVElNRU9VVCk7DQo+ICsJcmV0dXJu
IHJlYWRsX3BvbGxfdGltZW91dChwY2llLT5hcHBsX2Jhc2UgKyBBUFBMX0RFQlVHLCB2YWwsDQo+
ICsJCQkJICB2YWwgJiBBUFBMX0RFQlVHX1BNX0xJTktTVF9JTl9MMl9MQVQsDQo+ICsJCQkJICBQ
TUVfQUNLX0RFTEFZLCBQTUVfQUNLX1RJTUVPVVQpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9p
ZCB0ZWdyYV9wY2llX2R3X3BtZV90dXJub2ZmKHN0cnVjdCB0ZWdyYV9wY2llX2R3ICpwY2llKQ0K
DQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0K
